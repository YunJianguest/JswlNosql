package com.lsp.websocket.entity;

import java.util.HashMap;
import java.util.Map;

import javax.websocket.Session; 

public class WebsoketUser{
    public static final Map<String, Session> SessionMap = new HashMap<String, Session>(); 
    
}
