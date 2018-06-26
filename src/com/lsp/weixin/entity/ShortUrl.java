package com.lsp.weixin.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;

/***
 *  发起活动帖子
 * @author lsp
 *
 */
public class ShortUrl extends ReflectionDBObject{
	
	/**
	 * 长网站
	 */															
	private String lurl ;
	/**
	 * 短网站
	 */															
	private String surl ;
	private Date insdate;
	private String toUser;
	private String dwz;
	public String getLurl() {
		return lurl;
	}
	public void setLurl(String lurl) {
		this.lurl = lurl;
	}
	public String getSurl() {
		return surl;
	}
	public void setSurl(String surl) {
		this.surl = surl;
	}
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
	public String getDwz() {
		return dwz;
	}
	public void setDwz(String dwz) {
		this.dwz = dwz;
	}
	
}
