package com.lsp.mqsever;  
import java.util.Date;
import java.util.HashMap;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.TextMessage;  

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject; 
import com.lsp.android.entity.Reply;
import com.lsp.android.entity.ReplyUnFind;
import com.lsp.pub.db.MongoDbUtil; 
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;  
import com.lsp.pub.util.JmsService;
import com.lsp.pub.util.UniObject; 
import com.lsp.suc.entity.DatingServiceTrumpet;
import com.mongodb.DBObject;  
import com.sun.swing.internal.plaf.basic.resources.basic;
 
/**
 * 聊天信息队列
 * @author lsp 
 *   
 */
@Component
public class RepmessageConsumer implements MessageListener {

	@Override
	public void onMessage(Message message) {
		// TODO Auto-generated method stub
		MongoDbUtil mongoDbUtil=new MongoDbUtil(); 
		MongoSequence mongoSequence=new MongoSequence(); 
		TextMessage txtMsg = ((TextMessage) message);// 任务id 
		try {
			JSONObject obj = (JSONObject) JSON.parse(txtMsg.getText().toString());
			String type=obj.getString("type"); 
			if(Integer.parseInt(type)==1){
				String rid=obj.getString("rid");
				String fromUserid=obj.getString("fromUserid");
				 
				DBObject db=mongoDbUtil.findOneById(PubConstants.ANDROID_REPLYUNFIND, rid+"-"+fromUserid);
				ReplyUnFind rep=null;
				if(db!=null){
					rep=(ReplyUnFind) UniObject.DBObjectToObject(db, ReplyUnFind.class);
				    rep.setCount(rep.getCount()+1);
				}else{
					rep=new ReplyUnFind();
					rep.set_id(rid+"-"+fromUserid);
					rep.setCount(1);
					rep.setFromUserid(fromUserid);
					rep.setWid(Long.parseLong(rid)); 	
				} 
				mongoDbUtil.insertUpdate(PubConstants.ANDROID_REPLYUNFIND, rep); 
			}else if(Integer.parseInt(type)==2){ 
				String rid=obj.getString("rid");
				String msg=obj.getString("msg"); 
				DBObject  db=mongoDbUtil.findOneById(PubConstants.ANDROID_REPLY, Long.parseLong(rid));
				 
				if(db!=null){
					
					Reply  re=(Reply) UniObject.DBObjectToObject(db, Reply.class);
					re.setEndmsg(msg);
					re.setEndupdate(new Date());
					mongoDbUtil.insertUpdate(PubConstants.ANDROID_REPLY, re);
				}
				
			}else if(Integer.parseInt(type)==3){
				String rid=obj.getString("rid");
				String content=obj.getString("content"); 
				String msg=obj.getString("msg"); 
				String custid=obj.getString("custid"); 
				String fromUserid=obj.getString("fromUserid"); 
				String title=obj.getString("title"); 
				String picurl=obj.getString("picurl"); 
				String toUserid=obj.getString("toUserid"); 
				String url=obj.getString("url"); 
				com.lsp.android.entity.Message mess=new com.lsp.android.entity.Message();
				mess.set_id(mongoSequence.currval(PubConstants.ANDROID_MESSAGE));
				mess.setContent(content);
				mess.setCreatedate(new Date());
				mess.setCustid(custid);
				mess.setFromUserid(fromUserid);
				mess.setPicurl(picurl);
				mess.setRid(rid);
				mess.setTitle(title);
				mess.setToUserid(toUserid);
				mess.setUrl(url);
				mongoDbUtil.insertUpdate(PubConstants.ANDROID_MESSAGE, mess);
				
				for (String string : toUserid.split(",")) {
						if(StringUtils.isNotEmpty(string)){ 
							 DBObject  kf= mongoDbUtil.findOneById(PubConstants.SUC_DATINGSERVICETRUMPET, string);
							 if(kf!=null){ 
								 DatingServiceTrumpet  service=(DatingServiceTrumpet) UniObject.DBObjectToObject(kf, DatingServiceTrumpet.class);
								 service.setEndupdate(new Date());
								 mongoDbUtil.insertUpdate(PubConstants.SUC_DATINGSERVICETRUMPET, service);
							 }
						}
				 }
			}
		
			
		} catch (JMSException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		mongoDbUtil.close();
	}
	
}
