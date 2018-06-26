package com.lsp.websocket;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.lsp.pub.util.JmsService;
import com.lsp.websocket.interceptor.WebsocketInterceptor;
import com.lsp.websocket.service.WebsoketListen;

import net.sf.json.JSONObject;
/**
 * 聊天服务器类
 * @author lsp
 *
 */
@ServerEndpoint("/websocket")
public class ChatServer implements WebsoketListen,WebsocketInterceptor{  
	    @OnOpen
	    public void open(Session session) {
	        // 添加初始化操作 
	    	sessionCreated(session); 
	    }

	    /**
	     * 接受客户端的消息，并把消息发送给所有连接的会话
	     * @param message 客户端发来的消息
	     * @param session 客户端的会话
	     */
	    @OnMessage
	    public void getMessage(String message, Session session) {  
	        // 把客户端的消息解析为JSON对象
	        JSONObject jsonObject = JSONObject.fromObject(message);  
	       
	        if(jsonObject.get("init")!=null&&jsonObject.getString("init").equals("init")){
	        	//绑定用户 
	        	boundSessions(session,jsonObject.getString("uid"));
	        	Iterator it = jsonObject.keys();
	 	        while (it.hasNext()) { 
	                 String key = (String) it.next(); 
	                 boundAttribute(session.getId(), key, jsonObject.getString(key));
	             } 
	        }else{
	        	Map<String,Object>checkMap=new HashMap<>();
	        	if(jsonObject.get("check")!=null){
	        		for (String key : jsonObject.getString("check").split(",")) {
	        			checkMap.put(key, jsonObject.get(key));
					}
	        	}; 
	        	JmsService.SendJson(jsonObject.getString("toUserid"), jsonObject) ;
		     
	        }  
	      
	    }

	    @OnClose
	    public void close(Session session) {
	        // 添加关闭会话时的操作 
	    	sessionDestroyed(session); 
	    }

	    @OnError
	    public void error(Throwable t) {
	        // 添加处理错误的操作
	    }

		@Override
		public void sessionCreated(Session session) { 
			SessionMap.put(session.getId(), session);
			
		}

		@Override
		public void sessionDestroyed(Session session) { 
			JmsService.Offline(UidMap.get(session.getId()));
			SessionMap.remove(session.getId());
			SessionidMap.remove(UidMap.get(session.getId()));
			UidMap.remove(session.getId()); 
			
		}

		@Override
		public Collection<Session> getSessions() {
			// TODO Auto-generated method stub 
			return SessionMap.values();
		} 
		@Override
		public void boundSessions(Session session, String uid) {
			// TODO Auto-generated method stub
			SessionidMap.put(uid, session.getId());
			UidMap.put(session.getId(),uid);
			JmsService.Online(uid); 
		}

		@Override
		public void boundAttribute(String sessionid, String key, String value) {
			// TODO Auto-generated method stub
			Map<String, Object>obj=AttributeMap.get(sessionid);
			if(obj==null){
				obj=new HashMap<>();
			}
			obj.put(key, value);
			AttributeMap.put(sessionid, obj);
		}

		@Override
		public Object getAttribute(String sessionid, String key) { 
			// TODO Auto-generated method stub
			return AttributeMap.get(sessionid).get(key);
		}
		/**
		 * 向客户端发送消息
		 * @param session
		 * @param msg
		 */
		public  void   sendMessage(Session session,String msg){
			session.getAsyncRemote().sendText(msg);
		}
		/**
		 * 向客户端发送消息
		 * @param session
		 * @param msg
		 */
		public static void   sendMessages(Session session,String msg){
			if(session!=null){
				session.getAsyncRemote().sendText(msg);
			}
			
		}

		@Override
		public Session checkSession(Session session,Map<String,Object>checkMap) {
			// TODO Auto-generated method stub
			for (String key : checkMap.keySet()) {
				if(!checkMap.get(key).equals(AttributeMap.get(session.getId()).get(key))){
					return null;
				}
			}
			return session;
		}  	
}
