package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/***
 * 纪念馆通用
 * @author lsp
 *
 */
public class Mark extends ReflectionDBObject{ 
	 private String custid; 
	 private String title;
	 private String picurl;
	 private String summary;
	 private String content;
	 private Date   createdate;
	 private int    sort;
	 private int    mb;
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
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
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
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public int getMb() {
		return mb;
	}
	public void setMb(int mb) {
		this.mb = mb;
	}
	 
	
}
