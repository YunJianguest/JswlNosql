package com.lsp.mqsever; 

import java.util.Date;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.TextMessage;
 
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.lsp.android.entity.MessageInfo;
import com.lsp.pub.db.MongoDbUtil;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants; 
import com.lsp.pub.util.NotificationUtil;
import com.lsp.pub.util.UniObject;
import com.mongodb.DBObject;
 
/**
 * 系统提醒队列
 * @author lsp 
 *   
 */
@Component
public class PermessageConsumer implements MessageListener {

	@Override
	public void onMessage(Message message) {
		// TODO Auto-generated method stub
		MongoDbUtil mongoDbUtil=new MongoDbUtil();
		MongoSequence mongoSequence=new MongoSequence();
		TextMessage txtMsg = ((TextMessage) message);// 任务id 
		try {
			JSONObject obj = (JSONObject) JSON.parse(txtMsg.getText().toString());
			String custid=obj.getString("custid");
			String fromUserid=obj.getString("fromUserid");
			String title=obj.getString("title");
			String summary=obj.getString("summary");
			String picurl=obj.getString("picurl");
			String url=obj.getString("url");
			String type=obj.getString("type");
			String lx=obj.getString("lx");
			String id=obj.getString("id");
			
			String comname=obj.getString("comname");
			String orderid=obj.getString("orderid");
			String protitle=obj.getString("protitle");
			String procount=obj.getString("procount");
			String prostate=obj.getString("prostate");
			if(StringUtils.isNotEmpty(id)){
				DBObject  db=mongoDbUtil.findOneById(PubConstants.ANDROID_MESSAGEINFO, Long.parseLong(id));
				if(db!=null){
					MessageInfo me=(MessageInfo) UniObject.DBObjectToObject(db, MessageInfo.class);
					if(StringUtils.isNotEmpty(type)){
						me.setType(Integer.parseInt(type)); 
					}
					me.setFromUserid(fromUserid);
					NotificationUtil.sendMessage(me); 
				} 
			}else{
				MessageInfo me=new MessageInfo();
				me.set_id(mongoSequence.currval(PubConstants.ANDROID_MESSAGEINFO));
				me.setCreatedate(new Date());
				me.setCustid(custid);
				me.setFromUserid(fromUserid);
				me.setPicurl(picurl);
				me.setUrl(url);
				me.setTitle(title);
				me.setSummary(summary);
				me.setLx(lx);
				me.setComname(comname);
				me.setOrderid(orderid);
				me.setProstate(prostate);
				me.setProtitle(protitle);
				me.setProcount(procount);
				if(StringUtils.isNotEmpty(type)){
					me.setType(Integer.parseInt(type));
				}
				mongoDbUtil.insertUpdate(PubConstants.ANDROID_MESSAGEINFO, me); 
				NotificationUtil.sendMessage(me); 
			} 
			
		} catch (JMSException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		mongoDbUtil.close();
	}
	
}
