package com.lsp.mqsever;
 
import java.io.File;
import java.io.FileInputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.TextMessage;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.net.ftp.FTPClient;
import org.springframework.stereotype.Component;
 
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject; 
import com.lsp.pub.db.MongoDbUtil;
import com.lsp.pub.entity.GetAllFunc; 
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.entity.WxToken;
import com.lsp.pub.upload.FtpUtils;
import com.lsp.pub.upload.JsonUtil; 
import com.lsp.pub.util.DownloadImage;
import com.lsp.pub.util.EncodeUtils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.shop.entiy.ComMain;
import com.lsp.website.service.WwzService; 
import com.lsp.weixin.entity.WxUser;
import com.lsp.weixin.util.JuheUtil;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
/**
 * 微信提醒队列
 * @author lsp 
 *   
 */
@Component
public class ZdymessageConsumer implements MessageListener {
	
	public void onMessage(Message message) {
		MongoDbUtil mongoDbUtil=new MongoDbUtil();
		WwzService  wwzService=new WwzService();
		TextMessage txtMsg = ((TextMessage) message);// 任务id
		
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		try {

			JSONObject obj = (JSONObject) JSON.parse(txtMsg.getText().toString());
			String toUser=obj.getString("toUser");
			String fromUser=obj.getString("fromUser");
			String type=obj.getString("type");
			
			int size=obj.getIntValue("size");
			WxToken token=WeiXinUtil.getTokenByToUser(toUser);
			
			if(token==null){
				 token=new WxToken();
			}

			DBObject fromUserdb = mongoDbUtil.findOneById(PubConstants.DATA_WXUSER,fromUser);
			WxUser user =new WxUser ();
			if(fromUserdb!=null){
				user = (WxUser)UniObject.DBObjectToObject(fromUserdb,WxUser.class);	
			}
			
			whereMap.put("wid", toUser+"-"+type);
			sortMap.put("sort", 1);
			if(type==null){//违章推送
				return;
			}
			List<DBObject> zdyList=mongoDbUtil.queryAll(PubConstants.PUB_ZDYMESSAGE,whereMap,sortMap).toArray();
			
			if(type.equals("112")){
				 

			}else if(type.equals("zdy")){
				if(zdyList.size()>0){
					DBObject zdy=zdyList.get(0);
					if(zdy.get("lx").toString().equals("0")){
						if(zdyList.size()==1){
							WeiXinUtil.sendNews(token.getAccess_token(), fromUser, zdy, user);
						}else{
							WeiXinUtil.sendNews(token.getAccess_token(), fromUser, zdyList, user);
						}
						
					}else if(zdy.get("lx").toString().equals("1")){
						WeiXinUtil.sendKfText(token.getAccess_token(), fromUser, zdy.get("summary").toString(), user);
					}else if(zdy.get("lx").toString().equals("2")){
						
						
					}
				}
			}else if(type.equals("getMobile")){//更新电话省市
				JSONObject js=JuheUtil.getMobile(user.getTel());
				user.set_id(fromUser);
				if(js.getString("province")!=null){
					user.setProvince(js.getString("province"));
					user.setCity(js.getString("city"));
					mongoDbUtil.insertUpdate(PubConstants.DATA_WXUSER, user);
				}else{
					
				}
			
		
			}else if(type.equals("getuser")){//获取用户信息
				if(StringUtils.isEmpty(fromUser)){
					return;
				} 
				JSONObject map=WeiXinUtil.getUserInfo(token.getAccess_token(),fromUser);
				if (map== null) {//错误时微信会返回错误码等信息，JSON数据包示例如下（该示例为AppID无效错误）: 
					return ;
				}
				if (map.get("errcode") != null) {//错误时微信会返回错误码等信息，JSON数据包示例如下（该示例为AppID无效错误）: 
					
					return ;
				}
				if (map.get("subscribe").equals("0")){
					
					
					return ;
				} 
				user.set_id(UUID.randomUUID().toString());
                user.setFromUser(fromUser);
				user.setToUser(toUser);
				if (StringUtils.isEmpty(user.getProvince())) {
						user.setCity(map.getString("city"));
						
						user.setCountry(map.getString("country"));
						user.setProvince(map.getString("province"));
						user.setSex(map.getString("sex"));
				}

				if(map.get("headimgurl")==null||map.get("headimgurl").toString().length()<5){
						
				}else{
					user.setHeadimgurl(map.getString("headimgurl"));
					if(StringUtils.isNotEmpty(user.getHeadimgurl())){
						String path="logo_"+user.getFromUser()+".jpg";
						String savePath=SysConfig.getProperty("imgpath")+"/"+path;
						
						DownloadImage.download(user.getHeadimgurl(), savePath);
						File file=new File(savePath);
						
						if(SysConfig.getProperty("isossup").equals("1")){
							 
						}else if(SysConfig.getProperty("isossup").equals("2")){
							FileInputStream localObject1 = new FileInputStream(file);
							
							FTPClient ftp=FtpUtils.getFtpClient(SysConfig.getProperty("ftp"), SysConfig.getProperty("ftpname"), SysConfig.getProperty("ftppwd"),Integer.parseInt(SysConfig.getProperty("ftpport")));
							FtpUtils.uploadImageToFTP(localObject1, ftp, "/"+path);
							FtpUtils.closeFtp(ftp);
							user.setHeadimgurl(SysConfig.getProperty("osshttp")+path);
						}else if(SysConfig.getProperty("isossup").endsWith("3")){
							//跨域
							//添加文件到缓存 
							FileInputStream localObject1 = new FileInputStream(file);
							
							JsonUtil.Add(new String[]{"file","FileName","ContentType"},new Object[]{EncodeUtils.base64Encode(JsonUtil.readBytes(localObject1)),path,"img"});
						 	//返回保存的路径
							JsonUtil.UploadFile();
							
							user.setHeadimgurl(SysConfig.getProperty("osshttp")+path);
						}else{
							
							user.setHeadimgurl(path);
						}
					}
				}
					
				user.setLanguage(map.getString("language"));
				user.setCreatedate(new Date());
				user.setNickname(map.getString("nickname"));
				mongoDbUtil.insertUpdate(PubConstants.DATA_WXUSER, user);
				return ;
	
			}else if(type.equals("tbuser")){//获取用户信息
				user.set_id(fromUser);
				if(StringUtils.isEmpty(user.getHeadimgurl())){
					DBObject comUserdb = mongoDbUtil.findOneById(PubConstants.DATA_WXUSER,toUser);
					WxUser user1 =new WxUser ();
					if(comUserdb!=null){
						user1 = (WxUser)UniObject.DBObjectToObject(comUserdb,WxUser.class);	
					}
					user.setFromUser(fromUser);
					user.setCity(user1.getCity());
					
					user.setHeadimgurl(user1.getHeadimgurl());
					user.setProvince(user1.getProvince());
					user.setSex(user1.getSex());
					user.setNickname(user1.getNickname());
					mongoDbUtil.insertUpdate(PubConstants.DATA_WXUSER, user);
				}

			}else if(type.equals("sendsms")){//通知通告
				//String[] nr=obj.getString("nr").split("&");
				//CloopenService.sendsms(obj.getString("tel"),obj.getString("mbid"),nr);
			}else if(type.equals("subscribe")){//通知通告
				return;
			}else{//所以其他的推送，优先模板推送，然后图文 
				if(zdyList.size()==0){//未配置
					DBObject wxMessage=new BasicDBObject();
					if(obj.get("first")==null){
						wxMessage.put("title","通知通告");
					}else{
						wxMessage.put("title",obj.getString("first").toString());
					}
					if(obj.get("url")==null){
						
					}else{
						wxMessage.put("url", "");
					}
					
					wxMessage.put("picurl", "");
					StringBuffer summary=new StringBuffer();
					if(obj.get("remark")!=null){
						summary.append(obj.getString("remark")).append(";\n");
					}
					
					for(int k=0;k<size;k++){
						summary.append(obj.getString("keyword"+k)).append(";\n");
						
					}
					wxMessage.put("summary", summary.toString());
					ComMain commain=GetAllFunc.comToUser.get(toUser);
					if(commain==null){//主账号
						WeiXinUtil.sendNews(token.getAccess_token(),fromUser,wxMessage);
					}else{
						whereMap.clear();
						whereMap.put("comUser", fromUser);
						whereMap.put("toUser", toUser);
						DBObject tsUserdb=mongoDbUtil.findOne(PubConstants.DATA_WXUSER, whereMap);
						if(tsUserdb!=null){
							WxToken token1=WeiXinUtil.getTokenByToUser(toUser);
							wxMessage.put("url", wxMessage.get("url").toString().replaceAll("fromUserData", fromUser));
							WeiXinUtil.sendNews(token1.getAccess_token(),tsUserdb.get("_id").toString(),wxMessage);
						}
					}
					
					
				}else {//已配置
					if(user.getComUser()!=null&&obj.get("url")!=null){
						obj.put("url", obj.getString("url").replaceAll("fromUserData", user.getComUser()));
					}
					DBObject zdy=zdyList.get(0);
					String[] keyword=zdy.get("keyword").toString().split(",");
					if(zdy.get("lx")==null||zdy.get("lx").toString().equals("0")){//图文
						WeiXinUtil.sendNews(token.getAccess_token(),fromUser,zdyList,user);
					}else if(zdy.get("lx").toString().equals("1")){//文字推送
						WeiXinUtil.sendKfText(token.getAccess_token(),fromUser,zdy.get("summary").toString());
					}else if(zdy.get("lx").toString().equals("3")){//模板推送
						if(zdy.get("mb")==null||StringUtils.isEmpty(zdy.get("mb").toString())||token.getZhlx()!=2){//图文
							DBObject wxMessage=new BasicDBObject();
							if(obj.get("first")==null){
								wxMessage.put("title","");
							}else{
								wxMessage.put("title",obj.getString("first").toString());
							}
						
							wxMessage.put("url", obj.getString("url"));
							wxMessage.put("picurl", "");
							StringBuffer summary=new StringBuffer();
							summary.append(obj.getString("remark")).append(";\n");
							for(int k=0;k<size;k++){
								summary.append(obj.getString("keyword"+k)).append(";\n");
							
							}
							wxMessage.put("summary", summary.toString());
							WeiXinUtil.sendNews(token.getAccess_token(),fromUser,wxMessage);
						}else{//模板
						
							HashMap<String, String> data = new HashMap<String, String>();
							if(obj.get("first")==null){
								obj.put("first", "通知通告");
							}
							if(obj.get("remark")==null||StringUtils.isEmpty(obj.get("remark").toString())){
								if(zdy.get("summary")==null||StringUtils.isEmpty(zdy.get("summary").toString())){
									obj.put("remark", "");
								}else{
									obj.put("remark", zdy.get("summary").toString());
								}
								
							}
							if(user==null||user.getNo()==null){
								data.put("first", obj.getString("first"));
								
								for(int k=0;k<keyword.length;k++){
									if(obj.get("keyword"+k)==null){
										obj.put("keyword"+k, "");
									}
									data.put(keyword[k], obj.getString("keyword"+k));

								}
								data.put("remark", obj.getString("remark"));
							}else{
								data.put("first", obj.getString("first").replace("NO", user.getNo()));
								for(int k=0;k<keyword.length;k++){
									if(obj.get("keyword"+k)==null){
										obj.put("keyword"+k, "");
									}
									data.put(keyword[k], obj.getString("keyword"+k).replace("NO", user.getNo()));
								}
								data.put("remark", obj.getString("remark").replace("NO", user.getNo()));
							}
						
							
						
							WeiXinUtil.SendTemplate(toUser, fromUser,zdy.get("mb").toString(), obj.getString("url"), data);
						}
					}
				}
				
			}
			
	
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
		mongoDbUtil.close();
		
	}
	private String getOsshttp(){
		String osshttp="";
		if(SysConfig.getProperty("isossup").endsWith("0")){
			osshttp=SysConfig.getProperty("ip");
		}else{
			osshttp=SysConfig.getProperty("filehttp");
		}
		return osshttp;
	}
	
}
