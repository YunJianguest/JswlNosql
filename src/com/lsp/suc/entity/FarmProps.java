package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 农场道具
 * @author lsp
 *
 */
public class FarmProps extends ReflectionDBObject{

	private String custid;
	private String title;
	private String picurl;
	private String summary;
	/**
	 * 总成长值
	 */
	private int  growth;
	/**
	 * 魅力值
	 */
	private int  charm;
	/**
	 * 价格
	 */
	private double price;
	private int    sort;
	private Date   createdate;
	/**
	 * 最大使用次数（0为不限次数）
	 */
	private int    bigCount;
	private int    type;
	/**
	 * 库存
	 */
	private int    num;
	/**
	 * 售量
	 */
	private int    gmnum;
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
	public int getGrowth() {
		return growth;
	}
	public void setGrowth(int growth) {
		this.growth = growth;
	}  
	public int getCharm() {
		return charm;
	}
	public void setCharm(int charm) {
		this.charm = charm;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	public int getBigCount() {
		return bigCount;
	}
	public void setBigCount(int bigCount) {
		this.bigCount = bigCount;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getGmnum() {
		return gmnum;
	}
	public void setGmnum(int gmnum) {
		this.gmnum = gmnum;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	
}
