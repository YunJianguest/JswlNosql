package com.lsp.web.entity;

import com.mongodb.ReflectionDBObject;
import java.util.List;
/***
 * 资源管理
 * @author lsp
 *
 */
public class FolderInfo extends ReflectionDBObject
{
  private Integer sort;
  private String toUser;
  private String custid;
  private String title;
  private int state;
  private String createdate;
  private List<FolderInfo> lsfolder;
  private List<MusicInfo> lsmusic;
  private List<PictureInfo> lspic;
  private List<VideoInfo> lsvoide;
  private Long parentid;

  public Long getParentid()
  {
    return this.parentid;
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
  public String getToUser() {
    return this.toUser;
  }
  public void setToUser(String toUser) {
    this.toUser = toUser;
  }
  public String getCustid() {
    return this.custid;
  }
  public void setCustid(String custid) {
    this.custid = custid;
  }
  public String getTitle() {
    return this.title;
  }
  public void setTitle(String title) {
    this.title = title;
  }
  public int getState() {
    return this.state;
  }
  public void setState(int state) {
    this.state = state;
  }
  public String getCreatedate() {
    return this.createdate;
  }
  public void setCreatedate(String createdate) {
    this.createdate = createdate;
  }
  public List<FolderInfo> getLsfolder() {
    return this.lsfolder;
  }
  public void setLsfolder(List<FolderInfo> lsfolder) {
    this.lsfolder = lsfolder;
  }
  public List<MusicInfo> getLsmusic() {
    return this.lsmusic;
  }
  public void setLsmusic(List<MusicInfo> lsmusic) {
    this.lsmusic = lsmusic;
  }
  public List<PictureInfo> getLspic() {
    return this.lspic;
  }
  public void setLspic(List<PictureInfo> lspic) {
    this.lspic = lspic;
  }
  public List<VideoInfo> getLsvoide() {
    return this.lsvoide;
  }
  public void setLsvoide(List<VideoInfo> lsvoide) {
    this.lsvoide = lsvoide;
  }
}