package com.lsp.web.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
public class RadiolmInfo extends ReflectionDBObject {
	private String  toUser;
	private String custid;
	private Integer sort;
	
	/**
	 * 标题
	 */
	private String title;
	
	private Date  createdate;
	/**
	 * 总播放次数
	 */
	private int   playcount;
	/**
	 * 总内容数
	 */
	private Long   concount;
	/**
	 * 
	 * 主播
	 */
	private String anchor;
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public Integer getSort() {
		return sort;
	}
	public void setSort(Integer sort) {
		this.sort = sort;
	}
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
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	private String summary;
	private String picurl;
	 
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public int getPlaycount() {
		return playcount;
	}
	public void setPlaycount(int playcount) {
		this.playcount = playcount;
	}
	public Long getConcount() {
		return concount;
	}
	public void setConcount(Long concount) {
		this.concount = concount;
	}
	public String getAnchor() {
		return anchor;
	}
	public void setAnchor(String anchor) {
		this.anchor = anchor;
	}
	 
	 
	 
}
