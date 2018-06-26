package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 悬赏管理
 * @author lsp
 *
 */
public class Areward  extends ReflectionDBObject{

	private String fromUserid;
	private String toUserid;
	private String custid;
	private Date   createdate;
	private Long   bmtid;
	private Long   answerid;
	/**
	 * 1为悬赏结束0为悬赏开始
	 */
	private int    state;
	/**
	 * 悬赏金额
	 */
	private int    price;
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
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public Long getBmtid() {
		return bmtid;
	}
	public void setBmtid(Long bmtid) {
		this.bmtid = bmtid;
	}
	public Long getAnswerid() {
		return answerid;
	}
	public void setAnswerid(Long answerid) {
		this.answerid = answerid;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getToUserid() {
		return toUserid;
	}
	public void setToUserid(String toUserid) {
		this.toUserid = toUserid;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	
}
