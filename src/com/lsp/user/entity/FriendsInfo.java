package com.lsp.user.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 好友管理
 * @author lsp
 *
 */
public class FriendsInfo  extends ReflectionDBObject{

	private String fromUserid;
	private String friendsid;
	/**
	 * 0好友，1未审核，2审核驳回，3黑名单 4删除
	 */
	private int    state;
	private Date   createdate;
	private Date   setdate;
	public String getFromUserid() {
		return fromUserid;
	}
	public void setFromUserid(String fromUserid) {
		this.fromUserid = fromUserid;
	}  
	public String getFriendsid() {
		return friendsid;
	}
	public void setFriendsid(String friendsid) {
		this.friendsid = friendsid;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public Date getSetdate() {
		return setdate;
	}
	public void setSetdate(Date setdate) {
		this.setdate = setdate;
	}
	
}
