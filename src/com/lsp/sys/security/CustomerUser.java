package com.lsp.sys.security;

import com.mongodb.DBObject;
import java.util.List;
import java.util.Map;
import org.springframework.security.GrantedAuthority;
import org.springframework.security.userdetails.User;
/***
 * 资源管理
 * @author lsp
 *
 */
public class CustomerUser extends User
{
  private static final long serialVersionUID = 1L;
  private String id;
  private Long orgid;
  private Long roleid;
  private String orgname;
  private String loginname;
  private String custid;
  private String custname;
  private String telPhone;
  private String email;
  private String AppId;
  private String AppSecret;
  private String toUser;
  private String school;
  private String grade;
  private String classes;
  private Long comid;
  private String wwzqx;
  private List<DBObject> mpfunc;
  private int type;
  private int css;
  private Map<String, String> currentCompanyInfo;
  private String area;
  private String province;
  private String city;

  public String getTelPhone()
  {
    return this.telPhone;
  }
  public void setTelPhone(String telPhone) {
    this.telPhone = telPhone;
  }
  public String getEmail() {
    return this.email;
  }
  public void setEmail(String email) {
    this.email = email;
  }

  public Map<String, String> getCurrentCompanyInfo() {
    return this.currentCompanyInfo;
  }
  public void setCurrentCompanyInfo(Map<String, String> currentCompanyInfo) {
    this.currentCompanyInfo = currentCompanyInfo;
  }

  public CustomerUser(String id, String username, String password, boolean enabled, boolean accountNonExpired, boolean credentialsNonExpired, boolean accountNonLocked, GrantedAuthority[] authorities)
  {
    super(username, password, enabled, accountNonExpired, 
      credentialsNonExpired, accountNonLocked, authorities);
    this.id = id;
  }

  public String getId() {
    return this.id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getLoginname() {
    return this.loginname;
  }
  public void setLoginname(String loginname) {
    this.loginname = loginname;
  }
  public String getCustname() {
    return this.custname;
  }
  public void setCustname(String custname) {
    this.custname = custname;
  }
  public Long getOrgid() {
    return this.orgid;
  }
  public void setOrgid(Long orgid) {
    this.orgid = orgid;
  }
  public String getAppId() {
    return this.AppId;
  }
  public void setAppId(String appId) {
    this.AppId = appId;
  }
  public String getAppSecret() {
    return this.AppSecret;
  }
  public void setAppSecret(String appSecret) {
    this.AppSecret = appSecret;
  }
  public String getToUser() {
    return this.toUser;
  }
  public void setToUser(String toUser) {
    this.toUser = toUser;
  }
  public static long getSerialversionuid() {
    return 1L;
  }
  public String getSchool() {
    return this.school;
  }
  public void setSchool(String school) {
    this.school = school;
  }
  public String getGrade() {
    return this.grade;
  }
  public void setGrade(String grade) {
    this.grade = grade;
  }
  public String getClasses() {
    return this.classes;
  }
  public void setClasses(String classes) {
    this.classes = classes;
  }
  public String getOrgname() {
    return this.orgname;
  }
  public void setOrgname(String orgname) {
    this.orgname = orgname;
  }
  public Long getRoleid() {
    return this.roleid;
  }
  public void setRoleid(Long roleid) {
    this.roleid = roleid;
  }
  public String getWwzqx() {
    return this.wwzqx;
  }
  public void setWwzqx(String wwzqx) {
    this.wwzqx = wwzqx;
  }
  public Long getComid() {
    return this.comid;
  }
  public void setComid(Long comid) {
    this.comid = comid;
  }
  public List<DBObject> getMpfunc() {
    return this.mpfunc;
  }
  public void setMpfunc(List<DBObject> mpfunc) {
    this.mpfunc = mpfunc;
  }
   public int getType() {
	return type;
  }
  public void setType(int type) {
	this.type = type;
  }
  public int getCss() {
	return css;
  }
  public void setCss(int css) {
	this.css = css;
  }
  public String getCustid() {
	return custid;
  }
  public void setCustid(String custid) {
	this.custid = custid;
  }
  public String getArea() {
	return area;
  }
  public void setArea(String area) {
	this.area = area;
  }
public String getProvince() {
	return province;
}
public void setProvince(String province) {
	this.province = province;
}
public String getCity() {
	return city;
}
public void setCity(String city) {
	this.city = city;
}
   
}