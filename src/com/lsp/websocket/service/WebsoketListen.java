package com.lsp.websocket.service;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map; 
import javax.websocket.Session; 

public interface WebsoketListen{

	  public static final Map<String,Session> SessionMap = new HashMap<String, Session>();
	  public static final Map<String,String> UidMap = new HashMap<String, String>();
	  public static final Map<String,String> SessionidMap = new HashMap<String, String>();
	  public static final Map<String, Map<String,Object>> AttributeMap = new HashMap<String, Map<String,Object>>(); 
	  /** 
	      * Session创建事件 
	      */  
	  public void sessionCreated(Session session);  
	  /** 
	      * Session移除事件 
	      */  
	  public void sessionDestroyed(Session session);  
	  /** 
	      * 获取所有Session 
	      */  
	  public Collection<Session> getSessions(); 
	  /** 
	      * 绑定用户
	      */  
	  public void boundSessions(Session session,String uid); 
	  /** 
	      * 绑定属性
	      */  
	  public void boundAttribute(String sessionid,String key,String value); 
	  /** 
	      * 获取属性
	      */  
	  public Object getAttribute(String sessionid,String key); 
	 
	  
}
