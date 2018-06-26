package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 奖品结果
 * @author lsp
 *
 */
public class RewardRecord extends ReflectionDBObject{

	/**
	 * 姓名
	 */															
	private String name;

	/**
	 * 日期
	 */															
	private Date insDate;
	private String fromUser;
	private String fromUserid;
	private String toUser;
	private String custid;
	/**
	 * 状态
	 * 0 未对 1 已对 2 过期
	 */	
	private int state;
	
	/**
	 * 活动类型  1 大转盘 2砍价活动
	 */	
	private int lx;
	/**
	 * 兑奖卷颜色
	 */	
	private String ys;
	/**
	 * 背景图片
	 */	
	private String picurl;
	/**
	 * 链接地址
	 */	
	private String url;
	/**
	 * 活动id
	 */	
	private Long hdid;
	
	/**
	 * 奖品no
	 */	
	private Integer no;
	/**
	 * 奖品唯一兑换码
	 */	
	private String yhj;
	private int money;
	/**
	 * 奖品
	 */	
	private String jp;
	
	/**
	 * 兑奖截止日期
	 */	
	private Date djenddate;
	/**
	 * 活动名称
	 * @return
	 */
	private String hdtitle;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	

	public Date getInsDate() {
		return insDate;
	}

	public void setInsDate(Date insDate) {
		this.insDate = insDate;
	}

	public String getFromUser() {
		return fromUser;
	}

	public void setFromUser(String fromUser) {
		this.fromUser = fromUser;
	}

	public String getToUser() {
		return toUser;
	}

	public void setToUser(String toUser) {
		this.toUser = toUser;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public Long getHdid() {
		return hdid;
	}

	public void setHdid(Long hdid) {
		this.hdid = hdid;
	}

	public Integer getNo() {
		return no;
	}

	public void setNo(Integer no) {
		this.no = no;
	}

	public String getJp() {
		return jp;
	}

	public void setJp(String jp) {
		this.jp = jp;
	}

	public Date getDjenddate() {
		return djenddate;
	}

	public void setDjenddate(Date djenddate) {
		this.djenddate = djenddate;
	}

	public String getYhj() {
		return yhj;
	}

	public void setYhj(String yhj) {
		this.yhj = yhj;
	}

	

	public int getLx() {
		return lx;
	}

	public void setLx(int lx) {
		this.lx = lx;
	}

	public String getYs() {
		return ys;
	}

	public void setYs(String ys) {
		this.ys = ys;
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

	public int getMoney() {
		return money;
	}

	public void setMoney(int money) {
		this.money = money;
	}

	public String getFromUserid() {
		return fromUserid;
	}

	public void setFromUserid(String fromUserid) {
		this.fromUserid = fromUserid;
	}

	public String getCustid() {
		return custid;
	}

	public void setCustid(String custid) {
		this.custid = custid;
	}

	public String getHdtitle() {
		return hdtitle;
	}

	public void setHdtitle(String hdtitle) {
		this.hdtitle = hdtitle;
	}
 	
}
