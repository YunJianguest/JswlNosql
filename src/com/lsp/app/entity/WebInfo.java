package com.lsp.app.entity;

import com.mongodb.ReflectionDBObject;
/**
 * 资源管理
 * @author lsp 
 *   
 */
public class WebInfo extends ReflectionDBObject
{
  private String title;
  private String url;
  private String type;

  public String getTitle()
  {
    return this.title;
  }
  public void setTitle(String title) {
    this.title = title;
  }
  public String getUrl() {
    return this.url;
  }
  public void setUrl(String url) {
    this.url = url;
  }
  public String getType() {
    return this.type;
  }
  public void setType(String type) {
    this.type = type;
  }
}