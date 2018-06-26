package com.lsp.set.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 价格管理
 * @author lsp
 *
 */
public class Price  extends ReflectionDBObject{

	private String custid;
	private String title;
	private String type;
	private double price;
	private Date   createdate;
	private int    sort;
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
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
	
	
}
