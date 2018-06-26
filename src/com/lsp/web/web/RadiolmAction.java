package com.lsp.web.web;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
 
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction; 
import com.lsp.web.entity.RadiolmInfo;
import com.lsp.website.entity.WebsiteFlowInfo;
import com.lsp.website.service.WebsiteService;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;

/**
 * 广播栏目管理
 * @author lsp
 *
 */
@Namespace("/web")
@Results({@org.apache.struts2.convention.annotation.Result(name="reload", location="radiolm.action", type="redirect")})
public class RadiolmAction extends GeneralAction<RadiolmInfo> {


	private static final long serialVersionUID = -6784469775589971579L;


	  @Autowired
	  private WebsiteService wwzService;
	  @Autowired
	  private BaseDao basedao;
	  private Long _id;
	  private RadiolmInfo entity = new RadiolmInfo();
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
		  whereMap.put("toUser", SpringSecurityUtils.getCurrentUser().getToUser());
		  Struts2Utils.getRequest().setAttribute("toUser", SpringSecurityUtils.getCurrentUser().getToUser());
		  List<DBObject> list = this.basedao.getList(PubConstants.RADIOLM_INFO, 
			      whereMap, sortMap);
		 Struts2Utils.getRequest().setAttribute("radiolmList", list);
		 fycount=basedao.getCount(PubConstants.RADIOLM_INFO, whereMap);
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
				_id=mongoSequence.currval(PubConstants.RADIOLM_INFO);
			}
			entity.set_id(_id);
			entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
			entity.setCreatedate(new Date());
			entity.setToUser(SpringSecurityUtils.getCurrentUser().getToUser());
			basedao.insert(PubConstants.RADIOLM_INFO, entity);
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
				basedao.delete(PubConstants.RADIOLM_INFO,_id);
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
			  DBObject emDbObject = this.basedao.getMessage(PubConstants.RADIOLM_INFO, 
				        this._id);
				        this.entity = ((RadiolmInfo)UniObject.DBObjectToObject(emDbObject, 
				        		RadiolmInfo.class));
		}else{
			entity=new RadiolmInfo();
		}
		
	}
	public RadiolmInfo getModel()
	  {
	    return this.entity;
	  }
	public void  upd(){ 
		DBObject db = basedao.getMessage(PubConstants.RADIOLM_INFO, _id);
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}
	public String  web(){
		 
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		HashMap<String, Object> whereMap = new HashMap<String, Object>(); 
		String  toUser=Struts2Utils.getParameter("toUser");
		List<DBObject> list=basedao.getList(PubConstants.RADIOLM_INFO,whereMap,0,10, sortMap);
		Struts2Utils.getRequest().setAttribute("radiolmList", list);
	 
	  
		DBObject bqsel=new BasicDBObject();
		bqsel.put("title", "搜索");
		bqsel.put("marker", "fa-search");
		
		Struts2Utils.getRequest().setAttribute("bqsel", bqsel);
		
		Struts2Utils.getRequest().setAttribute("list",GetAllFunc.wxFunc.get(toUser));
		Struts2Utils.getRequest().setAttribute("advertisement", wwzService.advertisement(toUser, "radiolm")); 
		return "web";
	}
	 public void ajaxweb() throws Exception {

		  
			String sel=Struts2Utils.getParameter("sel");
			HashMap<String, Object> sortMap = new HashMap<String, Object>();
			HashMap<String, Object> whereMap = new HashMap<String, Object>();
			Map<String, Object> sub_map = new HashMap<String, Object>();
			String  toUser=Struts2Utils.getParameter("toUser");
			
			sortMap.put("sort", -1);
			if(StringUtils.isNotEmpty(toUser)){
				whereMap.put("toUser", toUser);
			}
			if(StringUtils.isNotEmpty(sel)){
				Pattern pattern = Pattern.compile("^.*" + sel + ".*$",Pattern.CASE_INSENSITIVE);
				whereMap.put("title", pattern);
			}
			if(Struts2Utils.getParameter("fypage")!=null){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
				
			}
			List<DBObject> list=basedao.getList(PubConstants.RADIOLM_INFO,whereMap,fypage,10, sortMap);
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
 
}
