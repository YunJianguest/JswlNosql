package com.lsp.parttime.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 推广
 * @author lsp
 *
 */
public class MissionPromote extends ReflectionDBObject{

	private String custid;
	private String fromid;
	private String tgid;
	/**
	 * 0未结算，1已结算
	 */
	private int  state;
	private Date createdate;
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public String getFromid() {
		return fromid;
	}
	public void setFromid(String fromid) {
		this.fromid = fromid;
	}
	public String getTgid() {
		return tgid;
	}
	public void setTgid(String tgid) {
		this.tgid = tgid;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	 
 
}
