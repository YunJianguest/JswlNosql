package com.lsp.suc.entity;

import com.mongodb.ReflectionDBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
public class Reward extends ReflectionDBObject{
	/**
	 * 编号
	 * 0 未中  1  2 3 4
	 */															
	private int no;
	/**
	 * 奖品
	 */															
	private String jp;
	/**
	 * 中奖概率
	 */															
	private int zjl;
	/**
	 * 数量
	 */															
	private int total;
	/**
	 * 领奖页面
	 */															
	private String method;
	/**
	 * 奖券id
	 */															
	private Long jjid;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getJp() {
		return jp;
	}
	public void setJp(String jp) {
		this.jp = jp;
	}
	public int getZjl() {
		return zjl;
	}
	public void setZjl(int zjl) {
		this.zjl = zjl;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public String getMethod() {
		return method;
	}
	public void setMethod(String method) {
		this.method = method;
	}
	public Long getJjid() {
		return jjid;
	}
	public void setJjid(Long jjid) {
		this.jjid = jjid;
	}
	
	
}
