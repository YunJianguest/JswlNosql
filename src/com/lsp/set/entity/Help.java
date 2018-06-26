package com.lsp.set.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 系统帮助
 * @author lsp
 *
 */
public class Help extends ReflectionDBObject{
	private String  custid;
	private int  type;
	/**
	 * 0为后台管理人员，1为用户
	 */
	private int  lx;
	private String  title;
	private String  content;
	private Date    createdate;
	private int     sort;
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	} 
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
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
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public int getLx() {
		return lx;
	}
	public void setLx(int lx) {
		this.lx = lx;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	

}
