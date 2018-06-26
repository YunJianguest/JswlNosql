package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;


/***
 *  验证码
 * @author lsp
 *
 */
public class DrawboxYzm extends ReflectionDBObject{
	/**
	 * 参与活动id
	 */
	private Long wid;
	
	/**
	 * 用户id
	 */
	private String fromUser;
	
	/**
	 * 次数
	 */
	private int cs;
	/**
	 * 次数
	 */
	private int sycs;
	
	/**
	 * 用户id
	 */
	private Date insdate;

	public Long getWid() {
		return wid;
	}

	public void setWid(Long wid) {
		this.wid = wid;
	}

	public String getFromUser() {
		return fromUser;
	}

	public void setFromUser(String fromUser) {
		this.fromUser = fromUser;
	}
	public int getCs() {
		return cs;
	}

	public void setCs(int cs) {
		this.cs = cs;
	}

	public int getSycs() {
		return sycs;
	}

	public void setSycs(int sycs) {
		this.sycs = sycs;
	}

	public Date getInsdate() {
		return insdate;
	}

	public void setInsdate(Date insdate) {
		this.insdate = insdate;
	}
	
}
