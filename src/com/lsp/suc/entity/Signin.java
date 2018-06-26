package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 签到管理
 * @author lsp
 *
 */
public class Signin extends ReflectionDBObject{

	private String custid;
	private String fromUserid;
	private int    contCount;
	private Date createdate; 
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
	public String getFromUserid() {
		return fromUserid;
	}
	public void setFromUserid(String fromUserid) {
		this.fromUserid = fromUserid;
	}
	public int getContCount() {
		return contCount;
	}
	public void setContCount(int contCount) {
		this.contCount = contCount;
	}
	 
	
	
}
