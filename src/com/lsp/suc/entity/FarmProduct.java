package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 农产品
 * @author lsp
 *
 */
public class FarmProduct extends ReflectionDBObject{

	private String custid;
	private String title;
	private String picurl;
	private String summary;
	/**
	 * 总成长值
	 */
	private int  growth;
	/**
	 * 当前成长值
	 */
	private int  nowgrowth;
	/**
	 * 成长速度（每小时）
	 */
	private int  speed;
	/**
	 * 魅力值
	 */
	private int  charm;
	/**
	 * 价格
	 */
	private double price;
	private int    sort;
	private Date   createdate;
	private String ewmurl;
	/**
	 * 库存
	 */
	private int    num;
	/**
	 * 售量
	 */
	private int    gmnum;
	/**
	 * 根据分类自动生成生长期图片
	 */
	private String    type;
	/**
	 * 奖项说明
	 */
	private String    awardsshow;
	/**
	 * 玩法说明
	 */
	private String    content;
	/**
	 * 开始时间
	 */
	private Date      startdate;
	/**
	 * 结束时间
	 */
	private Date      enddate;
	/**
	 * 开始兑奖时间
	 */
	private Date      startdjdate;
	/**
	 * 结束兑奖时间
	 */
	private Date      enddjdate;
	/**
	 * 赞助商
	 */
	private String    sponsors;
	/**
	 * 运营者
	 */
	private String    operators;
	
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getGrowth() {
		return growth;
	}
	public void setGrowth(int growth) {
		this.growth = growth;
	}
	public int getSpeed() {
		return speed;
	}
	public void setSpeed(int speed) {
		this.speed = speed;
	}
	public int getCharm() {
		return charm;
	}
	public void setCharm(int charm) {
		this.charm = charm;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public String getEwmurl() {
		return ewmurl;
	}
	public void setEwmurl(String ewmurl) {
		this.ewmurl = ewmurl;
	}
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getGmnum() {
		return gmnum;
	}
	public void setGmnum(int gmnum) {
		this.gmnum = gmnum;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public int getNowgrowth() {
		return nowgrowth;
	}
	public void setNowgrowth(int nowgrowth) {
		this.nowgrowth = nowgrowth;
	}
	public String getAwardsshow() {
		return awardsshow;
	}
	public void setAwardsshow(String awardsshow) {
		this.awardsshow = awardsshow;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getStartdate() {
		return startdate;
	}
	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}
	 
	public Date getStartdjdate() {
		return startdjdate;
	}
	public void setStartdjdate(Date startdjdate) {
		this.startdjdate = startdjdate;
	}
	 
	public String getSponsors() {
		return sponsors;
	}
	public void setSponsors(String sponsors) {
		this.sponsors = sponsors;
	}
	public String getOperators() {
		return operators;
	}
	public void setOperators(String operators) {
		this.operators = operators;
	}
	public Date getEnddate() {
		return enddate;
	}
	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}
	public Date getEnddjdate() {
		return enddjdate;
	}
	public void setEnddjdate(Date enddjdate) {
		this.enddjdate = enddjdate;
	}
	
}
