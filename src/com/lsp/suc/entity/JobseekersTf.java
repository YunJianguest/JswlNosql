package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 简历投放管理
 * @author lsp
 *
 */
public class JobseekersTf  extends ReflectionDBObject{

	private String custid;
	private String fromUserid;
	/**
	 * 简历ID
	 */
    private Long    seeid;
    /**
     * 投放公司ID
     */
    private Long    comid;
    /**
     * 0已审核1未审核2同意3拒绝
     */
    private int     state;
    private Date    createdate;
    /**
     * 审核时间
     */
    private Date    setdate;
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
	public Long getSeeid() {
		return seeid;
	}
	public void setSeeid(Long seeid) {
		this.seeid = seeid;
	}
	public Long getComid() {
		return comid;
	}
	public void setComid(Long comid) {
		this.comid = comid;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public Date getSetdate() {
		return setdate;
	}
	public void setSetdate(Date setdate) {
		this.setdate = setdate;
	} 
	 
}
