package com.lsp.website.entity;

import com.mongodb.ReflectionDBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
public class Websitegrapgh  extends ReflectionDBObject {


	private String toUser;
	private Integer sort; 
	
	private Long   webid;
	private Long   parentid;
	 
	/**
	 * 标题
	 */
	private String title;
	/**
	 * 
	 * 内容
	 */
	private String content;
	/**
	 * 链接
	 * 
	 */
	private String url;
	private String type;
	private String coding;
	
	/**
	 *图片 
	 * @return
	 */
	private String picurl;
	/**
	 * 是否首页显示0不显示/1显示
	 */
	private String state;
	/**
	 * 图片位置0左图1右图
	 * @return
	 */
	private String position;
	 
	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}
   
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getToUser() {
		return toUser;
	}

	public void setToUser(String toUser) {
		this.toUser = toUser;
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

	public String getPicurl() {
		return picurl;
	}

	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getCoding() {
		return coding;
	}

	public void setCoding(String coding) {
		this.coding = coding;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}
 
	
}
