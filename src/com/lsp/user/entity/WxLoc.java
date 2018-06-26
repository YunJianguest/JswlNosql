package com.lsp.user.entity;

import java.util.Date;
import java.util.List;

import com.mongodb.ReflectionDBObject;

/***
 * 位置管理
 * @author lsp
 *
 */
public class WxLoc extends ReflectionDBObject{
	/**
	 * 微信用户
	 */
	private String toUser;
	/**
	 * 微信用户
	 */
	private String fromUser;
	
	private String address;
	
	/**
	 * 经纬度，经度在前，纬度在后
	 */
	private List<Double> loc;
	private Long createdate;
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
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public List<Double> getLoc() {
		return loc;
	}
	public void setLoc(List<Double> loc) {
		this.loc = loc;
	}
	public Long getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Long createdate) {
		this.createdate = createdate;
	}
	
	
	
}
