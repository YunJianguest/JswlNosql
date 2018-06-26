package com.lsp.android.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * android消息管理
 * @author lsp
 *
 */
public class Message extends ReflectionDBObject{
     
	private String custid;
	private String fromUserid;
	private String toUserid;
	private String picurl;
	private String title;
	private String url;
	private String content;
	private String rid;
	private Date   createdate;
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public String getFromUserid() {
		return fromUserid;
	}
	public void setFromUserid(String fromUserid) {
		this.fromUserid = fromUserid;
	}
	public String getToUserid() {
		return toUserid;
	}
	public void setToUserid(String toUserid) {
		this.toUserid = toUserid;
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
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	
	 
}
