package com.lsp.parttime.entity;

import java.util.Date;

import org.bson.util.StringRangeSet;

import com.mongodb.ReflectionDBObject;
/**
 * 员工
 * @author lsp
 *
 */
public class Employee extends ReflectionDBObject{

	private String custid;
	private String fromid;
	private String tel;
	private String name;
	/**
	 * 学历
	 */
	private int education;
	/**
	 * 经验
	 */
	private int experience;
	private String idcard;
	private Date createdate;
	/**
	 * 备用手机号
	 */
	private String bytel;
	/**
	 * 微信ID
	 */
	private String wxid;
	/**
	 * 0为普通用户，1为管理员（只能查看手机号部分数据）2为超级管理员
	 */
	private int type;
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
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public int getEducation() {
		return education;
	}
	public void setEducation(int education) {
		this.education = education;
	}
	public int getExperience() {
		return experience;
	}
	public void setExperience(int experience) {
		this.experience = experience;
	}
	public String getIdcard() {
		return idcard;
	}
	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}
	public String getBytel() {
		return bytel;
	}
	public void setBytel(String bytel) {
		this.bytel = bytel;
	}
	public String getWxid() {
		return wxid;
	}
	public void setWxid(String wxid) {
		this.wxid = wxid;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	
}
