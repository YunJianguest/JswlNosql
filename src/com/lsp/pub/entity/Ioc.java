package com.lsp.pub.entity;

import com.mongodb.ReflectionDBObject;

/**
 * 图标库
 * 
 * @author lsp
 * 
 */
public class Ioc extends ReflectionDBObject{

	private String title;
	private String value;
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	
}
