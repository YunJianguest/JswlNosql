package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/***
 * 活动卡卷
 * @author lsp
 *
 */
public class ActivityCard extends ReflectionDBObject{ 
	private String fromUserid; 
	private String custid;  
	/**
	 * 日期
	 */															
	private Date createdate; 
	/**
	 * 状态
	 * 0 未对 1 已对 2 过期
	 */	
	private int state; 
	/**
	 * 活动id
	 */	
	private Long hdid; 
	/**
	 * 奖品唯一兑换码
	 */	
	private String yhj; 
	/**
	 * 奖品
	 */	
	private String jp;
	
	/**
	 * 兑奖截止日期
	 */	
	private Date djenddate;
	/**
	 * 活动名称
	 * @return
	 */
	private String hdtitle;
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
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public Long getHdid() {
		return hdid;
	}
	public void setHdid(Long hdid) {
		this.hdid = hdid;
	}
	public String getYhj() {
		return yhj;
	}
	public void setYhj(String yhj) {
		this.yhj = yhj;
	}
	public String getJp() {
		return jp;
	}
	public void setJp(String jp) {
		this.jp = jp;
	}
	public Date getDjenddate() {
		return djenddate;
	}
	public void setDjenddate(Date djenddate) {
		this.djenddate = djenddate;
	}
	public String getHdtitle() {
		return hdtitle;
	}
	public void setHdtitle(String hdtitle) {
		this.hdtitle = hdtitle;
	}
	
	
}
