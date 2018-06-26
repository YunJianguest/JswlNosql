package com.lsp.shop.entiy;

import java.util.Date;

import com.mongodb.ReflectionDBObject;

/***
 * 商品预定
 * @author lsp
 *
 */
public class YuDing  extends ReflectionDBObject{
	/**
	 * 预定时间
	 */
	private String rq;
	/**
	 * 预定时间
	 */
	private int sj;
	/**
	 * 可预定数
	 */
	private int total;
	/**
	 * 已出售数量
	 */
	private int num;
	private String toUser;
	/**
	 * 排序
	 */
	private long sort;
	
	
	public String getRq() {
		return rq;
	}
	public void setRq(String rq) {
		this.rq = rq;
	}
	public int getSj() {
		return sj;
	}
	public void setSj(int sj) {
		this.sj = sj;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public long getSort() {
		return sort;
	}
	public void setSort(long sort) {
		this.sort = sort;
	}
	
	
}
