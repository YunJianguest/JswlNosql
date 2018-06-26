package com.lsp.website.entity;

import com.mongodb.ReflectionDBObject;

/**
 * 幻灯片实体类
 * 
 * @author lsp
 * 
 */
public class SlideInfo extends ReflectionDBObject {

	private Integer sort;
	private Long webid;
	/**
	 * 样式
	 */
	private Long styleId;
	/**
	 * 标题
	 */
	private String title;
	/**
	 * 
	 * 内容
	 */
	private String context;
	/**
	 * 链接
	 * 
	 */
	private String url;
	/**
	 *图片 
	 * @return
	 */
	private String picurl;

	 

	public String getContext() {
		return context;
	}

	public void setContext(String context) {
		this.context = context;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}
 
	public Long getStyleId() {
		return styleId;
	}

	public void setStyleId(Long styleId) {
		this.styleId = styleId;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

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

	public Long getWebid() {
		return webid;
	}

	public void setWebid(Long webid) {
		this.webid = webid;
	}
    
	 

}
