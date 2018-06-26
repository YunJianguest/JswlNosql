package com.lsp.shop.entiy;
 
import java.util.Date; 
import com.mongodb.ReflectionDBObject;
/**
 * 砍价预定
 * @author lsp
 *
 */
public class Bargainingyd extends ReflectionDBObject{
	private String  custid;
	private String  fromUserid;  
	private Date    createdate;
	private Long    pid;
	private ProductInfo  pro;
	/**
	 * 0未兑换，1已兑换
	 */
	private int     state;
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
	 
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public ProductInfo getPro() {
		return pro;
	}
	public void setPro(ProductInfo pro) {
		this.pro = pro;
	}
	public Long getPid() {
		return pid;
	}
	public void setPid(Long pid) {
		this.pid = pid;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	 
	 
	 
}
