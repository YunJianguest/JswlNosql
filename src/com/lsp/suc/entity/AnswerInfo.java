package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;

/***
 * 答案
 * @author lsp
 *
 */
public class AnswerInfo  extends ReflectionDBObject{
	/**
	 * 图文消息标题
	 */
	private String title;
	
	/**
	 * 图片链接，支持JPG、PNG格式，较好的效果为大图640*320，小图80*80。  
	 */
	private String picurl;
	
	private Date createdate;
	/**
	 * 摘要
	 */															
	private String summary;
	/**
	 * 推理内容
	 */															
	private String context;
	/**
	 * 更多试题
	 */															
	private String moreurl;
	/**
	 * 0分提示
	 */															
	private String result0;
	
	/**
	 * 0分提示
	 */															
	private String result6;
	/**
	 * 0分提示
	 */															
	private String result7;
	/**
	 * 0分提示
	 */															
	private String result8;
	/**
	 * 95分提示
	 */															
	private String result9;
	/**
	 * 100分提示
	 */															
	private String result10;
	/**
	 * 参与频率 
	 *'0':'仅一次','1':'每日一次','2':'每日二次','3':'每日三次','4':'不限次数',99 停止
	 */
	private int rate;
	private Long comid;
	private String toUser;
	private int sort;
	private int mb;
	private int jf;
	/**
	 * 限制时间
	 */
	private Date limitdate;
	/**
	 * 出题数
	 */
	private int cts;
	/**
	 * 答题时间
	 */
	private int dtsj;

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
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
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
	
	public String getMoreurl() {
		return moreurl;
	}
	public void setMoreurl(String moreurl) {
		this.moreurl = moreurl;
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
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public String getResult0() {
		return result0;
	}
	public void setResult0(String result0) {
		this.result0 = result0;
	}
	
	public String getResult6() {
		return result6;
	}
	public void setResult6(String result6) {
		this.result6 = result6;
	}
	public String getResult7() {
		return result7;
	}
	public void setResult7(String result7) {
		this.result7 = result7;
	}
	public String getResult8() {
		return result8;
	}
	public void setResult8(String result8) {
		this.result8 = result8;
	}
	public String getResult9() {
		return result9;
	}
	public void setResult9(String result9) {
		this.result9 = result9;
	}
	public String getResult10() {
		return result10;
	}
	public void setResult10(String result10) {
		this.result10 = result10;
	}
	public int getMb() {
		return mb;
	}
	public void setMb(int mb) {
		this.mb = mb;
	}
	public int getJf() {
		return jf;
	}
	public void setJf(int jf) {
		this.jf = jf;
	}
	
	public int getRate() {
		return rate;
	}
	public void setRate(int rate) {
		this.rate = rate;
	}
	public int getCts() {
		return cts;
	}
	public void setCts(int cts) {
		this.cts = cts;
	}
	public int getDtsj() {
		return dtsj;
	}
	public void setDtsj(int dtsj) {
		this.dtsj = dtsj;
	}
	public Date getLimitdate() {
		return limitdate;
	}
	public void setLimitdate(Date limitdate) {
		this.limitdate = limitdate;
	}
	
	
}
