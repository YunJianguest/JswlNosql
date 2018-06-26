package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;

/***
 * 答题详细
 * @author lsp
 *
 */
public class AnswerDetail  extends ReflectionDBObject{
	/**
	 * 外键
	 */
	private Long wid;
	private String picurl;
	/**
	 *问题
	 */
	private String wt;
	/**
	 * 分数
	 */
	private int score0;
	/**
	 *答案
	 */
	private String daan0;
	/**
	 * 分数
	 */
	private int score1;
	/**
	 *答案
	 */
	private String daan1;
	/**
	 * 分数
	 */
	private int score2;
	/**
	 *答案
	 */
	private String daan2;
	/**
	 * 分数
	 */
	private int score3;
	/**
	 *答案
	 */
	private String daan3;
	private String toUser;
	private int sort;
	public Long getWid() {
		return wid;
	}
	public void setWid(Long wid) {
		this.wid = wid;
	}
	public String getWt() {
		return wt;
	}
	public void setWt(String wt) {
		this.wt = wt;
	}
	public int getScore0() {
		return score0;
	}
	public void setScore0(int score0) {
		this.score0 = score0;
	}
	public String getDaan0() {
		return daan0;
	}
	public void setDaan0(String daan0) {
		this.daan0 = daan0;
	}
	public int getScore1() {
		return score1;
	}
	public void setScore1(int score1) {
		this.score1 = score1;
	}
	public String getDaan1() {
		return daan1;
	}
	public void setDaan1(String daan1) {
		this.daan1 = daan1;
	}
	public int getScore2() {
		return score2;
	}
	public void setScore2(int score2) {
		this.score2 = score2;
	}
	public String getDaan2() {
		return daan2;
	}
	public void setDaan2(String daan2) {
		this.daan2 = daan2;
	}
	public int getScore3() {
		return score3;
	}
	public void setScore3(int score3) {
		this.score3 = score3;
	}
	public String getDaan3() {
		return daan3;
	}
	public void setDaan3(String daan3) {
		this.daan3 = daan3;
	}
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	
	
}
