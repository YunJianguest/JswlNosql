package com.lsp.shop.entiy;

import java.util.Date;
import java.util.List;

import com.mongodb.ReflectionDBObject;
/**
 * 订单编号
 * @author lsp 
 *   
 */
public class OrderForm extends ReflectionDBObject{
	/**
	 * 订单编号
	 */															
	private String no;
						
	private int count;
	/**
	 * 总
	 */
	private float total;
	/**
	 * 支付的金钱
	 */
	private float zfmoney;
	private double money;
	/**
	 * 兑换的积分
	 */
	private float jfdh;
	/**
	 * 商品编号
	 */
	private Long recordid;
	/**
	 * 商品价格
	 */
	private float remoney; 

	/**
	 * 经纬度，经度在前，纬度在后
	 */
	private List<Double> loc;
	/**
	 * 姓名
	 */															
	private String name;
	/**
	 * 电话
	 */															
	private String tel;
	/**
	 * 地址
	 */															
	private String address;
	/**
	 * 预定日期
	 */															
	private String yddate;
	/**
	 * 购买日期
	 */															
	private Date insDate;
	private Date createdate;
	/**
	 * 快递公司
	 */															
	private String kdcom;
	/**
	 * 快递单号
	 */															
	private String kdno;
	private String fromUser;
	private String fromUserid;
	private String toUser;
	/**
	 * 说明
	 */
	private String remark;
	/**
	 * 店铺编号
	 */
	private Long comid;
	/**
	 * 快递费用
	 */
	private double postage;
	/**
	 * 提醒
	 */
	private String remind;
	/**
	 * 状态
	 * 0 购物车 1订单  2 确认 3 发货 4收货 5退货 6 取消
	 */	
	private int state;
	/**
	 * 状态
	 * 0 商品 1选号 2扫码付3优惠劵4砍价 5 代驾
	 */	
	private int lx;
	
	private String province;
	private String city;
	private int ly;
	private String custid;
	private String ids;
	private String counts;
	private String kjid;
	/**
	 * 积分返还
	 */
	private float  jffh;
	/**
	 * 是否显示（0显示1不显示）
	 */
	private int    isxs;
	
	public int getIsxs() {
		return isxs;
	}
	public void setIsxs(int isxs) {
		this.isxs = isxs;
	}
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}
	public String getCounts() {
		return counts;
	}
	public void setCounts(String counts) {
		this.counts = counts;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	
	public float getTotal() {
		return total;
	}
	public void setTotal(float total) {
		this.total = total;
	}
	 
	public double getMoney() {
		return money;
	}
	public void setMoney(double money) {
		this.money = money;
	} 
	public float getJfdh() {
		return jfdh;
	}
	public void setJfdh(float jfdh) {
		this.jfdh = jfdh;
	}
	public Long getRecordid() {
		return recordid;
	}
	public void setRecordid(Long recordid) {
		this.recordid = recordid;
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
	public Date getInsDate() {
		return insDate;
	}
	public void setInsDate(Date insDate) {
		this.insDate = insDate;
	}
	public String getFromUser() {
		return fromUser;
	}
	public void setFromUser(String fromUser) {
		this.fromUser = fromUser;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	
	public List<Double> getLoc() {
		return loc;
	}
	public void setLoc(List<Double> loc) {
		this.loc = loc;
	}
	public String getYddate() {
		return yddate;
	}
	public void setYddate(String yddate) {
		this.yddate = yddate;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getKdno() {
		return kdno;
	}
	public void setKdno(String kdno) {
		this.kdno = kdno;
	}
	
	public int getLx() {
		return lx;
	}
	public void setLx(int lx) {
		this.lx = lx;
	}
	public float getRemoney() {
		return remoney;
	}
	public void setRemoney(float remoney) {
		this.remoney = remoney;
	}
	public Long getComid() {
		return comid;
	}
	public void setComid(Long comid) {
		this.comid = comid;
	}
	public String getKdcom() {
		return kdcom;
	}
	public void setKdcom(String kdcom) {
		this.kdcom = kdcom;
	}
	public String getRemind() {
		return remind;
	}
	public void setRemind(String remind) {
		this.remind = remind;
	}
	public float getZfmoney() {
		return zfmoney;
	}
	public void setZfmoney(float zfmoney) {
		this.zfmoney = zfmoney;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public double getPostage() {
		return postage;
	}
	public void setPostage(double postage) {
		this.postage = postage;
	}
	public String getFromUserid() {
		return fromUserid;
	}
	public void setFromUserid(String fromUserid) {
		this.fromUserid = fromUserid;
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
	public int getLy() {
		return ly;
	}
	public void setLy(int ly) {
		this.ly = ly;
	}
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public String getKjid() {
		return kjid;
	}
	public void setKjid(String kjid) {
		this.kjid = kjid;
	}
	public float getJffh() {
		return jffh;
	}
	public void setJffh(float jffh) {
		this.jffh = jffh;
	}
	 
}