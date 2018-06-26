package com.lsp.dwr.service;

import org.springframework.context.ApplicationEvent;
/**
 * 资源管理
 * @author lsp 
 *   
 */
public class ChatMessageEvent extends ApplicationEvent{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public ChatMessageEvent(Object source) {
		super(source);
		// TODO Auto-generated constructor stub
	}

}
