package com.lsp.suc.web;

import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;


import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoDbUtil;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.DictionaryInfo;
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.entity.WxToken;
import com.lsp.pub.util.BaiduPlace;
import com.lsp.pub.util.CodeImageUtil;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.DictionaryUtil;
import com.lsp.pub.util.ExportExcel;
import com.lsp.pub.util.MarkerHtml;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.web.GeneralAction;
import com.lsp.shop.entiy.ShopMb;
import com.lsp.suc.entity.CompanyInfo; 
import com.lsp.suc.entity.Place;
import com.lsp.user.entity.CustomerInfo;
import com.lsp.website.service.WwzService;
import com.lsp.weixin.entity.ShortUrl;
import com.lsp.weixin.entity.WxTicket;
import com.lsp.weixin.web.FreeMarker;
import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBObject;

/**
 * 城镇管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name = HouseAction.RELOAD, location = "house.action",params={"fypage", "%{fypage}"}, type = "redirect") })
public class HouseAction extends GeneralAction<CompanyInfo> {

	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private MongoSequence mongoSequence;	
	
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}
	@Autowired
	private WwzService wwzService;
	@Autowired
	private DictionaryUtil dictionaryUtil;
	private CompanyInfo entity=new CompanyInfo();
	private Long _id;


	@Override
	public String execute() throws Exception {
		
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		
		
		custid=SpringSecurityUtils.getCurrentUser().getId();
		Struts2Utils.getRequest().setAttribute("custid", custid);
		whereMap.put("custid", custid);
		sortMap.put("createdate", -1);
		String name=Struts2Utils.getParameter("name");
		String hy=Struts2Utils.getParameter("hy");
		String selmb=Struts2Utils.getParameter("selmb");
		String sel_enddate=Struts2Utils.getParameter("sel_enddate");
		
		String keyword=Struts2Utils.getParameter("keyword");
		if(StringUtils.isNotEmpty(hy)){
			Pattern pattern = Pattern.compile("^.*" + hy + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("type", pattern);
			Struts2Utils.getRequest().setAttribute("hy",  hy);
		}
		if(StringUtils.isNotEmpty(selmb)){
		
			whereMap.put("mb", Integer.parseInt(selmb));
			Struts2Utils.getRequest().setAttribute("selmb",  selmb);
		}
		
		if(StringUtils.isNotEmpty(keyword)){

			Pattern pattern = Pattern.compile("^.*" + keyword + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("keyword", pattern);
			Struts2Utils.getRequest().setAttribute("keyword", keyword);
		}
		if(StringUtils.isNotEmpty(name)){

			Pattern pattern = Pattern.compile("^.*" + name + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("name", pattern);
			Struts2Utils.getRequest().setAttribute("name", name);
		}
		BasicDBObject dateCondition = new BasicDBObject();
		if (StringUtils.isNotEmpty(sel_enddate)) {
			dateCondition.append("$lte",DateFormat.getFormat(sel_enddate + " 23:59:59"));
			whereMap.put("enddate", dateCondition);
			Struts2Utils.getRequest().setAttribute("sel_enddate", sel_enddate);
		}
		String selxs=Struts2Utils.getParameter("selxs");
		if(StringUtils.isNotEmpty(selxs)){
			
			whereMap.put("xs", Integer.parseInt(selxs));
			Struts2Utils.getRequest().setAttribute("selxs",  selxs);
		}
		fycount=baseDao.getCount(PubConstants.WX_COMPANY, whereMap);
		
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		HashMap<String, Object> backMap =new HashMap<String, Object>();
		backMap.put("content", 0);
		backMap.put("summary", 0); 
		List<DBObject> list=baseDao.getList(PubConstants.WX_COMPANY,whereMap,fypage,10, sortMap);
		 for (DBObject dbObject : list) {
				dbObject.put("nickname", wwzService.getCustName(dbObject.get("custid").toString()));
			} 
		whereMap.clear();
		whereMap.put("custid",SpringSecurityUtils.getCurrentUser().getId());
		List<DBObject> diclist = baseDao.getList(PubConstants.SUC_HOUSETYPE,whereMap, sortMap); 
		Struts2Utils.getRequest().setAttribute("hylist", diclist); 
		List<DBObject> mblist =dictionaryUtil.parentDicList(4);
		Struts2Utils.getRequest().setAttribute("mblist", mblist);

		Struts2Utils.getRequest().setAttribute("companyList", list);
		
	
		 
		return SUCCESS;
	}
	

	@Override
	public String delete() throws Exception {
		try {
			custid=SpringSecurityUtils.getCurrentUser().getId(); 
			baseDao.delete(PubConstants.WX_COMPANY,_id);
			addActionMessage("成功删除!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,删除过程中出现异常!");
		}
		return RELOAD;
	}
	public String deleteAll() throws Exception {
		try {
			custid=SpringSecurityUtils.getCurrentUser().getId(); 
			baseDao.delete(PubConstants.WX_COMPANY);
			addActionMessage("成功删除!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,删除过程中出现异常!");
		}
		return RELOAD;
	}
 
	@Override
	public String input() throws Exception {
		entity.setType(Struts2Utils.getParameter("type")); 
		Struts2Utils.getRequest().setAttribute("custid", SpringSecurityUtils.getCurrentUser().getId());
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		
		whereMap.put("custid", SpringSecurityUtils.getCurrentUser().getId());
		
		List<DBObject> hylist=baseDao.getList(PubConstants.SUC_HOUSETYPE, whereMap,null);
		Struts2Utils.getRequest().setAttribute("hylist", hylist);

		Struts2Utils.getRequest().setAttribute("mbmap", dictionaryUtil.parentDicList(4));
		return "add";
	}
	
	public String ktshop() throws Exception {
		DBObject db=baseDao.getMessage(PubConstants.WX_COMPANY,_id);
		DBObject shopmb=baseDao.getMessage(PubConstants.SHOP_SHOPMB,_id);
		toUser=SpringSecurityUtils.getCurrentUser().getToUser();
		if(shopmb==null){
			ShopMb sm=new ShopMb();
			sm.set_id(_id);
			if(db.get("logo")!=null){
				sm.setLogo(db.get("logo").toString());
			}
			if(db.get("name")!=null){
				sm.setName(db.get("name").toString());
			}
			sm.setMb(0);
			sm.setToUser(toUser);
			baseDao.insert(PubConstants.SHOP_SHOPMB, sm);
			addActionMessage("添加成功!");
		}else{
			addActionMessage("抱歉,已经添加过了!");
		}
		
		
	
	
	return RELOAD;
	}
	@Override
	public String update() throws Exception {	
		
		
		String custid= SpringSecurityUtils.getCurrentUser().getId();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		whereMap.put("custid", custid);
		
		List<DBObject> hylist=baseDao.getList(PubConstants.SUC_HOUSETYPE, whereMap,null);
		Struts2Utils.getRequest().setAttribute("hylist", hylist);
		Struts2Utils.getRequest().setAttribute("entity", baseDao.getMessage(PubConstants.WX_COMPANY, _id));
		Struts2Utils.getRequest().setAttribute("mbmap", dictionaryUtil.parentDicList(4));
		
		return "add";
	}
	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			//有custId查出来 用户信息
			entity = (CompanyInfo)UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.WX_COMPANY,_id),CompanyInfo.class);
		} else {
			entity = new CompanyInfo();
		}
	}
	
	

	@Override
	public String save() throws Exception {
		//注册业务逻辑
		System.out.println("---------------");
		try {
			if(_id == null){
				_id=mongoSequence.currval(PubConstants.WX_COMPANY);	
				entity.setCreatedate(new Date());
				if(entity.getMb()<0){
					CodeImageUtil.nuochePic(_id, entity.getCss(), entity.getLogo() );	
				} 	
			}		
			entity.set_id(_id);
			custid=SpringSecurityUtils.getCurrentUser().getId();
			entity.setCustid(custid);
			
		    List<Double>loc=new ArrayList<Double>();
		    if(StringUtils.isEmpty(Struts2Utils.getParameter("page_lng"))||StringUtils.isEmpty(Struts2Utils.getParameter("page_lat"))){
		    	loc.add(0.0);
			    loc.add(0.0);
		    }else{
		    	loc.add(Double.parseDouble(Struts2Utils.getParameter("page_lng")));
			    loc.add(Double.parseDouble(Struts2Utils.getParameter("page_lat")));
		    }
		    
		    entity.setLoc(loc);
		    if(entity.getMb()<0){
		    	DBObject ticke =baseDao.getMessage(PubConstants.WEIXIN_TICKET,_id.intValue());
		    	if(ticke==null){
		    		WxTicket tic = new WxTicket();
		    		tic.set_id(_id.intValue());
		    		tic.setInsdate(new Date());
		    		tic.setName(entity.getName());
		    		tic.setToUser(SpringSecurityUtils.getCurrentUser().getToUser());
		    		tic.setTel(entity.getTel());
		    		baseDao.insert(PubConstants.WEIXIN_TICKET, tic);
		    	}
		    }
 
		    //String dlurl=this.getCtxurl()+"/wwz/wwz!companynuoche.action?_id="+_id+"&toUser="+toUser;
			//ShortUrl cmpsu=WeiXinUtil.getDwz(toUser,dlurl);	
			
			//String surl=SysConfig.getProperty("ym")+"d?id="+cmpsu.get_id().toString();
			//CodeImageUtil.QRcodeToImage(surl, "cmpnuoche-"+_id, "jpg", 227, 227);
		   
		   /* if(entity.getMb()<2){
		    	entity.setToUserid("");
		    } else if(entity.getMb()==2){
		    	
		    }else{
		    	FreeMarker free=new FreeMarker();
		    	free.set_id("company-"+_id);
		    	free.setToUser(toUser);
		    	baseDao.insert(PubConstants.UPD_FREEMARKER,free);
		    }*/
			if(_id==null){
				entity.setCreatedate(new Date());
			} 
		    baseDao.insert(PubConstants.WX_COMPANY,entity);
		     
		    System.out.println("****************");
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return RELOAD;
	} 
	public String savehou() throws Exception {
		//注册业务逻辑
		System.out.println("---------------");
		try {
			if(_id == null){
				_id=mongoSequence.currval(PubConstants.WX_COMPANY);	
				entity.setCreatedate(new Date());
				if(entity.getMb()<0){
					CodeImageUtil.nuochePic(_id, entity.getCss(), entity.getLogo() );	
				} 	
			}		
			entity.set_id(_id);
			custid=SpringSecurityUtils.getCurrentUser().getId();
			entity.setCustid(custid);
			
		    List<Double>loc=new ArrayList<Double>();
		    if(StringUtils.isEmpty(Struts2Utils.getParameter("page_lng"))||StringUtils.isEmpty(Struts2Utils.getParameter("page_lat"))){
		    	loc.add(0.0);
			    loc.add(0.0);
		    }else{
		    	loc.add(Double.parseDouble(Struts2Utils.getParameter("page_lng")));
			    loc.add(Double.parseDouble(Struts2Utils.getParameter("page_lat")));
		    }
		    
		    entity.setLoc(loc);
		    if(entity.getMb()<0){
		    	DBObject ticke =baseDao.getMessage(PubConstants.WEIXIN_TICKET,_id.intValue());
		    	if(ticke==null){
		    		WxTicket tic = new WxTicket();
		    		tic.set_id(_id.intValue());
		    		tic.setInsdate(new Date());
		    		tic.setName(entity.getName());
		    		tic.setToUser(SpringSecurityUtils.getCurrentUser().getToUser());
		    		tic.setTel(entity.getTel());
		    		baseDao.insert(PubConstants.WEIXIN_TICKET, tic);
		    	}
		    }
 
		    //String dlurl=this.getCtxurl()+"/wwz/wwz!companynuoche.action?_id="+_id+"&toUser="+toUser;
			//ShortUrl cmpsu=WeiXinUtil.getDwz(toUser,dlurl);	
			
			//String surl=SysConfig.getProperty("ym")+"d?id="+cmpsu.get_id().toString();
			//CodeImageUtil.QRcodeToImage(surl, "cmpnuoche-"+_id, "jpg", 227, 227);
		   
		   /* if(entity.getMb()<2){
		    	entity.setToUserid("");
		    } else if(entity.getMb()==2){
		    	
		    }else{
		    	FreeMarker free=new FreeMarker();
		    	free.set_id("company-"+_id);
		    	free.setToUser(toUser);
		    	baseDao.insert(PubConstants.UPD_FREEMARKER,free);
		    }*/
			if(_id==null){
				entity.setCreatedate(new Date());
			} 
		    baseDao.insert(PubConstants.WX_COMPANY,entity);
		     
		    System.out.println("****************");
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return RELOAD;
	}
	public String scmb() throws Exception {
		//注册业务逻辑
		try {
			DBObject comdb=baseDao.getMessage(PubConstants.WX_COMPANY,_id);
			CodeImageUtil.nuochePic(_id, (Integer)comdb.get("css"), comdb.get("logo").toString() );	
				
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return RELOAD;
	}
	public String creat() throws Exception {
		//注册业务逻辑
		try {
				prepareModel();
				
					MarkerHtml mh=new MarkerHtml();
			    	mh.company(_id);
			    	entity.setToUserid(SysConfig.getProperty("ip")+"/marker/company/company"+_id+".html");
				
		    	entity.set_id(_id);
		    
		    baseDao.insert(PubConstants.WX_COMPANY,entity);
		     
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return RELOAD;
	}
	public String savehy() throws Exception {
		//注册业务逻辑
		try {
			DictionaryInfo dic=new DictionaryInfo();
			dic.set_id(mongoSequence.currval(PubConstants.DICTIONARY_INFO));
			dic.setKey(Struts2Utils.getParameter("key"));
			dic.setValue(Struts2Utils.getParameter("value"));
			dic.setPicurl(Struts2Utils.getParameter("picurl"));
			dic.setSort(Integer.parseInt(Struts2Utils.getParameter("sort")));
			dic.setType("行业类型");
			
			dic.setToUser(SpringSecurityUtils.getCurrentUser().getToUser());
			baseDao.insert(PubConstants.DICTIONARY_INFO,dic);
			
			addActionMessage("成功添加!");
			
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return RELOAD;
	}
	public String delhy() throws Exception {
		try {
			baseDao.delete(PubConstants.DICTIONARY_INFO,_id);
			addActionMessage("成功删除!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,删除过程中出现异常!");
		}
		return RELOAD;
	}
	public void updts() throws Exception {
		DBObject db = baseDao.getMessage(PubConstants.WX_COMPANYTS, _id);
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	} 

	public String createrf() throws Exception {
 
		Long comid=Long.parseLong(Struts2Utils.getParameter("comid"));
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		whereMap.put("comid", comid);
		DBObject rf=baseDao.getMessage(PubConstants.DATA_USER, whereMap);
		Struts2Utils.getRequest().setAttribute("rf", rf);
		Struts2Utils.getRequest().setAttribute("comid", comid);
		whereMap.clear();
		whereMap.put("toUser", SpringSecurityUtils.getCurrentUser().getToUser());
		List<DBObject> rolelist=baseDao.getList(PubConstants.ROLL_INFO, whereMap,null);
		HashMap<String, String> rolemap =new HashMap<String, String>();
		for(int i=0;i<rolelist.size();i++){
			rolemap.put(rolelist.get(i).get("_id").toString(), rolelist.get(i).get("rolename").toString());
			
		}
		Struts2Utils.getRequest().setAttribute("rolemap", rolelist);
		return "rf";
	} 
	public String saverf() throws Exception {
		CustomerInfo rfentity=new CustomerInfo();
		String userid=Struts2Utils.getParameter("userid");
		if(StringUtils.isEmpty(userid)){
			rfentity.set_id(mongoSequence.currval(PubConstants.DATA_USER));
		}else{
			
			DBObject rfdb =baseDao.getMessage(PubConstants.DATA_USER,Long.parseLong(userid));
			rfentity=(CustomerInfo)UniObject.DBObjectToObject(rfdb,CustomerInfo.class);
			rfentity.set_id(Long.parseLong(userid));
		}
		
		
		
		rfentity.setToUser(SpringSecurityUtils.getCurrentUser().getToUser());
		rfentity.setLoginname(Struts2Utils.getParameter("loginname"));
		rfentity.setPassword(Struts2Utils.getParameter("password"));
		rfentity.setCustname(Struts2Utils.getParameter("custname"));
		rfentity.setRoleid(Long.parseLong(Struts2Utils.getParameter("roleid")));
		
		
		rfentity.setComid(Long.parseLong(Struts2Utils.getParameter("comid")));
		rfentity.setRemark(Struts2Utils.getParameter("remark"));
		rfentity.setStartdate(DateFormat.getFormat(Struts2Utils.getParameter("startdate")));
		rfentity.setEnddate(DateFormat.getFormat(Struts2Utils.getParameter("enddate")));
		baseDao.insert(PubConstants.DATA_USER, rfentity);
	
		Long comid=Long.parseLong(Struts2Utils.getParameter("comid"));
		entity = (CompanyInfo)UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.WX_COMPANY,comid),CompanyInfo.class);
		entity.set_id(comid);
		entity.setCustid(rfentity.get_id().toString());
		baseDao.insert(PubConstants.WX_COMPANY,entity);
		return RELOAD;
	}
	public String creatmb() throws Exception {
		
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		whereMap.put("mb",  new BasicDBObject("$gt", 3)  );
		toUser=SpringSecurityUtils.getCurrentUser().getToUser();
		whereMap.put("toUser", toUser);
		List<DBObject> list=baseDao.getList(PubConstants.WX_COMPANY, whereMap,null);
		
    	String _id="";
    	MarkerHtml mh=new MarkerHtml();
    
    	for(int i=0;i<list.size();i++){
    		_id= list.get(i).get("_id").toString();
    		
    			CompanyInfo entity = (CompanyInfo)UniObject.DBObjectToObject(list.get(i),CompanyInfo.class);
					
	    			entity.set_id(Long.parseLong(_id));
	        			
	    		    mh.company(Long.parseLong(_id));
	    		    entity.setToUserid(SysConfig.getProperty("ip")+"/marker/company/company"+_id+".html");
	    		    	
	    		    baseDao.insert(PubConstants.WX_COMPANY,entity);
	    		    	
	    		
				

    	}
    	addActionMessage("成功添加!");
    	return RELOAD;
	}
	public void sckp() throws Exception {
		toUser=SpringSecurityUtils.getCurrentUser().getToUser();
		String dlurl=SysConfig.getProperty("ip")+"/wwz/wwz!companynuoche.action?_id="+_id+"&toUser="+toUser;
		ShortUrl cmpsu=WeiXinUtil.getDwz(toUser,dlurl);	
		
		String surl=SysConfig.getProperty("ym")+"d?id="+cmpsu.get_id().toString();
		CodeImageUtil.QRcodeToImage(surl, "cmpnuoche700-"+_id, "jpg", 700, 700);
		
		CodeImageUtil.aiPic(_id);	
		
    	
	}
	@Override
	public CompanyInfo getModel() {
		return entity;
	}
	public void set_id(Long _id) {
		this._id = _id;
	}
	 
	public void exp() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		toUser=SpringSecurityUtils.getCurrentUser().getToUser();
		whereMap.put("toUser", toUser);
		sortMap.put("sort", -1);
		String hy=Struts2Utils.getParameter("hy");
		String type=Struts2Utils.getParameter("type");
		String area=Struts2Utils.getParameter("area");
		String keyword=Struts2Utils.getParameter("keyword");
		if(StringUtils.isNotEmpty(hy)){
			Pattern pattern = Pattern.compile("^.*" + hy + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("type", pattern);
			Struts2Utils.getRequest().setAttribute("hy",  hy);
		}
	
		if(StringUtils.isNotEmpty(area)){
			Pattern pattern = Pattern.compile("^.*" + area + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("area", pattern);
			
			Struts2Utils.getRequest().setAttribute("area", area);
		}
		if(StringUtils.isNotEmpty(keyword)){

			Pattern pattern = Pattern.compile("^.*" + keyword + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("keyword", pattern);
			Struts2Utils.getRequest().setAttribute("keyword", keyword);
		}
		
		
		List<DBObject> list=baseDao.getList(PubConstants.WX_COMPANY,whereMap, sortMap);
		String[] header={ "编号","企业名字", "关键字", "企业地址", "电话", "行业", "模板"};  
		String[] body={ "_id","name", "keyword", "address", "tel", "type", "mb"}; 
		
		String newtime = new Date().getTime() + ".xls";
		
		HSSFWorkbook wb = ExportExcel.exportByMongo(list, header, body, newtime);  
		Struts2Utils.getResponse().setHeader("Content-disposition", "attachment;filename="
				+ URLEncoder.encode(newtime, "utf-8"));
        OutputStream ouputStream = Struts2Utils.getResponse().getOutputStream();  
        wb.write(ouputStream);  
        ouputStream.flush();  
        ouputStream.close();  
	}
	public String comment() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		
		
		whereMap.put("wid", _id);
		sortMap.put("insdate", -1);
		if(Struts2Utils.getParameter("fypage")!=null){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		fycount=baseDao.getCount(PubConstants.WX_COMCOMMENT, whereMap);
		List<DBObject> list=baseDao.getList(PubConstants.WX_COMCOMMENT,whereMap,fypage,10, sortMap);
		for(DBObject db:list){
			DBObject user=baseDao.getMessage(PubConstants.DATA_WXUSER, db.get("fromUser").toString());
			if(user!=null){
				if(user.get("headimgurl")!=null){
					db.put("headimgurl", user.get("headimgurl").toString());
				}
				if(user.get("tel")!=null){
					db.put("tel", user.get("tel").toString());
				}
				if(user.get("no")!=null){
					db.put("no", user.get("no").toString());
				}
				if(user.get("nickname")!=null){
					db.put("nickname", user.get("nickname").toString());
				}
				if(user.get("name")!=null){
					db.put("name", user.get("name").toString());
				}
				if(user.get("ly")!=null){
					db.put("ly", user.get("ly").toString());
				}
			}
				
		}
		Struts2Utils.getRequest().setAttribute("commentList", list);
		Struts2Utils.getRequest().setAttribute("wid", _id);

		return "comment";
	}
	public void commentexp() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		
		
		whereMap.put("wid", _id);
		sortMap.put("insdate", -1);
		if(Struts2Utils.getParameter("fypage")!=null){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		fycount=baseDao.getCount(PubConstants.WX_COMCOMMENT, whereMap);
		List<DBObject> list=baseDao.getList(PubConstants.WX_COMCOMMENT,whereMap, sortMap);
		for(DBObject db:list){
			DBObject user=baseDao.getMessage(PubConstants.DATA_WXUSER, db.get("fromUser").toString());
			if(user!=null){
				if(user.get("headimgurl")!=null){
					db.put("headimgurl", user.get("headimgurl").toString());
				}
				if(user.get("tel")!=null){
					db.put("tel", user.get("tel").toString());
				}
				if(user.get("no")!=null){
					db.put("no", user.get("no").toString());
				}
				if(user.get("nickname")!=null){
					db.put("nickname", user.get("nickname").toString());
				}
				if(user.get("name")!=null){
					db.put("name", user.get("name").toString());
				}
				if(user.get("ly")!=null){
					db.put("ly", user.get("ly").toString());
				}
			}
				
		}
		String[] header={ "编号","姓名", "微信名", "电话", "代码", "留言","日期"};  
		String[] body={ "_id","name", "nickname", "tel", "no", "comment", "insdate"}; 
		
		String newtime = new Date().getTime() + ".xls";
		
		HSSFWorkbook wb = ExportExcel.exportByMongo(list, header, body, newtime);  
		Struts2Utils.getResponse().setHeader("Content-disposition", "attachment;filename="
				+ URLEncoder.encode(newtime, "utf-8"));
        OutputStream ouputStream = Struts2Utils.getResponse().getOutputStream();  
        wb.write(ouputStream);  
        ouputStream.flush();  
        ouputStream.close();  
	}
	public  String  commentdelete()
	{
		custid=getCustid(); 
		try {
			if(_id!=null){
				HashMap<String, Object>whereMap=new HashMap<String, Object>();
				whereMap.put("custid",custid); 
				whereMap.put("_id", _id);
				baseDao.delete(PubConstants.WX_COMCOMMENT,_id);
				
				addActionMessage("删除成功！");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			addActionMessage("删除失败!");
		} 
		
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		
		String  wid=Struts2Utils.getParameter("wid");
		whereMap.put("wid", Long.parseLong(wid));
		sortMap.put("insdate", -1);
		if(Struts2Utils.getParameter("fypage")!=null){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		fycount=baseDao.getCount(PubConstants.WX_COMCOMMENT, whereMap);
		List<DBObject> list=baseDao.getList(PubConstants.WX_COMCOMMENT,whereMap,fypage,10, sortMap);
		for(DBObject db:list){
			DBObject user=baseDao.getMessage(PubConstants.DATA_WXUSER, db.get("fromUser").toString());
			if(user!=null){
				if(user.get("headimgurl")!=null){
					db.put("headimgurl", user.get("headimgurl").toString());
				}
				if(user.get("tel")!=null){
					db.put("tel", user.get("tel").toString());
				}
				if(user.get("no")!=null){
					db.put("no", user.get("no").toString());
				}
				if(user.get("nickname")!=null){
					db.put("nickname", user.get("nickname").toString());
				}
				if(user.get("name")!=null){
					db.put("name", user.get("name").toString());
				}
				if(user.get("ly")!=null){
					db.put("ly", user.get("ly").toString());
				}
			}
				
		}
		Struts2Utils.getRequest().setAttribute("commentList", list);
		Struts2Utils.getRequest().setAttribute("wid",wid);

		return "comment";
		
	}
	
	public String web() {
		getLscode();
		wwzService.flow(custid, "house");
		Struts2Utils.getRequest().setAttribute("custid",custid); 
		WxToken token=GetAllFunc.wxtoken.get(custid); 
		 if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 }
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/house!web.action?custid="+custid;  
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		whereMap.put("custid", custid);
		sortMap.put("sort", -1);
		List<DBObject> list = baseDao.getList(PubConstants.SUC_HOUSETYPE,
				whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("reading", wwzService.getFlow(custid, "house"));
		Struts2Utils.getRequest().setAttribute("type", list); 
		DBObject share=wwzService.getShareFx(custid,"house_share");
		Struts2Utils.getRequest().setAttribute("share", share);
		Struts2Utils.getRequest().setAttribute("slide",wwzService.getslide(custid, "house"));
		if(share!=null&&share.get("fxmb")!=null){
			return "web"+share.get("fxmb").toString();
		}  
		return "web";

	}
	public void  ajaxweb(){
		String  type=Struts2Utils.getParameter("type");
		String  custid=Struts2Utils.getParameter("custid");
		String  fypage=Struts2Utils.getParameter("fypage");
		Map<String, Object> sub_map = new HashMap<String, Object>();
		try {
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			sortMap.put("createdate", -1);
			whereMap.put("custid", custid);
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
			whereMap.put("xs", 0);//加载显示  
			BasicDBObject dateCondition = new BasicDBObject(); 
			dateCondition.append("$gte",new Date());
			whereMap.put("enddate",dateCondition);
			List<DBObject>list=baseDao.getList(PubConstants.WX_COMPANY, whereMap,Integer.parseInt(fypage),10,sortMap);
 
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
		String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		 
	}
	public void  ajaxzrweb(){ 
		String  custid=Struts2Utils.getParameter("custid"); 
		Map<String, Object> sub_map = new HashMap<String, Object>();
		try {
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			sortMap.put("sort", -1);
			whereMap.put("custid", custid); 
			whereMap.put("xs", 0);//加载显示  
			BasicDBObject dateCondition = new BasicDBObject(); 
			dateCondition.append("$gte",new Date());
			whereMap.put("enddate",dateCondition);
			List<DBObject>list=baseDao.getList(PubConstants.WX_COMPANY, whereMap,0,5,sortMap);
 
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
		String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		 
	}
	public String  webDetail(){
		getLscode(); 
		String id=Struts2Utils.getParameter("_id");
		Struts2Utils.getRequest().setAttribute("custid",custid); 
		WxToken token=GetAllFunc.wxtoken.get(custid);
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 }
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/house!webDetail.action?custid="+custid+"&_id="+id;  
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
	    DBObject  db=baseDao.getMessage(PubConstants.WX_COMPANY, Long.parseLong(id));
	       if(db!=null){
	    	   reading(db);   
	       }
	       Struts2Utils.getRequest().setAttribute("entity",db); 
	    
	    DBObject  share=new BasicDBObject(); 
	 
		share.put("fxtitle", db.get("name"));
		share.put("fxsummary", db.get("summary")); 
		share.put("fximg", db.get("logo")); 
		share.put("fxurl",url);
		Struts2Utils.getRequest().setAttribute("share", share);
		if(Integer.parseInt(db.get("mb").toString())>=1){
			Struts2Utils.getRequest().setAttribute("jumpurl",db.get("url"));
			return "detail99";
		}
		return "detail";
		
	}
	public String  webadd(){
		getLscode();
		DBObject db=wwzService.getWxUser(fromUserid);
		Struts2Utils.getRequest().setAttribute("user", db); 
		Struts2Utils.getRequest().setAttribute("custid", custid); 
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		whereMap.put("custid", custid);
		sortMap.put("sort", -1);
		List<DBObject> list = baseDao.getList(PubConstants.SUC_HOUSETYPE,
				whereMap, sortMap);
		 
		Struts2Utils.getRequest().setAttribute("type", list); 
		String id=Struts2Utils.getParameter("id");
		if(StringUtils.isNotEmpty(id)){
			Struts2Utils.getRequest().setAttribute("entity",baseDao.getMessage(PubConstants.WX_COMPANY, Long.parseLong(id)));
			Struts2Utils.getRequest().setAttribute("slide",wwzService.slide(custid, "house-"+id));
		}
		return "webadd";
		
	}
	/**
	 * 手机添加黄页
	 */
	public void  ajaxwebadd(){

		Map<String, Object> sub_map = new HashMap<String, Object>();
		try {
			custid=getCustid();
			lscode=getLscode(); 
			wwzService.flow(custid, custid+"house-web-add");
			String  name=Struts2Utils.getParameter("name");
			String  css=Struts2Utils.getParameter("css");
			String  keyword=Struts2Utils.getParameter("keyword");
			String  picurl=Struts2Utils.getParameter("picurl");
			String  logo=Struts2Utils.getParameter("logo");
			String  content=Struts2Utils.getParameter("content");
			String  tel=Struts2Utils.getParameter("tel");
			String  address=Struts2Utils.getParameter("address");
			String  type=Struts2Utils.getParameter("type");
			
			CompanyInfo  obj=new CompanyInfo();
			obj.set_id(mongoSequence.currval(PubConstants.WX_COMPANY));
			obj.setAddress(address);
			obj.setContext(content); 
			if(StringUtils.isNotEmpty(css)){
			   obj.setCss(Integer.parseInt(css));
			}
			obj.setName(name);
			obj.setPicurl(picurl);
			obj.setCreatedate(new Date());
			obj.setTel(tel); 
			obj.setCustid(custid);
			obj.setFromUserid(fromUserid);
			obj.setLogo(logo);
			obj.setType(type);
			obj.setMb(0);
			obj.setSort(0);
			obj.setKeyword(keyword); 
			obj.setXs(2);
			obj.setCustid(custid);
			baseDao.insert(PubConstants.WX_COMPANY, obj);
			sub_map.put("state", 0);
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			
			sub_map.put("state", 1);
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * 手机用户黄页列表
	 */
	public  void  ajaxlist(){

		Map<String, Object> sub_map = new HashMap<String, Object>();
		try {
			String  custid=Struts2Utils.getParameter("custid");
			lscode=getLscode();
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			whereMap.put("custid", custid);
			whereMap.put("fromUserid", fromUserid);
			List<DBObject>list=baseDao.getList(PubConstants.WX_COMPANY, whereMap,fypage,10,sortMap);
			if(list.size()>0){
				sub_map.put("state", 0);
				sub_map.put("list", list);
			}else{
				sub_map.put("state",1);
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			sub_map.put("state", 1);
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	} 
	/**
	 * 阅读城镇
	 * @param db
	 */
	public void  reading(DBObject db){
		if(db.get("reading")==null){
			CompanyInfo  com=(CompanyInfo) UniObject.DBObjectToObject(db, CompanyInfo.class);
			com.setReading(1);
			baseDao.insert(PubConstants.WX_COMPANY, com);
		}else{
			CompanyInfo  com=(CompanyInfo) UniObject.DBObjectToObject(db, CompanyInfo.class);
			com.setReading(com.getReading()+1);
			baseDao.insert(PubConstants.WX_COMPANY, com);
			
		}
	}
	/**
	 * 我的黄页
	 * @return
	 */
	public  String  personalhome(){ 
		getLscode();
		Struts2Utils.getRequest().setAttribute("custid", custid); 
		return "personalhome";
		
	}
	public void  ajaxpersonalhome(){ 
		getLscode(); 
		Map<String, Object> sub_map = new HashMap<String, Object>();
		try { 
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			whereMap.put("custid", custid);
			whereMap.put("fromUserid", fromUserid);
			List<DBObject>list=baseDao.getList(PubConstants.WX_COMPANY, whereMap,fypage,10,sortMap);
			if(list.size()>0){
				sub_map.put("state", 0);
				sub_map.put("list", list);
			}else{
				sub_map.put("state",1);
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			sub_map.put("state", 1);
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);
	}
	public void  auditok(){
		Map<String, Object> sub_map = new HashMap<String, Object>();
		custid=SpringSecurityUtils.getCurrentUser().getId();
		String id=Struts2Utils.getParameter("id");
		if(StringUtils.isNotEmpty(id)){
			CompanyInfo obj=(CompanyInfo) UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.WX_COMPANY, Long.parseLong(id)),CompanyInfo.class);
			obj.set_id(Long.parseLong(id));
			obj.setXs(0);
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.YEAR,1);
			obj.setEnddate(cal.getTime());
			obj.setCustid(custid);
			baseDao.insert(PubConstants.WX_COMPANY, obj);
			sub_map.put("state", 0);
		}
		String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);
	}
    public void  auditcancel(){
    	Map<String, Object> sub_map = new HashMap<String, Object>();
    	custid=SpringSecurityUtils.getCurrentUser().getId();
    	String id=Struts2Utils.getParameter("id");
		if(StringUtils.isNotEmpty(id)){
			CompanyInfo obj=(CompanyInfo) UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.WX_COMPANY, Long.parseLong(id)),CompanyInfo.class);
			obj.set_id(Long.parseLong(id));
			obj.setXs(1);
			obj.setCustid(custid);
			baseDao.insert(PubConstants.WX_COMPANY, obj);
			sub_map.put("state", 0);
		}
		String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);
	}
    /**
     * 从百度获取数据
     */
    public void  baidusj(){
    	 String  keyword=Struts2Utils.getParameter("keyword");
    	 String  type=Struts2Utils.getParameter("type"); 
    	 String  region=Struts2Utils.getParameter("region");
    	 String  custid=SpringSecurityUtils.getCurrentUser().getId();
    	 Map<String, Object> sub_map = new HashMap<String, Object>();
    	 HashMap<String, Object> whereMap =new HashMap<String, Object>(); 
    	 int j=1;
 		 int num=0;
 		 int page=0;
 		 while(j>0){
 			JSONArray arraylist = BaiduPlace.getCitylist(keyword,region,page);
			List<Place> list = (List<Place>) JSONArray.toCollection(arraylist,Place.class);
			j=list.size();
			for (int i = 0; i < list.size(); i++) {
				whereMap.clear();
				Place place=list.get(i);
				whereMap.put("custid", custid);
				whereMap.put("name", place.getName());
				DBObject db=baseDao.getMessage(PubConstants.WX_COMPANY, whereMap);
				if(db==null){
					CompanyInfo  com=new CompanyInfo();
					com.set_id(mongoSequence.currval(PubConstants.WX_COMPANY));
					com.setName(place.getName());
					com.setAddress(place.getAddress());
					com.setTel(place.getTelephone());
					com.setType(type);
					com.setCreatedate(new Date());
					com.setStartdate(new Date());
					Calendar cal = Calendar.getInstance();
					cal.add(Calendar.YEAR,5);
					com.setEnddate(cal.getTime());
					com.setCustid(custid);
					com.setXs(0);
					com.setKeyword(place.getName());
					com.setMb(0);
					List<Double> loc =new ArrayList<Double>();
					loc.add(place.getLng());
					loc.add(place.getLat());
					com.setLoc(loc);
					baseDao.insert(PubConstants.WX_COMPANY, com);
					num++;
				}
			 	
			}
			page++;
 		 }
 		sub_map.put("state", 0);
		sub_map.put("value", num);
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);  	 
    }
}
