package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 产品成长详情
 * @author lsp
 *
 */
public class FarmYdDetail extends ReflectionDBObject{

	private String custid;
	private String fromUserid;
	private String ydid;
	/**
	 * 成长值
	 */
	private int    growth;
	/**
	 * 道具ID
	 */
	private Long   cid;
	private Date   createdate;
	/**
	 * 0为已支付1为未支付
	 */
	private int    state;
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
	public String getYdid() {
		return ydid;
	}
	public void setYdid(String ydid) {
		this.ydid = ydid;
	}
	public int getGrowth() {
		return growth;
	}
	public void setGrowth(int growth) {
		this.growth = growth;
	}
	public Long getCid() {
		return cid;
	}
	public void setCid(Long cid) {
		this.cid = cid;
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
	
}
