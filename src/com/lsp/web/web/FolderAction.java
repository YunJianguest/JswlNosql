package com.lsp.web.web;

import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction; 
import com.lsp.web.entity.FolderInfo;
import com.lsp.web.entity.MusicInfo;
import com.lsp.web.entity.PictureInfo;
import com.lsp.web.entity.VideoInfo;
import com.mongodb.DBObject;
import java.io.File; 
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern; 
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

@Namespace("/web")
@Results({@org.apache.struts2.convention.annotation.Result(name="reload", location="folder.action", type="redirect")})
public class FolderAction extends GeneralAction<FolderInfo>
{ 
  private static final long serialVersionUID = -6784469775589971579L;

  @Autowired
  private BaseDao basedao;
  private Long _id;
  private FolderInfo entity = new FolderInfo();
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
    String parentid=Struts2Utils.getParameter("parentid");
    if(StringUtils.isNotEmpty(parentid)){
    	whereMap.put("parentid", Long.parseLong(parentid));	
    	Struts2Utils.getRequest().setAttribute("parentid", parentid);
    }else{
    	whereMap.put("parentid", 0L);
    	Struts2Utils.getRequest().setAttribute("parentid", 0);
    }
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
    List<DBObject>list = this.basedao.getList(PubConstants.FOLDER_INFO, whereMap, sortMap);
    this.fycount = this.basedao.getCount(PubConstants.FOLDER_INFO,whereMap);
    Struts2Utils.getRequest().setAttribute("fycount", Long.valueOf(this.fycount));
    whereMap.clear();
//    HashMap<String, Object> backMap = new HashMap<String, Object>();
//    backMap.put("toUser", 1);
//    backMap.put("nickname", 1);
//    List<DBObject>userList=basedao.getList(PubConstants.USER_INFO, whereMap, sortMap,backMap);
//    Struts2Utils.getRequest().setAttribute("userList", userList);
    Struts2Utils.getRequest().setAttribute("folderList", list);
    
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
        this._id = this.mongoSequence.currval(PubConstants.FOLDER_INFO);
      }

      this.entity.set_id(this._id);
      this.entity.setCreatedate(DateFormat.getDate(new Date()));
      this.entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
      this.entity.setToUser(SpringSecurityUtils.getCurrentUser().getToUser());
      if (this.entity.getParentid()!= 0L)
      {
        DBObject emDbObject = this.basedao.getMessage(PubConstants.FOLDER_INFO, 
          this.entity.getParentid());
        FolderInfo entity = (FolderInfo)UniObject.DBObjectToObject(emDbObject, 
          FolderInfo.class);

        if (entity.getLsfolder() == null) {
          List<FolderInfo> list = new ArrayList<FolderInfo>();
          list.add(this.entity);
          entity.setLsfolder(list);
        }
        else {
          List<FolderInfo> list = entity.getLsfolder();
          List<FolderInfo> list1 = new ArrayList<FolderInfo>();
          list1.add(this.entity);
          for (int i = 0; i < list.size(); i++)
          {
            System.out.println(JSONObject.fromObject(list.get(i)));
            Map<String,Class> map = new HashMap<String,Class>();
            map.put("lsfolder", FolderInfo.class);
            map.put("lsmusic", MusicInfo.class);
            map.put("lspic", PictureInfo.class);
            map.put("lsvoide", VideoInfo.class);
            FolderInfo func = (FolderInfo)JSONObject.toBean(JSONObject.fromObject(list.get(i)), FolderInfo.class, map);

            if ((func.getTitle() != this.entity.getTitle()) && (!func.getTitle().equals(this.entity.getTitle())))
            {
              list1.add(func);
            }
          }

          entity.setLsfolder(list1);
        }

        this.basedao.insert(PubConstants.FOLDER_INFO, entity);
      }

      this.basedao.insert(PubConstants.FOLDER_INFO, this.entity);
      addActionMessage("添加成功!");
    }
    catch (Exception e) {
      e.printStackTrace();
      addActionMessage("添加失败!");
    }
    return "reload";
  }
  public String savedetail() throws Exception
  {
    try
    {
      if (this._id== null)
      {
        this._id = this.mongoSequence.currval(PubConstants.FOLDER_INFO);
      }

      this.entity.set_id(this._id);
      this.entity.setCreatedate(DateFormat.getDate(new Date()));
      this.entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
      this.entity.setToUser(SpringSecurityUtils.getCurrentUser().getToUser());
      if (this.entity.getParentid()!= 0L)
      {
        DBObject emDbObject = this.basedao.getMessage(PubConstants.FOLDER_INFO, 
          this.entity.getParentid());
        FolderInfo entity = (FolderInfo)UniObject.DBObjectToObject(emDbObject, 
          FolderInfo.class);

        if (entity.getLsfolder() == null) {
          List<FolderInfo> list = new ArrayList<FolderInfo>();
          list.add(this.entity);
          entity.setLsfolder(list);
        }
        else {
          List<FolderInfo> list = entity.getLsfolder();
          List<FolderInfo> list1 = new ArrayList<FolderInfo>();
          list1.add(this.entity);
          for (int i = 0; i < list.size(); i++)
          {
            System.out.println(JSONObject.fromObject(list.get(i)));
            Map<String,Class> map = new HashMap<String,Class>();
            map.put("lsfolder", FolderInfo.class);
            map.put("lsmusic", MusicInfo.class);
            map.put("lspic", PictureInfo.class);
            map.put("lsvoide", VideoInfo.class);
            FolderInfo func = (FolderInfo)JSONObject.toBean(JSONObject.fromObject(list.get(i)), FolderInfo.class, map);

            if ((func.getTitle() != this.entity.getTitle()) && (!func.getTitle().equals(this.entity.getTitle())))
            {
              list1.add(func);
            }
          }

          entity.setLsfolder(list1);
        }

        this.basedao.insert(PubConstants.FOLDER_INFO, entity);
      }

      this.basedao.insert(PubConstants.FOLDER_INFO, this.entity);
      addActionMessage("添加成功!");
    }
    catch (Exception e) {
      e.printStackTrace();
      addActionMessage("添加失败!");
    }
    return getFolders();
  }


  public String delete() throws Exception
  {
    try
    {
       
      if (this._id != null) {
       
         this.basedao.delete(PubConstants.FOLDER_INFO, this._id);
         
        	 HashMap<String, Object> whereMap = new HashMap<String, Object>(); 
        	 whereMap.put("parentid", this._id);
        	 List<DBObject>list=basedao.getList(PubConstants.FOLDER_INFO, whereMap, null);
        	 for (DBObject dbObject : list) {
        		 this.basedao.delete(PubConstants.FOLDER_INFO,Long.parseLong(dbObject.get("_id").toString())); 
		 	
		      }
         addActionMessage("删除成功");
        
      }
    }
    catch (Exception e)
    {
      e.printStackTrace();
      addActionMessage("删除失败");
    }
    return RELOAD;
  }

  protected void prepareModel()
    throws Exception
  {
    if (this._id != null)
    {
      DBObject emDbObject = this.basedao.getMessage(PubConstants.FOLDER_INFO, this._id);
      this.entity = ((FolderInfo)UniObject.DBObjectToObject(emDbObject, FolderInfo.class));
    } else {
      this.entity = new FolderInfo();
    }
  }

  public FolderInfo getModel()
  {
    return this.entity;
  }

  public String getFolders()
  {
    HashMap<String, Object> sortMap = new HashMap<String, Object>();
    HashMap<String, Object> whereMap = new HashMap<String, Object>();
    sortMap.put("sort", Integer.valueOf(-1));
    String folderid=Struts2Utils.getParameter("folderid");
    String type=Struts2Utils.getParameter("type");
    toUser=SpringSecurityUtils.getCurrentUser().getToUser();
    whereMap.put("toUser", toUser);
    if(StringUtils.isNotEmpty(folderid)){
    	whereMap.put("folderid", Long.parseLong(folderid)); 
    	Struts2Utils.getRequest().setAttribute("folderid", folderid);
    	  //加载文件
        
        if(StringUtils.isNotEmpty(type)){
        	 if(type.equals("video")){
            	 List<DBObject> videoList = this.basedao.getList(PubConstants.VIDEO_INFO, whereMap, sortMap);
            	 Struts2Utils.getRequest().setAttribute("videoList", videoList);
            }else if(type.equals("music")){
            	List<DBObject> musicList = this.basedao.getList(PubConstants.MUSIC_INFO, whereMap, sortMap); 
                Struts2Utils.getRequest().setAttribute("musicList", musicList);
            }else if(type.equals("files")){
            	List<DBObject> filesList = this.basedao.getList(PubConstants.FILES_INFO, whereMap, sortMap); 
                Struts2Utils.getRequest().setAttribute("filesList", filesList);
            }
        }else{
        	 List<DBObject> videoList = this.basedao.getList(PubConstants.VIDEO_INFO, whereMap, sortMap);
        	 Struts2Utils.getRequest().setAttribute("videoList", videoList);
        	 List<DBObject> musicList = this.basedao.getList(PubConstants.MUSIC_INFO, whereMap, sortMap); 
             Struts2Utils.getRequest().setAttribute("musicList", musicList);
        }
       
        
       
    }else{
    	whereMap.put("folderid", 0L);
    	Struts2Utils.getRequest().setAttribute("folderid", 0);
    }
  
    whereMap.clear();
    
    String parentid=Struts2Utils.getParameter("parentid"); 
   
    if(StringUtils.isNotEmpty(parentid)){
    	whereMap.put("toUser", toUser);
    	whereMap.put("parentid", Long.parseLong(parentid));	
    	Struts2Utils.getRequest().setAttribute("parentid", parentid);
    }else{
    	whereMap.put("parentid", 0L);
    	Struts2Utils.getRequest().setAttribute("parentid", 0);
    }
    //加载文件夹
    List<DBObject> foldersList = this.basedao.getList(PubConstants.FOLDER_INFO, whereMap, sortMap);
    whereMap.clear();
    List<DBObject> folderList = this.basedao.getList(PubConstants.FOLDER_INFO, whereMap, sortMap);

    
    List<DBObject> dictionaryList = this.basedao.getList(PubConstants.DICTIONARY_INFO, whereMap, sortMap);
    Struts2Utils.getRequest().setAttribute("dictionaryList", dictionaryList);
   
    Struts2Utils.getRequest().setAttribute("foldersList", foldersList);
    Struts2Utils.getRequest().setAttribute("folderList", folderList);
    Struts2Utils.getRequest().setAttribute("type",type);
    Struts2Utils.getRequest().setAttribute("toUser", toUser);
    Struts2Utils.getRequest().setAttribute("userType",SpringSecurityUtils.getCurrentUser().getType());

    return "detail";
  }

  public String getchild() {
    if (this._id != null)
    {
      DBObject emDbObject = this.basedao.getMessage(PubConstants.FOLDER_INFO, this._id);
      this.entity = ((FolderInfo)UniObject.DBObjectToObject(emDbObject, FolderInfo.class));
      List<FolderInfo> list = this.entity.getLsfolder();

      List<FolderInfo> list1 = new ArrayList<FolderInfo>();
      if ((list != null) && (list.size() > 0)) {
        for (int i = 0; i < list.size(); i++)
        {
          FolderInfo func = (FolderInfo)JSONObject.toBean(JSONObject.fromObject(list.get(i)), FolderInfo.class);

          list1.add(func);
          if (func.getParentid() == this.entity.get_id()) {
            list1.add(func);
          }

        }

      }

      HashMap<String, Object> sortMap = new HashMap<String, Object>();
      HashMap<String, Object> whereMap = new HashMap<String, Object>();
      sortMap.put("createdate", Integer.valueOf(-1));
      whereMap.put("folderid", this._id);
      List<DBObject> musiclist = this.basedao.getList(PubConstants.MUSIC_INFO, whereMap, sortMap);
      List<DBObject> videolist = this.basedao.getList(PubConstants.VIDEO_INFO, whereMap, sortMap);
      List<DBObject> piclist = this.basedao.getList(PubConstants.PICTURE_INFO, whereMap, sortMap);

      this.fycount = list1.size() + musiclist.size() + videolist.size() + piclist.size();
      Struts2Utils.getRequest().setAttribute("musicList", musiclist);
      Struts2Utils.getRequest().setAttribute("videoList", videolist);
      Struts2Utils.getRequest().setAttribute("picList", piclist);
      Struts2Utils.getRequest().setAttribute("folderList", list1);
    }

    return "success";
  }
  public String deletechild() {
    try {
      if (this._id != null) {
        DBObject emDbObject = this.basedao.getMessage(PubConstants.FOLDER_INFO, this._id);
        this.entity = ((FolderInfo)UniObject.DBObjectToObject(emDbObject, FolderInfo.class));
        this.entity.setLsmusic(null);
        this.entity.setLsvoide(null);
        this.entity.setLsfolder(null);
        this.entity.setLspic(null);
        this.basedao.insert(PubConstants.FOLDER_INFO, this.entity);

        HashMap<String, Object> sortMap = new HashMap<String, Object>();
        HashMap<String, Object> whereMap = new HashMap<String, Object>();
        sortMap.put("createdate", Integer.valueOf(-1));
        whereMap.put("folderid", this._id);
        List<DBObject> filelist = this.basedao.getList(PubConstants.MUSIC_INFO, whereMap, sortMap);
        for (int i = 0; i < filelist.size(); i++)
        {
          MusicInfo entity = (MusicInfo)UniObject.DBObjectToObject((DBObject)filelist.get(i), MusicInfo.class);
          if ((entity.getPath() != null) && (!entity.getPath().equals("")))
          {
            File file = new File(entity.getPath());
            file.delete();
          }

          this.basedao.delete(PubConstants.MUSIC_INFO, entity.get_id().toString());
        }
      }

    }
    catch (Exception e)
    {
      e.printStackTrace();
    }

    return "reload";
  }
  public void deleteAll() {
    this.basedao.delete(PubConstants.FOLDER_INFO);
  }

  public String getchilds()
  {
    if (this._id != null)
    {
      DBObject emDbObject = this.basedao.getMessage(PubConstants.FOLDER_INFO, this._id);
      this.entity = ((FolderInfo)UniObject.DBObjectToObject(emDbObject, FolderInfo.class));
      List<FolderInfo> list = this.entity.getLsfolder();

      List<FolderInfo> list1 = new ArrayList<FolderInfo>();
      if ((list != null) && (list.size() > 0)) {
        for (int i = 0; i < list.size(); i++)
        {
          FolderInfo func = (FolderInfo)JSONObject.toBean(JSONObject.fromObject(list.get(i)), FolderInfo.class);

          list1.add(func);
          if (func.getParentid() == this.entity.get_id()) {
            list1.add(func);
          }

        }

      }

      HashMap <String, Object>sortMap = new HashMap<String, Object>();
      HashMap <String, Object>whereMap = new HashMap<String, Object>();
      sortMap.put("createdate", Integer.valueOf(-1));
      whereMap.put("folderid", this._id);
      List<DBObject> musiclist = this.basedao.getList(PubConstants.MUSIC_INFO, whereMap, sortMap);
      List<DBObject> videolist = this.basedao.getList(PubConstants.VIDEO_INFO, whereMap, 0, 20, sortMap);
      List<DBObject> piclist = this.basedao.getList(PubConstants.PICTURE_INFO, whereMap, sortMap);

      this.fycount = list1.size() + musiclist.size() + videolist.size() + piclist.size();
      Struts2Utils.getRequest().setAttribute("musicList", musiclist);
      Struts2Utils.getRequest().setAttribute("videolist", videolist);
      Struts2Utils.getRequest().setAttribute("picList", piclist);
      Struts2Utils.getRequest().setAttribute("foldersList", list1);
      whereMap.clear();
      List<DBObject> folderList = this.basedao.getList(PubConstants.FOLDER_INFO, whereMap, sortMap);

      List<DBObject> dictionaryList = this.basedao.getList(PubConstants.DICTIONARY_INFO, whereMap, sortMap);
      Struts2Utils.getRequest().setAttribute("dictionaryList", dictionaryList);
      Struts2Utils.getRequest().setAttribute("folderList", folderList);
    }

    return "detail";
  }

  public void chageData()
  {
    HashMap<String, Object> sortMap = new HashMap<String, Object>();
    HashMap<String, Object> whereMap = new HashMap<String, Object>();
    sortMap.put("sort", Integer.valueOf(-1));

    List<DBObject> list = this.basedao.getList(PubConstants.MUSIC_INFO, whereMap, sortMap);

    for (int i = 0; i < list.size(); i++) {
      MusicInfo entity = (MusicInfo)UniObject.DBObjectToObject((DBObject)list.get(i), MusicInfo.class);

      if (entity.getUrl().indexOf(".mp4") > 0) {
        VideoInfo video = new VideoInfo();
        video.set_id(entity.get_id());
        video.setContext(entity.getContext());
        video.setCreatedate(entity.getCreatedate());
        video.setCustid(entity.getCustid());
        video.setFolderid(entity.getFolderid());
        video.setPath(entity.getPath());
        video.setSort(entity.getSort());
        video.setSummary(entity.getSummary());
        video.setTitle(entity.getTitle());
        video.setToUser(entity.getToUser());
        video.setType(entity.getType());
        video.setUrl(entity.getUrl());
        this.basedao.insert(PubConstants.VIDEO_INFO, video);
        this.basedao.delete(PubConstants.MUSIC_INFO, Long.valueOf(Long.parseLong(entity.get_id().toString())));
      }
    }
  }
  /**
   * 清除文件夹下文件
   * （保留文件）
   */
  public void cleanAllFilse(){
	  HashMap<String, Object> sortMap = new HashMap<String, Object>();
	  HashMap<String, Object> whereMap = new HashMap<String, Object>();
	  String  id=Struts2Utils.getParameter("id");
	  if(StringUtils.isNotEmpty(id)){
		  whereMap.put("folderid", Long.parseLong(id));
	  }; 
	  List<DBObject> list = this.basedao.getList(PubConstants.MUSIC_INFO, whereMap, sortMap);
	  List<DBObject> list1 = this.basedao.getList(PubConstants.VIDEO_INFO, whereMap, sortMap);
	  for (DBObject dbObject : list) {
		 MusicInfo music= (MusicInfo) UniObject.DBObjectToObject(dbObject,MusicInfo.class);
		 music.setFolderid(0L);
		 basedao.insert(PubConstants.MUSIC_INFO, music);
	 }
	 for (DBObject dbObject : list1) {
		VideoInfo video=(VideoInfo) UniObject.DBObjectToObject(dbObject, VideoInfo.class);
		video.setFolderid(0L);
	}
	  
  }
}