package com.lsp.website.entity;

import com.mongodb.ReflectionDBObject;

/**
 * 滚动实体类
 * @author lsp
 *
 */
public class RollInfo  extends ReflectionDBObject {
	private Integer sort; 
	private Long webid;
	private String toUser;
	private String type;
	private String custid;
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
	private String pic;
	/**
	 * 位置0居左，1居右
	 */
	private String position;
 
	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
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

	public String getPic() {
		return pic;
	}

	public void setPic(String pic) {
		this.pic = pic;
	}
 
	public Long getWebid() {
		return webid;
	}

	public void setWebid(Long webid) {
		this.webid = webid;
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
	
 

}
