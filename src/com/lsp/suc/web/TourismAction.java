package com.lsp.suc.web;

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
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

 
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction;
import com.lsp.suc.entity.Tourism;
import com.lsp.website.entity.CommentInfo;
import com.lsp.website.service.WebsiteService;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;

/**
 * 旅游管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name ="reload", location = "tourism.action", type = "redirect") })
public class TourismAction  extends GeneralAction<Tourism>{

	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private MongoSequence mongoSequence;	
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}
	@Autowired
	private WebsiteService webService;
	
	private Tourism entity=new Tourism();
	private Long _id;


	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		HashMap<String, Object> backMap =new HashMap<String, Object>();
		
		toUser=SpringSecurityUtils.getCurrentUser().getToUser();
		sortMap.put("sort", -1); 
		//whereMap.put("toUser", toUser);
		String title=Struts2Utils.getParameter("title");
		if(StringUtils.isNotEmpty(title)){
			Pattern pattern = Pattern.compile("^.*" + title + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern);
			Struts2Utils.getRequest().setAttribute("title",  title);
		}
		backMap.put("context", 0);
		backMap.put("summary", 0);
		
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		
		List<DBObject> list=baseDao.getList(PubConstants.TOURISM_INFRO,whereMap,fypage,10,sortMap,backMap);
		fycount=baseDao.getCount(PubConstants.TOURISM_INFRO);
		Struts2Utils.getRequest().setAttribute("tourismList", list);
		Struts2Utils.getRequest().setAttribute("toUser", toUser);
		
		return SUCCESS;
	}


	@Override
	public Tourism getModel() {
		// TODO Auto-generated method stub
		return entity;
	}


	@Override
	public String input() throws Exception {
		// TODO Auto-generated method stub
		return "add";
	}


	@Override
	public String update() throws Exception {
		// TODO Auto-generated method stub
		DBObject  db=baseDao.getMessage(PubConstants.TOURISM_INFRO, _id);
		List<Double>list=(List<Double>) db.get("loc");
		String latLng=list.get(0)+","+list.get(1); 
		db.put("latLng", latLng);
		Struts2Utils.getRequest().setAttribute("entity", db);
		
		return "add";
	}


	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id==null){
				_id=mongoSequence.currval(PubConstants.TOURISM_INFRO);
			}
			String lat=Struts2Utils.getParameter("latLng");
			String[]strs=lat.split(",");
			List<Double>list=new ArrayList<Double>();
			list.add(Double.parseDouble(strs[0]));
			list.add(Double.parseDouble(strs[1]));
			entity.setLoc(list);
			
			toUser=SpringSecurityUtils.getCurrentUser().getToUser();
			entity.set_id(_id);
			entity.setToUser(toUser);
			entity.setInsdate(new Date());
			baseDao.insert(PubConstants.TOURISM_INFRO, entity);
			addActionMessage("添加成功");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			addActionMessage("添加失败");
		}
		return RELOAD;
	}


	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id!=null){
				String toUser=Struts2Utils.getParameter("toUser");
				baseDao.delete(PubConstants.TOURISM_INFRO, _id);
				//删除评论
				HashMap<String, Object> whereMap=new HashMap<String, Object>();
				whereMap.put("type", toUser+_id+"tourism");
				baseDao.delete(PubConstants.COMMENT_INFO,whereMap);
				addActionMessage("删除成功");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			addActionMessage("删除失败");
		}
		return RELOAD;
	}


	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id!=null){
				DBObject db=baseDao.getMessage(PubConstants.TOURISM_INFRO, _id);
				entity= (Tourism) UniObject.DBObjectToObject(db, Tourism.class);
			}else{
				entity=new Tourism();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	 	
	}
	public void set_id(Long _id) {
		this._id = _id;
	}
	public void upd() throws Exception {
		String id=Struts2Utils.getParameter("id");
		DBObject db = baseDao.getMessage(PubConstants.TOURISM_INFRO, id);
 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}
	
	
	public String web() throws Exception {
		  
	 
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		 
		webService.flow(toUser, "wxmenu-tourism");
		
	 
		sortMap.put("sort", -1);
		
		whereMap.put("toUser", toUser);
		
		List<DBObject> tourism=baseDao.getList(PubConstants.TOURISM_INFRO,whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("tourismList", tourism);
		
		DBObject bqsel=new BasicDBObject();
		bqsel.put("title", "搜索");
		bqsel.put("marker", "fa-search");
		
		Struts2Utils.getRequest().setAttribute("bqsel", bqsel);
		 
		Struts2Utils.getRequest().setAttribute("advertisement", webService.advertisement(toUser, "tourism"));
		return "web";
	}
	/**
	 * 获取景点列表
	 * @return
	 * @throws Exception 
	 */
	public void ajaxweb() throws Exception {
		 
		
		String sel=Struts2Utils.getParameter("sel"); 
		Map<String, Object> sub_map = new HashMap<String, Object>();

		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		
		if(StringUtils.isNotEmpty(sel)){
			Pattern pattern = Pattern.compile("^.*" + sel + ".*$",Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern);
		} 
		String sortby=Struts2Utils.getParameter("sortby");
		if(sortby==null){
			sortMap.put("insdate", -1);
		}else if(sortby.equals("1")){
			sortMap.put("ydl", -1);
		}else{
			sortMap.put("sort", -1);
		}
		
		whereMap.put("toUser", toUser);
		
		if(Struts2Utils.getParameter("fypage")!=null){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		
		List<DBObject> comList=baseDao.getList(PubConstants.TOURISM_INFRO, whereMap,fypage,10, sortMap);
		 
		for(DBObject db:comList){
			if(db.get("insdate")!=null){
				db.put("insdate", DateFormat.getSampleDate(DateFormat.getFormat(db.get("insdate").toString())));
			}
			
		   HashMap<String, Object> wherecomMap=new HashMap<String, Object>();
		   wherecomMap.put("type", toUser+db.get("_id")+"tourism");
		   Long comcount=baseDao.getCount(PubConstants.COMMENT_INFO,wherecomMap);
		   db.put("comcount", comcount);
			 
		}
		if(comList.size()>0){
			sub_map.put("state", 0);
		}else{
			sub_map.put("state", 1);
		}
		
		sub_map.put("list", comList);
		String json = JSONArray.fromObject(sub_map).toString();
		 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	
	
	/**
	 * 保存评论
	 */
	public void savecomment(){ 
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		try { 
			String context=Struts2Utils.getParameter("context");
			String title=Struts2Utils.getParameter("title");
			String type=Struts2Utils.getParameter("type");
			String wid=Struts2Utils.getParameter("wid");
			CommentInfo commentInfo=new CommentInfo();
			String toUser=Struts2Utils.getParameter("toUser");
			commentInfo.set_id(mongoSequence.currval(PubConstants.COMMENT_INFO));
			commentInfo.setFromUser(fromUser);
			commentInfo.setContext(context); 
			commentInfo.setCreatedate(new Date());
			commentInfo.setTitle(title); 
			commentInfo.setType(toUser+wid+type);
			baseDao.insert(PubConstants.COMMENT_INFO, commentInfo);
		    //addActionMessage("添加成功");
			sub_map.put("state", 0);
		    
//		    
//			fromUser=this.getFromUser();
//			 
//			//加载景点
//			DBObject  db=baseDao.getMessage(PubConstants.TOURISM_INFRO, Long.parseLong(wid));
//			List<Double>list=(List<Double>) db.get("loc");
//			String latLng=list.get(0)+","+list.get(1);
//			db.put("latLng", latLng);
//			Struts2Utils.getRequest().setAttribute("entity", db);
//		 
//			//加载评论
//			HashMap<String, Object>whereMap=new HashMap<String, Object>();
//			HashMap<String, Object>sortMap=new HashMap<String, Object>();
//			
//			whereMap.put("type", toUser+wid);
//			sortMap.put("createdate", -1);
//			
//			List<DBObject> detaillist=baseDao.getList(PubConstants.COMMENT_INFO, whereMap, sortMap);
//		 
//			Struts2Utils.getRequest().setAttribute("detailList", detaillist);
//
//			Struts2Utils.getRequest().setAttribute("toUser", toUser);	
//		    Struts2Utils.getRequest().setAttribute("toUser", toUser);
		   
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			//addActionMessage("添加失败");
			sub_map.put("state", 1);
			 
		}
		String json = JSONArray.fromObject(sub_map).toString();
			
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
     
	}
	/**
	 * 详细信息
	 * @return
	 */
	public  String  detail(){ 
		// TODO Auto-generated method stub
		addydl(); 
		//加载分享 
	 
		//加载景点
		DBObject  db=baseDao.getMessage(PubConstants.TOURISM_INFRO, _id);
		List<Double>list=(List<Double>) db.get("loc");
		String latLng=list.get(0)+","+list.get(1);
		db.put("latLng", latLng);
		Struts2Utils.getRequest().setAttribute("entity", db); 
		//加载评论
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>(); 
		whereMap.put("type", toUser+_id+"tourism");
		sortMap.put("createdate", -1);
		
		List<DBObject> detaillist=baseDao.getList(PubConstants.COMMENT_INFO, whereMap, sortMap);
	 
		Struts2Utils.getRequest().setAttribute("detailList", detaillist);

		Struts2Utils.getRequest().setAttribute("toUser", toUser);	
		return "detail";
	}
	public void  addydl(){
		
		try {
			DBObject db=baseDao.getMessage(PubConstants.TOURISM_INFRO, _id);
			if(db!=null){
				Tourism tourism=(Tourism) UniObject.DBObjectToObject(db, Tourism.class);
				if(tourism.getYdl()==null){
					tourism.setYdl(0L);
				}
				tourism.setYdl(tourism.getYdl()+1);
				baseDao.insert(PubConstants.TOURISM_INFRO, tourism);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
	}
	
}
