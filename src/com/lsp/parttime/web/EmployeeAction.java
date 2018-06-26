package com.lsp.parttime.web;

import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.lsp.hou.entity.HousewiferyFeatures;
import com.lsp.hou.web.HoufaetAction;
import com.lsp.parttime.entity.Employee;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.entity.WxToken;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.web.GeneralAction;
import com.lsp.website.service.WwzService;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import com.sun.org.apache.bcel.internal.generic.NEW;
import com.sun.swing.internal.plaf.basic.resources.basic;

import net.sf.json.JSONArray;
/**
 * 员工管理
 * 
 * @author lsp
 * 
 */
@Namespace("/parttime")
@Results({ @Result(name = HoufaetAction.RELOAD, location = "employee.action", params = {"fypage", "%{fypage}" }, type = "redirect") })
public class EmployeeAction extends GeneralAction<Employee>{

	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private Employee entity = new Employee();
	private String _id;
	@Autowired
	private WwzService wwzService;
	public void set_id(String _id) {
		this._id = _id;
	}

	private MongoSequence mongoSequence;

	@Override
	public String execute() throws Exception {
		custid=SpringSecurityUtils.getCurrentUser().getId();
		HashMap<String, Object>whereMap=new HashMap<>();
		HashMap<String, Object>sortMap=new HashMap<>();
		whereMap.put("custid", custid);
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))) {
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject>list=baseDao.getList(PubConstants.PARTTIME_EMPLOYEE, whereMap,fypage,10,sortMap);
		fycount=baseDao.getCount(PubConstants.PARTTIME_EMPLOYEE,whereMap);
		Struts2Utils.getRequest().setAttribute("list",list);
		Struts2Utils.getRequest().setAttribute("custid",custid);
		return SUCCESS; 
	}
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}

	@Override
	public Employee getModel() {
		// TODO Auto-generated method stub
		return null;
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
		return null;
	}

	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		SpringSecurityUtils.getCurrentUser().getId();
		baseDao.delete(PubConstants.PARTTIME_EMPLOYEE,_id);
		return RELOAD;
	}

	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		
	}
	/**
	 * 生成emp
	 */
	public void createEmp() {
		getLscode();
		HashMap<String,Object>whereMap=new HashMap<>();
		whereMap.put("fromid",fromUserid);
		whereMap.put("custid",custid);
		DBObject dbObject=baseDao.getMessage(PubConstants.PARTTIME_EMPLOYEE, whereMap);
		if (dbObject==null) {
			Employee employee=new Employee();
			employee.set_id(custid+"-"+fromUserid);
			employee.setCreatedate(new Date());
			employee.setCustid(custid);
			baseDao.insert(PubConstants.PARTTIME_EMPLOYEE, employee);
		}
		
	}
	/**
	 * 修改emp
	 */
	public void ajaxUpdEmp() { 
		getLocale();
		Map<String, Object>submap=new HashMap<String, Object>(); 
		submap.put("state", 1);
		String name=Struts2Utils.getParameter("name");
		String tel=Struts2Utils.getParameter("tel"); 
		String idcard=Struts2Utils.getParameter("idcard");
		String wxid=Struts2Utils.getParameter("wxid");
		String bytel=Struts2Utils.getParameter("bytel");
		DBObject dbObject=baseDao.getMessage(PubConstants.PARTTIME_EMPLOYEE, custid+"-"+fromUserid);
		if (dbObject!=null) {
			Employee employee=(Employee) UniObject.DBObjectToObject(dbObject, Employee.class);
			employee.setBytel(bytel);
			employee.setName(name);
			employee.setIdcard(idcard);
			employee.setTel(tel);
			employee.setWxid(wxid);
			baseDao.insert(PubConstants.PARTTIME_EMPLOYEE, employee);
			submap.put("state", 0);
		}
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * 设置管理员
	 */
	public void ajaxSetAdmin() {  
		Map<String, Object>submap=new HashMap<String, Object>(); 
		submap.put("state", 1);
		String id=Struts2Utils.getParameter("id");
		if (id!=null) {
			DBObject dbObject=baseDao.getMessage(PubConstants.PARTTIME_EMPLOYEE, id);
			if (dbObject!=null) {
				Employee employee=(Employee) UniObject.DBObjectToObject(dbObject, Employee.class);
				employee.setType(1);
				baseDao.insert(PubConstants.PARTTIME_EMPLOYEE, employee);
				submap.put("state",0);
			}
		}
	 
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * 设置管理员
	 */
	public void ajaxSetCjAdmin() {  
		Map<String, Object>submap=new HashMap<String, Object>(); 
		submap.put("state", 1);
		String id=Struts2Utils.getParameter("id");
		if (id!=null) {
			DBObject dbObject=baseDao.getMessage(PubConstants.PARTTIME_EMPLOYEE, id);
			if (dbObject!=null) {
				Employee employee=(Employee) UniObject.DBObjectToObject(dbObject, Employee.class);
				employee.setType(2);
				baseDao.insert(PubConstants.PARTTIME_EMPLOYEE, employee);
				submap.put("state",0);
			}
		}
	 
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * 取消管理员
	 */
	public void ajaxCancelAdmin() {  
		Map<String, Object>submap=new HashMap<String, Object>(); 
		submap.put("state", 1);
		String id=Struts2Utils.getParameter("id");
		if (id!=null) {
			DBObject dbObject=baseDao.getMessage(PubConstants.PARTTIME_EMPLOYEE, id);
			if (dbObject!=null) {
				Employee employee=(Employee) UniObject.DBObjectToObject(dbObject, Employee.class);
				employee.setType(0);
				baseDao.insert(PubConstants.PARTTIME_EMPLOYEE, employee);
				submap.put("state",0);
			}
		}
	 
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * 首页
	 * @return
	 */
	public String index() {
		getLscode();
		String tgid=Struts2Utils.getParameter("tgid");
		
    	Struts2Utils.getRequest().setAttribute("custid", custid); 
    	WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		System.out.println(token.getAppid());
		String url=SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid+"&tgid="+tgid;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}
		Struts2Utils.getRequest().setAttribute("tgid",tgid);
		DBObject share=wwzService.getShareFx(custid,"mission_share");  
		if(share==null){
			share=new BasicDBObject();
			share.put("fxtitle", wwzService.getWxUsertype(fromUserid, "nickname"));
			share.put("fximg",wwzService.getWxUsertype(fromUserid, "headimgurl"));
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid+"&tgid="+fromUserid);
			share.put("fxsummary", share.get("fxsummary"));
		}else{
			share.put("fxurl",  SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid+"&tgid="+fromUserid);
		} 
		Struts2Utils.getRequest().setAttribute("share", share);
		return "index";
	}
	/**
	 * 详情页
	 * @return
	 */
	public String details() {
		
		getLscode();
		String tgid=Struts2Utils.getParameter("tgid");
    	Struts2Utils.getRequest().setAttribute("custid", custid); 
    	String id=Struts2Utils.getParameter("id");
    	WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/parttime/employee!details.action?custid="+custid+"&id="+id+"&tgid="+tgid;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}
		DBObject share=wwzService.getShareFx(custid,"mission_share");  
		if(share==null){
			share=new BasicDBObject();
			share.put("fxtitle", wwzService.getWxUsertype(fromUserid, "nickname"));
			share.put("fximg",wwzService.getWxUsertype(fromUserid, "headimgurl"));
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!details.action?custid="+custid+"&id="+id+"&tgid="+fromUserid);
			share.put("fxsummary", share.get("fxsummary"));
		}else{
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!details.action?custid="+custid+"&id="+id+"&tgid="+fromUserid);
		} 
		Struts2Utils.getRequest().setAttribute("share", share);
		Struts2Utils.getRequest().setAttribute("tgid",tgid);
		
		if (StringUtils.isNotEmpty(id)) {
			DBObject dbObject=baseDao.getMessage(PubConstants.PARTTIME_MISSION, Long.parseLong(id));
			if (dbObject!=null) {
				String age=dbObject.get("age").toString();
				if (Integer.parseInt(age)==0) {
					dbObject.put("age","18岁以上");
				}
				
				String education=dbObject.get("education").toString();
				if (Integer.parseInt(education)==0) {
					dbObject.put("education","无");
				}
				if (Integer.parseInt(education)==1) {
					dbObject.put("education","大专以上");
				}
				if (Integer.parseInt(education)==2) {
					dbObject.put("education","本科以上");
				}
				if (Integer.parseInt(education)==3) {
					dbObject.put("education","硕士以上");
				}
				
				
				String experience=dbObject.get("experience").toString();
				if (Integer.parseInt(experience)==0) {
					dbObject.put("experience","无");
				}
				if (Integer.parseInt(experience)==1) {
					dbObject.put("experience","一年以上");
				}
				if (Integer.parseInt(experience)==2) {
					dbObject.put("experience","一年到三年");
				}
				if (Integer.parseInt(experience)==3) {
					dbObject.put("experience","三年以上");
				}
			}
			Struts2Utils.getRequest().setAttribute("entity",dbObject);
		}
		return "details";
	}
	/**
	 * 订单
	 * @return
	 */
	public String order() {
		getLscode();
    	Struts2Utils.getRequest().setAttribute("custid", custid); 
    	WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/parttime/employee!order.action?custid="+custid;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}
		DBObject share=wwzService.getShareFx(custid,"mission_share");  
		if(share==null){
			share=new BasicDBObject();
			share.put("fxtitle", wwzService.getWxUsertype(fromUserid, "nickname"));
			share.put("fximg",wwzService.getWxUsertype(fromUserid, "headimgurl"));
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid);
			share.put("fxsummary", share.get("fxsummary"));
		}else{
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid);
		} 
		Struts2Utils.getRequest().setAttribute("share", share);
		return "order";
	}
	/**
	 * 提现
	 * @return
	 */
	public String withposi() {
		getLscode();
    	Struts2Utils.getRequest().setAttribute("custid", custid); 
    	WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/parttime/employee!withposi.action?custid="+custid;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}
		DBObject share=wwzService.getShareFx(custid,"mission_share");  
		if(share==null){
			share=new BasicDBObject();
			share.put("fxtitle", wwzService.getWxUsertype(fromUserid, "nickname"));
			share.put("fximg",wwzService.getWxUsertype(fromUserid, "headimgurl"));
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid);
			share.put("fxsummary", share.get("fxsummary"));
		}else{
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid);
		} 
		Struts2Utils.getRequest().setAttribute("share", share);
		return "withposi";
	}
	/**
	 * 提现记录
	 * @return
	 */
	public String withposidet() {
		getLscode();
    	Struts2Utils.getRequest().setAttribute("custid", custid); 
    	WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/parttime/employee!withposidet.action?custid="+custid;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}
		DBObject share=wwzService.getShareFx(custid,"mission_share");  
		if(share==null){
			share=new BasicDBObject();
			share.put("fxtitle", wwzService.getWxUsertype(fromUserid, "nickname"));
			share.put("fximg",wwzService.getWxUsertype(fromUserid, "headimgurl"));
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid);
			share.put("fxsummary", share.get("fxsummary"));
		}else{
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid);
		} 
		Struts2Utils.getRequest().setAttribute("share", share);
		return "withposidet";
	}
	/**
	 * 手机认证
	 * @return
	 */
	public String telcertifica() {
		getLscode();
    	Struts2Utils.getRequest().setAttribute("custid", custid); 
    	WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/parttime/employee!telCertifica.action?custid="+custid;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}
		DBObject share=wwzService.getShareFx(custid,"mission_share");  
		if(share==null){
			share=new BasicDBObject();
			share.put("fxtitle", wwzService.getWxUsertype(fromUserid, "nickname"));
			share.put("fximg",wwzService.getWxUsertype(fromUserid, "headimgurl"));
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid);
			share.put("fxsummary", share.get("fxsummary"));
		}else{
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid);
		} 
		Struts2Utils.getRequest().setAttribute("share", share);
		return "telcertifica";
	}
	/**
	 * 通知
	 * @return
	 */
	public String notice() {
		getLscode();
    	Struts2Utils.getRequest().setAttribute("custid", custid); 
    	WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/parttime/employee!notice.action?custid="+custid;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}
		DBObject share=wwzService.getShareFx(custid,"mission_share");  
		if(share==null){
			share=new BasicDBObject();
			share.put("fxtitle", wwzService.getWxUsertype(fromUserid, "nickname"));
			share.put("fximg",wwzService.getWxUsertype(fromUserid, "headimgurl"));
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid);
			share.put("fxsummary", share.get("fxsummary"));
		}else{
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid);
		} 
		Struts2Utils.getRequest().setAttribute("share", share);
		return "notice";
	}
	/**
	 * 关于我们
	 * @return
	 */
	public String about() {
		getLscode();
    	Struts2Utils.getRequest().setAttribute("custid", custid); 
    	WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/parttime/employee!about.action?custid="+custid;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}
		DBObject share=wwzService.getShareFx(custid,"mission_share");  
		if(share==null){
			share=new BasicDBObject();
			share.put("fxtitle", wwzService.getWxUsertype(fromUserid, "nickname"));
			share.put("fximg",wwzService.getWxUsertype(fromUserid, "headimgurl"));
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid);
			share.put("fxsummary", share.get("fxsummary"));
		}else{
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid);
		} 
		Struts2Utils.getRequest().setAttribute("share", share);
		return "about";
	}
	/**
	 * 常见问题
	 * @return
	 */
	public String question() {
		getLscode();
    	Struts2Utils.getRequest().setAttribute("custid", custid); 
    	WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/parttime/employee!question.action?custid="+custid;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}
		DBObject share=wwzService.getShareFx(custid,"mission_share");  
		if(share==null){
			share=new BasicDBObject();
			share.put("fxtitle", wwzService.getWxUsertype(fromUserid, "nickname"));
			share.put("fximg",wwzService.getWxUsertype(fromUserid, "headimgurl"));
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid);
			share.put("fxsummary", share.get("fxsummary"));
		}else{
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid);
		} 
		Struts2Utils.getRequest().setAttribute("share", share);
		return "question";
	}
	/**
	 * 分享
	 * @return
	 */
	public String share() {
		getLscode();
    	Struts2Utils.getRequest().setAttribute("custid", custid); 
    	WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/parttime/employee!share.action?custid="+custid;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}
		DBObject share=wwzService.getShareFx(custid,"mission_share");  
		if(share==null){
			share=new BasicDBObject();
			share.put("fxtitle", wwzService.getWxUsertype(fromUserid, "nickname"));
			share.put("fximg",wwzService.getWxUsertype(fromUserid, "headimgurl"));
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid);
			share.put("fxsummary", share.get("fxsummary"));
		}else{
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid);
		} 
		Struts2Utils.getRequest().setAttribute("share", share);
		return "share";
	}
	/**
	 * 发布
	 * @return
	 */
	public String ajaxadd() {
		getLscode();
    	Struts2Utils.getRequest().setAttribute("custid", custid); 
    	WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/parttime/employee!ajaxadd.action?custid="+custid;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}
		DBObject share=wwzService.getShareFx(custid,"mission_share");  
		if(share==null){
			share=new BasicDBObject();
			share.put("fxtitle", wwzService.getWxUsertype(fromUserid, "nickname"));
			share.put("fximg",wwzService.getWxUsertype(fromUserid, "headimgurl"));
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid);
			share.put("fxsummary", share.get("fxsummary"));
		}else{
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid);
		} 
		Struts2Utils.getRequest().setAttribute("share", share);
		return "ajaxadd";
	}
	/**
	 * 我的
	 * @return
	 */
	public String mine() {
		getLscode();
    	Struts2Utils.getRequest().setAttribute("custid", custid); 
    	WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/parttime/employee!mine.action?custid="+custid;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}
		DBObject share=wwzService.getShareFx(custid,"mission_share");  
		if(share==null){
			share=new BasicDBObject();
			share.put("fxtitle", wwzService.getWxUsertype(fromUserid, "nickname"));
			share.put("fximg",wwzService.getWxUsertype(fromUserid, "headimgurl"));
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid);
			share.put("fxsummary", share.get("fxsummary"));
		}else{
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid);
		} 
		Struts2Utils.getRequest().setAttribute("share", share);
		Struts2Utils.getRequest().setAttribute("entity",baseDao.getMessage(PubConstants.PARTTIME_EMPLOYEE,custid+"-"+fromUserid)); 
		return "mine";
	}
	/**
	 * 我的资料
	 * @return
	 */
	public String minedata() {
		getLscode();
    	Struts2Utils.getRequest().setAttribute("custid", custid); 
    	WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/parttime/employee!minedata.action?custid="+custid;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}
		DBObject dbObject=baseDao.getMessage(PubConstants.PARTTIME_EMPLOYEE, custid+"-"+fromUserid);
		Struts2Utils.getRequest().setAttribute("entity",dbObject);
		DBObject share=wwzService.getShareFx(custid,"mission_share");  
		if(share==null){
			share=new BasicDBObject();
			share.put("fxtitle", wwzService.getWxUsertype(fromUserid, "nickname"));
			share.put("fximg",wwzService.getWxUsertype(fromUserid, "headimgurl"));
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid);
			share.put("fxsummary", share.get("fxsummary"));
		}else{
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid);
		} 
		Struts2Utils.getRequest().setAttribute("share", share);
		return "minedata";
	}

}
