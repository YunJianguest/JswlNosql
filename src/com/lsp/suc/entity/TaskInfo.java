package com.lsp.suc.entity;

import com.mongodb.ReflectionDBObject;
/**
 * 任务管理
 * @author lsp
 *
 */
public class TaskInfo extends ReflectionDBObject{

	private String  custid;
	private int     sort;
	/**
	 * 标题
	 */
	private String  title;
	/**
	 * 内容
	 */
	private String  content;
	/**
	 * 类型
	 */
	private String  type;
	/**
	 * 任务量
	 */
	private int     count;
	/**
	 * 模板
	 */
	private int  mb;
	/**
	 * 经验奖励
	 */
	private int  expreward;
	/**
	 * 积分奖励
	 * @return
	 */
	private int  jfreward;
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getMb() {
		return mb;
	}
	public void setMb(int mb) {
		this.mb = mb;
	}
	public int getExpreward() {
		return expreward;
	}
	public void setExpreward(int expreward) {
		this.expreward = expreward;
	}
	public int getJfreward() {
		return jfreward;
	}
	public void setJfreward(int jfreward) {
		this.jfreward = jfreward;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
 
	
	
}
