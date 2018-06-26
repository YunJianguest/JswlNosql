package com.lsp.weixin.web;

import java.util.HashMap;
import java.util.Map;

import javax.websocket.Session;

public class WxSession {
	public static final Map<String,Session> SessionMap = new HashMap<String, Session>(); 
}
