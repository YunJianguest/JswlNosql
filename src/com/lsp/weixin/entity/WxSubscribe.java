package com.lsp.weixin.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
public class WxSubscribe  extends ReflectionDBObject{
	/**
	 * 图文消息标题
	 */
	private String newtitle;
	/**
	 * 图文消息描述 
	 */
	private String context;
	/**
	 * 图片链接，支持JPG、PNG格式，较好的效果为大图640*320，小图80*80。  
	 */
	private String picurl;
	/**
	 * 点击图文消息跳转链接   
	 */
	private String url;
	/**
	 * 消息类型
	 */
	private String type;
	private Integer sort;
	private Date createdate;
	private String  custid;
	private String toUser;
	public String getNewtitle() {
		return newtitle;
	}
	public void setNewtitle(String newtitle) {
		this.newtitle = newtitle;
	}
	public String getContext() {
		return context;
	}
	public void setContext(String context) {
		this.context = context;
	}
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Integer getSort() {
		return sort;
	}
	public void setSort(Integer sort) {
		this.sort = sort;
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
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	
	
	
}

