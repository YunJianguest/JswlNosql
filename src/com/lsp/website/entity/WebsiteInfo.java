package com.lsp.website.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 网站实体类
 * @author lsp
 *
 */
public class WebsiteInfo  extends ReflectionDBObject {


	  private Integer sort;
	  private Long custId;
	  private String toUser;
	  private Long comId;
	  
	  /**
	   * 名称
	   */
	  private String title;
	  /**
	   * 访问链接
	   */
	  private String url;
	  /**
	   * 幻灯片ID
	   */
	  private Long slideId;
	  /**
	   * 导航条ID
	   */
	  private Long navigationId;
	 
	  /**
	   * 网站主体
	   */
	  private String body;
	  private String foot;
	  private Date   createdate;
	  private String picurl;
	  
	  private Integer mb;
	public Integer getSort() {
		return sort;
	}
	public void setSort(Integer sort) {
		this.sort = sort;
	}
	 
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	 
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}
	public String getFoot() {
		return foot;
	}
	public void setFoot(String foot) {
		this.foot = foot;
	}
	public Long getCustId() {
		return custId;
	}
	public void setCustId(Long custId) {
		this.custId = custId;
	}
	public Long getComId() {
		return comId;
	}
	public void setComId(Long comId) {
		this.comId = comId;
	}
	public Long getSlideId() {
		return slideId;
	}
	public void setSlideId(Long slideId) {
		this.slideId = slideId;
	}
	public Long getNavigationId() {
		return navigationId;
	}
	public void setNavigationId(Long navigationId) {
		this.navigationId = navigationId;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public Integer getMb() {
		return mb;
	}
	public void setMb(Integer mb) {
		this.mb = mb;
	}
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	 
	 
	  
}
