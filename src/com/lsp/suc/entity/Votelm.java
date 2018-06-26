package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
public class Votelm extends ReflectionDBObject{

	private String toUser;
	private String custid;
	private Integer sort;
	private String title;
	private String content;
	private String summary;
	private String url;
	/**
	 * LOGO图
	 */
	private String picurl;
	/**
	 * 背景图
	 */
	private String bgcurl;
	private Date   createdate;
	private Date   enddate;
	private Date   startdate;
	/**
	 * 报名截止日期
	 */
	private Date   bmenddate;
	/**
	 * 未开始提示语
	 */
	private String startclues;
	/**
	 * 已结束提示语
	 */
	private String endclues;
	/**
	 * 频率
	 */
	private  int   frequency; 
	/**
	 * 模板
	 * @return
	 */
	private  int  mb;
	/**
	 * 奖品设置
	 * @return
	 */
	private String jpsz;
	public String getBgcurl() {
		return bgcurl;
	}
	public void setBgcurl(String bgcurl) {
		this.bgcurl = bgcurl;
	}
	public int getMb() {
		return mb;
	}
	public void setMb(int mb) {
		this.mb = mb;
	}
	public int getFrequency() {
		return frequency;
	}
	public void setFrequency(int frequency) {
		this.frequency = frequency;
	}
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public Integer getSort() {
		return sort;
	}
	public void setSort(Integer sort) {
		this.sort = sort;
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
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public Date getEnddate() {
		return enddate;
	}
	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}
	public Date getStartdate() {
		return startdate;
	} 
	public String getStartclues() {
		return startclues;
	}
	public void setStartclues(String startclues) {
		this.startclues = startclues;
	}
	public String getEndclues() {
		return endclues;
	}
	public void setEndclues(String endclues) {
		this.endclues = endclues;
	}
	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}
	public String getJpsz() {
		return jpsz;
	}
	public void setJpsz(String jpsz) {
		this.jpsz = jpsz;
	}
	public Date getBmenddate() {
		return bmenddate;
	}
	public void setBmenddate(Date bmenddate) {
		this.bmenddate = bmenddate;
	}
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
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
	
	
	
}
