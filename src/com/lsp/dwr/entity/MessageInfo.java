package com.lsp.dwr.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 资源管理
 * @author lsp 
 *   
 */
public class MessageInfo extends ReflectionDBObject{
	private String msg;  
    private Date insdate;
    private String   fromuserid;
    private String   fromuserimg;
    private String   touserid;
    private String   touserimg;
    private String   toUser;
    //1公聊2私聊
    private String   type;
    //房间
    private Long      roomid;
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Date getInsdate() {
		return insdate;
	}
	public void setInsdate(Date insdate) {
		this.insdate = insdate;
	}
	 
	 
	public String getFromuserid() {
		return fromuserid;
	}
	public void setFromuserid(String fromuserid) {
		this.fromuserid = fromuserid;
	}
	public String getTouserid() {
		return touserid;
	}
	public void setTouserid(String touserid) {
		this.touserid = touserid;
	}
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public Long getRoomid() {
		return roomid;
	}
	public void setRoomid(Long roomid) {
		this.roomid = roomid;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getFromuserimg() {
		return fromuserimg;
	}
	public void setFromuserimg(String fromuserimg) {
		this.fromuserimg = fromuserimg;
	}
	public String getTouserimg() {
		return touserimg;
	}
	public void setTouserimg(String touserimg) {
		this.touserimg = touserimg;
	}
    

}
