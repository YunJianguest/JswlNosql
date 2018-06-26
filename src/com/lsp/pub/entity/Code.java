package com.lsp.pub.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;

public class Code extends ReflectionDBObject{

	/**
	 * 类型0电话验证码
	 */
	private int  type;
	private Date createdate; 
	private String value;
	private String code;
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	
	
}
