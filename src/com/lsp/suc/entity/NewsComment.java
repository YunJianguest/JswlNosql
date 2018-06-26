package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
public class NewsComment extends ReflectionDBObject{
	private String fromUser;									
	private String context;
	private Long newsid;
	private Date creatdate;
	
	public String getContext() {
		return context;
	}
	public void setContext(String context) {
		this.context = context;
	}
	public Long getNewsid() {
		return newsid;
	}
	public void setNewsid(Long newsid) {
		this.newsid = newsid;
	}
	public Date getCreatdate() {
		return creatdate;
	}
	public void setCreatdate(Date creatdate) {
		this.creatdate = creatdate;
	}
	public String getFromUser() {
		return fromUser;
	}
	public void setFromUser(String fromUser) {
		this.fromUser = fromUser;
	}
	
	

}

