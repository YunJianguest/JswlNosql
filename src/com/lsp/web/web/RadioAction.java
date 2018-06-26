package com.lsp.web.web;

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

import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction;
import com.lsp.web.entity.RadioInfo;
import com.lsp.web.entity.RadiolmInfo;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;

/**
 * 广播管理
 * @author Ccjh
 *
 */
@Namespace("/web")
@Results({@org.apache.struts2.convention.annotation.Result(name="reload", location="radio.action", type="redirect")})
public class RadioAction extends GeneralAction<RadioInfo> {

	private static final long serialVersionUID = -6784469775589971579L;


	  @Autowired
	  private BaseDao basedao;
	  private Long _id;
	  private RadioInfo entity = new RadioInfo();
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
		  HashMap<String,Object> sortMap=new HashMap<String, Object>();
		  sortMap.put("sort", -1);
		  
		  
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
		 String lmid = Struts2Utils.getParameter("lmid");
		 if (StringUtils.isNotEmpty(lmid)) {
			      
			      whereMap.put("lmid", Long.parseLong(lmid));
			      Struts2Utils.getRequest().setAttribute("lmid", lmid);
			    }
		  
		  whereMap.put("toUser", SpringSecurityUtils.getCurrentUser().getToUser());
		  Struts2Utils.getRequest().setAttribute("toUser", SpringSecurityUtils.getCurrentUser().getToUser());
		  List<DBObject> list = this.basedao.getList(PubConstants.RADIO_INFO, 
			      whereMap, sortMap);
		 Struts2Utils.getRequest().setAttribute("radioList", list);
		 fycount=basedao.getCount(PubConstants.RADIO_INFO, whereMap);
		 
		  return SUCCESS;
	  }
	@Override
	public String input() throws Exception {
		
		return "add";
	}

	@Override
	public String update() throws Exception {
		// TODO Auto-generated method stub
		return "add";
	}

	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id==null){
				_id=mongoSequence.currval(PubConstants.RADIO_INFO);
			}
			 HashMap<String, Object> whereMap = new HashMap<String, Object>();
			 whereMap.put("toUser", SpringSecurityUtils.getCurrentUser().getToUser());
			 String lmid = Struts2Utils.getParameter("lmid");
			 if (StringUtils.isNotEmpty(lmid)) {
				     entity.setLmid(Long.parseLong(lmid));
				     whereMap.put("lmid", Long.parseLong(lmid));
				     
				      Struts2Utils.getRequest().setAttribute("lmid", lmid);
				    }
			  
			entity.set_id(_id);
			entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
			entity.setCreatedate(new Date());
			entity.setToUser(SpringSecurityUtils.getCurrentUser().getToUser());
			basedao.insert(PubConstants.RADIO_INFO, entity);
			
			 if (StringUtils.isNotEmpty(lmid)) {
				 
			  DBObject obj=basedao.getMessage(PubConstants.RADIOLM_INFO,Long.parseLong(lmid));
			  RadiolmInfo radiolmInfo=(RadiolmInfo) UniObject.DBObjectToObject(obj, RadiolmInfo.class);
			  radiolmInfo.setConcount(basedao.getCount(PubConstants.RADIO_INFO,whereMap));  
			  basedao.insert(PubConstants.RADIOLM_INFO, radiolmInfo);
			   
			  
			 }
		
			addActionMessage("添加成功!");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			addActionMessage("添加失败!");
		}
		
		return RELOAD;
	}

	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id!=null){
				basedao.delete(PubConstants.RADIO_INFO,_id);
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
			  DBObject emDbObject = this.basedao.getMessage(PubConstants.RADIO_INFO, 
				        this._id);
				        this.entity = ((RadioInfo)UniObject.DBObjectToObject(emDbObject, 
				        		RadioInfo.class));
		}else{
			entity=new RadioInfo();
		}
		
	}
	public RadioInfo getModel()
	  {
	    return this.entity;
	  }
	public void  upd(){ 
		DBObject db = basedao.getMessage(PubConstants.RADIO_INFO, _id);
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}
	public String  web(){
		
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		HashMap<String, Object> whereMap = new HashMap<String, Object>(); 
		String  toUser=Struts2Utils.getParameter("toUser");
		sortMap.put("sort", -1);
		Long  lmid=Long.parseLong(Struts2Utils.getParameter("lmid"));
		whereMap.put("lmid", lmid);
		whereMap.put("toUser", toUser);
		List<DBObject> list=basedao.getList(PubConstants.RADIO_INFO,whereMap,0,10, sortMap);
		Struts2Utils.getRequest().setAttribute("radioList", list);
		DBObject  db=basedao.getMessage(PubConstants.RADIOLM_INFO, lmid);
		Struts2Utils.getRequest().setAttribute("radiolm", db);
		
		DBObject bqsel=new BasicDBObject();
		bqsel.put("title", "搜索");
		bqsel.put("marker", "fa-search");
		
		Struts2Utils.getRequest().setAttribute("bqsel", bqsel);
		
		//WxToken token=WeiXinUtil.getSignature(toUser,Struts2Utils.getRequest());
		//Struts2Utils.getRequest().setAttribute("token", token);
		Struts2Utils.getRequest().setAttribute("title", "");

		//Struts2Utils.getRequest().setAttribute("list",GetAllFunc.wxFunc.get(toUser));
		 
		return "web";
	}
	 public void ajaxweb() throws Exception {

			
			HashMap<String, Object> sortMap = new HashMap<String, Object>();
			HashMap<String, Object> whereMap = new HashMap<String, Object>();
			Map<String, Object> sub_map = new HashMap<String, Object>();
			String  toUser=Struts2Utils.getParameter("toUser"); 
			Long  lmid=Long.parseLong(Struts2Utils.getParameter("lmid"));
			whereMap.put("lmid", lmid);
			sortMap.put("sort", -1);
			if(StringUtils.isNotEmpty(toUser)){
				whereMap.put("toUser", toUser);
			}
			if(Struts2Utils.getParameter("fypage")!=null){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
				
			}
			List<DBObject> list=basedao.getList(PubConstants.RADIO_INFO,whereMap,fypage,10, sortMap);
			for(DBObject db:list){
				if(db.get("createdate")!=null){
					db.put("createdate", DateFormat.getDatenoss(DateFormat.getFormat(db.get("createdate").toString())));
				}
			}
			if(list.size()==0){
				sub_map.put("state", 1);
			}else{
				sub_map.put("state", 0);
			}
			
			sub_map.put("list", list);
			String json = JSONArray.fromObject(sub_map).toString();
			
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
			
		}
	 
	 public  void  ajaxplay(){
		  String  id=Struts2Utils.getParameter("_id");
		  Map<String, Object> sub_map = new HashMap<String, Object>();
		  if(StringUtils.isNotEmpty(id)){ 
		      DBObject db = basedao.getMessage(PubConstants.RADIO_INFO, Long.parseLong(id));
		      RadioInfo radioInfo=(RadioInfo) UniObject.DBObjectToObject(db, RadioInfo.class);
		      radioInfo.setPlaycount(radioInfo.getPlaycount()+1);
		      basedao.insert(PubConstants.RADIO_INFO, radioInfo);
		      DBObject obj=basedao.getMessage(PubConstants.RADIOLM_INFO,radioInfo.getLmid());
			  RadiolmInfo radiolmInfo=(RadiolmInfo) UniObject.DBObjectToObject(obj, RadiolmInfo.class);
			  radiolmInfo.setPlaycount(radiolmInfo.getPlaycount()+1); 
			  basedao.insert(PubConstants.RADIOLM_INFO, radiolmInfo);
			  sub_map.put("state", 0);
			  sub_map.put("radio", radioInfo);
		  }
		  sub_map.put("state", 1);
		  String json = JSONArray.fromObject(sub_map).toString(); 
		  Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]); 
		  
	 }
}
