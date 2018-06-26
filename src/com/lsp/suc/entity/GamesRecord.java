package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 游戏统计
 * @author lsp
 *
 */
public class GamesRecord extends ReflectionDBObject{

	private String custid;
	private Long   gid;
	private String fromUserid;
	private Date   createdate;
	/**
	 * 最后登录时间
	 */
	private Date   endlogindate;
	/**
	 * 成就
	 */
	private String achievement;
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public Long getGid() {
		return gid;
	}
	public void setGid(Long gid) {
		this.gid = gid;
	}
	public String getFromUserid() {
		return fromUserid;
	}
	public void setFromUserid(String fromUserid) {
		this.fromUserid = fromUserid;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public Date getEndlogindate() {
		return endlogindate;
	}
	public void setEndlogindate(Date endlogindate) {
		this.endlogindate = endlogindate;
	}
	public String getAchievement() {
		return achievement;
	}
	public void setAchievement(String achievement) {
		this.achievement = achievement;
	}
	
}
