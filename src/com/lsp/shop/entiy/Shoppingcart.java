package com.lsp.shop.entiy;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 购物车
 * @author lsp
 *
 */
public class Shoppingcart extends ReflectionDBObject{

	private String fromUser;
	private String toUser;
	private String fromUserid;
	private String custid;
	/**
	 * 规格
	 */
	private String spec;
	/**
	 * 商品编号
	 */
	private Long pid;
	/**
	 * 商品数量
	 */
	private int    count; 
	private Date   createdate;
	private int    state;
	private float  price;
	public String getFromUser() {
		return fromUser;
	}
	public void setFromUser(String fromUser) {
		this.fromUser = fromUser;
	}
	public Long getPid() {
		return pid;
	}
	public void setPid(Long pid) {
		this.pid = pid;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}  
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
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
	public String getSpec() {
		return spec;
	}
	public void setSpec(String spec) {
		this.spec = spec;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	
	
}
