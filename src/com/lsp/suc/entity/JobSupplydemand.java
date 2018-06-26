package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 房屋租赁
 * @author lsp
 *
 */
public class JobSupplydemand  extends ReflectionDBObject{

	private String custid;
	private String fromUserid;
	private String title;
	private String content;
	private String picurl;
	/**
	 * 联系电话
	 */
	private String tel;
	/**
	 * 联系人
	 */
	private String name;
	private String summary;
	private Date   createdate;
	/***
	 * 期望价格
	 */
	private int price;
	private int sort;
	/**
	 * 是否二手
	 * 
	 */
	private String issecond;
	/**
	 * 装修状况(精装，简装);
	 */
	private String decorate;
	/**
	 * 多少平方
	 */
	private String  big;
	/**
	 * 规格
	 */
	private String standard;
	/**
	 * 房屋地址
	 */
	private String address;
	/**
	 * 类型 0为供1为求
	 */
	private int lx;
	/**
	 * 房屋类型（洋楼，别墅）
	 */
	private String type; 
	/**
	 * 朝向
	 */
	private String  risingsun;
	/**
	 * 房龄
	 */
	private String  age;
	/**
	 * 楼层
	 */
	private String  floor;
	/**
	 * 产权
	 */
	private String  equity;
	
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	} 
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	 
	public String getFromUserid() {
		return fromUserid;
	}
	public int getLx() {
		return lx;
	}
	public void setLx(int lx) {
		this.lx = lx;
	}
	public void setFromUserid(String fromUserid) {
		this.fromUserid = fromUserid;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public String getIssecond() {
		return issecond;
	}
	public void setIssecond(String issecond) {
		this.issecond = issecond;
	}
	public String getDecorate() {
		return decorate;
	}
	public void setDecorate(String decorate) {
		this.decorate = decorate;
	}
	public String getBig() {
		return big;
	}
	public void setBig(String big) {
		this.big = big;
	}
	public String getStandard() {
		return standard;
	}
	public void setStandard(String standard) {
		this.standard = standard;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getRisingsun() {
		return risingsun;
	}
	public void setRisingsun(String risingsun) {
		this.risingsun = risingsun;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getFloor() {
		return floor;
	}
	public void setFloor(String floor) {
		this.floor = floor;
	}
	public String getEquity() {
		return equity;
	}
	public void setEquity(String equity) {
		this.equity = equity;
	}
	 
}
