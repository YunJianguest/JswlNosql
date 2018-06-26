package com.lsp.dwr.service;

import org.directwebremoting.impl.DefaultScriptSessionManager;  
/**
 * 资源管理
 * @author lsp 
 *   
 */
public class DWRScriptSessionManager extends DefaultScriptSessionManager {  
     public DWRScriptSessionManager(){  
            //绑定一个ScriptSession增加销毁事件的监听器  
            this.addScriptSessionListener( new DWRScriptSessionListener());  
           System. out.println( "bind DWRScriptSessionListener");  
     }  
}  