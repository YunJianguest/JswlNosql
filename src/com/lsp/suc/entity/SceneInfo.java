package com.lsp.suc.entity;

import com.mongodb.ReflectionDBObject;

/**
 * 场景
 * @author lsp
 *
 */
public class SceneInfo extends ReflectionDBObject{

	private String  toUser;
	private int     sort;
	//移动场景ID
	private Long    msid;
	private String  title;
	private String  picurl;
	private String  summary;
	private String  bg;
	private String  url;
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
	public Long getMsid() {
		return msid;
	}
	public void setMsid(Long msid) {
		this.msid = msid;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public String getBg() {
		return bg;
	}
	public void setBg(String bg) {
		this.bg = bg;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	
}
