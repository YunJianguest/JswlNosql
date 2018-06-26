package com.lsp.weixin.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;

/***
 * 资源管理
 * @author lsp
 *
 */
public class OilInfo  extends ReflectionDBObject{
	/**
	 * 省市
	 */
	private String province;
	
	private String oil90;
	private String oil93;
	private String oil97;
	private String oil0;
	private long insdate;
	
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getOil90() {
		return oil90;
	}
	public void setOil90(String oil90) {
		this.oil90 = oil90;
	}
	public String getOil93() {
		return oil93;
	}
	public void setOil93(String oil93) {
		this.oil93 = oil93;
	}
	public String getOil97() {
		return oil97;
	}
	public void setOil97(String oil97) {
		this.oil97 = oil97;
	}
	public String getOil0() {
		return oil0;
	}
	public void setOil0(String oil0) {
		this.oil0 = oil0;
	}
	public long getInsdate() {
		return insdate;
	}
	public void setInsdate(long insdate) {
		this.insdate = insdate;
	}
	
}
