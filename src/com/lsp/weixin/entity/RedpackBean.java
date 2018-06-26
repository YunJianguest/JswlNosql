package com.lsp.weixin.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 微信红包
 * @author lsp
 *
 */
public class RedpackBean  extends ReflectionDBObject{
	/**
	 * 随机字符串
	 */
	private String nonce_str;
	
	/**
	 * 签名
	 */
	private String sign;

	/**
	 * 商户订单号
	 */
	private String mch_billno;
	/**
	 *商户号
	 */
	private String mch_id;
	/**
	 *公众账号appid
	 */
	private String wxappid;
	/**
	 *商户名称
	 */
	private String send_name;
	/**
	 *用户openid
	 */
	private String re_openid;
	/**
	 *付款金额  付款金额，单位分
	 */
	private int total_amount;
	/**
	 *红包发放总人数
	 */
	private int total_num;
	/**
	 *Ip地址
	 */
	private String client_ip;
	/**
	 *红包祝福语
	 */
	private String wishing;
	/**
	 *活动名称
	 */
	private String act_name;
	/**
	 *备注
	 */
	private String remark;
	
	private Date insdate;
	private String toUser;
	/*
	 * 0 失败  1 发送成功  2 SENDING:发放中 
3  SENT:已发放待领取 
4  FAILED：发放失败 
5  RECEIVED:已领取 
6  REFUND:已退款
	 */
	private int state;
	public String getNonce_str() {
		return nonce_str;
	}
	public void setNonce_str(String nonce_str) {
		this.nonce_str = nonce_str;
	}
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
	}
	public String getMch_billno() {
		return mch_billno;
	}
	public void setMch_billno(String mch_billno) {
		this.mch_billno = mch_billno;
	}
	public String getMch_id() {
		return mch_id;
	}
	public void setMch_id(String mch_id) {
		this.mch_id = mch_id;
	}
	public String getWxappid() {
		return wxappid;
	}
	public void setWxappid(String wxappid) {
		this.wxappid = wxappid;
	}
	public String getSend_name() {
		return send_name;
	}
	public void setSend_name(String send_name) {
		this.send_name = send_name;
	}
	public String getRe_openid() {
		return re_openid;
	}
	public void setRe_openid(String re_openid) {
		this.re_openid = re_openid;
	}
	public int getTotal_amount() {
		return total_amount;
	}
	public void setTotal_amount(int total_amount) {
		this.total_amount = total_amount;
	}
	public int getTotal_num() {
		return total_num;
	}
	public void setTotal_num(int total_num) {
		this.total_num = total_num;
	}
	public String getWishing() {
		return wishing;
	}
	public void setWishing(String wishing) {
		this.wishing = wishing;
	}
	public String getAct_name() {
		return act_name;
	}
	public void setAct_name(String act_name) {
		this.act_name = act_name;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
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
	public String getClient_ip() {
		return client_ip;
	}
	public void setClient_ip(String client_ip) {
		this.client_ip = client_ip;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	
}

