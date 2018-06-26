package com.lsp.user.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 用户登录记录
 * @author lsp
 *
 */
public class UserLoginDetail extends ReflectionDBObject{
	private String custid;
	private String fromUserid;
	private Date createdate;
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
	

}
