package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 祭奠栏目管理
 * @author lsp
 *
 */
public class Memoriallm extends ReflectionDBObject{

	private String toUser;
	private int    sort; 
	/**
	 * 名称
	 */
	private String title;
	/**
	 * 祭奠简介
	 */
	private String context;
	private String picurl;
	/**
	 * 上香数
	 */
	private int    count;
	private Date   createdate;
	private int    mb;
	/**
	 * 音乐
	 */
	private String mp3;
	/**
	 * 菜单名称
	 */
	private String funcname1;
	private String funcname2;
	private String funcname3;
	private String funcname4;
	/**
	 * 菜单连接
	 */
	private String funcurl1;
	private String funcurl2;
	private String funcurl3;
	private String funcurl4;
	/**
	 * 菜单图标
	 */
	private String funcioc1;
	private String funcioc2;
	private String funcioc3;
	private String funcioc4;
	/**
	 * 类型0为普通陵园祭祀，1为历史人物公祭
	 */
	private int    type;
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
	 
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContext() {
		return context;
	}
	public void setContext(String context) {
		this.context = context;
	}
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public int getMb() {
		return mb;
	}
	public void setMb(int mb) {
		this.mb = mb;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getMp3() {
		return mp3;
	}
	public void setMp3(String mp3) {
		this.mp3 = mp3;
	}
	public String getFuncname1() {
		return funcname1;
	}
	public void setFuncname1(String funcname1) {
		this.funcname1 = funcname1;
	}
	public String getFuncname2() {
		return funcname2;
	}
	public void setFuncname2(String funcname2) {
		this.funcname2 = funcname2;
	}
	public String getFuncname3() {
		return funcname3;
	}
	public void setFuncname3(String funcname3) {
		this.funcname3 = funcname3;
	}
	public String getFuncname4() {
		return funcname4;
	}
	public void setFuncname4(String funcname4) {
		this.funcname4 = funcname4;
	}
	public String getFuncurl1() {
		return funcurl1;
	}
	public void setFuncurl1(String funcurl1) {
		this.funcurl1 = funcurl1;
	}
	public String getFuncurl2() {
		return funcurl2;
	}
	public void setFuncurl2(String funcurl2) {
		this.funcurl2 = funcurl2;
	}
	public String getFuncurl3() {
		return funcurl3;
	}
	public void setFuncurl3(String funcurl3) {
		this.funcurl3 = funcurl3;
	}
	public String getFuncurl4() {
		return funcurl4;
	}
	public void setFuncurl4(String funcurl4) {
		this.funcurl4 = funcurl4;
	}
	public String getFuncioc1() {
		return funcioc1;
	}
	public void setFuncioc1(String funcioc1) {
		this.funcioc1 = funcioc1;
	}
	public String getFuncioc2() {
		return funcioc2;
	}
	public void setFuncioc2(String funcioc2) {
		this.funcioc2 = funcioc2;
	}
	public String getFuncioc3() {
		return funcioc3;
	}
	public void setFuncioc3(String funcioc3) {
		this.funcioc3 = funcioc3;
	}
	public String getFuncioc4() {
		return funcioc4;
	}
	public void setFuncioc4(String funcioc4) {
		this.funcioc4 = funcioc4;
	}
	
	
}
