package com.lsp.shop.entiy;

import java.util.Date;

import com.mongodb.ReflectionDBObject;

/***
 * 店铺客服
 * @author lsp
 *
 */
public class ShopCustService  extends ReflectionDBObject{
	  private String custid;
	  /**
	   * 店铺编号
	   */
	  private Long   wid;
	  private String fromUserid;
	  private String headimgurl;
	  private String nickname;
	  private Date   createdate;
	  public String getCustid() {
		return custid;
	  }
	  public void setCustid(String custid) {
		this.custid = custid;
	  }
	  
	   public Long getWid() {
		return wid;
	  }
	  public void setWid(Long wid) {
		this.wid = wid;
	  }
	  public String getFromUserid() {
		return fromUserid;
	  }
	  public void setFromUserid(String fromUserid) {
		this.fromUserid = fromUserid;
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
	  public Date getCreatedate() {
		return createdate;
	  }
	  public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	  }
	  
  	
}
