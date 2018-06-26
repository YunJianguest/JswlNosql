package com.lsp.web.web;

import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.upload.FtpUtils;
import com.lsp.pub.util.FpathUtil;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction; 
import com.lsp.web.entity.AdvertisingInfo;
import com.mongodb.DBObject;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Pattern;  

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
/**
 * 滚动
 * @author lsp
 *
 */
@Namespace("/web")
@Results({@org.apache.struts2.convention.annotation.Result(name="reload", location="advertising.action", type="redirect")})
public class AdvertisingAction extends GeneralAction<AdvertisingInfo>
{
  private static final long serialVersionUID = -6784469775589971579L;

  @Autowired
  private BaseDao basedao;
  private Long _id;
  private AdvertisingInfo entity = new AdvertisingInfo();
  private MongoSequence mongoSequence;

  @Autowired
  public void setMongoSequence(MongoSequence mongoSequence)
  {
    this.mongoSequence = mongoSequence;
  }
  public void set_id(Long _id) {
    this._id = _id;
  }
  public String execute() throws Exception {
    HashMap<String, Object> sortMap = new HashMap<String, Object>();
    HashMap<String, Object> whereMap = new HashMap<String, Object>();
    sortMap.put("sort", Integer.valueOf(-1));
    String type = Struts2Utils.getParameter("type");
    if ((type != null) && (!type.equals("")))
    {
      Struts2Utils.getRequest().setAttribute("type", type);
    }
    if ((Struts2Utils.getParameter("fypage") != null) && 
      (!Struts2Utils.getParameter("fypage").endsWith(""))) {
      this.fypage = Integer.parseInt(Struts2Utils.getParameter("fypage"));
      Struts2Utils.getRequest().setAttribute("fypage", Integer.valueOf(this.fypage));
    }
    String title = Struts2Utils.getParameter("title");
    if (StringUtils.isNotEmpty(title)) {
      Pattern pattern = Pattern.compile("^.*" + title + ".*$", 
        2);
      whereMap.put("title", pattern);
      Struts2Utils.getRequest().setAttribute("title", title);
    }
    List<DBObject> list = this.basedao.getList(PubConstants.ADVERT_INFO, 
      whereMap, sortMap);
    Struts2Utils.getRequest().setAttribute("advertList", list);
    this.fycount = this.basedao.getCount(PubConstants.ADVERT_INFO);
    Struts2Utils.getRequest().setAttribute("fycount", Long.valueOf(this.fycount));

    return "success";
  }

  public String input()
    throws Exception
  {
    return "add";
  }

  public String update()
    throws Exception
  {
    return "add";
  }

  public String save() throws Exception
  {
    try
    {
      if (this._id == null) {
        this._id = this.mongoSequence.currval(PubConstants.ADVERT_INFO);
      }
      this.entity.set_id(this._id);
      this.entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
      this.entity.setToUser(SpringSecurityUtils.getCurrentUser().getToUser());
      this.entity.setCreatedate(new Date());
      String type = Struts2Utils.getParameter("type");
      if ((type != null) && (!type.equals(""))) {
        this.entity.setType(type);
      }
      this.basedao.insert(PubConstants.ADVERT_INFO, this.entity);
      addActionMessage("添加成功");
    }
    catch (Exception e) {
      e.printStackTrace();
      addActionMessage("添加失败");
    }
    return "reload";
  }

  public String delete() throws Exception
  {
    try
    {
      if (this._id != null) {
        DBObject emDbObject = this.basedao.getMessage(
          PubConstants.ADVERT_INFO, this._id);
        AdvertisingInfo entity = (AdvertisingInfo)UniObject.DBObjectToObject(
          emDbObject, AdvertisingInfo.class);

        if ((!entity.getPath().equals("")) && (entity.getPath() != null)) {
          FpathUtil.getNameAndPath(entity.getPath());
          FtpUtils.removeFile(FpathUtil.FNAME, FpathUtil.PATH, FtpUtils.getFtpClient(SysConfig.getProperty("ftp"), SysConfig.getProperty("ftpname"), SysConfig.getProperty("ftppwd"), Integer.parseInt(SysConfig.getProperty("ftpport"))));
          FtpUtils.closeFtp(FtpUtils.FTP);
        }

        this.basedao.delete(PubConstants.ADVERT_INFO, this._id);
        addActionMessage("删除成功");
      }
    }
    catch (Exception e) {
      e.printStackTrace();
      addActionMessage("添加失败");
    }
    return "reload";
  }

  protected void prepareModel() throws Exception
  {
    if (this._id != null)
    {
      DBObject emDbObject = this.basedao.getMessage(PubConstants.ADVERT_INFO, 
        this._id);
      this.entity = ((AdvertisingInfo)UniObject.DBObjectToObject(emDbObject, 
        AdvertisingInfo.class));
    } else {
      this.entity = new AdvertisingInfo();
    }
  }

  public AdvertisingInfo getModel()
  {
    return this.entity;
  }
}