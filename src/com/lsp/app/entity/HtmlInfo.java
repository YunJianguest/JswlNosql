package com.lsp.app.entity;

import com.mongodb.ReflectionDBObject;

/**
 * H5实体类
 * @author lsp
 *
 */
public class HtmlInfo extends ReflectionDBObject{

	private Integer sort;
	private Long  custid;
	private Long  toUser;
	
	
	private String title;
	private String url;
	private String picurl;


	public Integer getSort() {
		return sort;
	}


	public void setSort(Integer sort) {
		this.sort = sort;
	}


	public Long getCustid() {
		return custid;
	}


	public void setCustid(Long custid) {
		this.custid = custid;
	}


	public Long getToUser() {
		return toUser;
	}


	public void setToUser(Long toUser) {
		this.toUser = toUser;
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


	public String getPicurl() {
		return picurl;
	}


	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	
}
