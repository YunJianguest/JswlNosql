package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;

/**
 * 
 * @author lsp
 *
 */
public class LawyerGoods extends ReflectionDBObject{

	 private String custid;
	 private String title;
	 private Long lid;
	 private String summary;
	 private String content;
	 private String picurl;
	 private int  sort;
	 private String url;
	 private Date createdate;
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
	 public String getPicurl() {
		return picurl;
	 }
	 public void setPicurl(String picurl) {
		this.picurl = picurl;
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
	 public Long getLid() {
		return lid;
	 }
	 public void setLid(Long lid) {
		this.lid = lid;
	 }
	 public String getUrl() {
		return url;
	 }
	 public void setUrl(String url) {
		this.url = url;
	 }
	 
}
