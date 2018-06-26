package com.lsp.suc.entity;

import com.mongodb.ReflectionDBObject;
/**
 * 祭奠献词管理
 * @author lsp
 *
 */
public class MemorialMessage extends ReflectionDBObject{

	private String custid;
	private String fromUserid; 
	/**
	 * 祭奠ID
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
	/**
	 * 内容
	 */
	private String content; 
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	 
	 
}
