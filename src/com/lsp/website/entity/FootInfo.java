package com.lsp.website.entity;

import com.mongodb.ReflectionDBObject;
/**
 * 页脚实体类
 * @author lsp
 *
 */
public class FootInfo extends ReflectionDBObject{
	 private Integer sort;
	 private Long   comId;
	 /**
	  * 样式
	  */
	 private Long   styleId;
	 /**
	  * 标题
	  */
	 private String  title;
	 /**
	  * 
	  * 内容
	  */
	private String content;
	/**
	 * 链接
	 *  
	 */
	private String  url;
  
	 
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Integer getSort() {
		return sort;
	}
	public void setSort(Integer sort) {
		this.sort = sort;
	}
	public Long getComId() {
		return comId;
	}
	public void setComId(Long comId) {
		this.comId = comId;
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
}
