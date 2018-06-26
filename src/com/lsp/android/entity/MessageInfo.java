package com.lsp.android.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * android消息管理
 * @author lsp
 *
 */
public class MessageInfo extends ReflectionDBObject{
     
	private String custid;
	private String fromUserid;
	private String picurl;
	private String title;
	private String summary;
	private String url;
	/**
	 * 0为公聊，1为私聊，2为个人提醒，3为管理员提醒
	 */
	private int    type;
	/**
	 * 类型（activity）
	 */
	private String lx;
	/**
	 * 状态0为未读，1为已读
	 */
	private String state;
	private Date   createdate;
	/**
	 * 阅读的用户ID
	 */
	private String readid;
	/**
	 * 店铺名称
	 */
	private String comname;
	/**
	 * 订单编号
	 */
	private String orderid;
	/**
	 * 商品名称
	 */
	private String protitle;
	/**
	 * 商品数量
	 */
	private String procount;
	/**
	 * 订单状态(0未支付，1已支付)
	 */
	private String prostate;
	 
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public String getFromUserid() {
		return fromUserid;
	}
	public void setFromUserid(String fromUserid) {
		this.fromUserid = fromUserid;
	}
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getLx() {
		return lx;
	}
	public void setLx(String lx) {
		this.lx = lx;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getReadid() {
		return readid;
	}
	public void setReadid(String readid) {
		this.readid = readid;
	}
	public String getComname() {
		return comname;
	}
	public void setComname(String comname) {
		this.comname = comname;
	}
	public String getOrderid() {
		return orderid;
	}
	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}
	public String getProtitle() {
		return protitle;
	}
	public void setProtitle(String protitle) {
		this.protitle = protitle;
	}
	public String getProcount() {
		return procount;
	}
	public void setProcount(String procount) {
		this.procount = procount;
	}
	public String getProstate() {
		return prostate;
	}
	public void setProstate(String prostate) {
		this.prostate = prostate;
	}
	
	 
}
