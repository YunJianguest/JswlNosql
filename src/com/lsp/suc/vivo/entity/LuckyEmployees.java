package com.lsp.suc.vivo.entity; 
import java.util.Date;

import com.mongodb.ReflectionDBObject;
/***
 * 摇奖员工
 * @author lsp
 *
 */
public class LuckyEmployees extends ReflectionDBObject{
 
	private String custid;
	private String name;
	private String fromid;
	private String tel;
	/**
	 * 中奖次数
	 */
	private int count;
	private String address;
	private Date createdate;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getFromid() {
		return fromid;
	}
	public void setFromid(String fromid) {
		this.fromid = fromid;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	
}
