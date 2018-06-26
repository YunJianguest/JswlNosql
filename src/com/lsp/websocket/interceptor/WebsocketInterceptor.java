package com.lsp.websocket.interceptor;

import java.util.Map;

import javax.websocket.Session;

public interface WebsocketInterceptor {
	/**
	 * 拦截器
	 * @param session
	 * @return
	 */
   public Session checkSession(Session session,Map<String,Object>checkMap);
}
