package com.lsp.pub.entity;

import java.util.List;

import com.mongodb.DBObject;
import com.mongodb.ReflectionDBObject;
/**
 * 个人中心模板
 * @author lsp
 *
 */
public class Fromusermb extends ReflectionDBObject{

	private String custid;  
	private int mb;
	private List<DBObject> lsfunc;
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	} 
	public int getMb() {
		return mb;
	}
	public void setMb(int mb) {
		this.mb = mb;
	}
	public List<DBObject> getLsfunc() {
		return lsfunc;
	}
	public void setLsfunc(List<DBObject> lsfunc) {
		this.lsfunc = lsfunc;
	}
	 
	 
	
}
