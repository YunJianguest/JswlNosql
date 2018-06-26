package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 祭奠评论赞管理
 * @author lsp
 *
 */
public class MemorialCommentPraise extends ReflectionDBObject{

	private String custid;
	private String fromUserid; 
	/**
	 * 评论ID
	 */
	private Long   wid;
	/**
	 * 祭奠人名称
	 */
	private String nickname;
	/**
	 * 祭奠人头像
	 */
	private String headimgurl;
	private Date   createdate;
 
	public Long getWid() {
		return wid;
	}
	public void setWid(Long wid) {
		this.wid = wid;
	}
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public String getFromUserid() {
		return fromUserid;
	}
	public void setFromUserid(String fromUserid) {
		this.fromUserid = fromUserid;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getHeadimgurl() {
		return headimgurl;
	}
	public void setHeadimgurl(String headimgurl) {
		this.headimgurl = headimgurl;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	  
}
