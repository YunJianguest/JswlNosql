package com.lsp.dwr.web;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;  

import org.apache.commons.lang3.StringUtils;
import org.directwebremoting.Browser;
import org.directwebremoting.ScriptBuffer;  
import org.directwebremoting.ScriptSession;  
import org.directwebremoting.ScriptSessionFilter;
import org.springframework.context.ApplicationEvent;  
import org.springframework.context.ApplicationListener;  
import org.springframework.web.context.ServletContextAware; 

import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;

import com.lsp.android.entity.Message;
import com.lsp.android.entity.MessageInfo;
import com.lsp.dwr.service.ChatMessageEvent;
import com.lsp.dwr.service.MessageEvent;
import com.lsp.dwr.service.DWRScriptSessionListener; 
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.JmsService;
import com.mongodb.DBObject;
/**
 * 资源管理
 * @author lsp 
 *   
 */
public class ChatMessageClient implements ApplicationListener,ServletContextAware{

	 private ServletContext ctx;  
	  
	    public void setServletContext(ServletContext ctx) {  
	  
	        this.ctx = ctx;  
	  
	    }
	    @SuppressWarnings("deprecation")  
	  
	    public void onApplicationEvent(ApplicationEvent event) {  
	    	
	        //如果事件类型是ChatMessageEvent就执行下面操作  
	       
	        if (event instanceof ChatMessageEvent) {   
	        	send(event); 
	        }else if(event instanceof MessageEvent){
	        	sendMsg(event);
	        }  
	        
	       
	    } 
	    public void send(final ApplicationEvent event){  
            //过滤器  
           ScriptSessionFilter filter = new ScriptSessionFilter() {  
                  
                 public boolean match(ScriptSession scriptSession) { 
                	 
                      String custid = (String)scriptSession.getAttribute("custid");   
                      MessageInfo msg = (MessageInfo) event.getSource(); 
                      return msg.getCustid().equals(custid);  
                }  
           };  
  
           Runnable run = new Runnable(){  
        	   MessageInfo msg = (MessageInfo) event.getSource(); 
                 
        	   private ScriptBuffer script = new ScriptBuffer(); 
                
                 public void run() {  
                      //设置要调用的 js及参数  
                	 Date time = msg.getCreatedate();  
                  	  
 	                String s =DateFormat.getDate(time);
                	 script.appendScript("showMessage({title: '")  
               	   
 	                .appendScript(msg.getTitle()) 
 	                
 	                .appendScript("', picurl: '") 
 	                .appendScript(msg.getPicurl()) 
 	                
 	                .appendScript("', url: '") 
 	                .appendScript(msg.getUrl()) 
 	                .appendScript("', orderid: '") 
 	                .appendScript(msg.getOrderid())
 	                
 	                .appendScript("', lx: '") 
 	                .appendScript(msg.getLx()) 
 	                
 	                
 	                .appendScript("', summary: '") 
 	                .appendScript(msg.getSummary()) 
 	                
 	                .appendScript("', _id: '") 
 	                .appendScript(msg.get_id().toString()) 
 	                
 	                .appendScript("', createdate: '")  
 	  
 	                .appendScript(s)
 	  
 	                .appendScript("'})");
                	 
                	
                      //得到所有ScriptSession  
                     Collection<ScriptSession> sessions = DWRScriptSessionListener.getScriptSessions();
                     if(sessions.size()>0){ 
                    	   //遍历每一个ScriptSession 
                         if(msg.getType()==2){ 
                         	 for (ScriptSession scriptSession : sessions){ 
                              	   if(msg.getCustid().equals(scriptSession.getAttribute("custid").toString())&&msg.getFromUserid().equals(scriptSession.getAttribute("fromUserid").toString())&&scriptSession.getAttribute("type").toString().equals("1")){ 
                              		   scriptSession.addScript(script);  
                              	   }  
                               } 
                         	
                         }else if(msg.getType()==3){ 
                         	
                         	 for (ScriptSession scriptSession : sessions){  
                              	   if(msg.getCustid().equals(scriptSession.getAttribute("custid").toString())&&scriptSession.getAttribute("type").toString().equals("1")&&scriptSession.getAttribute("per").toString().indexOf(msg.getLx())>=0){ 
                              		   scriptSession.addScript(script);  
                              	   }  
                               } 
                         }
                     }
                     
                }  
           }; 
           if(DWRScriptSessionListener.getScriptSessions().size()>0){
        	   //执行推送   
               Browser. withAllSessionsFiltered(filter, run);    //注意这里调用了有filter功能的方法  
           }
          
   }  
	    
	    public void sendMsg(final ApplicationEvent event){  
	    	 
            //过滤器  
           ScriptSessionFilter filter = new ScriptSessionFilter() {  
                  
                 public boolean match(ScriptSession scriptSession) { 
                	 
                      String rid = (String)scriptSession.getAttribute("rid");   
                      Message msg = (Message) event.getSource();
                      if(!msg.getRid().equals(rid)){ 
                    	  for (String string : msg.getToUserid().split(",")) {
      						if(StringUtils.isNotEmpty(string)){
      							//添加到未读信息 
      							JmsService.unfindMessage(msg.getRid(), string,1);
      						}
      					}
                      }
                      return msg.getRid().equals(rid);  
                }  
           };   
           Runnable run = new Runnable(){  
        	   Message msg = (Message) event.getSource(); 
                 
        	   private ScriptBuffer script = new ScriptBuffer();
        	   private ScriptBuffer txscript = new ScriptBuffer();
        	   private ScriptBuffer kfscript = new ScriptBuffer();
                
                 public void run() {   
                	 Date time=msg.getCreatedate(); 
                	 String s =DateFormat.getDate(time); 
                	 script.appendScript("showMessage({fromUserid:'")
                	 .appendScript(msg.getFromUserid())
                	 .appendScript("', toUserid: '") 
                	 .appendScript(msg.getToUserid())
                	 .appendScript("', content: '") 
                	 .appendScript(msg.getContent())
                	 .appendScript("', picurl: '") 
                	 .appendScript(msg.getPicurl())
                	 .appendScript("', title: '") 
                	 .appendScript(msg.getTitle())
                	 .appendScript("', time: '") 
                	 .appendScript(s)
                	 .appendScript("'})");  
                	 
                	 txscript.appendScript("txMessage({fromUserid:'")
                	 .appendScript(msg.getFromUserid())
                	 .appendScript("', toUserid: '") 
                	 .appendScript(msg.getToUserid())
                	 .appendScript("', content: '") 
                	 .appendScript(msg.getContent())
                	 .appendScript("', picurl: '") 
                	 .appendScript(msg.getPicurl())
                	 .appendScript("', title: '") 
                	 .appendScript(msg.getTitle())
                	 .appendScript("', time: '") 
                	 .appendScript(s)
                	 .appendScript("'})"); 
                	 
                	 
                	  kfscript.appendScript("kfMessage({fromUserid:'")
                	 .appendScript(msg.getFromUserid())
                	 .appendScript("', toUserid: '") 
                	 .appendScript(msg.getToUserid())
                	 .appendScript("', content: '") 
                	 .appendScript(msg.getContent())
                	 .appendScript("', picurl: '") 
                	 .appendScript(msg.getPicurl())
                	 .appendScript("', title: '") 
                	 .appendScript(msg.getTitle())
                	 .appendScript("', time: '") 
                	 .appendScript(s)
                	 .appendScript("'})"); 
                      //得到所有ScriptSession
                	 String toUserid=msg.getToUserid(); 
                     Collection<ScriptSession> sessions = DWRScriptSessionListener.getScriptSessions(); 
                       for (ScriptSession scriptSession : sessions) {   
						if(scriptSession.getAttribute("rid").toString().equals(msg.getRid())&&msg.getToUserid().indexOf(scriptSession.getAttribute("fromUserid").toString())>=0){     
							  scriptSession.addScript(script); 
							  toUserid=toUserid.replace(scriptSession.getAttribute("fromUserid").toString(), "");
							  
						}else if(msg.getToUserid().indexOf(scriptSession.getAttribute("fromUserid").toString())>=0){ 
							 
							scriptSession.addScript(txscript);
							  
						}else if(scriptSession.getAttribute("parentid")!=null){ 
							 List<DBObject> lskf=GetAllFunc.datingCustServicenum.get(scriptSession.getAttribute("parentid").toString());
							 for (DBObject kf : lskf) {
								 if(msg.getToUserid().indexOf(kf.get("fromUserid").toString())>=0){
									 scriptSession.addScript(kfscript);
									 break;
								 }
							}
							  
						}
					}
                    String []lsto=toUserid.split(",");
                    for (String string : lsto) {
						if(StringUtils.isNotEmpty(string)){
							//添加到未读信息 
							JmsService.unfindMessage(msg.getRid(), string,1);
						}
					}
                    	 
                    
                }  
           };  
            //执行推送   
           Browser. withAllSessionsFiltered(filter, run);    //注意这里调用了有filter功能的方法  
   }  
	 
}
