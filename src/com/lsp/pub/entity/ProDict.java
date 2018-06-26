package com.lsp.pub.entity;

import com.mongodb.ReflectionDBObject;
/**
 * 资源管理
 * @author lsp 
 *   
 */
public class ProDict extends ReflectionDBObject{
	
	/**
	 * 层级 1 省 2 市 3 区县
	 */
	private int cj;
	/**
	 * 数据字典 简称
	 */
	private String jc;
	/**
	 * 字母
	 */
	private String zm;
	/**
	 * 数据字典 value
	 */
	private String value;
	/**
	 * 数据字典 value
	 */
	private String parentkey;

	/**
	 * 排序
	 */
	private int sort;

	public int getCj() {
		return cj;
	}

	public void setCj(int cj) {
		this.cj = cj;
	}

	public String getJc() {
		return jc;
	}

	public void setJc(String jc) {
		this.jc = jc;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getParentkey() {
		return parentkey;
	}

	public void setParentkey(String parentkey) {
		this.parentkey = parentkey;
	}

	public int getSort() {
		return sort;
	}

	public void setSort(int sort) {
		this.sort = sort;
	}

	public String getZm() {
		return zm;
	}

	public void setZm(String zm) {
		this.zm = zm;
	}
	
	
}