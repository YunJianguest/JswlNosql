package com.lsp.website.entity;

import com.mongodb.ReflectionDBObject;
/**
 * 导航条实体类
 * @author lsp
 *
 */
public class NavigationInfo extends ReflectionDBObject  {

	 private Integer sort;
	 private Long   webid;
	 /**
	  * 父级关联ID
	  */
	 private Long   parentid;
	 /**
	  * 1.一级菜单2.二级菜单.
	  */
	 private String  type;
	 private int     mb; 
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
	 private String context;
	/**
	 * 链接
	 *  
	 */
	private String  url;
    /**
     * 编码
     * @return
     */
	private String coding;  
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
	
	public Long getWebid() {
		return webid;
	}
	public void setWebid(Long webid) {
		this.webid = webid;
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
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getMb() {
		return mb;
	}
	public void setMb(int mb) {
		this.mb = mb;
	}
	public String getCoding() {
		return coding;
	}
	public void setCoding(String coding) {
		this.coding = coding;
	}
	public Long getParentid() {
		return parentid;
	}
	public void setParentid(Long parentid) {
		this.parentid = parentid;
	}
	 
	 
	 
}
