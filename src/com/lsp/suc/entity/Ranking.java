package com.lsp.suc.entity;

import com.mongodb.ReflectionDBObject;
/**
 * 排行榜
 * @author lsp
 *
 */
public class Ranking extends ReflectionDBObject{

	private String custid;
	/**
	 * 类型
	 */
	private String  type;
	private Long  rankno; 
	private String  rankid;
	private String rankname;
	private String picurl;
	/**
	 * 排序内容
	 */
	private int     value;
	/**
	 * 排名
	 */
	private int     rank;
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	 
	public int getValue() {
		return value;
	}
	public void setValue(int value) {
		this.value = value;
	}
	public int getRank() {
		return rank;
	}
	public void setRank(int rank) {
		this.rank = rank;
	}
	public Long getRankno() {
		return rankno;
	}
	public void setRankno(Long rankno) {
		this.rankno = rankno;
	}
	public String getRankname() {
		return rankname;
	}
	public void setRankname(String rankname) {
		this.rankname = rankname;
	}
	public String getRankid() {
		return rankid;
	}
	public void setRankid(String rankid) {
		this.rankid = rankid;
	}
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	
}
