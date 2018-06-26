package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 农场卡卷
 * @author lsp
 *
 */
public class FarmCard extends ReflectionDBObject{

	private String custid;
	private String fromUserid;
	/**
	 * 活动产品ID
	 */
	private Long hdid;
	private Date   createdate; 
	private String title;
	/**
	 * 最后兑奖时间
	 */
	private Date enddjdate;
	/**
	 * 开始兑奖时间
	 */
	private Date startdjdate;
	/**
	 * 快递名称
	 */
	private String courierName;
	/**
	 * 快递单号
	 */
	private String courierNo;
	/**
	 * 状态
	 * 0 未对 1 已对 2 过期,3已发货，4已签收
	 */	
	private int    state;
	/**
	 * 奖品唯一兑换码
	 */	
	private String djm;
	private String summary;
	/**
	 * 收货地址
	 * @return
	 */
	private String address;
	/**
	 * 姓名
	 * @return
	 */
	private String name;
	/**
	 * 电话
	 * @return
	 */
	private String tel;
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
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getEnddjdate() {
		return enddjdate;
	}
	public void setEnddjdate(Date enddjdate) {
		this.enddjdate = enddjdate;
	}
	public String getCourierName() {
		return courierName;
	}
	public void setCourierName(String courierName) {
		this.courierName = courierName;
	}
	public String getCourierNo() {
		return courierNo;
	}
	public void setCourierNo(String courierNo) {
		this.courierNo = courierNo;
	}
	public Long getHdid() {
		return hdid;
	}
	public void setHdid(Long hdid) {
		this.hdid = hdid;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public String getDjm() {
		return djm;
	}
	public void setDjm(String djm) {
		this.djm = djm;
	}
	public Date getStartdjdate() {
		return startdjdate;
	}
	public void setStartdjdate(Date startdjdate) {
		this.startdjdate = startdjdate;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	 
	 
}
