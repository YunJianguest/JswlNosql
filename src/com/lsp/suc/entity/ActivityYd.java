package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/***
 * 活动预定
 * @author lsp
 *
 */
public class ActivityYd extends ReflectionDBObject{

	private String  custid;
	private String  fromUserid;  
	private Date    createdate;
	private Long    wid;
	private ActivityInfo  obj;
	/**
	 * 0未兑换，1已兑换
	 */
	private int     state;
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
	 
	public Long getWid() {
		return wid;
	}
	public void setWid(Long wid) {
		this.wid = wid;
	}
	public ActivityInfo getObj() {
		return obj;
	}
	public void setObj(ActivityInfo obj) {
		this.obj = obj;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	
	
}
