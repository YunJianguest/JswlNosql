package com.lsp.suc.web;

import java.io.OutputStream;
import java.net.URLEncoder; 
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import net.sf.json.JSONArray; 
 
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;


import com.lsp.pub.dao.BaseDao; 
import com.lsp.pub.db.MongoSequence; 
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.entity.WxToken; 
import com.lsp.pub.util.DateFormat; 
import com.lsp.pub.util.ExportExcel; 
import com.lsp.pub.util.RelativeDate;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.web.GeneralAction; 
import com.lsp.suc.entity.JobCar;
import com.lsp.suc.entity.JobSupplydemand;
import com.lsp.suc.entity.Jobcompay;
import com.lsp.suc.entity.Jobemployment;
import com.lsp.suc.entity.Jobseekers; 
import com.lsp.suc.entity.JobseekersTf;
import com.lsp.website.service.WwzService;  
import com.mongodb.BasicDBObject; 
import com.mongodb.DBObject;
import com.sun.corba.se.spi.orb.StringPair;

/**
 * 招聘求职管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name = JobcompayAction.RELOAD, location = "jobcompay.action",params={"fypage", "%{fypage}"}, type = "redirect") })
public class JobcompayAction extends GeneralAction<Jobcompay> {

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
	private Jobcompay entity=new Jobcompay();
	private Long _id;


	@Override
	public String execute() throws Exception {
		
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		
		
		custid=SpringSecurityUtils.getCurrentUser().getId();
		Struts2Utils.getRequest().setAttribute("custid", custid);
		whereMap.put("custid", custid);
		sortMap.put("createdate", -1);
	 
		fycount=baseDao.getCount(PubConstants.WX_COMPANY, whereMap);
		
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		HashMap<String, Object> backMap =new HashMap<String, Object>();
		backMap.put("content", 0);
		backMap.put("summary", 0); 
		List<DBObject> list=baseDao.getList(PubConstants.SUC_JOBCOMPAY,whereMap,fypage,10, sortMap);
		 for (DBObject dbObject : list) {
			 HashMap<String, Object>wxuerwhereMap=new HashMap<String, Object>();
			 if(dbObject.get("fromUserid")!=null){
				 wxuerwhereMap.put("_id",dbObject.get("fromUserid").toString()); 
			 }else{
				 wxuerwhereMap.put("_id",dbObject.get("fromUserid"));
			 } 
			
			 DBObject  wxuer=wwzService.getWxUser(wxuerwhereMap);
			 dbObject.put("nickname", wxuer.get("nickname"));
			 
			} 
		whereMap.clear();
		whereMap.put("custid",SpringSecurityUtils.getCurrentUser().getId()); 

		Struts2Utils.getRequest().setAttribute("list", list);
		
	
		 
		return SUCCESS;
	}
	

	@Override
	public String delete() throws Exception {
		try {
			custid=SpringSecurityUtils.getCurrentUser().getId(); 
			baseDao.delete(PubConstants.SUC_JOBCOMPAY,_id);
			addActionMessage("成功删除!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,删除过程中出现异常!");
		}
		return RELOAD;
	}
	  
	@Override
	public String input() throws Exception {  
		
		custid=SpringSecurityUtils.getCurrentUser().getId();  
		return "add";
	} 
	@Override
	public String update() throws Exception {	
		
		
		String custid= SpringSecurityUtils.getCurrentUser().getId();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		whereMap.put("custid", custid); 
		Struts2Utils.getRequest().setAttribute("entity", baseDao.getMessage(PubConstants.SUC_JOBCOMPAY, _id)); 
		
		return "add";
	}
	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			//有custId查出来 用户信息
			entity = (Jobcompay)UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.SUC_JOBCOMPAY,_id),Jobcompay.class);
		} else {
			entity = new Jobcompay();
		}
	}
	
	

	@Override
	public String save() throws Exception {
		//注册业务逻辑
		try {
			if(_id == null){
				_id=mongoSequence.currval(PubConstants.SUC_JOBCOMPAY);	
				entity.setCreatedate(new Date()); 
			}		
			entity.set_id(_id);
			custid=SpringSecurityUtils.getCurrentUser().getId();
			entity.setCustid(custid); 
		    baseDao.insert(PubConstants.SUC_JOBCOMPAY,entity);
		     
		   
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return RELOAD;
	}
 
	@Override
	public Jobcompay getModel() {
		return entity;
	}
	public void set_id(Long _id) {
		this._id = _id;
	}  
	public void exp() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		custid=SpringSecurityUtils.getCurrentUser().getId();
		whereMap.put("custid", custid);
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
		
		
		List<DBObject> list=baseDao.getList(PubConstants.SUC_JOBCOMPAY,whereMap, sortMap);
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
		String  url=SysConfig.getProperty("ip")+"/suc/jobcompay!webDetail.action?custid="+custid+"&_id="+id;  
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
	    DBObject  db=baseDao.getMessage(PubConstants.SUC_JOBCOMPAY, Long.parseLong(id)); 
	    readingcom(db);
	    Struts2Utils.getRequest().setAttribute("entity",db); 
	    
	    DBObject  share=new BasicDBObject(); 
	 
		share.put("fxtitle", db.get("title"));
		share.put("fxsummary", db.get("summary")); 
		share.put("fximg", db.get("picurl")); 
		share.put("fxurl",url);
		Struts2Utils.getRequest().setAttribute("share", share); 
		return "detail";
		
	}
	public String  webadd(){
		getLscode(); 
		Struts2Utils.getRequest().setAttribute("custid", custid); 
		String id=Struts2Utils.getParameter("id");
		if(StringUtils.isNotEmpty(id)){
			Struts2Utils.getRequest().setAttribute("entity",baseDao.getMessage(PubConstants.SUC_JOBCOMPAY, Long.parseLong(id))); 
		}else{
			HashMap<String,Object>whereMap=new HashMap<String, Object>(); 
			whereMap.put("fromUserid", fromUserid);
			Long count=baseDao.getCount(PubConstants.SUC_JOBCOMPAY,whereMap); 
			if(count==1){ 
				Struts2Utils.getRequest().setAttribute("entity",baseDao.getMessage(PubConstants.SUC_JOBCOMPAY, whereMap)); 
			}
		} 
		return "webadd";
		
	}
	/**
	 * 手机添加企业信息
	 */
	public void  ajaxwebadd(){

		Map<String, Object> sub_map = new HashMap<String, Object>();
		try {
			getLscode();  
			String  title=Struts2Utils.getParameter("title");
			String  content=Struts2Utils.getParameter("content");
			String  picurl=Struts2Utils.getParameter("picurl");
			String  tel=Struts2Utils.getParameter("tel");
			String  summary=Struts2Utils.getParameter("summary"); 
			String  welfare=Struts2Utils.getParameter("welfare");
			String  address=Struts2Utils.getParameter("address");
			String  linkman=Struts2Utils.getParameter("linkman");
			String  industry=Struts2Utils.getParameter("industry");
			String  nature=Struts2Utils.getParameter("nature");
			HashMap<String,Object>whereMap=new HashMap<String, Object>(); 
			whereMap.put("fromUserid", fromUserid);
			Long count=baseDao.getCount(PubConstants.SUC_JOBCOMPAY,whereMap);
			Jobcompay  obj;
			if(count==0){
				obj=new Jobcompay();
				Long id=mongoSequence.currval(PubConstants.SUC_JOBCOMPAY);  
				obj.set_id(id);
			}else{
				obj=(Jobcompay) UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.SUC_JOBCOMPAY,whereMap), Jobcompay.class);
			}
			obj.setAddress(address);
			obj.setContent(content);  
			obj.setTitle(title);
			obj.setPicurl(picurl);
			obj.setCreatedate(new Date());
			obj.setTel(tel); 
			obj.setCustid(custid);
			obj.setFromUserid(fromUserid);
			obj.setLinkman(linkman);
			obj.setWelfare(welfare);
			obj.setSummary(summary);
			obj.setIndustry(industry);
			obj.setNature(nature);
			baseDao.insert(PubConstants.SUC_JOBCOMPAY, obj);
			sub_map.put("state", 0);
			sub_map.put("value", obj.get_id());
		
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			
			sub_map.put("state", 1);
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	
	 
   public String  employDetail(){
			getLscode(); 
			String id=Struts2Utils.getParameter("_id");
			Struts2Utils.getRequest().setAttribute("custid",custid); 
			WxToken token=GetAllFunc.wxtoken.get(custid);
			if(token.getSqlx()>0){
				 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
			 }
			Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
			token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
			String  url=SysConfig.getProperty("ip")+"/suc/jobemployment!employDetail.action?custid="+custid+"&_id="+id;  
			if(StringUtils.isEmpty(fromUserid)){ 
				String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
				Struts2Utils.getRequest().setAttribute("inspection",inspection);  
				return "refresh";
			}else if(fromUserid.equals("register")){ 
				String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
				Struts2Utils.getRequest().setAttribute("inspection",inspection);  
				return "refresh";
			}  
		    DBObject  db=baseDao.getMessage(PubConstants.SUC_JOBEMPLOYMENT, Long.parseLong(id));
		    readingemp(db);
		    if(db.get("cid")!=null){
		    	DBObject obj=baseDao.getMessage(PubConstants.SUC_JOBCOMPAY, Long.parseLong(db.get("cid").toString()));
		    	db.put("com", obj);
		    }
		    Struts2Utils.getRequest().setAttribute("entity",db); 
		    
		    DBObject  share=new BasicDBObject(); 
		 
			share.put("fxtitle", db.get("title"));
			share.put("fxsummary", db.get("summary")); 
			share.put("fximg",GetAllFunc.wxTouser.get(custid).getLogo()); 
			share.put("fxurl",url);
			Struts2Utils.getRequest().setAttribute("share", share); 
			return "employdetail";
			
		}
	public String  employadd(){
			getLscode(); 
			Struts2Utils.getRequest().setAttribute("custid", custid); 
			String id=Struts2Utils.getParameter("id");
			if(StringUtils.isNotEmpty(id)){
				Struts2Utils.getRequest().setAttribute("entity",baseDao.getMessage(PubConstants.SUC_JOBEMPLOYMENT, Long.parseLong(id))); 
			}
			return "employadd";
			
		}
	/**
	  * 手机添加招聘信息
	  */
	public void  ajaxemployadd(){

			Map<String, Object> sub_map = new HashMap<String, Object>();
			try {
				getLscode(); 
				String  id=Struts2Utils.getParameter("id");
				String  title=Struts2Utils.getParameter("title"); 
				String  tel=Struts2Utils.getParameter("tel");
				String  summary=Struts2Utils.getParameter("summary");  
				String  workaddress=Struts2Utils.getParameter("workaddress");
				String  linkman=Struts2Utils.getParameter("linkman");
				String  pcount=Struts2Utils.getParameter("pcount");
				String  record=Struts2Utils.getParameter("record");
				String  salary=Struts2Utils.getParameter("salary");
				String  type=Struts2Utils.getParameter("type");
				String  experience=Struts2Utils.getParameter("experience");
				if(StringUtils.isNotEmpty(id)){
					DBObject  db=baseDao.getMessage(PubConstants.SUC_JOBCOMPAY, Long.parseLong(id));
					Jobemployment  obj=new Jobemployment();
					obj.set_id(mongoSequence.currval(PubConstants.SUC_JOBEMPLOYMENT));
					obj.setWorkaddress(workaddress);
					obj.setCid(Long.parseLong(id));
					obj.setCustid(custid);
					obj.setLinkman(linkman); 
					obj.setPcount(Integer.parseInt(pcount));
					obj.setRecord(record);
					obj.setSalary(Integer.parseInt(salary));
					obj.setSummary(summary);
					obj.setTel(tel);
					obj.setTitle(title);
					obj.setType(type);
					obj.setCreatedate(new Date());
					obj.setExperience(experience);
					obj.setFromUserid(fromUserid);
					if(db.get("welfare")!=null){
						obj.setWelfare(db.get("welfare").toString());
					} 
					if(db.get("industry")!=null){
						obj.setIndustry(db.get("industry").toString());
					}
					if(db.get("nature")!=null){
						obj.setIndustry(db.get("nature").toString());
					}
					baseDao.insert(PubConstants.SUC_JOBEMPLOYMENT, obj);
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
	
	public String  seekersDetail(){
		getLscode(); 
		String id=Struts2Utils.getParameter("_id");
		Struts2Utils.getRequest().setAttribute("custid",custid); 
		WxToken token=GetAllFunc.wxtoken.get(custid);
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 }
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/jobseekers!webDetail.action?custid="+custid+"&_id="+id;  
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
	    DBObject  db=baseDao.getMessage(PubConstants.SUC_JOBSEEKERS, Long.parseLong(id)); 
	    readingseek(db);
	    Struts2Utils.getRequest().setAttribute("entity",db); 
	    
	    DBObject  share=new BasicDBObject(); 
	 
		share.put("fxtitle", db.get("title"));
		share.put("fxsummary", db.get("summary")); 
		share.put("fximg", db.get("picurl")); 
		share.put("fxurl",url);
		Struts2Utils.getRequest().setAttribute("share", share); 
		return "seekersdetail";
		
	}
	public String  seekersadd(){
		getLscode(); 
		Struts2Utils.getRequest().setAttribute("custid", custid); 
		String id=Struts2Utils.getParameter("id");
		if(StringUtils.isNotEmpty(id)){
			Struts2Utils.getRequest().setAttribute("entity",baseDao.getMessage(PubConstants.SUC_JOBSEEKERS, Long.parseLong(id))); 
		}
		return "seekersadd";
		
	}
	/**
	 * 手机添加求职信息
	 */
	public void  ajaxseekersadd(){

		Map<String, Object> sub_map = new HashMap<String, Object>();
		try {
			getLscode();  
			String  name=Struts2Utils.getParameter("name"); 
			String  title=Struts2Utils.getParameter("title"); 
			String  tel=Struts2Utils.getParameter("tel");
			String  picurl=Struts2Utils.getParameter("picurl");
			String  content=Struts2Utils.getParameter("content");
			String  summary=Struts2Utils.getParameter("summary");  
			String  workaddress=Struts2Utils.getParameter("workaddress"); ;
			String  salary=Struts2Utils.getParameter("salary"); 
			String  record=Struts2Utils.getParameter("record"); 
			String  experience=Struts2Utils.getParameter("experience");
			String  age=Struts2Utils.getParameter("age");
			String  sex=Struts2Utils.getParameter("sex");
			String  type=Struts2Utils.getParameter("type");
			Jobseekers  obj=new Jobseekers();
			obj.set_id(mongoSequence.currval(PubConstants.SUC_JOBSEEKERS));
			obj.setWorkaddress(workaddress);
			obj.setContent(content);
			obj.setCreatedate(new Date());
			obj.setCustid(custid);
			obj.setFromUserid(fromUserid);
			obj.setName(name);
			obj.setPicurl(picurl);
			obj.setSalary(Integer.parseInt(salary));
			obj.setSummary(summary);
			obj.setRecord(record);
			obj.setExperience(experience);
			obj.setTel(tel);
			obj.setTitle(title);
			obj.setAge(Integer.parseInt(age));
			obj.setSex(sex);
			obj.setType(type);
		    baseDao.insert(PubConstants.SUC_JOBSEEKERS, obj);
			sub_map.put("state", 0);
		 
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			
			sub_map.put("state", 1);
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	
	public String  supplyDetail(){
		getLscode(); 
		String id=Struts2Utils.getParameter("_id");
		Struts2Utils.getRequest().setAttribute("custid",custid); 
		WxToken token=GetAllFunc.wxtoken.get(custid);
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 }
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/jobseekers!webDetail.action?custid="+custid+"&_id="+id;  
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
	    DBObject  db=baseDao.getMessage(PubConstants.SUC_JOBSUPPLYDEMAND, Long.parseLong(id)); 
	    readingsupp(db);
	    Struts2Utils.getRequest().setAttribute("entity",db); 
	    
	    DBObject  share=new BasicDBObject(); 
	 
		share.put("fxtitle", db.get("title"));
		share.put("fxsummary", db.get("summary")); 
		share.put("fximg", db.get("picurl")); 
		share.put("fxurl",url);
		Struts2Utils.getRequest().setAttribute("share", share); 
		return "supplydetail";
		
	}
	public String  carDetail(){
		getLscode(); 
		String id=Struts2Utils.getParameter("_id");
		Struts2Utils.getRequest().setAttribute("custid",custid); 
		WxToken token=GetAllFunc.wxtoken.get(custid);
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 }
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/jobseekers!carDetail.action?custid="+custid+"&_id="+id;  
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
	    DBObject  db=baseDao.getMessage(PubConstants.SUC_JOBCAR, Long.parseLong(id)); 
	    readingcar(db);
	    Struts2Utils.getRequest().setAttribute("entity",db); 
	    
	    DBObject  share=new BasicDBObject(); 
	 
		share.put("fxtitle", db.get("title"));
		share.put("fxsummary", db.get("summary")); 
		share.put("fximg", db.get("picurl")); 
		share.put("fxurl",url);
		Struts2Utils.getRequest().setAttribute("share", share); 
		return "cardetail";
		
	}
	public String  supplyadd(){
		getLscode(); 
		Struts2Utils.getRequest().setAttribute("custid", custid); 
		String id=Struts2Utils.getParameter("id");
		Struts2Utils.getRequest().setAttribute("type", Struts2Utils.getParameter("type"));
		if(StringUtils.isNotEmpty(id)){
			Struts2Utils.getRequest().setAttribute("entity",baseDao.getMessage(PubConstants.SUC_JOBSUPPLYDEMAND, Long.parseLong(id))); 
		}
		return "supplyadd";
		
	}
	public String  caradd(){
		getLscode(); 
		Struts2Utils.getRequest().setAttribute("custid", custid); 
		String id=Struts2Utils.getParameter("id");
		Struts2Utils.getRequest().setAttribute("type", Struts2Utils.getParameter("type"));
		if(StringUtils.isNotEmpty(id)){
			Struts2Utils.getRequest().setAttribute("entity",baseDao.getMessage(PubConstants.SUC_JOBCAR, Long.parseLong(id))); 
		}
		return "caradd";
		
	}
	/**
	 * 手机添加租赁信息
	 */
	public void  ajaxsupplyadd(){

		Map<String, Object> sub_map = new HashMap<String, Object>();
		try {
			getLscode();  
			String  name=Struts2Utils.getParameter("name"); 
			String  title=Struts2Utils.getParameter("title"); 
			String  tel=Struts2Utils.getParameter("tel");
			String  picurl=Struts2Utils.getParameter("picurl");
			String  content=Struts2Utils.getParameter("content");
			String  summary=Struts2Utils.getParameter("summary");  
			String  lx=Struts2Utils.getParameter("lx");  
			String  type=Struts2Utils.getParameter("type"); 
			String  price=Struts2Utils.getParameter("price");
			String  decorate=Struts2Utils.getParameter("decorate");
			String  big=Struts2Utils.getParameter("big");
			String  standard=Struts2Utils.getParameter("standard");
			String  address=Struts2Utils.getParameter("address");
			String  risingsun=Struts2Utils.getParameter("risingsun");
			String  age=Struts2Utils.getParameter("age");
			String  floor=Struts2Utils.getParameter("floor");
			String  equity=Struts2Utils.getParameter("equity");
			String  issecond=Struts2Utils.getParameter("issecond");
			JobSupplydemand  obj=new JobSupplydemand();
			obj.set_id(mongoSequence.currval(PubConstants.SUC_JOBSEEKERS)); 
			obj.setContent(content);
			obj.setCreatedate(new Date());
			obj.setCustid(custid);
			obj.setFromUserid(fromUserid);
			obj.setName(name);
			obj.setPicurl(picurl); 
			obj.setSummary(summary);
			obj.setTel(tel);
			obj.setTitle(title);
			obj.setPrice(Integer.parseInt(price));
			if(StringUtils.isNotEmpty(lx)){
				obj.setLx(Integer.parseInt(lx));	
			}
			obj.setDecorate(decorate);
			obj.setEquity(equity);
			obj.setFloor(floor);
			obj.setRisingsun(risingsun);
			obj.setStandard(standard); 
			obj.setBig(big);
			obj.setAddress(address);
			obj.setAge(age);
			obj.setType(type);
			obj.setIssecond(issecond);
		    baseDao.insert(PubConstants.SUC_JOBSUPPLYDEMAND, obj);
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
	 * 二手车添加
	 */
	public  void     ajaxcaradd(){
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		String title=Struts2Utils.getParameter("title");
		String name=Struts2Utils.getParameter("name");
		String content=Struts2Utils.getParameter("content");
		String picurl=Struts2Utils.getParameter("picurl");
		String tel=Struts2Utils.getParameter("tel");
		String summary=Struts2Utils.getParameter("summary");
		String address=Struts2Utils.getParameter("address");
		String lx=Struts2Utils.getParameter("lx");
		String price=Struts2Utils.getParameter("price");
		String type=Struts2Utils.getParameter("type");
		String brand=Struts2Utils.getParameter("brand");
		String series=Struts2Utils.getParameter("series");
		String age=Struts2Utils.getParameter("age");
		String gearbox=Struts2Utils.getParameter("gearbox");
		String displacement=Struts2Utils.getParameter("displacement"); 
		JobCar car=new JobCar();
		car.set_id(mongoSequence.currval(PubConstants.SUC_JOBCAR));
		car.setCustid(custid);
		car.setFromUserid(fromUserid);
		car.setCreatedate(new Date());
		car.setAddress(address);
		car.setAge(age);
		car.setBrand(brand);
		car.setContent(content);
		car.setDisplacement(displacement);
		car.setGearbox(gearbox);
		car.setLx(Integer.parseInt(lx));
		car.setName(name);
		car.setPicurl(picurl);
		car.setPrice(Integer.parseInt(price));
		car.setSeries(series);
		car.setType(type);
		car.setTitle(title);
		car.setSummary(summary);
		car.setTel(tel);
		baseDao.insert(PubConstants.SUC_JOBCAR, car);
		sub_map.put("state",0);
		String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	public  String   index(){
		getLscode();
		wwzService.flow(custid,"jobcompay");
		Struts2Utils.getRequest().setAttribute("custid",custid); 
		WxToken token=GetAllFunc.wxtoken.get(custid);
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 }
        String  type=Struts2Utils.getParameter("type");
		Struts2Utils.getRequest().setAttribute("type",type);
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/jobcompay!index.action?custid="+custid+"&type="+type; 
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		} 
		Struts2Utils.getRequest().setAttribute("count",wwzService.getFlow(custid, "jobcompay"));
		Struts2Utils.getRequest().setAttribute("isadmin",Struts2Utils.getParameter("isadmin"));
		
		return "index";
	}
	/**
	 * 招聘信息列表
	 * @return
	 */
	public  String   commentindex(){
		getLscode();
		wwzService.flow(custid,"jobcompay-commentindex");
		Struts2Utils.getRequest().setAttribute("custid",custid); 
		WxToken token=GetAllFunc.wxtoken.get(custid);
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 } 
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/jobcompay!commentindex.action?custid="+custid; 
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		} 
		Struts2Utils.getRequest().setAttribute("count",wwzService.getFlow(custid, "jobcompay-commentindex"));
		Struts2Utils.getRequest().setAttribute("isadmin",Struts2Utils.getParameter("isadmin"));
		
		return "commentindex";
	}
	/**
	 * 求职信息列表
	 * @return
	 */
	public  String   seekindex(){
		getLscode();
		wwzService.flow(custid,"jobcompay-seekindex");
		Struts2Utils.getRequest().setAttribute("custid",custid); 
		WxToken token=GetAllFunc.wxtoken.get(custid);
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 } 
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/jobcompay!seekindex.action?custid="+custid; 
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		} 
		Struts2Utils.getRequest().setAttribute("count",wwzService.getFlow(custid, "jobcompay-seekindex"));
		Struts2Utils.getRequest().setAttribute("isadmin",Struts2Utils.getParameter("isadmin"));
		
		return "seekindex";
	}
	/**
	 * 房屋租赁列表
	 * @return
	 */
	public  String   suppindex(){
		getLscode();
		wwzService.flow(custid,"jobcompay-suppindex");
		Struts2Utils.getRequest().setAttribute("custid",custid); 
		WxToken token=GetAllFunc.wxtoken.get(custid);
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 } 
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/jobcompay!suppindex.action?custid="+custid; 
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		} 
		Struts2Utils.getRequest().setAttribute("count",wwzService.getFlow(custid, "jobcompay-suppindex"));
		Struts2Utils.getRequest().setAttribute("isadmin",Struts2Utils.getParameter("isadmin"));
		
		return "suppindex";
	}
	/**
	 * 二手车列表
	 * @return
	 */
	public  String   carindex(){
		getLscode();
		wwzService.flow(custid,"jobcompay-carindex");
		Struts2Utils.getRequest().setAttribute("custid",custid); 
		WxToken token=GetAllFunc.wxtoken.get(custid);
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 } 
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/jobcompay!carindex.action?custid="+custid; 
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		} 
		Struts2Utils.getRequest().setAttribute("count",wwzService.getFlow(custid, "jobcompay-carindex"));
		Struts2Utils.getRequest().setAttribute("isadmin",Struts2Utils.getParameter("isadmin"));
		
		return "carindex";
	}
	/**
	 * 首页
	 * @return
	 */
	public String   web(){
		getLscode();
		wwzService.flow(custid,"jobcompay");
		Struts2Utils.getRequest().setAttribute("custid",custid); 
		WxToken token=GetAllFunc.wxtoken.get(custid);
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 }
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/jobcompay!web.action?custid="+custid; 
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		} 
		Struts2Utils.getRequest().setAttribute("count",wwzService.getFlow(custid, "jobcompay"));
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
    	HashMap<String, Object>sortMap=new HashMap<String, Object>();
    	whereMap.put("custid",custid);
    	sortMap.put("sort",-1);
    	List<DBObject>list=baseDao.getList(PubConstants.SUC_JOBTYPE, whereMap, sortMap);
    	Struts2Utils.getRequest().setAttribute("typelist",list);
    	Struts2Utils.getRequest().setAttribute("slide",wwzService.slide(custid, "jobcompany"));
	 
		return "web";
	}
	/**
	 * ajax获取招聘信息
	 */
	public  void  ajaxemployweb(){
		Map<String, Object> sub_map = new HashMap<String, Object>();
		try {
			getLscode();
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			String  obj=Struts2Utils.getParameter("obj");
			String  welfare=Struts2Utils.getParameter("welfare"); 
			String  industry=Struts2Utils.getParameter("industry");
			String  nature=Struts2Utils.getParameter("nature");
			String  record=Struts2Utils.getParameter("record");
			String  experience=Struts2Utils.getParameter("experience");
			String  ssalary=Struts2Utils.getParameter("ssalary");
			String  bsalary=Struts2Utils.getParameter("bsalary"); 
			BasicDBObject dateCondition = new BasicDBObject();
			if(StringUtils.isNotEmpty(bsalary)&&StringUtils.isNotEmpty(ssalary)){
				dateCondition.append("$gte",Integer.parseInt(ssalary));
				dateCondition.append("$lte",Integer.parseInt(bsalary)); 
				whereMap.put("salary", dateCondition);
			}
			if(StringUtils.isNotEmpty(bsalary)&&StringUtils.isEmpty(ssalary)){ 
				dateCondition.append("$gte",Integer.parseInt(bsalary)); 
				whereMap.put("salary", dateCondition);
			}
			if(StringUtils.isEmpty(bsalary)&&StringUtils.isNotEmpty(ssalary)){
				dateCondition.append("$lte",Integer.parseInt(ssalary));  
				whereMap.put("salary", dateCondition);
			}
			if(StringUtils.isNotEmpty(obj)){
				Pattern pattern = Pattern.compile("^.*" + obj + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("title", pattern);
			}
			if(StringUtils.isNotEmpty(welfare)){
				Pattern pattern = Pattern.compile("^.*" + welfare + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("welfare", pattern);
			}
			if(StringUtils.isNotEmpty(industry)){
				Pattern pattern = Pattern.compile("^.*" + industry + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("industry", pattern);
			}
			if(StringUtils.isNotEmpty(nature)){
				Pattern pattern = Pattern.compile("^.*" + nature + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("nature", pattern);
			}
			if(StringUtils.isNotEmpty(record)){
				Pattern pattern = Pattern.compile("^.*" + record + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("record", pattern);
			}
			if(StringUtils.isNotEmpty(experience)){
				Pattern pattern = Pattern.compile("^.*" + experience + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("experience", pattern);
			}
			whereMap.put("custid", custid);
			String isadmin=Struts2Utils.getParameter("isadmin");
			if(StringUtils.isNotEmpty(isadmin)){
				whereMap.put("fromUserid", fromUserid);
			}
			sortMap.put("createdate",-1);
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			List<DBObject>list=baseDao.getList(PubConstants.SUC_JOBEMPLOYMENT, whereMap,fypage,10, sortMap);
			if(list.size()>0){
				sub_map.put("state","0");
				for (DBObject dbObject : list) {
	    			if(dbObject.get("createdate")!=null){
	    				dbObject.put("createdate", RelativeDate.format(DateFormat.getFormat(dbObject.get("createdate").toString()), new Date()));
	    			}
				}
				sub_map.put("list", list); 
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * ajax获取求职信息
	 */
	public  void  ajaxseekersweb(){
		Map<String, Object> sub_map = new HashMap<String, Object>();
		try {
			getLscode();
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			String  obj=Struts2Utils.getParameter("obj");
			String  sex=Struts2Utils.getParameter("sex");
			String  experience=Struts2Utils.getParameter("oexperiencebj");
			String  type=Struts2Utils.getParameter("type");
			String  record=Struts2Utils.getParameter("record");
			String  ssalary=Struts2Utils.getParameter("ssalary");
			String  bsalary=Struts2Utils.getParameter("bsalary"); 
			BasicDBObject dateCondition = new BasicDBObject();
			if(StringUtils.isNotEmpty(bsalary)&&StringUtils.isNotEmpty(ssalary)){
				dateCondition.append("$gte",Integer.parseInt(ssalary));
				dateCondition.append("$lte",Integer.parseInt(bsalary)); 
				whereMap.put("salary", dateCondition);
			}
			if(StringUtils.isNotEmpty(bsalary)&&StringUtils.isEmpty(ssalary)){ 
				dateCondition.append("$gte",Integer.parseInt(bsalary)); 
				whereMap.put("salary", dateCondition);
			}
			if(StringUtils.isEmpty(bsalary)&&StringUtils.isNotEmpty(ssalary)){
				dateCondition.append("$lte",Integer.parseInt(ssalary));  
				whereMap.put("salary", dateCondition);
			}
			
			String  sage=Struts2Utils.getParameter("sage");
			String  bage=Struts2Utils.getParameter("bage"); 
			BasicDBObject dateCondition1 = new BasicDBObject();
			if(StringUtils.isNotEmpty(bage)&&StringUtils.isNotEmpty(sage)){
				dateCondition.append("$gte",Integer.parseInt(sage));
				dateCondition.append("$lte",Integer.parseInt(bage)); 
				whereMap.put("age", dateCondition1);
			}
			if(StringUtils.isNotEmpty(bage)&&StringUtils.isEmpty(sage)){ 
				dateCondition.append("$gte",Integer.parseInt(bage)); 
				whereMap.put("age", dateCondition1);
			}
			if(StringUtils.isEmpty(bage)&&StringUtils.isNotEmpty(sage)){
				dateCondition.append("$lte",Integer.parseInt(sage));  
				whereMap.put("age", dateCondition1);
			}
			if(StringUtils.isNotEmpty(obj)){
				Pattern pattern = Pattern.compile("^.*" + obj + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("title", pattern);
			}
			if(StringUtils.isNotEmpty(type)){
				Pattern pattern = Pattern.compile("^.*" + type + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("type", pattern);
			}
			if(StringUtils.isNotEmpty(sex)){ 
				whereMap.put("sex", sex);
			}
			if(StringUtils.isNotEmpty(experience)){
				Pattern pattern = Pattern.compile("^.*" + experience + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("experience", pattern);
			}
			if(StringUtils.isNotEmpty(record)){
				Pattern pattern = Pattern.compile("^.*" + record + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("record", pattern);
			}
			whereMap.put("custid", custid);
			String isadmin=Struts2Utils.getParameter("isadmin");
			if(StringUtils.isNotEmpty(isadmin)){
				whereMap.put("fromUserid", fromUserid);
			}
			sortMap.put("createdate",-1);
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			List<DBObject>list=baseDao.getList(PubConstants.SUC_JOBSEEKERS, whereMap,fypage,10, sortMap);
			if(list.size()>0){
				sub_map.put("state","0");
				for (DBObject dbObject : list) {
	    			if(dbObject.get("createdate")!=null){
	    				dbObject.put("createdate", RelativeDate.format(DateFormat.getFormat(dbObject.get("createdate").toString()), new Date()));
	    			}
				}
				sub_map.put("list", list); 
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * ajax获取租赁信息
	 */
	public  void  ajaxsupplyweb(){
		Map<String, Object> sub_map = new HashMap<String, Object>();
		try {
			getLscode();
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			String  obj=Struts2Utils.getParameter("obj");
			String  floor=Struts2Utils.getParameter("floor");
			String  age=Struts2Utils.getParameter("age");
			String  risingsun=Struts2Utils.getParameter("risingsun");
			String  type=Struts2Utils.getParameter("type");
			String  decorate=Struts2Utils.getParameter("decorate");
			String  standard=Struts2Utils.getParameter("standard");
			String  big=Struts2Utils.getParameter("big");
			String  sprice=Struts2Utils.getParameter("sprice");
			String  bprice=Struts2Utils.getParameter("bprice"); 
			BasicDBObject dateCondition = new BasicDBObject();
			if(StringUtils.isNotEmpty(bprice)&&StringUtils.isNotEmpty(sprice)){
				dateCondition.append("$gte",Integer.parseInt(sprice));
				dateCondition.append("$lte",Integer.parseInt(bprice)); 
				whereMap.put("price", dateCondition);
			}
			if(StringUtils.isNotEmpty(bprice)&&StringUtils.isEmpty(sprice)){ 
				dateCondition.append("$gte",Integer.parseInt(bprice)); 
				whereMap.put("price", dateCondition);
			}
			if(StringUtils.isEmpty(bprice)&&StringUtils.isNotEmpty(sprice)){
				dateCondition.append("$lte",Integer.parseInt(sprice));  
				whereMap.put("price", dateCondition);
			}
			if(StringUtils.isNotEmpty(obj)){
				Pattern pattern = Pattern.compile("^.*" + obj + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("title", pattern);
			}
			whereMap.put("custid", custid);
			String isadmin=Struts2Utils.getParameter("isadmin");
			if(StringUtils.isNotEmpty(isadmin)){
				whereMap.put("fromUserid", fromUserid);
			}
			if(StringUtils.isNotEmpty(type)){
				Pattern pattern = Pattern.compile("^.*" + type + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("type", pattern); 
			}
			if(StringUtils.isNotEmpty(floor)){
				Pattern pattern = Pattern.compile("^.*" + floor + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("floor", pattern); 
			}
			if(StringUtils.isNotEmpty(age)){
				Pattern pattern = Pattern.compile("^.*" + age + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("age", pattern); 
			}
			if(StringUtils.isNotEmpty(risingsun)){
				Pattern pattern = Pattern.compile("^.*" + risingsun + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("risingsun", pattern); 
			}
			if(StringUtils.isNotEmpty(decorate)){
				Pattern pattern = Pattern.compile("^.*" + decorate + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("decorate", pattern); 
			}
			if(StringUtils.isNotEmpty(standard)){
				Pattern pattern = Pattern.compile("^.*" + standard + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("standard", pattern); 
			} 
			if(StringUtils.isNotEmpty(big)){
				Pattern pattern = Pattern.compile("^.*" + big + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("big", pattern); 
			} 
			sortMap.put("createdate",-1);
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			List<DBObject>list=baseDao.getList(PubConstants.SUC_JOBSUPPLYDEMAND, whereMap,fypage,10, sortMap);
			if(list.size()>0){
				sub_map.put("state","0");
				for (DBObject dbObject : list) {
	    			if(dbObject.get("createdate")!=null){
	    				dbObject.put("createdate", RelativeDate.format(DateFormat.getFormat(dbObject.get("createdate").toString()), new Date()));
	    			}
				}
				sub_map.put("list", list); 
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * ajax获取租赁信息
	 */
	public  void  ajaxcarweb(){
		Map<String, Object> sub_map = new HashMap<String, Object>();
		try {
			getLscode();
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			String  obj=Struts2Utils.getParameter("obj");
			String  brand=Struts2Utils.getParameter("brand");
			String  series=Struts2Utils.getParameter("series");
			String  age=Struts2Utils.getParameter("age");
			String  gearbox=Struts2Utils.getParameter("gearbox");
			String  displacement=Struts2Utils.getParameter("displacement");
			String  sprice=Struts2Utils.getParameter("sprice");
			String  bprice=Struts2Utils.getParameter("bprice"); 
			BasicDBObject dateCondition = new BasicDBObject();
			if(StringUtils.isNotEmpty(bprice)&&StringUtils.isNotEmpty(sprice)){
				dateCondition.append("$gte",Integer.parseInt(sprice));
				dateCondition.append("$lte",Integer.parseInt(bprice)); 
				whereMap.put("price", dateCondition); 
			}
			if(StringUtils.isNotEmpty(bprice)&&StringUtils.isEmpty(sprice)){ 
				dateCondition.append("$gte",Integer.parseInt(bprice));  
				whereMap.put("price", dateCondition);
			}
			if(StringUtils.isEmpty(bprice)&&StringUtils.isNotEmpty(sprice)){
				dateCondition.append("$lte",Integer.parseInt(sprice));  
				whereMap.put("price", dateCondition); 
			}
			if(StringUtils.isNotEmpty(obj)){
				Pattern pattern = Pattern.compile("^.*" + obj + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("title", pattern); 
			}
			whereMap.put("custid", custid);
			String isadmin=Struts2Utils.getParameter("isadmin");
			if(StringUtils.isNotEmpty(isadmin)){
				whereMap.put("fromUserid", fromUserid);
			}
			if(StringUtils.isNotEmpty(brand)){
				Pattern pattern = Pattern.compile("^.*" + brand + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("brand", pattern);  
			}
			if(StringUtils.isNotEmpty(series)){
				Pattern pattern = Pattern.compile("^.*" + series + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("series", pattern);  
			} 
			if(StringUtils.isNotEmpty(age)){
				Pattern pattern = Pattern.compile("^.*" + age + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("age", pattern);  
			} 
			if(StringUtils.isNotEmpty(gearbox)){
				Pattern pattern = Pattern.compile("^.*" + gearbox + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("gearbox", pattern);  
			}
			if(StringUtils.isNotEmpty(displacement)){
				Pattern pattern = Pattern.compile("^.*" + displacement + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("displacement", pattern);  
			} 
			sortMap.put("createdate",-1);
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			List<DBObject>list=baseDao.getList(PubConstants.SUC_JOBCAR, whereMap,fypage,10, sortMap);
			if(list.size()>0){
				sub_map.put("state","0");
				for (DBObject dbObject : list) {
	    			if(dbObject.get("createdate")!=null){
	    				dbObject.put("createdate", RelativeDate.format(DateFormat.getFormat(dbObject.get("createdate").toString()), new Date()));
	    			}
				}
				sub_map.put("list", list); 
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	public  void  readingcom(DBObject db){
		Jobcompay  obj=(Jobcompay) UniObject.DBObjectToObject(db, Jobcompay.class);
		if(obj.getSort()==0){
			obj.setSort(1);
		}else{
			obj.setSort(obj.getSort()+1);
		}
		baseDao.insert(PubConstants.SUC_JOBCOMPAY, obj);
	}
    public  void  readingemp(DBObject db){
    	Jobemployment  obj=(Jobemployment) UniObject.DBObjectToObject(db, Jobemployment.class);
		if(obj.getSort()==0){
			obj.setSort(1);
		}else{
			obj.setSort(obj.getSort()+1);
		}
		baseDao.insert(PubConstants.SUC_JOBEMPLOYMENT, obj);
		
	}
    public  void  readingseek(DBObject db){
    	Jobseekers  obj=(Jobseekers) UniObject.DBObjectToObject(db, Jobseekers.class);
		if(obj.getSort()==0){
			obj.setSort(1);
		}else{
			obj.setSort(obj.getSort()+1);
		}
		baseDao.insert(PubConstants.SUC_JOBSEEKERS, obj);
	
    }
    public  void  readingsupp(DBObject db){
    	JobSupplydemand  obj=(JobSupplydemand) UniObject.DBObjectToObject(db, JobSupplydemand.class);
		if(obj.getSort()==0){
			obj.setSort(1);
		}else{
			obj.setSort(obj.getSort()+1);
		}
		baseDao.insert(PubConstants.SUC_JOBSUPPLYDEMAND, obj);
		
	}
    public  void  readingcar(DBObject db){
    	JobCar  obj=(JobCar) UniObject.DBObjectToObject(db, JobCar.class);
		if(obj.getSort()==0){
			obj.setSort(1);
		}else{
			obj.setSort(obj.getSort()+1);
		}
		baseDao.insert(PubConstants.SUC_JOBCAR, obj);
		
	}
    /**
     * 简历投放
     */
    public  void  putin(){
    	getLscode();
    	Map<String, Object> sub_map = new HashMap<String, Object>();
    	String   lscomid=Struts2Utils.getParameter("lscomid");
    	String   seeid="";
    	HashMap<String, Object>whereMap=new HashMap<String, Object>();
    	HashMap<String, Object>sortMap=new HashMap<String, Object>();
    	sortMap.put("createdate", -1);
    	whereMap.put("fromUserid", fromUserid);
    	List<DBObject>list=baseDao.getList(PubConstants.SUC_JOBSEEKERS, whereMap,0,1,sortMap);
    	if(list.size()>0){
    		seeid=list.get(0).get("_id").toString();
    	}else{
    		sub_map.put("state", 2);
    		String json = JSONArray.fromObject(sub_map).toString(); 
    		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    		return;
    	}  
    	if(StringUtils.isNotEmpty(lscomid)&&StringUtils.isNotEmpty(seeid)){
    		String[]comid=lscomid.split(",");
    		for (String cid : comid) {
				if(StringUtils.isNotEmpty(cid)){
					JobseekersTf jtf=new JobseekersTf();
					jtf.set_id(mongoSequence.currval(PubConstants.SUC_JOBSEEKERTF));
					jtf.setComid(Long.parseLong(cid));
					jtf.setCustid(custid);
					jtf.setFromUserid(fromUserid);
					jtf.setSeeid(Long.parseLong(seeid));
					jtf.setState(1);
					jtf.setCreatedate(new Date());
					baseDao.insert(PubConstants.SUC_JOBSEEKERTF, jtf);
					sub_map.put("state", 0);
				}
			}
    	}
    	String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    }
    /**
     * 简历审核
     */
    public  void  jobTfset(){
    	getLscode();
    	Map<String, Object> sub_map = new HashMap<String, Object>();
    	String  id=Struts2Utils.getParameter("id");
    	String  state=Struts2Utils.getParameter("state");
    	if(StringUtils.isNotEmpty(id)&&StringUtils.isNotEmpty(state)){
    		DBObject  db=baseDao.getMessage(PubConstants.SUC_JOBSEEKERTF, Long.parseLong(id));
    		if(db!=null){
    			if(Integer.parseInt(state)==4){
    				baseDao.delete(PubConstants.SUC_JOBSEEKERTF,Long.parseLong(id));
    			}else{
    				JobseekersTf  obj=(JobseekersTf) UniObject.DBObjectToObject(db, JobseekersTf.class);
    				obj.setState(Integer.parseInt(state));
    				obj.setSetdate(new Date());
    				baseDao.insert(PubConstants.SUC_JOBSEEKERTF, obj);
    			}
    			sub_map.put("state", 0);
    		}
    	}
    	String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    }
    /**
     * 简历投放列表
     */
    public  void  ajaxtfweb(){
    	getLscode();
    	Map<String, Object> sub_map = new HashMap<String, Object>();
    	String  comid=Struts2Utils.getParameter("comid");
    	if(StringUtils.isNotEmpty(comid)){
    		HashMap<String, Object>whereMap=new HashMap<String, Object>();
    		HashMap<String, Object>sortMap=new HashMap<String, Object>();
    		sortMap.put("createdate", -1);
    		whereMap.put("comid", Long.parseLong(comid));
    		whereMap.put("custid", custid);
    		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
    			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
    		}
    		List<DBObject>list=baseDao.getList(PubConstants.SUC_JOBSEEKERTF, whereMap,fypage,10, sortMap);
    		if(list.size()>0){
    			sub_map.put("state", 0);
    			sub_map.put("list",list);
    		}
    	}
    	String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    }
    /**
     * 加载最热数据
     */
    public  void  ajaxzr(){
    	getLscode();
    	Map<String, Object> sub_map = new HashMap<String, Object>();
    	HashMap<String, Object>whereMap=new HashMap<String, Object>();
    	HashMap<String, Object>sortMap=new HashMap<String, Object>();
    	whereMap.put("custid",custid);
    	sortMap.put("sort", -1);
    	List<DBObject>clist=baseDao.getList(PubConstants.SUC_JOBEMPLOYMENT, whereMap,0,2,sortMap);
    	List<DBObject>slist=baseDao.getList(PubConstants.SUC_JOBSEEKERS, whereMap,0,2,sortMap);
    	List<DBObject>plist=baseDao.getList(PubConstants.SUC_JOBSUPPLYDEMAND, whereMap,0,2,sortMap);
    	List<DBObject>carlist=baseDao.getList(PubConstants.SUC_JOBCAR, whereMap,0,2,sortMap);
    	if(clist.size()>0){
    		sub_map.put("state", 0);
    		for (DBObject dbObject : clist) {
    			if(dbObject.get("createdate")!=null){
    				dbObject.put("createdate", RelativeDate.format(DateFormat.getFormat(dbObject.get("createdate").toString()), new Date()));
    			}
    			if(dbObject.get("tel")==null){
    				dbObject.put("tel", baseDao.getMessage(PubConstants.SUC_JOBCOMPAY, Long.parseLong(dbObject.get("cid").toString())).get("tel"));
    			}
			}
    		sub_map.put("clist", clist);
    	}
    	if(slist.size()>0){
    		sub_map.put("state", 0);
    		for (DBObject dbObject : slist) {
    			if(dbObject.get("createdate")!=null){
    				dbObject.put("createdate", RelativeDate.format(DateFormat.getFormat(dbObject.get("createdate").toString()), new Date()));
    			}
			}
    		sub_map.put("slist", slist);
    	}
    	if(plist.size()>0){
    		sub_map.put("state", 0);
    		for (DBObject dbObject : plist) {
    			if(dbObject.get("createdate")!=null){
    				dbObject.put("createdate", RelativeDate.format(DateFormat.getFormat(dbObject.get("createdate").toString()), new Date()));
    			}
			}
    		sub_map.put("plist", plist);
    	}
    	if(carlist.size()>0){
    		sub_map.put("state", 0);
    		for (DBObject dbObject : carlist) {
    			if(dbObject.get("createdate")!=null){
    				dbObject.put("createdate", RelativeDate.format(DateFormat.getFormat(dbObject.get("createdate").toString()), new Date()));
    			}
			}
    		sub_map.put("carlist", carlist);
    	}
    	String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    	
    }
    public  void  ajaxzx(){
    	getLscode();
    	Map<String, Object> sub_map = new HashMap<String, Object>();
    	HashMap<String, Object>whereMap=new HashMap<String, Object>();
    	HashMap<String, Object>sortMap=new HashMap<String, Object>();
    	whereMap.put("custid",custid);
    	sortMap.put("createdate", -1);
    	List<DBObject>clist=baseDao.getList(PubConstants.SUC_JOBEMPLOYMENT, whereMap,0,2,sortMap);
    	List<DBObject>slist=baseDao.getList(PubConstants.SUC_JOBSEEKERS, whereMap,0,2,sortMap);
    	List<DBObject>plist=baseDao.getList(PubConstants.SUC_JOBSUPPLYDEMAND, whereMap,0,2,sortMap);
    	List<DBObject>carlist=baseDao.getList(PubConstants.SUC_JOBCAR, whereMap,0,2,sortMap);
    	if(clist.size()>0){
    		sub_map.put("state", 0);
    		for (DBObject dbObject : clist) {
    			if(dbObject.get("createdate")!=null){
    				dbObject.put("createdate", RelativeDate.format(DateFormat.getFormat(dbObject.get("createdate").toString()), new Date()));
    			}
    			if(dbObject.get("tel")==null){
    				dbObject.put("tel", baseDao.getMessage(PubConstants.SUC_JOBCOMPAY, Long.parseLong(dbObject.get("cid").toString())).get("tel"));
    			}
			}
    		sub_map.put("clist", clist);
    	}
    	if(slist.size()>0){
    		sub_map.put("state", 0);
    		for (DBObject dbObject : slist) {
    			if(dbObject.get("createdate")!=null){
    				dbObject.put("createdate", RelativeDate.format(DateFormat.getFormat(dbObject.get("createdate").toString()), new Date()));
    			}
			}
    		sub_map.put("slist", slist);
    	}
    	if(plist.size()>0){
    		sub_map.put("state", 0);
    		for (DBObject dbObject : plist) {
    			if(dbObject.get("createdate")!=null){
    				dbObject.put("createdate", RelativeDate.format(DateFormat.getFormat(dbObject.get("createdate").toString()), new Date()));
    			}
			}
    		sub_map.put("plist", plist);
    	}
    	if(carlist.size()>0){
    		sub_map.put("state", 0);
    		for (DBObject dbObject : carlist) {
    			if(dbObject.get("createdate")!=null){
    				dbObject.put("createdate", RelativeDate.format(DateFormat.getFormat(dbObject.get("createdate").toString()), new Date()));
    			}
			}
    		sub_map.put("carlist", carlist);
    	}
    	String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    }
    /**
     * 招聘分类
     */
    public void  ajaxtype(){
    	getLscode();
    	Map<String, Object> sub_map = new HashMap<String, Object>();
    	HashMap<String, Object>whereMap=new HashMap<String, Object>();
    	HashMap<String, Object>sortMap=new HashMap<String, Object>();
    	whereMap.put("custid",custid);
    	sortMap.put("sort",-1);
    	List<DBObject>list=baseDao.getList(PubConstants.SUC_JOBTYPE, whereMap, sortMap);
    	if(list.size()>0){
    		sub_map.put("state", 0);
    		sub_map.put("list",list);
    	}
    	String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]); 
    }
    public void deletAll(){
    	String custid=SpringSecurityUtils.getCurrentUser().getId();
    	if(StringUtils.isNotEmpty(custid)){
    		baseDao.delete(PubConstants.SUC_JOBCAR);
    		baseDao.delete(PubConstants.SUC_JOBCOMPAY);
    		baseDao.delete(PubConstants.SUC_JOBEMPLOYMENT);
    		baseDao.delete(PubConstants.SUC_JOBSUPPLYDEMAND);
    		baseDao.delete(PubConstants.SUC_JOBSEEKERS);
    	}
    }
	 
}
