package com.lsp.suc.entity;

import com.mongodb.ReflectionDBObject;
/**
 * 论坛分类
 * @author lsp
 *
 */
public class Bbstypeinfo extends ReflectionDBObject{
	private String  toUser;
	private String  custid;
	private int     sort;
	/**
	 * 名称
	 */
	private String  title;
	/**
	 * LOGO
	 */
	private String  picurl;
	/**
	 * 连接
	 */
	private String  url;
	/**
	 * 类型
	 */
	private String  type;
	/**
	 * 图标
	 */
	private String  logo;
	/**
	 * 模板
	 */
	private int     mb;
	
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
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getLogo() {
		return logo;
	}
	public void setLogo(String logo) {
		this.logo = logo;
	}
	public int getMb() {
		return mb;
	}
	public void setMb(int mb) {
		this.mb = mb;
	}
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	


}
