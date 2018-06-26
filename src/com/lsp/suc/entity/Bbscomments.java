package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 论坛评论
 * @author lsp
 *
 */
public class Bbscomments extends ReflectionDBObject{

	/**
	 * 姓名
	 */
	private String name;
	/**
	 * 电话
	 */
	private String tel;
	
	/**
	 * 评论内容
	 */
	private String content;
	/**
	 * 便民贴id
	 */
	private Long bmtid;
	private Long parentid;
	private Long hfid;
	private String hfname;
	private String hfheadimgurl;
	private Date createdate;
	private String picurl;
	private String toUser;
	private String fromUser;
	private String fromUserid;
	private Long sort;

	private String headimgurl;
	/**
	 * 活动类型1为最佳答案
	 */
	private int    activity;
   
	public String getHfname() {
		return hfname;
	}

	public void setHfname(String hfname) {
		this.hfname = hfname;
	}

	public String getHfheadimgurl() {
		return hfheadimgurl;
	}

	public void setHfheadimgurl(String hfheadimgurl) {
		this.hfheadimgurl = hfheadimgurl;
	}

	public Long getHfid() {
		return hfid;
	}

	public void setHfid(Long hfid) {
		this.hfid = hfid;
	}

	public Long getParentid() {
		return parentid;
	}

	public void setParentid(Long parentid) {
		this.parentid = parentid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Long getBmtid() {
		return bmtid;
	}

	public void setBmtid(Long bmtid) {
		this.bmtid = bmtid;
	}

	public Date getCreatedate() {
		return createdate;
	}

	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}

	public String getPicurl() {
		return picurl;
	}

	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}

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

	public Long getSort() {
		return sort;
	}

	public void setSort(Long sort) {
		this.sort = sort;
	}

	public String getHeadimgurl() {
		return headimgurl;
	}

	public void setHeadimgurl(String headimgurl) {
		this.headimgurl = headimgurl;
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
	
}
