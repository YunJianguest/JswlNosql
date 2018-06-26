package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
 /**
  * 婚恋订单
  * @author lsp
  *
  */
public class DatingOrder  extends ReflectionDBObject{
 
	 private String fromUserid;
	 private String custid;
	 private Date   createdate;
	 private double money;
	 private String content;
	 /**
	  * 0未支付1支付成功
	  */
	 private int    state;
	 /**
	  * 0金币充值1会员充值
	  */
	 private int    type;
	 /**
	  * 会员充值时间（单位天）
	  */
	 private int    time;
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
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getTime() {
		return time;
	}
	public void setTime(int time) {
		this.time = time;
	}
 	
}
