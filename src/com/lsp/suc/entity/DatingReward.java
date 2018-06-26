package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 婚恋奖励机制
 * @author lsp
 *
 */
public class DatingReward extends ReflectionDBObject{

	private String custid;
	private String fromUserid;
	/**
	 * 0为分享奖励1为邀请奖励
	 */
	private int    type;
	/**
	 * 邀请奖励值
	 */
	private int    value;
	/**
	 * 最后奖励时间
	 */
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
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getValue() {
		return value;
	}
	public void setValue(int value) {
		this.value = value;
	} 
	
}
