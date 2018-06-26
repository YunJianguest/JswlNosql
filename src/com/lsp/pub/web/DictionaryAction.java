package com.lsp.pub.web;

import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.DictionaryInfo;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject; 
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
 * 通用action
 * @author lsp 
 *   
 */
@Namespace("/pub")
@Results({@org.apache.struts2.convention.annotation.Result(name="reload", location="dictionary.action", type="redirect")})
public class DictionaryAction extends GeneralAction<DictionaryInfo>
{
  private static final long serialVersionUID = -6784469775589971579L;

  @Autowired
  private BaseDao basedao;
  private Long _id;
  private DictionaryInfo entity = new DictionaryInfo();
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
    if ((type != null) && (!type.equals(""))) {
      whereMap.put("type", type);
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
      whereMap.put("name", pattern);
      Struts2Utils.getRequest().setAttribute("title", title);
    }
    List<DBObject> list = this.basedao.getList(PubConstants.DICTIONARY_INFO, whereMap, sortMap);
    Struts2Utils.getRequest().setAttribute("dicList", list);
    this.fycount = this.basedao.getCount(PubConstants.DICTIONARY_INFO);
    Struts2Utils.getRequest().setAttribute("fycount", Long.valueOf(this.fycount));
    return "success";
  }

  public String input() throws Exception
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
        this._id = this.mongoSequence.currval(PubConstants.DICTIONARY_INFO);
      }
      this.entity.set_id(this._id);
      this.entity.setCreatedate(new Date());
      this.entity.setToUser(SpringSecurityUtils.getCurrentUser().getToUser());
      this.entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
      this.basedao.insert(PubConstants.DICTIONARY_INFO, this.entity);
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
        this.basedao.delete(PubConstants.DICTIONARY_INFO, this._id);
      }
      addActionMessage("删除成功");
    }
    catch (Exception e) {
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
      DBObject emDbObject = this.basedao.getMessage(PubConstants.DICTIONARY_INFO, this._id);
      this.entity = ((DictionaryInfo)UniObject.DBObjectToObject(emDbObject, DictionaryInfo.class));
    } else {
      this.entity = new DictionaryInfo();
    }
  }

  public DictionaryInfo getModel()
  {
    return this.entity;
  }
}