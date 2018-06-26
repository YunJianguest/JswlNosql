package com.lsp.pub.entity;

import com.mongodb.ReflectionDBObject;

public class Font extends ReflectionDBObject{

	private String  title;
	private String  value;
	private String custid;
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
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	
}
