package com.lsp.hou.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 服务订单
 * @author lsp
 *
 */
public class HousewiferyOrder extends ReflectionDBObject{

	private String custid;
	/**
	 * 客户id
	 */
	private String fromid;
	/**
	 * 服务人员id
	 */
	private String cleanid;
	/**
	 * 服务类型0为日常保洁1为油烟机清洗
	 */
	private String type;
	/**
	 * 服务开始时间
	 */
    private Date  startdate;
    /**
     * 服务结束时间
     */
    private Date  enddate;
    /**
     * 服务地址
     */
    private String address;
    /**
     * 客户联系电话
     */
    private String tel;
    /**
     * 服务价格
     */
    private double price;
    /**
     * 附加价格
     */
    private double adjunctprice;
    /**
     * 总价
     */
    private double totalprice;
    /**
     * 状态
     */
    private String state;
    /**
     * 备注
     */
    private String remark;
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public String getFromid() {
		return fromid;
	}
	public void setFromid(String fromid) {
		this.fromid = fromid;
	}
	public String getCleanid() {
		return cleanid;
	}
	public void setCleanid(String cleanid) {
		this.cleanid = cleanid;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
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
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public double getAdjunctprice() {
		return adjunctprice;
	}
	public void setAdjunctprice(double adjunctprice) {
		this.adjunctprice = adjunctprice;
	}
	public double getTotalprice() {
		return totalprice;
	}
	public void setTotalprice(double totalprice) {
		this.totalprice = totalprice;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
    
}
