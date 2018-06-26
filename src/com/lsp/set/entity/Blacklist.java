package com.lsp.set.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;

/**
 * 黑名单
 * @author lsp
 *
 */
public class Blacklist extends ReflectionDBObject{
 
	private String fromUserid;
	private String custid;
	private Date   createdate; 
	private String type;
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
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	
}
