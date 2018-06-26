package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 置顶管理
 * @author lsp
 *
 */
public class Bbsstick extends ReflectionDBObject{
	private Long  bmtid;
	private String custid;
	private String fromUserid;
	private Date createdate;
	private String content;
	/**
	 * 开始时间
	 */
	private Date startdate;
	/**
	 * 结束时间
	 */
	private Date enddate;
	/**
	 * 总消费
	 */
	private Double price;
	/**
	 * 总时长
	 */
	private Long  time;
	
	/**
	 * 状态1为未审核0为已审核
	 */
	private int    state;
	public Long getBmtid() {
		return bmtid;
	}
	public void setBmtid(Long bmtid) {
		this.bmtid = bmtid;
	}
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
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public Long getTime() {
		return time;
	}
	public void setTime(Long time) {
		this.time = time;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	 
	 
}
