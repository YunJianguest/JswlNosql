package com.lsp.pub.entity;

import com.mongodb.ReflectionDBObject;
import java.util.List;
import org.apache.commons.lang.builder.ToStringBuilder;
/**
 * 资源管理
 * @author lsp 
 *   
 */
public class FuncInfo extends ReflectionDBObject
{
  public static final String AUTHORITY_PREFIX = "ROLE_";
  private String logo;
  private String name;
  private String url;
  private int status;
  private Long parentid;
  private int sort;
  private List<FuncInfo> tfunc;

  public String getName()
  {
    return this.name;
  }
  public void setName(String name) {
    this.name = name;
  }
  public String getUrl() {
    return this.url;
  }
  public void setUrl(String url) {
    this.url = url;
  }
  public int getStatus() {
    return this.status;
  }
  public void setStatus(int status) {
    this.status = status;
  }
  public Long getParentid() {
    return this.parentid;
  }
  public void setParentid(Long parentid) {
    this.parentid = parentid;
  }

  public int getSort()
  {
    return this.sort;
  }

  public void setSort(int sort) {
    this.sort = sort;
  }

  public String getLogo() {
    return this.logo;
  }
  public void setLogo(String logo) {
    this.logo = logo;
  }

  public List<FuncInfo> getTfunc() {
    return this.tfunc;
  }
  public void setTfunc(List<FuncInfo> tfunc) {
    this.tfunc = tfunc;
  }
  public static String getAuthorityPrefix() {
    return "ROLE_";
  }

  public String getAuthName()
  {
    return "ROLE_" + (Long)get_id();
  }

  public String toString() {
    return ToStringBuilder.reflectionToString(this);
  }
}