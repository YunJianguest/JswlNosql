package com.lsp.user.web;

import com.lsp.email.entity.Email; 
import com.lsp.email.util.EmailUtils;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.Fromusermb;
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.entity.RoleInfo;
import com.lsp.pub.util.BaseDate;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.ListUtil;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction; 
import com.lsp.user.entity.UserInfo;
import com.lsp.website.service.WwzService;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject; 

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Pattern; 
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
/***
 * 资源管理
 * @author lsp
 *
 */
@Namespace("/user")
@Results({@org.apache.struts2.convention.annotation.Result(name="reload", location="user.action", type="redirect")})
public class UserAction extends GeneralAction<UserInfo>
{
  private static final long serialVersionUID = -6784469775589971579L;

  @Autowired
  private BaseDao basedao;
  private String _id;
  private UserInfo entity = new UserInfo();
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
    sortMap.put("createdate",-1);
    if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
		fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
	} 
    String title = Struts2Utils.getParameter("title");
    if (StringUtils.isNotEmpty(title)) {
      Pattern pattern = Pattern.compile("^.*" + title + ".*$", 
        2);
      whereMap.put("account", pattern);
      Struts2Utils.getRequest().setAttribute("title", title);
    }
    String name = Struts2Utils.getParameter("name");
    if (StringUtils.isNotEmpty(name)) {
      Pattern pattern = Pattern.compile("^.*" + name + ".*$", 
        2);
      whereMap.put("nickname", pattern);
      Struts2Utils.getRequest().setAttribute("name", name);
    }
    whereMap.put("custid",SpringSecurityUtils.getCurrentUser().getId());
    List<DBObject> list = this.basedao.getList(PubConstants.USER_INFO, whereMap, sortMap); 
    for (DBObject dbObject : list) {
		dbObject.put("nickname", wwzservice.getCustName(dbObject.get("custid").toString()));
	}
    Struts2Utils.getRequest().setAttribute("userList", list);
    this.fycount = this.basedao.getCount(PubConstants.USER_INFO,whereMap);
    Struts2Utils.getRequest().setAttribute("fycount", Long.valueOf(this.fycount));
    whereMap.clear();
    whereMap.put("custid",SpringSecurityUtils.getCurrentUser().getId());
    List<DBObject> rolelist = this.basedao.getList(PubConstants.ROLE_INFO, whereMap, sortMap);
    HashMap<Long, Object> map = new HashMap<Long,Object>();
    map.put(Long.valueOf(0L), "请选择");
    List<Map<Long,Object>> lsrole = new ArrayList<Map<Long,Object>>();
    for (int i = 0; i < rolelist.size(); i++) {
      RoleInfo entity = (RoleInfo)UniObject.DBObjectToObject((DBObject)rolelist.get(i), RoleInfo.class);
      HashMap<Long,Object> roleMap = new HashMap<Long,Object>();
      map.put(Long.valueOf(Long.parseLong(entity.get_id().toString())), entity.getRolename().toString());

      lsrole.add(roleMap);
    } 
    Struts2Utils.getRequest().setAttribute("custid", SpringSecurityUtils.getCurrentUser().getId());
    Struts2Utils.getRequest().setAttribute("map", map); 
    Struts2Utils.getRequest().setAttribute("rolelist", rolelist);
    sortMap.clear();
    sortMap.put("sort", -1);  
    Struts2Utils.getRequest().setAttribute("fromfunc", basedao.getList(PubConstants.PUB_FROMUSERFUNC, null, sortMap));
    return SUCCESS;
  }

  public String input()
    throws Exception
  {
    return "add";
  }

  public String update()
    throws Exception
  {
    return "add";
  }

  public String save() throws Exception
  {
    try
    { 
    	
      if(StringUtils.isEmpty(_id)){
    	  _id=UUID.randomUUID().toString(); 
      }
      this.entity.set_id(_id);
      this.entity.setCreatedate(new Date());
      this.entity.setCustid(SpringSecurityUtils.getCurrentUser().getId()); 
     
      this.basedao.insert(PubConstants.USER_INFO, this.entity);
      String funcs=Struts2Utils.getParameter("funcs");
      List<DBObject>list=new ArrayList<DBObject>(); 
      if(StringUtils.isNotEmpty(funcs)){
    	  String[]lsfunc=funcs.split(",");
    	  for (String string : lsfunc) {
			if(StringUtils.isNotEmpty(string)){
				DBObject  db=basedao.getMessage(PubConstants.PUB_FROMUSERFUNC, Long.parseLong(string));
				list.add(db);
			}
		}
    	  
      }
      list=ListUtil.sort(list, "sort");
      String  fxmb=Struts2Utils.getParameter("mb"); 
      Fromusermb   mb=new Fromusermb();
      mb.set_id(_id);
      mb.setCustid(_id);
      mb.setLsfunc(list);
      if(StringUtils.isNotEmpty(fxmb)){
    	  mb.setMb(Integer.parseInt(fxmb));
      }
      basedao.insert(PubConstants.PUB_FROMUSERMB, mb);
      addActionMessage("添加成功");
    }
    catch (Exception e) {
      e.printStackTrace();
      addActionMessage("添加失败");
    }
    return RELOAD;
  }

  public String delete() throws Exception
  {
    try
    {   HashMap<String, Object>whereMap=new HashMap<String, Object>();
        whereMap.put("_id", _id);
        whereMap.put("custid", SpringSecurityUtils.getCurrentUser().getId());
    	
        this.basedao.delete(PubConstants.USER_INFO,whereMap);
        addActionMessage("删除失败");
      
    }
    catch (Exception e)
    {
      e.printStackTrace();
      addActionMessage("删除成功");
    }
    return RELOAD;
  }
   
  protected void prepareModel()
    throws Exception
  {
    if (this._id != null)
    {
      DBObject emDbObject = this.basedao.getMessage(PubConstants.USER_INFO, this._id);
      this.entity = ((UserInfo)UniObject.DBObjectToObject(emDbObject, UserInfo.class));
    } else {
      this.entity = new UserInfo();
    }
  }
 
  public UserInfo getModel()
  {
    return this.entity;
  }
  public void upd() throws Exception {
	    
		DBObject db = basedao.getMessage(PubConstants.USER_INFO, _id);
		List<DBObject>list=wwzservice.getfromusermb(_id);
		db.put("funclist", list);
		db.put("mb",wwzservice.getfromusermbs(_id).get("mb"));
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
  } 

  public String main() {
		//qqfromUser = getQqfromUser();
		//HashMap<String, Object> whereMap = new HashMap<String, Object>();
		//whereMap.put("qqfromUser", qqfromUser);
		//DBObject db = wwzservice.getWxUser(whereMap);
		//Struts2Utils.getRequest().setAttribute("entity", db);
 
		return "main";
 }
  
  public void  ajaxsave(){
		
		Map<String, Object>sub_Map=new HashMap<String, Object>();
		try {
			String  id=Struts2Utils.getParameter("id");
			String  account=Struts2Utils.getParameter("account");
			String  password=Struts2Utils.getParameter("password"); 
			String  nickname=Struts2Utils.getParameter("nickname"); 
			String  toUser=Struts2Utils.getParameter("toUser");
			String  roleid=Struts2Utils.getParameter("roleid");
			String  type=Struts2Utils.getParameter("type");
			String  funcs=Struts2Utils.getParameter("funcs");
			String  fxmb=Struts2Utils.getParameter("mb");
			String  area=Struts2Utils.getParameter("area");
			String  province=Struts2Utils.getParameter("province");
			String  city=Struts2Utils.getParameter("city");
			if(StringUtils.isEmpty(id)){
				id=UUID.randomUUID().toString();
			}
			UserInfo  user=new UserInfo();
			user.set_id(id);
			user.setAccount(account);
			user.setPassword(password);
			user.setToUser(toUser);
			user.setNickname(nickname);
			user.setCustid(SpringSecurityUtils.getCurrentUser().getId());
			user.setArea(area);
			user.setProvince(province);
			user.setCity(city);
			if(StringUtils.isNotEmpty(roleid)){
				user.setRoleid(Long.parseLong(roleid));	
			}
			if(org.apache.commons.lang3.StringUtils.isNotEmpty(type)){
				user.setType(Integer.parseInt(type));	
			}
			user.setCreatedate(new Date());
			basedao.insert(PubConstants.USER_INFO, user);
			List<DBObject>list=new ArrayList<DBObject>();
			  if(StringUtils.isNotEmpty(funcs)){
				  String[]lsfunc=funcs.split(",");
				  for (String string : lsfunc) {
					if(StringUtils.isNotEmpty(string)){
						DBObject  db=basedao.getMessage(PubConstants.PUB_FROMUSERFUNC, Long.parseLong(string));
						list.add(db);
					}
				}
				  
			  }
			  Fromusermb   mb=new Fromusermb();
			  mb.set_id(id);
			  mb.setCustid(SpringSecurityUtils.getCurrentUser().getId());
			  mb.setLsfunc(list); 
			  if(StringUtils.isNotEmpty(fxmb)){
				  mb.setMb(Integer.parseInt(fxmb));
			  }
			  basedao.insert(PubConstants.PUB_FROMUSERMB, mb);
			  sub_Map.put("state", 0); 
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			sub_Map.put("state", 1);
			e.printStackTrace();
		}
	  	String json = JSONArray.fromObject(sub_Map).toString();
		 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	  
	}
	/**
	 * ajax保存
	 */
	public void  ajaxwebsave(){
		
		Map<String, Object>sub_Map=new HashMap<String, Object>();
		try {
			String  id=Struts2Utils.getParameter("id");
			String  account=Struts2Utils.getParameter("account");
			String  password=Struts2Utils.getParameter("password"); 
			String  nickname=Struts2Utils.getParameter("nickname"); 
			String  toUser=Struts2Utils.getParameter("toUser");
			String  roleid=Struts2Utils.getParameter("roleid");
			String  type=Struts2Utils.getParameter("type");
			String  email=Struts2Utils.getParameter("email");
			String  tel=Struts2Utils.getParameter("tel");
			String  cid=Struts2Utils.getParameter("cid");
			String  funcs=Struts2Utils.getParameter("funcs");
			String  qq=Struts2Utils.getParameter("qq"); 
			if(StringUtils.isNotEmpty(cid)&&StringUtils.isNotEmpty(account)&&StringUtils.isNotEmpty(password)&&StringUtils.isNotEmpty(email)){
				HashMap<String,Object>whereMap= new HashMap<String, Object>();
				whereMap.put("account", account);
				List<DBObject>list=basedao.getList(PubConstants.USER_INFO, whereMap, null);
				if(list.size()==0){
					if(StringUtils.isEmpty(id)){
						id=UUID.randomUUID().toString();
					}
					UserInfo  user=new UserInfo();
					user.set_id(id);
					user.setAccount(account);
					user.setPassword(password);
					user.setToUser(toUser);
					user.setNickname(nickname);
					if(StringUtils.isEmpty(nickname)){
						user.setNickname(account);	
					}
					user.setTel(tel);
					user.setCustid(cid);
					if(StringUtils.isNotEmpty(roleid)){
						user.setRoleid(Long.parseLong(roleid));	
					}
					if(StringUtils.isNotEmpty(type)){
						user.setType(Integer.parseInt(type));	
					}
					user.setQq_id(qq);
					basedao.insert(PubConstants.USER_INFO, user);
					/**List<DBObject>list=new ArrayList<DBObject>();
					  if(StringUtils.isNotEmpty(funcs)){
						  String[]lsfunc=funcs.split(",");
						  for (String string : lsfunc) {
							if(StringUtils.isNotEmpty(string)){
								DBObject  db=basedao.getMessage(PubConstants.PUB_FROMUSERFUNC, Long.parseLong(string));
								list.add(db);
							}
						}
						  
					  }
					  Fromusermb   mb=new Fromusermb();
					  mb.set_id(id);
					  mb.setCustid(SpringSecurityUtils.getCurrentUser().getId());
					  mb.setLsfunc(list);
					  basedao.insert(PubConstants.PUB_FROMUSERMB, mb);*/
					  sendemail(email,account);
					  sub_Map.put("state", 0); 
				}else{
					 sub_Map.put("state", 2);
					 String json = JSONArray.fromObject(sub_Map).toString();
					 
					 Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
					 return;
					
				}
				
			}else{
				 sub_Map.put("state", 1);
				 String json = JSONArray.fromObject(sub_Map).toString();
				 
				 Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
				 return;
			}
		
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			sub_Map.put("state", 1);
			e.printStackTrace();
		}
	  	String json = JSONArray.fromObject(sub_Map).toString();
		 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	  
	}
	/**
	 * 获取用户数据
	 */
	public  void   getusercount(){
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		int usertype=SpringSecurityUtils.getCurrentUser().getType();
		if(usertype==2){
		custid=SpringSecurityUtils.getCurrentUser().getId();
		if(StringUtils.isNotEmpty(custid))
		 {
		 Pattern pattern = Pattern.compile("^.*" + custid + ".*$",
		  Pattern.CASE_INSENSITIVE);
			whereMap.put("custid", pattern); 
		 } 
		 Long count=basedao.getCount(PubConstants.DATA_WXUSER, whereMap);
		 sub_map.put("count", count);
		 String rq=BaseDate.RelativeDate(BaseDate.getDate(),-1);
		 whereMap.put("createdate",  new BasicDBObject("$lte",DateFormat.getFormat(rq + " 23:59:59")).append("$gte", DateFormat.getFormat(rq + " 00:00:00")));
		 long zrcount=basedao.getCount(PubConstants.DATA_WXUSER, whereMap);
		 sub_map.put("zcount", zrcount);
		 whereMap.put("createdate", new BasicDBObject("$gt", BaseDate.getDay(new Date(), -30)));
	     long bycount=basedao.getCount(PubConstants.DATA_WXUSER, whereMap);
		 sub_map.put("ycount", bycount);
		 
		 String json = JSONArray.fromObject(sub_map).toString();
	     Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		 
		} 
		
	}
	/**
	 * 获取黄页数据
	 */
	public  void   gethousecount(){
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		int usertype=SpringSecurityUtils.getCurrentUser().getType();
		custid=SpringSecurityUtils.getCurrentUser().getId();
		if(usertype==2){
		 whereMap.put("custid", custid);
		 Long count=basedao.getCount(PubConstants.WX_COMPANY, whereMap);
		 sub_map.put("count", count);
		 String rq=BaseDate.RelativeDate(BaseDate.getDate(),-1);
		 whereMap.put("createdate",  new BasicDBObject("$lte",DateFormat.getFormat(rq + " 23:59:59")).append("$gte", DateFormat.getFormat(rq + " 00:00:00")));
		 long zrcount=basedao.getCount(PubConstants.WX_COMPANY, whereMap);
		 sub_map.put("zcount", zrcount);
		 whereMap.put("createdate", new BasicDBObject("$gt", BaseDate.getDay(new Date(), -30)));
	     long bycount=basedao.getCount(PubConstants.WX_COMPANY, whereMap);
		 sub_map.put("ycount", bycount);
		 sub_map.put("reading", wwzservice.getFlow(custid, "house"));
		 String json = JSONArray.fromObject(sub_map).toString();
	     Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		 
		} 
		
	}
	/**
	 * 获取论坛数据
	 */
	public  void   getbbscount(){
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		int usertype=SpringSecurityUtils.getCurrentUser().getType();
		custid=SpringSecurityUtils.getCurrentUser().getId();
		if(usertype==2){
		 whereMap.put("custid",custid );
		 Long count=basedao.getCount(PubConstants.BBS_INFO, whereMap);
		 sub_map.put("count", count);
		 String rq=BaseDate.RelativeDate(BaseDate.getDate(),-1);
		 whereMap.put("createdate",  new BasicDBObject("$lte",DateFormat.getFormat(rq + " 23:59:59")).append("$gte", DateFormat.getFormat(rq + " 00:00:00")));
		 long zrcount=basedao.getCount(PubConstants.BBS_INFO, whereMap);
		 sub_map.put("zcount", zrcount);
		 whereMap.put("createdate", new BasicDBObject("$gt", BaseDate.getDay(new Date(), -30)));
	     long bycount=basedao.getCount(PubConstants.BBS_INFO, whereMap);
		 sub_map.put("ycount", bycount);
		 sub_map.put("reading", wwzservice.getFlow(custid, "bbs"));
		 String json = JSONArray.fromObject(sub_map).toString();
	     Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		 
		} 
		
	}
	/**
	 * 获取商城数据
	 */
	public  void   getshopcount(){
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		int usertype=SpringSecurityUtils.getCurrentUser().getType();
		custid=SpringSecurityUtils.getCurrentUser().getId();
		if(usertype==2){
		 whereMap.put("custid",custid );
		 Long count=basedao.getCount(PubConstants.WX_ORDERFORM, whereMap);
		 sub_map.put("count", count);
		 String rq=BaseDate.RelativeDate(BaseDate.getDate(),-1);
		 whereMap.put("createdate",  new BasicDBObject("$lte",DateFormat.getFormat(rq + " 23:59:59")).append("$gte", DateFormat.getFormat(rq + " 00:00:00")));
		 long zrcount=basedao.getCount(PubConstants.WX_ORDERFORM, whereMap);
		 sub_map.put("zcount", zrcount);
		 whereMap.put("createdate", new BasicDBObject("$gt", BaseDate.getDay(new Date(), -30)));
	     long bycount=basedao.getCount(PubConstants.WX_ORDERFORM, whereMap);
		 sub_map.put("ycount", bycount);
		 sub_map.put("reading", wwzservice.getFlow(custid, "shop"));
		 String json = JSONArray.fromObject(sub_map).toString();
	     Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		 
		} 
		
	}
	/**
	 * 网站模块流量统计
	 * @throws Exception
	 */
	public void getHmenuReading() throws Exception {
		Map<String, Object> sub_map = new HashMap<String, Object>();
		custid=SpringSecurityUtils.getCurrentUser().getId();
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		HashMap<String, Object> backMap =new HashMap<String, Object>();
		
		backMap.put("_id", 1);
		backMap.put("name", 1);
		whereMap.put("custid", custid);
		Pattern pattern = Pattern.compile("^.*wxmenu-.*$",Pattern.CASE_INSENSITIVE);
		whereMap.put("type", pattern);
		sortMap.put("count", -1);
		
		List<DBObject> list=basedao.getList(PubConstants.WWZ_FLOW,whereMap,0,20, sortMap);
		
		List<HashMap<String, Object>> list1=new ArrayList<HashMap<String, Object>>();
		
		for(DBObject db:list){
			HashMap<String, Object> m=new HashMap<String, Object>();
			
			String type=db.get("type").toString().replace("wxmenu-", "");
			String title=GetAllFunc.wxtitle.get(custid + type);
			if(StringUtils.isEmpty(type)||StringUtils.isEmpty(title)){
				m.put("y", type);
			}else{
				m.put("y", title);
			}
			
			m.put("a", (Integer)db.get("count"));
			list1.add(m);
		}
		sub_map.put("list", list1);
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 发送邮件
	 * @param email
	 * @param id
	 */
	public  void   sendemail(String email,String id){
		Email  emailInfo=new Email();
		try {
			emailInfo.setFromAddress(javax.mail.internet.MimeUtility.encodeText("邑联科技")+" "+SysConfig.getProperty("eaddress"));
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} 
		emailInfo.setToAddress(email); 
		emailInfo.setUserName(SysConfig.getProperty("eusername"));
		emailInfo.setPassword(SysConfig.getProperty("epassword"));
		emailInfo.setType("text/html;charset=UTF-8");
		emailInfo.setHost(SysConfig.getProperty("ehost"));
		emailInfo.setHostType("smtp");
		emailInfo.setSubject("恭喜您成为邑联科技的会员");
		String content="";
		content+="<div style='padding: 20px;'><font size='3'><div>亲爱的用户"+id+":</div></font>" 
		       +"<div style='padding-top: 10px;padding-bottom: 10px;'>您好！欢迎您加入邑联，请立即点击下列按钮（链接）激活您的帐号。</div>"
			   +"<a href='"+SysConfig.getProperty("ip")+"/user/user!activate.action?id="+id+"'><div style='padding-bottom: 10px;'>此处是验证连接</div></a>"
		       +"<div style='padding-bottom: 10px;'>此信息由系统自动发送，请勿回复！</div></div>";
		emailInfo.setContent(content);
		try {
			EmailUtils.sendHtmlEmail(emailInfo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * 激活账号
	 */
	public String activate(){
		String  account=Struts2Utils.getParameter("id"); 
		HashMap<String,Object>whereMap=new HashMap<String, Object>();
		whereMap.put("account",account);
		List<DBObject>list=basedao.getList(PubConstants.USER_INFO, whereMap,null);
		if(list.size()==1&&list.get(0).get("createdate")==null){
			whereMap.clear();
			whereMap.put("rolename","免费用户");
			List<DBObject> lsrl=basedao.getList(PubConstants.ROLE_INFO, whereMap, null);
			
			UserInfo  info=(UserInfo) UniObject.DBObjectToObject(list.get(0), UserInfo.class);
			info.setCreatedate(new Date());
			if(lsrl.size()>0){
				info.setRoleid(Long.parseLong(lsrl.get(0).get("_id").toString()));
			}
			basedao.insert(PubConstants.USER_INFO, info); 
		}
		return "activate"; 
	}
	/**
	 * 激活账号
	 */
	public void   ajaxactivate(){
		Map<String, Object>sub_Map=new HashMap<String, Object>();
		String  account=Struts2Utils.getParameter("account");
		HashMap<String,Object>whereMap=new HashMap<String, Object>();
		whereMap.put("account",account);
		List<DBObject>list=basedao.getList(PubConstants.USER_INFO, whereMap,null);
		if(list.size()==1){
			UserInfo  info=(UserInfo) UniObject.DBObjectToObject(list.get(1), UserInfo.class);
			info.setCreatedate(new Date());
			basedao.insert(PubConstants.USER_INFO, info);
			sub_Map.put("state",0);
		}
		String json = JSONArray.fromObject(sub_Map).toString();
	    Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 注册
	 * @return
	 */
	public String  register(){
		//加载区域（默认）
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		whereMap.put("account", "admin");
		DBObject  db=basedao.getMessage(PubConstants.USER_INFO, whereMap);
		if(db!=null){
			Struts2Utils.getRequest().setAttribute("id", db.get("_id"));
		} 
		return "register"; 
	}
	 
}