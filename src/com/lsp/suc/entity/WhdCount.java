package com.lsp.suc.entity;

import java.util.Date;
import java.util.List;

import com.mongodb.ReflectionDBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
public class WhdCount extends ReflectionDBObject{
	
	/**
	 * 活动日期
	 */
	private String insdate;
	private Date createdate;
	/**
	 * 类型  1 图文 2 大转盘 3 刮刮乐 4 投票  99 签到 5优惠劵 6视频
	 */
	private int lx;
	
	private String fromUser;
	private String fromUserid;
	private Long wid;
	private Long tpid;
	


	public String getInsdate() {
		return insdate;
	}

	public void setInsdate(String insdate) {
		this.insdate = insdate;
	}

	public String getFromUser() {
		return fromUser;
	}

	public void setFromUser(String fromUser) {
		this.fromUser = fromUser;
	}

	public Long getWid() {
		return wid;
	}

	public void setWid(Long wid) {
		this.wid = wid;
	}

	public int getLx() {
		return lx;
	}

	public void setLx(int lx) {
		this.lx = lx;
	}

	public Long getTpid() {
		return tpid;
	}

	public void setTpid(Long tpid) {
		this.tpid = tpid;
	}

	public Date getCreatedate() {
		return createdate;
	}

	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}

	public String getFromUserid() {
		return fromUserid;
	}

	public void setFromUserid(String fromUserid) {
		this.fromUserid = fromUserid;
	}
	
	
}	