package com.lsp.pub.entity;

import com.mongodb.ReflectionDBObject;
/**
 * 色值
 * 
 * @author lsp
 * 
 */
public class Color extends ReflectionDBObject{

	private String  title;
	private String  value;
	private String  picurl;
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
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	
}
