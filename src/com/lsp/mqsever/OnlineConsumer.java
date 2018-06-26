package com.lsp.mqsever;   
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.TextMessage;  

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import com.lsp.android.entity.Reply;
import com.lsp.android.entity.ReplyUnFind;
import com.lsp.pub.db.MongoDbUtil; 
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;  
import com.lsp.pub.util.UniObject;
import com.lsp.suc.entity.DatingServiceTrumpet;
import com.lsp.websocket.ChatServer;
import com.lsp.websocket.service.WebsoketListen;
import com.lsp.weixin.entity.WxUser;
import com.mongodb.DBObject;
import com.mongodb.util.JSON; 

import net.sf.json.JSONObject;
 
/**
 * 在线状态更新
 * @author lsp 
 *   
 */
@Component
public class OnlineConsumer implements MessageListener {

	@Override
	public void onMessage(Message message) {
		// TODO Auto-generated method stub
		MongoDbUtil mongoDbUtil=new MongoDbUtil(); 
		MongoSequence mongoSequence=new MongoSequence();  
		TextMessage txtMsg = ((TextMessage) message);// 任务id  
		try { 
			JSONObject obj =JSONObject.fromObject(txtMsg.getText());   
			String type=obj.getString("type");  
			String id=obj.getString("id");   
			if(Integer.parseInt(type)==1){ 
				DBObject dbObject=mongoDbUtil.findOneById(PubConstants.DATA_WXUSER, id);
				if(dbObject!=null){
					WxUser user=(WxUser) UniObject.DBObjectToObject(dbObject, WxUser.class);
					user.setOnline(1); 
					mongoDbUtil.insertUpdate(PubConstants.DATA_WXUSER, user);
				}
			}else if(Integer.parseInt(type)==0){ 
				DBObject dbObject=mongoDbUtil.findOneById(PubConstants.DATA_WXUSER, id);
				if(dbObject!=null){
					WxUser user=(WxUser) UniObject.DBObjectToObject(dbObject, WxUser.class);
					user.setOnline(0); 
					mongoDbUtil.insertUpdate(PubConstants.DATA_WXUSER, user);
				}
			}else if (Integer.parseInt(type)==2) {
				//系统发送消息到指定用户
				String msg=obj.getString("msg");   
				for (String string :id.split(",")) { 
					if(WebsoketListen.SessionidMap.get(string)!=null){
						JSONObject  jsonObject=new JSONObject();
						jsonObject.put("admin","admin");
						jsonObject.put("message",msg); 
						ChatServer.sendMessages(WebsoketListen.SessionMap.get(WebsoketListen.SessionidMap.get(string)),jsonObject.toString());
						 
					} 
				} 
			}else if (Integer.parseInt(type)==3) {
				//系统发送消息到指定用户 
				JSONObject msg=JSONObject.fromObject(obj.get("msg"));  
				//保存消息
				String rid=null;
			    String content=null;
			    String custid=null;
			    String fromUserid=null;
			    String title=null;
			    String picurl=null;
			    String url=null;
			    String toUserid=null;
				if (msg.get("rid")!=null) {
					rid=msg.getString("rid"); 
				}
				if (msg.get("content")!=null) {
					content=msg.getString("content"); 
				}
				if (msg.get("custid")!=null) {
					custid=msg.getString("custid"); 
				}
				if (msg.get("fromUserid")!=null) {
					fromUserid=msg.getString("fromUserid"); 
				}
				if (msg.get("title")!=null) {
					title=msg.getString("title"); 
				}
				if (msg.get("picurl")!=null) {
					picurl=msg.getString("picurl"); 
				}
				if (msg.get("url")!=null) {
					url=msg.getString("url"); 
				}
				if (msg.get("toUserid")!=null) {
					toUserid=msg.getString("toUserid"); 
				}
				 
				HashMap<String, Object>whereMap=new HashMap<>();
				whereMap.put("no", fromUserid); 
				DBObject dbObject =mongoDbUtil.findOne(PubConstants.DATA_WXUSER, whereMap);
				if(dbObject!=null){ 
					com.lsp.android.entity.Message mess=new com.lsp.android.entity.Message();
					mess.set_id(mongoSequence.currval(PubConstants.ANDROID_MESSAGE));
					mess.setContent(content);
					mess.setCreatedate(new Date());
					mess.setCustid(custid);
					mess.setFromUserid(dbObject.get("_id").toString());
					mess.setPicurl(picurl);
					mess.setRid(rid);
					mess.setTitle(title);
					mess.setToUserid(toUserid);
					mess.setUrl(url);
					mongoDbUtil.insertUpdate(PubConstants.ANDROID_MESSAGE, mess);
				}  
				//更新会话 
				DBObject  db=mongoDbUtil.findOneById(PubConstants.ANDROID_REPLY, Long.parseLong(rid));
				 
				if(db!=null){
					
					Reply  re=(Reply) UniObject.DBObjectToObject(db, Reply.class);
					re.setEndmsg(content);
					re.setEndupdate(new Date());
					mongoDbUtil.insertUpdate(PubConstants.ANDROID_REPLY, re);
				} 
				
				for (String string :id.split(",")) {
					if (StringUtils.isNotEmpty(string)) { 
						HashMap<String, Object>whereMap1=new HashMap<>();
						whereMap1.put("no", string);
						DBObject dbObject1 =mongoDbUtil.findOne(PubConstants.DATA_WXUSER, whereMap1);
						String toId=dbObject1.get("_id").toString(); 
						//验证客服  
						DBObject  kf= mongoDbUtil.findOneById(PubConstants.SUC_DATINGSERVICETRUMPET, toId);
						if(kf!=null){  
							DatingServiceTrumpet  service=(DatingServiceTrumpet) UniObject.DBObjectToObject(kf, DatingServiceTrumpet.class);
							service.setEndupdate(new Date());
							mongoDbUtil.insertUpdate(PubConstants.SUC_DATINGSERVICETRUMPET, service);
							if(WebsoketListen.SessionidMap.get(service.getParent())!=null){ 
								JSONObject  jsonObject=new JSONObject(); 
								Iterator it = msg.keys();
					 	        while (it.hasNext()) { 
					                 String key = (String) it.next();
					                 if(!key.equals("type")){
					                	 jsonObject.put(key,msg.get(key)); 
					                 } 
					             }  
								ChatServer.sendMessages(WebsoketListen.SessionMap.get(WebsoketListen.SessionidMap.get(service.getParent())),jsonObject.toString());
								 
							}else{
								//添加到未读信息
								DBObject db1=mongoDbUtil.findOneById(PubConstants.ANDROID_REPLYUNFIND,rid+"-"+toId);
								ReplyUnFind rep=null;
								if(db1!=null){
									rep=(ReplyUnFind) UniObject.DBObjectToObject(db1, ReplyUnFind.class);
								    rep.setCount(rep.getCount()+1);
								    rep.setFromUserid(toId);
								    rep.setWid(Long.parseLong(rid)); 
								}else{
									rep=new ReplyUnFind();
									rep.set_id(rid+"-"+toId);
									rep.setCount(1);
									rep.setFromUserid(toId);
									rep.setWid(Long.parseLong(rid)); 	
								} 
								mongoDbUtil.insertUpdate(PubConstants.ANDROID_REPLYUNFIND, rep); 
							}
							 
						}else{ 
							if (dbObject1!=null) {  
								if(WebsoketListen.SessionidMap.get(toId)!=null){ 
									JSONObject  jsonObject=new JSONObject(); 
									Iterator it = msg.keys();
						 	        while (it.hasNext()) { 
						                 String key = (String) it.next();
						                 if(!key.equals("type")){
						                	 jsonObject.put(key,msg.get(key)); 
						                 } 
						             }  
									ChatServer.sendMessages(WebsoketListen.SessionMap.get(WebsoketListen.SessionidMap.get(toId)),jsonObject.toString());
									 
								}else{
									//添加到未读信息
									DBObject db1=mongoDbUtil.findOneById(PubConstants.ANDROID_REPLYUNFIND,rid+"-"+toId);
									ReplyUnFind rep=null;
									if(db1!=null){
										rep=(ReplyUnFind) UniObject.DBObjectToObject(db1, ReplyUnFind.class);
									    rep.setCount(rep.getCount()+1);
									    rep.setFromUserid(toId);
									    rep.setWid(Long.parseLong(rid)); 
									}else{
										rep=new ReplyUnFind();
										rep.set_id(rid+"-"+toId);
										rep.setCount(1);
										rep.setFromUserid(toId);
										rep.setWid(Long.parseLong(rid)); 	
									} 
									mongoDbUtil.insertUpdate(PubConstants.ANDROID_REPLYUNFIND, rep); 
								} 
								 	
								
							}
						} 
					
					}
					
				} 
				
				
			}else if (Integer.parseInt(type)==4) {
				//添加未读消息
				String rid=obj.getString("rid");   
				DBObject db=mongoDbUtil.findOneById(PubConstants.ANDROID_REPLYUNFIND, rid+"-"+id);
				ReplyUnFind rep=null;
				if(db!=null){
					rep=(ReplyUnFind) UniObject.DBObjectToObject(db, ReplyUnFind.class);
				    rep.setCount(rep.getCount()+1);
				    rep.setFromUserid(id);
					rep.setWid(Long.parseLong(rid)); 
				}else{
					rep=new ReplyUnFind();
					rep.set_id(rid+"-"+id);
					rep.setCount(1);
					rep.setFromUserid(id);
					rep.setWid(Long.parseLong(rid)); 	
				} 
				mongoDbUtil.insertUpdate(PubConstants.ANDROID_REPLYUNFIND, rep);
			} 
		 
		} catch (JMSException e) {
			// TODO Auto-generated catch block 
			e.printStackTrace();
		} 
		mongoDbUtil.close();
	}
	
	
}
