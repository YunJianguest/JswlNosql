package com.lsp.shop.entiy;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 支付订单
 * @author lsp
 *
 */
public class Paymentorder extends ReflectionDBObject{

	private String custid;
	private String fromUserid;
	private Long   comid;
	private Date   createdate;
	private Double price;
	private String title;
	/**
	 * 1为扫码支付2为购物车3为普遍支付
	 */
	private int    type;
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public String getFromUserid() {
		return fromUserid;
	}
	public void setFromUserid(String fromUserid) {
		this.fromUserid = fromUserid;
	}
	public Long getComid() {
		return comid;
	}
	public void setComid(Long comid) {
		this.comid = comid;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	
	
}
