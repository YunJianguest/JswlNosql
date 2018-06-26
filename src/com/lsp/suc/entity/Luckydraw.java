package com.lsp.suc.entity;

import java.util.Date;
import java.util.List;

import com.mongodb.ReflectionDBObject;
/***
 * 摇奖管理
 * @author lsp
 *
 */
public class Luckydraw extends ReflectionDBObject{
	/**
	 * 标题
	 */															
	private String title;
	/**
	 * 分享链接  0 默认 1 单点登录
	 */															
	private int fx;
	/*
	 * 摘要
	 */															
	private String summary;
	/**
	 * 说明
	 */															
	private String context;
	/**
	 * 图片地址
	 */
	private String picurl;

	private Date createdate;
	/**
	 * 活动开始日期
	 */
	private Date startdate;
	/**
	 * 活动结束日期
	 */
	private Date enddate;
	/**
	 * 兑奖结束日期
	 */
	private Date djenddate;
	/**
	 * 参与频率 
	 *'0':'仅一次','1':'每日一次','2':'每日二次','3':'每日三次','4':'不限次数'
	 */
	private int rate;
	/**
	 * 0 不限制  1 每日一次
	 */
	private int djcs;
	/**
	 * 0 不验证  1 验证
	 */
	private int yz;
	private List<Reward> reward;
	private String custid;
	private Long comid;
	private String toUser;
	private String fromUserid;
	/**
	 * 未开始提示语
	 */
	private String startts;
	/**
	 * 已过期提示语
	 */
	private String overts;
	private String cgts;
	/**
	 * 0 大转盘  1刮刮乐2.0元抢
	 */
	private int lx;
	private String mp3;
	/**
	 * 发起人姓名
	 */
	private String fromUsername;
	/**
	 * 发起人电话
	 */
	private String fromUsertel;
	/**
	 * 发起人QQ
	 * @return
	 */
	private String fromUserqq;
	/**
	 * 参与人数
	 * @return
	 */
	private int pcount;
	private String imgurl;
	private String url;
	/**
	 * 发起单位
	 */
	private String unit;
	private int sort;
	private String bgcolor;
	/**
	 * 中奖率
	 */
	private int zjl;
	/**
	 * 兑奖二维码地址
	 * @return
	 */
	private String ewmurl;
	/**
	 * 积分消耗
	 */
	private float  jfxh;

	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
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
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public Date getStartdate() {
		return startdate;
	}
	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}
	public Date getEnddate() {
		return enddate;
	}
	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}
	public Date getDjenddate() {
		return djenddate;
	}
	public void setDjenddate(Date djenddate) {
		this.djenddate = djenddate;
	}
	public int getRate() {
		return rate;
	}
	public void setRate(int rate) {
		this.rate = rate;
	}
	public List<Reward> getReward() {
		return reward;
	}
	public void setReward(List<Reward> reward) {
		this.reward = reward;
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
	public Long getComid() {
		return comid;
	}
	public void setComid(Long comid) {
		this.comid = comid;
	}
	public String getStartts() {
		return startts;
	}
	public void setStartts(String startts) {
		this.startts = startts;
	}
	public String getOverts() {
		return overts;
	}
	public void setOverts(String overts) {
		this.overts = overts;
	}
	public String getCgts() {
		return cgts;
	}
	public void setCgts(String cgts) {
		this.cgts = cgts;
	}
	public int getDjcs() {
		return djcs;
	}
	public void setDjcs(int djcs) {
		this.djcs = djcs;
	}
	public int getLx() {
		return lx;
	}
	public void setLx(int lx) {
		this.lx = lx;
	}
	public int getFx() {
		return fx;
	}
	public void setFx(int fx) {
		this.fx = fx;
	}
	public int getYz() {
		return yz;
	}
	public void setYz(int yz) {
		this.yz = yz;
	}
	public String getMp3() {
		return mp3;
	}
	public void setMp3(String mp3) {
		this.mp3 = mp3;
	}
	public String getFromUserid() {
		return fromUserid;
	}
	public void setFromUserid(String fromUserid) {
		this.fromUserid = fromUserid;
	}
	public String getFromUsername() {
		return fromUsername;
	}
	public void setFromUsername(String fromUsername) {
		this.fromUsername = fromUsername;
	}
	public String getFromUsertel() {
		return fromUsertel;
	}
	public void setFromUsertel(String fromUsertel) {
		this.fromUsertel = fromUsertel;
	}
	public String getFromUserqq() {
		return fromUserqq;
	}
	public void setFromUserqq(String fromUserqq) {
		this.fromUserqq = fromUserqq;
	}
	public int getPcount() {
		return pcount;
	}
	public void setPcount(int pcount) {
		this.pcount = pcount;
	}
	public String getImgurl() {
		return imgurl;
	}
	public void setImgurl(String imgurl) {
		this.imgurl = imgurl;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public String getBgcolor() {
		return bgcolor;
	}
	public void setBgcolor(String bgcolor) {
		this.bgcolor = bgcolor;
	}
	public int getZjl() {
		return zjl;
	}
	public void setZjl(int zjl) {
		this.zjl = zjl;
	}
	public String getEwmurl() {
		return ewmurl;
	}
	public void setEwmurl(String ewmurl) {
		this.ewmurl = ewmurl;
	}
	public float getJfxh() {
		return jfxh;
	}
	public void setJfxh(float jfxh) {
		this.jfxh = jfxh;
	}
	 
}
