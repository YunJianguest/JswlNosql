package com.lsp.suc.vivo.entity;

import java.util.Date; 
import com.mongodb.ReflectionDBObject;
/**
 * 排行榜
 * @author lsp
 *
 */
public class LeaderBoard extends ReflectionDBObject{

	private String fromid; 
	private String headimgurl;
	private String nickname;
	private String address;
	private Date updatedate; 
	/**
	 * 名次
	 */
	private int ranking;
	/**
	 * 数量
	 */
	private int count;
	public String getFromid() {
		return fromid;
	}
	public void setFromid(String fromid) {
		this.fromid = fromid;
	}
	public String getHeadimgurl() {
		return headimgurl;
	}
	public void setHeadimgurl(String headimgurl) {
		this.headimgurl = headimgurl;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public Date getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(Date updatedate) {
		this.updatedate = updatedate;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getRanking() {
		return ranking;
	}
	public void setRanking(int ranking) {
		this.ranking = ranking;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	 
	
}
