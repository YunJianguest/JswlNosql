package com.lsp.weixin.entity;

import com.mongodb.ReflectionDBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
public class WxPayConfig extends ReflectionDBObject{
	private String partner;
	private String toUser;
	private String partner_key; 
	private String certLocalPath;
	private String appid;
	private String appsecret;
	private String appkey;
	private String name;
	public String getPartner() {
		return partner;
	}
	public void setPartner(String partner) {
		this.partner = partner;
	}
	public String getPartner_key() {
		return partner_key;
	}
	public void setPartner_key(String partner_key) {
		this.partner_key = partner_key;
	}
	public String getAppid() {
		return appid;
	}
	public void setAppid(String appid) {
		this.appid = appid;
	}
	public String getAppsecret() {
		return appsecret;
	}
	public void setAppsecret(String appsecret) {
		this.appsecret = appsecret;
	}
	public String getAppkey() {
		return appkey;
	}
	public void setAppkey(String appkey) {
		this.appkey = appkey;
	}
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public String getCertLocalPath() {
		return certLocalPath;
	}
	public void setCertLocalPath(String certLocalPath) {
		this.certLocalPath = certLocalPath;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
}
