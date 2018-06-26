package com.lsp.suc.web;

import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.ExportExcel;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction;
import com.lsp.suc.entity.GraphiclmInfo;
import com.lsp.suc.entity.Housecomment;
import com.lsp.suc.entity.Signin;
import com.lsp.suc.entity.Signinstatis;
import com.lsp.website.service.WebsiteService;
import com.lsp.website.service.WwzService;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;

/**
 * 签到管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results({@org.apache.struts2.convention.annotation.Result(name="reload", location="signin.action",params={"parentid", "%{parentid}"},  type="redirect")})
public class SigninAction extends GeneralAction<Signin>{


	private static final long serialVersionUID = -6784469775589971579L;

	  @Autowired
	  private BaseDao basedao;
	  private Long _id;
	  private Signin entity = new Signin();
	  private MongoSequence mongoSequence;
	  @Autowired
	  private WwzService wwzService;
	  @Autowired
	  public void setMongoSequence(MongoSequence mongoSequence)
	  {
	    this.mongoSequence = mongoSequence;
	  }
	  public void set_id(Long _id) {
	    this._id = _id;
	  }
	  @Override
	  public String execute() throws Exception {
		  
		    HashMap<String, Object> sortMap =new HashMap<String, Object>();
			HashMap<String, Object> whereMap =new HashMap<String, Object>();
			HashMap<String, Object> backMap =new HashMap<String, Object>();
			
			custid=SpringSecurityUtils.getCurrentUser().getId();
			sortMap.put("sort", -1); 
			String parentid=Struts2Utils.getParameter("parentid");  
			String name=Struts2Utils.getParameter("name");
			if(StringUtils.isNotEmpty(name)){
				Pattern pattern = Pattern.compile("^.*" + name + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("content", pattern);
				Struts2Utils.getRequest().setAttribute("name",  name);
			} 
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			
			List<DBObject> list=basedao.getList(PubConstants.SUC_SIGNIN,whereMap,fypage,10,sortMap,backMap);
			fycount=basedao.getCount(PubConstants.SUC_SIGNIN,whereMap);
			Struts2Utils.getRequest().setAttribute("list", list);
			Struts2Utils.getRequest().setAttribute("custid", custid);
			
		  return SUCCESS;
	  }
	@Override
	public String input() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String update() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id==null){
				_id=mongoSequence.currval(PubConstants.SUC_SIGNIN);
			} 
			entity.set_id(_id); 
			entity.setCreatedate(new Date()); 
			
			basedao.insert(PubConstants.SUC_SIGNIN, entity);
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
				basedao.delete(PubConstants.SUC_SIGNIN,_id); 
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
	public Signin getModel() {
		// TODO Auto-generated method stub
		return entity;
	}
	 
	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		
		try {
			if(_id!=null){
				DBObject db=basedao.getMessage(PubConstants.SUC_SIGNIN, _id);
				entity= (Signin) UniObject.DBObjectToObject(db, Signin.class);
			}else{
				entity=new Signin();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	public void  upd(){
		String id=Struts2Utils.getParameter("id"); 
		DBObject db=basedao.getMessage(PubConstants.SUC_SIGNIN, Long.parseLong(id)); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
		
	}
	public  String   web(){
	 
		return "web";
	}
	/**
	 * ajax
	 */
	public  void   ajaxweb(){ 
		String parentid=Struts2Utils.getParameter("parentid");   
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		 
		 
		whereMap.put("parentid", Long.parseLong(parentid));
		
		if(Struts2Utils.getParameter("fypage")!=null){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		
		List<DBObject> comList=basedao.getList(PubConstants.SUC_HOUSECOMMENT, whereMap,fypage,10, sortMap);
		 
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
	 * ajax添加
	 */
	public  void   ajaxsave(){

		Map<String, Object> sub_map = new HashMap<String, Object>();  
		custid=getCustid();
		lscode=getLscode();
		try {
			DBObject  user=wwzService.getWxUser(fromUserid);
			if(user.get("_id").toString().equals("notlogin")){
				sub_map.put("state", 3);
				String json = JSONArray.fromObject(sub_map).toString(); 
				Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
				return ;
			}
			 
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			whereMap.put("fromUserid", fromUserid);
			Long count=basedao.getCount(PubConstants.SUC_SIGNIN, whereMap);
			if(count>0){
				//每日时间验证
				BasicDBObject dateCondition = new BasicDBObject();
				
				dateCondition.append("$gte",com.lsp.pub.util.DateUtil.getTimesmorning());
				dateCondition.append("$lt",com.lsp.pub.util.DateUtil.getTimesnight()); 
				whereMap.put("createdate", dateCondition); 
				Long  countss=basedao.getCount(PubConstants.SUC_SIGNIN, whereMap);
				if(countss>0){
					//今日已签
					sub_map.put("state", 1);
				}else{
					//记录
					Signinstatis  statis=new Signinstatis();
					statis.set_id(mongoSequence.currval(PubConstants.SUC_SIGNINSTATIS));
					statis.setCreatedate(new Date());
					statis.setFromUserid(fromUserid);
					statis.setCustid(custid);
					basedao.insert(PubConstants.SUC_SIGNINSTATIS, statis);
					Signin obj=(Signin)UniObject.DBObjectToObject(basedao.getMessage(PubConstants.SUC_SIGNIN, fromUserid), Signin.class);
					//连续签到验证
					BasicDBObject dateConditions = new BasicDBObject(); 
					dateConditions.append("$gte",com.lsp.pub.util.DateUtil.getYesterdayTimesmorning());
					dateConditions.append("$lt",com.lsp.pub.util.DateUtil.getYesterdayTimesnight()); 
					whereMap.clear();
					whereMap.put("fromUserid", fromUserid);
					whereMap.put("createdate", dateConditions); 
					Long  counts=basedao.getCount(PubConstants.SUC_SIGNIN, whereMap);
					obj.set_id(fromUserid);
					if(counts>0){
						obj.setContCount(obj.getContCount()+1);
					}else{
						obj.setContCount(1);
					}
					basedao.insert(PubConstants.SUC_SIGNIN, obj); 
					sub_map.put("state", 0);
				}
				
				
				
			}else{
				//记录
				Signinstatis  statis=new Signinstatis();
				statis.set_id(mongoSequence.currval(PubConstants.SUC_SIGNINSTATIS));
				statis.setCreatedate(new Date());
				statis.setFromUserid(fromUserid);
				statis.setCustid(custid);
				basedao.insert(PubConstants.SUC_SIGNINSTATIS, statis);
				Signin obj=new Signin();
				obj.set_id(fromUserid);
				obj.setFromUserid(fromUserid);
				obj.setCreatedate(new Date());
				obj.setContCount(1);
				basedao.insert(PubConstants.SUC_SIGNIN, obj); 
				sub_map.put("state", 0);
				
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			sub_map.put("state", 1);
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString();
		 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
 

}
