package com.lsp.weixin.entity;

import com.mongodb.ReflectionDBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
public class WxMenu extends ReflectionDBObject{
	/**
	 * 一级菜单
	 */
	private String name;
	/**
	 * 类型
	 */
	private String type;
	
	private String key;
	/**
	 * 排序
	 */
	private int sort;
	private Long parentid;
	private String custid;
	private String toUser;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
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
	public Long getParentid() {
		return parentid;
	}
	public void setParentid(Long parentid) {
		this.parentid = parentid;
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

	
}

