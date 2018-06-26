package com.lsp.suc.vivo.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 卡片
 * @author lsp
 *
 */
public class Card extends ReflectionDBObject{

	private String custid;
	private String title;
	private String content;
	private String logo;
	private String url;
	private Date createdate;
	/**
	 * 中奖率
	 */
	private int zjl;
	/**
	 * 数量
	 */
	private int total;
	private int sort;
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
	public String getLogo() {
		return logo;
	}
	public void setLogo(String logo) {
		this.logo = logo;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public int getZjl() {
		return zjl;
	}
	public void setZjl(int zjl) {
		this.zjl = zjl;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	
	
}
