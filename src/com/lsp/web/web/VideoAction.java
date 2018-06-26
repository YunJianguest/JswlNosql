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
import com.lsp.web.entity.MusicInfo;
import com.lsp.web.entity.VideoInfo;
import com.mongodb.DBObject;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
/***
 * 资源管理
 * @author lsp
 *
 */
@Namespace("/web")
@Results({@org.apache.struts2.convention.annotation.Result(name="reload", location="video.action", type="redirect")})
public class VideoAction extends GeneralAction<VideoInfo>
{
  private static final long serialVersionUID = -6784469775589971579L;

  @Autowired
  private BaseDao basedao;
  private Long _id;
  private VideoInfo entity = new VideoInfo();
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
    List<DBObject> list = this.basedao.getList(PubConstants.VIDEO_INFO, 
      whereMap, this.fypage, 10, sortMap);
    Struts2Utils.getRequest().setAttribute("videoList", list);
    this.fycount = this.basedao.getCount(PubConstants.VIDEO_INFO);
    Struts2Utils.getRequest().setAttribute("fycount", Long.valueOf(this.fycount));

    whereMap.clear();
    sortMap.clear();
    List<DBObject>folderlist = this.basedao.getList(PubConstants.FOLDER_INFO, whereMap, sortMap);
    HashMap<Long, Object> map = new HashMap<Long, Object>();
    map.put(Long.valueOf(0L), "请选择");
    List<Map<Long, Object>>lsfolder = new ArrayList<Map<Long, Object>>();
    for (int i = 0; i < folderlist.size(); i++) {
      FolderInfo entity = (FolderInfo)JSONObject.toBean(JSONObject.fromObject(folderlist.get(i)), FolderInfo.class);

      HashMap<Long, Object> roleMap = new HashMap<Long, Object>();

      map.put(Long.valueOf(Long.parseLong(entity.get_id().toString())), entity
        .getTitle());

      lsfolder.add(roleMap);
    }
    Struts2Utils.getRequest().setAttribute("type", "video");
    Struts2Utils.getRequest().setAttribute("map", map);
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
      if (this._id == null)
      {
        this._id = this.mongoSequence.currval(PubConstants.VIDEO_INFO);
      }

      this.entity.set_id(this._id);
      this.entity.setCreatedate(new Date());
      this.entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
      this.entity.setToUser(SpringSecurityUtils.getCurrentUser().getToUser());
      this.basedao.insert(PubConstants.VIDEO_INFO, this.entity);
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
        DBObject emDbObject = this.basedao.getMessage(PubConstants.VIDEO_INFO, 
          this._id);
        VideoInfo entity = (VideoInfo)UniObject.DBObjectToObject(emDbObject, 
          VideoInfo.class);
        if ((!entity.getPath().equals("")) && (entity.getPath() != null)) {
          FpathUtil.getNameAndPath(entity.getPath());
          FtpUtils.removeFile(FpathUtil.FNAME, FpathUtil.PATH, FtpUtils.getFtpClient(SysConfig.getProperty("ftp"), SysConfig.getProperty("ftpname"), SysConfig.getProperty("ftppwd"), Integer.parseInt(SysConfig.getProperty("ftpport"))));
          FtpUtils.closeFtp(FtpUtils.FTP);
        }

        this.basedao.delete(PubConstants.VIDEO_INFO, this._id);
        addActionMessage("删除成功");
      }
    }
    catch (Exception e)
    {
      e.printStackTrace();
      addActionMessage("添加失败");
    }
    return "reload";
  }

  public void   savedetail(){
	  Map<String, Object> sub_map = new HashMap<String, Object>();
	  try {
		  String title=Struts2Utils.getParameter("title");
		  String url=Struts2Utils.getParameter("url");
		  String folderid=Struts2Utils.getParameter("folderid");
		  String path=Struts2Utils.getParameter("path");
		  String toUser=Struts2Utils.getParameter("toUser");
		  String sort=Struts2Utils.getParameter("sort");
		  VideoInfo videoInfo=new VideoInfo();
		  videoInfo.set_id(mongoSequence.currval(PubConstants.VIDEO_INFO));
		  videoInfo.setUrl(url);
		  videoInfo.setTitle(title);
		  videoInfo.setCreatedate(new Date());
		  videoInfo.setPath(path);
		  videoInfo.setFolderid(Long.parseLong(folderid));
		  videoInfo.setToUser(toUser);
		  videoInfo.setSort(Integer.parseInt(sort));
		  basedao.insert(PubConstants.VIDEO_INFO, videoInfo);
		  sub_map.put("state", 0);
	} catch (NumberFormatException e) {
		// TODO Auto-generated catch block
		  sub_map.put("state", 1);
		e.printStackTrace();
	}
	  String json = JSONArray.fromObject(sub_map).toString();
		 
	  Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);  
  }
  protected void prepareModel()
    throws Exception
  {
    if (this._id != null)
    {
      DBObject emDbObject = this.basedao.getMessage(PubConstants.VIDEO_INFO, 
        this._id);
      this.entity = ((VideoInfo)UniObject.DBObjectToObject(emDbObject, 
        VideoInfo.class));
    } else {
      this.entity = new VideoInfo();
    }
  }

  public VideoInfo getModel()
  {
    return this.entity;
  }
}