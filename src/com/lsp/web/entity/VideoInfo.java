package com.lsp.web.entity;

import com.mongodb.ReflectionDBObject;
import java.util.Date;
/***
 * 资源管理
 * @author lsp
 *
 */
public class VideoInfo extends ReflectionDBObject {
	private Integer sort;
	private String custid;
	private String toUser;
	private String title;
	private String context;
	private String summary;
	private String url;
	private String path;
	private Date createdate;
	private Long folderid;
	private String type;
	private Long parentid;
	private String position;
	private String state;
	private Long  webid;

	
	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Long getWebid() {
		return webid;
	}

	public void setWebid(Long webid) {
		this.webid = webid;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public Long getParentid() {
		return parentid;
	}

	public void setParentid(Long parentid) {
		this.parentid = parentid;
	}

	public Integer getSort() {
		return this.sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public String getCustid() {
		return this.custid;
	}

	public void setCustid(String custid) {
		this.custid = custid;
	}

	public String getToUser() {
		return this.toUser;
	}

	public void setToUser(String toUser) {
		this.toUser = toUser;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContext() {
		return this.context;
	}

	public void setContext(String context) {
		this.context = context;
	}

	public String getSummary() {
		return this.summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getPath() {
		return this.path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Date getCreatedate() {
		return this.createdate;
	}

	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}

	public Long getFolderid() {
		return this.folderid;
	}

	public void setFolderid(Long folderid) {
		this.folderid = folderid;
	}
}