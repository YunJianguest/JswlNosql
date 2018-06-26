package com.lsp.website.entity;

import com.mongodb.ReflectionDBObject;
/**
 * 赞管理
 * @author lsp
 *
 */
public class PraiseInfo extends ReflectionDBObject {

	private String  toUser;
	private String  type;
	private Long    cid; 
	private Long    count;
	private String  fromUser;
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
	public Long getCid() {
		return cid;
	}
	public void setCid(Long cid) {
		this.cid = cid;
	}
	public Long getCount() {
		return count;
	}
	public void setCount(Long count) {
		this.count = count;
	}
	public String getFromUser() {
		return fromUser;
	}
	public void setFromUser(String fromUser) {
		this.fromUser = fromUser;
	}
	
	
}
