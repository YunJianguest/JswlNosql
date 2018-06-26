package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
public class WxFriend extends ReflectionDBObject{
	/**
	 * 微信用户
	 */
	private String toUser;
	
	/**
	 * 微信公众帐号
	 */
	private String fromUser;
	/**
	 * 微信公众帐号
	 */
	private String friendUser;
	
	/**
	 * 1推荐  2 关注  3 挪车  同城  同车型
	 */
	private String type;
	
	private Date createdate;

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

	public String getFriendUser() {
		return friendUser;
	}

	public void setFriendUser(String friendUser) {
		this.friendUser = friendUser;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Date getCreatedate() {
		return createdate;
	}

	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	
	
	
}

