package com.lsp.parttime.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 通知
 * @author lsp
 *
 */
public class MissionInform extends ReflectionDBObject{

	private String custid;
	private String fromid; 
	/**
	 * 0未读1已读
	 */
	private int state;
	private Date createdate;
	private String title;
	/**
	 * 0为系统消息1为岗位提醒如（岗位申请和发布）2提现提醒（订单）
	 */
	private int type;
	private String content;
	/**
	 * 提现ID；
	 */
	private String tid;
	/**
	 * 订单id
	 */
	private String oid;
	/**
	 * 岗位id
	 */
	private Long mid;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public String getOid() {
		return oid;
	}
	public void setOid(String oid) {
		this.oid = oid;
	}
	public Long getMid() {
		return mid;
	}
	public void setMid(Long mid) {
		this.mid = mid;
	}
	
 
}
