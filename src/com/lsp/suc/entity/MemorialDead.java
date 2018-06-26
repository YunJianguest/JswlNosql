package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 祭奠逝者信息
 * @author lsp
 *
 */
public class MemorialDead extends ReflectionDBObject{

	private String custid;
	private String fromUserid;
	private String picurl;
	/**
	 * 祭奠id
	 */
	private Long   wid;
	/**
	 * 姓名
	 */
	private String name;
	/**
	 * 籍贯
	 */
	private String nativePlace;
	/**
	 * 职业
	 */
	private String professional;
	/**
	 * 与逝者关系
	 */
	private String relashipbetween;
	/**
	 * 出生地
	 */
	private String birthAddress;
	/**
	 * 安葬地
	 */
	private String burialAddress;
	private String summary;
	private Date   createdate;
	/**
	 * 生日
	 * @return
	 */
	private String  birthdate;
	/**
	 * 忌日
	 * @return
	 */
	private String  burialdate;
	private int   sort;
	
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
	public String getFromUserid() {
		return fromUserid;
	}
	public void setFromUserid(String fromUserid) {
		this.fromUserid = fromUserid;
	}
	public Long getWid() {
		return wid;
	}
	public void setWid(Long wid) {
		this.wid = wid;
	}
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNativePlace() {
		return nativePlace;
	}
	public void setNativePlace(String nativePlace) {
		this.nativePlace = nativePlace;
	}
	public String getProfessional() {
		return professional;
	}
	public void setProfessional(String professional) {
		this.professional = professional;
	}
	public String getRelashipbetween() {
		return relashipbetween;
	}
	public void setRelashipbetween(String relashipbetween) {
		this.relashipbetween = relashipbetween;
	}
	public String getBirthAddress() {
		return birthAddress;
	}
	public void setBirthAddress(String birthAddress) {
		this.birthAddress = birthAddress;
	}
	public String getBurialAddress() {
		return burialAddress;
	}
	public void setBurialAddress(String burialAddress) {
		this.burialAddress = burialAddress;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	 
	public String getBirthdate() {
		return birthdate;
	}
	public void setBirthdate(String birthdate) {
		this.birthdate = birthdate;
	}
	public String getBurialdate() {
		return burialdate;
	}
	public void setBurialdate(String burialdate) {
		this.burialdate = burialdate;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	 
	
	 
}
