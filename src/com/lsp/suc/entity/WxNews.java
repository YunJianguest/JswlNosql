package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
public class WxNews  extends ReflectionDBObject{
	/**
	 * 图文消息标题
	 */
	private String newtitle;
	/**
	 * 摘要
	 */															
	private String summary;
	/**
	 * 图文消息描述 
	 */
	private String description;
	/**
	 * 图片链接，支持JPG、PNG格式，较好的效果为大图640*320，小图80*80。  
	 */
	private String picUrl;
	/**
	 * 幻灯片
	 */
	private String slide;
	/**
	 * 图片是否显示，1不显示 0显示
	 */
	private int picxs;
	/**
	 * 点击图文消息跳转链接   
	 */
	private String url;
	/**
	 * 背景音乐
	 */
	private String mp3;
	
	/**
	 * 消息类型 '0':'文章','2':'超链接','1':'视频'
	 */
	private int lx;
	/**
	 * '0':'左图','1':'大图','2':'右图','3':'三张图'
	 */
	private int xslx;
	/**
	 *评论  '1':'可评论','2':'不可评论'
	 */
	private int pllx;
	
	
	/**
	 * 消息类型
	 */
	private String type;
	
	private Date createdate;
	private Long custid;
	private Long comid;
	private String toUser;
	private String fromUser;
	private int sort;
	/**
	 *状态 0 默认   2推荐
	 */
	private int state;
	/**
	 *是否显示  0 显示  1 不显示
	 */
	private int xs;
	/**
	 *阅读量
	 */
	private int ydl; 
	/**
	 * 微信素材
	 */
	private String media_id;
	private String thumb_media_id;
	public String getNewtitle() {
		return newtitle;
	}
	public void setNewtitle(String newtitle) {
		this.newtitle = newtitle;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getPicUrl() {
		return picUrl;
	}
	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public Long getCustid() {
		return custid;
	}
	public void setCustid(Long custid) {
		this.custid = custid;
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
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public int getLx() {
		return lx;
	}
	public void setLx(int lx) {
		this.lx = lx;
	}
	public String getFromUser() {
		return fromUser;
	}
	public void setFromUser(String fromUser) {
		this.fromUser = fromUser;
	}
	public int getPllx() {
		return pllx;
	}
	public void setPllx(int pllx) {
		this.pllx = pllx;
	}
	public Long getComid() {
		return comid;
	}
	public void setComid(Long comid) {
		this.comid = comid;
	}
	public int getPicxs() {
		return picxs;
	}
	public void setPicxs(int picxs) {
		this.picxs = picxs;
	}
	public String getMp3() {
		return mp3;
	}
	public void setMp3(String mp3) {
		this.mp3 = mp3;
	}
	public String getSlide() {
		return slide;
	}
	public void setSlide(String slide) {
		this.slide = slide;
	}
	public int getXs() {
		return xs;
	}
	public void setXs(int xs) {
		this.xs = xs;
	}
	
	
	public int getYdl() {
		return ydl;
	}
	public void setYdl(int ydl) {
		this.ydl = ydl;
	}
	public int getXslx() {
		return xslx;
	}
	public void setXslx(int xslx) {
		this.xslx = xslx;
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
	 
	
	
}