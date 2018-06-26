package com.lsp.pub.entity;

import com.mongodb.ReflectionDBObject;
import java.util.Date;
import java.util.List;
/**
 * 资源管理
 * @author lsp 
 *   
 */
public class RoleInfo extends ReflectionDBObject
{
  private String rolename;
  private List<Long> funcList;
  private String remark;
  private Long orgid;
  private String custid;
  private String toUser;
  private Date createdate;
  private String nickname;

  public String getRolename()
  {
    return this.rolename;
  }

  public void setRolename(String rolename) {
    this.rolename = rolename;
  }

  public String getRemark() {
    return this.remark;
  }

  public void setRemark(String remark) {
    this.remark = remark;
  }

  public List<Long> getFuncList() {
    return this.funcList;
  }

  public void setFuncList(List<Long> funcList) {
    this.funcList = funcList;
  }

  public Long getOrgid() {
    return this.orgid;
  }

  public void setOrgid(Long orgid) {
    this.orgid = orgid;
  } 
  public String getCustid() {
	return custid;
  }

  public void setCustid(String custid) {
	this.custid = custid;
  }

  public Date getCreatedate() {
    return this.createdate;
  }

  public void setCreatedate(Date createdate) {
    this.createdate = createdate;
  }

  public String getToUser() {
	return toUser;
}

 public void setToUser(String toUser) {
	this.toUser = toUser;
}

public String getNickname() {
	return nickname;
}

public void setNickname(String nickname) {
	this.nickname = nickname;
}
  
}