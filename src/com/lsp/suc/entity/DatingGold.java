package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
 /**
  * 婚恋金币记录
  * @author lsp
  *
  */
public class DatingGold  extends ReflectionDBObject{
 
	 private String custid;
	 private String fromUserid;
	 private Date   createdate;
	 private double money;
	 /**
	  * 0增加1消费
	  */
	 private int    type;
	 /**
	  * 备注
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
	public double getMoney() {
		return money;
	}
	public void setMoney(double money) {
		this.money = money;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	 
}
