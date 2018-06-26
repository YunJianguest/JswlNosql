package com.lsp.shop.entiy;

import java.util.Date;

import com.mongodb.ReflectionDBObject;

/***
 * 关联账号
 * @author lsp
 *
 */
public class ComMain  extends ReflectionDBObject{
	

	private String toUser;//服务号ID
	private String comToUser;//子类ID
	private String title;

	
	public String getToUser() {
		return toUser;
	}

	public void setToUser(String toUser) {
		this.toUser = toUser;
	}

	public String getComToUser() {
		return comToUser;
	}

	public void setComToUser(String comToUser) {
		this.comToUser = comToUser;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	
	
}
