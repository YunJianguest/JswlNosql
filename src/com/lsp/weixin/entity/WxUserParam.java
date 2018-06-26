package com.lsp.weixin.entity;

import java.util.Date;
import java.util.List;

import com.mongodb.ReflectionDBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
public class WxUserParam extends ReflectionDBObject{
	/**
	 * 微信用户
	 */
	private String toUser;
	/**
	 * 修改日期
	 */
	private Date insdate;
	/**
	 * 是否微信推送 0 推送 1 不推送
	 */
	private int wx;
	/**
	 * 是否短信推送 0 推送 1 不推送
	 */
	private int dx;
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public Date getInsdate() {
		return insdate;
	}
	public void setInsdate(Date insdate) {
		this.insdate = insdate;
	}
	public int getWx() {
		return wx;
	}
	public void setWx(int wx) {
		this.wx = wx;
	}
	public int getDx() {
		return dx;
	}
	public void setDx(int dx) {
		this.dx = dx;
	}
	
}
