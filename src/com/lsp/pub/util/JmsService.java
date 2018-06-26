package com.lsp.pub.util; 
 
import java.util.HashMap;

import javax.jms.Destination;
import javax.jms.TextMessage;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.jms.JmsException;
import org.springframework.jms.core.JmsTemplate; 
import com.lsp.android.entity.Message;
import com.lsp.android.entity.MessageInfo;

/**
 * 工具
 * @author lsp 
 *   
 */
public class JmsService {
	
	
	
	/**
	 * 向Topic队列eedaTopic 发送 消息
	 * @param message 消息内容
	 * @return 
	 * @throws Exception
	 */
	public  static boolean smsSend(String tel,String title,String message) throws Exception{
		
		try {
			JmsTemplate jmsTemplate = (JmsTemplate) SpringBeanLoader.getBeanMq("jmsTemplate");
			Destination destination = (Destination) SpringBeanLoader.getBeanMq("JTBDataUpDestination");
			//向广播队列发送消息发送消息
			jmsTemplate.convertAndSend(destination,tel+"|"+title+"|"+message); 
		}  catch (Exception e) {
			
			
			return false;
			//throw new Exception("Active MQ 没有开启");
		}
		
		return true;
	}
	/**
	 * 向Topic队列eedaTopic 发送 消息
	 * @param message 消息内容
	 * @return 
	 * @throws Exception
	 */
	public  static boolean zdyMessage(String toUser,String fromUser,String type) {
		
		try { 
			JmsTemplate jmsTemplate = (JmsTemplate) SpringBeanLoader.getBeanMq("jmsTemplate");
			Destination destination = (Destination) SpringBeanLoader.getBeanMq("zdymessageDestination");
			//向广播队列发送消息发送消息 
			HashMap<String,String> map=new HashMap<String,String>();
			map.put("toUser", toUser);
			map.put("fromUser", fromUser);
			map.put("type", type);

			String json = JSONArray.fromObject(map).toString();
			jmsTemplate.convertAndSend(destination,json.substring(1, json.length() - 1)); 
		}  catch (Exception e) {

			//throw new Exception("Active MQ 没有开启");
		}
		
		return true;
	}
	/**
	 * 向Topic队列eedaTopic 发送 消息
	 * @param message 消息内容
	 * @return 
	 * @throws Exception
	 */
	public  static boolean zdyMessage(String toUser,String fromUser,String type,String tsUser) {
		
		try {
			JmsTemplate jmsTemplate = (JmsTemplate) SpringBeanLoader.getBeanMq("jmsTemplate");
			Destination destination = (Destination) SpringBeanLoader.getBeanMq("zdymessageDestination");
			//向广播队列发送消息发送消息
			
			HashMap<String,String> map=new HashMap<String,String>();
			map.put("toUser", toUser);
			map.put("fromUser", fromUser);
			map.put("tsUser", tsUser);
			map.put("type", type);

			String json = JSONArray.fromObject(map).toString();
			jmsTemplate.convertAndSend(destination,json.substring(1, json.length() - 1)); 
		}  catch (Exception e) {

			//throw new Exception("Active MQ 没有开启");
		}
		
		return true;
	}
	/**
	 * 向Topic队列eedaTopic 发送 消息
	 * @param message 消息内容
	 * @return 
	 * @throws Exception
	 */
	public  static boolean jsonMessage(String toUser,String fromUser,String type,HashMap<String,Object> msg) {
		
		msg.put("toUser", toUser);
		msg.put("fromUser", fromUser);
		msg.put("type", type);
		String json = JSONArray.fromObject(msg).toString();
		try {
			JmsTemplate jmsTemplate = (JmsTemplate) SpringBeanLoader.getBeanMq("jmsTemplate");
			Destination destination = (Destination) SpringBeanLoader.getBeanMq("zdymessageDestination");
			//向广播队列发送消息发送消息
			jmsTemplate.convertAndSend(destination,json.substring(1, json.length() - 1)); 
		}  catch (Exception e) {

			//throw new Exception("Active MQ 没有开启");
		}
		
		return true;
	}
	/**
	 * 向Topic队列eedaTopic 发送 消息
	 * @param message 消息内容
	 * @return 
	 * @throws Exception
	 */
	public  static boolean mailMessage(String toUser,String fromUser,String type,HashMap<String,Object> msg) {
		
		msg.put("toUser", toUser);
		msg.put("fromUser", fromUser);
		msg.put("type", type);
		String json = JSONArray.fromObject(msg).toString();
		try {
			JmsTemplate jmsTemplate = (JmsTemplate) SpringBeanLoader.getBeanMq("jmsTemplate");
			Destination destination = (Destination) SpringBeanLoader.getBeanMq("mailmessageDestination");
			//向广播队列发送消息发送消息
			jmsTemplate.convertAndSend(destination,json.substring(1, json.length() - 1)); 
		}  catch (Exception e) {

			//throw new Exception("Active MQ 没有开启");
		}
		
		return true;
	}
	/**
	 * 向Topic队列eedaTopic 发送 消息
	 * @param message 消息内容
	 * @return 
	 * @throws Exception
	 */
	public  static boolean kfDataOut(String fromUser,String message) throws Exception{
		
		try {
			JmsTemplate jmsTemplate = (JmsTemplate) SpringBeanLoader.getBeanMq("jmsTemplate");
			Destination destination = (Destination) SpringBeanLoader.getBeanMq("kfDataOut");
			//向广播队列发送消息发送消息
			jmsTemplate.convertAndSend(destination,fromUser+"||"+message); 
		}  catch (Exception e) {
			
			
			return false;
			//throw new Exception("Active MQ 没有开启");
		}
		
		return true;
	}
	
	/**
	 * 从queue队列eedaQueue接收消息
	 * @throws Exception
	 */	
	public static void queueGet() throws Exception{
	
		JmsTemplate jmsTemplate = (JmsTemplate) SpringBeanLoader.getBeanMq("jmsTemplate");
		Destination destination = (Destination) SpringBeanLoader.getBeanMq("kfDataIn");
		//接收消息
		while(true){
			TextMessage msg=(TextMessage)jmsTemplate.receive(destination);  
		}
	}
	/**
	 * 向队列里面推送通知消息
	 * @param custid
	 * @param fromUserid
	 * @param title
	 * @param summary
	 * @param url
	 * @param picurl
	 * @return
	 */
	public  static boolean permessageMessage(String custid,String fromUserid,String title,String summary,String url,String picurl,String type,String lx) {
		 
			try {
				JmsTemplate jmsTemplate = (JmsTemplate) SpringBeanLoader.getBeanMq("jmsTemplate"); 
				Destination destination = (Destination) SpringBeanLoader.getBeanMq("permessageDestination");
				//向广播队列发送消息发送消息
				
				HashMap<String,String> map=new HashMap<String,String>();
				map.put("custid", custid);
				map.put("fromUserid", fromUserid);
				map.put("title", title);
				map.put("summary", summary);
				map.put("url", url);
				map.put("picurl", picurl);
				map.put("type", type);
				map.put("lx", lx);

				String json = JSONArray.fromObject(map).toString(); 
				jmsTemplate.convertAndSend(destination,json.substring(1, json.length() - 1));
			} catch (JmsException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
		 
		
		return true;
	}
	/**
	 * 向队列里面推送通知消息（调用历史消息）
	 * @param custid
	 * @param fromUserid
	 * @param title
	 * @param summary
	 * @param url
	 * @param picurl
	 * @return
	 */
	public  static boolean permessageMessage(String custid,String fromUserid,String id,String type) {
		 
			try {
				JmsTemplate jmsTemplate = (JmsTemplate) SpringBeanLoader.getBeanMq("jmsTemplate"); 
				Destination destination = (Destination) SpringBeanLoader.getBeanMq("permessageDestination");
				//向广播队列发送消息发送消息
				
				HashMap<String,String> map=new HashMap<String,String>();
				map.put("custid", custid);
				map.put("fromUserid", fromUserid);
				map.put("id", id);
				map.put("type",type); 
				String json = JSONArray.fromObject(map).toString(); 
				jmsTemplate.convertAndSend(destination,json.substring(1, json.length() - 1));
			} catch (JmsException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
		 
		
		return true;
	}
	 
	/**
	 * 向队列里面推送通知消息(带订单信息)
	 * @param custid
	 * @param fromUserid
	 * @param title
	 * @param summary
	 * @param url
	 * @param picurl
	 * @return
	 */
	public  static boolean permessageMessage(MessageInfo me) {
		 
			try {
				JmsTemplate jmsTemplate = (JmsTemplate) SpringBeanLoader.getBeanMq("jmsTemplate"); 
				Destination destination = (Destination) SpringBeanLoader.getBeanMq("permessageDestination");
				//向广播队列发送消息发送消息
				
				HashMap<String,String> map=new HashMap<String,String>();
				map.put("custid", me.getCustid());
				map.put("fromUserid", me.getFromUserid());
				map.put("title", me.getTitle());
				map.put("summary", me.getSummary());
				map.put("url", me.getUrl());
				map.put("picurl", me.getPicurl());
				map.put("type", me.getType()+"");
				map.put("lx", me.getLx());
				map.put("comname", me.getComname());
				map.put("orderid", me.getOrderid());
				map.put("procount",me.getProcount());
				map.put("prostate", me.getProstate());
				map.put("protitle", me.getProtitle());

				String json = JSONArray.fromObject(map).toString(); 
				jmsTemplate.convertAndSend(destination,json.substring(1, json.length() - 1));
			} catch (JmsException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
		 
		
		return true;
	} 
	/**
	 * 微信红包队列 
	 * @param orderno
	 * @return
	 */
	public  static boolean redpacketMessage(String orderno) {
		 
			try {
				JmsTemplate jmsTemplate = (JmsTemplate) SpringBeanLoader.getBeanMq("jmsTemplate"); 
				Destination destination = (Destination) SpringBeanLoader.getBeanMq("redpacketDestination");
				//向广播队列发送消息发送消息
				
				HashMap<String,String> map=new HashMap<String,String>();
				map.put("orderno", orderno); 
				String json = JSONArray.fromObject(map).toString(); 
				jmsTemplate.convertAndSend(destination,json.substring(1, json.length() - 1));
			} catch (JmsException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
		 
		
		return true;
	}
	/**
	 * 微信红包（摇奖）队列 
	 * @param orderno
	 * @param luckid
	 * @return
	 */
	public  static boolean redpacketMessage(String orderno,String reward,int type) {
		 
		try {
			JmsTemplate jmsTemplate = (JmsTemplate) SpringBeanLoader.getBeanMq("jmsTemplate"); 
			Destination destination = (Destination) SpringBeanLoader.getBeanMq("redpacketDestination");
			//向广播队列发送消息发送消息
			
			HashMap<String,String> map=new HashMap<String,String>();
			map.put("orderno", orderno); 
			map.put("reward", reward);
			map.put("type", type+"");
			String json = JSONArray.fromObject(map).toString(); 
			jmsTemplate.convertAndSend(destination,json.substring(1, json.length() - 1));
		} catch (JmsException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	 
	
	return true;
 }
	 /**
	  * 更新未读信息
	  * @param rid
	  * @param fromUsreid
	  * @return
	  */
	public  static boolean unfindMessage(String rid,String fromUserid,int type) {
		 
		try {
			JmsTemplate jmsTemplate = (JmsTemplate) SpringBeanLoader.getBeanMq("jmsTemplate"); 
			Destination destination = (Destination) SpringBeanLoader.getBeanMq("repmessageDestination");
			//向广播队列发送消息发送消息
			
			HashMap<String,String> map=new HashMap<String,String>();
			map.put("rid", rid); 
			map.put("fromUserid", fromUserid); 
			map.put("type", type+""); 
			String json = JSONArray.fromObject(map).toString(); 
			jmsTemplate.convertAndSend(destination,json.substring(1, json.length() - 1));
		} catch (JmsException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	 
	
	return true;
 }
	 /**
	  * 更新最后聊天信息
	  * @param rid
	  * @param fromUsreid
	  * @return
	  */
  public  static boolean upendMessage(String rid,String msg,int type) {
	
		try { 
			JmsTemplate jmsTemplate = (JmsTemplate) SpringBeanLoader.getBeanMq("jmsTemplate");  
			Destination destination = (Destination) SpringBeanLoader.getBeanMq("repmessageDestination");
			//向广播队列发送消息发送消息  
			HashMap<String,String> map=new HashMap<String,String>();
			map.put("rid", rid); 
			map.put("msg", msg); 
			map.put("type", type+""); 
			
			String json = JSONArray.fromObject(map).toString(); 
			jmsTemplate.convertAndSend(destination,json.substring(1, json.length() - 1));
		} catch (JmsException e) {
			// TODO Auto-generated catch block 
			e.printStackTrace(); 
		} 
	 
	
	return true;
 }
  /**
   * 保存聊天记录
   * @param msg
   * @param type
   * @return
   */
  public  static boolean saveMessage(Message msg,int type) {
	
		try { 
			JmsTemplate jmsTemplate = (JmsTemplate) SpringBeanLoader.getBeanMq("jmsTemplate");  
			Destination destination = (Destination) SpringBeanLoader.getBeanMq("repmessageDestination");
			//向广播队列发送消息发送消息  
			HashMap<String,String> map=new HashMap<String,String>();
			map.put("rid", msg.getRid()); 
			map.put("content", msg.getContent());
			map.put("custid", msg.getCustid()); 
			map.put("fromUserid", msg.getFromUserid()); 
			map.put("picurl", msg.getPicurl()); 
			map.put("title", msg.getTitle()); 
			map.put("toUserid", msg.getToUserid()); 
			map.put("url", msg.getUrl());   
			map.put("type", type+""); 
			
			String json = JSONArray.fromObject(map).toString(); 
			jmsTemplate.convertAndSend(destination,json.substring(1, json.length() - 1));
		} catch (JmsException e) {
			// TODO Auto-generated catch block 
			e.printStackTrace(); 
		} 
	 
	
	return true;
  }
  
  /**
   * 验证奖励
   * @param msg
   * @param type
   * @return
   */
  public  static boolean  CheckReward(String id,String type,String custid,String fromUserid) {
	
		try {  
			JmsTemplate jmsTemplate = (JmsTemplate) SpringBeanLoader.getBeanMq("jmsTemplate");  
			Destination destination = (Destination) SpringBeanLoader.getBeanMq("checkmessageDestination");
			//向广播队列发送消息发送消息  
			HashMap<String,String> map=new HashMap<String,String>();
			map.put("id", id);
			map.put("type",type);
			map.put("custid",custid);
			map.put("fromUserid",fromUserid);  
			String json = JSONArray.fromObject(map).toString(); 
			jmsTemplate.convertAndSend(destination,json.substring(1, json.length() - 1));
		} catch (JmsException e) {
			// TODO Auto-generated catch block 
			e.printStackTrace(); 
		} 
	 
	
	return true;
  }
  /**
   * 验证奖励
   * @param msg
   * @param type
   * @return
   */
  public  static boolean  Online(String id) {
	
		try {  
			JmsTemplate jmsTemplate = (JmsTemplate) SpringBeanLoader.getBeanMq("jmsTemplate");  
			Destination destination = (Destination) SpringBeanLoader.getBeanMq("onlineDestination");
			//向广播队列发送消息发送消息  
			HashMap<String,String> map=new HashMap<String,String>();
			map.put("id", id);
			map.put("type","1");  
			String json = JSONArray.fromObject(map).toString(); 
			jmsTemplate.convertAndSend(destination,json.substring(1, json.length() - 1));
		} catch (JmsException e) {
			// TODO Auto-generated catch block 
			e.printStackTrace(); 
		}  
	 return true;
   } 
  /**
   * 验证奖励
   * @param msg
   * @param type
   * @return
   */
     public  static boolean  Offline(String id) {
	
		try {  
			JmsTemplate jmsTemplate = (JmsTemplate) SpringBeanLoader.getBeanMq("jmsTemplate");  
			Destination destination = (Destination) SpringBeanLoader.getBeanMq("onlineDestination");
			//向广播队列发送消息发送消息  
			HashMap<String,String> map=new HashMap<String,String>();
			map.put("id", id);
			map.put("type","0"); 
			String json = JSONArray.fromObject(map).toString(); 
			jmsTemplate.convertAndSend(destination,json.substring(1, json.length() - 1));
		} catch (JmsException e) {
			// TODO Auto-generated catch block 
			e.printStackTrace(); 
		} 
	  
	   return true;
    }
    /**
     * 发送消息到指定用户（后台发送）
     * @param id
     * @param msg
     * @return
     */
     public  static boolean  SendMsg(String id,String msg) {
   	
   	 try {  
   		JmsTemplate jmsTemplate = (JmsTemplate) SpringBeanLoader.getBeanMq("jmsTemplate");  
   		Destination destination = (Destination) SpringBeanLoader.getBeanMq("onlineDestination");
   		//向广播队列发送消息发送消息  
   		HashMap<String,String> map=new HashMap<String,String>();
   		map.put("id", id);
   		map.put("type","2");
   		map.put("msg",msg);
   		String json = JSONArray.fromObject(map).toString(); 
   		jmsTemplate.convertAndSend(destination,json.substring(1, json.length() - 1));
   	  } catch (JmsException e) {
   			// TODO Auto-generated catch block 
   			e.printStackTrace(); 
   	 }  
   	   return true;
    }
     /**
      * 发送消息到指定用户（用户发送）
      * @param id
      * @param msg
      * @return
      */
     public  static boolean  SendJson(String id,JSONObject msg) {
           	
       try {  
       		JmsTemplate jmsTemplate = (JmsTemplate) SpringBeanLoader.getBeanMq("jmsTemplate");  
       		Destination destination = (Destination) SpringBeanLoader.getBeanMq("onlineDestination");
       		//向广播队列发送消息发送消息  
       		HashMap<String,String> map=new HashMap<String,String>();
       		map.put("id", id);
       		map.put("type","3");
       		map.put("msg",msg.toString());
       		String json = JSONArray.fromObject(map).toString(); 
       		jmsTemplate.convertAndSend(destination,json.substring(1, json.length() - 1));
       		} catch (JmsException e) {
       			// TODO Auto-generated catch block 
       		e.printStackTrace(); 
       	}  
       	 return true;
     }       
     /**
      * 添加到未读消息
      * @param id（用户ID）
      * @param rid（会话ID）
      * @return
      */
     public  static boolean  AddUnread(String id,String rid) {
           	
       try {  
       		JmsTemplate jmsTemplate = (JmsTemplate) SpringBeanLoader.getBeanMq("jmsTemplate");  
       		Destination destination = (Destination) SpringBeanLoader.getBeanMq("onlineDestination");
       		//向广播队列发送消息发送消息  
       		HashMap<String,String> map=new HashMap<String,String>();
       		map.put("id", id);
       		map.put("type","4");
       		map.put("rid",rid);
       		String json = JSONArray.fromObject(map).toString(); 
       		jmsTemplate.convertAndSend(destination,json.substring(1, json.length() - 1));
       		} catch (JmsException e) {
       			// TODO Auto-generated catch block 
       		e.printStackTrace(); 
       	}  
       	 return true;
     }       

}
