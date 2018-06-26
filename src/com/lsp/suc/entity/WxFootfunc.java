package com.lsp.suc.entity;

import com.mongodb.ReflectionDBObject;
/**
 * 底部菜单
 * @author lsp
 *
 */
public class WxFootfunc extends ReflectionDBObject {

	private String toUser;
	private String custid;
	private int sort;
	/**
	 * 父级菜单
	 */
	private Long parentid;
	/**
	 * 图标
	 */
	private String ioc;
	private String title;
	private String url;
	private String picurl;
	/**
	 * 类型
	 */
	private String type;
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
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
	public Long getParentid() {
		return parentid;
	}
	public void setParentid(Long parentid) {
		this.parentid = parentid;
	}
	 
	public String getIoc() {
		return ioc;
	}
	public void setIoc(String ioc) {
		this.ioc = ioc;
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
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	} 
	
	
}
