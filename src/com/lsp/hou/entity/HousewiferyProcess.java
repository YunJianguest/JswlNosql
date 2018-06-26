package com.lsp.hou.entity;

import com.mongodb.ReflectionDBObject;
/**
 * 服务流程
 * @author lsp
 *
 */
public class HousewiferyProcess extends ReflectionDBObject{

	private String custid;
	private String title;
	private String font;
	private String picurl;
	private String url;
	private int sort;
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getFont() {
		return font;
	}
	public void setFont(String font) {
		this.font = font;
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
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	
	
}
