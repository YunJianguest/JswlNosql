package com.lsp.android.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * android权限管理详情
 * @author lsp
 *
 */
public class PermissionsIn extends ReflectionDBObject{

	private String custid;
	private String fromUserid;
	private Long   wid; 
	private Date   createdate;
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
	public Long getWid() {
		return wid;
	}
	public void setWid(Long wid) {
		this.wid = wid;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	} 
	
}
