package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 论坛实体类
 * @author lsp
 *
 */
public class BbsInfo extends ReflectionDBObject{
   
		/**
		 * 图文消息标题
		 */
		private String title;
		
		/**
		 * 图片链接，支持JPG、PNG格式，较好的效果为大图640*320，小图80*80。  
		 */
		private String picurl;
		
		
		private Date createdate;
		private String custid;
		private String fromUserid;
		private String toUser;
		private String content;
		/**
		 * 心情
		 */
		private String humor;
		/**
		 * 摘要
		 */															
		private String summary;
		/**
		 * 类型
		 */															
		private String type;
		private Integer reading;
		private Integer state;
		private String fromUser;
		private String nikename;
		private String headimgurl;
		private Integer praise;
		/**
		 * 活动 0为默认正常，1为悬赏
		 */
		private  int    activity;
		/**
		 * 活动 0为默认正常，1为置顶
		 */
		private  int    stick;
		private  String  mp4url;
		/**
		 * 1为管理员
		 */
		private  int  adminstate; 
		public String getHumor() {
			return humor;
		}
		public void setHumor(String humor) {
			this.humor = humor;
		}
		public String getNikename() {
			return nikename;
		}
		public void setNikename(String nikename) {
			this.nikename = nikename;
		}
		public String getHeadimgurl() {
			return headimgurl;
		}
		public void setHeadimgurl(String headimgurl) {
			this.headimgurl = headimgurl;
		}
		public String getTitle() {
			return title;
		}
		public void setTitle(String title) {
			this.title = title;
		}
		public String getPicurl() {
			return picurl;
		}
		public void setPicurl(String picurl) {
			this.picurl = picurl;
		}
		public Date getCreatedate() {
			return createdate;
		}
		public void setCreatedate(Date createdate) {
			this.createdate = createdate;
		}
		public String getCustid() {
			return custid;
		}
		public void setCustid(String custid) {
			this.custid = custid;
		}
		public String getToUser() {
			return toUser;
		}
		public void setToUser(String toUser) {
			this.toUser = toUser;
		}
		 
		public Integer getReading() {
			return reading;
		}
		public void setReading(Integer reading) {
			this.reading = reading;
		}
		public Integer getState() {
			return state;
		}
		public void setState(Integer state) {
			this.state = state;
		}
		public String getContent() {
			return content;
		}
		public void setContent(String content) {
			this.content = content;
		}
		public String getSummary() {
			return summary;
		}
		public void setSummary(String summary) {
			this.summary = summary;
		}
		public String getType() {
			return type;
		}
		public void setType(String type) {
			this.type = type;
		}
		public String getFromUser() {
			return fromUser;
		}
		public void setFromUser(String fromUser) {
			this.fromUser = fromUser;
		}
		public Integer getPraise() {
			return praise;
		}
		public void setPraise(Integer praise) {
			this.praise = praise;
		}
		public String getFromUserid() {
			return fromUserid;
		}
		public void setFromUserid(String fromUserid) {
			this.fromUserid = fromUserid;
		}
		public int getActivity() {
			return activity;
		}
		public void setActivity(int activity) {
			this.activity = activity;
		}
		public int getStick() {
			return stick;
		}
		public void setStick(int stick) {
			this.stick = stick;
		}
		public String getMp4url() {
			return mp4url;
		}
		public void setMp4url(String mp4url) {
			this.mp4url = mp4url;
		}
		public int getAdminstate() {
			return adminstate;
		}
		public void setAdminstate(int adminstate) {
			this.adminstate = adminstate;
		}
		 
		 
		
}
