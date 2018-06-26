package com.lsp.shop.entiy;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 商品推广
 * @author lsp
 *
 */
public class Shoptg  extends ReflectionDBObject{

	private String  custid;
	/**
	 * 店铺ID
	 */
	private Long    comid;
	/**
	 * 商品ID
	 */
	private Long    pid;
	/**
	 * 推广类型
	 */
	private int     lx;
	private Date    createdate;
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public Long getComid() {
		return comid;
	}
	public void setComid(Long comid) {
		this.comid = comid;
	}
	public Long getPid() {
		return pid;
	}
	public void setPid(Long pid) {
		this.pid = pid;
	}
	public int getLx() {
		return lx;
	}
	public void setLx(int lx) {
		this.lx = lx;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	
}
