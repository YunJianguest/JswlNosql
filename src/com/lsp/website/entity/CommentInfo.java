package com.lsp.website.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 评论管理
 * @author lsp
 *
 */
public class CommentInfo extends ReflectionDBObject {
	private  String  toUser;
	private  String  fromUser;
	private  String  type;
	
	private  String  title;
	private  String  context;
	private  String  picurl;
	
	private  Date    createdate;

	public String getToUser() {
		return toUser;
	}

	public void setToUser(String toUser) {
		this.toUser = toUser;
	}

	public String getFromUser() {
		return fromUser;
	}

	public void setFromUser(String fromUser) {
		this.fromUser = fromUser;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContext() {
		return context;
	}

	public void setContext(String context) {
		this.context = context;
	}

	public String getPicurl() {
		return picurl;
	}

	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}

	public Date getCreatedate() {
		return createdate;
	}

	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	
	 

}
