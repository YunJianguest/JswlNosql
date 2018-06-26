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
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.entity.WxToken;
import com.lsp.pub.util.DictionaryUtil;
import com.lsp.pub.util.MarkerHtml;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.web.GeneralAction;
import com.lsp.suc.entity.WxFootfunc;
import com.lsp.suc.entity.WxFunc;
import com.lsp.suc.entity.Comunit;
import com.lsp.web.entity.AdvertisingInfo;
import com.lsp.website.entity.RollInfo;
import com.lsp.website.service.WwzService;
import com.lsp.weixin.entity.WxPayConfig;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBObject;

/**
 * 企业管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name = ComunitAction.RELOAD, location = "comunit.action",params={"tab", "%{tab}"}, type = "redirect") })
public class ComunitAction extends GeneralAction<Comunit>{

	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private Comunit entity=new Comunit();;
	private String _id;
	private int tab;
	@Autowired
	private WwzService wwzService;
	@Autowired
	private DictionaryUtil dictionaryUtil;
	private MongoSequence mongoSequence;	
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}
	@Override
	public String execute() throws Exception {
	
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		HashMap<String, Object> backMap =new HashMap<String, Object>(); 
		backMap.put("summary", 0);
		String toUser= SpringSecurityUtils.getCurrentUser().getToUser();
		
		String keyword=Struts2Utils.getParameter("keyword");
		if(StringUtils.isNotEmpty(keyword)){
			Pattern pattern = Pattern.compile("^.*" + keyword + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("keyword", pattern);
			Struts2Utils.getRequest().setAttribute("keyword",keyword);
		}
		String title=Struts2Utils.getParameter("title");
		if(StringUtils.isNotEmpty(keyword)){
			Pattern pattern = Pattern.compile("^.*" + title + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern);
			Struts2Utils.getRequest().setAttribute("title",keyword);
		}
		whereMap.put("toUser", toUser);
		sortMap.put("sort", -1);
		List<DBObject>list=baseDao.getList(PubConstants.DATA_WXTOUSER, whereMap,fypage,10,sortMap,backMap);
		fycount=baseDao.getCount(PubConstants.WX_COMPANY, whereMap);
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		
		Struts2Utils.getRequest().setAttribute("comList", list);
        
		return SUCCESS;
	}
	public String updatecom() throws Exception {
		
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		String custid=SpringSecurityUtils.getCurrentUser().getId();  
		DBObject db=baseDao.getMessage(PubConstants.DATA_WXTOUSER,custid);
		
		if(db!=null){
			entity = (Comunit)UniObject.DBObjectToObject(db,Comunit.class);
		}
		Struts2Utils.getRequest().setAttribute("entity", entity);
		
		whereMap.clear();
		sortMap.put("sort", 1);
		whereMap.put("custid", custid);
		List<DBObject> list=baseDao.getList(PubConstants.DATA_WXFUNCTION,whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("wxfuncList", list);
		whereMap.clear();
		whereMap.put("custid", custid);
		//whereMap.put("parentid", null);
		List<DBObject> footList=baseDao.getList(PubConstants.WX_FOOTFUNCTION,whereMap, sortMap);
		 
		Struts2Utils.getRequest().setAttribute("footList", footList);
		List<DBObject> iconlist=dictionaryUtil.parentDicList(18);
		Struts2Utils.getRequest().setAttribute("iconlist",iconlist);
		Struts2Utils.getRequest().setAttribute("typeList", dictionaryUtil.dicListByMongo("微信菜单"));
		
		
		whereMap.clear();
		sortMap.put("sort", 1);
		whereMap.put("custid", custid);
		whereMap.put("type", "index_1");
		
		List<DBObject> advlist=baseDao.getList(PubConstants.ADVERTISEMENT,whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("advlist",advlist);
		
		whereMap.clear();
		sortMap.put("sort", 1);
		whereMap.put("custid", custid);
		whereMap.put("type", "index_1");
		
		List<DBObject> rolllist=baseDao.getList(PubConstants.NEW_ROLL,whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("rolllist",rolllist);
		Struts2Utils.getRequest().setAttribute("custid", custid); 
		Struts2Utils.getRequest().setAttribute("toUser", SpringSecurityUtils.getCurrentUser().getToUser()); 
		return "add";
	}
	
	@Override
	public String delete() throws Exception {
		try {
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
		    whereMap.put("_id",_id);
		    whereMap.put("custid", SpringSecurityUtils.getCurrentUser().getId());
			baseDao.delete(PubConstants.DATA_WXTOUSER,whereMap);
			addActionMessage("成功删除!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,删除过程中出现异常!");
		}
		return RELOAD;
	}
	public String delfunc() throws Exception {
		try {
		
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
		    whereMap.put("_id", Long.parseLong(_id));
		    whereMap.put("custid", SpringSecurityUtils.getCurrentUser().getId());
			baseDao.delete(PubConstants.DATA_WXFUNCTION,whereMap);
			addActionMessage("成功删除!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,删除过程中出现异常!");
		}
		return updatecom();
	}
	public String deladv() throws Exception {
		try {
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
		    whereMap.put("_id", Long.parseLong(_id));
		    whereMap.put("custid", SpringSecurityUtils.getCurrentUser().getId());
			baseDao.delete(PubConstants.ADVERTISEMENT,whereMap);
			addActionMessage("成功删除!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,删除过程中出现异常!");
		}
		return updatecom();
	}
	public String delfoot() throws Exception {
		try {
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
		    whereMap.put("_id", Long.parseLong(_id));
		    whereMap.put("custid", SpringSecurityUtils.getCurrentUser().getId());
			baseDao.delete(PubConstants.WX_FOOTFUNCTION,whereMap);
			addActionMessage("成功删除!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,删除过程中出现异常!");
		}
		return updatecom();
	}
	public String delroll() throws Exception {
		try {
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
		    whereMap.put("_id", Long.parseLong(_id));
		    whereMap.put("custid", SpringSecurityUtils.getCurrentUser().getId());
			baseDao.delete(PubConstants.NEW_ROLL,whereMap);
			addActionMessage("成功删除!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,删除过程中出现异常!");
		}
		return updatecom();
	} 
	@Override
	public String input() throws Exception {
		return "add";
	}
	
	@Override
	public String update() throws Exception {
		return "add";
	}
	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			//有custId查出来 用户信息
			entity = (Comunit)UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.DATA_WXTOUSER,_id),Comunit.class);
			
		} else {
			entity = new Comunit();
		}
	}
	
	

	@Override
	public String save() throws Exception {
		//注册业务逻辑
		/*try {
			String toUser= SpringSecurityUtils.getCurrentUser().getToUser();
			entity.set_id(toUser);
			entity.setToUser(toUser);
			baseDao.insert(PubConstants.DATA_WXTOUSER,entity);
			GetAllFunc.wxTouser.put(toUser, entity);
			if(entity.getZhlx()>0){
				WxToken token=new WxToken();
				token.set_id(toUser);
				token.setAppid(entity.getAppid());
				token.setSecret(entity.getSecret());
				token.setExpires_in(0);
				token.setToUser(toUser);
				token.setZhlx(entity.getZhlx());
				
				GetAllFunc.wxtoken.put(toUser+_id, token);
				
			}
			
			
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}*/
		
		return updatecom();
	}
	/**
	 * 添加基本信息
	 * @return
	 * @throws Exception
	 */
	public String savebase() throws Exception {
		//注册业务逻辑
		try {
			String coustid= SpringSecurityUtils.getCurrentUser().getId();
			toUser=SpringSecurityUtils.getCurrentUser().getToUser();
			DBObject wxdb=baseDao.getMessage(PubConstants.DATA_WXTOUSER,coustid);
			if(wxdb!=null){
				entity = (Comunit)UniObject.DBObjectToObject(wxdb,Comunit.class);	
			}
			entity.set_id(coustid);
			entity.setCustid(SpringSecurityUtils.getCurrentUser().getCustid()); 
			entity.setTitle(Struts2Utils.getParameter("title"));
			entity.setMb(Struts2Utils.getParameter("mb")); 
			entity.setMp3(Struts2Utils.getParameter("mp3"));
			entity.setLogo(Struts2Utils.getParameter("logo"));
			entity.setFoot(Struts2Utils.getParameter("foot"));
			entity.setJfbs(Struts2Utils.getParameter("jfbs"));
			entity.setCss(Integer.parseInt(Struts2Utils.getParameter("css")));
			entity.setSummary(Struts2Utils.getParameter("summary"));
			entity.setToUser(toUser);
			entity.setBjt(Struts2Utils.getParameter("bjt"));
			entity.setSort(Integer.parseInt(Struts2Utils.getParameter("sort")));
			baseDao.insert(PubConstants.DATA_WXTOUSER,entity); 
			GetAllFunc.wxTouser.put(coustid, entity);
			 
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return updatecom();
	}
	/**
	 * 添加微信配置信息
	 * @return
	 * @throws Exception
	 */
	public String savewx() throws Exception {
		//注册业务逻辑
		try {
			 
			     String custid= SpringSecurityUtils.getCurrentUser().getId();
			     toUser=SpringSecurityUtils.getCurrentUser().getToUser();
			     DBObject wxdb=baseDao.getMessage(PubConstants.DATA_WXTOUSER,custid);
			    if(wxdb!=null){
				  entity = (Comunit)UniObject.DBObjectToObject(wxdb,Comunit.class);	
			    }
			    entity.set_id(custid);
		    	entity.setZhlx(Integer.parseInt(Struts2Utils.getParameter("zhlx")));
				entity.setAppid(Struts2Utils.getParameter("appid"));
				entity.setToUser(toUser);
				entity.setSecret(Struts2Utils.getParameter("secret"));
				entity.setQx(Integer.parseInt(Struts2Utils.getParameter("qx")));
				entity.setKf(Integer.parseInt(Struts2Utils.getParameter("kf")));
				entity.setIsjh(Integer.parseInt(Struts2Utils.getParameter("isjh")));
				entity.setSqlx(Integer.parseInt(Struts2Utils.getParameter("sqlx")));
				baseDao.insert(PubConstants.DATA_WXTOUSER,entity); 
				GetAllFunc.wxTouser.put(custid, entity);
				if(entity.getZhlx()>0){
					WxToken token=new WxToken();
					token.set_id(toUser);
					token.setAppid(entity.getAppid());
					token.setSecret(entity.getSecret());
					token.setExpires_in(0);
					token.setToUser(toUser); 
					token.setZhlx(1); 
					GetAllFunc.wxtoken.put(toUser, token);
					
				}
				
		   
			
			
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return updatecom();
	}
	/**
	 * 添加菜单信息
	 * @return
	 * @throws Exception
	 */
	public String savefunc() throws Exception {
		//注册业务逻辑
		try {
			WxFunc func=new WxFunc();
			String id=Struts2Utils.getParameter("_id");
			if(StringUtils.isEmpty(id)){
				func.set_id(mongoSequence.currval(PubConstants.DATA_WXFUNCTION));	
			}else{
				func.set_id(Long.parseLong(id));
			}
			toUser=SpringSecurityUtils.getCurrentUser().getToUser();
			String custid= SpringSecurityUtils.getCurrentUser().getId(); 
			func.setCustid(custid);
			func.setToUser(toUser);
			func.setName(Struts2Utils.getParameter("name"));
			func.setKey(Struts2Utils.getParameter("key"));
			func.setPicurl(Struts2Utils.getParameter("picurl"));
			func.setType(Struts2Utils.getParameter("type"));
			func.setMb(Integer.parseInt(Struts2Utils.getParameter("mb")));
			func.setXs(Integer.parseInt(Struts2Utils.getParameter("xs")));
			func.setSummary(Struts2Utils.getParameter("summary"));
			func.setAdminurl(Struts2Utils.getParameter("adminurl"));
			func.setUrl(Struts2Utils.getParameter("url").replace("&fromUser=fromUserData", ""));
			func.setSort(Integer.parseInt(Struts2Utils.getParameter("sort")));
			func.setTb(Struts2Utils.getParameter("tb"));
			baseDao.insert(PubConstants.DATA_WXFUNCTION,func);
			GetAllFunc.wxfunc.put(custid+func.getKey(), func.getName());
			GetAllFunc.wxmenu.put(custid+func.getKey(), func);
			GetAllFunc.wxMb.put(custid+func.getKey(), func.getMb());
			
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return updatecom();
	}
	/**
	 * 添加底部菜单信息
	 * @return
	 * @throws Exception
	 */
	public String savefoot() throws Exception {
		//注册业务逻辑
		try {  
			    toUser=SpringSecurityUtils.getCurrentUser().getToUser(); 
			    String custid= SpringSecurityUtils.getCurrentUser().getId(); 
				WxFootfunc func=new WxFootfunc();
				String id=Struts2Utils.getParameter("id");
				if(StringUtils.isEmpty(id)){
					func.set_id(mongoSequence.currval(PubConstants.WX_FOOTFUNCTION));	
				}else{
					func.set_id(Long.parseLong(id));
				}
				func.setCustid(custid);
				func.setToUser(toUser);
				func.setTitle(Struts2Utils.getParameter("title"));
				func.setSort(Integer.parseInt(Struts2Utils.getParameter("sort")));
				func.setPicurl(Struts2Utils.getParameter("picurl"));
				func.setIoc(Struts2Utils.getParameter("ioc"));
				func.setType(Struts2Utils.getParameter("type"));
				if(StringUtils.isNotEmpty(Struts2Utils.getParameter("parentid"))){
					func.setParentid(Long.parseLong(Struts2Utils.getParameter("parentid")));
				}
			 
				func.setUrl(Struts2Utils.getParameter("url")); 
				baseDao.insert(PubConstants.WX_FOOTFUNCTION,func);
			 
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return updatecom();
	}
	/**
	 * 修改菜单
	 * @return
	 * @throws Exception
	 */
	public void updfunc() throws Exception{ 
		String id=Struts2Utils.getParameter("id"); 
		DBObject db=baseDao.getMessage(PubConstants.DATA_WXFUNCTION, Long.parseLong(id)); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
		
	}
	public String saveadv() throws Exception {
		//注册业务逻辑
		try {
			AdvertisingInfo news=new AdvertisingInfo();
			String custid= SpringSecurityUtils.getCurrentUser().getId();
			String id=Struts2Utils.getParameter("id");
			if(StringUtils.isEmpty(id)){
				news.set_id(mongoSequence.currval(PubConstants.ADVERTISEMENT));	
			}else{
				news.set_id(Long.parseLong(id));
			}
			toUser=SpringSecurityUtils.getCurrentUser().getToUser();
			news.setToUser(toUser);
			news.setCustid(custid);
			news.setType("index_1");
			news.setTitle(Struts2Utils.getParameter("title"));
			
			news.setPicurl(Struts2Utils.getParameter("picurl"));
			
		
			news.setUrl(Struts2Utils.getParameter("url").replace("&fromUser=fromUserData", ""));
			news.setSort(Integer.parseInt(Struts2Utils.getParameter("sort")));
			baseDao.insert(PubConstants.ADVERTISEMENT,news);
			
			
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return updatecom();
	}
	public String saveroll() throws Exception {
		//注册业务逻辑
		try {
			RollInfo roll=new RollInfo();
			String id=Struts2Utils.getParameter("id");
			String custid= SpringSecurityUtils.getCurrentUser().getId();
			if(StringUtils.isEmpty(id)){
				roll.set_id(mongoSequence.currval(PubConstants.NEW_ROLL));	
			}else{
				roll.set_id(Long.parseLong(id));
			}
			roll.setCustid(custid);
			toUser=SpringSecurityUtils.getCurrentUser().getToUser();
			roll.setToUser(toUser);
			roll.setType("index_1");
			roll.setTitle(Struts2Utils.getParameter("title"));
			
			
		
			roll.setUrl(Struts2Utils.getParameter("url").replace("&fromUser=fromUserData", ""));
			roll.setSort(Integer.parseInt(Struts2Utils.getParameter("sort")));
			baseDao.insert(PubConstants.NEW_ROLL,roll);
			
			
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return updatecom();
	}
	public String fabu() throws Exception{
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		
		sortMap.put("sort", 1);
		
		String toUser=SpringSecurityUtils.getCurrentUser().getToUser();
		whereMap.put("toUser", toUser);
		String custid=SpringSecurityUtils.getCurrentUser().getId();
		whereMap.put("custid", custid);
		sortMap.put("sort", 1);
		List<DBObject> list=baseDao.getList(PubConstants.DATA_WXFUNCTION,whereMap, sortMap);
		GetAllFunc.wxFunc.put(custid, list);
		for(int i=0;i<list.size();i++){
			WxFunc func=(WxFunc)UniObject.DBObjectToObject(list.get(i),WxFunc.class);
			GetAllFunc.wxfunc.put(custid+func.getKey(), func.getName());
			GetAllFunc.wxmenu.put(custid+func.getKey(), list.get(i));
			GetAllFunc.wxMb.put(custid+func.getKey(), func.getMb());
		}
		whereMap.clear();
		whereMap.put("custid", custid);
		sortMap.put("sort", 1);
		List<DBObject> footlist=baseDao.getList(PubConstants.WX_FOOTFUNCTION,whereMap, sortMap);
		GetAllFunc.footFunc.put(custid, footlist);
		return updatecom();
	}
	public String register() throws Exception {
		String toUser= SpringSecurityUtils.getCurrentUser().getToUser();
		MarkerHtml mk=new MarkerHtml();
		mk.register(toUser);
		return RELOAD;
	}
	public void updpay() throws Exception {
		DBObject db = baseDao.getMessage(PubConstants.WEIXIN_PAYCONFIG, _id);
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}

	public String savepay() throws Exception {
		//注册业务逻辑
		try {
			String toUser= SpringSecurityUtils.getCurrentUser().getToUser();
			String custid= SpringSecurityUtils.getCurrentUser().getId();
			entity=GetAllFunc.wxTouser.get(custid); 
			WxPayConfig wc=new WxPayConfig();
			wc.set_id(custid);
			wc.setAppid(entity.getAppid());
			wc.setAppsecret(entity.getSecret());
			wc.setAppkey(Struts2Utils.getParameter("appkey"));
			wc.setPartner(Struts2Utils.getParameter("partner"));
			wc.setPartner_key(Struts2Utils.getParameter("partner_key"));
			baseDao.insert(PubConstants.WEIXIN_PAYCONFIG,wc); 
			GetAllFunc.wxPay.put(toUser,wc);
			
			
			
			
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return updatecom();
	}
	@Override
	public Comunit getModel() {
		return entity;
	}
	public void set_id(String _id) {
		this._id = _id;
	}

	public BaseDao getBaseDao() {
		return baseDao;
	}

	public void setBaseDao(BaseDao baseDao) {
		this.baseDao = baseDao;
	}

	public Comunit getEntity() {
		return entity;
	}

	public void setEntity(Comunit entity) {
		this.entity = entity;
	}

	public int getTab() {
		return tab;
	}

	public void setTab(int tab) {
		this.tab = tab;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String get_id() {
		return _id;
	}
	/**
	 * 微网站主页面
	 * @return
	 * @throws Exception
	 */
	public  String  webIndex() throws Exception{

		toUser = Struts2Utils.getParameter("toUser");
		String custid=Struts2Utils.getParameter("custid");
		wwzService.flow(custid, "wxmenu-index"); 
		DBObject user=wwzService.getUserdb(fromUser);
		Struts2Utils.getRequest().setAttribute("user", user);
		Struts2Utils.getRequest().setAttribute("roll",wwzService.roll(custid, "index_1"));
		
		WxToken token=WeiXinUtil.getSignature(custid,Struts2Utils.getRequest());
		Struts2Utils.getRequest().setAttribute("token", token);

		Struts2Utils.getRequest().setAttribute("list",GetAllFunc.wxFunc.get(custid));
		Comunit entity = GetAllFunc.wxTouser.get(custid);
		if(entity!=null){
			Struts2Utils.getRequest().setAttribute("entity",entity);

			Struts2Utils.getRequest().setAttribute("advertisement", wwzService.advertisement(custid, "index_1"));
			
			Struts2Utils.getRequest().setAttribute("footlist",GetAllFunc.footFunc.get(custid));

			Struts2Utils.getRequest().setAttribute("mp3", entity.getMp3());
			
			Struts2Utils.getRequest().setAttribute("logo",GetAllFunc.wxTouser.get(custid).getLogo());
			
		}
		
		HashMap<String, Object> backMap=new HashMap<String, Object>();
		backMap.put("context", 0);
		DBObject aboutdb = baseDao.getMessage(PubConstants.DATA_ABOUTUS, custid,backMap);
		Struts2Utils.getRequest().setAttribute("aboutus", aboutdb); 
		return entity.getMb();
	}
	/**
	 * 企业列表
	 * @return
	 */
	public  String  web(){
		 String  toUser=Struts2Utils.getParameter("toUser"); 
		 wwzService.flow("toUser", "index"+toUser);
		 HashMap<String, Object>whereMap=new HashMap<String, Object>();
		 HashMap<String, Object>sortMap=new HashMap<String, Object>();
		 whereMap.put("toUser", toUser);
		 sortMap.put("sort", -1);  
		 Struts2Utils.getRequest().setAttribute("touser", toUser);
		return "web";
	}
	/**
	 * ajax获取企业列表
	 */
	public  void  ajaxweb(){
		String  type=Struts2Utils.getParameter("type");
		String  toUser=Struts2Utils.getParameter("toUser");
		String  fypage=Struts2Utils.getParameter("fypage");
		Map<String, Object> sub_map = new HashMap<String, Object>();
		try {
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			sortMap.put("sort", -1);
			whereMap.put("toUser", toUser);
			String keyword=Struts2Utils.getParameter("sel");
			if(StringUtils.isNotEmpty(keyword)){
				Pattern pattern = Pattern.compile("^.*" + keyword + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("keyword", pattern); 
			} 
			if(StringUtils.isNotEmpty(type)){
				Pattern pattern = Pattern.compile("^.*" + type + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("type", pattern); 
			}
			
			List<DBObject>list=baseDao.getList(PubConstants.DATA_WXTOUSER, whereMap,Integer.parseInt(fypage),10,sortMap);
			if(list.size()>0){
				sub_map.put("state", 0);
				sub_map.put("list", list);
			}else{
				sub_map.put("state", 1);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
		    sub_map.put("state", 1);
			e.printStackTrace();
		}
	} 
	/**
	 * 企业详情
	 * @return
	 * @throws Exception
	 */
	public  String  webDetail() throws Exception{

		toUser = Struts2Utils.getParameter("toUser");
		wwzService.flow(toUser, "wxmenu-index"); 
		DBObject user=wwzService.getUserdb(fromUser);
		Struts2Utils.getRequest().setAttribute("user", user);
		Struts2Utils.getRequest().setAttribute("roll",wwzService.roll(toUser, "index_1"));
		
		WxToken token=WeiXinUtil.getSignature(toUser,Struts2Utils.getRequest());
		Struts2Utils.getRequest().setAttribute("token", token);

		Struts2Utils.getRequest().setAttribute("list",GetAllFunc.wxFunc.get(toUser));
		Comunit entity = GetAllFunc.wxTouser.get(toUser);
		
		Struts2Utils.getRequest().setAttribute("entity",entity);

		Struts2Utils.getRequest().setAttribute("advertisement", wwzService.advertisement(toUser, "index_1"));
		
		Struts2Utils.getRequest().setAttribute("footlist",GetAllFunc.footFunc.get(toUser));

		Struts2Utils.getRequest().setAttribute("mp3", entity.getMp3());
		
		Struts2Utils.getRequest().setAttribute("logo",GetAllFunc.wxTouser.get(toUser).getLogo());
		
		HashMap<String, Object> backMap=new HashMap<String, Object>();
		backMap.put("context", 0);
		DBObject aboutdb = baseDao.getMessage(PubConstants.DATA_ABOUTUS, toUser,backMap);
		Struts2Utils.getRequest().setAttribute("aboutus", aboutdb); 
		return entity.getMb();
	}
	/**
	 * 配置关注页面
	 * @return
	 */
	public String  updewm()throws Exception{
		custid=SpringSecurityUtils.getCurrentUser().getId();
		Struts2Utils.getRequest().setAttribute("entity", GetAllFunc.wxTouser.get(custid)); 
		return "ewm"; 	
	}
	/**
	 * 
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	public String  saveewm()throws Exception{
		custid=SpringSecurityUtils.getCurrentUser().getId();
		String  logo=Struts2Utils.getParameter("logo");
		String  ewmurl=Struts2Utils.getParameter("ewmurl");
		Comunit  obj=GetAllFunc.wxTouser.get(custid);
		if(obj==null){
			obj=new Comunit();
			obj.set_id(custid);
		}
		obj.setLogo(logo);
		obj.setEwmurl(ewmurl);
		baseDao.insert(PubConstants.DATA_WXTOUSER, obj);
		GetAllFunc.wxTouser.put(custid, obj);
		return updewm();
	}
	public  void  ajaxsaveewm(){
		Map<String, Object> submap = new HashMap<String, Object>();
		custid=SpringSecurityUtils.getCurrentUser().getId();
		String  logo=Struts2Utils.getParameter("logo");
		String  ewmurl=Struts2Utils.getParameter("ewmurl");
		String  summary=Struts2Utils.getParameter("summary");
		String  ewmxs=Struts2Utils.getParameter("ewmxs");
		String  zsjf=Struts2Utils.getParameter("zsjf");
		String  tsjf=Struts2Utils.getParameter("tsjf");
		Comunit  obj=GetAllFunc.wxTouser.get(custid);
		if(obj==null){
			obj=new Comunit();
			obj.set_id(custid);
		}
		if(StringUtils.isNotEmpty(logo)){
			obj.setLogo(logo);	
		}
		if(StringUtils.isNotEmpty(ewmurl)){
			obj.setEwmurl(ewmurl);	
		} 
		if(StringUtils.isNotEmpty(summary)){
			obj.setSummary(summary);	
		}
		if(StringUtils.isNotEmpty(ewmxs)){
			obj.setEwmxs(Integer.parseInt(ewmxs));	
		}
		if(StringUtils.isNotEmpty(zsjf)){
			obj.setZsjf(Float.parseFloat(zsjf));
		}
		if(StringUtils.isNotEmpty(tsjf)){
			obj.setTsjf(tsjf);
		}
		baseDao.insert(PubConstants.DATA_WXTOUSER, obj);
		submap.put("state", 0);
		GetAllFunc.wxTouser.put(custid, obj);
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	 
	
}
