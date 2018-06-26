package com.lsp.android.entity;

import com.mongodb.ReflectionDBObject;
/**
 * 会话状态
 * @author lsp
 *
 */
public class ReplyState extends ReflectionDBObject{

	private String fromUserid; 
	/**
	 * 会话ID
	 */
	private Long   wid;
	/**
	 * 会话状态0标准1置顶
	 */
	private int    state;
	public String getFromUserid() {
		return fromUserid;
	}
	public void setFromUserid(String fromUserid) {
		this.fromUserid = fromUserid;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public Long getWid() {
		return wid;
	}
	public void setWid(Long wid) {
		this.wid = wid;
	}
	
	
}
