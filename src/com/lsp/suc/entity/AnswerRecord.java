package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;

/**
 * 答题结果
 * @author lsp 
 *   
 */
public class AnswerRecord  extends ReflectionDBObject{
	/**
	 * 图文消息标题
	 */
	private Long wid;
	
	
	private String fromUser;
	
	private Date insdate;
	private Date startdate;
	private Date enddate;
	private int fen;

	
	public Long getWid() {
		return wid;
	}
	public void setWid(Long wid) {
		this.wid = wid;
	}
	
	public String getFromUser() {
		return fromUser;
	}
	public void setFromUser(String fromUser) {
		this.fromUser = fromUser;
	}
	
	public int getFen() {
		return fen;
	}
	public void setFen(int fen) {
		this.fen = fen;
	}
	
	public Date getStartdate() {
		return startdate;
	}
	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}
	public Date getEnddate() {
		return enddate;
	}
	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}
	public Date getInsdate() {
		return insdate;
	}
	public void setInsdate(Date insdate) {
		this.insdate = insdate;
	}
	
}
