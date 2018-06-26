package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;

/***
 * 资源管理
 * @author lsp
 *
 */
public class TpError extends ReflectionDBObject{
	
	/**
	 * 类型
	 */
	private Date insdate;
	
	private String toUser;

	public Date getInsdate() {
		return insdate;
	}

	public void setInsdate(Date insdate) {
		this.insdate = insdate;
	}

	public String getToUser() {
		return toUser;
	}

	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	
}
