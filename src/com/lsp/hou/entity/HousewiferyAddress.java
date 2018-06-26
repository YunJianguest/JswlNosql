package com.lsp.hou.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 地址
 * @author lsp
 *
 */
public class HousewiferyAddress extends ReflectionDBObject{

	private String custid; 
	/**
	 * 用户所在省份 
	 */
	private String province;
	/**
	 * 用户所在城市
	 */
	private String city;
	/**
	 * 县
	 */
	private String county;
	private String name;
	private String tel;
	private String address; 
	private Date createdate;
	private Date updatedate;
	/**
	 * 0为普通地址，1为默认地址
	 */
	private int  lx;
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getCounty() {
		return county;
	}
	public void setCounty(String county) {
		this.county = county;
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
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public Date getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(Date updatedate) {
		this.updatedate = updatedate;
	}
	public int getLx() {
		return lx;
	}
	public void setLx(int lx) {
		this.lx = lx;
	}
	
}
