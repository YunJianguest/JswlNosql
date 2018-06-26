package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 答题
 * @author lsp 
 *   
 */
public class AnswerRecordDetail  extends ReflectionDBObject{
	/**
	 * 图文消息标题
	 */
	private String wid;
	
	/**
	 * 答题id
	 */
	private Long detailid;
	private int score;
	private String daan;
	

	private int sort;


	public String getWid() {
		return wid;
	}


	public void setWid(String wid) {
		this.wid = wid;
	}


	public Long getDetailid() {
		return detailid;
	}


	public void setDetailid(Long detailid) {
		this.detailid = detailid;
	}


	public int getScore() {
		return score;
	}


	public void setScore(int score) {
		this.score = score;
	}


	public String getDaan() {
		return daan;
	}


	public void setDaan(String daan) {
		this.daan = daan;
	}


	public int getSort() {
		return sort;
	}


	public void setSort(int sort) {
		this.sort = sort;
	}
	
}
