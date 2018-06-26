package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 积分统计
 * @author lsp
 *
 */
public class IntegralTotal extends ReflectionDBObject{

	/**
	 * 微信用户
	 */
	private String fromUser;
	private String toUser;
	
	/**
	 * 总收入
	 */
	private int sr;
	/**
	 * 总支出
	 */
	private int zc;
	/**
	 * 积分
	 */
	private int jf;
	private Date insdate;
	public String getFromUser() {
		return fromUser;
	}
	public void setFromUser(String fromUser) {
		this.fromUser = fromUser;
	}
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public int getSr() {
		return sr;
	}
	public void setSr(int sr) {
		this.sr = sr;
	}
	public int getZc() {
		return zc;
	}
	public void setZc(int zc) {
		this.zc = zc;
	}
	public int getJf() {
		return jf;
	}
	public void setJf(int jf) {
		this.jf = jf;
	}
	public Date getInsdate() {
		return insdate;
	}
	public void setInsdate(Date insdate) {
		this.insdate = insdate;
	}
	
}
