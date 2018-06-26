package com.lsp.suc.entity;

import com.mongodb.ReflectionDBObject;

/**
 * 积分总计
 * @author lsp
 *
 */
public class IntegralRecord extends ReflectionDBObject {
	private String  custid; 
	private String  fromUserid;
	private float   value;
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public String getFromUserid() {
		return fromUserid;
	}
	public void setFromUserid(String fromUserid) {
		this.fromUserid = fromUserid;
	}
	public float getValue() {
		return value;
	}
	public void setValue(float value) {
		this.value = value;
	}
	

}
