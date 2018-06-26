package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
 /**
  * 婚恋星级评分
  * @author lsp
  *
  */
public class DatingStar  extends ReflectionDBObject{
 
	 private String fromUserid;
	 private String custid;
	 private Date   createdate;
	 /**
	  * 星级
	  */
	 private int    star;
	 private String content;
	public String getFromUserid() {
		return fromUserid;
	}
	public void setFromUserid(String fromUserid) {
		this.fromUserid = fromUserid;
	}
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public int getStar() {
		return star;
	}
	public void setStar(int star) {
		this.star = star;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	 
}
