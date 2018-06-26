package com.lsp.weixin.web;
 
import java.util.Date;
import java.util.List;

import com.mongodb.ReflectionDBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
public class FreeMarker extends ReflectionDBObject{
	/**
	 * 企业地址
	 */															
	private String toUser;

	public String getToUser() {
		return toUser;
	}

	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	
	
}
