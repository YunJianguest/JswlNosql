package com.lsp.website.entity;

import com.mongodb.ReflectionDBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
public class Promotelink extends ReflectionDBObject {

	private Integer sort;
	private Long webid;
	/**
	 * 父级关联ID
	 */
	private Long parentid;
	/**
	 * 样式
	 */
	private Long styleId;
	/**
	 * 标题
	 */
	private String title;
	/**
	 * 图片
	 */
	private String picurl;
	/**
	 * 链接
	 * 
	 */
	private String url;
	public Integer getSort() {
		return sort;
	}
	public void setSort(Integer sort) {
		this.sort = sort;
	}
	 
	public Long getWebid() {
		return webid;
	}
	public void setWebid(Long webid) {
		this.webid = webid;
	}
	public Long getParentid() {
		return parentid;
	}
	public void setParentid(Long parentid) {
		this.parentid = parentid;
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
