package com.lsp.app.entity;

import com.mongodb.ReflectionDBObject;
/**
 * H5元素实体类
 * @author lsp
 *
 */
public class HelementInfo extends ReflectionDBObject{

	private Integer sort;
	private Long  Lid;
	private Long  styleId;
	
	private String title;
	private String summary;
	private String picurl;
	 
	
	private String url;


	public Integer getSort() {
		return sort;
	}


	public void setSort(Integer sort) {
		this.sort = sort;
	}


	public Long getLid() {
		return Lid;
	}


	public void setLid(Long lid) {
		Lid = lid;
	}


	public Long getStyleId() {
		return styleId;
	}


	public void setStyleId(Long styleId) {
		this.styleId = styleId;
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


	public String getUrl() {
		return url;
	}


	public void setUrl(String url) {
		this.url = url;
	}
	
}
