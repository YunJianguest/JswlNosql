package com.lsp.mqsever; 

import java.io.IOException; 
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.TextMessage; 
import org.jdom.JDOMException;
import org.springframework.stereotype.Component;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject; 
import com.lsp.pub.db.MongoDbUtil;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.PubConstants; 
import com.lsp.pub.entity.WxToken; 
import com.lsp.pub.util.BaseDecimal;
import com.lsp.pub.util.CommonUtil; 
import com.lsp.pub.util.PayCommonUtil;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.XMLUtil;
import com.lsp.suc.entity.RewardRecord;
import com.lsp.website.service.WwzService;
import com.lsp.weixin.entity.RedpackInfo;
import com.lsp.weixin.entity.WxPayConfig;
import com.mongodb.DBObject;
 
/**
 * 微信红包队列
 * @author lsp 
 *   
 */
@Component
public class RedpacketConsumer implements MessageListener {

	@Override
	public void onMessage(Message message) {
		// TODO Auto-generated method stub
		MongoDbUtil mongoDbUtil=new MongoDbUtil();
		MongoSequence mongoSequence=new MongoSequence(); 
		WwzService  wwzService=new WwzService();
		TextMessage txtMsg = ((TextMessage) message);// 任务id
		try {
			JSONObject obj = (JSONObject) JSON.parse(txtMsg.getText().toString());
			String orderno=obj.getString("orderno");
			String reward=obj.getString("reward");
			String type=obj.getString("type");
			System.out.println(orderno);
			System.out.println(reward);
			System.out.println(type);
			DBObject db=mongoDbUtil.findOneById(PubConstants.WEIXIN_REDPACKINFO, orderno);
			System.out.println(db);
			if(db!=null){
				System.out.println("*******1");
				RedpackInfo red=(RedpackInfo) UniObject.DBObjectToObject(db, RedpackInfo.class);
				
				WxToken wxtoken=GetAllFunc.wxtoken.get(red.getCustid());
				System.out.println(wxtoken);
				System.out.println(wxtoken.getQx());
				WxPayConfig wxconfig=new WxPayConfig();
				if(wxtoken.getQx()==0){
					  
				}else if(wxtoken.getQx()==1){
					wxconfig=GetAllFunc.wxPay.get(red.getCustid());
				}else if(wxtoken.getQx()==2){//父类结算   
					wxconfig=GetAllFunc.wxPay.get(wwzService.getparentcustid(red.getCustid()));
				} 
			  
				String nonce_str=PayCommonUtil.CreateNoncestr();
				System.out.println("*******12"); 
				SortedMap<Object,Object> parameters = new TreeMap<Object,Object>();
				parameters.put("nonce_str", nonce_str);
				parameters.put("mch_billno",orderno); 
				parameters.put("mch_id",red.getMch_id());
				parameters.put("wxappid",red.getWxappid());  
				parameters.put("remark", red.getRemark()); 
				System.out.println("*******123"); 
				parameters.put("send_name", red.getSend_name());//商户名称
				parameters.put("re_openid",red.getFromUserid());
				parameters.put("total_amount",BaseDecimal.round(BaseDecimal.multiplication(red.getTotal_amount()+"", "100"),0));
				parameters.put("total_num",red.getTotal_num());
				System.out.println("*******1234"); 
				parameters.put("wishing",red.getWishing());
				parameters.put("client_ip",red.getClient_ip());
				parameters.put("act_name",red.getAct_name()); 
				System.out.println("*******");
				String sign = PayCommonUtil.createSign("UTF-8", parameters,wxconfig.getPartner_key());
				parameters.put("sign", sign);
				System.out.println("*******");
				System.out.println(parameters.toString());
				String requestXML = PayCommonUtil.getRequestXml(parameters);
				System.out.println("****---");
				String result =CommonUtil.httpsRequestSSL("https://api.mch.weixin.qq.com/mmpaymkttransfers/sendredpack","POST", requestXML,wxconfig.getPartner(),"c:/certs/"+wxconfig.getPartner()+"_"+wxconfig.getPartner()+"/apiclient_cert.p12");
				System.out.println("****---***"); 
				Map<String, String> map = XMLUtil.doXMLParse(result);
				System.out.println(result);
		        if(map.get("return_msg").equals("发放成功")&&map.get("err_code_des").equals("发放成功")){
		        	 red.setState(1);
		        	 mongoDbUtil.insertUpdate(PubConstants.WEIXIN_REDPACKINFO, red);
		        	 if(reward!=null){
		        		 if (type=="1") {
		        			 DBObject  rew=mongoDbUtil.findOneById(PubConstants.SUC_VIVO_REWARDRECORD, Long.parseLong(reward));
			        		 if(rew!=null){
			        			 com.lsp.suc.vivo.entity.VivoRewardRecord rewardRecord=(com.lsp.suc.vivo.entity.VivoRewardRecord)UniObject.DBObjectToObject(rew, com.lsp.suc.vivo.entity.VivoRewardRecord.class);
			        			 rewardRecord.setState(1);
			        			 mongoDbUtil.insertUpdate(PubConstants.SUC_VIVO_REWARDRECORD,rewardRecord);
			        		 }
						}else if(type=="0") {
							DBObject  rew=mongoDbUtil.findOneById(PubConstants.WHD_REWARDRECORD, Long.parseLong(reward));
			        		 if(rew!=null){
			        			 RewardRecord rewardRecord=(RewardRecord)UniObject.DBObjectToObject(rew, RewardRecord.class);
			        			 rewardRecord.setState(1);
			        			 mongoDbUtil.insertUpdate(PubConstants.WHD_REWARDRECORD,rewardRecord);
			        		 }
						}
		        		 
		        	 }
		        } 
			} 
			
		} catch (JMSException | JDOMException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		mongoDbUtil.close();
	}
	
}
