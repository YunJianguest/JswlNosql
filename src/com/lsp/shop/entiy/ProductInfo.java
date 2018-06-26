package com.lsp.shop.entiy;

import java.util.Date;

import com.mongodb.ReflectionDBObject;


/***
 *  商品详情
 * @author lsp
 *
 */
public class ProductInfo extends ReflectionDBObject{
	/**
	 * 标题
	 */															
	private String ptitle;
	/**
	 * 产品编码
	 */															
	private String no;
	
	/**
	 * 标签
	 */															
	private int bq;
	/**
	 * 数量
	 */															
	private int num;
	/**
	 * 购买数量
	 */															
	private int gmnum;
	/**
	 * 价格
	 */															
	private Double price;
	/**
	 * 原价格
	 */															
	private Double oldprice;
	/**
	 * 图片。  
	 */
	private String logo;
	/**
	 * 图片链接，支持JPG、PNG格式，较好的效果为大图640*320，小图80*80。  
	 */
	private String picUrl;

	/**
	 * 产品链接地址
	 */
	private String url;
	
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
	 * 摘要
	 */															
	private String summary;
	/**
	 * context
	 */															
	private String context;
	/**
	 * 活动规则
	 */
	private String rule;
	/**
	 * 消息类型
	 */
	private String type;
	
	private Date createdate;

	private Long comid;
	private String toUser;
	private int sort;
	private int mb;
	/**
	 * 购买次数   0 无限制  1一次 2 次  3次
	 */
	private int gmcs;
	/**
	 * 提醒
	 */
	private String remind;
	private String custid;
	/**
	 * 推广类型1为左图，2为右上3为右下
	 */
	private int   tglx;
	/**
	 * 行业类型
	 * @return
	 */
	private String hylx;
	/**
	 * 每次砍价
	 */
	private float   kjprice;
	/**
	 * 最低砍价
	 */
	private float   lowprice;
	/**
	 * 参团人数
	 */
	private int     pcount;
	/**
	 * 团购价格
	 */
	private float   pprice;
	/**
	 * 提供公司
	 * @return
	 */
	private String  unit;
	/**
	 * 快递价格
	 */
	private float   kdprice;
	/**
	 * 积分返还
	 */
	private float   jffh;
	/**
	 * 是否显示0为显示，1为不显示
	 */
	private int      isxs;
	/**
	 * 积分兑换
	 */
	private float    jfdh;
	/**
	 * 代理price
	 */
	private double   dlprice;
	public String getPtitle() {
		return ptitle;
	}
	public void setPtitle(String ptitle) {
		this.ptitle = ptitle;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
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
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public Double getOldprice() {
		return oldprice;
	}
	public void setOldprice(Double oldprice) {
		this.oldprice = oldprice;
	}
	public String getLogo() {
		return logo;
	}
	public void setLogo(String logo) {
		this.logo = logo;
	}
	public String getPicUrl() {
		return picUrl;
	}
	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
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
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public String getContext() {
		return context;
	}
	public void setContext(String context) {
		this.context = context;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
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
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public int getBq() {
		return bq;
	}
	public void setBq(int bq) {
		this.bq = bq;
	}
	public int getMb() {
		return mb;
	}
	public void setMb(int mb) {
		this.mb = mb;
	}
	public int getGmcs() {
		return gmcs;
	}
	public void setGmcs(int gmcs) {
		this.gmcs = gmcs;
	}
	public String getRemind() {
		return remind;
	}
	public void setRemind(String remind) {
		this.remind = remind;
	}
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public int getTglx() {
		return tglx;
	}
	public void setTglx(int tglx) {
		this.tglx = tglx;
	}
	public String getHylx() {
		return hylx;
	}
	public void setHylx(String hylx) {
		this.hylx = hylx;
	}
	public float getKjprice() {
		return kjprice;
	}
	public void setKjprice(float kjprice) {
		this.kjprice = kjprice;
	}
	public float getLowprice() {
		return lowprice;
	}
	public void setLowprice(float lowprice) {
		this.lowprice = lowprice;
	}
	public String getRule() {
		return rule;
	}
	public void setRule(String rule) {
		this.rule = rule;
	}
	public int getPcount() {
		return pcount;
	}
	public void setPcount(int pcount) {
		this.pcount = pcount;
	}
	public float getPprice() {
		return pprice;
	}
	public void setPprice(float pprice) {
		this.pprice = pprice;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public float getKdprice() {
		return kdprice;
	}
	public void setKdprice(float kdprice) {
		this.kdprice = kdprice;
	}
	public float getJffh() {
		return jffh;
	}
	public void setJffh(float jffh) {
		this.jffh = jffh;
	}
	public int getIsxs() {
		return isxs;
	}
	public void setIsxs(int isxs) {
		this.isxs = isxs;
	}
	public float getJfdh() {
		return jfdh;
	}
	public void setJfdh(float jfdh) {
		this.jfdh = jfdh;
	}
	public double getDlprice() {
		return dlprice;
	}
	public void setDlprice(double dlprice) {
		this.dlprice = dlprice;
	}
	
	 
}
