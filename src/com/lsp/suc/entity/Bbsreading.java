package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 论坛点赞
 * @author lsp
 *
 */
public class Bbsreading extends ReflectionDBObject{

	private Long bmtid;
	private Date createdate;
	
	private String toUser;
	private String fromUser;
	private String fromUserid;
	
	public Long getBmtid() {
		return bmtid;
	}
	public void setBmtid(Long bmtid) {
		this.bmtid = bmtid;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public String getFromUser() {
		return fromUser;
	}
	public void setFromUser(String fromUser) {
		this.fromUser = fromUser;
	}
	public String getFromUserid() {
		return fromUserid;
	}
	public void setFromUserid(String fromUserid) {
		this.fromUserid = fromUserid;
	}
	
}
