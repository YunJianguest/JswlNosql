package com.lsp.weixin.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
public class WxTicket extends ReflectionDBObject{
	/**
	 * 渠道名称
	 */															
	private String name;
	/**
	 * 渠道名称
	 */															
	private String tel;
	/**
	 * 备注
	 */															
	private String remark;
	/**
	 * 二维码图片解析后的地址，开发者可根据该地址自行生成需要的二维码图片
	 */															
	private String url;
	/**
	 * 获取的二维码ticket，凭借此ticket可以在有效时间内换取二维码。
	 */															
	private String ticket;
	
	private String toUser;
	
	private Date insdate;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public Date getInsdate() {
		return insdate;
	}
	public void setInsdate(Date insdate) {
		this.insdate = insdate;
	}
	public String getTicket() {
		return ticket;
	}
	public void setTicket(String ticket) {
		this.ticket = ticket;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	

}
