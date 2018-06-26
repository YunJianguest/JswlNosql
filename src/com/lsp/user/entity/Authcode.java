package com.lsp.user.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;

/**
 * 验证码
 * @author lsp
 *
 */
public class Authcode extends ReflectionDBObject{ 
	private  String code;
	private  Date   createdate;
	private  Date   activitydate;
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Date getCreatedate() {
		return createdate;
	}

	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}

	public Date getActivitydate() {
		return activitydate;
	}

	public void setActivitydate(Date activitydate) {
		this.activitydate = activitydate;
	}
	
}
