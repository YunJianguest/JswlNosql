package com.lsp.weixin.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;

/***
 * 资源管理
 * @author lsp
 *
 */
public class WeixinRequest extends ReflectionDBObject{
	/**
	 * 开发者微信号 
	 */
	private String toUser;
	/**
	 * 发送方帐号（一个OpenID） 
	 */
	private String fromUser;
	/**
	 * 消息创建时间 （整型） 
	 */
	private Date createTime;
	/**
	 * 消息类型
	 */
	private String msgType;
	/**
	 * 文本消息内容
	 */
	private String content;
	/**
	 * 图片链接 /消息链接
	 */
	private String picUrl;
	/**
	 * 地理位置纬度  
	 */
	private Double location_X;
	/**
	 * 地理位置经度 
	 */
	private Double location_Y;
	/**
	 * 消息标题 
	 */
	private String Title;
	/**
	 * 消息描述 
	 */
	private String Description;
	/**
	 * 消息链接
	 */
	private String url;
	/**
	 * 事件类型，subscribe(订阅)、unsubscribe(取消订阅)、CLICK(自定义菜单点击事件) 
	 */
	private String event;
	/**
	 * 事件KEY值，与自定义菜单接口中KEY值对应 
	 */
	private String eventKey ;
	
	/**
	 * 消息id，64位整型 
	 */
	private Long msgId;
	
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public String getFromUser() {
		return fromUser;
	}
	public void setFromUser(String fromUser) {
		this.fromUser = fromUser;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getMsgType() {
		return msgType;
	}
	public void setMsgType(String msgType) {
		this.msgType = msgType;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPicUrl() {
		return picUrl;
	}
	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}
	public Double getLocation_X() {
		return location_X;
	}
	public void setLocation_X(Double location_X) {
		this.location_X = location_X;
	}
	public Double getLocation_Y() {
		return location_Y;
	}
	public void setLocation_Y(Double location_Y) {
		this.location_Y = location_Y;
	}
	public String getTitle() {
		return Title;
	}
	public void setTitle(String title) {
		Title = title;
	}
	public String getDescription() {
		return Description;
	}
	public void setDescription(String description) {
		Description = description;
	}
	public Long getMsgId() {
		return msgId;
	}
	public void setMsgId(Long msgId) {
		this.msgId = msgId;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getEvent() {
		return event;
	}
	public void setEvent(String event) {
		this.event = event;
	}
	public String getEventKey() {
		return eventKey;
	}
	public void setEventKey(String eventKey) {
		this.eventKey = eventKey;
	}
	
}
