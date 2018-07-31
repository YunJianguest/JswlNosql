package com.lsp.suc.entity;
 

import com.mongodb.ReflectionDBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
public class WxFunc extends ReflectionDBObject{
	/**
	 * 菜单名称
	 */
	private String name;
	/**
	 * 标记
	 */
	private String key;
	
	/**
	 * 类型
	 */
	private String type;
	/**
	 * 图片
	 */
	private String picurl;
	/**
	 * 图标
	 */
	private String tb;
	/**
	 * 链接地址
	 */
	private String url;
	/**
	 * 管理地址
	 */
	private String adminurl;
	/**
	 * 是否显示  0 显示  1主页菜单不显示  2 菜单不显示 3 都不显示
	 */
	private int xs;
	/**
	 * 模板
	 */
	private int mb;
	/**
	 * 排序
	 */
	private int sort;
	
	private String custid;
	private String toUser;
	private String summary;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	public int getMb() {
		return mb;
	}
	public void setMb(int mb) {
		this.mb = mb;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	
	public String getAdminurl() {
		return adminurl;
	}
	public void setAdminurl(String adminurl) {
		this.adminurl = adminurl;
	}
	public int getXs() {
		return xs;
	}
	public void setXs(int xs) {
		this.xs = xs;
	}
	public String getTb() {
		return tb;
	}
	public void setTb(String tb) {
		this.tb = tb;
	}
	
	
}

