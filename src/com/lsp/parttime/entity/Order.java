package com.lsp.parttime.entity; 

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 订单
 * @author lsp
 *
 */
public class Order extends ReflectionDBObject{

	private String custid;
	private String fromid;
	private Date createdate;
	/**
	 * 公司ID
	 */
	private Long comid;
	/**
	 * 公司名称
	 */
	private String company;
	/**
	 * 任务ID
	 */
	private Long mid;
	/**
	 * 任务名称
	 */
	private String mtitle;
	/**
	 * 状态0.已报名1.已拒绝2.进行中3.已完成4.已结算5未完成
	 */
	private int state;
	/**
	 * 金额
	 */
	private double amount;
	/**
	 * 集合时间
	 */
	private Date gatherdate;
	/**
	 * 上班开始时间
	 */
	private Date startdate;
	/**
	 * 上班结束时间
	 */
	private Date enddate;
	/**
	 * 预计工作时长expectworkinghours
	 */
	private int  expectwh;
	/**
	 * 实际工作时长
	 */
	private int  practicalwh;
	/**
	 * 上班地点
	 */
	private String workaddress;
	/**
	 * 单价
	 */
	private double price;
	/**
	 * 结算类型（0为默认即一单多钱，1为小时结算，2为日结算，3为月结算）
	 */
	private int jstype;
	/**
	 * 完结时间
	 */
	private Date updatedate;
	/**
	 * 联系电话
	 */
	private String linktel;
	/**
	 * 时间(统一小时计算)
	 */
	private int  time;
	/**
	 * 总额
	 */
	private double total;
	public Date getGatherdate() {
		return gatherdate;
	}
	public void setGatherdate(Date gatherdate) {
		this.gatherdate = gatherdate;
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
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public Long getComid() {
		return comid;
	}
	public void setComid(Long comid) {
		this.comid = comid;
	}
	public Long getMid() {
		return mid;
	}
	public void setMid(Long mid) {
		this.mid = mid;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public int getExpectwh() {
		return expectwh;
	}
	public void setExpectwh(int expectwh) {
		this.expectwh = expectwh;
	}
	public int getPracticalwh() {
		return practicalwh;
	}
	public void setPracticalwh(int practicalwh) {
		this.practicalwh = practicalwh;
	}
	public String getWorkaddress() {
		return workaddress;
	}
	public void setWorkaddress(String workaddress) {
		this.workaddress = workaddress;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getMtitle() {
		return mtitle;
	}
	public void setMtitle(String mtitle) {
		this.mtitle = mtitle;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public int getJstype() {
		return jstype;
	}
	public void setJstype(int jstype) {
		this.jstype = jstype;
	}
	public Date getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(Date updatedate) {
		this.updatedate = updatedate;
	}
	public String getLinktel() {
		return linktel;
	}
	public void setLinktel(String linktel) {
		this.linktel = linktel;
	}
	public int getTime() {
		return time;
	}
	public void setTime(int time) {
		this.time = time;
	}
	public double getTotal() {
		return total;
	}
	public void setTotal(double total) {
		this.total = total;
	}
	
}
