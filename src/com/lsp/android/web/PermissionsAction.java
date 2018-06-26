package com.lsp.android.web;
  
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map; 
import java.util.regex.Pattern;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.activemq.filter.function.splitFunction;
import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
 
import com.alibaba.fastjson.JSON;
import com.lsp.android.entity.MessageInfo;
import com.lsp.android.entity.Permissions;
import com.lsp.android.entity.PermissionsIn;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.DateUtil;
import com.lsp.pub.util.JmsService;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction;
import com.lsp.website.service.WwzService;
import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
 

/**
 * android权限管理
 * 
 * @author lsp
 * 
 */
@Namespace("/android")
@Results({ @Result(name = PermissionsAction.RELOAD, location = "permissions.action", params = {"fypage", "%{fypage}" }, type = "redirect") })
public class PermissionsAction extends GeneralAction<Permissions> {
	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao basedao;
	private Permissions entity = new Permissions();;
	private Long _id;
	@Autowired
	private WwzService  wwzservice;

	private MongoSequence mongoSequence;

	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}

	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		sortMap.put("sort", 1);
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject> list = basedao.getList(PubConstants.ANDROID_PERMISSIONS,whereMap,fypage,10, sortMap);
		Struts2Utils.getRequest().setAttribute("list", list); 
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		try {
			custid=SpringSecurityUtils.getCurrentUser().getId();
			basedao.delete(PubConstants.ANDROID_PERMISSIONS, _id);
			addActionMessage("成功删除!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,删除过程中出现异常!");
		}
		return RELOAD;
	}

	@Override
	public String input() throws Exception { 
		return "add";
	}

	@Override
	public String update() throws Exception { 
		return "add";
	}
	public void upd() throws Exception {
		DBObject db = basedao.getMessage(PubConstants.ANDROID_PERMISSIONS, _id);
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}
	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			// 有custId查出来 用户信息
			DBObject db = basedao.getMessage(PubConstants.ANDROID_PERMISSIONS, _id);

			entity = JSON.parseObject(db.toString(), Permissions.class);
			entity.set_id((Long) db.get("_id"));
		} else {
			entity = new Permissions();
		}
	}

	@Override
	public String save() throws Exception {
		// 注册业务逻辑
		try {
			if (_id == null) {
				_id = mongoSequence.currval(PubConstants.ANDROID_PERMISSIONS);
			}
			entity.set_id(_id); 
			basedao.insert(PubConstants.ANDROID_PERMISSIONS, entity); 
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		return RELOAD;
	}

	@Override
	public Permissions getModel() {
		return entity;
	}

	public void set_id(Long _id) {
		this._id = _id;
	}
	/**
	 * 获取权限列表
	 */
	public  void   ajaxweb(){
		getLscode();
		Map<String, Object> submap = new HashMap<String, Object>();
		String type=wwzservice.getWxUsertype(fromUserid, "androidAdmin"); 
		if(type.equals("1")){
		   HashMap<String, Object>whereMap=new HashMap<>();
		   HashMap<String, Object>sortMap=new HashMap<>();
		   sortMap.put("sort",-1);
		   List<DBObject>list=basedao.getList(PubConstants.ANDROID_PERMISSIONS, whereMap, sortMap);
		   if(list.size()>0){
			   for (DBObject dbObject : list) {
				   whereMap.clear();
				   whereMap.put("fromUserid", fromUserid);
				   whereMap.put("wid",Long.parseLong(dbObject.get("_id").toString()));
				   DBObject db=basedao.getMessage(PubConstants.ANDROID_PERMISSIONSIN, whereMap);
				   if(db!=null){
					   dbObject.put("istx", true);
				   }else{
					   dbObject.put("istx", false);
				   }
			  }
			   submap.put("state", 0);
			   submap.put("value",list); 	
		  }
		   
		}
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	} 
	/**
	 * 开通提醒
	 */
	public  void  setpermiss(){
		getLscode();
		Map<String, Object> submap = new HashMap<String, Object>();
		String id=Struts2Utils.getParameter("id");
		HashMap<String, Object>whereMap=new HashMap<>();
		whereMap.put("fromUserid", fromUserid);
		whereMap.put("wid", Long.parseLong(id));
		List<DBObject>list=basedao.getList(PubConstants.ANDROID_PERMISSIONSIN, whereMap,null);
		DBObject  obj=basedao.getMessage(PubConstants.ANDROID_PERMISSIONS, Long.parseLong(id));
		if(list.size()==0&&obj!=null){
			PermissionsIn in=new PermissionsIn();
			in.set_id(mongoSequence.currval(PubConstants.ANDROID_PERMISSIONSIN));
			in.setCustid(custid);
			in.setFromUserid(fromUserid);
			in.setWid(Long.parseLong(id));
			in.setCreatedate(new Date());
			basedao.insert(PubConstants.ANDROID_PERMISSIONSIN,in); 
			//JmsService.permessageMessage(custid, fromUserid,"权限提醒", "恭喜您开通了"+obj.get("title")+"权限",null,null,"2","permission");
			submap.put("state", 0);
		}   
		    String json = JSONArray.fromObject(submap).toString(); 
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	 
		
	}
	/**
	 * 取消提醒
	 */
	public  void  cancelpermiss(){
		getLscode();
		Map<String, Object> submap = new HashMap<String, Object>();
		String id=Struts2Utils.getParameter("id");
		HashMap<String, Object>whereMap=new HashMap<>();
		whereMap.put("fromUserid", fromUserid);
		whereMap.put("wid", Long.parseLong(id));
		basedao.delete(PubConstants.ANDROID_PERMISSIONSIN, whereMap);
		DBObject  obj=basedao.getMessage(PubConstants.ANDROID_PERMISSIONS, Long.parseLong(id));
		//JmsService.permessageMessage(custid, fromUserid,"权限提醒", "您取消了"+obj.get("title")+"权限",null,null,"2","permission");
		submap.put("state", 0);
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	public  String  login(){
		Struts2Utils.getRequest().setAttribute("custid",custid);
		return "login";
	}
    public  void   ajaxlogin(){
    	Map<String, Object> submap = new HashMap<String, Object>();
	    String id=Struts2Utils.getParameter("id");
	    String password=Struts2Utils.getParameter("password");
	    DBObject  db=wwzservice.getWXuserVipNo(id);
	    if(db!=null){
	    	if(db.get("password").toString().equals(password)&&db.get("androidAdmin").toString().equals("1")){
	    		submap.put("state", 0);
	    		submap.put("value",wwzservice.getcode(db.get("_id").toString()));
	    	}
	    }
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
    public  String  index(){
    	getLscode();
    	Struts2Utils.getRequest().setAttribute("custid",custid);
    	if(!wwzservice.getUser(custid)){ 
    		return "login";
    	}
    	if(wwzservice.getWxUser(fromUserid).get("_id").toString().equals("notlogin")){ 
    		return "login";
    	}  
        Struts2Utils.getRequest().setAttribute("entity", wwzservice.getWxUser(fromUserid));
    	String type=wwzservice.getWxUsertype(fromUserid, "androidAdmin"); 
    	Struts2Utils.getRequest().setAttribute("type", type);
		if(type.equals("1")){
		   HashMap<String, Object>whereMap=new HashMap<>();
		   HashMap<String, Object>sortMap=new HashMap<>();
		   sortMap.put("sort",-1);
		   List<DBObject>list=basedao.getList(PubConstants.ANDROID_PERMISSIONS, whereMap, sortMap);
		   if(list.size()>0){
			   for (DBObject dbObject : list) {
				   whereMap.clear();
				   whereMap.put("fromUserid", fromUserid);
				   whereMap.put("wid",Long.parseLong(dbObject.get("_id").toString()));
				   DBObject db=basedao.getMessage(PubConstants.ANDROID_PERMISSIONSIN, whereMap);
				   if(db!=null){
					   dbObject.put("istx", true);
				   }else{
					   dbObject.put("istx", false);
				   }
			  } 
		  }
		  Struts2Utils.getRequest().setAttribute("plist",list); 
		  
		  //加载权限
		  whereMap.clear();
		  whereMap.put("fromUserid", fromUserid);
		  List<DBObject>perlist=basedao.getList(PubConstants.ANDROID_PERMISSIONSIN, whereMap, null);
		  String per="";
		  if(perlist.size()>0){
			  for (DBObject dbObject : perlist) {
				DBObject  obj=basedao.getMessage(PubConstants.ANDROID_PERMISSIONS, Long.parseLong(dbObject.get("wid").toString()));
				
				if(obj!=null&&obj.get("type")!=null){
					per+=obj.get("type").toString()+",";
				}
			}
		  }
		  Struts2Utils.getRequest().setAttribute("per", per);
		}
		return "index";
		
	}
    /**
     * ajax阅读消息
     */
    public  void  ajaxreadingmsg(){
    	getLscode();
		Map<String, Object> submap = new HashMap<String, Object>();
		String id=Struts2Utils.getParameter("id");
		if(StringUtils.isNotEmpty(id)){
			DBObject db=basedao.getMessage(PubConstants.ANDROID_MESSAGEINFO, Long.parseLong(id));
			if(db!=null){
				MessageInfo  msg=(MessageInfo) UniObject.DBObjectToObject(db, MessageInfo.class);
				msg.setReadid(msg.getReadid()+","+fromUserid);
				basedao.insert(PubConstants.ANDROID_MESSAGEINFO,msg);
				submap.put("state",0);
			}
		}
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
    /**
     * ajax获取未读消息
     */
    public  void  ajaxmsg(){
    	getLscode();
		Map<String, Object> submap = new HashMap<String, Object>();
		HashMap<String, Object>whereMap=new HashMap<>();
		HashMap<String, Object>sortMap=new HashMap<>();
		whereMap.put("fromUserid",fromUserid); 
		List<DBObject>perlist=basedao.getList(PubConstants.ANDROID_PERMISSIONSIN,whereMap, null); 
		 
		if(perlist.size()>0){
			  for (DBObject dbObject : perlist) {
				DBObject  obj=basedao.getMessage(PubConstants.ANDROID_PERMISSIONS, Long.parseLong(dbObject.get("wid").toString()));
				if(obj!=null){ 
					whereMap.clear(); 
					sortMap.put("createdate",1);
					whereMap.put("lx", obj.get("type").toString());
					whereMap.put("custid",custid); 
					String perdate=dbObject.get("createdate").toString();
					//时间验证
					BasicDBObject dateCondition = new BasicDBObject(); 
					dateCondition.append("$gte",DateFormat.getFormat(perdate)); 
					whereMap.put("createdate", dateCondition);
					//不包含指定字符串
					Pattern pattern = Pattern.compile("^(?!.*?" + fromUserid + ").*$",
							Pattern.CASE_INSENSITIVE);
					BasicDBList   dblist=new BasicDBList(); 
					dblist.add(new BasicDBObject("readid",null));
					dblist.add(new BasicDBObject("readid",pattern));
					//or判断
					whereMap.put("$or", dblist); 
					List<DBObject>msglist=basedao.getList(PubConstants.ANDROID_MESSAGEINFO,whereMap, sortMap); 
					 
					for (DBObject dbObject2 : msglist) {  
						 if(dbObject2!=null){
								JmsService.permessageMessage(custid, fromUserid,dbObject2.get("_id").toString(),"2"); 
							}
					}
					
				} 
				
			}
		}
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
    public  void  deleteAll(){
    	//custid=SpringSecurityUtils.getCurrentUser().getId();
    	//basedao.delete(PubConstants.ANDROID_PERMISSIONSIN);
    	//basedao.delete(PubConstants.ANDROID_MESSAGEINFO);
    	
    }
}
