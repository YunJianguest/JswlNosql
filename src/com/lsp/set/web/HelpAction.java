package com.lsp.set.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Pattern;

import net.sf.json.JSONArray;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction;
import com.lsp.set.entity.Aboutus;
import com.lsp.set.entity.Blacklist;
import com.lsp.set.entity.Help;
import com.lsp.set.entity.Price;
import com.lsp.set.entity.SensitiveWord;
import com.lsp.website.service.WwzService;
import com.mongodb.DBObject;
import com.mongodb.util.JSON;
/**
 * 系统帮助
 * 
 * @author lsp
 * 
 */
@Namespace("/set")
@Results({ @Result(name = HelpAction.RELOAD, location = "help.action",params={"type","%{type}","fypage", "%{fypage}"}, type = "redirect") })
public class HelpAction extends GeneralAction<Help>{
	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private MongoSequence mongoSequence;
	private Help entity = new Help();;
	private Long _id;
	@Autowired
    private WwzService wwzService;
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}

	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		sortMap.put("sort", -1);
		String type=Struts2Utils.getParameter("type");
		if(StringUtils.isNotEmpty(type)){
			whereMap.put("type",Integer.parseInt(type));
		}
		String title=Struts2Utils.getParameter("title");
		if(StringUtils.isNotEmpty(title)){
			Pattern pattern = Pattern.compile("^.*" + title + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern);
			Struts2Utils.getRequest().setAttribute("title",  title);
		}
		whereMap.put("custid", SpringSecurityUtils.getCurrentUser().getId());
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject> list = baseDao.getList(PubConstants.SET_HELP,whereMap,fypage,10,sortMap);
		fycount=baseDao.getCount(PubConstants.SET_HELP, whereMap);
		Struts2Utils.getRequest().setAttribute("list", list);
		
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		try {
			custid=SpringSecurityUtils.getCurrentUser().getId();
			baseDao.delete(PubConstants.SET_HELP, _id); 
			addActionMessage("删除成功!");

		
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,删除失败!");
		}
		return RELOAD;
	}

	@Override
	public String input() throws Exception {
	
		return "add";
	}

	@Override
	public String update() throws Exception {
	     
		DBObject db=baseDao.getMessage(PubConstants.SET_HELP,_id);
			
		Struts2Utils.getRequest().setAttribute("entity",db); 
		 
		return "add";
	}
	public void upd() throws Exception {
		DBObject db = baseDao.getMessage(PubConstants.SET_HELP, _id);
		
		String json = JSONArray.fromObject(db).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}


	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			// 有custId查出来 用户信息
			entity = (Help)UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.SET_HELP,_id),Help.class);
			
		} else {
			entity = new Help();
		}
	}

	@Override
	public String save() throws Exception {
		// 注册业务逻辑
		try {
			if(_id==null){
				_id=mongoSequence.currval(PubConstants.SET_HELP);
			} 
			entity.set_id(_id);
			entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
			entity.setCreatedate(new Date()); 
			baseDao.insert(PubConstants.SET_HELP, entity); 
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		return RELOAD;
	}
	 
	@Override
	public Help getModel() {
		return entity;
	}

	public void set_id(Long _id) {
		this._id = _id;
	}
	public  String  web(){
		custid=getCustid();
		lscode=getLscode();
		String type=Struts2Utils.getParameter("type"); 
		String lx=Struts2Utils.getParameter("lx");
		if(StringUtils.isEmpty(lx)){
			lx="1";
		}
		if(StringUtils.isEmpty(type)){
			type="1";
		}
		wwzService.flow(custid, "help"); 
		Struts2Utils.getRequest().setAttribute("lscode",lscode);
		Struts2Utils.getRequest().setAttribute("custid",custid);  
		Struts2Utils.getRequest().setAttribute("type",type);  
		return "web"+lx;
	}
	public  String  detail(){
		custid=getCustid();
		lscode=getLscode(); 
		String id=Struts2Utils.getParameter("id");
		DBObject  db=null;
		if(StringUtils.isNotEmpty(id)){
			db=baseDao.getMessage(PubConstants.SET_HELP,Long.parseLong(id));
			Struts2Utils.getRequest().setAttribute("entity",db);
		}
		Struts2Utils.getRequest().setAttribute("lscode",lscode);
		Struts2Utils.getRequest().setAttribute("custid",custid);
		if(db!=null){
			return "detail"+db.get("lx");
		}else{
			return "detail";
		}
		
	}
	/**
	 * ajax获取普通用户
	 */
	public  void  ajaxweb(){
		custid=getCustid();
		lscode=getLscode();
		String type=Struts2Utils.getParameter("type");
		String lx=Struts2Utils.getParameter("lx");
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		Struts2Utils.getRequest().setAttribute("lscode",lscode);
		Struts2Utils.getRequest().setAttribute("custid",custid); 
		if(StringUtils.isNotEmpty(custid)){
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			List<Integer>lstype=new ArrayList<Integer>();
			lstype.add(-1);
			lstype.add(1);
			lstype.add(2);
			lstype.add(3);
			lstype.add(4);
			List<HashMap<String, Object>>lsall=new ArrayList<HashMap<String, Object>>();
			
			for (Integer integer:lstype) {
				whereMap.put("custid", custid);
				whereMap.put("type",integer);
				whereMap.put("lx", Integer.parseInt(lx));
				sortMap.put("sort",1);
				List<DBObject> list=baseDao.getList(PubConstants.SET_HELP, whereMap,fypage,10,sortMap); 
				if(list.size()>0){
					HashMap<String, Object>lsmap=new HashMap<String, Object>();
					lsmap.put("list",list);
					lsmap.put("type",integer);
					lsall.add(lsmap);  
				} 
			}
			if(lsall.size()>0){
				sub_map.put("state", 0); 
				sub_map.put("list", lsall); 	
			}
			
		} 
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
 
}
