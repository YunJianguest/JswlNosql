package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
 /**
  * 婚恋条件
  * @author lsp
  *
  */
public class DatingCondition  extends ReflectionDBObject{
   
	private String fromUserid;
	/**
	 * 开始年龄
	 */
	private int    startAge;
	/**
	 * 结束年龄
	 */
	private int    endAge;
	/**
	 * 开始身高
	 */
	private int    startHeight;
	/**
	 * 结束身高
	 */
	private int    endHeight;
	/**
	 * 学历
	 */
	private int    record;
	/**
	 * 收入
	 */
	private int    income;  
	/**
	 * 区县
	 */
	private String county;
	/**
	 * 省
	 */
	private String province;
	/**
	 * 市
	 */
	private String city;
	/**
	 * 0为男，1为女
	 */
	private int    sex;
	public String getFromUserid() {
		return fromUserid;
	}
	public void setFromUserid(String fromUserid) {
		this.fromUserid = fromUserid;
	}
	public int getStartAge() {
		return startAge;
	}
	public void setStartAge(int startAge) {
		this.startAge = startAge;
	}
	public int getEndAge() {
		return endAge;
	}
	public void setEndAge(int endAge) {
		this.endAge = endAge;
	}
	public int getStartHeight() {
		return startHeight;
	}
	public void setStartHeight(int startHeight) {
		this.startHeight = startHeight;
	}
	public int getEndHeight() {
		return endHeight;
	}
	public void setEndHeight(int endHeight) {
		this.endHeight = endHeight;
	}
	public int getRecord() {
		return record;
	}
	public void setRecord(int record) {
		this.record = record;
	}
	 
	public int getIncome() {
		return income;
	}
	public void setIncome(int income) {
		this.income = income;
	}
	public String getCounty() {
		return county;
	}
	public void setCounty(String county) {
		this.county = county;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public int getSex() {
		return sex;
	}
	public void setSex(int sex) {
		this.sex = sex;
	}
	 
	
 	
}
