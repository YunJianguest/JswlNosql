package com.lsp.user.web;

import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Pattern;


import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.activemq.filter.function.splitFunction;
import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.google.gson.JsonObject;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.entity.WxToken;
import com.lsp.pub.util.JmsService;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.UserUtil;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.web.GeneralAction;
import com.lsp.suc.entity.Comunit;
import com.lsp.user.entity.CustomerInfo;
import com.lsp.user.entity.UserInfo;
import com.lsp.website.service.WwzService;
import com.lsp.websocket.ChatServer;
import com.lsp.websocket.service.WebsoketListen;
import com.lsp.weixin.entity.WxUser;
import com.lsp.weixin.entity.WxUserToken;
import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
/**
 * 手机用户管理
 * @author lsp
 *
 */
@Namespace("/user")
@Results({@org.apache.struts2.convention.annotation.Result(name="reload", location="fromuser.action",params={"fypage", "%{fypage}","nickname", "%{nickname}"}, type="redirect")})
public class FromuserAction extends GeneralAction<WxUser>{
	 private static final long serialVersionUID = -6784469775589971579L;

	  @Autowired
	  private BaseDao basedao;
	  private String _id;
	  private WxUser entity = new WxUser();
	  private MongoSequence mongoSequence;
	  @Autowired
	  private WwzService  wwzservice; 
	  @Autowired
	  public void setMongoSequence(MongoSequence mongoSequence)
	  {
	    this.mongoSequence = mongoSequence;
	  }
	  public void set_id(String _id) {
	    this._id = _id;
	  }
	  
	  public String execute() throws Exception {
		  
		    HashMap<String, Object> sortMap = new HashMap<String, Object>();
		    HashMap<String, Object> whereMap = new HashMap<String, Object>();
		    custid=SpringSecurityUtils.getCurrentUser().getId();
		    if(StringUtils.isNotEmpty(custid))
			{
				Pattern pattern = Pattern.compile("^.*" + custid + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("custid", pattern); 
			} 
			String  nickname=Struts2Utils.getParameter("nickname");
			if(StringUtils.isNotEmpty(nickname))
			{
				Pattern pattern = Pattern.compile("^.*" + nickname + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("nickname", pattern);
				Struts2Utils.getRequest().setAttribute("nickname",  nickname);
			}
			String  isline=Struts2Utils.getParameter("isline");
			if(StringUtils.isNotEmpty(isline))
			{  
				if(Integer.parseInt(isline)==1){
					whereMap.put("online", Integer.parseInt(isline));
				}else if (Integer.parseInt(isline)==0) {
					BasicDBList   dblist=new BasicDBList(); 
					dblist.add(new BasicDBObject("online",null));
					dblist.add(new BasicDBObject("online",0));
					//or判断
					whereMap.put("$or", dblist); 
				}
				
				Struts2Utils.getRequest().setAttribute("isline",  isline);
			}
		    sortMap.put("createdate", Integer.valueOf(-1));
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			} 
		    List<DBObject> list = this.basedao.getList(PubConstants.DATA_WXUSER, whereMap,fypage,10,sortMap);
		    Struts2Utils.getRequest().setAttribute("userList", list);
		    for (DBObject dbObject : list) { 
		    	if(dbObject.get("_id")!=null){
		    		DBObject  code=basedao.getMessage(PubConstants.USER_AUTHCODE,dbObject.get("_id").toString());
		    		if(code!=null){
			    		dbObject.put("activitydate", code.get("activitydate"));
			    	}
		    		dbObject.put("logindate",wwzservice.getlogin(custid, dbObject.get("_id").toString()));
		    	}
		    	
		    	
			}
		    this.fycount = this.basedao.getCount(PubConstants.DATA_WXUSER,whereMap); 
		    Struts2Utils.getRequest().setAttribute("custid",SpringSecurityUtils.getCurrentUser().getId());
		  
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

	public void upd() throws Exception {
		DBObject db = basedao.getMessage(PubConstants.DATA_WXUSER, _id);
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}
	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub  
	     DBObject  db=basedao.getMessage(PubConstants.DATA_WXUSER, _id);
	     if(db!=null){
	    	 WxUser  user=(WxUser) UniObject.DBObjectToObject(db, WxUser.class);
	    	 user.setPassword(Struts2Utils.getParameter("password"));
	    	 basedao.insert(PubConstants.DATA_WXUSER, user); 
	     }
		return RELOAD;
	}

	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		try { 
			custid=SpringSecurityUtils.getCurrentUser().getId();
			basedao.delete(PubConstants.DATA_WXUSER,_id);
			/*HashMap<String, Object>whereMap=new HashMap<String, Object>(); 
			whereMap.put("_id",_id);
			if(StringUtils.isNotEmpty(custid)){
				Pattern pattern = Pattern.compile("^.*" + custid + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("custid", pattern); 	
			}
			DBObject db=basedao.getMessage(PubConstants.DATA_WXUSER, whereMap);
			if(db!=null){
				WxUser  user=(WxUser) UniObject.DBObjectToObject(db, WxUser.class);
				user.setCustid(user.getCustid().replace(custid+",", ""));
				basedao.insert(PubConstants.DATA_WXUSER, user);
			}*/ 
			addActionMessage("删除成功");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return RELOAD;
	}

	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id!=null){
				DBObject  db=basedao.getMessage(PubConstants.DATA_WXUSER, _id);
				entity=(WxUser) UniObject.DBObjectToObject(db, WxUser.class);
			}else{
				
				entity=new WxUser();
				
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			addActionMessage("删除失败");
		}
		
	}
	@Override
	public WxUser getModel() {
		// TODO Auto-generated method stub
		return entity;
	}
	 public String UserDetail(){ 
		  getLscode();  
		  Struts2Utils.getRequest().setAttribute("custid",custid );
		  WxToken token=GetAllFunc.wxtoken.get(custid);
			 if(token.getSqlx()>0){
				 token=GetAllFunc.wxtoken.get(wwzservice.getparentcustid(custid)); 
			 } 
			Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
			token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
			String  url=SysConfig.getProperty("ip")+"/user/fromuser!UserDetail.action?custid="+custid;  
			if(StringUtils.isEmpty(fromUserid)){ 
				String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
				Struts2Utils.getRequest().setAttribute("inspection",inspection);  
				return "refresh";
			}else if(fromUserid.equals("register")){ 
				String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
				Struts2Utils.getRequest().setAttribute("inspection",inspection);  
				return "refresh";
			}  
		  
		  //优先使用用户ID查询
		  DBObject wxUser=new BasicDBObject();
		  if(StringUtils.isNotEmpty(fromUserid)){
			  HashMap<String, Object>whereMap=new HashMap<String, Object>();
			  whereMap.put("_id", fromUserid);
			  wxUser=wwzservice.getWxUser(whereMap);
			  whereMap.clear();
			  whereMap.put("fromUserid",fromUserid);
			  whereMap.put("custid", custid);
			  Long bbscount=basedao.getCount(PubConstants.BBS_INFO, whereMap);
			  whereMap.clear();
			  whereMap.put("fromUserid",fromUserid);
			  Long tackcount=basedao.getCount(PubConstants.SUC_TASK);
			  wxUser.put("bbscount",bbscount); 
			  wxUser.put("tackcount",tackcount); 
			  double bl= Double.parseDouble(wxUser.get("getExperience").toString())/Double.parseDouble(wxUser.get("needExperience").toString());   
			  wxUser.put("expbl",new java.text.DecimalFormat("#").format(bl*100));
			  //积分
			  wxUser.put("jf",wwzservice.getJf(custid, fromUserid));
			  Struts2Utils.getRequest().setAttribute("entity", wxUser);
		  }else{
			 
			  if(StringUtils.isEmpty(qqfromUser)){
				  //未登录
				  return "fromlogin";  
			  }else{
				  //根据QQ登录信息查询  
				  HashMap<String, Object>whereMap=new HashMap<String, Object>();
				  whereMap.put("qqfromUser", qqfromUser);
				  wxUser=wwzservice.getWxUser(whereMap);
				  whereMap.put("custid", custid);
				  Long count=basedao.getCount(PubConstants.BBS_INFO, whereMap);
				  wxUser.put("bbscount",count);
				  Struts2Utils.getRequest().setAttribute("entity", wxUser);
				  
				  
			  }
			  
		  }
		  //加载菜单   
		  DBObject  mb=wwzservice.getfromusermbs(custid);
		  Struts2Utils.getRequest().setAttribute("func",mb);  
		  
		  DBObject share=wwzservice.getShareFx(custid,"fromuser_share"); 
		  if(share==null){
			  share=new BasicDBObject();
		  }
		  share.put("fximg",GetAllFunc.wxTouser.get(custid).getLogo());
		  share.put("fxurl",url);  
		  Struts2Utils.getRequest().setAttribute("share", share);
		  //加载佣金
		  DBObject  agent=wwzservice.getAgentPrice(custid, fromUserid);
		  Struts2Utils.getRequest().setAttribute("agent",agent);
		  //检测代理 
		  if(wwzservice.checkAgent(custid,fromUserid)){
			 Struts2Utils.getRequest().setAttribute("isAgent","ok");
		  }
		  if(mb!=null&&mb.get("mb")!=null){
			  return "detail"+mb.get("mb");  
		  }
		return "detail";   
	  }
	 public String register(){
		  
		return "register";   
	 }
	 /**
	  * ajax注册
	  */
	 public void  ajaxregister(){
		//邮箱用作登录账户方便邮箱验证
		String  name=Struts2Utils.getParameter("name");
		String  toUser=Struts2Utils.getParameter("toUser");
		String  custid=Struts2Utils.getParameter("custid");
		String  password=Struts2Utils.getParameter("password"); 
		Map<String, Object>sub_Map=new HashMap<String, Object>();
		//验证用户名是否唯一
		if(wwzservice.checkName(name)){
			try {
				if(StringUtils.isNotEmpty(name)&&StringUtils.isNotEmpty(password)){
					 WxUser user=new WxUser();
					 user.set_id(UUID.randomUUID().toString());
					 user.setLoginname(name); 
					 //user.setNo(wwzservice.getVipNo());
					 user.setLoginpasswd(password);
					 user.setCreatedate(new Date());
					 user.setNickname("江湖大虾!");
					 user.setEmail(name);
					 user.setToUser(toUser);
					 user.setCustid(custid);
					 basedao.insert(PubConstants.DATA_WXUSER, user);
					 sub_Map.put("state",0);
					 sub_Map.put("value", user.get_id().toString());
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				sub_Map.put("state", 1);
				e.printStackTrace();
			}
		}else{
			sub_Map.put("state", 2); 
		}
		
		String json = JSONArray.fromObject(sub_Map).toString();
		 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
		 
	 }
	 /**
	  * ajax登录
	  */
	 public void  ajaxlongin(){
		 String  name=Struts2Utils.getParameter("name");
		 String  password=Struts2Utils.getParameter("password");
		 HashMap<String, Object>whereMap=new HashMap<String, Object>();
		 Map<String, Object>sub_Map=new HashMap<String, Object>();
		 try {
			
			 whereMap.put("loginname", name);
			 DBObject  db=basedao.getMessage(PubConstants.DATA_WXUSER, whereMap);
			 if(db!=null){
				 if(db.get("loginpasswd").equals(password)){
					sub_Map.put("state", 0);
					sub_Map.put("value", db.get("_id").toString());
				 }
			 }
		} catch (Exception e) {
			sub_Map.put("state", 1);
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_Map).toString();
		 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		 
	 }
	 /**
	  * 微信授权登录
	  */
	 public  String   wxlogin(){
		 getLscode();
		 WxUserToken token=GetAllFunc.usertoken.get(fromUser);
		 fromUserid=wwzservice.register(fromUser,token,custid); 
		 if(StringUtils.isNotEmpty(fromUserid)){
			 lscode=wwzservice.createcode(fromUserid);	 
		 }
		 Struts2Utils.getRequest().setAttribute("lscode", lscode);
		 Struts2Utils.getRequest().setAttribute("custid", custid);
		 return "wxlogin";
	 }
	 /**
	  * ajax返回登录url
	  */
	 public void  getloginurl(){
		 custid=getCustid();
		 Map<String, Object> submap = new HashMap<String, Object>();
		try {
			 WxToken token=GetAllFunc.wxtoken.get(custid); 
			 if(token.getSqlx()>0){
				 token=GetAllFunc.wxtoken.get(wwzservice.getparentcustid(custid)); 
			 } 
			 
			 String surl=SysConfig.getProperty("ip")+"/user/fromuser!wxlogin.action?custid="+custid;
			 String ddurl="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(surl)+"&response_type=code&scope=snsapi_userinfo&state=123#wechat_redirect";
		     submap.put("state", 0);
		     submap.put("value", ddurl);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			submap.put("state",1);
			e.printStackTrace();
		}
		 String json = JSONArray.fromObject(submap).toString(); 
		 Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	 }
	public String  qqlogin(){
		  fromUserid=getFromUserid();
		  custid=getCustid(); 
		  Struts2Utils.getRequest().setAttribute("fromUserid", fromUserid);
		  Struts2Utils.getRequest().setAttribute("custid",custid );
		return "qqlogin";
		
	}
	/**
	 * 用户信息
	 * @return
	 */
	public String  detail(){ 
		 getLscode();
		 DBObject  user=wwzservice.getWxUser(fromUserid);
		 Struts2Utils.getRequest().setAttribute("user",user);
		 Struts2Utils.getRequest().setAttribute("custid",custid); 
		return "add";
		
	}
	public void  savedetatil(){
		Map<String, Object> submap = new HashMap<String, Object>();
		 getLscode();
		 String  headimgurl=Struts2Utils.getParameter("headimgurl");
		 String  email=Struts2Utils.getParameter("email");
		 String  nickname=Struts2Utils.getParameter("nickname");
		 String  qq=Struts2Utils.getParameter("qq");
		 String  wxid=Struts2Utils.getParameter("wxid");
		 String  tel=Struts2Utils.getParameter("tel");
		 String  password=Struts2Utils.getParameter("password");
		 DBObject db=wwzservice.getWxUser(fromUserid);
		 if(db.get("_id").equals("notlogin")){
			 submap.put("state", 3);
			 return;
		 }else{
			 WxUser  user=(WxUser) UniObject.DBObjectToObject(db, WxUser.class); 
			 if(StringUtils.isNotEmpty(headimgurl)){
				 user.setHeadimgurl(headimgurl);
			 }
			 if(StringUtils.isNotEmpty(nickname)){
				 user.setNickname(nickname); 
			 }
			 if(StringUtils.isNotEmpty(email)){
				 user.setEmail(email); 
			 }
			 if(StringUtils.isNotEmpty(qq)){
				 user.setQq(qq);
			 }
			 if(StringUtils.isNotEmpty(wxid)){
				 user.setWxid(wxid); 
			 }
			 if(StringUtils.isNotEmpty(tel)){
				 user.setTel(tel);	 
			 }
			 if(StringUtils.isNotEmpty(password)){
				 user.setPassword(password);
			 }
			  
			 basedao.insert(PubConstants.DATA_WXUSER, user);
			 submap.put("state", 0);
		 } 
		 String json = JSONArray.fromObject(submap).toString(); 
		 Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 设置安卓管理员
	 */
	public  void   setAndroidAdmin(){
		Map<String, Object> submap = new HashMap<String, Object>();
		custid=SpringSecurityUtils.getCurrentUser().getId();
		String id=Struts2Utils.getParameter("id");
		DBObject  db=basedao.getMessage(PubConstants.DATA_WXUSER, id);
		if(db!=null){
			WxUser  user=(WxUser) UniObject.DBObjectToObject(db, WxUser.class);
			user.setAndroidAdmin(1);
			basedao.insert(PubConstants.DATA_WXUSER, user);
			submap.put("state", 0);
		}
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 取消安卓管理员
	 */
	public  void   cancelAndroidAdmin(){
		Map<String, Object> submap = new HashMap<String, Object>();
		custid=SpringSecurityUtils.getCurrentUser().getId();
		String id=Struts2Utils.getParameter("id");
		DBObject  db=basedao.getMessage(PubConstants.DATA_WXUSER, id);
		if(db!=null){
			WxUser  user=(WxUser) UniObject.DBObjectToObject(db, WxUser.class);
			user.setAndroidAdmin(0);
			basedao.insert(PubConstants.DATA_WXUSER, user);
			submap.put("state", 0);
		}
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	} 
	/**
	 * 设置用户密码
	 */
	public  void  setfromUserpasswd(){
		Map<String, Object> submap = new HashMap<String, Object>();
		custid=SpringSecurityUtils.getCurrentUser().getId();
		String  password=Struts2Utils.getParameter("password");
		String  id=Struts2Utils.getParameter("id");
		if(StringUtils.isNotEmpty(password)&&StringUtils.isNotEmpty(id)){
			DBObject  db=basedao.getMessage(PubConstants.DATA_WXUSER, id);
			if(db!=null){
				WxUser  user=(WxUser) UniObject.DBObjectToObject(db, WxUser.class);
				user.setPassword(password);
				basedao.insert(PubConstants.DATA_WXUSER, user);
				submap.put("state", 0);
			}
		}
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	public String test(){
		getLscode();
		Struts2Utils.getRequest().setAttribute("custid",custid);
		return "test";
	} 
	 
}
