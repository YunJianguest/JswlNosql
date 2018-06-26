package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
 /**
  * 婚恋会员
  * @author lsp
  *
  */
public class DatingMember  extends ReflectionDBObject{
 
	private String custid;
	private String fromUserid;
	private Date   createdate;
	/**
	 * 开始时间
	 */
	private Date   startdate;
	/**
	 * 结束时间
	 */
	private Date   enddate;
	/**
	 * 消费金额
	 */
	private double money;
	/**
	 * 备注
	 * @return
	 */
	private String content;
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
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public Date getStartdate() {
		return startdate;
	}
	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}
	public Date getEnddate() {
		return enddate;
	}
	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}
	public double getMoney() {
		return money;
	}
	public void setMoney(double money) {
		this.money = money;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
}
