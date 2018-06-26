package com.lsp.parttime.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 任务
 * @author lsp
 *
 */
public class Mission extends ReflectionDBObject{

	private String title;
	private String custid;
	private String fromid;
	private Long comid;
	/**
	 * 薪资
	 */
	private String wages;
	/**
	 * 工作地点
	 */
	private String workaddress;
	/**
	 * 招聘人数
	 */
	private int num;
	/**
	 * 学历要求
	 */
	private int education;
	/**
	 * 经验要求
	 */
	private int experience;
	/**
	 * 年龄要求
	 */
	private int age;
	/**
	 * 负责人姓名
	 */
	private String linkname;
	/**
	 * 负责人电话
	 */
	private String linktel;
	private int sort;
	private int collect;
	private Date createdate;
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
	 * 描述
	 */
	private String content;
	/**
	 * 福利
	 */
	private String welfare;
	/**
	 * 0平台自营
	 */
	private int type;
	/**
	 * 公司
	 */
	private String company;
	private String summary;
	/**
	 * 区域
	 */
	private String area;
	/**
	 * 单价
	 */
	private double price;
	/**
	 * 结算类型（0为默认即一单多钱，1为小时结算，2为日结算，3为月结算）
	 */
	private int jstype;
	/**
	 * 0为已审核1为未审核
	 */
	private int state;
	 
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	 
	public String getWages() {
		return wages;
	}
	public void setWages(String wages) {
		this.wages = wages;
	}
	public String getWorkaddress() {
		return workaddress;
	}
	public void setWorkaddress(String workaddress) {
		this.workaddress = workaddress;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getEducation() {
		return education;
	}
	public void setEducation(int education) {
		this.education = education;
	}
	public int getExperience() {
		return experience;
	}
	public void setExperience(int experience) {
		this.experience = experience;
	}
	public String getLinkname() {
		return linkname;
	}
	public void setLinkname(String linkname) {
		this.linkname = linkname;
	}
	public String getLinktel() {
		return linktel;
	}
	public void setLinktel(String linktel) {
		this.linktel = linktel;
	}
	public Long getComid() {
		return comid;
	}
	public void setComid(Long comid) {
		this.comid = comid;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public int getCollect() {
		return collect;
	}
	public void setCollect(int collect) {
		this.collect = collect;
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
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWelfare() {
		return welfare;
	}
	public void setWelfare(String welfare) {
		this.welfare = welfare;
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
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	
}
