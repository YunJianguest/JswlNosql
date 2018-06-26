package com.lsp.mqsever;  
import java.util.Calendar;
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
import com.lsp.pub.db.MongoDbUtil; 
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;  
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.DateUtil;
import com.lsp.pub.util.UniObject; 
import com.lsp.suc.entity.DatingInfo;
import com.lsp.suc.entity.DatingMember;
import com.lsp.suc.entity.DatingReward;
import com.lsp.suc.entity.DatingStatistical;
import com.lsp.website.service.WwzService;
import com.mongodb.DBObject;  
import com.sun.swing.internal.plaf.basic.resources.basic;
 
/**
 * 验证奖励
 * @author lsp 
 *   
 */
@Component
public class CheckrewardConsumer implements MessageListener {

	@Override
	public void onMessage(Message message) {
		// TODO Auto-generated method stub
		MongoDbUtil mongoDbUtil=new MongoDbUtil(); 
		MongoSequence mongoSequence=new MongoSequence(); 
		WwzService  wwzService=new WwzService();
		TextMessage txtMsg = ((TextMessage) message);// 任务id  
		try {
			JSONObject obj = (JSONObject) JSON.parse(txtMsg.getText().toString());
			String type=obj.getString("type"); 
			String custid=obj.getString("custid"); 
			if(Integer.parseInt(type)==1){
				String id=obj.getString("id"); 
				HashMap<String,Object>whereMap=new HashMap<>();
				whereMap.put("fromUserid", id);
				whereMap.put("type",0);
				DBObject  db=mongoDbUtil.findOne(PubConstants.SUC_DATINGREWARD, whereMap);
				 
				if(db!=null){ 
					String time=db.get("createdate").toString();
					//验证时间
					if(!DateUtil.checkbig(DateUtil.addDay(DateFormat.getFormat(time),3))){
						 
						//奖励发放 
						  DatingMember member=new DatingMember(); 
						  member.set_id(mongoSequence.currval(PubConstants.SUC_DATINGMEMEBER)); 
						  member.setCreatedate(new Date()); 
						  member.setCustid(custid); 
						  member.setFromUserid(id); 
						  member.setMoney(0); 
						  Calendar cal = Calendar.getInstance(); 
						  cal.add(Calendar.HOUR,6);  
						  member.setStartdate(new Date());
						  member.setEnddate(cal.getTime());
						  mongoDbUtil.insertUpdate(PubConstants.SUC_DATINGMEMEBER, member); 
						  DBObject  dat=mongoDbUtil.findOneById(PubConstants.SUC_DATING, id); 
						  if(dat!=null){ 
							  DatingInfo info=(DatingInfo) UniObject.DBObjectToObject(dat, DatingInfo.class);
							  if(info.getEndMemberDate()!=null){
								  cal.setTime(info.getEndMemberDate());
								  cal.add(Calendar.HOUR,6); 
								  info.setEndMemberDate(cal.getTime());  
							  }else{
								  info.setEndMemberDate(cal.getTime());   
							  } 
							  mongoDbUtil.insertUpdate(PubConstants.SUC_DATING, info); 
							  
							  DatingReward  reward=(DatingReward) UniObject.DBObjectToObject(db, DatingReward.class); 
							  reward.setCreatedate(new Date()); 
							  mongoDbUtil.insertUpdate(PubConstants.SUC_DATINGREWARD, reward);
						  } 
					}
				}else{ 
					//奖励发放  
					  DatingMember member=new DatingMember(); 
					  member.set_id(mongoSequence.currval(PubConstants.SUC_DATINGMEMEBER)); 
					  member.setCreatedate(new Date()); 
					  member.setCustid(custid); 
					  member.setFromUserid(id); 
					  member.setMoney(0); 
					  Calendar cal = Calendar.getInstance(); 
					  cal.add(Calendar.HOUR,6);  
					  member.setStartdate(new Date());
					  member.setEnddate(cal.getTime());
					  mongoDbUtil.insertUpdate(PubConstants.SUC_DATINGMEMEBER, member); 
					  DBObject  dat=mongoDbUtil.findOneById(PubConstants.SUC_DATING, id); 
					  if(dat!=null){ 
						  DatingInfo info=(DatingInfo) UniObject.DBObjectToObject(dat, DatingInfo.class);
						  if(info.getEndMemberDate()!=null){
							  cal.setTime(info.getEndMemberDate());
							  cal.add(Calendar.HOUR,6); 
							  info.setEndMemberDate(cal.getTime());  
						  }else{
							  info.setEndMemberDate(cal.getTime());   
						  } 
						  mongoDbUtil.insertUpdate(PubConstants.SUC_DATING, info);  
							DatingReward  reward=new DatingReward();
							reward.set_id(mongoSequence.currval(PubConstants.SUC_DATINGREWARD));
							reward.setCreatedate(new Date());
							reward.setCustid(custid);
							reward.setFromUserid(id);
							reward.setType(0); 
							mongoDbUtil.insertUpdate(PubConstants.SUC_DATINGREWARD, reward);
					  } 
					  
				 
					
				} 
			}else if(Integer.parseInt(type)==2){ 
				String fromUserid=obj.getString("fromUserid");
				String id=obj.getString("id");
				HashMap<String,Object>whereMap1=new HashMap<>();
				whereMap1.put("no",id);
				DBObject user=mongoDbUtil.findOne(PubConstants.DATA_WXUSER, whereMap1);
				String toUserid="";
				if(user!=null){
				  toUserid=user.get("_id").toString();	
				} 
				if(!toUserid.equals(fromUserid)&&StringUtils.isNotEmpty(toUserid)){
					DatingStatistical st=new DatingStatistical();
					st.set_id(fromUserid);
					st.setCustid(custid);
					st.setFromUserid(fromUserid);
					st.setCreatedate(new Date());
					st.setToUserid(toUserid); 
					mongoDbUtil.insertUpdate(PubConstants.SUC_DATINGSTATISTICAL, st);
					//验证任务
					HashMap<String,Object>whereMap=new HashMap<>();
					whereMap.put("toUserid",toUserid);
					Long count=mongoDbUtil.getCount(PubConstants.SUC_DATINGSTATISTICAL, whereMap);
					if(count>=5){
						whereMap.clear();
						whereMap.put("fromUserid",toUserid);
						whereMap.put("type",1);
						whereMap.put("value", 5);
						Long c=mongoDbUtil.getCount(PubConstants.SUC_DATINGREWARD, whereMap);
						if(c==0){
							//奖励发放  
							  DatingMember member=new DatingMember(); 
							  member.set_id(mongoSequence.currval(PubConstants.SUC_DATINGMEMEBER)); 
							  member.setCreatedate(new Date()); 
							  member.setCustid(custid); 
							  member.setFromUserid(fromUserid); 
							  member.setMoney(0); 
							  Calendar cal = Calendar.getInstance(); 
							  cal.add(Calendar.HOUR,6);  
							  member.setStartdate(new Date());
							  member.setEnddate(cal.getTime());
							  mongoDbUtil.insertUpdate(PubConstants.SUC_DATINGMEMEBER, member); 
							  DBObject  db=mongoDbUtil.findOneById(PubConstants.SUC_DATING, fromUserid); 
							  if(db!=null){ 
								  DatingInfo info=(DatingInfo) UniObject.DBObjectToObject(db, DatingInfo.class);
								  if(info.getEndMemberDate()!=null){
									  cal.setTime(info.getEndMemberDate());
									  cal.add(Calendar.HOUR,6); 
									  info.setEndMemberDate(cal.getTime());  
								  }else{
									  info.setEndMemberDate(cal.getTime());   
								  } 
								  mongoDbUtil.insertUpdate(PubConstants.SUC_DATING, info); 
								  DatingReward  reward=new DatingReward();
									reward.set_id(mongoSequence.currval(PubConstants.SUC_DATINGREWARD));
									reward.setCreatedate(new Date());
									reward.setCustid(custid);
									reward.setFromUserid(toUserid);
									reward.setType(1);
									reward.setValue(5);
									mongoDbUtil.insertUpdate(PubConstants.SUC_DATINGREWARD, reward);
							  } 
							  
						  }
						 	 
						
					}else if(count>=10){
						whereMap.clear();
						whereMap.put("fromUserid",toUserid);
						whereMap.put("type",1);
						whereMap.put("value", 10);
						Long c=mongoDbUtil.getCount(PubConstants.SUC_DATINGREWARD, whereMap);
						if(c==0){
							//奖励发放 
							  DatingMember member=new DatingMember(); 
							  member.set_id(mongoSequence.currval(PubConstants.SUC_DATINGMEMEBER)); 
							  member.setCreatedate(new Date()); 
							  member.setCustid(custid); 
							  member.setFromUserid(fromUserid); 
							  member.setMoney(0); 
							  Calendar cal = Calendar.getInstance(); 
							  cal.add(Calendar.HOUR,7);  
							  member.setStartdate(new Date());
							  member.setEnddate(cal.getTime());
							  mongoDbUtil.insertUpdate(PubConstants.SUC_DATINGMEMEBER, member); 
							  DBObject  db=mongoDbUtil.findOneById(PubConstants.SUC_DATING, fromUserid); 
							  if(db!=null){ 
								  DatingInfo info=(DatingInfo) UniObject.DBObjectToObject(db, DatingInfo.class);
								  if(info.getEndMemberDate()!=null){
									  cal.setTime(info.getEndMemberDate());
									  cal.add(Calendar.HOUR,7); 
									  info.setEndMemberDate(cal.getTime());  
								  }else{
									  info.setEndMemberDate(cal.getTime());   
								  } 
								  mongoDbUtil.insertUpdate(PubConstants.SUC_DATING, info); 
								  DatingReward  reward=new DatingReward();
									reward.set_id(mongoSequence.currval(PubConstants.SUC_DATINGREWARD));
									reward.setCreatedate(new Date());
									reward.setCustid(custid);
									reward.setFromUserid(toUserid);
									reward.setType(1);
									reward.setValue(10);
									mongoDbUtil.insertUpdate(PubConstants.SUC_DATINGREWARD, reward);
							  } 
							  
							
						}
						
					}else if(count>=15){
						whereMap.clear();
						whereMap.put("fromUserid",toUserid);
						whereMap.put("type",1);
						whereMap.put("value", 15);
						Long c=mongoDbUtil.getCount(PubConstants.SUC_DATINGREWARD, whereMap);
						if(c==0){
							//奖励发放 
							  DatingMember member=new DatingMember(); 
							  member.set_id(mongoSequence.currval(PubConstants.SUC_DATINGMEMEBER)); 
							  member.setCreatedate(new Date()); 
							  member.setCustid(custid); 
							  member.setFromUserid(fromUserid); 
							  member.setMoney(0); 
							  Calendar cal = Calendar.getInstance(); 
							  cal.add(Calendar.HOUR,10);  
							  member.setStartdate(new Date());
							  member.setEnddate(cal.getTime());
							  mongoDbUtil.insertUpdate(PubConstants.SUC_DATINGMEMEBER, member); 
							  DBObject  db=mongoDbUtil.findOneById(PubConstants.SUC_DATING, fromUserid); 
							  if(db!=null){ 
								  DatingInfo info=(DatingInfo) UniObject.DBObjectToObject(db, DatingInfo.class);
								  if(info.getEndMemberDate()!=null){
									  cal.setTime(info.getEndMemberDate());
									  cal.add(Calendar.HOUR,10); 
									  info.setEndMemberDate(cal.getTime());  
								  }else{
									  info.setEndMemberDate(cal.getTime());   
								  } 
								  mongoDbUtil.insertUpdate(PubConstants.SUC_DATING, info); 
								  DatingReward  reward=new DatingReward();
									reward.set_id(mongoSequence.currval(PubConstants.SUC_DATINGREWARD));
									reward.setCreatedate(new Date());
									reward.setCustid(custid);
									reward.setFromUserid(toUserid);
									reward.setType(1);
									reward.setValue(15);
									mongoDbUtil.insertUpdate(PubConstants.SUC_DATINGREWARD, reward);
							  } 
							  
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
