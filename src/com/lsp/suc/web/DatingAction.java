package com.lsp.suc.web;
 
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder; 
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.SortedMap;
import java.util.TreeMap;
import java.util.UUID;
import java.util.regex.Pattern;

import net.sf.json.JSONArray;
import sun.reflect.generics.tree.VoidDescriptor;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
 
import com.google.common.collect.Lists;
import com.lsp.android.entity.MessageInfo;
import com.lsp.android.entity.ReplyUnFind;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.Location;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.entity.WxToken;
import com.lsp.pub.util.BaseDecimal;
import com.lsp.pub.util.CommonUtil;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.DateUtil;
import com.lsp.pub.util.Geohash;
import com.lsp.pub.util.JmsService;
import com.lsp.pub.util.NumberUtil;
import com.lsp.pub.util.PayCommonUtil;
import com.lsp.pub.util.RelativeDate;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.TenpayUtil;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.util.XMLUtil;
import com.lsp.pub.web.GeneralAction;
import com.lsp.shop.entiy.OrderForm;
import com.lsp.shop.entiy.OrderFormpro;
import com.lsp.shop.entiy.Paymentorder;
import com.lsp.shop.entiy.ProductInfo;
import com.lsp.shop.entiy.ShopMb;
import com.lsp.suc.entity.DatingAudit;
import com.lsp.suc.entity.DatingCondition;
import com.lsp.suc.entity.DatingFoot;
import com.lsp.suc.entity.DatingGold;
import com.lsp.suc.entity.DatingInfo; 
import com.lsp.suc.entity.DatingMember;
import com.lsp.suc.entity.DatingOrder;
import com.lsp.suc.entity.DatingPhoto;
import com.lsp.suc.entity.DatingService;
import com.lsp.suc.entity.DatingServiceTrumpet;
import com.lsp.suc.entity.DatingStar;
import com.lsp.suc.entity.DatingStatistical;
import com.lsp.website.service.WwzService;
import com.lsp.weixin.entity.WxPayConfig;
import com.lsp.weixin.entity.WxUser;
import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject; 
import com.mongodb.DB;
import com.mongodb.DBObject;

/**
 * 婚恋管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name = DatingAction.RELOAD, location = "dating.action",params={"fypage", "%{fypage}"}, type = "redirect") })
public class DatingAction extends GeneralAction<DatingInfo> {

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
	private DatingInfo entity=new DatingInfo();
	private String _id;


	@Override
	public String execute() throws Exception {
		
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		
		
		custid=SpringSecurityUtils.getCurrentUser().getId();
		Struts2Utils.getRequest().setAttribute("custid", custid);
		whereMap.put("custid", custid);
		sortMap.put("createdate", -1);
		String name=Struts2Utils.getParameter("name");
		String tel=Struts2Utils.getParameter("tel");
	  
		if(StringUtils.isNotEmpty(name)){

			Pattern pattern = Pattern.compile("^.*" + name + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("nickname", pattern);
			Struts2Utils.getRequest().setAttribute("name", name);
		}
		if(StringUtils.isNotEmpty(tel)){
			whereMap.put("tel", tel);
			Struts2Utils.getRequest().setAttribute("tel", tel);
		} 
		fycount=baseDao.getCount(PubConstants.SUC_DATING, whereMap);
		
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		HashMap<String, Object> backMap =new HashMap<String, Object>(); 
		List<DBObject> list=baseDao.getList(PubConstants.SUC_DATING,whereMap,fypage,10, sortMap);
		 
		Struts2Utils.getRequest().setAttribute("List", list);
		 
		return SUCCESS;
	}
	

	@Override
	public String delete() throws Exception {
		try {
			custid=SpringSecurityUtils.getCurrentUser().getId(); 
			baseDao.delete(PubConstants.SUC_DATING,_id);
			addActionMessage("成功删除!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,删除过程中出现异常!");
		}
		return RELOAD;
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
			entity = (DatingInfo)UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.SUC_DATING,_id),DatingInfo.class);
		} else {
			entity = new DatingInfo();
		}
	}
	
	

	@Override
	public String save() throws Exception {
		 
		return RELOAD;
	}
	 
	@Override
	public DatingInfo getModel() {
		return entity;
	}
	public void set_id(String _id) {
		this._id = _id;
	}
	 
	/**
	 * 列表页面
	 * @return
	 */
	public String web() {
		getLscode();
		wwzService.flow(custid, "dating_web");
		Struts2Utils.getRequest().setAttribute("custid",custid);
		String datingid=Struts2Utils.getParameter("datingid");
		WxToken token=GetAllFunc.wxtoken.get(custid); 
		 if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 }
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/dating!web.action?custid="+custid+"&datingid="+datingid;  
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
		register(); 
		Struts2Utils.getRequest().setAttribute("reading", wwzService.getFlow(custid, "dating_web")); 
		DBObject share=wwzService.getShareFx(custid,"dating_web");
		if(share==null){
			share=new BasicDBObject(); 
		} 
		share.put("fxurl",SysConfig.getProperty("ip")+"/suc/dating!web.action?custid="+custid+"&datingid="+wwzService.getVipNo(fromUserid));
		Struts2Utils.getRequest().setAttribute("share", share);
		Struts2Utils.getRequest().setAttribute("uncount",getunfind(fromUserid));
		Struts2Utils.getRequest().setAttribute("slide",wwzService.getslide(custid, "dating_web"));
		Struts2Utils.getRequest().setAttribute("datingtype",1); 
		CheckReward(datingid); 
		Struts2Utils.getRequest().setAttribute("datingid",wwzService.getVipNo(fromUserid));
		if(share!=null&&share.get("fxmb")!=null){
			return "web"+share.get("fxmb").toString();
		}  
		return "web";

	}
	/**
	 * 附近页面
	 * @return
	 */
	public String near() {
		getLscode();
		wwzService.flow(custid, "dating_near");
		Struts2Utils.getRequest().setAttribute("custid",custid);
		String datingid=Struts2Utils.getParameter("datingid");
		Struts2Utils.getRequest().setAttribute("datingid",datingid);
		WxToken token=GetAllFunc.wxtoken.get(custid); 
		 if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 }
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/dating!near.action?custid="+custid;  
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
		 
		Struts2Utils.getRequest().setAttribute("reading", wwzService.getFlow(custid, "dating_near")); 
		DBObject share=wwzService.getShareFx(custid,"dating_web");
		if(share==null){
			share=new BasicDBObject(); 
		} 
		share.put("fxurl",SysConfig.getProperty("ip")+"/suc/dating!web.action?custid="+custid+"&datingid="+wwzService.getVipNo(fromUserid));
		Struts2Utils.getRequest().setAttribute("share", share);
		Struts2Utils.getRequest().setAttribute("uncount",getunfind(fromUserid));
		Struts2Utils.getRequest().setAttribute("slide",wwzService.getslide(custid, "dating_near"));
		Struts2Utils.getRequest().setAttribute("datingtype",3); 
		return "near";

	}
	/**
	 * 消息页面
	 * @return
	 */
	public String message() {
		getLscode();
		wwzService.flow(custid, "dating_message");
		String datingid=Struts2Utils.getParameter("datingid");
		Struts2Utils.getRequest().setAttribute("datingid",datingid);
		Struts2Utils.getRequest().setAttribute("custid",custid); 
		WxToken token=GetAllFunc.wxtoken.get(custid); 
		 if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 }
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/dating!message.action?custid="+custid;  
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
		 
		Struts2Utils.getRequest().setAttribute("reading", wwzService.getFlow(custid, "dating_message")); 
		DBObject share=wwzService.getShareFx(custid,"dating_web");
		if(share==null){
			share=new BasicDBObject(); 
		} 
		share.put("fxurl",SysConfig.getProperty("ip")+"/suc/dating!web.action?custid="+custid+"&datingid="+wwzService.getVipNo(fromUserid));
		Struts2Utils.getRequest().setAttribute("share", share); 
		Struts2Utils.getRequest().setAttribute("slide",wwzService.getslide(custid, "dating_message"));
		Struts2Utils.getRequest().setAttribute("uncount",getunfind(fromUserid));
		Struts2Utils.getRequest().setAttribute("datingtype",2); 
		return "message";

	}
	/**
	 * 个人中心
	 * @return
	 */
	public String personalcenter() {
		getLscode();
		wwzService.flow(custid, "dating_personalcenter");
		String datingid=Struts2Utils.getParameter("datingid");
		Struts2Utils.getRequest().setAttribute("datingid",datingid);
		Struts2Utils.getRequest().setAttribute("custid",custid); 
		WxToken token=GetAllFunc.wxtoken.get(custid); 
		 if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 }
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/dating!personalcenter.action?custid="+custid;  
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
		DBObject  db=baseDao.getMessage(PubConstants.SUC_DATING, fromUserid);
		if(db==null){
			return webadd();
		}else{
			db.put("no", wwzService.getVipNo(fromUserid));
			if(db.get("endMemberDate")!=null){
				String endMemberDate=db.get("endMemberDate").toString();
				if(DateUtil.checkbig(DateFormat.getFormat(endMemberDate))){
					db.put("member",1);//会员有效
				}else{
					db.put("member",2);//会员失效
				}
				
			}   
			Struts2Utils.getRequest().setAttribute("entity", db); 
		}
		Struts2Utils.getRequest().setAttribute("reading", wwzService.getFlow(custid, "dating_personalcenter")); 
		DBObject share=wwzService.getShareFx(custid,"dating_web");
		if(share==null){
			share=new BasicDBObject(); 
		} 
		share.put("fxurl",SysConfig.getProperty("ip")+"/suc/dating!web.action?custid="+custid+"&datingid="+wwzService.getVipNo(fromUserid));
		Struts2Utils.getRequest().setAttribute("share", share); 
		Struts2Utils.getRequest().setAttribute("slide",wwzService.getslide(custid, "dating_personalcenter"));
		Struts2Utils.getRequest().setAttribute("uncount",getunfind(fromUserid));
		Struts2Utils.getRequest().setAttribute("con",baseDao.getMessage(PubConstants.SUC_DATINGCONDITION, fromUserid)); 
		HashMap<String, Object>whereMap=new HashMap<>();
		whereMap.put("toUserid", fromUserid);
		whereMap.put("createdate", new BasicDBObject("$gte",DateUtil.addDay(new Date(), -7)));
		Struts2Utils.getRequest().setAttribute("foot",baseDao.getCount(PubConstants.SUC_DATINGFOOT, whereMap));
		Struts2Utils.getRequest().setAttribute("datingtype",4);  
		return "personalcenter";

	}
	/**
	 * 获取列表
	 */
	public void  ajaxweb(){ 
		getLscode();
		String  fypage=Struts2Utils.getParameter("fypage");
		Map<String, Object> sub_map = new HashMap<String, Object>();
		try {
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			sortMap.put("createdate", -1);
			//whereMap.put("custid", custid);
			 
			String sex=Struts2Utils.getParameter("sex");
			if(StringUtils.isNotEmpty(sex)){
				whereMap.put("sex",Integer.parseInt(sex));
			}
			String  city=Struts2Utils.getParameter("city");
			if(StringUtils.isNotEmpty(city)){
				whereMap.put("city",city);
			}else {
				DBObject db=wwzService.getCustUser(custid);

				Pattern pattern = Pattern.compile("^.*" + db.get("city").toString() + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("city",pattern); 
			}
			String  province=Struts2Utils.getParameter("province");
			if(StringUtils.isNotEmpty(province)){
				whereMap.put("province",province);
			}
			String  income=Struts2Utils.getParameter("income");
			if(StringUtils.isNotEmpty(income)){
				whereMap.put("income",income);
			}
			String  record=Struts2Utils.getParameter("record");
			if(StringUtils.isNotEmpty(record)){
				whereMap.put("record",record);
			}
			String  professional=Struts2Utils.getParameter("professional");
			if(StringUtils.isNotEmpty(professional)){
				whereMap.put("professional",professional);
			}
			String agestart=Struts2Utils.getParameter("agestart");
			String ageend=Struts2Utils.getParameter("ageend");
			BasicDBObject ageCondition = new BasicDBObject();
			if(StringUtils.isNotEmpty(ageend)&&StringUtils.isNotEmpty(agestart)){
				ageCondition.append("$gte",Integer.parseInt(agestart));
				ageCondition.append("$lte",Integer.parseInt(ageend));
				whereMap.put("age",ageCondition);
			}
			if(StringUtils.isNotEmpty(ageend)&&StringUtils.isEmpty(agestart)){ 
				ageCondition.append("$lte",Integer.parseInt(ageend));
				whereMap.put("age",ageCondition);
			}
			if(StringUtils.isEmpty(ageend)&&StringUtils.isNotEmpty(agestart)){
				ageCondition.append("$gte",Integer.parseInt(agestart)); 
				whereMap.put("age",ageCondition);
			}
			 
			List<DBObject>list=baseDao.getList(PubConstants.SUC_DATING, whereMap,Integer.parseInt(fypage),10,sortMap);
            
			if(list.size()>0){
				sub_map.put("state", 0);
				String id=wwzService.getWxUsertype(fromUserid, "no"); 
				for (DBObject dbObject : list) {
					//String time=wwzService.getlogin(custid, dbObject.get("_id").toString()).toString();
					//if(StringUtils.isNotEmpty(time)){
						//dbObject.put("logindate", RelativeDate.format(DateFormat.getFormat(time), new Date()));	
					//}
					
					dbObject.put("msgState",getMsgState(id+","+dbObject.get("no"))); 
				}
				sub_map.put("list", list);
			} 
		} catch (Exception e) {
			// TODO Auto-generated catch block 
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		 
	}
	/**
	 * 获取附近列表
	 */
	public void  ajaxnear(){ 
		getLscode();
		String  fypage=Struts2Utils.getParameter("fypage");
		Map<String, Object> sub_map = new HashMap<String, Object>();
		try {
			//获取用户位置
			DBObject  db=baseDao.getMessage(PubConstants.PUB_LOCATION,fromUserid);
			if(db!=null){
				HashMap<String, Object>whereMap=new HashMap<String, Object>();
				HashMap<String, Object>sortMap=new HashMap<String, Object>(); 
				int  scope=1;
				if(StringUtils.isNotEmpty(Struts2Utils.getParameter("scope"))){
					scope=Integer.parseInt(Struts2Utils.getParameter("scope"));
				}
				//whereMap.put("custid", custid); 
				Pattern pattern = Pattern.compile(db.get("geohash").toString().substring(0, scope) + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("geohash", pattern);
				List<DBObject>list=baseDao.getList(PubConstants.PUB_LOCATION, whereMap,Integer.parseInt(fypage),20,sortMap);
				int  num=0;
				if(list.size()>0){
					sub_map.put("state", 0);
					String id=wwzService.getWxUsertype(fromUserid, "no"); 
					for (DBObject dbObject : list) { 
						dbObject.put("distance",BaseDecimal.mToKm(getDistance(db,dbObject.get("_id").toString())));
						DBObject  dating=baseDao.getMessage(PubConstants.SUC_DATING, dbObject.get("_id").toString()); 
						if(dating!=null){
							num++;
							dating.put("msgState",getMsgState(id+","+dating.get("no"))); 
							if(StringUtils.isNotEmpty(wwzService.getlogin(custid, dating.get("_id").toString()).toString())){
								dating.put("logindate", RelativeDate.format(DateFormat.getFormat(wwzService.getlogin(custid, dating.get("_id").toString()).toString()), new Date()));  	
							} 
							dbObject.put("dating",dating);
						}
					}   
					if(num<20){
						List<DBObject>listnew=getServiceNear(20-num,id); 
						if(listnew.size()>0){
							for (DBObject dbObject : listnew) {
								   list.add(dbObject);	
								}
						}
						
					}
					sub_map.put("list", list);
				} 
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block 
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		 
	}
	/**
	 * 手机添加页面  
	 * @return
	 */
	public String  webadd(){
		getLscode(); 
		String datingid=Struts2Utils.getParameter("datingid");
		Struts2Utils.getRequest().setAttribute("datingid",datingid);
		Struts2Utils.getRequest().setAttribute("custid",custid); 
		WxToken token=GetAllFunc.wxtoken.get(custid); 
		 if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 }
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/dating!webadd.action?custid="+custid;  
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
		 
		Struts2Utils.getRequest().setAttribute("reading", wwzService.getFlow(custid, "dating_near")); 
		DBObject share=wwzService.getShareFx(custid,"dating_web");
		if(share==null){
			share=new BasicDBObject(); 
		} 
		share.put("fxurl",SysConfig.getProperty("ip")+"/suc/dating!web.action?custid="+custid+"&datingid="+wwzService.getVipNo(fromUserid));
		Struts2Utils.getRequest().setAttribute("share", share);
		DBObject  db=baseDao.getMessage(PubConstants.SUC_DATING, fromUserid);
		Struts2Utils.getRequest().setAttribute("uncount",getunfind(fromUserid));
		if(db!=null){
			Struts2Utils.getRequest().setAttribute("entity", db);
		}
		return "webadd";
		
	}
	/**
	 * 详情页面  
	 * @return
	 */
	public String  detail(){
		getLscode(); 
		String datingid=Struts2Utils.getParameter("datingid");
		Struts2Utils.getRequest().setAttribute("datingid",datingid);
		Struts2Utils.getRequest().setAttribute("custid",custid); 
		String  id=Struts2Utils.getParameter("id");
		WxToken token=GetAllFunc.wxtoken.get(custid); 
		 if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 }
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/dating!near.action?custid="+custid+"&id="+id;  
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
		 
		Struts2Utils.getRequest().setAttribute("reading", wwzService.getFlow(custid, "dating_near")); 
		DBObject share=wwzService.getShareFx(custid,"dating_web");
		if(share==null){
			share=new BasicDBObject(); 
		} 
		share.put("fxurl",SysConfig.getProperty("ip")+"/suc/dating!web.action?custid="+custid+"&datingid="+wwzService.getVipNo(fromUserid));
		Struts2Utils.getRequest().setAttribute("share", share);
		
		Struts2Utils.getRequest().setAttribute("uncount",getunfind(fromUserid));
		if(StringUtils.isNotEmpty(id)){
			DBObject  db=baseDao.getMessage(PubConstants.SUC_DATING, id);
			if(db!=null){
				if(db.get("endMemberDate")!=null){
					String endMemberDate=db.get("endMemberDate").toString();
					if(DateUtil.checkbig(DateFormat.getFormat(endMemberDate))){
						db.put("member",1);//会员有效
					}else{
						db.put("member",2);//会员失效
					}
					
				}else{
					db.put("member",0);
				}
				DBObject dats=baseDao.getMessage(PubConstants.SUC_DATINGSERVICETRUMPET, id);
				if(dats!=null){
					DBObject usercust=wwzService.getCustUser(custid);
					db.put("province", usercust.get("province"));
					db.put("city", usercust.get("city"));
				}
				
				Struts2Utils.getRequest().setAttribute("entity", db);
				HashMap<String, Object>whereMap=new HashMap<>();
				whereMap.put("fromUserid",id);
				HashMap<String, Object>sortMap=new HashMap<>();
				sortMap.put("createdate",-1);
				List<DBObject>list=baseDao.getList(PubConstants.SUC_DATINGPHOTO, whereMap,0,4,sortMap);
				 
				if(list.size()>0){  
					Struts2Utils.getRequest().setAttribute("photo",list);	
				}
			} 
		} 
		DBObject  user=baseDao.getMessage(PubConstants.SUC_DATING, fromUserid);
		int member=0;
		if(user!=null){
			Struts2Utils.getRequest().setAttribute("username",user.get("nickname"));
			if(user.get("endMemberDate")!=null){
				String endMemberDate=user.get("endMemberDate").toString();
				if(DateUtil.checkbig(DateFormat.getFormat(endMemberDate))){
					member=1;//会员有效
				}else{
					 
				}
				
			} 
		} 
		
		Struts2Utils.getRequest().setAttribute("member", member);
		return "detail"; 
	}
	/**
	 * 手机添加
	 */
	public void  ajaxwebadd(){ 
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		try { 
			String  city=Struts2Utils.getParameter("city");
			String  nickname=Struts2Utils.getParameter("nickname");
			String  concept=Struts2Utils.getParameter("concept"); 
			String  constellation=Struts2Utils.getParameter("constellation");
			String  firstmeet=Struts2Utils.getParameter("firstmeet"); 
			String  height=Struts2Utils.getParameter("height");
			String  income=Struts2Utils.getParameter("income");
			String  likeDatingSite=Struts2Utils.getParameter("likeDatingSite");
			String  wx=Struts2Utils.getParameter("wx");
			String  weight=Struts2Utils.getParameter("weight");
			String  tel=Struts2Utils.getParameter("tel");
			String  record=Struts2Utils.getParameter("record");
			String  qq=Struts2Utils.getParameter("qq");
			String  purpose=Struts2Utils.getParameter("purpose");
			String  province=Struts2Utils.getParameter("province");
			String  professional=Struts2Utils.getParameter("professional");
			String  marriage=Struts2Utils.getParameter("marriage");
			String  sex=Struts2Utils.getParameter("sex");
			String  age=Struts2Utils.getParameter("age");
			String  birthday=Struts2Utils.getParameter("birthday");
			String  county=Struts2Utils.getParameter("county");
			String  qqState=Struts2Utils.getParameter("qqState");
			String  wxState=Struts2Utils.getParameter("telState");
			String  telState=Struts2Utils.getParameter("telState");
			DBObject  user=wwzService.getWxUser(fromUserid);
			DBObject  dat=baseDao.getMessage(PubConstants.SUC_DATING, fromUserid);
			DatingInfo  obj=null; 
			if(dat!=null){
				obj=(DatingInfo) UniObject.DBObjectToObject(dat, DatingInfo.class);
			}else{
				obj=new DatingInfo(); 	
			} 
			obj.set_id(fromUserid);
			obj.setCustid(custid); 
			obj.setNo(user.get("no").toString());
			if(StringUtils.isNotEmpty(nickname)){
				obj.setNickname(nickname);
			}
			if(StringUtils.isNotEmpty(birthday)){ 
				obj.setBirthday(birthday);
			} 
			if(StringUtils.isNotEmpty(city)){
				obj.setCity(city);
			}
			if(StringUtils.isNotEmpty(concept)){
				obj.setConcept(concept);
			}
			if(StringUtils.isNotEmpty(constellation)){
				obj.setConstellation(constellation);
			} 
			obj.setCreatedate(new Date());
			if(StringUtils.isNotEmpty(firstmeet)){
				obj.setFirstmeet(firstmeet);
			}   
			if(StringUtils.isNotEmpty(height)){
				obj.setHeight(Integer.parseInt(height));
			}
			if(StringUtils.isNotEmpty(income)){
				obj.setIncome(Integer.parseInt(income));
			}
			if(StringUtils.isNotEmpty(likeDatingSite)){
				obj.setLikeDatingSite(likeDatingSite);
			}
			if(StringUtils.isNotEmpty(wx)){
				obj.setWx(wx);
			}
			if(StringUtils.isNotEmpty(weight)){
				obj.setWeight(Integer.parseInt(weight));
			}
			if(StringUtils.isNotEmpty(tel)){
				obj.setTel(tel);	
			}
			if(StringUtils.isNotEmpty(record)){
				obj.setRecord(Integer.parseInt(record));	
			}
			if(StringUtils.isNotEmpty(qq)){
				obj.setQq(qq);	
			}
			if(StringUtils.isNotEmpty(purpose)){
				obj.setPurpose(purpose);
			}
			if(StringUtils.isNotEmpty(province)){
				obj.setProvince(province);	
			}
			if(StringUtils.isNotEmpty(professional)){
				obj.setProfessional(professional);
			} 
			if(StringUtils.isNotEmpty(marriage)){
				obj.setMarriage(Integer.parseInt(marriage));
			}
			if(StringUtils.isNotEmpty(sex)){
				obj.setSex(Integer.parseInt(sex));
			}
			if(StringUtils.isNotEmpty(age)){
				obj.setAge(Integer.parseInt(age));
			}
			if(StringUtils.isNotEmpty(county)){
				obj.setCounty(county);
			}
			if(StringUtils.isNotEmpty(qqState)){
				obj.setQqState(Integer.parseInt(qqState));
			}
			if(StringUtils.isNotEmpty(wxState)){
				obj.setWxState(Integer.parseInt(wxState));
			}
			if(StringUtils.isNotEmpty(telState)){
				obj.setTelState(Integer.parseInt(telState));
			}
			obj.setCreatedate(new Date());
			baseDao.insert(PubConstants.SUC_DATING, obj);
			
			if(obj.getAge()>0&&StringUtils.isNotEmpty(obj.getBirthday())&&obj.getHeight()>0&&obj.getWeight()>0&&obj.getIncome()>0&&obj.getSex()>0&&obj.getRecord()>0){
				if(StringUtils.isNotEmpty(obj.getTel())&&StringUtils.isNotEmpty(obj.getProvince())&&StringUtils.isNotEmpty(obj.getCity())){
					updateStar(1, "资料完成度达到90%");
				}
			}
			sub_map.put("state", 0);
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block 
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * 记录足迹
	 */
	public void  saveFoot(){
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		String id=Struts2Utils.getParameter("id");
		String content=Struts2Utils.getParameter("content");
		if(StringUtils.isNotEmpty(id)&&!id.equals(fromUserid)){
			DBObject user=wwzService.getWxUser(fromUserid);
			DatingFoot foot=new DatingFoot();
			foot.set_id(id+"-"+user.get("no"));
			foot.setToUserid(id);
			foot.setFromUserid(fromUserid);
			foot.setCreatedate(new Date());
			
			foot.setHeadimgurl(user.get("headimgurl").toString());
			foot.setNickname(user.get("nickname").toString());
			if(StringUtils.isNotEmpty(content)){
				foot.setContent(content);
			}
			baseDao.insert(PubConstants.SUC_DATINGFOOT, foot);
			sub_map.put("state", 0);
		}
		String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 足迹
	 * @return
	 */
	public String  foot(){
		getLscode();
		String datingid=Struts2Utils.getParameter("datingid");
		Struts2Utils.getRequest().setAttribute("datingid",datingid);
		Struts2Utils.getRequest().setAttribute("custid",custid); 
		WxToken token=GetAllFunc.wxtoken.get(custid); 
		 if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 }
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/dating!foot.action?custid="+custid;  
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
		 
		Struts2Utils.getRequest().setAttribute("reading", wwzService.getFlow(custid, "dating_near")); 
		DBObject share=wwzService.getShareFx(custid,"dating_web");
		if(share==null){
			share=new BasicDBObject(); 
		} 
		share.put("fxurl",SysConfig.getProperty("ip")+"/suc/dating!web.action?custid="+custid+"&datingid="+wwzService.getVipNo(fromUserid));
		Struts2Utils.getRequest().setAttribute("share", share);
		Struts2Utils.getRequest().setAttribute("uncount",getunfind(fromUserid));
		HashMap<String, Object>whereMap=new HashMap<>();
		whereMap.put("toUserid", fromUserid);
		whereMap.put("createdate", new BasicDBObject("$gte",DateUtil.addDay(new Date(), -7)));
		Struts2Utils.getRequest().setAttribute("foot",baseDao.getCount(PubConstants.SUC_DATINGFOOT, whereMap));
		return "foot"; 
	}
	/**
	 * 获取足迹
	 */
	public void   ajaxfoot(){
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		HashMap<String, Object>whereMap=new HashMap<>();
		HashMap<String, Object>sortMap=new HashMap<>();
		whereMap.put("toUserid", fromUserid);
		//获取7天内所有记录
		whereMap.put("createdate", new BasicDBObject("$gte",DateUtil.addDay(new Date(), -7)));
		sortMap.put("createdate",-1);
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject>list=baseDao.getList(PubConstants.SUC_DATINGFOOT, whereMap,0,18,sortMap); 
		if(list.size()>0){
			sub_map.put("state", 0);
			sub_map.put("list",list);
		}
		String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 保存相册
	 */
	public  void  savePhoto(){
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		String picurl=Struts2Utils.getParameter("picurl");
		String title=Struts2Utils.getParameter("title");  
		if(StringUtils.isNotEmpty(picurl)){
			DatingAudit audit=new DatingAudit();
			audit.set_id(mongoSequence.currval(PubConstants.SUC_DATINGAUDIT));
			audit.setContent(title);
			audit.setCustid(custid);
			audit.setFromUserid(fromUserid);
			audit.setPicurl(picurl);
			audit.setCreatedate(new Date());
			audit.setType(1);
			baseDao.insert(PubConstants.SUC_DATINGAUDIT, audit);
			sub_map.put("state", 0);
		}
		String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 相册
	 * @return
	 */
	public String photo(){
		getLscode();
		String datingid=Struts2Utils.getParameter("datingid");
		Struts2Utils.getRequest().setAttribute("datingid",datingid);
		Struts2Utils.getRequest().setAttribute("custid",custid); 
		WxToken token=GetAllFunc.wxtoken.get(custid); 
		 if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 }
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/dating!photo.action?custid="+custid;  
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
		 
		Struts2Utils.getRequest().setAttribute("reading", wwzService.getFlow(custid, "dating_near")); 
		DBObject share=wwzService.getShareFx(custid,"dating_web");
		if(share==null){
			share=new BasicDBObject(); 
		} 
		share.put("fxurl",SysConfig.getProperty("ip")+"/suc/dating!web.action?custid="+custid+"&datingid="+wwzService.getVipNo(fromUserid));
		Struts2Utils.getRequest().setAttribute("share", share);
		return "photo";
	}
	/**
	 * 获取相册
	 */
	public void  ajaxPhoto(){
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		HashMap<String, Object>whereMap=new HashMap<>();
		HashMap<String, Object>sortMap=new HashMap<>();
		whereMap.put("fromUserid", fromUserid);
		sortMap.put("createdate",-1);
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject>list=baseDao.getList(PubConstants.SUC_DATINGPHOTO, whereMap,fypage,18,sortMap);
		if(list.size()>0){
			if(list.size()>4){
				updateStar(1,"上传本人四张照片"); 
			}
			sub_map.put("state", 0);
			sub_map.put("list",list);
		}
		String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * 婚恋条件
	 * @return
	 */
	public String condition(){
		getLscode();
		String datingid=Struts2Utils.getParameter("datingid");
		Struts2Utils.getRequest().setAttribute("datingid",datingid);
		Struts2Utils.getRequest().setAttribute("custid",custid); 
		WxToken token=GetAllFunc.wxtoken.get(custid); 
		 if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 }
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/dating!condition.action?custid="+custid;  
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
		 
		Struts2Utils.getRequest().setAttribute("reading", wwzService.getFlow(custid, "dating_near")); 
		DBObject share=wwzService.getShareFx(custid,"dating_web");
		if(share==null){
			share=new BasicDBObject(); 
		} 
		share.put("fxurl",SysConfig.getProperty("ip")+"/suc/dating!web.action?custid="+custid+"&datingid="+wwzService.getVipNo(fromUserid));
		Struts2Utils.getRequest().setAttribute("share", share);
		DBObject  db=baseDao.getMessage(PubConstants.SUC_DATINGCONDITION,fromUserid);
		if(db!=null){
			Struts2Utils.getRequest().setAttribute("entity",db);
		}
		return "condition";
	}
	/**
	 * 保存条件
	 */
	public void  saveCondition(){
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		DatingCondition  condition=null;
		DBObject  db=baseDao.getMessage(PubConstants.SUC_DATINGCONDITION, fromUserid);
		if(db!=null){
			condition=(DatingCondition) UniObject.DBObjectToObject(db, DatingCondition.class);
		}else{
			condition=new DatingCondition();
			condition.set_id(fromUserid);
		}
		String startAge=Struts2Utils.getParameter("startAge");
		String endAge=Struts2Utils.getParameter("endAge");
		String startHeight=Struts2Utils.getParameter("startHeight");
		String endHeight=Struts2Utils.getParameter("endHeight");
		String record=Struts2Utils.getParameter("record");
		String income=Struts2Utils.getParameter("income"); 
		String county=Struts2Utils.getParameter("county");
		String province=Struts2Utils.getParameter("province");
		String city=Struts2Utils.getParameter("city"); 
		String sex=Struts2Utils.getParameter("sex"); 
		if(StringUtils.isNotEmpty(startAge)){
			condition.setStartAge(Integer.parseInt(startAge));
		}
		if(StringUtils.isNotEmpty(endAge)){
			condition.setEndAge(Integer.parseInt(endAge));
		}
		if(StringUtils.isNotEmpty(startHeight)){
			condition.setStartHeight(Integer.parseInt(startHeight));
		}
		if(StringUtils.isNotEmpty(endHeight)){
			condition.setEndHeight(Integer.parseInt(endHeight));
		}
		if(StringUtils.isNotEmpty(income)){
			condition.setIncome(Integer.parseInt(income));
		} 
		if(StringUtils.isNotEmpty(record)){
			condition.setRecord(Integer.parseInt(record));
		}
		if(StringUtils.isNotEmpty(province)){
			condition.setProvince(province);
		}
		if(StringUtils.isNotEmpty(city)){
			condition.setCity(city);
		}
		if(StringUtils.isNotEmpty(county)){
			condition.setCounty(county);
		}
		if(StringUtils.isNotEmpty(sex)){
			condition.setSex(Integer.parseInt(sex));
		}
		baseDao.insert(PubConstants.SUC_DATINGCONDITION, condition);
		sub_map.put("state", 0);
		String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	public  void  delReply(){
		HashMap<String, Object>whereMap=new HashMap<>();
		//baseDao.delete(PubConstants.SUC_DATINGSERVICETRUMPET);
		//baseDao.delete(PubConstants.SUC_DATINGSTATISTICAL, whereMap);
		//baseDao.delete(PubConstants.SUC_DATINGREWARD, whereMap); 
		//baseDao.delete(PubConstants.SUC_DATING);
		//baseDao.delete(PubConstants.SUC_DATINGPHOTO);
		baseDao.delete(PubConstants.ANDROID_REPLY);
		//baseDao.delete(PubConstants.ANDROID_MESSAGE);
	}
	/**
	 * 聊天界面
	 * @return
	 */
	public  String chat(){
		getLscode();
		String datingid=Struts2Utils.getParameter("datingid");
		Struts2Utils.getRequest().setAttribute("datingid",datingid);
		String id=Struts2Utils.getParameter("id"); 
		Struts2Utils.getRequest().setAttribute("custid",custid); 
		WxToken token=GetAllFunc.wxtoken.get(custid); 
		 if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 }
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/dating!chat.action?custid="+custid+"&id="+id;  
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
		 
		Struts2Utils.getRequest().setAttribute("reading", wwzService.getFlow(custid, "dating_near")); 
		DBObject share=wwzService.getShareFx(custid,"dating_web");
		if(share==null){
			share=new BasicDBObject(); 
		} 
		share.put("fxurl",SysConfig.getProperty("ip")+"/suc/dating!web.action?custid="+custid+"&datingid="+wwzService.getVipNo(fromUserid));
		Struts2Utils.getRequest().setAttribute("share", share);
		if(StringUtils.isNotEmpty(id)){
			Struts2Utils.getRequest().setAttribute("custid",custid);
			String no=wwzService.getVipNo(fromUserid);
			Struts2Utils.getRequest().setAttribute("no",no);
			HashMap<String,Object>whereMap=new HashMap<>();
			whereMap.put("no",id);
			DBObject  db=baseDao.getMessage(PubConstants.SUC_DATING, whereMap);
			Struts2Utils.getRequest().setAttribute("nickname",db.get("nickname"));
			DBObject fromUser=wwzService.getWxUser(fromUserid);
			Struts2Utils.getRequest().setAttribute("headimgurl",fromUser.get("headimgurl"));
			Struts2Utils.getRequest().setAttribute("fromNickname",fromUser.get("nickname"));
			Struts2Utils.getRequest().setAttribute("id",id); 
		}
		
		return "chat";
	}
	/**
	 * 聊天界面
	 * @return
	 */
	public  String chatDetail(){
		getLscode();
		String datingid=Struts2Utils.getParameter("datingid");
		Struts2Utils.getRequest().setAttribute("datingid",datingid);
		String rid=Struts2Utils.getParameter("rid"); 
		Struts2Utils.getRequest().setAttribute("custid",custid); 
		WxToken token=GetAllFunc.wxtoken.get(custid); 
		 if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 }
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/dating!chatDetail.action?custid="+custid+"&rid="+rid;  
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
		 
		Struts2Utils.getRequest().setAttribute("reading", wwzService.getFlow(custid, "dating_near")); 
		DBObject share=wwzService.getShareFx(custid,"dating_web");
		if(share==null){
			share=new BasicDBObject(); 
		} 
		share.put("fxurl",SysConfig.getProperty("ip")+"/suc/dating!web.action?custid="+custid+"&datingid="+wwzService.getVipNo(fromUserid));
		Struts2Utils.getRequest().setAttribute("share", share);
		if(StringUtils.isNotEmpty(rid)){
			Struts2Utils.getRequest().setAttribute("custid",custid);
			String no=wwzService.getVipNo(fromUserid);
			DBObject  db=baseDao.getMessage(PubConstants.ANDROID_REPLY, Long.parseLong(rid));
			if(db!=null){
				Struts2Utils.getRequest().setAttribute("no",no); 
				HashMap<String,Object>whereMap=new HashMap<>();
				whereMap.put("no",db.get("ids").toString().replace(no, "").replace(",", ""));
				DBObject  dat=baseDao.getMessage(PubConstants.SUC_DATING, whereMap);
				Struts2Utils.getRequest().setAttribute("nickname",dat.get("nickname")); ;
				DBObject fromUser=wwzService.getWxUser(fromUserid);
				Struts2Utils.getRequest().setAttribute("headimgurl",fromUser.get("headimgurl"));
				Struts2Utils.getRequest().setAttribute("fromNickname",fromUser.get("nickname"));
				Struts2Utils.getRequest().setAttribute("rid",rid); 
				Struts2Utils.getRequest().setAttribute("id",db.get("ids").toString().replace(no, "").replace(",", "")); 
			}
			
		}
		
		return "chat";
	}
	/**
	 * ajax获取消息列表
	 */
	public void  ajaxMsg(){
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		HashMap<String, Object>whereMap=new HashMap<>();
		HashMap<String, Object>sortMap=new HashMap<>();
		//whereMap.put("custid", custid); 
		whereMap.put("endmsg", new BasicDBObject("$ne",null));
		whereMap.put("endupdate", new BasicDBObject("$ne",null)); 
		Pattern pattern = Pattern.compile("^.*" + wwzService.getVipNo(fromUserid) + ".*$",
					Pattern.CASE_INSENSITIVE);
		whereMap.put("ids", pattern);
		sortMap.put("endupdate",-1);
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject>list=baseDao.getList(PubConstants.ANDROID_REPLY, whereMap,fypage,10,sortMap);  
		if(list.size()>0){
			sub_map.put("state", 0); 
			for (DBObject dbObject : list) {
				String ids=dbObject.get("ids").toString();
				ids=ids.replace(wwzService.getVipNo(fromUserid), "");
				ids=ids.replace(",","");
				if(ids.equals("")){
					DBObject user=wwzService.getWxUser(fromUserid);
					dbObject.put("headimgurl", user.get("headimgurl"));
					dbObject.put("nickname", user.get("nickname"));
					dbObject.put("endupdate",RelativeDate.format(DateFormat.getFormat(dbObject.get("endupdate").toString()), new Date()));
					dbObject.put("uncount", getunfind(dbObject.get("_id").toString(),fromUserid));
				}else{ 
					HashMap<String,Object>whereMaps=new HashMap<>();
					whereMaps.put("no",ids);
					DBObject  user=baseDao.getMessage(PubConstants.SUC_DATING, whereMaps);
					if(user!=null){
						dbObject.put("headimgurl", user.get("headimgurl"));
						dbObject.put("nickname", user.get("nickname"));
						dbObject.put("endupdate",RelativeDate.format(DateFormat.getFormat(dbObject.get("endupdate").toString()), new Date()));
						dbObject.put("uncount", getunfind(dbObject.get("_id").toString(),fromUserid));
					} 
				}
				
			}
			sub_map.put("list",list);
		}
		String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 获取会话未读信息
	 * @return
	 */
	public  int  getunfind(String rid,String fromUserid){
		DBObject db=baseDao.getMessage(PubConstants.ANDROID_REPLYUNFIND, rid+"-"+fromUserid);
		if(db!=null){
			return Integer.parseInt(db.get("count").toString());
		}
		return 0; 
	} 
	/**
	 * 获取全部未读信息
	 * @return
	 */
	public  Long  getunfind(String fromUserid){
		HashMap<String, Object>whereMap=new HashMap<>();
		whereMap.put("fromUserid",fromUserid);
		Long count=0L;
		List<DBObject>list=baseDao.getList(PubConstants.ANDROID_REPLYUNFIND, whereMap, null);
		for (DBObject dbObject : list) {
			if(dbObject.get("count")!=null){
				count+=Long.parseLong(dbObject.get("count").toString());
			}
		}
		if(count>0){
			return count;
		}
		return 0L; 
	}
	/**
	 * 获取全部未读信息
	 * @return
	 */
	public  void  getUnfinds(){
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		HashMap<String, Object>whereMap=new HashMap<>();
		whereMap.put("fromUserid",fromUserid);
		Long count=0L;
		List<DBObject>list=baseDao.getList(PubConstants.ANDROID_REPLYUNFIND, whereMap, null);
		for (DBObject dbObject : list) {
			if(dbObject.get("count")!=null){
				count+=Long.parseLong(dbObject.get("count").toString());
			}
		}  
		sub_map.put("value",count);  
		String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		 
	}
	/**
	 * 保存位置
	 */
	public  void  saveLoc(){
		getLscode();
		String lat=Struts2Utils.getParameter("lat");
		String lon=Struts2Utils.getParameter("lon");
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		if(StringUtils.isNotEmpty(lat)&&StringUtils.isNotEmpty(lon)){
			try {
				Location  loc=new Location();
				loc.set_id(fromUserid);
				loc.setCustid(custid);
				loc.setGeohash(Geohash.encode(Double.parseDouble(lat),Double.parseDouble(lon)));
				loc.setLatitude(Double.parseDouble(lat));
				loc.setLongitude(Double.parseDouble(lon));
				loc.setCreatedate(new Date());
				baseDao.insert(PubConstants.PUB_LOCATION, loc);
				sub_map.put("value", 0);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} 
		String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		 
	}
	/**
	 * 计算当前用户和某用户的距离
	 * @param id用户ID
	 * @return返回距离 单位：米 
	 */
	public  double  getDistance(DBObject u_loc,String id){
		DBObject  a_loc=baseDao.getMessage(PubConstants.PUB_LOCATION, id); 
		if(a_loc!=null&&a_loc.get("longitude")!=null&&a_loc.get("latitude")!=null){  
			return BaseDecimal.Distance(Double.parseDouble(a_loc.get("longitude").toString()), Double.parseDouble(a_loc.get("latitude").toString()),Double.parseDouble(u_loc.get("longitude").toString()), Double.parseDouble(u_loc.get("latitude").toString()));
			
		}
		return 0; 
	}
	 
	/**
	 * 金币充值
	 * @throws Exception
	 */
	 public void wxpayGold() throws Exception{
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
			//获取提交的商品名称
			String remark = Struts2Utils.getParameter("remark");
			//支付类型
			String type = Struts2Utils.getParameter("type");
			//时间
			String time = Struts2Utils.getParameter("time");
			//四位随机数
			String strRandom = TenpayUtil.buildRandom(4) + "";
			 
			 
			String orderno = DateFormat.getDate() + strRandom+mongoSequence.currval(PubConstants.SUC_DATINGORDER);
			DatingOrder  order  =new DatingOrder();
			order.set_id(orderno);
			order.setCreatedate(new Date());	
	    	order.setCustid(custid);
	    	order.setFromUserid(fromUserid);
	    	if(StringUtils.isNotEmpty(price)){
	    		order.setMoney(Double.parseDouble(price));
	    	}
	    	order.setContent(remark);
	    	order.setState(0);
	    	if(StringUtils.isNotEmpty(type)){
	    		order.setType(Integer.parseInt(type));
	    	}
	    	if(StringUtils.isNotEmpty(time)){
	    		order.setTime(Integer.parseInt(time));
	    	}
	    	baseDao.insert(PubConstants.SUC_DATINGORDER, order);
	    	 
			StringBuffer attach=new StringBuffer(orderno);//0
			attach.append("&").append(custid);// 
			attach.append("&").append(fromUserid); 
		 
			String nonce_str=PayCommonUtil.CreateNoncestr();
			SortedMap<Object,Object> parameters = new TreeMap<Object,Object>();
			parameters.put("appid", wxconfig.getAppid()); 
			parameters.put("mch_id", wxconfig.getPartner());
			parameters.put("nonce_str", nonce_str);
			parameters.put("attach", attach.toString());
			parameters.put("body", remark); 
			parameters.put("is_subscribe", "Y");
			parameters.put("out_trade_no", orderno);
			parameters.put("total_fee", BaseDecimal.round(BaseDecimal.multiplication(price, "100"),0));
			parameters.put("spbill_create_ip",Struts2Utils.getRequest().getRemoteAddr());
			parameters.put("notify_url", this.getCtxurl()+"/suc/dating!payokGold.action");
			parameters.put("trade_type", "JSAPI");
			parameters.put("openid", wwzService.getWxUser(fromUserid).get("fromUser").toString());


			String sign = PayCommonUtil.createSign("UTF-8", parameters,wxconfig.getPartner_key());
			parameters.put("sign", sign);
			String requestXML = PayCommonUtil.getRequestXml(parameters);
			
			String result =CommonUtil.httpsRequest("https://api.mch.weixin.qq.com/pay/unifiedorder", "POST", requestXML);
			
			Map<String, String> map = XMLUtil.doXMLParse(result);


		    params.put("appId", wxconfig.getAppid());
		    params.put("timeStamp", Long.toString(new Date().getTime()));
		    params.put("nonceStr",nonce_str);
		    params.put("package", "prepay_id="+map.get("prepay_id"));
		    params.put("signType", "MD5");
		    String paySign =  PayCommonUtil.createSign("UTF-8", params,wxconfig.getPartner_key());
		    params.put("packageValue", "prepay_id="+map.get("prepay_id"));    //这里用packageValue是预防package是关键字在js获取值出错
		    params.put("paySign", paySign);
		    
		    params.put("state", 0);
		  
		    params.put("orderno", orderno);
			String json = JSONArray.fromObject(params).toString();
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		}
		
		/**
		 * 金币充值通知
		 * @throws Exception
		 */
	  public void payokGold() throws Exception{ 
			InputStream inStream = Struts2Utils.getRequest().getInputStream();
	        ByteArrayOutputStream outSteam = new ByteArrayOutputStream();
	        byte[] buffer = new byte[1024];
	        int len = 0;
	        while ((len = inStream.read(buffer)) != -1) {
	            outSteam.write(buffer, 0, len);
	        }
	       
	        outSteam.close();
	        inStream.close();
	        String result  = new String(outSteam.toByteArray(),"utf-8");
	     
	        Map<Object, Object> map = XMLUtil.doXMLParse(result);
	        String return_code=map.get("return_code").toString();
	       
	        if(return_code.equals("SUCCESS")){ 
	        	fromUser=map.get("openid").toString(); //推送信息时用到
	        	String[] attach=map.get("attach").toString().split("&");
	        	String orderno=attach[0];
	        	String custid=attach[1];  
	        	String fromUserid=attach[2]; 
	        	//更新订单
	        	DBObject orderdb=baseDao.getMessage(PubConstants.SUC_DATINGORDER, orderno);
	        	DatingOrder entity = (DatingOrder)UniObject.DBObjectToObject(orderdb,DatingOrder.class); 
	        	entity.set_id(orderno);
	        	entity.setState(1);//
	        	baseDao.insert(PubConstants.SUC_DATINGORDER, entity);
	        	if(entity.getType()==0){
	        		//金币充值
	        		UpdateGold(fromUserid, custid, entity.getMoney(), 0, "金币充值");
	        		
	        	}else if(entity.getType()==1){
	        		//会员充值
	        		addMember(fromUserid, custid, entity.getMoney(),entity.getTime());
	        	} 
	        	
	        	Struts2Utils.getResponse().getWriter().write(PayCommonUtil.setXML("SUCCESS", ""));
	        	
	        }else{
	        	Struts2Utils.getResponse().getWriter().write(PayCommonUtil.setXML("SUCCESS", ""));
	        }
	      
		} 
	  /**
	   * 更新金币
	   */
	  public  boolean   UpdateGold(String fromUserid,String custid,double price,int type,String content){
		  DatingGold gold=new DatingGold();
		  gold.set_id(mongoSequence.currval(PubConstants.SUC_DATINGGOLD));
		  gold.setContent(content);
		  gold.setCreatedate(new Date());
		  gold.setCustid(custid);
		  gold.setFromUserid(fromUserid);
		  gold.setMoney(price*100);
		  gold.setType(type);
		  baseDao.insert(PubConstants.SUC_DATINGGOLD, gold);
		  DBObject  db=baseDao.getMessage(PubConstants.SUC_DATING, fromUserid);
		  if(db!=null){
			  DatingInfo info=(DatingInfo) UniObject.DBObjectToObject(db, DatingInfo.class);
			  info.set_id(fromUserid); 
			  if(type==0){ 
				  info.setMoney(info.getMoney()+price*100);
				  //增加
			  }else if(type==1){
				  //消费 
				  if(info.getMoney()-price>0){
					  info.setMoney(info.getMoney()-price);  
				  }else{
					  return false;
				  }
				  
			  }
			  baseDao.insert(PubConstants.SUC_DATING, info);
			  return true;
		  }
		return false;
		 
	  }
	  /**
	   * 充值会员
	   * @param fromUserid
	   * @param custid
	   * @param price
	   * @param time（单位天）
	   * @return
	   */
	  public  boolean   addMember(String fromUserid,String custid,double price,int time){
		  DatingMember member=new DatingMember();
		  member.set_id(mongoSequence.currval(PubConstants.SUC_DATINGMEMEBER));
		  member.setCreatedate(new Date());
		  member.setCustid(custid);
		  member.setFromUserid(fromUserid);
		  member.setMoney(price);
		  Calendar cal = Calendar.getInstance();
		  cal.add(Calendar.DATE,+time); 
		  member.setStartdate(new Date());
		  member.setEnddate(cal.getTime());
		  baseDao.insert(PubConstants.SUC_DATINGMEMEBER, member);
		  DBObject  db=baseDao.getMessage(PubConstants.SUC_DATING, fromUserid);
		  if(db!=null){
			  DatingInfo info=(DatingInfo) UniObject.DBObjectToObject(db, DatingInfo.class);
			  if(info.getEndMemberDate()!=null){
				  cal.setTime(info.getEndMemberDate());
				  cal.add(Calendar.DATE,time); 
				  info.setEndMemberDate(cal.getTime());  
			  }else{
				  info.setEndMemberDate(cal.getTime());   
			  } 
			  baseDao.insert(PubConstants.SUC_DATING, info);
			  return true;
		  }
		return false;
		  
	  }
	  /**
	   * 充值会员
	   * @param fromUserid
	   * @param custid
	   * @param content
	   * @param time（单位小时）
	   * @return
	   */
	  public  boolean   addMember(String fromUserid,String custid,String  content,int time){
		  DatingMember member=new DatingMember();
		  member.set_id(mongoSequence.currval(PubConstants.SUC_DATINGMEMEBER));
		  member.setCreatedate(new Date());
		  member.setCustid(custid);
		  member.setFromUserid(fromUserid);
		  member.setContent(content);
		  member.setMoney(0);
		  Calendar cal = Calendar.getInstance();
		  cal.add(Calendar.HOUR,+time); 
		  member.setStartdate(new Date());
		  member.setEnddate(cal.getTime());
		  baseDao.insert(PubConstants.SUC_DATINGMEMEBER, member);
		  DBObject  db=baseDao.getMessage(PubConstants.SUC_DATING, fromUserid);
		  if(db!=null){
			  DatingInfo info=(DatingInfo) UniObject.DBObjectToObject(db, DatingInfo.class);
			  if(info.getEndMemberDate()!=null){
				  cal.setTime(info.getEndMemberDate());
				  cal.add(Calendar.HOUR,time); 
				  info.setEndMemberDate(cal.getTime());  
			  }else{
				  info.setEndMemberDate(cal.getTime());   
			  } 
			  baseDao.insert(PubConstants.SUC_DATING, info);
			  return true;
		  }
		return false;
		  
	  }
	  /**
	   * 充值页面
	   * @return
	   */
	  public String recharge(){
		  getLscode();
		  String datingid=Struts2Utils.getParameter("datingid");
		  Struts2Utils.getRequest().setAttribute("datingid",datingid);
		  Struts2Utils.getRequest().setAttribute("custid",custid); 
			WxToken token=GetAllFunc.wxtoken.get(custid); 
			 if(token.getSqlx()>0){
				 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
			 }
			Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
			token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
			String  url=SysConfig.getProperty("ip")+"/suc/dating!recharge.action?custid="+custid;  
			if(StringUtils.isEmpty(fromUserid)){ 
				String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
				Struts2Utils.getRequest().setAttribute("inspection",inspection);  
				return "refresh";
			}else if(fromUserid.equals("register")){ 
				String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
				Struts2Utils.getRequest().setAttribute("inspection",inspection);  
				return "refresh";
			}  
			 
			Struts2Utils.getRequest().setAttribute("reading", wwzService.getFlow(custid, "dating_near")); 
			DBObject share=wwzService.getShareFx(custid,"dating_web");
			if(share==null){
				share=new BasicDBObject(); 
			} 
			share.put("fxurl",SysConfig.getProperty("ip")+"/suc/dating!web.action?custid="+custid+"&datingid="+wwzService.getVipNo(fromUserid));
			Struts2Utils.getRequest().setAttribute("share", share);
		return "recharge";   
	  }
	  /**
	   * 获取消息更新状态
	   * @return
	   */
	  public  int  getMsgState(String ids){ 
		  if(StringUtils.isNotEmpty(ids)){
			  HashMap<String, Object>whereMap=new HashMap<>();
			  BasicDBList   dblist=new BasicDBList(); 
			  dblist.add(new BasicDBObject("ids",ids));
			  dblist.add(new BasicDBObject("ids",ids.split(",")[1]+","+ids.split(",")[0]));
			  //or判断
			  whereMap.put("$or", dblist);   
			  whereMap.put("custid",custid);
			  List<DBObject>list=baseDao.getList(PubConstants.ANDROID_REPLY, whereMap, null); 
			  if(list.size()>0){
				  DBObject db=list.get(0); 
				  if(db.get("endupdate")!=null){
					  
					  String endupdate=db.get("endupdate").toString(); 
					  if(DateUtil.checkbig(DateUtil.addHour(DateFormat.getFormat(endupdate),24))){
						  //已打招呼
						  return 1;
					  }
				  }
			  }
		  }
		return 0;   
	  }
	  /**
	   * 自动注册
	   * @return
	   */
	  public  boolean   register(){
		  DBObject dbObject =baseDao.getMessage(PubConstants.SUC_DATING, fromUserid);
		  if(dbObject==null){
			  DBObject  wxuser=wwzService.getWxUser(fromUserid);
			  DatingInfo info=new DatingInfo();
			  info.set_id(fromUserid);
			  info.setCustid(custid);
			  if(wxuser.get("sex")!=null){
				  info.setSex(Integer.parseInt(wxuser.get("sex").toString()));
			  }
			  if(wxuser.get("city")!=null){
				  info.setCity(wxuser.get("city").toString());
			  }if(wxuser.get("province")!=null){
				  info.setProvince(wxuser.get("province").toString());
			  }
			  info.setNo(wxuser.get("no").toString());
			  info.setNickname(wxuser.get("nickname").toString());
			  info.setHeadimgurl(wxuser.get("headimgurl").toString());
			  baseDao.insert(PubConstants.SUC_DATING, info);
		  }
		return false;   
	  } 
	  /**
	   * 消息付费
	   */
	  public void  deductMsg(){
		  getLscode(); 
		  HashMap<String, Object>whereMap=new HashMap<>();
		  Map<String, Object> sub_map = new HashMap<String, Object>();
		  //会员验证
		  DBObject db=baseDao.getMessage(PubConstants.SUC_DATING, fromUserid);
		  if(db!=null){
				if(db.get("endMemberDate")!=null){
					String endMemberDate=db.get("endMemberDate").toString();
					if(DateUtil.checkbig(DateFormat.getFormat(endMemberDate))){
						//会员免费
						sub_map.put("state",0);
						String json = JSONArray.fromObject(sub_map).toString(); 
						Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
						return;
					  }
				  } 
			 
		  } 
		   //每日时间验证
		  BasicDBObject dateCondition = new BasicDBObject(); 
		  dateCondition.append("$gte",com.lsp.pub.util.DateUtil.getTimesmorning());
		  dateCondition.append("$lt",com.lsp.pub.util.DateUtil.getTimesnight()); 
		  whereMap.put("createdate", dateCondition);
		  whereMap.put("fromUserid", fromUserid);
		  Long count=baseDao.getCount(PubConstants.ANDROID_MESSAGE, whereMap);
		  if(count<20){
			  sub_map.put("state",0); 
		  }else if(count==10){
			  sub_map.put("state",1);  
		  }else{
			  if(UpdateGold(fromUserid, custid,1.0,1, "消息付费")){
				  sub_map.put("state",2);   
			  }else{
				  sub_map.put("state",3); 
			  };
			  
		  } 
		  String json = JSONArray.fromObject(sub_map).toString(); 
		  Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		  
	  }
	  /**
	   * 根据ID获取聊天对象信息
	   */
	  public void  GetChatDetail(){
		  getLscode();
		  Map<String, Object> sub_map = new HashMap<String, Object>();
		  String id=Struts2Utils.getParameter("id");
		  if(StringUtils.isNotEmpty(id)){
			  HashMap<String, Object>whereMap=new HashMap<>();
			  HashMap<String, Object>backMap=new HashMap<>();
			  whereMap.put("no",id);  
			  backMap.put("nickname", 1);
			  backMap.put("headimgurl", 1);
			  backMap.put("province", 1);
			  backMap.put("city", 1);
			  backMap.put("age", 1);
			  backMap.put("no", 1);
			  backMap.put("income", 1);
			  backMap.put("height", 1);
			  DBObject db=baseDao.getMessage(PubConstants.SUC_DATING, whereMap,backMap);
			  if(db!=null){
				  sub_map.put("state", 0);
				  DBObject dats=baseDao.getMessage(PubConstants.SUC_DATINGSERVICETRUMPET, db.get("_id").toString());
					if(dats!=null){
						DBObject usercust=wwzService.getCustUser(custid);
						db.put("province", usercust.get("province"));
						db.put("city", usercust.get("city"));
					}
				  
				  sub_map.put("value",db);
			  }
		  }  
		  String json = JSONArray.fromObject(sub_map).toString(); 
		  Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	  } 
	  public String  datingService(){
		  custid=SpringSecurityUtils.getCurrentUser().getId();
		  HashMap<String, Object>whereMap=new HashMap<>();
		  HashMap<String, Object>sortMap=new HashMap<>();
		  whereMap.put("custid", custid);
		  sortMap.put("createdate", -1);
		  String  id=Struts2Utils.getParameter("id");
		  if(StringUtils.isNotEmpty(id)){
			  whereMap.put("fromUserid",wwzService.getfromUseridVipNo(id)); 
			  Struts2Utils.getRequest().setAttribute("id",id);
		  }
		  if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			  fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		  }
		  List<DBObject>list=baseDao.getList(PubConstants.SUC_DATINGSERVICE, whereMap,fypage,10,sortMap);
		  fycount=baseDao.getCount(PubConstants.SUC_DATINGSERVICE, whereMap);  
		  if(list.size()>0){
			  for (DBObject dbObject : list) {
				  DBObject user=wwzService.getWxUser(dbObject.get("fromUserid").toString());
				  dbObject.put("nickname",user.get("nickname"));
				  dbObject.put("headimgurl",user.get("headimgurl"));
			}
		  }
		  Struts2Utils.getRequest().setAttribute("list", list);
		return "service";   
	  }
	  public String  datingServiceDel(){
		  String id=Struts2Utils.getParameter("id");
		  custid=SpringSecurityUtils.getCurrentUser().getId();
		  baseDao.delete(PubConstants.SUC_DATINGSERVICE, id);
		  return datingService(); 
	  }
	  public String  datingServiceWeb(){ 
		  getLscode(); 
		  Struts2Utils.getRequest().setAttribute("custid",custid);
		return "serviceweb";   
	  }
	  public String  datingServiceLogin(){  
		return "servicelogin";   
	  }
	  public void    datingServiceSave(){
		  Map<String, Object> sub_map = new HashMap<String, Object>();
		  String custid=SpringSecurityUtils.getCurrentUser().getId();
		  String id=Struts2Utils.getParameter("id");
		  DatingService  dat=new DatingService();
		  dat.set_id(wwzService.getfromUseridVipNo(id)+"-"+custid);
		  dat.setFromUserid(wwzService.getfromUseridVipNo(id));
		  dat.setCustid(custid);
		  dat.setCreatedate(new Date());
		  baseDao.insert(PubConstants.SUC_DATINGSERVICE, dat);
		  sub_map.put("state", 0);
		  String json = JSONArray.fromObject(sub_map).toString(); 
		  Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	  }
	  public   boolean   datingServiceTrumpetSave(String id){  
		  try {
			  DatingServiceTrumpet  dat=new DatingServiceTrumpet();
			  dat.set_id(id);
			  dat.setFromUserid(id);
			  dat.setCustid(custid);
			  dat.setParent(fromUserid);
			  dat.setCreatedate(new Date());
			  baseDao.insert(PubConstants.SUC_DATINGSERVICETRUMPET, dat);
			  return true;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 return false; 
	  }
	  public void    datingServiceTrumpetWeb(){
		  getLscode();
		  Map<String, Object> sub_map = new HashMap<String, Object>();  
		  HashMap<String,Object>whereMap=new HashMap<>();
		  HashMap<String,Object>sortMap=new HashMap<>();
		  sortMap.put("endupdate", -1); 
		  whereMap.put("parent",fromUserid);
		  whereMap.put("custid", custid);
		  if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			  fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		  }
		  List<DBObject>list=baseDao.getList(PubConstants.SUC_DATINGSERVICETRUMPET, whereMap,fypage,10,sortMap);
		  if(list.size()>0){
			  sub_map.put("state", 0);
			  for (DBObject dbObject : list) {
				DBObject db=baseDao.getMessage(PubConstants.SUC_DATING, dbObject.get("fromUserid").toString());
				if(db!=null){
					dbObject.put("obj", db);
					dbObject.put("uncount",getunfind(dbObject.get("fromUserid").toString()));
				}
			} 
			  sub_map.put("list", list);
		  }
		  String json = JSONArray.fromObject(sub_map).toString(); 
		  Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	  }
	  public  void   ajaxLogin(){
		  Map<String, Object> sub_map = new HashMap<String, Object>();
		  String id=Struts2Utils.getParameter("id");
		  String password=Struts2Utils.getParameter("password"); 
		  DBObject  db=wwzService.getWXuserVipNo(id); 
		  if(db!=null&&db.get("password")!=null&&db.get("password").toString().equals(password)){
			  //验证客服
			  HashMap<String, Object>whereMap=new HashMap<>();
			  whereMap.put("_id", db.get("_id").toString());
			  List<DBObject> list=baseDao.getList(PubConstants.SUC_DATING,whereMap,null);
			  if(list.size()==1){ 
				  
				  //加载客服 
				  whereMap.clear();
				  whereMap.put("parent", db.get("_id").toString());
				  List<DBObject>listservic=baseDao.getList(PubConstants.SUC_DATINGSERVICETRUMPET, whereMap, null);
				  if(listservic.size()>0){
					  GetAllFunc.datingCustServicenum.put(db.get("_id").toString(), listservic);
				  }
				  sub_map.put("state", 0);
				  sub_map.put("custid",list.get(0).get("custid"));
				  sub_map.put("value", wwzService.getcode(db.get("_id").toString())); 
			  }
			 
		  }
		  String json = JSONArray.fromObject(sub_map).toString(); 
		  Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	  } 
	  public void  ServiceTrumpetMsg(){
			getLscode();
			Map<String, Object> sub_map = new HashMap<String, Object>();
			HashMap<String, Object>whereMap=new HashMap<>();
			HashMap<String, Object>sortMap=new HashMap<>();
			String id=Struts2Utils.getParameter("id");
			if(StringUtils.isNotEmpty(id)){
				whereMap.put("custid", custid); 
				whereMap.put("endmsg", new BasicDBObject("$ne",null));
				whereMap.put("endupdate", new BasicDBObject("$ne",null)); 
				Pattern pattern = Pattern.compile("^.*" + wwzService.getVipNo(id) + ".*$",
							Pattern.CASE_INSENSITIVE);
				whereMap.put("ids", pattern);
				sortMap.put("createdate",-1);
				if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
					fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
				}
				List<DBObject>list=baseDao.getList(PubConstants.ANDROID_REPLY, whereMap,fypage,10,sortMap);  
				if(list.size()>0){
					sub_map.put("state", 0); 
					for (DBObject dbObject : list) {
						String ids=dbObject.get("ids").toString();
						ids=ids.replace(wwzService.getVipNo(id), "");
						ids=ids.replace(",","");
						if(ids.equals("")){
							DBObject user=wwzService.getWxUser(id);
							dbObject.put("headimgurl", user.get("headimgurl"));
							dbObject.put("nickname", user.get("nickname"));
							dbObject.put("endupdate",RelativeDate.format(DateFormat.getFormat(dbObject.get("endupdate").toString()), new Date()));
							dbObject.put("uncount", getunfind(dbObject.get("_id").toString(),id));
						}else{
							DBObject user=wwzService.getWXuserVipNo(ids);
							dbObject.put("headimgurl", user.get("headimgurl"));
							dbObject.put("nickname", user.get("nickname"));
							dbObject.put("endupdate",RelativeDate.format(DateFormat.getFormat(dbObject.get("endupdate").toString()), new Date()));
							dbObject.put("uncount", getunfind(dbObject.get("_id").toString(),id));
						}
						
					}
					sub_map.put("list",list);
				}
			}
			
			String json = JSONArray.fromObject(sub_map).toString(); 
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		}
	  /**
	   * 后台添加客服
	   */
	  public void  saveServiceByid(){
		  Map<String, Object> sub_map = new HashMap<String, Object>();
		  String id=Struts2Utils.getParameter("id");
		  String fid=Struts2Utils.getParameter("fid");
		  if(StringUtils.isNotEmpty(id)){
			  DBObject  db=baseDao.getMessage(PubConstants.SUC_DATING, id);
			  if(db!=null){
				  WxUser  wx=new WxUser();
				  wx.set_id(db.get("_id").toString());
				  wx.setNo(db.get("no").toString());
				  if(db.get("headimgurl")!=null){
					  wx.setHeadimgurl(db.get("headimgurl").toString()); 
				  }
				  if (db.get("nickname")!=null) {
					  wx.setNickname(db.get("nickname").toString());
				  }
				  if(db.get("sex")!=null){
					  wx.setSex(db.get("sex").toString());
				  }
				  if (db.get("city")!=null) {
						wx.setCity(db.get("city").toString());
				  }
				  if (db.get("province")!=null) {
						wx.setProvince(db.get("province").toString());
				  } 
				  wx.setCustid(db.get("custid").toString()+",");
				  wx.setCreatedate(new Date());
				  baseDao.insert(PubConstants.DATA_WXUSER, wx);
				  DBObject  servi=baseDao.getMessage(PubConstants.SUC_DATINGSERVICETRUMPET, id);
				  if(servi==null){
					  DatingServiceTrumpet  dat=new DatingServiceTrumpet();
					  String fno=wwzService.getfromUseridVipNo(fid);  
					  dat.set_id(id);
					  dat.setFromUserid(id);
					  dat.setCustid(SpringSecurityUtils.getCurrentUser().getId());
					  dat.setParent(fno);
					  dat.setCreatedate(new Date());
					  baseDao.insert(PubConstants.SUC_DATINGSERVICETRUMPET, dat);
					  sub_map.put("state",0);
				  }else{
					  sub_map.put("state",1); 
				  }
				  
			  }
		  }
		  
		  String json = JSONArray.fromObject(sub_map).toString(); 
		  Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	  }
	  /**
	   * 添加客服
	   */
	  public void  saveService(){
			getLscode();
			Map<String, Object> sub_map = new HashMap<String, Object>();
			try { 
				String  city=Struts2Utils.getParameter("city");
				String  name=Struts2Utils.getParameter("name");
				String  picurl=Struts2Utils.getParameter("picurl");
				String  concept=Struts2Utils.getParameter("concept"); 
				String  constellation=Struts2Utils.getParameter("constellation");
				String  firstmeet=Struts2Utils.getParameter("firstmeet"); 
				String  height=Struts2Utils.getParameter("height");
				String  income=Struts2Utils.getParameter("income");
				String  likeDatingSite=Struts2Utils.getParameter("likeDatingSite");
				String  wx=Struts2Utils.getParameter("wx");
				String  weight=Struts2Utils.getParameter("weight");
				String  tel=Struts2Utils.getParameter("tel");
				String  record=Struts2Utils.getParameter("record");
				String  qq=Struts2Utils.getParameter("qq");
				String  purpose=Struts2Utils.getParameter("purpose");
				String  province=Struts2Utils.getParameter("province");
				String  professional=Struts2Utils.getParameter("professional");
				String  marriage=Struts2Utils.getParameter("marriage");
				String  sex=Struts2Utils.getParameter("sex");
				String  age=Struts2Utils.getParameter("age");
				String  birthday=Struts2Utils.getParameter("birthday");
				String  county=Struts2Utils.getParameter("county");
				String  qqState=Struts2Utils.getParameter("qqState");
				String  wxState=Struts2Utils.getParameter("telState");
				String  telState=Struts2Utils.getParameter("telState");
				WxUser db=wwzService.registerUser(custid, name, picurl, sex, age, city, province);
				if(db!=null){
					DatingInfo  obj= new DatingInfo(); ; 
					 
					obj.set_id(db.get_id().toString());
					obj.setFromUserid(db.get_id().toString());
					obj.setCustid(custid); 
					obj.setNo(db.getNo());
					if(StringUtils.isNotEmpty(birthday)){ 
						obj.setBirthday(birthday);
					} 
					if(StringUtils.isNotEmpty(city)){
						obj.setCity(city);
					}
					if(StringUtils.isNotEmpty(concept)){
						obj.setConcept(concept);
					}
					if(StringUtils.isNotEmpty(constellation)){
						obj.setConstellation(constellation);
					} 
					obj.setCreatedate(new Date());
					if(StringUtils.isNotEmpty(firstmeet)){
						obj.setFirstmeet(firstmeet);
					} 
					obj.setHeadimgurl(db.getHeadimgurl());
					obj.setNickname(db.getNickname());
					if(StringUtils.isNotEmpty(height)){
						obj.setHeight(Integer.parseInt(height));
					}
					if(StringUtils.isNotEmpty(income)){
						obj.setIncome(Integer.parseInt(income));
					}
					if(StringUtils.isNotEmpty(likeDatingSite)){
						obj.setLikeDatingSite(likeDatingSite);
					}
					if(StringUtils.isNotEmpty(wx)){
						obj.setWx(wx);
					}
					if(StringUtils.isNotEmpty(weight)){
						obj.setWeight(Integer.parseInt(weight));
					}
					if(StringUtils.isNotEmpty(tel)){
						obj.setTel(tel);	
					}
					if(StringUtils.isNotEmpty(record)){
						obj.setRecord(Integer.parseInt(record));	
					}
					if(StringUtils.isNotEmpty(qq)){
						obj.setQq(qq);	
					}
					if(StringUtils.isNotEmpty(purpose)){
						obj.setPurpose(purpose);
					}
					if(StringUtils.isNotEmpty(province)){
						obj.setProvince(province);	
					}
					if(StringUtils.isNotEmpty(professional)){
						obj.setProfessional(professional);
					} 
					if(StringUtils.isNotEmpty(marriage)){
						obj.setMarriage(Integer.parseInt(marriage));
					}
					if(StringUtils.isNotEmpty(sex)){
						obj.setSex(Integer.parseInt(sex));
					}
					if(StringUtils.isNotEmpty(age)){
						obj.setAge(Integer.parseInt(age));
					}
					if(StringUtils.isNotEmpty(county)){
						obj.setCounty(county);
					}
					if(StringUtils.isNotEmpty(qqState)){
						obj.setQqState(Integer.parseInt(qqState));
					}
					if(StringUtils.isNotEmpty(wxState)){
						obj.setWxState(Integer.parseInt(wxState));
					}
					if(StringUtils.isNotEmpty(telState)){
						obj.setTelState(Integer.parseInt(telState));
					}
					baseDao.insert(PubConstants.SUC_DATING, obj);
					boolean bl=datingServiceTrumpetSave(obj.get_id().toString());
					if(bl){
						sub_map.put("state", 0);	
					}
				}  
			} catch (NumberFormatException e) {
				// TODO Auto-generated catch block 
				e.printStackTrace();
			}
			String json = JSONArray.fromObject(sub_map).toString(); 
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	  }
	  /**
		 * ajax获取消息列表
		 */
		public void  ajaxServiceMsg(){
			getLscode();
			Map<String, Object> sub_map = new HashMap<String, Object>();
			HashMap<String, Object>whereMap=new HashMap<>();
			HashMap<String, Object>sortMap=new HashMap<>();
			String id=Struts2Utils.getParameter("id");
			whereMap.put("custid", custid); 
			whereMap.put("endmsg", new BasicDBObject("$ne",null));
			whereMap.put("endupdate", new BasicDBObject("$ne",null)); 
			Pattern pattern = Pattern.compile("^.*" + id+ ".*$",
						Pattern.CASE_INSENSITIVE);
			whereMap.put("ids", pattern);
			sortMap.put("createdate",-1);
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			List<DBObject>list=baseDao.getList(PubConstants.ANDROID_REPLY, whereMap,fypage,10,sortMap);   
			if(list.size()>0){
				sub_map.put("state", 0); 
				for (DBObject dbObject : list) {
					String ids=dbObject.get("ids").toString();
					ids=ids.replace(id, "");
					ids=ids.replace(",","");
					String fromUserid=wwzService.getfromUseridVipNo(id);
					if(ids.equals("")){
						DBObject user=wwzService.getWxUser(fromUserid);
						dbObject.put("headimgurl", user.get("headimgurl"));
						dbObject.put("nickname", user.get("nickname"));
						dbObject.put("endupdate",RelativeDate.format(DateFormat.getFormat(dbObject.get("endupdate").toString()), new Date()));
						dbObject.put("uncount", getunfind(dbObject.get("_id").toString(),fromUserid));
					}else{
						DBObject user=wwzService.getWXuserVipNo(ids);
						if(user!=null){
							dbObject.put("headimgurl", user.get("headimgurl"));
							dbObject.put("nickname", user.get("nickname"));
						} 
						dbObject.put("endupdate",RelativeDate.format(DateFormat.getFormat(dbObject.get("endupdate").toString()), new Date()));
						dbObject.put("uncount", getunfind(dbObject.get("_id").toString(),fromUserid));
					}
					
				}
				sub_map.put("list",list);
			}
			String json = JSONArray.fromObject(sub_map).toString(); 
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		} 
		public void  delunfind(){
			 getLscode();
			 Map<String, Object> submap = new HashMap<String, Object>();
			 String id=Struts2Utils.getParameter("id");
			 String rid=Struts2Utils.getParameter("rid");
			 DBObject db=baseDao.getMessage(PubConstants.ANDROID_REPLYUNFIND, rid+"-"+wwzService.getfromUseridVipNo(id));
			 if(db!=null){
				 ReplyUnFind find=(ReplyUnFind) UniObject.DBObjectToObject(db, ReplyUnFind.class);
				 find.setCount(0);
				 baseDao.insert(PubConstants.ANDROID_REPLYUNFIND, find);
				 submap.put("state",0);
			 }
			 String json = JSONArray.fromObject(submap).toString(); 
			 Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		}
		 
		public void  getCode(){
			 getLscode();
			 Map<String, Object> submap = new HashMap<String, Object>();
			 String id=Struts2Utils.getParameter("id");
			 if(StringUtils.isNotEmpty(id)){ 
				 String code=wwzService.createcode(wwzService.getfromUseridVipNo(id));
				 if(StringUtils.isNotEmpty(code)){
					 submap.put("state", 0);
					 submap.put("value",code);
				 }
			 } 
			 String json = JSONArray.fromObject(submap).toString(); 
			 Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		}
		/**
		 * 奖励
		 */
		public void  ajaxReward(){
			getLscode(); 
			JmsService.CheckReward(fromUserid, "1",custid,null);
		}
		/**
		 * 奖励
		 */
        public void  CheckReward(String id){ 
        	 JmsService.CheckReward(id, "2",custid,fromUserid);
		}
        /**
         * 任务提示
         * @return
         */
        public String taskprompt(){
        	getLscode();
    		Struts2Utils.getRequest().setAttribute("custid",custid); 
    		WxToken token=GetAllFunc.wxtoken.get(custid); 
    		 if(token.getSqlx()>0){
    			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
    		 }
    		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
    		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
    		String  url=SysConfig.getProperty("ip")+"/suc/dating!taskprompt.action?custid="+custid;  
    		if(StringUtils.isEmpty(fromUserid)){ 
    			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
    			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
    			return "refresh";
    		}else if(fromUserid.equals("register")){ 
    			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
    			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
    			return "refresh";
    		}   
    		DBObject share=wwzService.getShareFx(custid,"dating_web");
    		if(share==null){
    			share=new BasicDBObject(); 
    		} 
    		share.put("fxurl",SysConfig.getProperty("ip")+"/suc/dating!web.action?custid="+custid+"&datingid="+wwzService.getVipNo(fromUserid));
    		Struts2Utils.getRequest().setAttribute("share", share); 
			return "taskprompt"; 
        } 
        /**
         * 更改头像
         */
        public  void  updateHeadimg(){
        	getLscode();
        	String picurl=Struts2Utils.getParameter("picurl");
        	Map<String, Object> submap = new HashMap<String, Object>();
        	if(StringUtils.isNotEmpty(picurl)){
        		try {
					DatingAudit audit=new DatingAudit();
					audit.set_id(mongoSequence.currval(PubConstants.SUC_DATINGAUDIT));
					audit.setCreatedate(new Date());
					audit.setFromUserid(fromUserid);
					audit.setCustid(custid);
					audit.setType(0);
					audit.setPicurl(picurl);
					baseDao.insert(PubConstants.SUC_DATINGAUDIT, audit);
					submap.put("state", 0);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
        	} 
        	String json = JSONArray.fromObject(submap).toString(); 
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
     }
    	/**
    	 * 获取会话
    	 */
    	public  void   ajaxdetail(){
    		getLscode();
    		Map<String, Object> submap = new HashMap<String, Object>();
    		String id=Struts2Utils.getParameter("id");
    		String fid=Struts2Utils.getParameter("fid");
    		if(StringUtils.isNotEmpty(fid)){
    			fid=wwzService.getfromUseridVipNo(fid);
    		}
    		if(StringUtils.isNotEmpty(id)){
    			  HashMap<String, Object>whereMap=new HashMap<>();
    			    HashMap<String, Object>sortMap=new HashMap<>();
    			    sortMap.put("createdate",-1); 
    			    whereMap.put("rid",id);
    			    if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
    			    	fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
    			    	
    			    }
    			    List<DBObject>list=baseDao.getList(PubConstants.ANDROID_MESSAGE,whereMap,fypage,15,sortMap);
    			     
    			    if(list.size()>0){
    			    	submap.put("state", 0);
    			    	submap.put("list", list);
    			    	for (DBObject dbObject : list) {
    						if(dbObject.get("fromUserid").toString().equals(fid)){
    							dbObject.put("location","left"); 
    						}else{
    							dbObject.put("location","right");
    						}
    					}
    			    }
    		} 
    	    
    		String json = JSONArray.fromObject(submap).toString(); 
    		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    	}
    	/**
    	 * 增加星级
    	 * @param star
    	 * @param content
    	 * @return
    	 */
    	public  boolean    updateStar(int star,String content){
    		HashMap<String, Object>whereMap=new HashMap<>();
    		whereMap.put("fromUserid", fromUserid);
    		whereMap.put("content",content);
    		Long count=baseDao.getCount(PubConstants.SUC_DATINGSTAR, whereMap);
    		if(count==0){
    			DatingStar  obj=new DatingStar();
        		obj.set_id(mongoSequence.currval(PubConstants.SUC_DATINGSTAR));
        		obj.setContent(content);
        		obj.setCreatedate(new Date());
        		obj.setStar(star);
        		obj.setFromUserid(fromUserid);
        		obj.setCustid(custid);
        		baseDao.insert(PubConstants.SUC_DATINGSTAR, obj);
        		DBObject  db=baseDao.getMessage(PubConstants.SUC_DATING, fromUserid);
        		if(db!=null){
        			DatingInfo info=(DatingInfo) UniObject.DBObjectToObject(db, DatingInfo.class);
        			info.setLevel(info.getLevel()+star);
        			baseDao.insert(PubConstants.SUC_DATING, info);
        			
        		}
        		/**
        		 * 赠送会员
        		 */
        		addMember(fromUserid,custid,content,6);
    		} 
			return false; 
    	}
    	/**
    	 * 获取星级任务状态
    	 */
    	public void   getStarState(){
    		getLscode();
    		Map<String, Object> submap = new HashMap<String, Object>();
    		HashMap<String, Object>whereMap=new HashMap<>();
    		whereMap.put("fromUserid", fromUserid); 
    		List<DBObject>list=baseDao.getList(PubConstants.SUC_DATINGSTAR, whereMap,null); 
    		//验证分享  
			whereMap.put("type",0);
			DBObject  db=baseDao.getMessage(PubConstants.SUC_DATINGREWARD, whereMap);
			if(db!=null){
				String time=db.get("createdate").toString();
				if(DateUtil.checkbig(DateUtil.addDay(DateFormat.getFormat(time),3))){
					//分享已完成
					DBObject  obj=new BasicDBObject();
					obj.put("content","快乐分享");
					list.add(obj);
				}
			}
			whereMap.clear();
			whereMap.put("toUserid",fromUserid);
			Long count=baseDao.getCount(PubConstants.SUC_DATINGSTATISTICAL, whereMap);
			DBObject  obj=new BasicDBObject();
			obj.put("content","邀请好友");
			obj.put("count",count);
			list.add(obj);
    		//验证好友邀请
    		if(list.size()>0){
    			submap.put("state", 0);
    			submap.put("list", list);
    		}
    		String json = JSONArray.fromObject(submap).toString(); 
    		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    	}
    	/**
    	 * 获取星级
    	 */
    	public void   getStar(){
    		getLscode();
    		Map<String, Object> submap = new HashMap<String, Object>();
    		DBObject  db=baseDao.getMessage(PubConstants.SUC_DATING, fromUserid);
    		submap.put("value",db.get("level"));
    		String json = JSONArray.fromObject(submap).toString(); 
    		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    	}
    	/**
    	 * 星级任务页面
    	 * @return
    	 */
    	public  String   star(){
    		getLscode();
    		String datingid=Struts2Utils.getParameter("datingid");
    		Struts2Utils.getRequest().setAttribute("datingid",datingid);
    		Struts2Utils.getRequest().setAttribute("custid",custid); 
    		WxToken token=GetAllFunc.wxtoken.get(custid); 
    		 if(token.getSqlx()>0){
    			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
    		 }
    		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
    		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
    		String  url=SysConfig.getProperty("ip")+"/suc/dating!star.action?custid="+custid;  
    		if(StringUtils.isEmpty(fromUserid)){ 
    			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
    			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
    			return "refresh";
    		}else if(fromUserid.equals("register")){ 
    			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
    			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
    			return "refresh";
    		}   
    		DBObject share=wwzService.getShareFx(custid,"dating_web");
    		if(share==null){
    			share=new BasicDBObject(); 
    		} 
    		share.put("fxurl",SysConfig.getProperty("ip")+"/suc/dating!web.action?custid="+custid+"&datingid="+wwzService.getVipNo(fromUserid));
    		Struts2Utils.getRequest().setAttribute("share", share); 
    		Struts2Utils.getRequest().setAttribute("nickname",baseDao.getMessage(PubConstants.SUC_DATING, fromUserid).get("nickname"));
			return "star"; 	
    	}
    	public   void   initData(){
    		try {
				String  path=Struts2Utils.getParameter("path");
				String  sex=Struts2Utils.getParameter("sex"); 
				if(StringUtils.isNotEmpty(path)){
					init(path,sex);
				}
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    	}
    	public  void   init(String filepath,String sex) throws FileNotFoundException, IOException{
    		 File file = new File(SysConfig.getProperty("imgpath")+"/"+filepath);
    			if (!file.isDirectory()) {  
    				
    			} else if (file.isDirectory()) { 
    			        String[] filelist = file.list(); 
    			         
    			        for (int i = 0; i < filelist.length; i++) {
    			        	if(NumberUtil.isNumeric(filelist[i])){ 
    			        	    
    			                File readfile = new File(SysConfig.getProperty("imgpath")+"/"+filepath + "/" + filelist[i]);
    			                if (!readfile.isDirectory()) { 

    			                } else if (readfile.isDirectory()) { 
    			                        String[]files=readfile.list();
    			                        String id=UUID.randomUUID().toString(); 
    			                        String filedirname=id.replace("-","")+DateFormat.getDateXml(new Date());
    			                        readfile.renameTo(new File(SysConfig.getProperty("imgpath")+"/"+filepath + "/" + filedirname));
                                        boolean  bl=false;
    			                        for (int j = 0; j <files.length; j++) {
    			                        	  File imgfile = new File(SysConfig.getProperty("imgpath")+"/"+filepath + "/" +filedirname+"/"+files[j]);
    			                        	  if(imgfile.getAbsolutePath().indexOf("logo")>=0){
    			                        		  //处理头像和基本信息
    			                        		  DatingInfo info=new DatingInfo();
    			                        		  info.set_id(id);
    			                        		  info.setCustid(SpringSecurityUtils.getCurrentUser().getId());
    			                        		  String  jbs=imgfile.getName();
    			                        		  String[]lsjb=jbs.split("_");
    			                        		  if(lsjb.length>=3){
    			                        			  info.setNickname(lsjb[2]);
        			                        		  String jb=lsjb[3]; 
        			                        		  String lsj[]=jb.split("，"); 
        			                        		  if(NumberUtil.isNumeric(lsj[0].substring(0,2))){ 
        			                        			  info.setAge(Integer.parseInt(lsj[0].substring(0,2)));
        				                        		  info.setProvince(lsj[1].substring(0,2));
        				                        		  if(lsj[1].length()>=4){
        				                        			  info.setCity(lsj[1].substring(2,4));    
        				                        		  }else{ 
        				                        		  } 
        				                        		  info.setNo(wwzService.getVipNo());
        				                        		  info.setSex(Integer.parseInt(sex));
        				                        		  info.setHeadimgurl(filepath + "/" +filedirname+"/"+"logo_"+id+".jpg");
        				                        		  info.setHeight(Integer.parseInt(lsj[3].substring(0, lsj[3].indexOf("cm"))));
        				                        		  info.setCreatedate(new Date());
        				                        		  int s = new Random().nextInt(4)%(4-0+1) +0;
        				                        		  if(s>3){
        				                        			s=3;  
        				                        		  }
        				                        		  info.setIncome(s);
        				                        		  s = new Random().nextInt(6)%(6-0+1) +0;
        				                        		  if(s>5){
        				                        			s=5;  
        				                        		  }
        				                        		  info.setRecord(s); 
        				                        		  baseDao.insert(PubConstants.SUC_DATING, info); 
        				                        		  bl=true;
        				                        		  imgfile.renameTo(new File(SysConfig.getProperty("imgpath")+"/"+filepath + "/" +filedirname+"/"+"logo_"+id+".jpg"));
        			                        		  }
    			                        		  }
    			                        		  
    			                        		 
    			                        		  
    			                        	  }else if(imgfile.getAbsolutePath().indexOf("gai")>=0){ 
    			                        		  if(bl){
    			                        			  //添加相册
    			                        			  DatingPhoto  photo=new DatingPhoto();
    			                        			  photo.set_id(mongoSequence.currval(PubConstants.SUC_DATINGPHOTO));
    			                        			  photo.setCreatedate(new Date());
    			                        			  photo.setFromUserid(id);
    			                        			  photo.setPicurl(filepath + "/" +filedirname+"/"+"photo_"+id+"_"+j+".jpg");
    			                        			  baseDao.insert(PubConstants.SUC_DATINGPHOTO, photo);
    			                        			  imgfile.renameTo(new File(SysConfig.getProperty("imgpath")+"/"+filepath + "/" +filedirname+"/"+"photo_"+id+"_"+j+".jpg")); 
    			                        		  }
    			                        		  
    			                        		  
    			                        	  }
    			                        	
    									}
    			                       
    			                }
    			        	}
    			        }

    			}
    			
    	}
    	
    	
    	public   List<DBObject> getServiceNear(int num,String no){
    		List<DBObject> list=new ArrayList<DBObject>(); 
    		List<DBObject> listnew=new ArrayList<DBObject>(); 
    		for (List<DBObject> values : GetAllFunc.datingCustServicenum.values()) {  
    			 for (DBObject object : values) {
    				
    				 list.add(object);
				}
    		}  
    		if(list.size()<num){
    			num=list.size();
    		}
    		if(list.size()>0){
    			HashMap<String,Integer>map=BaseDecimal.getListRand(num,list.size());  
        		for (Integer values : map.values()) {
    				 listnew.add(list.get(values));
    			} 
        		for (DBObject dbObject : listnew) {
        			 String id=dbObject.get("fromUserid").toString(); 
    				 DBObject  db=getDating(id);
    				 if(db!=null){
    					 db.put("msgState",getMsgState(no+","+db.get("no"))); 
    				 } 
    				 Random rand = new Random();  
    				 dbObject.put("distance", BaseDecimal.mToKm(rand.nextInt(10000))); 
    				 dbObject.put("dating", db);
    			}
    		}
    		
			return listnew; 
    	}
    	
    	
        public  DBObject  getDating(String id){
    	   if(StringUtils.isEmpty(id)){
    		  return null;
    	  }
    	  DBObject  db=baseDao.getMessage(PubConstants.SUC_DATING, id); 
    	   if(db!=null){
    		  return db;
    	   }
		   return null;
    	
       }
       public void upuser(){
    	   String area=Struts2Utils.getParameter("area");
    	   String province=Struts2Utils.getParameter("province");
    	   HashMap<String,Object>whereMap=new HashMap<>();
    	   whereMap.put("sex",1);  
   		   Pattern pattern = Pattern.compile("^" +area + ".*$",
   					Pattern.CASE_INSENSITIVE);
   		   whereMap.put("city", pattern);
   		   List<DBObject>list=baseDao.getList(PubConstants.SUC_DATING, whereMap,null);
   		   int  count=list.size(); 
   		   if (count<50) {
   			whereMap.clear();
   			whereMap.put("sex",1);
   			pattern = Pattern.compile("^((?!" +area + ").)*$",
   					Pattern.CASE_INSENSITIVE);
   		    whereMap.put("city", pattern);
   			   list=baseDao.getList(PubConstants.SUC_DATING, whereMap,null); 
   			   for (DBObject dbObject : list) {
				if(dbObject.get("city").toString().indexOf(area)<0){
					DatingInfo datingInfo=(DatingInfo) UniObject.DBObjectToObject(dbObject, DatingInfo.class);
					datingInfo.setCity(area);
					datingInfo.setProvince(province);
					baseDao.insert(PubConstants.SUC_DATING, datingInfo);
					count++;
					if (count==50) {
						break;
					}
				}
			}
		   }
   		  whereMap.clear();  
   		  whereMap.put("sex",2);  
  		   pattern = Pattern.compile("^" +area + ".*$",
  					Pattern.CASE_INSENSITIVE);
  		   whereMap.put("city", pattern);
  		   list=baseDao.getList(PubConstants.SUC_DATING, whereMap,null);
  		   count=list.size(); 
  		   if (count<150) {
  			whereMap.clear();
  			whereMap.put("sex",2);
  			pattern = Pattern.compile("^((?!" +area + ").)*$",
   					Pattern.CASE_INSENSITIVE);
  		    whereMap.put("city", pattern);
  			   list=baseDao.getList(PubConstants.SUC_DATING, whereMap,null);
  			   for (DBObject dbObject : list) {
				if(dbObject.get("city").toString().indexOf(area)<0){
					DatingInfo datingInfo=(DatingInfo) UniObject.DBObjectToObject(dbObject, DatingInfo.class);
					datingInfo.setCity(area);
					datingInfo.setProvince(province);
					baseDao.insert(PubConstants.SUC_DATING, datingInfo);
					count++;
					if (count==150) {
						break;
					}
				}
			}
		 }
       }
       
       public void addmm() {
    	   String fromid=Struts2Utils.getParameter("fromid");
    	   fromid=wwzService.getfromUseridVipNo(fromid);
    	   String count=Struts2Utils.getParameter("count");
    	   String custid=Struts2Utils.getParameter("custid");
    	   int  c=0;
		 List<DBObject>list=baseDao.getList(PubConstants.SUC_DATING, null, null);
		 for (DBObject dbObject : list) {
			DBObject dbObject2=baseDao.getMessage(PubConstants.SUC_DATINGSERVICETRUMPET,dbObject.get("_id").toString());
			if (dbObject2==null) {
				  DatingServiceTrumpet  dat=new DatingServiceTrumpet();
				  dat.set_id(dbObject.get("_id").toString());
				  dat.setFromUserid(dbObject.get("_id").toString());
				  dat.setCustid(custid);
				  dat.setParent(fromid);
				  dat.setCreatedate(new Date());
				  baseDao.insert(PubConstants.SUC_DATINGSERVICETRUMPET, dat);
				  c++;
				  if(c==Integer.parseInt(count)){
					  break;
				  }
			}
		}
	}
     
	 
}
