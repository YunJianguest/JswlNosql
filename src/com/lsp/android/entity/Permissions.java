package com.lsp.android.entity;

import com.mongodb.ReflectionDBObject;
/**
 * android权限管理
 * @author lsp
 *
 */
public class Permissions extends ReflectionDBObject{
     
	private String title;
	private int sort; 
	private String ioc;
	private String color;
	private String type;
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public String getIoc() {
		return ioc;
	}
	public void setIoc(String ioc) {
		this.ioc = ioc;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	 
	
}
