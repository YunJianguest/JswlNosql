package com.lsp.shop.entiy;

import java.util.Date;

import com.mongodb.ReflectionDBObject;

/***
 * 商品分类
 * @author lsp
 *
 */
public class ShopMb  extends ReflectionDBObject{
	/**
	 * 商城名称
	 */
	private String name;
	/**
	 * 商户id
	 */
	private Long   cid;
	/**
	 * 商城logo
	 */
	private String logo;
	/**
	 * 幻灯片
	 */
	private String picurl;
	
	/**
	 * 链接地址
	 */
	private String url;
	
	private String toUser;
	private String custid;
	
	private String summary;
	/**
	 * 包邮价格
	 */
	private float  byprice;
	private int mb;
	/**
	 * 排序
	 */
	private int sort;
	/**
	 * 按钮一
	 */
	private String but1;
	/**
	 * 自定义菜单
	 */
	private String gm1;
	/**
	 * 按钮二
	 */
	private String but2;
	/**
	 * 自定义菜单
	 */
	private String gm2;
	/**
	 * 网店类型，0为普通网店，1为官方网店
	 */
	private int    lx;
	private String searchcolor;
	/**
	 * 网店类型，0为普通网店，1为积分商城
	 */
	private int    type;
	/**
	 * 积分比例
	 */
	private int    jfbl;
	/**
     * 总销售额
     */
    private  double  sales;
    /**
     * 月销售额
     */
    private  double  monthsales;
    /**
     * 日销售额
     */
    private  double  daysales;
    
	 
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLogo() {
		return logo;
	}
	public void setLogo(String logo) {
		this.logo = logo;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public int getMb() {
		return mb;
	}
	public void setMb(int mb) {
		this.mb = mb;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public String getBut1() {
		return but1;
	}
	public void setBut1(String but1) {
		this.but1 = but1;
	}
	public String getGm1() {
		return gm1;
	}
	public void setGm1(String gm1) {
		this.gm1 = gm1;
	}
	public String getBut2() {
		return but2;
	}
	public void setBut2(String but2) {
		this.but2 = but2;
	}
	public String getGm2() {
		return gm2;
	}
	public void setGm2(String gm2) {
		this.gm2 = gm2;
	} 
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public Long getCid() {
		return cid;
	}
	public void setCid(Long cid) {
		this.cid = cid;
	}
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public int getLx() {
		return lx;
	}
	public void setLx(int lx) {
		this.lx = lx;
	}
	public float getByprice() {
		return byprice;
	}
	public void setByprice(float byprice) {
		this.byprice = byprice;
	}
	public String getSearchcolor() {
		return searchcolor;
	}
	public void setSearchcolor(String searchcolor) {
		this.searchcolor = searchcolor;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getJfbl() {
		return jfbl;
	}
	public void setJfbl(int jfbl) {
		this.jfbl = jfbl;
	}
	public double getSales() {
		return sales;
	}
	public void setSales(double sales) {
		this.sales = sales;
	}
	public double getMonthsales() {
		return monthsales;
	}
	public void setMonthsales(double monthsales) {
		this.monthsales = monthsales;
	}
	public double getDaysales() {
		return daysales;
	}
	public void setDaysales(double daysales) {
		this.daysales = daysales;
	}
	
  	
}
