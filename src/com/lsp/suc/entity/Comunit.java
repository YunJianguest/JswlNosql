package com.lsp.suc.entity;

import com.mongodb.ReflectionDBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
public class Comunit extends ReflectionDBObject{
	/**
	 * 微信用户
	 */
	private String toUser;
	private String custid;
	/**
	 * 创建者
	 */
	private String parentUser;
	/**
	 * 企业标题
	 */
	private String title;
	/**
	 * 网站模板
	 */
	private String mb;
	/**
	 * 积分标识
	 */
	private String jfbs;
	 
	/**
	 * 背景音乐
	 */
	private String mp3;
	/**
	 * logo
	 */
	private String logo;
	/**
	 * 下标
	 */
	private String foot;
	/**
	 * 菜单不显示右内容
	 */
	private String jytype;
	/**
	 *结算方式 0  不结算  1 积分
	 */
	private int qx;
	/**
	 * 第三方用户唯一凭证
	 */
	private String appid;
	/**
	 * 第三方用户唯一凭证密钥，既appsecret 
	 */
	private String secret;
	/**
	 * 账号类型   1 服务号
	 */
	private int zhlx;
	/**
	 * 账号类型  0 绿色  1 蓝色 2 灰色
	 */
	private int css;
	/**
	 * 是否需要激活   0 车名片  1非车名片
	 */
	private int isjh;
	/**
	 * 是否开启客服    0 不需要 1开启
	 */
	private int kf;
	/**
	 * 图灵 开发者注册帐号
	 */
	private String tlkey;
	private String summary;
	/**
	 * 网站类型
	 */
	private String type;
	/**
	 * 关键字
	 */
	private String keyword;
	/**
	 * 是否为主页
	 */
	private int    iszy;
	/**
	 * 序号
	 * @return
	 */
	private int  sort;
	/**
	 * 背景图
	 * @return
	 */
	private String bjt;
	/**
	 * 授权类型0为本类，1为父类
	 */
	private int    sqlx;
	private String  ewmurl;
	/**
	 * 0为显示，1为不显示
	 */
	private int     ewmxs;
	/**
	 * 首次登陆赠送积分
	 */
	private float   zsjf;
	/**
	 * 积分提示
	 */
	private String  tsjf;
	
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getLogo() {
		return logo;
	}
	public void setLogo(String logo) {
		this.logo = logo;
	}
	
	public String getMb() {
		return mb;
	}
	public void setMb(String mb) {
		this.mb = mb;
	}
	public String getJfbs() {
		return jfbs;
	}
	public void setJfbs(String jfbs) {
		this.jfbs = jfbs;
	}
	public String getFoot() {
		return foot;
	}
	public void setFoot(String foot) {
		this.foot = foot;
	}
	public int getIszy() {
		return iszy;
	}
	public void setIszy(int iszy) {
		this.iszy = iszy;
	}
	public String getMp3() {
		return mp3;
	}
	public void setMp3(String mp3) {
		this.mp3 = mp3;
	}
	public String getAppid() {
		return appid;
	}
	public void setAppid(String appid) {
		this.appid = appid;
	}
	public String getSecret() {
		return secret;
	}
	public void setSecret(String secret) {
		this.secret = secret;
	}
	public int getZhlx() {
		return zhlx;
	}
	public void setZhlx(int zhlx) {
		this.zhlx = zhlx;
	}
	public int getQx() {
		return qx;
	}
	public void setQx(int qx) {
		this.qx = qx;
	}
	public String getTlkey() {
		return tlkey;
	}
	public void setTlkey(String tlkey) {
		this.tlkey = tlkey;
	}
	public int getIsjh() {
		return isjh;
	}
	public void setIsjh(int isjh) {
		this.isjh = isjh;
	}
	public int getKf() {
		return kf;
	}
	public void setKf(int kf) {
		this.kf = kf;
	}
	public String getJytype() {
		return jytype;
	}
	public void setJytype(String jytype) {
		this.jytype = jytype;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public int getCss() {
		return css;
	}
	public void setCss(int css) {
		this.css = css;
	}
	public String getParentUser() {
		return parentUser;
	}
	public void setParentUser(String parentUser) {
		this.parentUser = parentUser;
	}
	public String getBjt() {
		return bjt;
	}
	public void setBjt(String bjt) {
		this.bjt = bjt;
	}
	public int getSqlx() {
		return sqlx;
	}
	public void setSqlx(int sqlx) {
		this.sqlx = sqlx;
	}
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public String getEwmurl() {
		return ewmurl;
	}
	public void setEwmurl(String ewmurl) {
		this.ewmurl = ewmurl;
	}
	public int getEwmxs() {
		return ewmxs;
	}
	public void setEwmxs(int ewmxs) {
		this.ewmxs = ewmxs;
	}
	public float getZsjf() {
		return zsjf;
	}
	public void setZsjf(float zsjf) {
		this.zsjf = zsjf;
	}
	public String getTsjf() {
		return tsjf;
	}
	public void setTsjf(String tsjf) {
		this.tsjf = tsjf;
	} 
	
}
