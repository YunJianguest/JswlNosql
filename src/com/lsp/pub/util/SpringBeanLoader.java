package com.lsp.pub.util;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
/**
 * 工具
 * @author lsp 
 *   
 */
public class SpringBeanLoader
{
  private static Log logger = LogFactory.getLog(SpringBeanLoader.class);

  private static ApplicationContext context = null;

  public static Object getBeanMq(String bean名称)
  {
	  if(context == null){
		  context = new ClassPathXmlApplicationContext("applicationContext-mq.xml");
		  context.getBean("listenerQueueZdymessage");
		  context.getBean("listenerQueuePermessage"); 
		  context.getBean("listenerQueueRedmessage"); 
		  context.getBean("listenerQueueRepmessage"); 
		  context.getBean("listenerQueueCheckmessage");
		  context.getBean("listenerQueueOnlinemessage"); 
	  } 
    return context.getBean(bean名称);
  } 
}