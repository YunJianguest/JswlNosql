package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/***
 * 活动内容
 * @author lsp
 *
 */
public class ActivityInfo extends ReflectionDBObject{
	
	private String  custid;
	private String  title;
	private String  picurl;
	private String  url;
	/**
	 * 库存
	 */															
	private int num;
	/**
	 * 参与量
	 */															
	private int gmnum;
	/**
	 * 价格
	 */															
	private Double price;
	/**
	 * 最低价
	 */
	private Double   lowprice;
	/**
	 * 摘要
	 */															
	private String summary;
	/**
	 * 描述
	 */															
	private String content;
	/**
	 * 类型
	 */
	private int type;
	/**
	 * 参团人数
	 */
	private int     pcount;
	/**
	 * 是否显示0为显示，1为不显示
	 */
	private int      isxs;
	/**
	 * 积分兑换
	 */
	private float    jfdh;
	/**
	 * 积分参与
	 */
	private float    jfcy;
	private Date     createdate;
	private Date     startdate;
	private Date     endedate;
	private Date     djenddate;
	private int      sort;
	
	/**
	 * 兑奖二维码
	 * @return
	 */
	private String  ewmurl;
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
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
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
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public Double getLowprice() {
		return lowprice;
	}
	public void setLowprice(Double lowprice) {
		this.lowprice = lowprice;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getPcount() {
		return pcount;
	}
	public void setPcount(int pcount) {
		this.pcount = pcount;
	}
	public int getIsxs() {
		return isxs;
	}
	public void setIsxs(int isxs) {
		this.isxs = isxs;
	}
	public float getJfdh() {
		return jfdh;
	}
	public void setJfdh(float jfdh) {
		this.jfdh = jfdh;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public Date getStartdate() {
		return startdate;
	}
	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}
	public Date getEndedate() {
		return endedate;
	}
	public void setEndedate(Date endedate) {
		this.endedate = endedate;
	}
	public Date getDjenddate() {
		return djenddate;
	}
	public void setDjenddate(Date djenddate) {
		this.djenddate = djenddate;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public float getJfcy() {
		return jfcy;
	}
	public void setJfcy(float jfcy) {
		this.jfcy = jfcy;
	}
	public String getEwmurl() {
		return ewmurl;
	}
	public void setEwmurl(String ewmurl) {
		this.ewmurl = ewmurl;
	}
	 
	
}
