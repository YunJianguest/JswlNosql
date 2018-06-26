package com.lsp.suc.entity;

import java.util.Date;
import java.util.List;

import com.mongodb.ReflectionDBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
public class YhjJilu extends ReflectionDBObject{
	/**
	 * 标题
	 */															
	private int no;
	private String fromUser;
	private String jp;
	private String ys;
	private String picurl;
	private Date djenddate;
	/*
	 * 摘要
	 */															
	private int total;
	
	public String getFromUser() {
		return fromUser;
	}
	public void setFromUser(String fromUser) {
		this.fromUser = fromUser;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getJp() {
		return jp;
	}
	public void setJp(String jp) {
		this.jp = jp;
	}
	public String getYs() {
		return ys;
	}
	public void setYs(String ys) {
		this.ys = ys;
	}
	public Date getDjenddate() {
		return djenddate;
	}
	public void setDjenddate(Date djenddate) {
		this.djenddate = djenddate;
	}
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	
}
