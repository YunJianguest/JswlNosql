package com.lsp.hou.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 保洁员
 * @author lsp
 *
 */
public class HousewiferyInfo extends ReflectionDBObject{

	private String custid;
	private String name;
	private String tel;
	private String picurl;
	/**
	 * 0为空闲1为忙碌
	 */
	private int  state;
	private Date createdate;
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
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
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
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
	
}
