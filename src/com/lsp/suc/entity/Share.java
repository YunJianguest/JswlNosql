package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
public class Share extends ReflectionDBObject
{

	/**
	 * 分享标题
	 */															
	private String fxtitle ;
	/**
	 * 分享链接
	 */															
	private String fxurl ;
	/**
	 * 原链接地址
	 */															
	private String oldurl ;
	/**
	 * 分享描述
	 */															
	private String fxsummary ;
	
	private String toUser;
	private String fximg;
	private String fxtype;
	private Date insdate;
	private int fxmb;
	public String getFxtitle() {
		return fxtitle;
	}
	public void setFxtitle(String fxtitle) {
		this.fxtitle = fxtitle;
	}
	public String getFxurl() {
		return fxurl;
	}
	public void setFxurl(String fxurl) {
		this.fxurl = fxurl;
	}
	public String getFxsummary() {
		return fxsummary;
	}
	public void setFxsummary(String fxsummary) {
		this.fxsummary = fxsummary;
	}
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public String getFximg() {
		return fximg;
	}
	public void setFximg(String fximg) {
		this.fximg = fximg;
	}
	public Date getInsdate() {
		return insdate;
	}
	public void setInsdate(Date insdate) {
		this.insdate = insdate;
	}
	public String getFxtype() {
		return fxtype;
	}
	public void setFxtype(String fxtype) {
		this.fxtype = fxtype;
	}
	public String getOldurl() {
		return oldurl;
	}
	public void setOldurl(String oldurl) {
		this.oldurl = oldurl;
	}
	public int getFxmb() {
		return fxmb;
	}
	public void setFxmb(int fxmb) {
		this.fxmb = fxmb;
	}
}