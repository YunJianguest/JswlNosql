package com.lsp.weixin.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
public class WxContext extends ReflectionDBObject{

	/**
	 * 图文消息的标题
	 */
	private String title;
	/**
	 * 图文页的URL，或者，当获取的列表是图片素材列表时，该字段是图片的URL 
	 */
	private String url;
	/**
	 * 图
	 */
	private String thumb_media_id;
	private String picurl;
	
	/**
	 * 
	 */
	private Date insdate;
	private String toid;
	private String media_id;
	private String toUser;
	private int ydl;
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	
	public Date getInsdate() {
		return insdate;
	}
	public void setInsdate(Date insdate) {
		this.insdate = insdate;
	}
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public String getToid() {
		return toid;
	}
	public void setToid(String toid) {
		this.toid = toid;
	}
	public String getMedia_id() {
		return media_id;
	}
	public void setMedia_id(String media_id) {
		this.media_id = media_id;
	}
	public String getThumb_media_id() {
		return thumb_media_id;
	}
	public void setThumb_media_id(String thumb_media_id) {
		this.thumb_media_id = thumb_media_id;
	}
	public int getYdl() {
		return ydl;
	}
	public void setYdl(int ydl) {
		this.ydl = ydl;
	}
	
}
