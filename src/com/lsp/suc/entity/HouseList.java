package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;

/***
 * 资源管理
 * @author lsp
 *
 */
public class HouseList  extends ReflectionDBObject{
	/**
	 * 标题
	 */
	private String title;
	/**
	 * 简介
	 */
	private String summary;
	
	/**
	 * 内容  
	 */
	private String context;
	/**
	 * 户型图
	 */
	private String picurl;
	/**
	 * 全景图
	 */
	private String phototu;
	
	
	private Date createdate;
	private Long custid;
	private String toUser;
	private int sort;
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
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
	public String getPhototu() {
		return phototu;
	}
	public void setPhototu(String phototu) {
		this.phototu = phototu;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public Long getCustid() {
		return custid;
	}
	public void setCustid(Long custid) {
		this.custid = custid;
	}
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	
	
}

