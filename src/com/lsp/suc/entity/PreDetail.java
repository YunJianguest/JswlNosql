package com.lsp.suc.entity;

import com.mongodb.ReflectionDBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
public class PreDetail extends ReflectionDBObject{
	/**
	 * 外键
	 */															
	private Long wid;
	/*
	 * 优惠劵码
	 */															
	private String yhj;
	
	/**
	 * 领取人
	 */															
	private String fromUser;
	/**
	 * 状态 0 未领取  1 领取  2 已用
	 */															
	private int state;
	public Long getWid() {
		return wid;
	}
	public void setWid(Long wid) {
		this.wid = wid;
	}
	public String getYhj() {
		return yhj;
	}
	public void setYhj(String yhj) {
		this.yhj = yhj;
	}
	
	public String getFromUser() {
		return fromUser;
	}
	public void setFromUser(String fromUser) {
		this.fromUser = fromUser;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	
	
}
