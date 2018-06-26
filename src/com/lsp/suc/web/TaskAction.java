package com.lsp.suc.web;
 
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
import com.lsp.suc.entity.Bbstypeinfo;
import com.lsp.suc.entity.IntegralInfo;
import com.lsp.suc.entity.TaskInfo;
import com.lsp.website.service.WebsiteService;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;

 
/**
 * 任务管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name ="reload", location = "task.action",type = "redirect") })
public class TaskAction extends GeneralAction<TaskInfo>{

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
	
	private TaskInfo entity=new TaskInfo();
	private Long _id;


	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		HashMap<String, Object> backMap =new HashMap<String, Object>();
		
		custid=SpringSecurityUtils.getCurrentUser().getId();
		sortMap.put("sort", -1); 
		whereMap.put("custid", custid);
		String title=Struts2Utils.getParameter("title");
		if(StringUtils.isNotEmpty(title)){
			Pattern pattern = Pattern.compile("^.*" + title + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern);
			Struts2Utils.getRequest().setAttribute("title",  title);
		}
	 
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		
		List<DBObject> list=baseDao.getList(PubConstants.SUC_TASK,whereMap,fypage,10,sortMap,backMap);
		fycount=baseDao.getCount(PubConstants.SUC_TASK,whereMap);
		Struts2Utils.getRequest().setAttribute("taskList", list);
		Struts2Utils.getRequest().setAttribute("toUser", toUser);
		
		return SUCCESS;
	}


	@Override
	public TaskInfo getModel() {
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
	 
		return "add";
	}
	public void upd() throws Exception { 
		DBObject db = baseDao.getMessage(PubConstants.SUC_TASK, _id); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}


	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id==null){
				_id=mongoSequence.currval(PubConstants.SUC_TASK); 
			} 
			String custid=SpringSecurityUtils.getCurrentUser().getId();  
			entity.set_id(_id); 
			entity.setCustid(custid); 
			baseDao.insert(PubConstants.SUC_TASK, entity);
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
		String custid=SpringSecurityUtils.getCurrentUser().getId(); 
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		whereMap.put("custid", custid);
		whereMap.put("_id", _id);
		baseDao.delete(PubConstants.SUC_TASK, whereMap);
		return RELOAD;
	}


	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id!=null){
				DBObject db=baseDao.getMessage(PubConstants.SUC_TASK, _id);
				entity= (TaskInfo) UniObject.DBObjectToObject(db, TaskInfo.class);
			}else{
				entity=new TaskInfo();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	 	
	}
	public void set_id(Long _id) {
		this._id = _id;
	}
	/**
	 * 个人任务列表
	 * @return
	 */
	public String  web(){
		getLscode();
		Struts2Utils.getRequest().setAttribute("custid", custid); 
		return "web";
	}
	public void  ajaxweb(){
		getLscode();
		Map<String, Object>submap=new HashMap<String, Object>();
		try {
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			whereMap.put("custid", custid); 
			sortMap.put("sort", -1);
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			
			List<DBObject>list=baseDao.getList(PubConstants.SUC_TASK, whereMap,10,fypage, sortMap);
			
			if(list.size()>0){
				
				for (DBObject dbObject : list) { 
					whereMap.clear();
					//每日时间验证
					BasicDBObject dateCondition = new BasicDBObject();
					
					dateCondition.append("$gte",com.lsp.pub.util.DateUtil.getTimesmorning());
					dateCondition.append("$lt",com.lsp.pub.util.DateUtil.getTimesnight()); 
					whereMap.put("createdate", dateCondition); 
					whereMap.put("parentid", Long.parseLong(dbObject.get("_id").toString()));
					whereMap.put("fromUserid",fromUserid);
				    Long count =baseDao.getCount(PubConstants.SUC_TASKRESULT, whereMap); 
				    dbObject.put("cou", count); 
					if(count>=Long.parseLong(dbObject.get("count").toString())){
						dbObject.put("state", "0");
					}else{
						dbObject.put("state", "1");
					}
				}  
				submap.put("state", 0);
				submap.put("list", list);
			}else{
				submap.put("state", 1);
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			submap.put("state", 1);
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	

}
