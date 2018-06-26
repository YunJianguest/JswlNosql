package com.lsp.website.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;

/***
 *  网站流量
 * @author lsp
 *
 */
public class WwzFlowInfo extends ReflectionDBObject{
	
	/**
	 * 类型
	 */
	private String type;
	
	private String toUser;
	private int count;
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	
	
	

}

