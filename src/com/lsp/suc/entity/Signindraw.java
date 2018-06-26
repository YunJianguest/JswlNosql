package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 签到摇奖
 * @author lsp
 *
 */
public class Signindraw  extends ReflectionDBObject{

	private String custid;
	private String title;
	private String content;
	private String picurl;
	private String ewmurl;
	private Date   createdate;
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public String getEwmurl() {
		return ewmurl;
	}
	public void setEwmurl(String ewmurl) {
		this.ewmurl = ewmurl;
	}
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	
}
