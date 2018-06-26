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
import com.lsp.web.entity.FolderInfo;
import com.lsp.web.entity.PictureInfo;
import com.mongodb.DBObject;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Pattern;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

@Namespace("/web")
@Results({@org.apache.struts2.convention.annotation.Result(name="reload", location="picture.action", type="redirect")})
public class PictureAction extends GeneralAction<PictureInfo>
{
  private static final long serialVersionUID = -6784469775589971579L;

  @Autowired
  private BaseDao basedao;
  private Long _id;
  private PictureInfo entity = new PictureInfo();
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
    List<DBObject> list = this.basedao.getList(PubConstants.PICTURE_INFO, 
      whereMap, sortMap);
    Struts2Utils.getRequest().setAttribute("pictureList", list);
    this.fycount = this.basedao.getCount(PubConstants.PICTURE_INFO);
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
      if (this._id == null)
      {
        this._id = this.mongoSequence.currval(PubConstants.PICTURE_INFO);
      }

      this.entity.set_id(this._id);
      this.entity.setCreatedate(new Date());
      this.entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
      this.entity.setToUser(SpringSecurityUtils.getCurrentUser().getToUser());
      if (this.entity.getFolderid().longValue() != 0L)
      {
        DBObject emDbObject = this.basedao.getMessage(PubConstants.FOLDER_INFO, 
          this.entity.getFolderid());
        FolderInfo entity = (FolderInfo)UniObject.DBObjectToObject(emDbObject, 
          FolderInfo.class);

        if (entity.getLsfolder() == null) {
          List<PictureInfo> list = new ArrayList<PictureInfo>();
          list.add(this.entity);
          entity.setLspic(list);
        }
        else {
          List<PictureInfo> list = entity.getLspic();
          List<PictureInfo> list1 = new ArrayList<PictureInfo>();
          list1.add(this.entity);
          for (int i = 0; i < list.size(); i++)
          {
            PictureInfo func = (PictureInfo)JSONObject.toBean(JSONObject.fromObject(list.get(i)), PictureInfo.class);

            if ((func.getTitle() != this.entity.getTitle()) && (!func.getTitle().equals(this.entity.getTitle())))
            {
              list1.add(func);
            }
          }

          entity.setLspic(list1);
        }

        this.basedao.insert(PubConstants.FOLDER_INFO, entity);
      }

      this.basedao.insert(PubConstants.PICTURE_INFO, this.entity);

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
        DBObject emDbObject = this.basedao.getMessage(PubConstants.PICTURE_INFO, 
          this._id);
        PictureInfo entity = (PictureInfo)UniObject.DBObjectToObject(emDbObject, 
          PictureInfo.class);

        if ((!entity.getPath().equals("")) && (entity.getPath() != null)) {
          FpathUtil.getNameAndPath(entity.getPath());
          FtpUtils.removeFile(FpathUtil.FNAME, FpathUtil.PATH, FtpUtils.getFtpClient(SysConfig.getProperty("ftp"), SysConfig.getProperty("ftpname"), SysConfig.getProperty("ftppwd"), Integer.parseInt(SysConfig.getProperty("ftpport"))));
          FtpUtils.closeFtp(FtpUtils.FTP);
        }

        this.basedao.delete(PubConstants.PICTURE_INFO, this._id);
        addActionMessage("删除成功");
      }
    }
    catch (Exception e)
    {
      e.printStackTrace();
      addActionMessage("删除失败");
    }
    return "reload";
  }

  protected void prepareModel()
    throws Exception
  {
    if (this._id != null)
    {
      DBObject emDbObject = this.basedao.getMessage(PubConstants.PICTURE_INFO, 
        this._id);
      this.entity = ((PictureInfo)UniObject.DBObjectToObject(emDbObject, 
        PictureInfo.class));
    } else {
      this.entity = new PictureInfo();
    }
  }

  public PictureInfo getModel()
  {
    return this.entity;
  }
}