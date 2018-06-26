package com.lsp.weixin.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;

/***
 *  发起活动帖子
 * @author lsp
 *
 */
public class SendEail extends ReflectionDBObject{
	/**
	 * 组
	 */															
	private String fromUser;
	/**
	 * 组
	 */															
	private Long comid;
	private String type;
	/**
	 * 发送邮件路径
	 */
	private String picurl;
	private Date insdate;
	public String getFromUser() {
		return fromUser;
	}
	public void setFromUser(String fromUser) {
		this.fromUser = fromUser;
	}
	public Date getInsdate() {
		return insdate;
	}
	public void setInsdate(Date insdate) {
		this.insdate = insdate;
	}
	public Long getComid() {
		return comid;
	}
	public void setComid(Long comid) {
		this.comid = comid;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	
	
}
