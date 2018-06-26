package com.lsp.parttime.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 公司
 * @author lsp
 *
 */
public class Company extends ReflectionDBObject{
	private String custid;
	private String fromid;
	/**
	 * 公司名称
	 */
	private String name;
	/**
	 * 公司LOGO
	 */
	private String logourl;
	/**
	 * 营业执照
	 */
	private String businesslicense;
	/**
	 * 公司电话
	 */
	private String tel;
	/**
	 * 联系人电话
	 */
	private String linktel;
	/**
	 * 联系人姓名
	 */
	private String linkname;
	/**
	 * 公司福利
	 */
	private String welfare;
	private Date createdate;
	private int sort;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLogourl() {
		return logourl;
	}
	public void setLogourl(String logourl) {
		this.logourl = logourl;
	}
	public String getBusinesslicense() {
		return businesslicense;
	}
	public void setBusinesslicense(String businesslicense) {
		this.businesslicense = businesslicense;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getLinktel() {
		return linktel;
	}
	public void setLinktel(String linktel) {
		this.linktel = linktel;
	}
	public String getLinkname() {
		return linkname;
	}
	public void setLinkname(String linkname) {
		this.linkname = linkname;
	}
	public String getWelfare() {
		return welfare;
	}
	public void setWelfare(String welfare) {
		this.welfare = welfare;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	

}
