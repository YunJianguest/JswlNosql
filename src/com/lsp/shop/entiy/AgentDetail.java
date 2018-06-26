package com.lsp.shop.entiy;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 代理销售明细
 * @author lsp
 *
 */
public class AgentDetail extends ReflectionDBObject {

	/**
	 * 代理ID
	 */
	 private String wid;
	 private String fromUserid;
	 /**
	  * 订单ID
	  */
	 private String oid;
	 /**
	  * 提成金额
	  */
	 private double price;
	 /**
	  * 1为收入，2为支出
	  */
	 private int    type; 
	 private Date   createdate; 
	public String getWid() {
		return wid;
	}
	public void setWid(String wid) {
		this.wid = wid;
	}
	public String getOid() {
		return oid;
	}
	public void setOid(String oid) {
		this.oid = oid;
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
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getFromUserid() {
		return fromUserid;
	}
	public void setFromUserid(String fromUserid) {
		this.fromUserid = fromUserid;
	} 
	 
}
