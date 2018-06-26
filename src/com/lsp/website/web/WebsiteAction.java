package com.lsp.website.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction; 
import com.lsp.web.entity.VideoInfo;
import com.lsp.website.entity.NavigationInfo;
import com.lsp.website.entity.Promotelink;
import com.lsp.website.entity.RollInfo;
import com.lsp.website.entity.SlideInfo;
import com.lsp.website.entity.WebsiteInfo;
import com.lsp.website.entity.Websitegrapgh;
import com.mongodb.DBObject;

/**
 * 网站管理
 * @author lsp
 *
 */
@Namespace("/website")
@Results({@org.apache.struts2.convention.annotation.Result(name="reload", location="website.action", type="redirect")})
public class WebsiteAction  extends GeneralAction<WebsiteInfo>{
	private static final long serialVersionUID = -6784469775589971579L;

	  @Autowired
	  private BaseDao basedao;
	  private Long _id;
	  private WebsiteInfo entity = new WebsiteInfo();
	  private MongoSequence mongoSequence;

	  @Autowired
	  public void setMongoSequence(MongoSequence mongoSequence)
	  {
	    this.mongoSequence = mongoSequence;
	  }

	  public void set_id(Long _id) {
	    this._id = _id;
	  }
	  public String execute() throws Exception{ 
		  HashMap<String, Object> whereMap = new HashMap<String, Object>();
		  HashMap<String, Object> sortMap = new HashMap<String, Object>(); 
		  String comid=Struts2Utils.getParameter("comid"); 
		  if(StringUtils.isNotEmpty(comid)){
			  Struts2Utils.getRequest().setAttribute("comid",comid);
		  }
		  toUser=SpringSecurityUtils.getCurrentUser().getToUser();
		  Struts2Utils.getRequest().setAttribute("toUser",toUser);
		 
		  whereMap.put("toUser", toUser);
		  sortMap.put("createdate", -1); 
		  
		  if(org.apache.commons.lang.StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			  fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));  
		  }
		  
		  List<DBObject>list=basedao.getList(PubConstants.WEBSITE_INFO, whereMap,fypage,10, sortMap);
		  Struts2Utils.getRequest().setAttribute("websiteList", list);
		  System.out.println(list.toString());
		  fycount=basedao.getCount(PubConstants.WEBSITE_INFO, whereMap);
		  return SUCCESS;
	  }
	@Override
	public String input() throws Exception {
		Struts2Utils.getRequest().setAttribute("toUser", Struts2Utils.getParameter("toUser"));
		//Struts2Utils.getRequest().setAttribute("comid", Struts2Utils.getParameter("comid"));
		Struts2Utils.getRequest().setAttribute("webid", Struts2Utils.getParameter(null));
		Struts2Utils.getRequest().setAttribute("tab", 0);
	
		return "add";
	}

	@Override
	public String update() throws Exception {
		// TODO Auto-generated method stub
		String toUser=Struts2Utils.getParameter("toUser");
		Struts2Utils.getRequest().setAttribute("toUser", toUser);
		String webid=Struts2Utils.getParameter("webid");
		Struts2Utils.getRequest().setAttribute("webid",webid );  
		Struts2Utils.getRequest().setAttribute("tab", Struts2Utils.getParameter("tab"));
		String naviid=Struts2Utils.getParameter("naviid"); 
		String graphid=Struts2Utils.getParameter("graphid"); 
		Struts2Utils.getRequest().setAttribute("naviid", Struts2Utils.getParameter("naviid")); 
	    HashMap<String, Object>whereMap=new HashMap<String, Object>();
	    HashMap<String, Object>sortMap=new HashMap<String, Object>();
	    
	    if(StringUtils.isNotEmpty(webid)){
	    	whereMap.put("webid", Long.parseLong(webid));
	    }
	    sortMap.put("sort", -1);
	    
	    //加载网站主体
	    DBObject  db=basedao.getMessage(PubConstants.WEBSITE_INFO, Long.parseLong(webid));
	    
		//加载滚动
	    List<DBObject>rollList=basedao.getList(PubConstants.ROLL_INFO, whereMap, sortMap);
		
		//加载幻灯片
	    List<DBObject>slideList=basedao.getList(PubConstants.SLIDE_INFO, whereMap, sortMap);
	    //加载推广链接
	    List<DBObject>promotelist=basedao.getList(PubConstants.WEBSITE_PROMOTELINK, whereMap, sortMap);
	    //加载视频
	    List<DBObject>videolist=basedao.getList(PubConstants.VIDEO_INFO, whereMap, sortMap);
	    
	    //加载导航
	    if(StringUtils.isNotEmpty(naviid)){
	    	whereMap.put("parentid",Long.parseLong(naviid));
	    }else{
	    	whereMap.put("parentid",null);
	    }
	    List<DBObject>naviList=basedao.getList(PubConstants.NAVIGATION_INFO, whereMap, sortMap);
	    //加载图文栏目
	    whereMap.clear();
	    if(StringUtils.isNotEmpty(webid)){
	    	whereMap.put("webid", Long.parseLong(webid));
	    };
	    if(StringUtils.isNotEmpty(graphid)){
	    	whereMap.put("parentid", graphid);
	    }else{
	    	whereMap.put("parentid", null);
	    }
	    List<DBObject>webgraphList=basedao.getList(PubConstants.WEBSITE_GRAPH, whereMap, sortMap);
	     
	    Struts2Utils.getRequest().setAttribute("videoList", videolist);
	    Struts2Utils.getRequest().setAttribute("rollList", rollList);
	    Struts2Utils.getRequest().setAttribute("naviList", naviList);
	    Struts2Utils.getRequest().setAttribute("slideList", slideList);
	    Struts2Utils.getRequest().setAttribute("promoteList", promotelist);
	    Struts2Utils.getRequest().setAttribute("webgraphList", webgraphList);
	    Struts2Utils.getRequest().setAttribute("entity", db); 
		return "add";
	}

	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		toUser=SpringSecurityUtils.getCurrentUser().getToUser();
		String  title=Struts2Utils.getParameter("title");
		String  url=Struts2Utils.getParameter("url");
		String  picurl=Struts2Utils.getParameter("picurl");
		String  sort=Struts2Utils.getParameter("sort");
		String  webid=Struts2Utils.getParameter("webid");
		String  foot=Struts2Utils.getParameter("foot");
		try {
			if(StringUtils.isNotEmpty(webid)){
				DBObject db=basedao.getMessage(PubConstants.WEBSITE_INFO, Long.parseLong(webid));
				WebsiteInfo  web=(WebsiteInfo) UniObject.DBObjectToObject(db, WebsiteInfo.class);
				web.setTitle(title);
				web.setUrl(url);
				web.setPicurl(picurl);
				web.setSort(Integer.parseInt(sort));
				web.setCreatedate(new Date());
				web.setFoot(foot);
				basedao.insert(PubConstants.WEBSITE_INFO, web);
				addActionMessage("添加成功！");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			addActionMessage("添加失败！");
		}
		 
		
		return update();
	}
	

	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		// Struts2Utils.getRequest().setAttribute("comid", Struts2Utils.getParameter("comid"));
		try {
			if(_id!=null){
				basedao.delete(PubConstants.WEBSITE_INFO,_id);
			}
			addActionMessage("删除成功！");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			addActionMessage("删除失败！");
		}
		return RELOAD;
	}

	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		if(_id!=null){
			  DBObject emDbObject = this.basedao.getMessage(PubConstants.WEBSITE_INFO, 
				        this._id);
				        this.entity = ((WebsiteInfo)UniObject.DBObjectToObject(emDbObject, 
				        WebsiteInfo.class));
		}else{
			entity=new WebsiteInfo();
		}
		
	}
	public WebsiteInfo getModel()
	  {
	    return this.entity;
	  }
	/**
	 * 添加滚动字幕
	 * @throws Exception 
	 */
	public String  saveRoll() throws Exception{
		toUser=SpringSecurityUtils.getCurrentUser().getToUser();
		try {
			String  title=Struts2Utils.getParameter("title");
			String  url=Struts2Utils.getParameter("url");
			String  webid=Struts2Utils.getParameter("webid");  
			String  sort=Struts2Utils.getParameter("sort");
			String  id=Struts2Utils.getParameter("id");
			String  position=Struts2Utils.getParameter("position");
			RollInfo roll=null;
			if(StringUtils.isNotEmpty(webid)){
			  if(StringUtils.isEmpty(id)){
				 roll=new RollInfo();
				 roll.set_id(mongoSequence.currval(PubConstants.ROLL_INFO));
				
			    }else{
				 DBObject db=basedao.getMessage(PubConstants.ROLL_INFO, Long.parseLong(id));
				 roll=(RollInfo) UniObject.DBObjectToObject(db, RollInfo.class); 
			  }
			 
			roll.setWebid(Long.parseLong(webid));	
			
			if(StringUtils.isNotEmpty(sort)){
				roll.setSort(Integer.parseInt(sort));	
			} 
			roll.setUrl(url);
			roll.setTitle(title);
			roll.setPosition(position);
			basedao.insert(PubConstants.ROLL_INFO, roll);
			addActionMessage("添加成功");
			}
			
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			addActionMessage("添加失败");
		}
		return update();
		
	}
	/**
     * 修改滚动字幕
     * 
     */
    public  void  updRoll(){
    	String id=Struts2Utils.getParameter("id"); 
		DBObject db=basedao.getMessage(PubConstants.ROLL_INFO, Long.parseLong(id)); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
    	
    }
	/**
	 * 删除滚动字幕
	 * @throws Exception 
	 */
	public  String delRoll() throws Exception{
		try {
			String id=Struts2Utils.getParameter("id"); 
			if(StringUtils.isNotEmpty(id)){
				basedao.delete(PubConstants.ROLL_INFO,Long.parseLong(id));
				addActionMessage("删除成功");
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			addActionMessage("删除失败");
		}
		return update();
	}
	
	/**
	 * 添加导航条
	 * @throws Exception 
	 */
    public String  saveNavi() throws Exception{ 
    	toUser=SpringSecurityUtils.getCurrentUser().getToUser();
    	try {
    		String  title=Struts2Utils.getParameter("title");
			String  url=Struts2Utils.getParameter("url");
			String  webid=Struts2Utils.getParameter("webid");  
			String  sort=Struts2Utils.getParameter("sort"); 
			String  type=Struts2Utils.getParameter("type"); 
			String  coding=Struts2Utils.getParameter("coding");
			String  id=Struts2Utils.getParameter("id");
			String  naviid=Struts2Utils.getParameter("naviid"); 
			NavigationInfo obj=null;
			if(StringUtils.isNotEmpty(webid)){
			  if(StringUtils.isEmpty(id)){
				 obj=new NavigationInfo();
				 obj.set_id(mongoSequence.currval(PubConstants.NAVIGATION_INFO));
				
			   }else{
				 DBObject db=basedao.getMessage(PubConstants.NAVIGATION_INFO, Long.parseLong(id));
				 obj=(NavigationInfo) UniObject.DBObjectToObject(db, NavigationInfo.class); 
			   } 
		
			obj.setWebid(Long.parseLong(webid));	
			obj.setSort(Integer.parseInt(sort)); 
			obj.setUrl(url);
			obj.setTitle(title);
		    obj.setCoding(coding);
		    obj.setType(type);
		    
		    if(StringUtils.isNotEmpty(naviid)){
		    	 obj.setParentid(Long.parseLong(naviid));
		    }
		   
			basedao.insert(PubConstants.NAVIGATION_INFO, obj);
			addActionMessage("添加成功");
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			addActionMessage("添加失败");
		}
		return update();
    	
    }
    /**
     * 修改导航
     * 
     */
    public  void  updNavi(){
    	
    	String id=Struts2Utils.getParameter("id"); 
		DBObject db=basedao.getMessage(PubConstants.NAVIGATION_INFO, Long.parseLong(id)); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
    	
    }
    /**
	 * 删除导航条
     * @throws Exception 
	 */
	public  String delNavi() throws Exception{
		try {
			String id=Struts2Utils.getParameter("id");
			if(StringUtils.isNotEmpty(id)){
				basedao.delete(PubConstants.NAVIGATION_INFO,Long.parseLong(id));
				addActionMessage("删除成功");
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			addActionMessage("删除失败");
		}
		return update();
	}
	/**
	 * 获取菜单列表
	 * @return
	 * @throws Exception
	 */
	public  void  getNavis() throws Exception{
		 
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		String  id=Struts2Utils.getParameter("id"); 
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		if(StringUtils.isNotEmpty(id)){
			whereMap.put("parentid", Long.parseLong(id)); 	
		}  
		List<DBObject>list=basedao.getList(PubConstants.NAVIGATION_INFO, whereMap, sortMap);
		if(list.size()>0){
			sub_map.put("list",list);
			sub_map.put("state",0);  
			sub_map.put("naviid", id);
		}else{ 
			sub_map.put("naviid", id);
			sub_map.put("state",1);
		}  
		String json = JSONArray.fromObject(sub_map).toString();
		 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);  
    
	 
	}
    /**
     * 添加滚动图片
     * @throws Exception 
     */
    public String  saveSlide() throws Exception{ 
    	toUser=SpringSecurityUtils.getCurrentUser().getToUser();
    	try {
			String  title=Struts2Utils.getParameter("title");
			String  url=Struts2Utils.getParameter("url");
			String  webid=Struts2Utils.getParameter("webid");
			 
			String  sort=Struts2Utils.getParameter("sort");
			String  picurl=Struts2Utils.getParameter("picurl");
			String  id=Struts2Utils.getParameter("id");
			SlideInfo obj=null;
			if(StringUtils.isNotEmpty(webid)){
			  if(StringUtils.isEmpty(id)){
				 obj=new SlideInfo();
				 obj.set_id(mongoSequence.currval(PubConstants.SLIDE_INFO)); 
			    }else{
				DBObject db=basedao.getMessage(PubConstants.SLIDE_INFO, Long.parseLong(id));
				obj=(SlideInfo) UniObject.DBObjectToObject(db, SlideInfo.class); 
			   } 
			 
			obj.setWebid(Long.parseLong(webid));	
			
			if(StringUtils.isNotEmpty(sort)){
				obj.setSort(Integer.parseInt(sort));	
			} 
			obj.setUrl(url);
			obj.setTitle(title);
			obj.setPicurl(picurl); 
			basedao.insert(PubConstants.SLIDE_INFO, obj); 
 
			}
			addActionMessage("添加成功");
			
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			addActionMessage("添加失败");
		}
	 
    	return update();
    	
    }
    /**
     * 修改滚动图片
     * 
     */
    public  void  updSlide(){
    	String id=Struts2Utils.getParameter("id"); 
		DBObject db=basedao.getMessage(PubConstants.SLIDE_INFO, Long.parseLong(id)); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
    	
    }
    /**
	 * 删除滚动图片
     * @throws Exception 
	 */
	public  String delSlide() throws Exception{ 
		
		try {
			String id=Struts2Utils.getParameter("id"); 
			if(StringUtils.isNotEmpty(id)){ 
				basedao.delete(PubConstants.SLIDE_INFO,Long.parseLong(id));
				addActionMessage("删除成功");
				
			}
			
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			addActionMessage("删除失败");
		}
		return update();
	}
 
	/**
	 * 获取全部图文栏目
	 * @throws Exception
	 */
	public void getGraphiclms() throws Exception{
		 
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		String  id=Struts2Utils.getParameter("id"); 
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		if(StringUtils.isNotEmpty(id)){
			whereMap.put("parentid", Long.parseLong(id)); 	
		}  
		List<DBObject>list=basedao.getList(PubConstants.WEBSITE_GRAPH, whereMap, sortMap);
		if(list.size()>0){
			sub_map.put("list",list);
			sub_map.put("state",0);   
		}else{  
			sub_map.put("state",1);
		}  
		String json = JSONArray.fromObject(sub_map).toString();
		 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);  
   
	 
	}
	/**
	 * 添加图文栏目
	 */
	public String  addGraphiclm()throws Exception{
		toUser=SpringSecurityUtils.getCurrentUser().getToUser();
    	try {
			String  title=Struts2Utils.getParameter("title");
			String  url=Struts2Utils.getParameter("url");
			String  webid=Struts2Utils.getParameter("webid");
			String  type=Struts2Utils.getParameter("type");
			String  coding=Struts2Utils.getParameter("coding");
			String  content=Struts2Utils.getParameter("content");
			 
			String  sort=Struts2Utils.getParameter("sort");
			String  picurl=Struts2Utils.getParameter("picurl");
			String  id=Struts2Utils.getParameter("id");
			String  parentid=Struts2Utils.getParameter("parentid");
			String  state=Struts2Utils.getParameter("state");
			String  position=Struts2Utils.getParameter("position");
			Websitegrapgh obj=null;
			
			if(StringUtils.isNotEmpty(webid)){
			  if(StringUtils.isEmpty(id)){
				 obj=new Websitegrapgh();
				 obj.set_id(mongoSequence.currval(PubConstants.WEBSITE_GRAPH)); 
			    }else{
				DBObject db=basedao.getMessage(PubConstants.WEBSITE_GRAPH, Long.parseLong(id));
				obj=(Websitegrapgh) UniObject.DBObjectToObject(db, Websitegrapgh.class); 
			   } 
			 
			obj.setWebid(Long.parseLong(webid));
			obj.setToUser(toUser); 
			obj.setSort(Integer.parseInt(sort)); 
			if(StringUtils.isNotEmpty(parentid)){
				 
				obj.setParentid(Long.parseLong(parentid));
			}
			obj.setUrl(url);
			obj.setTitle(title);
			obj.setPicurl(picurl);
			obj.setCoding(coding);
			obj.setContent(content);
			obj.setType(type);
			obj.setPosition(position);
			obj.setState(state);
			basedao.insert(PubConstants.WEBSITE_GRAPH, obj); 
 
			} 
			addActionMessage("添加成功");
			
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			addActionMessage("添加失败");
		}
		
		
		return update();
		
	}
	/**
     * 修改图文栏目
     * 
     */
    public  void  updGraphiclm(){
    	String id=Struts2Utils.getParameter("id"); 
		DBObject db=basedao.getMessage(PubConstants.WEBSITE_GRAPH, Long.parseLong(id)); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
    	
    }
    
    /**
  	 * 删除图文栏目
       * @throws Exception 
  	 */
  	public  String delGraphiclm() throws Exception{ 
  		
  		try {
  			String id=Struts2Utils.getParameter("id"); 
  			if(StringUtils.isNotEmpty(id)){ 
  				basedao.delete(PubConstants.WEBSITE_GRAPH,Long.parseLong(id));
  				addActionMessage("删除成功");
  				
  			}
  			
  		} catch (NumberFormatException e) {
  			// TODO Auto-generated catch block
  			e.printStackTrace();
  			addActionMessage("删除失败");
  		}
  		return update();
  	}
	/**
	 * 添加推广链接
	 */
	public String  addPromotelink()throws Exception{
		toUser=SpringSecurityUtils.getCurrentUser().getToUser();
    	try {
			String  title=Struts2Utils.getParameter("title");
			String  url=Struts2Utils.getParameter("url");
			String  webid=Struts2Utils.getParameter("webid");
			 
			String  sort=Struts2Utils.getParameter("sort");
			String  picurl=Struts2Utils.getParameter("picurl");
			String  id=Struts2Utils.getParameter("id");
			Promotelink obj=null;
			if(StringUtils.isNotEmpty(webid)){
			  if(StringUtils.isEmpty(id)){
				 obj=new Promotelink();
				 obj.set_id(mongoSequence.currval(PubConstants.WEBSITE_PROMOTELINK)); 
			    }else{
				DBObject db=basedao.getMessage(PubConstants.WEBSITE_PROMOTELINK, Long.parseLong(id));
				obj=(Promotelink) UniObject.DBObjectToObject(db, Promotelink.class); 
			   } 
			 
			obj.setWebid(Long.parseLong(webid));	
			
			if(StringUtils.isNotEmpty(sort)){
				obj.setSort(Integer.parseInt(sort));	
			} 
			obj.setUrl(url);
			obj.setTitle(title);
			obj.setPicurl(picurl); 
			basedao.insert(PubConstants.WEBSITE_PROMOTELINK, obj); 
 
			}
			addActionMessage("添加成功");
			
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			addActionMessage("添加失败");
		}
	 
		return update();
		
	}
	/**
     * 修改推广链接
     * 
     */
    public  void  updPromotelink(){
    	String id=Struts2Utils.getParameter("id"); 
		DBObject db=basedao.getMessage(PubConstants.WEBSITE_PROMOTELINK, Long.parseLong(id)); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
    	
    }
    
    /**
  	 * 删除推广链接
       * @throws Exception 
  	 */
  	public  String delPromotelink() throws Exception{ 
  		
  		try {
  			String id=Struts2Utils.getParameter("id"); 
  			if(StringUtils.isNotEmpty(id)){ 
  				basedao.delete(PubConstants.WEBSITE_PROMOTELINK,Long.parseLong(id));
  				addActionMessage("删除成功");
  				
  			}
  			
  		} catch (NumberFormatException e) {
  			// TODO Auto-generated catch block
  			e.printStackTrace();
  			addActionMessage("删除失败");
  		}
  		return update();
  	}
  	
  	/**
	 * 添加视频
	 */
	public String  addVideo()throws Exception{
		toUser=SpringSecurityUtils.getCurrentUser().getToUser();
    	try {
			String  title=Struts2Utils.getParameter("title");
			String  url=Struts2Utils.getParameter("url");
			String  webid=Struts2Utils.getParameter("webid");
			String  position=Struts2Utils.getParameter("position");
			String  state=Struts2Utils.getParameter("state");
			String  content=Struts2Utils.getParameter("content");
			String  sort=Struts2Utils.getParameter("sort"); 
			String  id=Struts2Utils.getParameter("id");
			VideoInfo obj=null;
			if(StringUtils.isNotEmpty(webid)){
			  if(StringUtils.isEmpty(id)){
				 obj=new VideoInfo();
				 obj.set_id(mongoSequence.currval(PubConstants.VIDEO_INFO)); 
			    }else{
				DBObject db=basedao.getMessage(PubConstants.VIDEO_INFO, Long.parseLong(id));
				obj=(VideoInfo) UniObject.DBObjectToObject(db, VideoInfo.class); 
			   } 
			 
			obj.setWebid(Long.parseLong(webid));	
			
			if(StringUtils.isNotEmpty(sort)){
				obj.setSort(Integer.parseInt(sort));	
			} 
			obj.setUrl(url);
			obj.setTitle(title);
			obj.setPosition(position);
			obj.setContext(content);
			obj.setState(state);
			basedao.insert(PubConstants.VIDEO_INFO, obj); 
 
			}
			addActionMessage("添加成功");
			
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			addActionMessage("添加失败");
		}
	 
		return update();
		
	}
	/**
     * 修改视频
     * 
     */
    public  void  updVideo(){
    	String id=Struts2Utils.getParameter("id"); 
		DBObject db=basedao.getMessage(PubConstants.VIDEO_INFO, Long.parseLong(id)); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
    	
    }
    
    /**
  	 * 删除视频
       * @throws Exception 
  	 */
  	public  String delVideo() throws Exception{ 
  		
  		try {
  			String id=Struts2Utils.getParameter("id"); 
  			if(StringUtils.isNotEmpty(id)){ 
  				basedao.delete(PubConstants.VIDEO_INFO,Long.parseLong(id));
  				addActionMessage("删除成功");
  				
  			}
  			
  		} catch (NumberFormatException e) {
  			// TODO Auto-generated catch block
  			e.printStackTrace();
  			addActionMessage("删除失败");
  		}
  		return update();
  	}
  	
	/**
	 * 删除全部
	 */
	public  void  delAll(){
		try {
			basedao.delete(PubConstants.WEBSITE_INFO);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
    /**
     * 添加网站模板
     */
    public void  ajaxsaveMb(){
    	Map<String, Object> sub_map = new HashMap<String, Object>(); 
    	try {
    		 
			String mb=Struts2Utils.getParameter("mb"); 
			String webid=Struts2Utils.getParameter("webid"); 
			String toUser=SpringSecurityUtils.getCurrentUser().getToUser();
			String comid=Struts2Utils.getParameter("comid"); 
			if(StringUtils.isNotEmpty(webid)){
				DBObject db=basedao.getMessage(PubConstants.WEBSITE_INFO, webid);
				
				WebsiteInfo com=(WebsiteInfo) UniObject.DBObjectToObject(db, WebsiteInfo.class);
				if(StringUtils.isNotEmpty(mb)){ 
					com.setMb(Integer.parseInt(mb));	
				} 
				com.set_id(Long.parseLong(webid)); 
				com.setToUser(toUser);
				basedao.insert(PubConstants.WEBSITE_INFO, com);
				sub_map.put("webid", webid);
			    sub_map.put("state", 0);	 
			}else{
				WebsiteInfo com=new WebsiteInfo(); 
				Long id=mongoSequence.currval(PubConstants.WEBSITE_INFO);
				com.set_id(id);
				com.setMb(Integer.parseInt(mb));
				com.setToUser(toUser);
				if(StringUtils.isNotEmpty(comid)){
					com.setComId(Long.parseLong(comid));
				}
				
				basedao.insert(PubConstants.WEBSITE_INFO, com);
				sub_map.put("webid", id); 
				sub_map.put("state", 0);
			}
			
			
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			sub_map.put("state", 1);	
		}
    	
    	String json = JSONArray.fromObject(sub_map).toString();
		 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);  
    
    }
   
    /**
     * PC端
     * @return
     */
    public  String   webPc(){
    	String toUser=Struts2Utils.getParameter("toUser");
		
		String webid=Struts2Utils.getParameter("webid");
		 
		DBObject  db=basedao.getMessage(PubConstants.WEBSITE_INFO,Long.parseLong(webid));
	    HashMap<String, Object>whereMap=new HashMap<String, Object>();
	    HashMap<String, Object>sortMap=new HashMap<String, Object>();
	     
	    if(StringUtils.isNotEmpty(webid)){
	    	whereMap.put("webid", Long.parseLong(webid));
	    }
	    whereMap.put("parentid", null);
	    sortMap.put("sort", -1);
	    //加载网站主体
	    Struts2Utils.getRequest().setAttribute("entity", db); 
		//加载滚动
	    List<DBObject>rollList=basedao.getList(PubConstants.ROLL_INFO, whereMap, sortMap);
		//加载导航
	    List<DBObject>naviList=basedao.getList(PubConstants.NAVIGATION_INFO, whereMap, sortMap);
	    
	    for (DBObject dbObject : naviList) {
			//加载子导航
	    	HashMap<String, Object>naviwhereMap=new HashMap<String, Object>();
		    HashMap<String, Object>navisortMap=new HashMap<String, Object>();
		    naviwhereMap.put("parentid",Long.parseLong(dbObject.get("_id").toString()));
		    navisortMap.put("sort", -1);
		    List<DBObject>navchildsiList=basedao.getList(PubConstants.NAVIGATION_INFO, naviwhereMap, navisortMap);
	    	if(navchildsiList.size()>0){
	    		dbObject.put("childs", navchildsiList);
	    	}
	    	 
		}
		//加载幻灯片
	    List<DBObject>slideList=basedao.getList(PubConstants.SLIDE_INFO, whereMap, sortMap);
	    //循环加载锚链接内容
	    List<DBObject>graphicList=new ArrayList<DBObject>();
	    HashMap<String, Object>graphMap=new HashMap<String, Object>();
	    for (DBObject dbObject : naviList) {
			if(dbObject.get("url").toString().startsWith("#")){
				graphMap.put("coding",dbObject.get("url").toString().substring(1));
				graphicList.add(basedao.getMessage(PubConstants.GRAPHIC_INFO,graphMap));
				graphMap.clear();
			}
		}
	   
	    //加载推广链接
	    List<DBObject>proList=basedao.getList(PubConstants.WEBSITE_PROMOTELINK, whereMap, sortMap);
	    //加载视频
	    whereMap.put("state",'1'); 
	    List<DBObject>videolist=basedao.getList(PubConstants.VIDEO_INFO, whereMap, sortMap); 
	    //加载图文栏目
	    List<DBObject>websitegra=basedao.getList(PubConstants.WEBSITE_GRAPH, whereMap, sortMap);
	    Struts2Utils.getRequest().setAttribute("videoList", videolist);
	    Struts2Utils.getRequest().setAttribute("proList", proList);
	    Struts2Utils.getRequest().setAttribute("websitegra", websitegra);
	    Struts2Utils.getRequest().setAttribute("graphicList", graphicList);
	    Struts2Utils.getRequest().setAttribute("toUser", toUser);
	    Struts2Utils.getRequest().setAttribute("webid",webid ); 
	    Struts2Utils.getRequest().setAttribute("rollList", rollList);
	    Struts2Utils.getRequest().setAttribute("naviList", naviList);
	    Struts2Utils.getRequest().setAttribute("slideList", slideList); 
	    String mb=db.get("mb").toString(); 
    	return "pc"+mb;
    }
    /**
     * PC端
     * @return
     */
    public  String   webPcnews(){
    	String toUser=Struts2Utils.getParameter("toUser");
		
		String webid=Struts2Utils.getParameter("webid");
		 
		DBObject  db=basedao.getMessage(PubConstants.WEBSITE_INFO,Long.parseLong(webid));
	    HashMap<String, Object>whereMap=new HashMap<String, Object>();
	    HashMap<String, Object>sortMap=new HashMap<String, Object>();
	     
	    if(StringUtils.isNotEmpty(webid)){
	    	whereMap.put("webid", Long.parseLong(webid));
	    }
	    whereMap.put("parentid", null);
	    sortMap.put("sort", -1);
	    //加载网站主体
	    Struts2Utils.getRequest().setAttribute("entity", db); 
		//加载滚动
	    List<DBObject>rollList=basedao.getList(PubConstants.ROLL_INFO, whereMap, sortMap);
		//加载导航
	    List<DBObject>naviList=basedao.getList(PubConstants.NAVIGATION_INFO, whereMap, sortMap);
	    
	    for (DBObject dbObject : naviList) {
			//加载子导航
	    	HashMap<String, Object>naviwhereMap=new HashMap<String, Object>();
		    HashMap<String, Object>navisortMap=new HashMap<String, Object>();
		    naviwhereMap.put("parentid",Long.parseLong(dbObject.get("_id").toString()));
		    navisortMap.put("sort", -1);
		    List<DBObject>navchildsiList=basedao.getList(PubConstants.NAVIGATION_INFO, naviwhereMap, navisortMap);
	    	if(navchildsiList.size()>0){
	    		dbObject.put("childs", navchildsiList);
	    	}
	    	 
		}
	    String graid=Struts2Utils.getParameter("graid");
	    String gracod=Struts2Utils.getParameter("gracod");
	    DBObject gra=null;
	    //加载图文栏目
	    if(StringUtils.isNotEmpty(graid)){
	    	 whereMap.put("parentid", Long.parseLong(graid));
	    	 gra=basedao.getMessage(PubConstants.WEBSITE_GRAPH,Long.parseLong(graid));
	    }
	    if(StringUtils.isNotEmpty(gracod)){
	    	 whereMap.put("coding",gracod);
	    	 gra=basedao.getMessage(PubConstants.WEBSITE_GRAPH,whereMap);
	    } 
	    List<DBObject>websitegra=basedao.getList(PubConstants.WEBSITE_GRAPH, whereMap, sortMap);
	    //加载图文实体
	   
	    Struts2Utils.getRequest().setAttribute("websitegra", websitegra); 
	    Struts2Utils.getRequest().setAttribute("toUser", toUser);
	    Struts2Utils.getRequest().setAttribute("webid",webid ); 
	    Struts2Utils.getRequest().setAttribute("rollList", rollList);
	    Struts2Utils.getRequest().setAttribute("naviList", naviList); 
	    Struts2Utils.getRequest().setAttribute("gra", gra);
	    String mb=db.get("mb").toString(); 
    	return "news"+mb;
    }
    
	 
}
