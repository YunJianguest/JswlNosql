package com.lsp.pub.entity;

import com.mongodb.ReflectionDBObject; 
/**
 * 资源管理
 * @author lsp 
 *   
 */
public class WxToken extends ReflectionDBObject{
	/**
	 * 微信用户
	 */
	private String toUser;
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
	 * 授权类型
	 */
	private int sqlx;
	/**
	 * 客服
	 */
	private int kf;
	/**
	 * 结算
	 */
	private int qx;
	/**
	 * 账号类型
	 */
	private int isjh;
	/**
	 * 获取到的凭证
	 */
	private String access_token;
	/**
	 * 获取到的凭证
	 */
	private String jsapi_ticket;
	/**
	 * 获取到的凭证
	 */
	private String url;
	/**
	 * 背景图片
	 */
	private long expires_in;
	
	/**
	 * 生成签名的时间戳
	 */
	private String timestamp;
	/**
	 * 生成签名的随机串
	 */
	private String noncestr;
	/**
	 * 签名，见附录1
	 */
	private String signature;
	/**
	 * 备注
	 */
	private String remark;
	/**
	 * 是否验证关注（0不验证，1验证）
	 */
	private int    isgz;
	
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
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
	public String getAccess_token() {
		return access_token;
	}
	public void setAccess_token(String access_token) {
		this.access_token = access_token;
	}
	public long getExpires_in() {
		return expires_in;
	}
	public void setExpires_in(long expires_in) {
		this.expires_in = expires_in;
	}
	public int getZhlx() {
		return zhlx;
	}
	public void setZhlx(int zhlx) {
		this.zhlx = zhlx;
	}
	public String getJsapi_ticket() {
		return jsapi_ticket;
	}
	public void setJsapi_ticket(String jsapi_ticket) {
		this.jsapi_ticket = jsapi_ticket;
	}
	public String getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	public String getNoncestr() {
		return noncestr;
	}
	public void setNoncestr(String noncestr) {
		this.noncestr = noncestr;
	}
	public String getSignature() {
		return signature;
	}
	public void setSignature(String signature) {
		this.signature = signature;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public int getSqlx() {
		return sqlx;
	}
	public void setSqlx(int sqlx) {
		this.sqlx = sqlx;
	}
	public int getKf() {
		return kf;
	}
	public void setKf(int kf) {
		this.kf = kf;
	}
	public int getQx() {
		return qx;
	}
	public void setQx(int qx) {
		this.qx = qx;
	}
	public int getIsjh() {
		return isjh;
	}
	public void setIsjh(int isjh) {
		this.isjh = isjh;
	}
	public int getIsgz() {
		return isgz;
	}
	public void setIsgz(int isgz) {
		this.isgz = isgz;
	}
	
	
}
