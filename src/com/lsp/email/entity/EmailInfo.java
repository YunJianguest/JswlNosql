package com.lsp.email.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 资源管理
 * @author lsp 
 *   
 */
public class EmailInfo extends ReflectionDBObject{

	private  String  custid;
	private  String  fromUserid;
	private  String  toUserid;
	private  String  title;
	private  String  content;
	/**
	 * 1未读，0已读，2垃圾箱
	 */
	private  int     state;
	/**
	 * 0普通用户，1管理员
	 */
	private  int     type;
	private  Date    createdate;
	private  Date    readdate;
	private  String  url;
	private  String  picurl;
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
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public Date getReaddate() {
		return readdate;
	}
	public void setReaddate(Date readdate) {
		this.readdate = readdate;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	
	
}
