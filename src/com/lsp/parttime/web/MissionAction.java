package com.lsp.parttime.web;

import java.net.URLEncoder;
import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.lsp.hou.web.HoufaetAction;
import com.lsp.parttime.entity.Employee;
import com.lsp.parttime.entity.Mission;
import com.lsp.parttime.entity.MissionPromote;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.entity.WxToken;
import com.lsp.pub.util.BaseDecimal;
import com.lsp.pub.util.CommonUtil;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.PayCommonUtil;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.TenpayUtil;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.util.XMLUtil;
import com.lsp.pub.web.GeneralAction;
import com.lsp.website.service.WwzService;
import com.lsp.weixin.entity.WxPayConfig;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject; 

import net.sf.json.JSONArray;
import net.sf.json.JSONObject; 
/**
 * 任务管理
 * @author lsp
 *
 */
@Namespace("/parttime")
@Results({ @Result(name = HoufaetAction.RELOAD, location = "mission.action", params = {"fypage", "%{fypage}" }, type = "redirect") })
public class MissionAction extends GeneralAction<Mission>{

	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private Mission entity = new Mission();
	private Long _id; 
	public void set_id(Long _id) {
		this._id = _id;
	}
	@Autowired
	private WwzService wwzService;
	private MongoSequence mongoSequence;

	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}
	@Override
	public String execute() throws Exception {
		custid=SpringSecurityUtils.getCurrentUser().getId();
		HashMap<String, Object>whereMap=new HashMap<>();
		HashMap<String, Object>sortMap=new HashMap<>();
		whereMap.put("custid", custid);
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))) {
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject>list=baseDao.getList(PubConstants.PARTTIME_MISSION, whereMap,fypage,10,sortMap);
		fycount=baseDao.getCount(PubConstants.PARTTIME_MISSION,whereMap);
		Struts2Utils.getRequest().setAttribute("list",list);
		Struts2Utils.getRequest().setAttribute("custid",custid);
		return SUCCESS; 
	}

	@Override
	public Mission getModel() {
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
		// TODO Auto-generated method stub
		return "add";
	}

	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		if (_id==null) {
			_id=mongoSequence.currval(PubConstants.PARTTIME_MISSION);
		} 
		entity.set_id(_id);
		entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
		String gatherdate=Struts2Utils.getParameter("gatherdate");
		String startdate=Struts2Utils.getParameter("startdate");
		String enddate=Struts2Utils.getParameter("enddate");
		
		entity.setCreatedate(new Date());
		baseDao.insert(PubConstants.PARTTIME_MISSION, entity);
		return RELOAD;
	}

	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		SpringSecurityUtils.getCurrentUser().getId();
		baseDao.delete(PubConstants.PARTTIME_MISSION,_id);
		return RELOAD;
	}

	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		if (_id!=null) {
			entity=(Mission) baseDao.getMessage(PubConstants.PARTTIME_MISSION, _id);
		}else {
			entity=new Mission();
		}
		
	}
	public void upd() throws Exception {
		DBObject db = baseDao.getMessage(PubConstants.PARTTIME_MISSION, _id);
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}
	/**
	 * 发布任务
	 * @throws ParseException 
	 */
	public void  createMiss() throws ParseException {
		getLscode();
		Map<String, Object>submap=new HashMap<String, Object>(); 
		submap.put("state", 1);
		if (wwzService.CheckEmployee(fromUserid, custid)) { 
			String linktel=Struts2Utils.getParameter("linktel");
			String linkname=Struts2Utils.getParameter("linkname"); 
			String experience=Struts2Utils.getParameter("experience");
			String education=Struts2Utils.getParameter("education");
			String num=Struts2Utils.getParameter("num");
			String workaddress=Struts2Utils.getParameter("workaddress");
			String wages=Struts2Utils.getParameter("wages");
			String title=Struts2Utils.getParameter("title");
			String price=Struts2Utils.getParameter("price");
			String jstype=Struts2Utils.getParameter("jstype");
			String gatherdate=Struts2Utils.getParameter("gatherdate");
			String startdate=Struts2Utils.getParameter("startdate");
			String enddate=Struts2Utils.getParameter("enddate");
			String type=Struts2Utils.getParameter("type");
			String company=Struts2Utils.getParameter("company");
			String area=Struts2Utils.getParameter("area");
			String age=Struts2Utils.getParameter("age");
			String summary=Struts2Utils.getParameter("summary");
			
			try {
				Mission mission=new Mission();
				mission.set_id(mongoSequence.currval(PubConstants.PARTTIME_MISSION));
				mission.setFromid(fromUserid);
				mission.setCustid(custid);
				mission.setTitle(title);
				if (StringUtils.isNotEmpty(price)) {
					mission.setPrice(Double.parseDouble(price));
				}
				if (StringUtils.isNotEmpty(jstype)) {
					mission.setJstype(Integer.parseInt(jstype));
				} 
				System.out.println(gatherdate);
				mission.setGatherdate(DateFormat.StringToDate(gatherdate+":00"));
				mission.setStartdate(DateFormat.StringToDate(startdate+":00"));
				mission.setEnddate(DateFormat.StringToDate(enddate+":00"));
				if (StringUtils.isNotEmpty(type)) {
					mission.setType(Integer.parseInt(type));
				} 
				mission.setCompany(company);
				mission.setArea(area);
				if (StringUtils.isNotEmpty(age)) {
					mission.setAge(Integer.parseInt(age));
				} 
				mission.setCreatedate(new Date());
				if (StringUtils.isNotEmpty(education)) {
					mission.setEducation(Integer.parseInt(education));
				}
				if (StringUtils.isNotEmpty(experience)) {
					mission.setExperience(Integer.parseInt(experience));
				}
				if (StringUtils.isNotEmpty(num)) {
					mission.setNum(Integer.parseInt(num));
				} 
				mission.setLinkname(linkname);
				mission.setLinktel(linktel);
				mission.setWages(wages);
				mission.setWorkaddress(workaddress);
				mission.setSummary(summary);
				baseDao.insert(PubConstants.PARTTIME_MISSION, mission);
				submap.put("state", 0);
			} catch (NumberFormatException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
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
    	Struts2Utils.getRequest().setAttribute("custid", custid); 
    	WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		System.out.println(token.getAppid());
		String url=SysConfig.getProperty("ip")+"/parttime/mission!index.action?custid="+custid;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}
		System.out.println("************");
		DBObject share=wwzService.getShareFx(custid,"mission_share");  
		if(share==null){
			share=new BasicDBObject();
			share.put("fxtitle", wwzService.getWxUsertype(fromUserid, "nickname"));
			share.put("fximg",wwzService.getWxUsertype(fromUserid, "headimgurl"));
			share.put("fxurl", url);
			share.put("fxsummary", share.get("fxsummary"));
		}else{
			share.put("fxurl", url);
		} 
		Struts2Utils.getRequest().setAttribute("share", share);
		return "index2";
	}
	/**
	 * 详情页
	 * @return
	 */
	public String details() {
		
		getLscode();
    	Struts2Utils.getRequest().setAttribute("custid", custid); 
    	String id=Struts2Utils.getParameter("id");
    	WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/parttime/mission!details.action?custid="+custid+"&id="+id;
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
			share.put("fxurl", url);
			share.put("fxsummary", share.get("fxsummary"));
		}else{
			share.put("fxurl", url);
		} 
		Struts2Utils.getRequest().setAttribute("share", share);
		
		
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
		String url=SysConfig.getProperty("ip")+"/parttime/mission!order.action?custid="+custid;
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
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid+"&tgid="+fromUserid);
			share.put("fxsummary", share.get("fxsummary"));
		}else{
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid+"&tgid="+fromUserid);
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
		String url=SysConfig.getProperty("ip")+"/parttime/mission!withposi.action?custid="+custid;
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
			share.put("fxurl",SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid+"&tgid="+fromUserid);
			share.put("fxsummary", share.get("fxsummary"));
		}else{
			share.put("fxurl",SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid+"&tgid="+fromUserid);
		} 
		Struts2Utils.getRequest().setAttribute("share", share);
		Struts2Utils.getRequest().setAttribute("data", wwzService.getAsset(custid, fromUserid));
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
		String url=SysConfig.getProperty("ip")+"/parttime/mission!withposidet.action?custid="+custid;
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
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid+"&tgid="+fromUserid);
			share.put("fxsummary", share.get("fxsummary"));
		}else{
			share.put("fxurl",SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid+"&tgid="+fromUserid);
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
		String url=SysConfig.getProperty("ip")+"/parttime/mission!telCertifica.action?custid="+custid;
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
			share.put("fxurl",SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid+"&tgid="+fromUserid);
			share.put("fxsummary", share.get("fxsummary"));
		}else{
			share.put("fxurl",SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid+"&tgid="+fromUserid);
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
		String url=SysConfig.getProperty("ip")+"/parttime/mission!notice.action?custid="+custid;
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
			share.put("fxurl",SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid+"&tgid="+fromUserid);
			share.put("fxsummary", share.get("fxsummary"));
		}else{
			share.put("fxurl",SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid+"&tgid="+fromUserid);
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
		String url=SysConfig.getProperty("ip")+"/parttime/mission!about.action?custid="+custid;
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
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid+"&tgid="+fromUserid);
			share.put("fxsummary", share.get("fxsummary"));
		}else{
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid+"&tgid="+fromUserid);
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
		String url=SysConfig.getProperty("ip")+"/parttime/mission!question.action?custid="+custid;
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
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid+"&tgid="+fromUserid);
			share.put("fxsummary", share.get("fxsummary"));
		}else{
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid+"&tgid="+fromUserid);
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
		String url=SysConfig.getProperty("ip")+"/parttime/mission!share.action?custid="+custid;
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
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid+"&tgid="+fromUserid);
			share.put("fxsummary", share.get("fxsummary"));
		}else{
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid+"&tgid="+fromUserid);
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
		String url=SysConfig.getProperty("ip")+"/parttime/mission!ajaxadd.action?custid="+custid;
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
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid+"&tgid="+fromUserid);
			share.put("fxsummary", share.get("fxsummary"));
		}else{
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid+"&tgid="+fromUserid);
		} 
		Struts2Utils.getRequest().setAttribute("share", share);
		return "ajaxadd";
	}
	/**
	 * 职位管理
	 * @return
	 */
	public String mission() {
		getLscode();
    	Struts2Utils.getRequest().setAttribute("custid", custid); 
    	WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/parttime/mission!mission.action?custid="+custid;
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
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid+"&tgid="+fromUserid);
			share.put("fxsummary", share.get("fxsummary"));
		}else{
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid+"&tgid="+fromUserid);
		} 
		Struts2Utils.getRequest().setAttribute("share", share);
		return "mission";
	}
	/**
	 * 职位订单
	 * @return
	 */
	public String missorder() {
		getLscode();
    	Struts2Utils.getRequest().setAttribute("custid", custid); 
    	String id=Struts2Utils.getParameter("id");
    	WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/parttime/mission!missorder.action?custid="+custid+"&id="+id;
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
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid+"&tgid="+fromUserid);
			share.put("fxsummary", share.get("fxsummary"));
		}else{
			share.put("fxurl", SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid+"&tgid="+fromUserid);
		} 
		Struts2Utils.getRequest().setAttribute("entity", baseDao.getMessage(PubConstants.PARTTIME_MISSION, Long.parseLong(id)));
		Struts2Utils.getRequest().setAttribute("share", share);
		return "missorder";
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
		String url=SysConfig.getProperty("ip")+"/parttime/mission!mine.action?custid="+custid;
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
			share.put("fxurl",SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid+"&tgid="+fromUserid);
			share.put("fxsummary", share.get("fxsummary"));
		}else{
			share.put("fxurl",SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid+"&tgid="+fromUserid);
		} 
		Struts2Utils.getRequest().setAttribute("share", share);
		Struts2Utils.getRequest().setAttribute("entity",baseDao.getMessage(PubConstants.PARTTIME_EMPLOYEE, custid+"-"+fromUserid)); 
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
		String url=SysConfig.getProperty("ip")+"/parttime/mission!minedata.action?custid="+custid;
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
			share.put("fxurl",  SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid+"&tgid="+fromUserid);
			share.put("fxsummary", share.get("fxsummary"));
		}else{
			share.put("fxurl",  SysConfig.getProperty("ip")+"/parttime/employee!index.action?custid="+custid+"&tgid="+fromUserid);
		} 
		Struts2Utils.getRequest().setAttribute("share", share);
		return "minedata";
	}
	/**
	 * ajax获取首页数据
	 */
	public void ajaxIndex() {
		getLscode();
		Map<String, Object>submap=new HashMap<String, Object>();
		submap.put("state", 1);
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		sortMap.put("createdate", -1);
		whereMap.put("custid", custid);
		if (StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))) {
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject>list=baseDao.getList(PubConstants.PARTTIME_MISSION, whereMap,fypage,10, sortMap);
		if(list.size()>0){
			submap.put("state",0);
			for (DBObject dbObject : list) {
				String age=dbObject.get("age").toString();
				if (Integer.parseInt(age)==0) {
					dbObject.put("age","18岁以上");
				}
				String jstype=dbObject.get("jstype").toString();
				if (Integer.parseInt(jstype)==0) {
					dbObject.put("jstype","默认");
				}
				if (Integer.parseInt(jstype)==1) {
					dbObject.put("jstype","时");
				}
				if (Integer.parseInt(jstype)==2) {
					dbObject.put("jstype","日");
				}
				if (Integer.parseInt(jstype)==3) {
					dbObject.put("jstype","月");
				}
				HashMap<String,Object>whereMap1=new HashMap<>();
				whereMap1.put("mid",Long.parseLong(dbObject.get("_id").toString()));
				dbObject.put("zpcount", baseDao.getCount(PubConstants.PARTTIME_ORDER,whereMap1));
			}
			submap.put("list",list);	
		}
		
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * ajax获取订单数据
	 */
	public void ajaxOrder() {
		getLscode();
		Map<String, Object>submap=new HashMap<String, Object>();
		submap.put("state", 1);
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		sortMap.put("createdate", -1);
		if (StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))) {
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		whereMap.put("custid", custid);
		whereMap.put("fromid", fromUserid);
		String state=Struts2Utils.getParameter("state");
		System.out.println(state);
		if (StringUtils.isNotEmpty(state)) {
			whereMap.put("state", Integer.parseInt(state));
		}  
		List<DBObject>list=baseDao.getList(PubConstants.PARTTIME_ORDER, whereMap,fypage,10, sortMap);
		 
		if(list.size()>0){
			submap.put("state",0);
			submap.put("list",list);	
		} 
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * ajax获取提现数据
	 */
	public void ajaxWithposi() {
		getLscode();
		Map<String, Object>submap=new HashMap<String, Object>();
		submap.put("state", 1);
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		sortMap.put("createdate", -1);
		whereMap.put("custid", custid);
		whereMap.put("fromid", fromUserid);
		if (StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))) {
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject>list=baseDao.getList(PubConstants.PARTTIME_ASSETSRECORD, whereMap,fypage,10, sortMap);
		if(list.size()>0){
			submap.put("state",0);
			submap.put("list",list);	
		}
		
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 保存个人数据
	 */
	public void ajaxSaveMine() { 
		getLscode();
		Map<String, Object> submap = new HashMap<String, Object>();
		submap.put("state", 1); 
		try {
			String name=Struts2Utils.getParameter("name");
			String tel=Struts2Utils.getParameter("tel");
			String idcard=Struts2Utils.getParameter("idcard");
			String wxid=Struts2Utils.getParameter("wxid");
			String bytel=Struts2Utils.getParameter("bytel");
			String experience=Struts2Utils.getParameter("experience");
			String education=Struts2Utils.getParameter("education"); 
			Employee employee=new Employee(); 
			DBObject dbObject=baseDao.getMessage(PubConstants.PARTTIME_EMPLOYEE,custid+"-"+fromUserid);
			if (dbObject!=null) {
				employee=(Employee) UniObject.DBObjectToObject(dbObject, Employee.class);
			} 
			employee.set_id(custid+"-"+fromUserid);
			employee.setBytel(bytel);
			employee.setCustid(custid); 
			employee.setCreatedate(new Date());
			if (StringUtils.isNotEmpty(experience)) {
				employee.setEducation(Integer.parseInt(experience));
			}
			if (StringUtils.isNotEmpty(education)) {
				employee.setExperience(Integer.parseInt(education));	
			} 
			employee.setFromid(fromUserid);
			employee.setName(name);
			employee.setIdcard(idcard);
			employee.setWxid(wxid);
			employee.setTel(tel);
			baseDao.insert(PubConstants.PARTTIME_EMPLOYEE, employee);
			wwzService.InsMissionInform(custid, fromUserid, "个人信息修改提醒", "您在近期进行了个人信息的修改，如果不是本人操作请尽快修改！并重置个人账户！", 0, "", "", 0L);
			submap.put("state", 0);
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * ajax获取通知数据
	 */
	public void ajaxNotice() {
		getLscode();
		Map<String, Object>submap=new HashMap<String, Object>();
		submap.put("state", 1);
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		sortMap.put("createdate", -1);
		whereMap.put("fromid", fromUserid);
		whereMap.put("custid",custid);
		if (StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))) {
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject>list=baseDao.getList(PubConstants.PARTTIME_MISSIONINFORM, whereMap,fypage,10, sortMap);
		if(list.size()>0){
			submap.put("state",0);
			for (DBObject dbObject : list) {
				if (Integer.parseInt(dbObject.get("type").toString())==1) {
					dbObject.put("obj",baseDao.getMessage(PubConstants.PARTTIME_MISSION, Long.parseLong(dbObject.get("mid").toString())));
				}else if(Integer.parseInt(dbObject.get("type").toString())==2){
					dbObject.put("obj",baseDao.getMessage(PubConstants.PARTTIME_MISSION, Long.parseLong(dbObject.get("oid").toString())));
					 
				}
			}
			submap.put("list",list);	
		}
		
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	    * 微信提现
	    */
	   public  void  wxtx() throws Exception{
		    SortedMap<Object,Object> params = new TreeMap<Object,Object>();
			getLscode(); 
			DBObject  wx=wwzService.getWxUser(fromUserid);
			if(wx.get("_id").equals("notlogin")){
				params.put("state", 3);
				String json = JSONArray.fromObject(params).toString();
				Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
				return; 
			} 
			WxToken wxtoken=GetAllFunc.wxtoken.get(custid);
			WxPayConfig wxconfig=new WxPayConfig();
			if(wxtoken.getQx()==0){
				params.put("state", 1);
				String json = JSONArray.fromObject(params).toString();
				Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
				return;
			}else if(wxtoken.getQx()==1){
				wxconfig=GetAllFunc.wxPay.get(custid);
			}else if(wxtoken.getQx()==2){//父类结算   
				wxconfig=GetAllFunc.wxPay.get(wwzService.getparentcustid(custid));
			}
			//支付的价格
			String price = Struts2Utils.getParameter("price"); 
			boolean bl=wwzService.checkAssetMiss(custid, fromUserid);
			if (!bl) {
				//账号资金异常
				params.put("state",5);
				String json = JSONArray.fromObject(params).toString();
				Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
				return;
			}
			if(wwzService.getAsset(custid,fromUserid)<Double.parseDouble(price)){
				//账号余额不足
				params.put("state",2);
				String json = JSONArray.fromObject(params).toString();
				Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
				return;
			}
			if(Double.parseDouble(price)>200||Double.parseDouble(price)<1){
				//输入金额有误（支持1-200）
				params.put("state",4);
				String json = JSONArray.fromObject(params).toString();
				Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
				return;
			} 
			//备注
			String remark=Struts2Utils.getParameter("remark");
			//活动名称
			String act_name=Struts2Utils.getParameter("act_name");
			//红包祝福语
			String wishing=Struts2Utils.getParameter("wishing");  
		     
			//10位序列号,可以自行调整。
			//四位随机数
			String strRandom = TenpayUtil.buildRandom(4)+"";
			String orderno = DateFormat.getDate()+strRandom+mongoSequence.currval(PubConstants.SHOP_AGENTDETAIL);
		  
			String nonce_str=PayCommonUtil.CreateNoncestr();
			SortedMap<Object,Object> parameters = new TreeMap<Object,Object>();
			parameters.put("nonce_str", nonce_str);
			parameters.put("mch_billno",orderno); 
			parameters.put("mch_id", wxconfig.getPartner());
			parameters.put("wxappid",wxconfig.getAppid());  
			parameters.put("remark", remark); 
			parameters.put("send_name", wxconfig.getName());//商户名称
			parameters.put("re_openid", wwzService.getWxUsertype(fromUserid,"fromUser"));
			parameters.put("total_amount", BaseDecimal.round(BaseDecimal.multiplication(price, "100"),0));
			parameters.put("total_num", "1");
			parameters.put("wishing",wishing);
			parameters.put("client_ip", Struts2Utils.getRequest().getRemoteAddr());
			parameters.put("act_name",act_name); 
		 


			String sign = PayCommonUtil.createSign("UTF-8", parameters,wxconfig.getPartner_key());
			parameters.put("sign", sign);
			String requestXML = PayCommonUtil.getRequestXml(parameters);
			
			String result =CommonUtil.httpsRequestSSL("https://api.mch.weixin.qq.com/mmpaymkttransfers/sendredpack","POST", requestXML,wxconfig.getPartner(),"D:/certs/"+wxconfig.getPartner()+"_"+wxconfig.getPartner()+"/apiclient_cert.p12");
			
			Map<String, String> map = XMLUtil.doXMLParse(result);
	        if(map.get("return_msg").equals("发放成功")&&map.get("err_code_des").equals("发放成功")){
	        	//更新账号
	        	wwzService.reduceAssMiss(custid, fromUserid,Double.parseDouble(price));
	        	 
	        }
		    params.put("state", 0); 
		    params.put("value",price);
			String json = JSONArray.fromObject(params).toString();
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
			
	   }
	   /**
	    * 生成推广
	    */
	   public void  CreateTg() {
		   getLscode();
		   Map<String, Object>submap=new HashMap<String, Object>();
			submap.put("state", 1);
			HashMap<String, Object>whereMap=new HashMap<String, Object>(); 
			whereMap.put("fromid", fromUserid);
			whereMap.put("custid",custid);
			String tgid=Struts2Utils.getParameter("tgid");
			if (StringUtils.isNotEmpty(tgid)&&!tgid.equals(fromUserid)) {
				MissionPromote missionPromote=new MissionPromote();
				DBObject dbObject=baseDao.getMessage(PubConstants.PARTTIME_MISSIONPROMOTE, whereMap);
				if (dbObject!=null) {
					submap.put("state", 2);
				}else {
					missionPromote.set_id(mongoSequence.currval(PubConstants.PARTTIME_MISSIONPROMOTE));
					missionPromote.setCreatedate(new Date());
					missionPromote.setCustid(custid);
					missionPromote.setFromid(fromUserid);
					missionPromote.setTgid(tgid);
					baseDao.insert(PubConstants.PARTTIME_MISSIONPROMOTE, missionPromote);
					submap.put("state", 0);
				} 
			}
		
			String json = JSONArray.fromObject(submap).toString(); 
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	   }
	   /**
		 * ajax获取职位数据
		 */
		public void ajaxMisson() {
			getLscode();
			Map<String, Object>submap=new HashMap<String, Object>();
			submap.put("state", 1);
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			sortMap.put("createdate", -1);
			whereMap.put("custid",custid);
			if (StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))) {
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			List<DBObject>list=baseDao.getList(PubConstants.PARTTIME_MISSION, whereMap,fypage,10, sortMap);
			if(list.size()>0){
				submap.put("state",0);
				for (DBObject dbObject : list) {
					String age=dbObject.get("age").toString();
					if (Integer.parseInt(age)==0) {
						dbObject.put("age","18岁以上");
					}
					String jstype=dbObject.get("jstype").toString();
					if (Integer.parseInt(jstype)==0) {
						dbObject.put("jstype","默认");
					}
					if (Integer.parseInt(jstype)==1) {
						dbObject.put("jstype","时");
					}
					if (Integer.parseInt(jstype)==2) {
						dbObject.put("jstype","日");
					}
					if (Integer.parseInt(jstype)==3) {
						dbObject.put("jstype","月");
					}
					HashMap<String,Object>whereMap1=new HashMap<>();
					whereMap1.put("mid",Long.parseLong(dbObject.get("_id").toString()));
					dbObject.put("zpcount", baseDao.getCount(PubConstants.PARTTIME_ORDER,whereMap1));
				}
				submap.put("list",list);	
			}
			
			String json = JSONArray.fromObject(submap).toString(); 
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		}
		/**
		 * ajax获取职位订单数据
		 */
		public void ajaxMissonOrder() {
			getLscode();
			Map<String, Object>submap=new HashMap<String, Object>();
			submap.put("state", 1);
			DBObject dbObject1=baseDao.getMessage(PubConstants.PARTTIME_EMPLOYEE, custid+"-"+fromUserid);
			if (dbObject1!=null&&dbObject1.get("type")!=null) {
				int type=Integer.parseInt(dbObject1.get("type").toString());
				if (type>0) {
					String mid=Struts2Utils.getParameter("mid");
					if (StringUtils.isNotEmpty(mid)) {
						HashMap<String, Object>whereMap=new HashMap<String, Object>();
						HashMap<String, Object>sortMap=new HashMap<String, Object>();
						sortMap.put("createdate", -1);
						whereMap.put("custid",custid);
						whereMap.put("mid",Long.parseLong(mid));
						if (StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))) {
							fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
						} 
						String state=Struts2Utils.getParameter("state"); 
						if (StringUtils.isNotEmpty(state)) {
							whereMap.put("state", Integer.parseInt(state));
						}  
						List<DBObject>list=baseDao.getList(PubConstants.PARTTIME_ORDER, whereMap,fypage,20, sortMap);
						 
						if(list.size()>0){
							submap.put("state",0);
							for (DBObject dbObject : list) { 
								DBObject dbObject2=baseDao.getMessage(PubConstants.PARTTIME_EMPLOYEE, custid+"-"+dbObject.get("fromid").toString());
								if (type==1) {
									if(dbObject2!=null&&dbObject2.get("tel")!=null) {
										String tel=dbObject2.get("tel").toString();
										dbObject2.put("tel",encryptingTel(tel));
									}
									
								}
								dbObject.put("obj",dbObject2);
							}
							submap.put("list",list);	
						} 
					}
				}
			}
			
			
			String json = JSONArray.fromObject(submap).toString(); 
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		}
		public String encryptingTel(String tel) {
			if (tel.length()==11) {
				String str1=tel.substring(0,3);
				String str2=tel.substring(7);
				
				return str1+"****"+str2; 
			}else {
				return tel;
			}
			
			
		}
		
}
