package com.lsp.web.entity;

import java.util.Date;

import com.mongodb.ReflectionDBObject;
/**
 * 文件通用实体类
 * @author lsp
 *
 */
public class FilesInfo extends ReflectionDBObject{

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
	  /**
	   * 标注各个文件类型（mp3.mp4,txt等）
	   */
	  private String type;
	public Integer getSort() {
		return sort;
	}
	public void setSort(Integer sort) {
		this.sort = sort;
	}
	public String getCustid() {
		return custid;
	}
	public void setCustid(String custid) {
		this.custid = custid;
	}
	public String getToUser() {
		return toUser;
	}
	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContext() {
		return context;
	}
	public void setContext(String context) {
		this.context = context;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public Long getFolderid() {
		return folderid;
	}
	public void setFolderid(Long folderid) {
		this.folderid = folderid;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	  
}
