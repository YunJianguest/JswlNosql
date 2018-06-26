package com.lsp.suc.entity;

import java.util.Date;
import java.util.List;

import com.mongodb.ReflectionDBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
public class WxRelation extends ReflectionDBObject{
	/**
	 * 微信用户
	 */
	private String toUser;
	/**
	 * 姓名
	 */
	private String name;
	/**
	 * 电话
	 */
	private String tel;
	/**
	 * 身份证
	 */
	private String sfz;
	/**
	 * 外键 fromUser
	 */
	private String wid;
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getSfz() {
		return sfz;
	}
	public void setSfz(String sfz) {
		this.sfz = sfz;
	}
	public String getWid() {
		return wid;
	}
	public void setWid(String wid) {
		this.wid = wid;
	}
	
	
	
}
