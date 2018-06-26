package com.lsp.set.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 快递管理
 * @author lsp
 *
 */
public class Courier extends ReflectionDBObject{

	private String custid;
	private String title; 
	private String picurl;
	private String sort;
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
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	
}
