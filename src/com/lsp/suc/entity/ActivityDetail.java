package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/***
 * 活动记录
 * @author lsp
 *
 */
public class ActivityDetail extends ReflectionDBObject{

	 private String fromUserid;  
	 private String ydid;
	 private float kjprice;
	 private Date   createdate;
	public String getFromUserid() {
		return fromUserid;
	}
	public void setFromUserid(String fromUserid) {
		this.fromUserid = fromUserid;
	}
	public String getYdid() {
		return ydid;
	}
	public void setYdid(String ydid) {
		this.ydid = ydid;
	}
	public float getKjprice() {
		return kjprice;
	}
	public void setKjprice(float kjprice) {
		this.kjprice = kjprice;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	 
}
