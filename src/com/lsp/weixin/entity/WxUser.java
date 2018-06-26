package com.lsp.weixin.entity;

import java.util.Date;
import java.util.List;

import com.mongodb.ReflectionDBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
public class WxUser extends ReflectionDBObject{
	/**
	 * 微信用户
	 */
	private String toUser;
	/**
	 * 是否为管理员
	 * 
	 */
	private boolean  isadmin;
	/**
	 * 平台账号
	 */
	private String custid;
	/**
	 * 绑定号
	 */
	private String sno;
	/**
	 * 绑定密码
	 */
	private String password;
	/**
	 * 微信公众帐号
	 */
	private String fromUser;
	/**
	 * QQ号
	 */
	private String qqfromUser;
	/**
	 * 微信id
	 */
	private String wxid;
	
	/**
	 * 会员号
	 */
	private String no;
	
	private String comname;
	private String name;
	private String qq;
	private String email;
	/**
	 * 用户照片
	 */
	private String userimg;
	private String sfz;
	private Date birthday;
	private String sfzpic;
	private String tel;
	private String address;
	/**
	 * 用户的昵称
	 */
	private String nickname;
	/**
	 * 用户的性别，值为1时是男性，值为2时是女性，值为0时是未知 
	 */
	private String sex;
	/**
	 * 用户所在城市
	 */
	private String city;

	/**
	 * 用户所在县
	 */
	private String county;
	/**
	 * 用户所在国家
	 */
	private String country;
	/**
	 * 用户所在省份 
	 */
	private String province;
	 
	/**
	 * 用户的语言，简体中文为zh_CN 
	 */
	private String language;
	/**
	 * 用户头像，最后一个数值代表正方形头像大小（有0、46、64、96、132数值可选，0代表640*640正方形头像），用户没有头像时该项为空 
	 */
	private String headimgurl;
	/**
	 * 经纬度，经度在前，纬度在后
	 */
	private List<Double> loc;
	private Date createdate;
	
	/**
	 * 0 默认 
	 */
	private int lx;
	
	private Long wid;
	
	private String comUser;
	/**
	 * 来源
	 */
	private int ly;
	/**
	 * 其他来源同步用户
	 */
	private String qtUser;
	private int groupid;
	 
	/**
	 * 序号
	 */
	private int xh;
	
	/**
	 * 积分
	 * @return
	 */
	private int  jf;
	/**
	 * 等级
	 * @return
	 */
	private int   level;
	/**
	 * 论坛帖子
	 */
	private Long   bbscount;
	/**
	 * 徽章
	 */
	private String levelimgurl;
	/**
	 * 累计总经验
	 * @return
	 */
	private int  experience;
	/**
	 * 升级需要经验
	 */
	private int  needExperience;
	/**
	 * 当前获得经验
	 */
	private int  getExperience;
	/**
	 * 心情
	 * @return
	 */
	private String humor;
	private boolean isqqvip;
	private boolean isqqhz;
	private int     qqHzdj;
	private String loginname;
	private String loginpasswd;
	private String    expbl; 
	private Long    tackcount;
	/**
	 * 是否是安卓管理员
	 */
	private int     androidAdmin; 
	/**
	 * 是否在线0不在线1在线
	 */
	private int     online;
	public int getNeedExperience() {
		return needExperience;
	}
	public void setNeedExperience(int needExperience) {
		this.needExperience = needExperience;
	}
	public int getGetExperience() {
		return getExperience;
	}
	public void setGetExperience(int getExperience) {
		this.getExperience = getExperience;
	}
	public String getHumor() {
		return humor;
	}
	public void setHumor(String humor) {
		this.humor = humor;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public String getLevelimgurl() {
		return levelimgurl;
	}
	public void setLevelimgurl(String levelimgurl) {
		this.levelimgurl = levelimgurl;
	}
	public int getExperience() {
		return experience;
	}
	public void setExperience(int experience) {
		this.experience = experience;
	}
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public String getSno() {
		return sno;
	}
	public void setSno(String sno) {
		this.sno = sno;
	}
	public String getFromUser() {
		return fromUser;
	}
	public void setFromUser(String fromUser) {
		this.fromUser = fromUser;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getHeadimgurl() {
		return headimgurl;
	}
	public void setHeadimgurl(String headimgurl) {
		this.headimgurl = headimgurl;
	}
	public List<Double> getLoc() {
		return loc;
	}
	public void setLoc(List<Double> loc) {
		this.loc = loc;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public Long getWid() {
		return wid;
	}
	public void setWid(Long wid) {
		this.wid = wid;
	}
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	public String getSfz() {
		return sfz;
	}
	public void setSfz(String sfz) {
		this.sfz = sfz;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	
	public String getComname() {
		return comname;
	}
	public void setComname(String comname) {
		this.comname = comname;
	}
	
	public String getCounty() {
		return county;
	}
	public void setCounty(String county) {
		this.county = county;
	}
	
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	public int getGroupid() {
		return groupid;
	}
	public void setGroupid(int groupid) {
		this.groupid = groupid;
	}
	 
	public String getComUser() {
		return comUser;
	}
	public void setComUser(String comUser) {
		this.comUser = comUser;
	}
	public int getLx() {
		return lx;
	}
	public void setLx(int lx) {
		this.lx = lx;
	}
	public String getSfzpic() {
		return sfzpic;
	}
	public void setSfzpic(String sfzpic) {
		this.sfzpic = sfzpic;
	}
	 
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getQtUser() {
		return qtUser;
	}
	public void setQtUser(String qtUser) {
		this.qtUser = qtUser;
	}
	public String getUserimg() {
		return userimg;
	}
	public void setUserimg(String userimg) {
		this.userimg = userimg;
	}
	public int getLy() {
		return ly;
	}
	public void setLy(int ly) {
		this.ly = ly;
	}
	 
	public int getXh() {
		return xh;
	}
	public void setXh(int xh) {
		this.xh = xh;
	}
	public int getJf() {
		return jf;
	}
	public void setJf(int jf) {
		this.jf = jf;
	}
	public String getQqfromUser() {
		return qqfromUser;
	}
	public void setQqfromUser(String qqfromUser) {
		this.qqfromUser = qqfromUser;
	}
	public boolean isIsqqvip() {
		return isqqvip;
	}
	public void setIsqqvip(boolean isqqvip) {
		this.isqqvip = isqqvip;
	}
	public boolean isIsqqhz() {
		return isqqhz;
	}
	public void setIsqqhz(boolean isqqhz) {
		this.isqqhz = isqqhz;
	}
	public int getQqHzdj() {
		return qqHzdj;
	}
	public void setQqHzdj(int qqHzdj) {
		this.qqHzdj = qqHzdj;
	}
	public String getLoginname() {
		return loginname;
	}
	public void setLoginname(String loginname) {
		this.loginname = loginname;
	}
	public String getLoginpasswd() {
		return loginpasswd;
	}
	public void setLoginpasswd(String loginpasswd) {
		this.loginpasswd = loginpasswd;
	}
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public Long getBbscount() {
		return bbscount;
	}
	public void setBbscount(Long bbscount) {
		this.bbscount = bbscount;
	}
	public boolean isIsadmin() {
		return isadmin;
	}
	public void setIsadmin(boolean isadmin) {
		this.isadmin = isadmin;
	}
	public String getExpbl() {
		return expbl;
	}
	public void setExpbl(String expbl) {
		this.expbl = expbl;
	}
	public Long getTackcount() {
		return tackcount;
	}
	public void setTackcount(Long tackcount) {
		this.tackcount = tackcount;
	}
	public String getWxid() {
		return wxid;
	}
	public void setWxid(String wxid) {
		this.wxid = wxid;
	}
	public int getAndroidAdmin() {
		return androidAdmin;
	}
	public void setAndroidAdmin(int androidAdmin) {
		this.androidAdmin = androidAdmin;
	}
	public int getOnline() {
		return online;
	}
	public void setOnline(int online) {
		this.online = online;
	} 
	
}
