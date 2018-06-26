package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 祭奠管理
 * @author lsp
 *
 */
public class MemorialInfo extends ReflectionDBObject{

	private String custid;
	private String fromUserid;
	private int    sort;
	/**
	 * 栏目ID
	 */
	private Long   wid;
	/**
	 * 祭奠名称
	 */
	private String title;
	/**
	 * 祭奠简介
	 */
	private String content;
	private String picurl;
	private String summary;
	/**
	 * 上香数
	 */
	private int    count;
	/**
	 * 类别（0单人，1双人，2多人）
	 */
	private int    type;
	private Date   createdate;
	/**
	 * 关注量
	 */
	private int    focuscount;
	/**
	 * 亲友量
	 */
	private int    relativescount;
	/**
	 * 评论量
	 */
	private int    comcount;
	/**
	 * 亲情值
	 */
	private int     familyValues;
	private int      mb;
	 
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public Long getWid() {
		return wid;
	}
	public void setWid(Long wid) {
		this.wid = wid;
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
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
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
	public int getFocuscount() {
		return focuscount;
	}
	public void setFocuscount(int focuscount) {
		this.focuscount = focuscount;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getRelativescount() {
		return relativescount;
	}
	public void setRelativescount(int relativescount) {
		this.relativescount = relativescount;
	}
	public int getComcount() {
		return comcount;
	}
	public void setComcount(int comcount) {
		this.comcount = comcount;
	}
	public int getFamilyValues() {
		return familyValues;
	}
	public void setFamilyValues(int familyValues) {
		this.familyValues = familyValues;
	}
	public int getMb() {
		return mb;
	}
	public void setMb(int mb) {
		this.mb = mb;
	}
	
	
}
