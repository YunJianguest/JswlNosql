package com.lsp.suc.entity;

import java.util.Date;
import java.util.List;

import com.mongodb.ReflectionDBObject;

/***
 *  公司管理
 * @author lsp
 *
 */
public class CompanyInfo extends ReflectionDBObject{
	/**
	 * 企业名字
	 */															
	private String name; 
	/**
	 * 关键字
	 */															
	private String keyword;
	/**
	 * 企业地址
	 */															
	private String address;
	/**
	 * 400电话
	 */															
	private String tel400;
	/**
	 * 电话
	 */															
	private String tel;
	/**
	 * 联系人
	 */															
	private String lxr;
	/**
	 * 联系人电话
	 */															
	private String lxrtel;
	/**
	 * 营业时间
	 */															
	private String yxtime;
	/**
	 * 服务项目
	 */															
	private String fwxm;
	/**
	 * 经纬度，经度在前，纬度在后
	 */
	
	private List<Double> loc;
	/**
	 * 图片链接，支持JPG、PNG格式，较好的效果为大图640*320，小图80*80。  
	 */
	private String picurl;
	/**
	 * 企业logo
	 * */
	private String logo;
	/**
	 * 行业
	 */															
	private String type;
	/**
	 * 区域
	 */															
	private String area;
	/**
	 * 推荐标记
	 */															
	private String lx;
	
	/**
	 * 摘要
	 */															
	private String summary;
	/**
	 * context
	 */															
	private String context;
	/**
	 * 交通线路
	 */															
	private String jtxl;
	
	private Date createdate;
	private Date startdate;
	private Date enddate;
	private String custid;
	private String toUser; 
	/**
	 * 链接地址
	 */
	private String toUserid;
	/**
	 *微信账号toUser 
	 */
	private String toUserno;
	/**
	 *AppID(应用ID)
	 */
	private String appID;
	/**
	 *AppSecret(应用密钥)
	 */
	private String appSecret;
	private String mbname;
	private int sort;
	/**
	 * 关注logo
	 * */
	private String gzlogo;
	private String gzsm;
	private String gzurl;
	private String gztitle;
	
	private int mb;
	private int css;
	private String mp3;
	/**
	 * 是否显示   0 显示  1 不显示 2 待审核
	 */
	private int xs;
	/**
	 * 评分
	 */
	private float pf;
	private String fromUser;
	private String fromUserid;
	private int    reading;
	/**
	 * 支付等级
	 */
	private int    paylevel;
	private float  zfmoney;
	private String url; 
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	
	public List<Double> getLoc() {
		return loc;
	}
	public void setLoc(List<Double> loc) {
		this.loc = loc;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public String getPicurl() {
		return picurl;
	}
	public void setPicurl(String picurl) {
		this.picurl = picurl;
	}
	public String getContext() {
		return context;
	}
	public void setContext(String context) {
		this.context = context;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getJtxl() {
		return jtxl;
	}
	public void setJtxl(String jtxl) {
		this.jtxl = jtxl;
	}
	public String getLogo() {
		return logo;
	}
	public void setLogo(String logo) {
		this.logo = logo;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public int getMb() {
		return mb;
	}
	public String getMbname() {
		return mbname;
	}
	public void setMbname(String mbname) {
		this.mbname = mbname;
	}
	public void setMb(int mb) {
		this.mb = mb;
	}
	public String getToUserid() {
		return toUserid;
	}
	public void setToUserid(String toUserid) {
		this.toUserid = toUserid;
	}
	public String getMp3() {
		return mp3;
	}
	public void setMp3(String mp3) {
		this.mp3 = mp3;
	}
	public Date getEnddate() {
		return enddate;
	}
	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}
	public String getToUserno() {
		return toUserno;
	}
	public void setToUserno(String toUserno) {
		this.toUserno = toUserno;
	}
	
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	
	public int getXs() {
		return xs;
	}
	public void setXs(int xs) {
		this.xs = xs;
	}
	public String getAppID() {
		return appID;
	}
	public void setAppID(String appID) {
		this.appID = appID;
	}
	public String getAppSecret() {
		return appSecret;
	}
	public void setAppSecret(String appSecret) {
		this.appSecret = appSecret;
	}
	public String getLx() {
		return lx;
	}
	public void setLx(String lx) {
		this.lx = lx;
	}
	public String getTel400() {
		return tel400;
	}
	public void setTel400(String tel400) {
		this.tel400 = tel400;
	}
	public String getLxr() {
		return lxr;
	}
	public void setLxr(String lxr) {
		this.lxr = lxr;
	}
	public String getLxrtel() {
		return lxrtel;
	}
	public void setLxrtel(String lxrtel) {
		this.lxrtel = lxrtel;
	}
	public String getYxtime() {
		return yxtime;
	}
	public void setYxtime(String yxtime) {
		this.yxtime = yxtime;
	}
	public String getFwxm() {
		return fwxm;
	}
	public void setFwxm(String fwxm) {
		this.fwxm = fwxm;
	}
	public String getGzlogo() {
		return gzlogo;
	}
	public void setGzlogo(String gzlogo) {
		this.gzlogo = gzlogo;
	}
	public String getGzsm() {
		return gzsm;
	}
	public void setGzsm(String gzsm) {
		this.gzsm = gzsm;
	}
	public String getGzurl() {
		return gzurl;
	}
	public void setGzurl(String gzurl) {
		this.gzurl = gzurl;
	}
	public int getCss() {
		return css;
	}
	public void setCss(int css) {
		this.css = css;
	}
	public String getGztitle() {
		return gztitle;
	}
	public void setGztitle(String gztitle) {
		this.gztitle = gztitle;
	}
	public float getPf() {
		return pf;
	}
	public void setPf(float pf) {
		this.pf = pf;
	}
	public String getFromUser() {
		return fromUser;
	}
	public void setFromUser(String fromUser) {
		this.fromUser = fromUser;
	}
	public String getFromUserid() {
		return fromUserid;
	}
	public void setFromUserid(String fromUserid) {
		this.fromUserid = fromUserid;
	}
	public int getReading() {
		return reading;
	}
	public void setReading(int reading) {
		this.reading = reading;
	}
	public Date getStartdate() {
		return startdate;
	}
	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}
	 
	public int getPaylevel() {
		return paylevel;
	}
	public void setPaylevel(int paylevel) {
		this.paylevel = paylevel;
	}
	public float getZfmoney() {
		return zfmoney;
	}
	public void setZfmoney(float zfmoney) {
		this.zfmoney = zfmoney;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	} 
	
}
