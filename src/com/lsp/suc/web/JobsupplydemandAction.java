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
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.web.GeneralAction; 
import com.lsp.suc.entity.JobSupplydemand;
import com.lsp.suc.entity.Jobemployment; 
import com.lsp.suc.entity.Jobseekers;
import com.lsp.website.service.WwzService;  
import com.mongodb.BasicDBObject; 
import com.mongodb.DBObject;

/**
 * 供求信息管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name = JobsupplydemandAction.RELOAD, location = "jobsupplydemand.action",params={"fypage", "%{fypage}"}, type = "redirect") })
public class JobsupplydemandAction extends GeneralAction<JobSupplydemand> {

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
	private JobSupplydemand entity=new JobSupplydemand();
	private Long _id;


	@Override
	public String execute() throws Exception {
		
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>(); 
		custid=SpringSecurityUtils.getCurrentUser().getId(); 
		Struts2Utils.getRequest().setAttribute("custid", custid);
		whereMap.put("custid", custid);
		sortMap.put("createdate", -1);  
		fycount=baseDao.getCount(PubConstants.SUC_JOBSUPPLYDEMAND, whereMap);
		
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		HashMap<String, Object> backMap =new HashMap<String, Object>();
		backMap.put("content", 0);
		backMap.put("summary", 0); 
		List<DBObject> list=baseDao.getList(PubConstants.SUC_JOBSUPPLYDEMAND,whereMap,fypage,10, sortMap);
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
		Struts2Utils.getRequest().setAttribute("list", list);
		 	 
		return SUCCESS;
	}
	

	@Override
	public String delete() throws Exception {
		try {
			custid=SpringSecurityUtils.getCurrentUser().getId(); 
			baseDao.delete(PubConstants.SUC_JOBSUPPLYDEMAND,_id);
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
		Struts2Utils.getRequest().setAttribute("entity", baseDao.getMessage(PubConstants.SUC_JOBSUPPLYDEMAND, _id)); 
		
		return "add";
	}
	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			//有custId查出来 用户信息
			entity = (JobSupplydemand)UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.SUC_JOBSUPPLYDEMAND,_id),JobSupplydemand.class);
		} else {
			entity = new JobSupplydemand();
		}
	}
	
	

	@Override
	public String save() throws Exception {
		//注册业务逻辑
		try {
			if(_id == null){
				_id=mongoSequence.currval(PubConstants.SUC_JOBSUPPLYDEMAND);	
				entity.setCreatedate(new Date()); 
			}		
			entity.set_id(_id);
			custid=SpringSecurityUtils.getCurrentUser().getId();
			entity.setCustid(custid); 
		    baseDao.insert(PubConstants.SUC_JOBSUPPLYDEMAND,entity);
		     
		   
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return RELOAD;
	}
 
	@Override
	public JobSupplydemand getModel() {
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
		
		
		List<DBObject> list=baseDao.getList(PubConstants.SUC_JOBSUPPLYDEMAND,whereMap, sortMap);
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
			Struts2Utils.getRequest().setAttribute("entity",baseDao.getMessage(PubConstants.SUC_JOBSUPPLYDEMAND, Long.parseLong(id))); 
		}
		return "webadd";
		
	}
	/**
	 * 手机添加求职信息
	 */
	public void  ajaxwebadd(){

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
			obj.setLx(Integer.parseInt(lx));
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
	 
}
