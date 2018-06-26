package com.lsp.user.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 客户管理
 * @author lsp
 *
 */
public class CustomerInfo extends ReflectionDBObject{
	private String  custid;
	private String  toUser;
	private String  fromUser;
	private Integer sort;
	private Date    createdate;
	private Long    createcustid;
	/**
	 * 昵称
	 */
	private String  nickname;
	private String  picurl;
	/**
	 * 微信
	 */
	private String  wxid;
	private String  wxname;
	/**
	 * QQ
	 */
	private String  qqid;
	private String  qqname;
	private String  tel;
	private String  sex;
	private String  address;
	/**
	 * 公司
	 */
	private String  company;
	private Long    comid;
	
	private Long    friendsid;
	private String  friendsname;
	
	private String  password;
	private String  loginname;
	private Long  roleid;
	private String  custname;
	private Date  startdate;
	private Date  enddate;
	private String remark;
	
	public String getLoginname() {
		return loginname;
	}
	public void setLoginname(String loginname) {
		this.loginname = loginname;
	}
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
	public Integer getSort() {
		return sort;
	}
	public void setSort(Integer sort) {
		this.sort = sort;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public Long getCreatecustid() {
		return createcustid;
	}
	public void setCreatecustid(Long createcustid) {
		this.createcustid = createcustid;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	public String getWxid() {
		return wxid;
	}
	public void setWxid(String wxid) {
		this.wxid = wxid;
	}
	public String getWxname() {
		return wxname;
	}
	public void setWxname(String wxname) {
		this.wxname = wxname;
	}
	public String getQqid() {
		return qqid;
	}
	public void setQqid(String qqid) {
		this.qqid = qqid;
	}
	public String getQqname() {
		return qqname;
	}
	public void setQqname(String qqname) {
		this.qqname = qqname;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public Long getComid() {
		return comid;
	}
	public void setComid(Long comid) {
		this.comid = comid;
	}
	public Long getFriendsid() {
		return friendsid;
	}
	public void setFriendsid(Long friendsid) {
		this.friendsid = friendsid;
	}
	public String getFriendsname() {
		return friendsname;
	}
	public void setFriendsname(String friendsname) {
		this.friendsname = friendsname;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Long getRoleid() {
		return roleid;
	}
	public void setRoleid(Long roleid) {
		this.roleid = roleid;
	}
	public String getCustname() {
		return custname;
	}
	public void setCustname(String custname) {
		this.custname = custname;
	}
	public Date getStartdate() {
		return startdate;
	}
	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}
	public Date getEnddate() {
		return enddate;
	}
	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	

}
