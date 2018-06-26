package com.lsp.shop.entiy;

import com.mongodb.ReflectionDBObject;
/**
 * 商品规格
 * @author lsp
 *
 */
public class Specification extends ReflectionDBObject{

	private String  title;
	private String  custid;
	private Long  parentid;
	private float   price;
	private String  sort;
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	} 
	public Long getParentid() {
		return parentid;
	}
	public void setParentid(Long parentid) {
		this.parentid = parentid;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	
}
