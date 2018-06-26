package com.lsp.suc.vivo.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;

public class DjCode  extends ReflectionDBObject{

	/**
	 * 创建者
	 */
	private String custid;
	/**
	 * 使用者
	 */
	private String fromid;
	/**
	 * 串码
	 */
	private String code;
	/**
	 * 0正常，1已使用
	 */
	private int  state;
	/**
	 * 创建时间
	 */
	private Date createdate;
	/**
	 * 兑换时间
	 */
	private Date djdate;
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
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
	public Date getDjdate() {
		return djdate;
	}
	public void setDjdate(Date djdate) {
		this.djdate = djdate;
	}
	
}
