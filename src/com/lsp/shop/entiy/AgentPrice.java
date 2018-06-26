package com.lsp.shop.entiy;

import com.mongodb.ReflectionDBObject;
/**
 * 用户佣金
 * @author lsp
 *
 */
public class AgentPrice extends ReflectionDBObject{

	private String  fromUserid;
	private String  custid;
	private double  price;
	public String getFromUserid() {
		return fromUserid;
	}
	public void setFromUserid(String fromUserid) {
		this.fromUserid = fromUserid;
	}
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	
}
