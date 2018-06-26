package com.lsp.android.entity;

import java.util.Date;
import java.util.List;

import com.mongodb.ReflectionDBObject;
/**
 * 会话
 * @author lsp
 *
 */
public class Reply extends ReflectionDBObject{

	private String custid;
	private String fromUserid; 
	private String title;
	private String ids;
	/**
	 * 不显示的ID
	 */
	private String noids;
	private Long pid;
	private Date   createdate;
	private Date   endupdate; 
	private String  endmsg;
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
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	} 
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}
	public String getFromUserid() {
		return fromUserid;
	}
	public void setFromUserid(String fromUserid) {
		this.fromUserid = fromUserid;
	}
	public Long getPid() {
		return pid;
	}
	public void setPid(Long pid) {
		this.pid = pid;
	}
	public String getNoids() {
		return noids;
	}
	public void setNoids(String noids) {
		this.noids = noids;
	}
	public String getEndmsg() {
		return endmsg;
	}
	public void setEndmsg(String endmsg) {
		this.endmsg = endmsg;
	}
	public Date getEndupdate() {
		return endupdate;
	}
	public void setEndupdate(Date endupdate) {
		this.endupdate = endupdate;
	}
	 
	
	
}
