package com.lsp.suc.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 婚恋实体
 * @author lsp
 *
 */
public class DatingInfo extends ReflectionDBObject{

	private String custid;
	private String fromUserid;
	private String nickname;
	private String headimgurl;
	private String no;
	/**
	 * 省
	 */
	private String province;
	/**
	 * 市
	 */
	private String city;
	/**
	 * QQ号
	 */
	private String qq;
	/**
	 * 微信号
	 */
	private String wx;
	/**
	 * 电话
	 */
	private String tel;
	/**
	 * 交友目的
	 */
	private String purpose;
	/**
	 * 恋爱观念
	 */
	private String concept;
	/**
	 * 首次见面
	 */
	private String firstmeet;
	/**
	 * 喜欢的约会地点
	 */
	private String likeDatingSite;
	/**
	 * 身高
	 */
	private int height;
	/**
	 * 婚姻状态
	 */
	private int marriage;
	/**
	 * 收入
	 */
	private int income;
	/**
	 * 学历
	 */
	private int record;
	/**
	 * 职业
	 */
	private String professional;
	/**
	 * 体重
	 */
	private int weight;
	/**
	 * 星座
	 */
	private String constellation;
	/**
	 * 生日
	 */
	private String birthday;
	private Date   createdate; 
	/**
	 * 性别1为男，2为女,0为未知
	 */
	private int    sex;
	/**
	 * 年龄
	 */
	private int    age;
	/**
	 * 关注度
	 */
	private int    focuscount;
	/**
	 * 区县
	 */
	private String county;
	/**
	 * QQ隐私状态（0为公开，1为保密）
	 */
	private int    qqState;
	/**
	 * 微信隐私状态（0为公开，1为保密）
	 */
	private int    wxState;
	/**
	 * 手机隐私状态（0为公开，1为保密）
	 */
	private int    telState;
	/**
	 * 金币
	 */
	private double money;
	/**
	 * 会员结束日期
	 */
	private Date   endMemberDate;
	/**
	 * 1会员有效，2会员失效
	 */
	private int    member;
	/**
	 * 等级
	 */
	private int    level;
	/**
	 * 头像认证0为未认证，1为已认证
	 */
	private int    headimgrz;
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
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getHeadimgurl() {
		return headimgurl;
	}
	public void setHeadimgurl(String headimgurl) {
		this.headimgurl = headimgurl;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	public String getWx() {
		return wx;
	}
	public void setWx(String wx) {
		this.wx = wx;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getPurpose() {
		return purpose;
	}
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	public String getConcept() {
		return concept;
	}
	public void setConcept(String concept) {
		this.concept = concept;
	}
	public String getFirstmeet() {
		return firstmeet;
	}
	public void setFirstmeet(String firstmeet) {
		this.firstmeet = firstmeet;
	}
	public String getLikeDatingSite() {
		return likeDatingSite;
	}
	public void setLikeDatingSite(String likeDatingSite) {
		this.likeDatingSite = likeDatingSite;
	}  
	public int getMarriage() {
		return marriage;
	}
	public void setMarriage(int marriage) {
		this.marriage = marriage;
	}
	public int getIncome() {
		return income;
	}
	public void setIncome(int income) {
		this.income = income;
	}
	public int getRecord() {
		return record;
	}
	public void setRecord(int record) {
		this.record = record;
	}
	public String getProfessional() {
		return professional;
	}
	public void setProfessional(String professional) {
		this.professional = professional;
	}
	public String getConstellation() {
		return constellation;
	}
	public void setConstellation(String constellation) {
		this.constellation = constellation;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public int getSex() {
		return sex;
	}
	public void setSex(int sex) {
		this.sex = sex;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public int getHeight() {
		return height;
	}
	public void setHeight(int height) {
		this.height = height;
	}
	public int getWeight() {
		return weight;
	}
	public void setWeight(int weight) {
		this.weight = weight;
	}
	public int getFocuscount() {
		return focuscount;
	}
	public void setFocuscount(int focuscount) {
		this.focuscount = focuscount;
	}
	public String getCounty() {
		return county;
	}
	public void setCounty(String county) {
		this.county = county;
	}
	public int getQqState() {
		return qqState;
	}
	public void setQqState(int qqState) {
		this.qqState = qqState;
	}
	public int getWxState() {
		return wxState;
	}
	public void setWxState(int wxState) {
		this.wxState = wxState;
	}
	public int getTelState() {
		return telState;
	}
	public void setTelState(int telState) {
		this.telState = telState;
	}
	public double getMoney() {
		return money;
	}
	public void setMoney(double money) {
		this.money = money;
	}
	public Date getEndMemberDate() {
		return endMemberDate;
	}
	public void setEndMemberDate(Date endMemberDate) {
		this.endMemberDate = endMemberDate;
	}
	public int getMember() {
		return member;
	}
	public void setMember(int member) {
		this.member = member;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public int getHeadimgrz() {
		return headimgrz;
	}
	public void setHeadimgrz(int headimgrz) {
		this.headimgrz = headimgrz;
	}
	
	
}
