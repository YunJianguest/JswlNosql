package com.lsp.suc.entity;

import java.util.Date;
import java.util.List;

import com.mongodb.ReflectionDBObject;

/***
 * 旅游管理
 * @author lsp
 *
 */
public class Tourism  extends ReflectionDBObject{
	/**
	 * 标题
	 */
	private String title;
	
	/**
	 * 图片链接，支持JPG、PNG格式，较好的效果为大图640*320，小图80*80。  
	 */
	private String picurl;
	private String tel;
	private List<Double> loc;
	private Date insdate;
	/**
	 * 摘要
	 */															
	private String summary;
	/**
	 * 内容
	 */															
	private String context;
	private String toUser; 
	private Integer sort;
	
	private Long  ydl;
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
	public Date getInsdate() {
		return insdate;
	}
	public void setInsdate(Date insdate) {
		this.insdate = insdate;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public String getContext() {
		return context;
	}
	public void setContext(String context) {
		this.context = context;
	}
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	} 
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public List<Double> getLoc() {
		return loc;
	}
	public void setLoc(List<Double> loc) {
		this.loc = loc;
	}
	public Integer getSort() {
		return sort;
	}
	public void setSort(Integer sort) {
		this.sort = sort;
	}
	public Long getYdl() {
		return ydl;
	}
	public void setYdl(Long ydl) {
		this.ydl = ydl;
	}
	
	
}
