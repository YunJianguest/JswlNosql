package com.lsp.suc.entity;

import java.util.Date;
import java.util.List;

import com.mongodb.ReflectionDBObject;

/***
 * 资源管理
 * @author lsp
 *
 */
public class VoteInfo extends ReflectionDBObject{
	/**
	 * 标题
	 */															
	private String title;
	
	private String picurl;
	private String bgurl;
	private String tel;
	private String url;
 
	/**
	 * 图片是否显示，1停止投票  0显示
	 */
	private int stop;
	private String type;
	private String custid;
	private String toUser;
	private int sort;
	private int count;
	private Long voteid;
	private String summary;
	private Date createdate;
	private String context;
	private String fromUserid;
	
	//助力果农
	/**
	 * 苹果品种
	 * @return
	 */
	private String varieties;
	/**
	 * 产量
	 */
	private String production;
	/**
	 * 产区
	 */
	private String region;
	/**
	 * 销售价格
	 */
	private String price;
	
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
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
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
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public Long getVoteid() {
		return voteid;
	}
	public void setVoteid(Long voteid) {
		this.voteid = voteid;
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
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
 
	public int getStop() {
		return stop;
	}
	public void setStop(int stop) {
		this.stop = stop;
	}
	public String getBgurl() {
		return bgurl;
	}
	public void setBgurl(String bgurl) {
		this.bgurl = bgurl;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getFromUserid() {
		return fromUserid;
	}
	public void setFromUserid(String fromUserid) {
		this.fromUserid = fromUserid;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getVarieties() {
		return varieties;
	}
	public void setVarieties(String varieties) {
		this.varieties = varieties;
	}
	public String getProduction() {
		return production;
	}
	public void setProduction(String production) {
		this.production = production;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	
	
}
