package com.lsp.shop.entiy;

import java.util.Date;

import com.mongodb.ReflectionDBObject;

/***
 * 商品分类
 * @author lsp
 *
 */
public class WxPay  extends ReflectionDBObject{
	/**
	 * 菜单名称
	 */
	private String fromUser;
	
	private String name;
	private String toUser;
	private float price;
	private Date insdate;
	private String spbill_create_ip;
	
	public String getFromUser() {
		return fromUser;
	}
	public void setFromUser(String fromUser) {
		this.fromUser = fromUser;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public Date getInsdate() {
		return insdate;
	}
	public void setInsdate(Date insdate) {
		this.insdate = insdate;
	}
	public String getSpbill_create_ip() {
		return spbill_create_ip;
	}
	public void setSpbill_create_ip(String spbill_create_ip) {
		this.spbill_create_ip = spbill_create_ip;
	}
	
}
