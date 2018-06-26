package com.lsp.suc.entity;


import java.util.Date;
import java.util.List;

import com.mongodb.ReflectionDBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
public class Preferential extends ReflectionDBObject{
	/**
	 * 标题
	 */															
	private String title;
	/**
	 * 标题
	 */															
	private String yhj;
	/**
	 * 背景颜色
	 */															
	private String ys;
	/*
	 * 摘要
	 */															
	private String summary;
	/*
	 * 抵扣金额
	 */															
	private int money;
	
	/**
	 * 说明
	 */															
	private String context;
	/**
	 * 图片地址
	 */
	private String picurl;

	private Date createdate;
	/**
	 * 活动开始日期
	 */
	private Date startdate;
	/**
	 * 活动结束日期
	 */
	private Date enddate;
	/**
	 * 兑奖结束日期
	 */
	private Date djenddate;
	/**
	 * 参与频率 
	 *'0':'仅一次','1':'每日一次','2':'每日二次','3':'每日三次','4':'不限次数'
	 */
	private int rate;
	
	/**
	 * 0 不限制  1 每日一次 2 每日二次
	 */
	private int djcs;

	private Long comid;
	private String toUser;
	private String startts;
	private String overts;
	private String cgts;
	private String lqwts;
	
	/**
	 * 模板
	 */
	private int mb;
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getYhj() {
		return yhj;
	}
	public void setYhj(String yhj) {
		this.yhj = yhj;
	}
	public String getYs() {
		return ys;
	}
	public void setYs(String ys) {
		this.ys = ys;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public int getMoney() {
		return money;
	}
	public void setMoney(int money) {
		this.money = money;
	}
	public String getContext() {
		return context;
	}
	public void setContext(String context) {
		this.context = context;
	}
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
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
	public Date getEnddate() {
		return enddate;
	}
	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}
	public Date getDjenddate() {
		return djenddate;
	}
	public void setDjenddate(Date djenddate) {
		this.djenddate = djenddate;
	}
	public int getRate() {
		return rate;
	}
	public void setRate(int rate) {
		this.rate = rate;
	}
	public int getDjcs() {
		return djcs;
	}
	public void setDjcs(int djcs) {
		this.djcs = djcs;
	}
	public Long getComid() {
		return comid;
	}
	public void setComid(Long comid) {
		this.comid = comid;
	}
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public String getStartts() {
		return startts;
	}
	public void setStartts(String startts) {
		this.startts = startts;
	}
	public String getOverts() {
		return overts;
	}
	public void setOverts(String overts) {
		this.overts = overts;
	}
	public String getCgts() {
		return cgts;
	}
	public void setCgts(String cgts) {
		this.cgts = cgts;
	}
	public String getLqwts() {
		return lqwts;
	}
	public void setLqwts(String lqwts) {
		this.lqwts = lqwts;
	}
	public int getMb() {
		return mb;
	}
	public void setMb(int mb) {
		this.mb = mb;
	}
	
	
}

