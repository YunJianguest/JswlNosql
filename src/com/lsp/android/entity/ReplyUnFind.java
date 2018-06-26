package com.lsp.android.entity;
 
import com.mongodb.ReflectionDBObject;
/**
 * 未查看的会话
 * @author lsp
 *
 */
public class ReplyUnFind extends ReflectionDBObject{

	private String fromUserid; 
	/**
	 * 会话ID
	 */
	private Long   wid;
	private int    count;
	 
	public String getFromUserid() {
		return fromUserid;
	}
	public void setFromUserid(String fromUserid) {
		this.fromUserid = fromUserid;
	} 
	 
	public Long getWid() {
		return wid;
	}
	public void setWid(Long wid) {
		this.wid = wid;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	
	
}
