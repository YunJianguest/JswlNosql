package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 婚恋客服小号
 * @author lsp
 *
 */
public class DatingServiceTrumpet extends ReflectionDBObject{

	private String custid;
	private String fromUserid;
	private String parent;
	private Date   createdate;
	private Date   endupdate;
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
	public String getParent() {
		return parent;
	}
	public void setParent(String parent) {
		this.parent = parent;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public Date getEndupdate() {
		return endupdate;
	}
	public void setEndupdate(Date endupdate) {
		this.endupdate = endupdate;
	}
	  
	 
}
