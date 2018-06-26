package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 评论
 * @author lsp 
 *   
 */
public class Board  extends ReflectionDBObject{
	private String fromUser;
	/**
	 * 姓名
	 */
	private String name;
	private String type;
	/**
	 * 评论内容
	 */
	private String content;
	
	private Date createdate;
	
	private String toUser;
	/**
	 * 评论
	 */															
	private int pf;
	private String fromUserto;
	private int sort;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public String getFromUser() {
		return fromUser;
	}
	public void setFromUser(String fromUser) {
		this.fromUser = fromUser;
	}
	public String getFromUserto() {
		return fromUserto;
	}
	public void setFromUserto(String fromUserto) {
		this.fromUserto = fromUserto;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	public int getPf() {
		return pf;
	}
	public void setPf(int pf) {
		this.pf = pf;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
 	
}
