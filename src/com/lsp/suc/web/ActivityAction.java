package com.lsp.suc.web;

import java.net.URLEncoder;
import java.util.Date;
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
import com.lsp.pub.util.BaseDate;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.DateUtil;
import com.lsp.pub.util.JmsService;
import com.lsp.pub.util.RelativeDate;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.TenpayUtil;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.web.GeneralAction; 
import com.lsp.suc.entity.ActivityCard;
import com.lsp.suc.entity.ActivityDetail;
import com.lsp.suc.entity.ActivityInfo;
import com.lsp.suc.entity.ActivityYd; 
import com.lsp.suc.entity.RewardRecord;
import com.lsp.suc.entity.Share;
import com.lsp.website.service.WwzService;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;

 
/**
 * 活动总管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name ="reload", location = "activity.action",params={"fypage","%{fypage}"}, type = "redirect") })
public class ActivityAction extends GeneralAction<ActivityInfo>{

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
	
	private ActivityInfo entity=new ActivityInfo();
	private Long _id;


	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		HashMap<String, Object> backMap =new HashMap<String, Object>();
		
		custid=SpringSecurityUtils.getCurrentUser().getId();
		sortMap.put("sort", -1); 
		whereMap.put("custid", custid);
		String title=Struts2Utils.getParameter("title");
		if(StringUtils.isNotEmpty(title)){
			Pattern pattern = Pattern.compile("^.*" + title + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern);
			Struts2Utils.getRequest().setAttribute("title",  title);
		}
	 
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		backMap.put("content", 0);
		List<DBObject> list=baseDao.getList(PubConstants.SUC_ACTIVITYINFO,whereMap,fypage,10,sortMap,backMap);
		fycount=baseDao.getCount(PubConstants.SUC_ACTIVITYINFO,whereMap);
		Struts2Utils.getRequest().setAttribute("list", list);
		Struts2Utils.getRequest().setAttribute("custid", custid);
		
		return SUCCESS;
	}


	@Override
	public ActivityInfo getModel() {
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
		Struts2Utils.getRequest().setAttribute("entity",baseDao.getMessage(PubConstants.SUC_ACTIVITYINFO, _id));
		return "add";
	}
	public void upd() throws Exception { 
		DBObject db = baseDao.getMessage(PubConstants.SUC_ACTIVITYINFO, _id); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}


	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id==null){
				_id=mongoSequence.currval(PubConstants.SUC_ACTIVITYINFO); 
			}  
			String custid=SpringSecurityUtils.getCurrentUser().getId(); 
			entity.set_id(_id); 
			entity.setCustid(custid);
			entity.setCreatedate(new Date());
			entity.setEwmurl(wwzService.recode("activity-mbTicket-"+_id,SysConfig.getProperty("ip")+"/suc/activity!mbTicket.action?custid="+custid+"&id="+_id, entity.getPicurl(),true, 200, 1000));
			baseDao.insert(PubConstants.SUC_ACTIVITYINFO, entity);
			addActionMessage("添加成功");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			addActionMessage("添加失败");
		}
		return RELOAD;
	}
	
	 
	 

	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub 
		String custid=SpringSecurityUtils.getCurrentUser().getId();
		HashMap<String,Object>whereMap=new HashMap<String, Object>();
		whereMap.put("_id", _id);
		whereMap.put("custid",custid);
		baseDao.delete(PubConstants.SUC_ACTIVITYINFO, whereMap);
		return RELOAD;
	}


	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id!=null){
				DBObject db=baseDao.getMessage(PubConstants.SUC_ACTIVITYINFO, _id);
				entity= (ActivityInfo) UniObject.DBObjectToObject(db, ActivityInfo.class);
			}else{
				entity=new ActivityInfo();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	 	
	}
	public void set_id(Long _id) {
		this._id = _id;
	}
    public  String  web(){
		return "web"; 
    }
    /**
     * 活动详情
     * @return
     */
    public  String  detail(){
    	String  id=Struts2Utils.getParameter("id");
    	String custid=SpringSecurityUtils.getCurrentUser().getId();
    	HashMap<String, Object>whereMap=new HashMap<>();
    	HashMap<String, Object>sortMap=new HashMap<>();
    	whereMap.put("ydid", id);
    	sortMap.put("createdate", -1);
    	if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
    		fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
    	}
    	List<DBObject>list=baseDao.getList(PubConstants.SUC_ACTIVITYDETAIL, whereMap,fypage,10, sortMap);
    	fycount=baseDao.getCount(PubConstants.SUC_ACTIVITYDETAIL, whereMap);
    	for (DBObject dbObject : list) {
			if(dbObject.get("fromUserid")!=null){
				DBObject  db=wwzService.getWxUser(dbObject.get("fromUserid").toString());
				dbObject.put("headimgurl",db.get("headimgurl"));
				dbObject.put("nickname",db.get("nickname"));
			}
			if(dbObject.get("createdate")!=null){
				dbObject.put("createdate", RelativeDate.format(DateFormat.getFormat(dbObject.get("createdate").toString()), new Date()));
			}
		}
    	Struts2Utils.getRequest().setAttribute("id",id);
    	Struts2Utils.getRequest().setAttribute("list",list);
		return "detail"; 
    }
    /**
     * 预订管理
     * @return
     */
    public  String  yd(){
    	String  id=Struts2Utils.getParameter("id");
    	String custid=SpringSecurityUtils.getCurrentUser().getId();
    	HashMap<String, Object>whereMap=new HashMap<>();
    	HashMap<String, Object>sortMap=new HashMap<>();
    	whereMap.put("wid", Long.parseLong(id));
    	sortMap.put("createdate", -1);
    	if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
    		fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
    	}
    	List<DBObject>list=baseDao.getList(PubConstants.SUC_ACTIVITYYD, whereMap,fypage,10, sortMap);
    	fycount=baseDao.getCount(PubConstants.SUC_ACTIVITYYD, whereMap);
    	for (DBObject dbObject : list) {
			if(dbObject.get("fromUserid")!=null){
				DBObject  db=wwzService.getWxUser(dbObject.get("fromUserid").toString());
				dbObject.put("headimgurl",db.get("headimgurl"));
				dbObject.put("nickname",db.get("nickname"));
			}
			if(dbObject.get("createdate")!=null){
				dbObject.put("createdate", RelativeDate.format(DateFormat.getFormat(dbObject.get("createdate").toString()), new Date()));
			}
		}
    	Struts2Utils.getRequest().setAttribute("id",id);
    	Struts2Utils.getRequest().setAttribute("list",list);
		return "yd"; 
    }
    
    /**
     * 卡卷管理
     * @return
     */
    public  String  card(){
    	String  id=Struts2Utils.getParameter("id");
    	String custid=SpringSecurityUtils.getCurrentUser().getId();
    	HashMap<String, Object>whereMap=new HashMap<>();
    	HashMap<String, Object>sortMap=new HashMap<>();
    	whereMap.put("hdid", Long.parseLong(id));
    	sortMap.put("createdate", -1);
    	if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
    		fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
    	}
    	List<DBObject>list=baseDao.getList(PubConstants.SUC_ACTIVITYCARD, whereMap,fypage,10, sortMap);
    	fycount=baseDao.getCount(PubConstants.SUC_ACTIVITYCARD, whereMap);
    	Struts2Utils.getRequest().setAttribute("list",list);
		return "card"; 
    }
    /**
     * 手机预订列表
     * @return
     */
    public  String  webydlb(){
    	getLscode(); 
    	WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/suc/activity!webydlb.action?custid="+custid;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
		return "webydlb"; 	
    }
    /**
     * 手机预订
     * @return
     */
    public  String  webyd(){
    	getLscode();
    	String id=Struts2Utils.getParameter("id");
    	WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/suc/activity!webyd.action?custid="+custid+"&id="+id;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}
		DBObject  db=baseDao.getMessage(PubConstants.SUC_ACTIVITYYD, id);
		DBObject  obj=baseDao.getMessage(PubConstants.SUC_ACTIVITYINFO,Long.parseLong(db.get("wid").toString()));
		if(obj!=null){
			ActivityYd inf=(ActivityYd) UniObject.DBObjectToObject(db, ActivityYd.class);
			double bl= inf.getObj().getPrice()/Double.parseDouble(obj.get("price").toString());  
			db.put("oldprice",obj.get("price"));
			db.put("bl",new java.text.DecimalFormat("#").format(bl*100));
			DBObject  share=new BasicDBObject();
			if(inf.getObj().getType()==0){
				share.put("fxtitle","砍价("+inf.getObj().getTitle()+")");
			} 
			share.put("fximg", wwzService.getWxUsertype(db.get("fromUserid").toString(),"headimgurl"));
			share.put("fxsummary", inf.getObj().getSummary());
			share.put("fxurl",url);
			Struts2Utils.getRequest().setAttribute("share", share);
		} 
		db.put("headimgurl",wwzService.getWxUsertype(db.get("fromUserid").toString(), "headimgurl"));
		db.put("nickname",wwzService.getWxUsertype(db.get("fromUserid").toString(), "nickname"));
		Struts2Utils.getRequest().setAttribute("entity",db);
		
		return "webyd"; 
    }
    /**
     * 手机卡卷管理
     * @return
     */
    public  String  webcard(){
    	getLscode(); 
    	WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/suc/activity!webcard.action?custid="+custid;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
		return "webcard"; 
    }
    /**
     * 手机活动详情
     * @return
     */
    public  String  webdetail(){
    	getLscode();
    	String id=Struts2Utils.getParameter("id");
    	WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/suc/activity!webdetail.action?custid="+custid+"&id="+id;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}
		DBObject  db=baseDao.getMessage(PubConstants.SUC_ACTIVITYINFO, Long.parseLong(id));
		Struts2Utils.getRequest().setAttribute("entity",db);
		DBObject  share=new BasicDBObject(); 
		if(db!=null){
			if(db.get("type")!=null&&Integer.parseInt(db.get("type").toString())==0){
				share.put("fxtitle","砍价("+db.get("title")+")");
			}
			share.put("fximg",db.get("picurl")); 
			share.put("fxsummary", db.get("summary"));
			share.put("fxurl",url);
			Struts2Utils.getRequest().setAttribute("share", share);
		}
		
		return "webdetail"; 
    }
    /**
     * ajax获取活动列表
     */
    public  void    ajaxweb(){
    	getLscode(); 
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
	    HashMap<String, Object>sortMap=new HashMap<String, Object>(); 
		whereMap.put("custid",custid);
		whereMap.put("isxs",0);
		sortMap.put("sort", -1);
		String sel=Struts2Utils.getParameter("sel");
		if(StringUtils.isNotEmpty(sel)){
			Pattern pattern = Pattern.compile("^.*" + sel + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern); 
		}
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject>list=baseDao.getList(PubConstants.SUC_ACTIVITYINFO, whereMap,fypage,12,sortMap);
		if(list.size()>0){
			sub_map.put("state", 0);
			sub_map.put("list",list);
		} 
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    }
    /**
     * ajax获取个人预订列表
     */
    public  void    ajaxydweb(){
    	getLscode();  
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
		    HashMap<String, Object>sortMap=new HashMap<String, Object>(); 
			whereMap.put("custid",custid);
			whereMap.put("fromUserid",fromUserid);
			sortMap.put("createdate", -1);
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			List<DBObject>list=baseDao.getList(PubConstants.SUC_ACTIVITYYD, whereMap,fypage,10,sortMap);
			if(list.size()>0){
				sub_map.put("state", 0);
				for (DBObject dbObject : list) {
					if(dbObject.get("fromUserid")!=null){
						DBObject  db=wwzService.getWxUser(dbObject.get("fromUserid").toString());
						dbObject.put("headimgurl",db.get("headimgurl"));
						dbObject.put("nickname",db.get("nickname"));
					}
					if(dbObject.get("createdate")!=null){
						dbObject.put("createdate", RelativeDate.format(DateFormat.getFormat(dbObject.get("createdate").toString()), new Date()));
					}
				}
				sub_map.put("list",list);
			}  
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    }
    /**
     * ajax获取预订列表
     */
    public  void    ajaxydweblist(){
    	getLscode();  
		Map<String, Object> sub_map = new HashMap<String, Object>();
		    String id=Struts2Utils.getParameter("id");
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
		    HashMap<String, Object>sortMap=new HashMap<String, Object>(); 
		    HashMap<String, Object>backMap=new HashMap<String, Object>();
		    backMap.put("obj",0);
			whereMap.put("custid",custid); 
			whereMap.put("wid",Long.parseLong(id));
			sortMap.put("createdate", -1);
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			List<DBObject>list=baseDao.getList(PubConstants.SUC_ACTIVITYYD, whereMap,0,50,sortMap,backMap);
			if(list.size()>0){
				sub_map.put("state", 0);
				for (DBObject dbObject : list) {
					if(dbObject.get("fromUserid")!=null){
						DBObject  db=wwzService.getWxUser(dbObject.get("fromUserid").toString());
						dbObject.put("headimgurl",db.get("headimgurl"));
						dbObject.put("nickname",db.get("nickname"));
					}
					if(dbObject.get("createdate")!=null){
						dbObject.put("createdate", RelativeDate.format(DateFormat.getFormat(dbObject.get("createdate").toString()), new Date()));
					}
				}
				sub_map.put("list",list);
			}  
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    }
    /**
     * ajax获取卡卷列表
     */
    public  void    ajaxcardweb(){
    	getLscode(); 
    	String  id=Struts2Utils.getParameter("id");
		Map<String, Object> sub_map = new HashMap<String, Object>();
		if(StringUtils.isNotEmpty(id)){
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
		    HashMap<String, Object>sortMap=new HashMap<String, Object>(); 
			whereMap.put("custid",custid);
			whereMap.put("hdid",Long.parseLong(id));
			sortMap.put("createdate", -1);
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			List<DBObject>list=baseDao.getList(PubConstants.SUC_ACTIVITYCARD, whereMap,fypage,12,sortMap);
			if(list.size()>0){
				sub_map.put("state", 0);
				sub_map.put("list",list);
			} 
		} 
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    }
    /**
     * ajax获取活动详情列表
     */
    public  void    ajaxdetailweb(){
    	getLscode(); 
    	String  id=Struts2Utils.getParameter("id");
		Map<String, Object> sub_map = new HashMap<String, Object>();
		if(StringUtils.isNotEmpty(id)){
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
		    HashMap<String, Object>sortMap=new HashMap<String, Object>();  
			whereMap.put("ydid",id);
			sortMap.put("createdate", -1);
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			List<DBObject>list=baseDao.getList(PubConstants.SUC_ACTIVITYDETAIL, whereMap,fypage,12,sortMap);
			if(list.size()>0){
				sub_map.put("state", 0);
				for (DBObject dbObject : list) {
					if(dbObject.get("fromUserid")!=null){
						DBObject  db=wwzService.getWxUser(dbObject.get("fromUserid").toString());
						dbObject.put("headimgurl",db.get("headimgurl"));
						dbObject.put("nickname",db.get("nickname"));
					}
					if(dbObject.get("createdate")!=null){
						dbObject.put("createdate", RelativeDate.format(DateFormat.getFormat(dbObject.get("createdate").toString()), new Date()));
					}
				}
				sub_map.put("list",list);
			} 
		} 
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    }
    /**
     * ajax预订活动
     */
    public  void    ajaxyd(){
    	getLscode();
    	Map<String, Object> sub_map = new HashMap<String, Object>();
    	String id=Struts2Utils.getParameter("id");
    	if(StringUtils.isNotEmpty(id)){
    		DBObject  db=baseDao.getMessage(PubConstants.SUC_ACTIVITYINFO, Long.parseLong(id));
    		if(db!=null){
    			//库存已完
    			if(Integer.parseInt(db.get("num").toString())<=0){
    				sub_map.put("state",1);  
    			}else{
    				//验证是否重复预订
    				HashMap<String, Object>whereMap=new HashMap<>();
    				whereMap.put("wid",Long.parseLong(id));
    				whereMap.put("fromUserid",fromUserid);
    				List<DBObject> list=baseDao.getList(PubConstants.SUC_ACTIVITYYD,whereMap,null);
    				if(list.size()>=1){
    					sub_map.put("state", 2);
    					sub_map.put("value",list.get(0).get("_id"));  
    				}else{
    					if(Float.parseFloat(db.get("jfdh").toString())>0&&!wwzService.deljf(db.get("jfdh").toString(),fromUserid, "activity-kj", custid,null)){
    						sub_map.put("state", 3); 
    						String json = JSONArray.fromObject(sub_map).toString();
    						Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    						return ;
    					}
    					String  code=DateFormat.getDate()+TenpayUtil.buildRandom(6)+mongoSequence.currval(PubConstants.SUC_ACTIVITYYD);
    					ActivityYd  yd=new ActivityYd();
    					yd.set_id(code);
    					yd.setCreatedate(new Date());
    					yd.setCustid(custid);
    					yd.setFromUserid(fromUserid);
    					yd.setWid(Long.parseLong(id));
    					yd.setObj((ActivityInfo)UniObject.DBObjectToObject(db, ActivityInfo.class));
    					baseDao.insert(PubConstants.SUC_ACTIVITYYD, yd);
    					sub_map.put("state", 0);
    					sub_map.put("value", code);
    					JmsService.permessageMessage(custid, fromUserid,"活动预订提醒", "用户:"+wwzService.getWxUsertype(fromUserid, "nickname")+"预订了 "+db.get("title")+" 活动",null, null,"3","activity-yd");
    				}
    			}
    		}
    	}
    	String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    }
    /**
     * ajax参与活动
     */
    public  void    ajaxplay(){
    	getLscode();
    	String id=Struts2Utils.getParameter("id");
    	Map<String, Object> sub_map = new HashMap<String, Object>();
    	if(StringUtils.isNotEmpty(id)){
    		DBObject  db=baseDao.getMessage(PubConstants.SUC_ACTIVITYYD,id);
    		if(db!=null){
    			ActivityYd yd=(ActivityYd)UniObject.DBObjectToObject(db, ActivityYd.class);
    			//验证库存
    			DBObject  info=baseDao.getMessage(PubConstants.SUC_ACTIVITYINFO,yd.getWid());
    			if(Integer.parseInt(info.get("num").toString())<=0){
    				//库存已完
    				sub_map.put("state", 1);
    			}else{
    				//验证活动底线
    				if(yd.getObj().getPrice()<=yd.getObj().getLowprice()){
    					//活动到底
        				sub_map.put("state", 2);
    				}else{
    					//验证重复
    					HashMap<String, Object>whereMap=new HashMap<>();
    					whereMap.put("ydid", id);
    					whereMap.put("fromUserid", fromUserid);
    					Long count=baseDao.getCount(PubConstants.SUC_ACTIVITYDETAIL, whereMap); 
    					if(count>0){ 
    						//重复参与
            				sub_map.put("state", 3);
    					}else{
    						ActivityInfo  act=(ActivityInfo) UniObject.DBObjectToObject(info, ActivityInfo.class);
    						ActivityInfo  ob=yd.getObj();
    						if(ob.getJfcy()>0&&!wwzService.deljf(ob.getJfcy()+"",fromUserid, "activity-cy", custid,null)){
        						sub_map.put("state", 4); 
        						String json = JSONArray.fromObject(sub_map).toString();
        						Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
        						return ;
        					} 
    						float iprice=0;
    						float  price=TenpayUtil.buildRandom(1);
    						double isprice=act.getPrice()/act.getPcount();
    						if(isprice<10&&isprice>1){
    							price=TenpayUtil.buildRandom(1)*0.1f;
    						}else if(isprice<1&&isprice>0.1){
    							price=TenpayUtil.buildRandom(1)*0.01f;
    						}
    						int  fprice=TenpayUtil.buildRandom(1); 
    						if(fprice>5){
    							iprice=(float)((act.getPrice()-act.getLowprice())/act.getPcount()-price);
    						}else{
    							iprice=(float)((act.getPrice()-act.getLowprice())/act.getPcount()+price);
    						} 
    						if(iprice>0&&iprice<=ob.getPrice()-ob.getLowprice()&&ob.getPrice()-ob.getLowprice()>0){ 
    							ob.setPrice(ob.getPrice()-iprice);
    							yd.setObj(ob); 
    							baseDao.insert(PubConstants.SUC_ACTIVITYYD, yd);
    							//记录用户
    							ActivityDetail  obj=new ActivityDetail(); 
    							obj.set_id(mongoSequence.currval(PubConstants.SUC_ACTIVITYDETAIL)); 
    							obj.setFromUserid(fromUserid);
    							obj.setYdid(id);
    							obj.setKjprice(iprice);
    							obj.setCreatedate(new Date());
    							baseDao.insert(PubConstants.SUC_ACTIVITYDETAIL, obj); 
    							if(ob.getPrice()<=ob.getLowprice()){
    								ActivityInfo ac=(ActivityInfo) UniObject.DBObjectToObject(info, ActivityInfo.class);
    								if(ac.getNum()-1>=0){
    									ac.setNum(ac.getNum()-1);
    									ac.setGmnum(ac.getGmnum()+1); 
    								}
    								baseDao.insert(PubConstants.SUC_ACTIVITYINFO, ac);
    								//生成卡卷 
    								RewardRecord  rr=new RewardRecord();
    								String yhjid=BaseDate.generateShortUuid().toUpperCase();
    								rr.set_id(mongoSequence.currval(PubConstants.WHD_REWARDRECORD));
    								rr.setCustid(custid);
    								rr.setHdid(Long.parseLong(yd.get_id().toString()));
    								rr.setLx(2);
    								rr.setInsDate(new Date());
    								rr.setState(0);
    								rr.setHdtitle(act.getTitle()); 
    								rr.setJp(act.getTitle()+"-"+act.getLowprice()+"元兑换卷");
    								rr.setYhj(yhjid);
    								rr.setDjenddate(act.getDjenddate());
    								rr.setFromUserid(yd.getFromUserid()); 
    								baseDao.insert(PubConstants.WHD_REWARDRECORD, rr);
    							}
    							
    							sub_map.put("value",obj.getKjprice());
    							sub_map.put("state",0);
    						}else if(iprice>ob.getPrice()-ob.getLowprice()&&ob.getPrice()-ob.getLowprice()>0){ 
    							ob.setPrice(Double.parseDouble(ob.getLowprice()+""));
    							yd.setObj(ob);
    							baseDao.insert(PubConstants.SUC_ACTIVITYYD, yd);
    							//记录用户
    							ActivityDetail  obj=new ActivityDetail();
    							obj.set_id(mongoSequence.currval(PubConstants.SUC_ACTIVITYDETAIL)); 
    							obj.setFromUserid(fromUserid);
    							obj.setYdid(id);
    							obj.setKjprice(iprice);
    							obj.setCreatedate(new Date());
    							baseDao.insert(PubConstants.SUC_ACTIVITYDETAIL, obj);
    							//更新库存 
    							if(ob.getPrice()<=ob.getLowprice()){
    								ActivityInfo ac=(ActivityInfo) UniObject.DBObjectToObject(info, ActivityInfo.class);
    								if(ac.getNum()-1>=0){ 
    									ac.setNum(ac.getNum()-1);
    									ac.setGmnum(ac.getGmnum()+1);
    								}
    								baseDao.insert(PubConstants.SUC_ACTIVITYINFO, ac);
    								
    								//生成卡卷  
    								RewardRecord  rr=new RewardRecord();
    								String yhjid=BaseDate.generateShortUuid().toUpperCase();
    								rr.set_id(mongoSequence.currval(PubConstants.WHD_REWARDRECORD));
    								rr.setCustid(custid);
    								rr.setHdid(Long.parseLong(yd.get_id().toString()));
    								rr.setLx(2);
    								rr.setInsDate(new Date());
    								rr.setState(0);
    								rr.setHdtitle(act.getTitle()); 
    								rr.setJp(act.getTitle()+"-"+act.getLowprice()+"元兑换卷");
    								rr.setYhj(yhjid);
    								rr.setDjenddate(act.getDjenddate());
    								rr.setFromUserid(yd.getFromUserid()); 
    								baseDao.insert(PubConstants.WHD_REWARDRECORD, rr);
    							}
    							sub_map.put("value",obj.getKjprice());
    							sub_map.put("state",0);
    						}  
    						JmsService.permessageMessage(custid, fromUserid,"活动参与提醒", "用户:"+wwzService.getWxUsertype(fromUserid, "nickname")+"参与 "+yd.getObj().getTitle()+" 活动",null, null,"3","activity-play");
    					}
    				}
    			}
    			 
    		}
    	} 
    	String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    }
    /**
     * ajax删除预订
     */
    public  void   ajaxdelkj(){
    	getLscode();
    	Map<String, Object> sub_map = new HashMap<String, Object>();
    	String id=Struts2Utils.getParameter("id");
    	if(StringUtils.isNotEmpty(id)){
    		baseDao.delete(PubConstants.SUC_ACTIVITYYD, id);
    		sub_map.put("state", 0);
    	}
    	String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    } 
    /**
	 * 手机扫码兑奖
	 */
	public String mbTicket(){
		getLscode(); 
		Struts2Utils.getRequest().setAttribute("custid",custid);
		String  id=Struts2Utils.getParameter("id");
		WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		}
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/activity!mbTicket.action?custid="+custid+"&id="+id;  
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
		if(StringUtils.isNotEmpty(id)){
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			whereMap.put("wid", Long.parseLong(id));
			whereMap.put("fromUserid", fromUserid);
			whereMap.put("custid",custid);
			DBObject  yd=baseDao.getMessage(PubConstants.SUC_ACTIVITYYD, whereMap);
			if(yd!=null){
				whereMap.clear();
				whereMap.put("hdid", Long.parseLong(yd.get("_id").toString()));
				whereMap.put("fromUserid", fromUserid);
				whereMap.put("custid",custid);
				whereMap.put("lx",2);
				DBObject  card=baseDao.getMessage(PubConstants.WHD_REWARDRECORD, whereMap);
				if(card!=null){
					RewardRecord rr=(RewardRecord) UniObject.DBObjectToObject(card, RewardRecord.class);
					if(DateUtil.checkbig(rr.getDjenddate())){
						if(rr.getState()==0){
							//未兑奖
							rr.setState(1);
							baseDao.insert(PubConstants.WHD_REWARDRECORD, rr);
							Struts2Utils.getRequest().setAttribute("state", 0);
							Struts2Utils.getRequest().setAttribute("jp",rr.getJp());
						}else{
							//已兑奖
							Struts2Utils.getRequest().setAttribute("state", 4);
							Struts2Utils.getRequest().setAttribute("jp",rr.getJp());
						} 
						
					 }else{
						 //过期
						 rr.setState(2);
					     baseDao.insert(PubConstants.WHD_REWARDRECORD, rr);
						 Struts2Utils.getRequest().setAttribute("state", 3); 
						 Struts2Utils.getRequest().setAttribute("jp",rr.getJp());
					 } 
				}else{
					Struts2Utils.getRequest().setAttribute("state", 1);
				}
				
			}
			
		}
		
		return "mbticket"; 
	}
	/**
	 * ajax生成兑奖二维码
	 */
	public  void  ajaxcreateewm(){
		custid=SpringSecurityUtils.getCurrentUser().getId();
		String id=Struts2Utils.getParameter("id");
		Map<String, Object> sub_map = new HashMap<String, Object>();
		if(StringUtils.isNotEmpty(id)){
			DBObject  db=baseDao.getMessage(PubConstants.SUC_ACTIVITYINFO,Long.parseLong(id));
			if(db!=null){
				ActivityInfo  activityInfo=(ActivityInfo) UniObject.DBObjectToObject(db, ActivityInfo.class);
				activityInfo.setEwmurl(wwzService.recode("activity-mbTicket-"+id,SysConfig.getProperty("ip")+"/suc/activity!mbTicket.action?custid="+custid+"&id="+id, activityInfo.getPicurl(),true, 200, 1000));
				baseDao.insert(PubConstants.SUC_ACTIVITYINFO,activityInfo);
				sub_map.put("state", 0);
				sub_map.put("value",activityInfo.getEwmurl());
			}
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
   

}
