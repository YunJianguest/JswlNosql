package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 签到摇奖（签到统计）
 * @author lsp
 *
 */
public class SignindrawTj extends ReflectionDBObject{

	private String custid;
	private String fromUserid;
	private Long   sid;
	private Date   createdate;
	/**
	 * 状态0未中奖，1中奖
	 */
	private int    state;
	private Date   zjdate;
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
	public Long getSid() {
		return sid;
	}
	public void setSid(Long sid) {
		this.sid = sid;
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
	public Date getZjdate() {
		return zjdate;
	}
	public void setZjdate(Date zjdate) {
		this.zjdate = zjdate;
	}
	
}
