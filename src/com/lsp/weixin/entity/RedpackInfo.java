package com.lsp.weixin.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 微信红包
 * @author lsp
 *
 */
public class RedpackInfo  extends ReflectionDBObject{
	private String custid;
	private String fromUserid;
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
	 *付款金额  付款金额，单位分
	 */
	private double total_amount;
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
	
	private Date createdate; 
	/**
	 * 0为失败；1为成功
	 */
	private int state;
	/**
	 * 0为摇奖
	 */
	private int lx;
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
	public double getTotal_amount() {
		return total_amount;
	}
	public void setTotal_amount(double total_amount) {
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
	public String getFromUserid() {
		return fromUserid;
	}
	public void setFromUserid(String fromUserid) {
		this.fromUserid = fromUserid;
	}
	public int getLx() {
		return lx;
	}
	public void setLx(int lx) {
		this.lx = lx;
	}
	
}

