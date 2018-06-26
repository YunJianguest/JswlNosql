package com.lsp.suc.web;
 
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.URLEncoder; 
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap; 
import java.util.List;
import java.util.Map; 
import java.util.SortedMap;
import java.util.TreeMap;
import java.util.regex.Pattern; 

import net.sf.json.JSONArray;

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
import com.lsp.pub.util.BaseDecimal; 
import com.lsp.pub.util.CommonUtil;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.DateUtil;
import com.lsp.pub.util.DictionaryUtil; 
import com.lsp.pub.util.PayCommonUtil;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.TenpayUtil;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.util.XMLUtil;
import com.lsp.pub.web.GeneralAction; 
import com.lsp.shop.entiy.OrderForm;
import com.lsp.suc.entity.BbsInfo; 
import com.lsp.suc.entity.Bbscomments;
import com.lsp.suc.entity.Bbspraise;
import com.lsp.suc.entity.Bbsreading; 
import com.lsp.suc.entity.Exceptional;
import com.lsp.website.service.WwzService; 
import com.lsp.weixin.entity.WxPayConfig; 
 
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import com.sun.org.apache.bcel.internal.generic.NEW; 
/**
 * 论坛
 * @author lsp
 *　我们使用下面的比较操作符"$gt" 、"$gte"、 "$lt"、 "$lte"(分别对应">"、 ">=" 、"<" 、"<=")  $nin  不包含  $in 包含，$ne不等于
 */
@Namespace("/suc")
@Results({@Result(name= BbsAction.RELOAD, location="bbs.action",params={"fypage", "%{fypage}"}, type="redirect")})
public class BbsAction extends GeneralAction<BbsInfo> {
	private static final long serialVersionUID = -6201497505112403306L;
	@Autowired
	private BaseDao baseDao;
	private BbsInfo entity = new BbsInfo();
	private Long _id;

	private MongoSequence mongoSequence;
	@Autowired
	private WwzService wwzService;
	@Autowired
	private DictionaryUtil dictionaryUtil;
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}

	@Override
	public String execute() throws Exception { 
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		HashMap<String, Object> backMap =new HashMap<String, Object>(); 
		custid=SpringSecurityUtils.getCurrentUser().getId(); 
		sortMap.put("createdate", -1); 
		whereMap.put("custid", custid);
		String name=Struts2Utils.getParameter("name");
		if(StringUtils.isNotEmpty(name)){
			Pattern pattern = Pattern.compile("^.*" + name + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("content", pattern);
			Struts2Utils.getRequest().setAttribute("name",  name);
		}
	 
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		
		List<DBObject> list=baseDao.getList(PubConstants.BBS_INFO,whereMap,fypage,10,sortMap,backMap); 
		fycount=baseDao.getCount(PubConstants.BBS_INFO,whereMap);
		Struts2Utils.getRequest().setAttribute("bbsList", list);
		Struts2Utils.getRequest().setAttribute("custid", custid);
		
		return SUCCESS;
	}


	/**
	 * 论坛首页
	 * 
	 * @return
	 */
	public String index() {   
		getLscode();
		wwzService.flow(custid, "bbs"); 
		Struts2Utils.getRequest().setAttribute("custid", custid);
		Struts2Utils.getRequest().setAttribute("fid",wwzService.getVipNo(fromUserid));
		WxToken token=GetAllFunc.wxtoken.get(custid); 
		 if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 }
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());  
		String  url=SysConfig.getProperty("ip")+"/suc/bbs!index.action?custid="+custid+"&fid="+Struts2Utils.getParameter("fid");  
		 
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
		Struts2Utils.getRequest().setAttribute("list",
				GetAllFunc.wxFunc.get(custid));  
		//获取用户信息 
		DBObject  user=wwzService.getWxUser(fromUserid);
		if(!user.get("_id").equals("notlogin")){
			double bl= Double.parseDouble(user.get("getExperience").toString())/Double.parseDouble(user.get("needExperience").toString());   
			user.put("expbl",new java.text.DecimalFormat("#").format(bl*100)); 	
		}
		 
		Struts2Utils.getRequest().setAttribute("user",user);
		  
		Struts2Utils.getRequest().setAttribute("type",Struts2Utils.getParameter("type"));
		HashMap<String,Object>whereMap=new HashMap<String, Object>();
		HashMap<String,Object>sortMap=new HashMap<String, Object>();
		whereMap.put("custid",custid);
		sortMap.put("sort",-1);
		List<DBObject>typelist=baseDao.getList(PubConstants.BBSTYPE_INFO, whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("bbstype",typelist);
		
		DBObject  share=baseDao.getMessage(PubConstants.WEIXIN_SHAREFX, custid+"-bbs_share"); 
		share.put("fxurl", url);
		int  bbsll=wwzService.getFlow(custid, "bbs");
		whereMap.clear();
		whereMap.put("custid", custid);
		Long  bbscount=baseDao.getCount(PubConstants.BBS_INFO,whereMap);
		
		//加载广告位
		Struts2Utils.getRequest().setAttribute("advlist",wwzService.getadvertispay(custid)); 
		Struts2Utils.getRequest().setAttribute("bbsll",bbsll);
		Struts2Utils.getRequest().setAttribute("bbscount",bbscount);
		Struts2Utils.getRequest().setAttribute("share", share);
		Struts2Utils.getRequest().setAttribute("slide", wwzService.getslide(custid, "bbs")); 
		if(share!=null&&share.get("fxmb")!=null){
			return "index"+share.get("fxmb").toString();
		} 
		return "index1";
	}
	/**
	 * ajax加载置顶数据
	 */
	public void ajaxstick(){
		//加载置顶帖子
		getLscode();
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		whereMap.put("custid", custid);
		whereMap.put("state", 0);
		sortMap.put("createdate", -1); 
		List<DBObject>zdlist=baseDao.getList(PubConstants.BBS_STICK, whereMap,sortMap);
		List<DBObject>xzlist=new ArrayList<DBObject>();
		if(zdlist.size()>0){
			for (DBObject dbObject : zdlist) {  
				DBObject  bbs=baseDao.getMessage(PubConstants.BBS_INFO, Long.parseLong(dbObject.get("bmtid").toString()));
				if(DateUtil.checksimal(DateFormat.getFormat(dbObject.get("enddate").toString()))){
					BbsInfo  obj=(BbsInfo) UniObject.DBObjectToObject(bbs, BbsInfo.class);
					obj.setStick(0);
					baseDao.insert(PubConstants.BBS_INFO, obj);
				}else{
					
					if (bbs!=null&&bbs.get("createdate")!= null) {
						bbs.put("createdate", DateFormat
								.getSampleDate(DateFormat.getFormat(dbObject.get(
										"createdate").toString())));
						
						 
						//加载用户等级
						bbs.put("level",wwzService.getWxUsertype(bbs.get("fromUserid").toString(),"level"));
						//加载打赏记录
						HashMap<String, Object> excwhereMap=new HashMap<String, Object>();
						excwhereMap.put("type","bbs-"+dbObject.get("_id").toString()); 
						Long expcount=baseDao.getCount(PubConstants.SUC_EXCEPTIONAL, excwhereMap);
						dbObject.put("exceptional", expcount);
						// 加载点赞和评论数据
						whereMap.clear();
						whereMap.put("bmtid",
								Long.parseLong(bbs.get("_id").toString()));
						whereMap.put("parentid", null); 
						Long commentcount = baseDao.getCount(PubConstants.BBS_COMMENTS,
								whereMap); 
						bbs.put("commentcount", commentcount); 
						
						whereMap.clear();
						whereMap.put("type", bbs.get("_id").toString());
						Long  parisecount=baseDao.getCount(PubConstants.BBS_PRAISE,
								whereMap);
						bbs.put("praise", parisecount); 
						String picurl = (String) bbs.get("picurl");
						String picurls[] = null;
						if (StringUtils.isNotEmpty(picurl) && picurl.length() > 0) {
							picurls = picurl.split(",");
							bbs.put("picurls", picurls);
						} else {
							bbs.put("picurls", picurls);
						
						
						dbObject.put("bbs", bbs); 
							
						 } 
					} 
					xzlist.add(dbObject);
				}
				
				
			 }
			if(xzlist.size()>0){
				sub_map.put("state", 0);
				sub_map.put("list", xzlist);
			} 
		}else{
			sub_map.put("state", 1);
		}
		String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1),
				new String[0]);
	}
	  
	 
	/**
	 * ajax加载论坛数据
	 */
	public void ajaxIndex() {
		try { 
			getLscode();
			String type = Struts2Utils.getParameter("type");
           
			String custid = Struts2Utils.getParameter("custid");
			Struts2Utils.getRequest().setAttribute("custid", custid);
			HashMap<String, Object> sortMap = new HashMap<String, Object>();
			HashMap<String, Object> whereMap = new HashMap<String, Object>();
			HashMap<String, Object> whereMapmore = new HashMap<String, Object>();
			Map<String, Object> sub_map = new HashMap<String, Object>(); 
			if (type.equals("2")) {
				//返回最热帖子
				sortMap.put("reading", -1);
				whereMap.put("custid", custid);

			} else if (type.equals("1")) { 
				//返回最新帖子（默认）
				sortMap.put("createdate", -1);
				whereMap.put("custid", custid); 
			}else if(type.equals("3")){
				
				//返回登录用户的相关论坛帖子
				sortMap.put("createdate", -1);
				whereMap.put("custid", custid);
				DBObject  wx=wwzService.getWxUser(fromUserid);
				if(!wx.get("_id").equals("notlogin")){
					whereMap.put("fromUserid",fromUserid);
				}else{
					whereMap.put("fromUserid","notlogin");
				} 
			}else{
				sortMap.put("createdate", -1);
				whereMap.put("custid", custid); 
				Pattern pattern = Pattern.compile("^.*" + type + ".*$",
							Pattern.CASE_INSENSITIVE);
			    whereMap.put("type", pattern); 
				 
				
			} 
			//去除置顶帖子
			if(!type.equals("3")){
			 BasicDBObject dateCondition = new BasicDBObject(); 
				dateCondition.append("$ne",1);
				whereMap.put("stick", dateCondition);
				
			}
			whereMap.put("adminstate",new BasicDBObject("$ne",1));
			// 加载帖子内容
			fypage = Integer.parseInt(Struts2Utils.getParameter("fypage"));
			List<DBObject> bbslist = baseDao.getList(PubConstants.BBS_INFO,
					whereMap, fypage, 10, sortMap);
			for (DBObject dbObject : bbslist) {
				if (dbObject.get("createdate") != null) {
					dbObject.put("createdate", DateFormat
							.getSampleDate(DateFormat.getFormat(dbObject.get(
									"createdate").toString())));
				}

				// 加载点赞和评论数据
				whereMapmore.clear();
				whereMapmore.put("bmtid",
						Long.parseLong(dbObject.get("_id").toString()));
				whereMapmore.put("parentid", null); 
				Long commentcount = baseDao.getCount(PubConstants.BBS_COMMENTS,
						whereMapmore); 
				dbObject.put("commentcount", commentcount); 
				
				whereMapmore.clear();
				whereMapmore.put("type", dbObject.get("_id").toString());
				Long  parisecount=baseDao.getCount(PubConstants.BBS_PRAISE,
						whereMapmore);
				dbObject.put("praise", parisecount); 
				String picurl = (String) dbObject.get("picurl");
				String picurls[] = null;
				if (StringUtils.isNotEmpty(picurl) && picurl.length() > 0) {
					picurls = picurl.split(",");
					dbObject.put("picurls", picurls);
				} else {
					dbObject.put("picurls", picurls);
				}
				//加载用户等级
				dbObject.put("level",wwzService.getWxUsertype(dbObject.get("fromUserid").toString(),"level"));
				//加载打赏记录
				HashMap<String, Object> excwhereMap=new HashMap<String, Object>();
				excwhereMap.put("type","bbs-"+dbObject.get("_id").toString()); 
				Long expcount=baseDao.getCount(PubConstants.SUC_EXCEPTIONAL, excwhereMap);
				dbObject.put("exceptional", expcount);
				// 加载回复内容
				HashMap<String, Object> commentwhereMap = new HashMap<String, Object>();
				HashMap<String, Object> commentsortMap = new HashMap<String, Object>();
				commentwhereMap.put("bmtid",
						Long.parseLong(dbObject.get("_id").toString()));
				commentwhereMap.put("parentid", null);
				commentsortMap.put("createdate", -1);
				List<DBObject> commentlist = baseDao.getList(
						PubConstants.BBS_COMMENTS, commentwhereMap,
						commentsortMap);

				for (DBObject dbObject2 : commentlist) {
					// 加载二级评论

					commentwhereMap.put("parentid",
							Long.parseLong(dbObject2.get("_id").toString()));
					List<DBObject> commentchildlist = baseDao.getList(
							PubConstants.BBS_COMMENTS, commentwhereMap,
							commentsortMap);

					dbObject2.put("commentchildlist", commentchildlist);

				}
				dbObject.put("commentlist", commentlist);

			}
			if (bbslist.size() > 0) {
				sub_map.put("state", 0); 
				sub_map.put("list", bbslist);
			} else {
				sub_map.put("state", 1);
			}
			String json = JSONArray.fromObject(sub_map).toString();

			Struts2Utils.renderJson(json.substring(1, json.length() - 1),
					new String[0]);
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	/**
	 * ajax添加论坛内容
	 */
	public void ajaxAdd(){
		Map<String, Object>submap=new HashMap<String, Object>();
		try { 
			getLscode();    
			String content=Struts2Utils.getParameter("content");
			String picurl=Struts2Utils.getParameter("picurl");
			String custid = Struts2Utils.getParameter("custid"); 
			String type = Struts2Utils.getParameter("type");
			String mp4url=Struts2Utils.getParameter("mp4url");
			DBObject user=wwzService.getWxUser(fromUserid);
			BbsInfo  obj=new BbsInfo();
			Long  id=mongoSequence.currval(PubConstants.BBS_INFO);
			obj.set_id(id);
			obj.setContent(content);
			obj.setCreatedate(new Date());
			obj.setFromUserid(fromUserid);
			obj.setType(type);
			if(StringUtils.isNotEmpty(picurl)){
				obj.setPicurl(picurl.replace("undefined",""));
			} 
			obj.setCustid(custid);
			if(user.get("headimgurl")!=null){
				obj.setHeadimgurl(user.get("headimgurl").toString());	
			} 
			obj.setNikename(user.get("nickname").toString());
			if(user.get("humor")!=null){
				obj.setHumor(user.get("humor").toString());
			}
			if(StringUtils.isNotEmpty(mp4url)){
				if(mp4url.startsWith("https://v.qq.com")){
					if(mp4url.indexOf("vid=")>0){
						obj.setMp4url("https://v.qq.com/iframe/preview.html?vid="+mp4url.substring(mp4url.indexOf("vid=")+4));
					}
					if(mp4url.indexOf("html")>0){
						obj.setMp4url("https://v.qq.com/iframe/preview.html?vid="+mp4url.substring(mp4url.lastIndexOf("/")+1,mp4url.indexOf("html")-1));
					}
				}
				if(mp4url.startsWith("http://v.youku.com")){
					if(mp4url.indexOf("html")>0){
						mp4url=mp4url.substring(0, mp4url.indexOf("html"));
						mp4url=mp4url.substring(mp4url.indexOf("id_")+3, mp4url.lastIndexOf("."));
						obj.setMp4url("http://player.youku.com/embed/"+mp4url+"==");
					}
				} 	
			} 
			baseDao.insert(PubConstants.BBS_INFO, obj);
			//JmsService.permessageMessage(custid, fromUserid,"论坛发帖", "用户:"+wwzService.getWxUsertype(fromUserid, "nickname")+"发了一条新消息 ",null, null,"3","bbs-add");
			if(!user.get("_id").toString().equals("notlogin")){
				String  areward=Struts2Utils.getParameter("areward");
				if(StringUtils.isNotEmpty(areward)&&Integer.parseInt(areward)!=0){ 
					boolean bl=wwzService.areward(fromUserid, custid, id, areward, user);
					if(bl){
					  submap.put("areward", "ok");	
					}
				}
				String time=Struts2Utils.getParameter("time");
				String  bbsstick=Struts2Utils.getParameter("bbsstick");
				if(StringUtils.isNotEmpty(bbsstick)&&Integer.parseInt(bbsstick)!=0&&StringUtils.isNotEmpty(time)&&Integer.parseInt(time)!=0){
					
					boolean bl=wwzService.stick(fromUserid, custid, id, bbsstick,time,user); 
					if(bl){ 
					   submap.put("bbsstick", "ok");	
					}
				} 
				
				 
				//验证任务
				 
			    Long ref=wwzService.checkTask("bbsadd",fromUserid,custid);
				if(ref!=-1L){
					wwzService.completeTask(ref,custid,fromUserid,"bbsadd");
					DBObject  db=baseDao.getMessage(PubConstants.SUC_TASK,ref); 
					submap.put("expreward",db.get("expreward"));
					submap.put("jfreward",db.get("jfreward")); 
					
				}
				
			}
			submap.put("state", 0);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			submap.put("state", 1);
			e.printStackTrace();
		}
        String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	public  String  webadd(){
		wwzService.flow(custid, "bbs");
		getLscode();
		//fromUserid=getFromUserid(); 
		DBObject  wxuser=wwzService.getWxUser(fromUserid);
		wxuser.put("jf",wwzService.getJf(custid, fromUserid));
		
		//WxToken token=WeiXinUtil.getSignature(wwzService.gettoUser(custid),Struts2Utils.getRequest());
		//Struts2Utils.getRequest().setAttribute("token", token); 
		Struts2Utils.getRequest().setAttribute("custid", custid);  
		Struts2Utils.getRequest().setAttribute("list",
				GetAllFunc.wxFunc.get(custid));  
		//获取用户信息 
		Struts2Utils.getRequest().setAttribute("user",wxuser);  
		Struts2Utils.getRequest().setAttribute("type",Struts2Utils.getParameter("type"));
		HashMap<String,Object>whereMap=new HashMap<String, Object>();
		HashMap<String,Object>sortMap=new HashMap<String, Object>();
		whereMap.put("custid",custid);
		sortMap.put("sort",-1);
		List<DBObject>typelist=baseDao.getList(PubConstants.BBSTYPE_INFO, whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("bbstype",typelist);
		 
		DBObject  share=baseDao.getMessage(PubConstants.WEIXIN_SHAREFX, custid+"-bbs_share"); 
	 
		if(share!=null&&share.get("fxmb")!=null){
			return "webadd"+share.get("fxmb").toString();
		} 
		
		return "webadd";
	}
	/**
	 * ajax添加论坛回复内容
	 */
	public void ajaxAddcomment(){
		Map<String, Object>submap=new HashMap<String, Object>();
		try {
			getLscode();
			String  bmtid=Struts2Utils.getParameter("bmtid");  
			String  hfid=Struts2Utils.getParameter("hfid"); 
			String  parentid=Struts2Utils.getParameter("parentid");
			String  content=Struts2Utils.getParameter("content");
			Bbscomments obj=new Bbscomments(); 
			obj.set_id(mongoSequence.currval(PubConstants.BBS_COMMENTS));
			obj.setBmtid(Long.parseLong(bmtid));
			if(StringUtils.isNotEmpty(parentid)){
				obj.setParentid(Long.parseLong(parentid));
			} 
			if(StringUtils.isNotEmpty(hfid)){
	            obj.setHfid(Long.parseLong(hfid));
	            DBObject  hfobj=baseDao.getMessage(PubConstants.BBS_COMMENTS, Long.parseLong(hfid));
	             
	            if(hfobj.get("headimgurl")!=null){
	              obj.setHfheadimgurl(hfobj.get("headimgurl").toString());	
	            } 
	            obj.setHfname(hfobj.get("name").toString());
			}
			obj.setCreatedate(new Date());
			obj.setFromUserid(fromUserid);
			DBObject  user=wwzService.getWxUser(fromUserid);
			if(user.get("headimgurl")!=null){
				obj.setHeadimgurl(user.get("headimgurl").toString());	
			} 
			obj.setName(user.get("nickname").toString());
			obj.setContent(content);  
			if(StringUtils.isEmpty(parentid)){
				HashMap<String, Object>wherecuntMap=new HashMap<String, Object>();
				wherecuntMap.put("bmtid",Long.parseLong(bmtid));
				wherecuntMap.put("parentid",null);	
				obj.setSort(baseDao.getCount(PubConstants.BBS_COMMENTS,wherecuntMap)+1);
			}  
			baseDao.insert(PubConstants.BBS_COMMENTS, obj);
			//验证任务 
		    Long ref=wwzService.checkTask("bbscomments", fromUserid,custid); 
			if(ref!=-1L){
				wwzService.completeTask(ref,custid,fromUserid,"bbscomments"); 
				DBObject  db=baseDao.getMessage(PubConstants.SUC_TASK,ref); 
				submap.put("expreward",db.get("expreward"));
				submap.put("jfreward",db.get("jfreward")); 
			} 
			submap.put("state", 0);
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			submap.put("state", 1);
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * 论坛详情页面
	 */
	public  String  bbsDetails(){
		getLscode();  
		String  bmtid=Struts2Utils.getParameter("bmtid");
		WxToken token=GetAllFunc.wxtoken.get(custid);
		if(token!=null&&token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 }
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String  url=SysConfig.getProperty("ip")+"/suc/bbs!bbsDetails.action?custid="+custid+"&bmtid="+bmtid;  
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
		DBObject  wxuser=wwzService.getWxUser(fromUserid);
		wxuser.put("jf",wwzService.getJf(custid, fromUserid));
		Struts2Utils.getRequest().setAttribute("user",wxuser);  
		Struts2Utils.getRequest().setAttribute("custid", custid);
		if(StringUtils.isNotEmpty(bmtid)){
			DBObject  db=baseDao.getMessage(PubConstants.BBS_INFO, Long.parseLong(bmtid));
			if(fromUserid.equals(db.get("fromUserid").toString())){
				wxuser.put("isadmin", true); 
			}
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			HashMap<String, Object> whereMapmores = new HashMap<String, Object>();
			whereMapmores.put("bmtid", Long.parseLong(bmtid)); 
			sortMap.put("createdate", -1); 
		    //加载最佳答案 
			whereMap.put("bmtid", Long.parseLong(bmtid));
			DBObject  arew=baseDao.getMessage(PubConstants.BBS_AREWARD,whereMap);
			if(arew!=null&&Integer.parseInt(arew.get("state").toString())==1){
				 Long answerid=Long.parseLong(arew.get("answerid").toString());
				 DBObject  answer=baseDao.getMessage(PubConstants.BBS_COMMENTS, answerid);
				 whereMap.clear();
				 whereMap.put("parentid", Long.parseLong(answer.get("_id").toString()));
				 List<DBObject>answerchild=baseDao.getList(PubConstants.BBS_COMMENTS, whereMap, sortMap);
				 answer.put("childlist", answerchild);
				 whereMap.clear();
				 whereMap.put("type", bmtid+"-"+answer.get("_id").toString());
				 Long  praisecount=baseDao.getCount(PubConstants.BBS_PRAISE,whereMap);
				 answer.put("praise", praisecount);
				 Struts2Utils.getRequest().setAttribute("answer", answer);
			}
			String picurl = (String) db.get("picurl");
			String picurls[] = null; 
			if (StringUtils.isNotEmpty(picurl)&&picurl.length() > 0) {
				picurls = picurl.split(",");
				db.put("picurls", picurls);
			} else {
				db.put("picurls", picurls);
			}  

			whereMapmores.put("parentid",null);
			db.put("commentcount", baseDao.getCount(PubConstants.BBS_COMMENTS,whereMapmores));
			whereMapmores.clear();
			whereMapmores.put("type", bmtid);
			db.put("praise", baseDao.getCount(PubConstants.BBS_PRAISE,whereMapmores));
			whereMapmores.put("parentid",null);
			//加载打赏记录
			whereMapmores.clear();
			whereMapmores.put("type","bbs-"+db.get("_id").toString()); 
			HashMap<String, Object>sorMap=new HashMap<String, Object>();
			sorMap.put("createdate",-1);
			List<DBObject>list=baseDao.getList(PubConstants.SUC_EXCEPTIONAL, whereMapmores, sortMap);
			float money=0;
			for (DBObject dbObject : list) {
				DBObject wx=wwzService.getWxUser(dbObject.get("fromUserid").toString());
				dbObject.put("headimgurl", wx.get("headimgurl"));
				money+=Float.parseFloat(dbObject.get("price").toString()); 
			}
			db.put("level", wwzService.getWxUsertype(db.get("fromUserid").toString(), "level"));
			Struts2Utils.getRequest().setAttribute("entity", db); 
			Struts2Utils.getRequest().setAttribute("money", money);
			Struts2Utils.getRequest().setAttribute("exclist", list);
			Struts2Utils.getRequest().setAttribute("exceptional", list.size());
			Struts2Utils.getRequest().setAttribute("title", "详情");
			  
			DBObject  share=baseDao.getMessage(PubConstants.WEIXIN_SHAREFX, custid+"-bbs_share"); 
			if (db.get("adminstate")!=null&&db.get("adminstate").toString().equals("1")) {
				share.put("fxsummary", db.get("title")); 
			}else{
				share.put("fxsummary", db.get("content")); 
			}  
			share.put("fxurl",url); 
			Struts2Utils.getRequest().setAttribute("share", share);
			if(share!=null&&share.get("fxmb")!=null){ 
			
				return "detail"+share.get("fxmb").toString();
			} 
		} 
		return "detail1";
	}
	/**
	 * ajax加载评论
	 */
	public void  ajaxcomment(){
		getLscode();
		String  bmtid=Struts2Utils.getParameter("bmtid");
		Map<String, Object>submap=new HashMap<String, Object>();
		try {
			HashMap<String,Object>whereMap=new HashMap<String, Object>();
			HashMap<String,Object>sortMap=new HashMap<String, Object>();
			sortMap.put("createdate", -1);
			whereMap.put("bmtid",Long.parseLong(bmtid));
			whereMap.put("parentid", null);
			whereMap.put("activity", 0);
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			List<DBObject>list=baseDao.getList(PubConstants.BBS_COMMENTS, whereMap,fypage,10, sortMap);
			
			if(list.size()>0){
				for (DBObject dbObject : list) { 
					whereMap.clear();
					whereMap.put("parentid", Long.parseLong(dbObject.get("_id").toString()));
					List<DBObject>commentchildlist=baseDao.getList(PubConstants.BBS_COMMENTS, whereMap,sortMap);
					dbObject.put("commentchildlist", commentchildlist);
					HashMap<String, Object> whereMapmore = new HashMap<String, Object>();
					whereMapmore.put("type", bmtid+"-"+dbObject.get("_id").toString());
					Long  praisecount=baseDao.getCount(PubConstants.BBS_PRAISE,whereMapmore);
					dbObject.put("praise", praisecount);
				}
				submap.put("state", 0);
				submap.put("list",list);
			}else{
				submap.put("state", 1); 	
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			submap.put("state", 1); 	
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * bbs论坛点赞
	 */
	public void  bbspraiseAdd(){ 
		Map<String, Object>submap=new HashMap<String, Object>();
		 
			try {
				String  bmtid=Struts2Utils.getParameter("bmtid");  
				getLscode();
				DBObject  wxuser=wwzService.getWxUser(fromUserid);
				if(wxuser.get("_id").equals("notlogin")){
					//未登录
					submap.put("state",3);
					
				}else{
					if(StringUtils.isNotEmpty(bmtid)){
						//检测是否已经赞
						HashMap<String, Object>whereMap=new HashMap<String, Object>();
						whereMap.put("type", bmtid);
						whereMap.put("fromUserid", fromUserid);
						Long count =baseDao.getCount(PubConstants.BBS_PRAISE, whereMap);
						if(count==0L){
							
							Bbspraise  obj=new Bbspraise();
							obj.set_id(mongoSequence.currval(PubConstants.BBS_PRAISE));
							obj.setType(bmtid);
							obj.setCreatedate(new Date());
							obj.setToUser(toUser);
							obj.setFromUserid(fromUserid);
							baseDao.insert(PubConstants.BBS_PRAISE, obj);
							//验证任务 
						    Long ref=wwzService.checkTask("bbspraise", fromUserid,custid);
						  
							if(ref!=-1L){
								wwzService.completeTask(ref,custid,fromUserid,"bbspraise");
								DBObject  db=baseDao.getMessage(PubConstants.SUC_TASK,ref); 
								submap.put("expreward",db.get("expreward"));
								submap.put("jfreward",db.get("jfreward")); 
							}
						  
							submap.put("state", 0); 
							whereMap.clear();
							whereMap.put("type", bmtid);
							submap.put("value",baseDao.getCount(PubConstants.BBS_PRAISE, whereMap));
						}else{
							
							submap.put("state", 2); 
							
						} 
				  } 	
              }
			} catch (NumberFormatException e) {
				// TODO Auto-generated catch block
				submap.put("state", 1); 
				e.printStackTrace();
			} 	
	 
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * bbs论坛阅读
	 */
	public void bbsReading(){
		Map<String, Object>submap=new HashMap<String, Object>();
		try {
			getLscode();
			String  bmtid=Struts2Utils.getParameter("bmtid"); 
			if(StringUtils.isNotEmpty(bmtid)){
				DBObject obj=baseDao.getMessage(PubConstants.BBS_INFO, Long.parseLong(bmtid));
				BbsInfo  bbs=(BbsInfo) UniObject.DBObjectToObject(obj, BbsInfo.class);
				if(bbs.getReading()==null){
					bbs.setReading(1);
				}else{
					bbs.setReading(bbs.getReading()+1);
				}
				
				baseDao.insert(PubConstants.BBS_INFO, bbs);
				
				Bbsreading  reading=new Bbsreading();
				reading.set_id(mongoSequence.currval(PubConstants.BBS_READING));
				reading.setCreatedate(new Date());
				reading.setFromUserid(fromUserid);
				reading.setBmtid(Long.parseLong(bmtid)); 
				baseDao.insert(PubConstants.BBS_READING, reading);
				
				//验证任务 
			    Long ref=wwzService.checkTask("bbsreading", fromUserid,custid);
				if(ref!=-1L){
					wwzService.completeTask(ref,custid,fromUserid,"bbsreading");
					DBObject  db=baseDao.getMessage(PubConstants.SUC_TASK,ref); 
					submap.put("expreward",db.get("expreward"));
					submap.put("jfreward",db.get("jfreward"));  
					
				}
				submap.put("state", 0);
				submap.put("value", bbs.getReading());
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			submap.put("state", 1);
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * ajax 删除评论
	 * 
	 */
	public void ajaxdelcomment(){
		getLscode(); 
		DBObject user=wwzService.getWxUser(fromUserid);
		Map<String, Object>submap=new HashMap<String, Object>();
		try {
			if(user.get("_id").equals("notlogin")){
				//未登录
				submap.put("state", 3);
			}else{
				String id=Struts2Utils.getParameter("id");
				HashMap<String, Object>whereMap=new HashMap<String, Object>();
				if(user.get("isadmin")==null){  
					whereMap.put("fromUserid", fromUserid); 
				}
				whereMap.put("parentid", Long.parseLong(id));
				//删除二级回复
				
				baseDao.delete(PubConstants.BBS_COMMENTS, whereMap);
				whereMap.clear();
				if(user.get("isadmin")==null){  
					whereMap.put("fromUserid", fromUserid); 
				}
				whereMap.put("_id",Long.parseLong(id));
				//删除评论
				baseDao.delete(PubConstants.BBS_COMMENTS, whereMap);
				
				submap.put("state", 0);
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			submap.put("state", 1);
			e.printStackTrace();
		}
		
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * ajax 删除帖子
	 */
	public  void   ajaxdelbbs(){
		lscode=getLscode();
		custid=getCustid();
		DBObject user=wwzService.getWxUser(fromUserid);
		Map<String, Object>submap=new HashMap<String, Object>();
		try {
			if(user.get("_id").equals("notlogin")){
				//未登录
				submap.put("state", 3);
			}else{
				String id=Struts2Utils.getParameter("id");
				HashMap<String, Object>whereMap=new HashMap<String, Object>();
				if(user.get("isadmin")==null){
					 
					whereMap.put("fromUserid", fromUserid); 
				}
				whereMap.put("bmtid", Long.parseLong(id));  
				//删除评论
				baseDao.delete(PubConstants.BBS_COMMENTS, whereMap);
				whereMap.clear();
				if(user.get("isadmin")==null){
					whereMap.put("fromUserid", fromUserid); 
				}
				whereMap.put("_id", Long.parseLong(id));
				//删除帖子
				baseDao.delete(PubConstants.BBS_INFO, whereMap);
				
				submap.put("state", 0);
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			submap.put("state", 1);
			e.printStackTrace();
		}
		
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * ajax 删除全部评论
	 */
	public  void   ajaxdelallcoment(){
		lscode=getLscode();
		custid=getCustid();
		DBObject user=wwzService.getWxUser(fromUserid);
		Map<String, Object>submap=new HashMap<String, Object>();
		try {
			if(user.get("_id").equals("notlogin")){
				//未登录
				submap.put("state", 3);
			}else{
				String id=Struts2Utils.getParameter("id");
				HashMap<String, Object>whereMap=new HashMap<String, Object>();
				if(user.get("isadmin")==null){
					whereMap.put("fromUserid", fromUserid); 
				}
				whereMap.put("bmtid", Long.parseLong(id));  
				//删除评论
				baseDao.delete(PubConstants.BBS_COMMENTS, whereMap); 
				submap.put("state", 0);
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			submap.put("state", 1);
			e.printStackTrace();
		}
		
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * 个人主页
	 * @return
	 */
	public  String   personalhome(){
		getLscode();
		String toUserid=Struts2Utils.getParameter("toUserid"); 
		Struts2Utils.getRequest().setAttribute("custid", custid);
		Struts2Utils.getRequest().setAttribute("toUserid", toUserid);
		DBObject  share=baseDao.getMessage(PubConstants.WEIXIN_SHAREFX, custid+"-bbs_share"); 
		
		if(StringUtils.isNotEmpty(toUserid)){
			//登录他人主页
			DBObject  db=wwzService.getWxUser(toUserid);
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			whereMap.put("fromUserid",toUserid);
			Long bbscount=baseDao.getCount(PubConstants.BBS_INFO, whereMap);
			db.put("bbscount",bbscount); 
			double bl= Double.parseDouble(db.get("getExperience").toString())/Double.parseDouble(db.get("needExperience").toString());   
			db.put("expbl",new java.text.DecimalFormat("#").format(bl*100)); 
			Struts2Utils.getRequest().setAttribute("user", db); 
		}else{
			//登录个人主页
			DBObject  db=wwzService.getWxUser(fromUserid); 
			db.put("isadmin", true);
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			whereMap.put("fromUserid",fromUserid);
			Long bbscount=baseDao.getCount(PubConstants.BBS_INFO, whereMap);
			db.put("bbscount",bbscount); 
			double bl= Double.parseDouble(db.get("getExperience").toString())/Double.parseDouble(db.get("needExperience").toString());   
			db.put("expbl",new java.text.DecimalFormat("#").format(bl*100)); 
			Struts2Utils.getRequest().setAttribute("user", db);
		}
		  
		 
		if(share!=null&&share.get("fxmb")!=null){ 
			return "personalhome"+share.get("fxmb").toString();
		} 
		return "personalhome";
		
	}
	 
	@Override
	public String input() throws Exception {
		// TODO Auto-generated method stub
		HashMap<String,Object>whereMap=new HashMap<String, Object>();
		HashMap<String,Object>sortMap=new HashMap<String, Object>();
		whereMap.put("custid",SpringSecurityUtils.getCurrentUser().getId());
		sortMap.put("sort",-1);
		List<DBObject>typelist=baseDao.getList(PubConstants.BBSTYPE_INFO, whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("bbstype",typelist);
		
		return "add";
	}

	@Override
	public String update() throws Exception {
		// TODO Auto-generated method stub
		HashMap<String,Object>whereMap=new HashMap<String, Object>();
		HashMap<String,Object>sortMap=new HashMap<String, Object>();
		whereMap.put("custid",SpringSecurityUtils.getCurrentUser().getId());
		sortMap.put("sort",-1);
		List<DBObject>typelist=baseDao.getList(PubConstants.BBSTYPE_INFO, whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("bbstype",typelist);
		Struts2Utils.getRequest().setAttribute("entity",baseDao.getMessage(PubConstants.BBS_INFO,_id));
		return "add";
	}
    
	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		if(_id == null){
			_id=mongoSequence.currval(PubConstants.BBS_INFO); 
		}		
		entity.set_id(_id);
		custid=SpringSecurityUtils.getCurrentUser().getId();
		entity.setContent(Struts2Utils.getParameter("content"));
		entity.setFromUserid("1");
		entity.setTitle(Struts2Utils.getParameter("title"));
		entity.setType(Struts2Utils.getParameter("type"));
		entity.setCustid(custid);
		entity.setNikename("管理员");
		entity.setAdminstate(1);
		entity.setCreatedate(new Date()); 
		baseDao.insert(PubConstants.BBS_INFO,entity);
		return RELOAD;
	}

	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		 try {
			String id=Struts2Utils.getParameter("_id");
			String custid=SpringSecurityUtils.getCurrentUser().getId();
			 if(StringUtils.isNotEmpty(id)){ 
				 //删除对应评论
				 HashMap<String, Object>whereMap=new HashMap<String, Object>();
				 whereMap.put("bmtid",Long.parseLong(id));
				 baseDao.delete(PubConstants.BBS_COMMENTS, whereMap);
				 //删除对应赞数据
				 baseDao.delete(PubConstants.BBS_PRAISE, whereMap);
				 //删除对应阅读量数据
				 baseDao.delete(PubConstants.BBS_READING, whereMap);
				 
				 //删除数据
				 baseDao.delete(PubConstants.BBS_INFO, Long.parseLong(id));
			 }
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return RELOAD;
	}


	public void set_id(Long _id) {
		this._id = _id;
	} 
	/**
	 * 微信支付
	 * @throws Exception
	 */
	public void wxpay() throws Exception{
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
		
		if(wxconfig==null||wxconfig.getAppid()==null){
			params.put("state", 1); 
			String json = JSONArray.fromObject(params).toString();
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
			return;
		}
		//获取提交的商品价格
		String price = Struts2Utils.getParameter("price");
		//获取提交的商品名称
		String remark = Struts2Utils.getParameter("remark");
		
		int lx=Integer.parseInt(Struts2Utils.getParameter("lx"));//0 商品 1选号 2扫码付3优惠劵4砍价
		//总金钱
		float total=Float.parseFloat(Struts2Utils.getParameter("total"));
		 
		Long recordid=0L;
		if(org.apache.commons.lang.StringUtils.isNotEmpty(Struts2Utils.getParameter("recordid"))){
			recordid=Long.parseLong(Struts2Utils.getParameter("recordid"));//14
		}
		float remoney=0;
		if(org.apache.commons.lang.StringUtils.isNotEmpty(Struts2Utils.getParameter("remoney"))){
			remoney=Float.parseFloat(Struts2Utils.getParameter("remoney"));//14
		}
		int num=Integer.parseInt(Struts2Utils.getParameter("num"));
		 
		String toUserid=Struts2Utils.getParameter("toUserid");
		String type=Struts2Utils.getParameter("type");
		//四位随机数
		String strRandom = TenpayUtil.buildRandom(4) + "";
		
		//10位序列号,可以自行调整。
		String orderno = DateFormat.getDate() + strRandom+mongoSequence.currval(PubConstants.SUC_ORDERNO);
		
		/**
		 * 生成支付订单
		 */
		OrderForm entity=new OrderForm();
		entity.set_id(orderno);
		entity.setState(1);//1为生成订单状态
		entity.setNo(orderno);
		entity.setLx(lx); 
		entity.setFromUserid(fromUserid); 
		if(wx!=null){
			//保存微信用户地址
			if(wx.get("province")!=null){
				entity.setProvince(wx.get("province").toString());
			}
			if(wx.get("city")!=null){
				entity.setCity(wx.get("city").toString());
			}
			if(wx.get("ly")!=null){
				entity.setLy(Integer.parseInt(wx.get("ly").toString()));
			}
		}
		entity.setInsDate(new Date()); 
		entity.setCount(num);//15
		entity.setTotal(total);//6
		
		
		entity.setZfmoney(Float.parseFloat(price));//7 
		entity.setRecordid(recordid);
		entity.setRemoney(remoney); 
		entity.setRemark(remark);
		baseDao.insert(PubConstants.WX_ORDERFORM, entity);
		StringBuffer attach=new StringBuffer(orderno);//传递订单编号 
		attach.append("&").append(custid);
		attach.append("&").append(toUserid);
		attach.append("&").append(type);
		 
		String nonce_str=PayCommonUtil.CreateNoncestr();
		SortedMap<Object,Object> parameters = new TreeMap<Object,Object>(); 
		parameters.put("appid", wxconfig.getAppid());//公众账号ID 
		parameters.put("mch_id", wxconfig.getPartner());//商户号
		parameters.put("nonce_str", nonce_str);//随机字符串
		parameters.put("attach", attach.toString());
		parameters.put("body", remark);//商品描述
		parameters.put("is_subscribe", "Y"); 
		parameters.put("out_trade_no", orderno);
		parameters.put("total_fee",BaseDecimal.round(BaseDecimal.multiplication(price, "100"),0));//总金额
		parameters.put("spbill_create_ip",Struts2Utils.getRequest().getRemoteAddr());//终端ip  
		parameters.put("notify_url", this.getCtxurl()+"/suc/bbs!payok.action");//通知地址 
		parameters.put("trade_type", "JSAPI");//支付类型 
		parameters.put("openid", wwzService.getWxUser(fromUserid).get("fromUser").toString());//用户ID
		String sign = PayCommonUtil.createSign("UTF-8", parameters,wxconfig.getPartner_key());
				
		parameters.put("sign", sign);//签名
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
	    params.put("paySign", paySign);                                                          //paySign的生成规则和Sign的生成规则一致
	    params.put("state", 0);
	   
		String json = JSONArray.fromObject(params).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 结算
	 * @throws Exception
	 */
	public void payok() throws Exception{
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
        	DBObject orderdb=baseDao.getMessage(PubConstants.WX_ORDERFORM, orderno);
        	OrderForm entity = (OrderForm)UniObject.DBObjectToObject(orderdb,OrderForm.class);
            //支付成功
        	entity.set_id(orderno);
        	entity.setState(2);//2为已经支付成功
        	baseDao.insert(PubConstants.WX_ORDERFORM, entity);
        	DBObject  obj=wwzService.getWxUser(entity.getFromUserid());
        	if(obj.get("_id").equals("notlogin")){
        		
        	}else{ 
        		//结算 
        		float  mo=entity.getZfmoney()*100;
        		String toUserid=attach[2];
        		Exceptional  exc=new Exceptional();
				exc.set_id(mongoSequence.currval(PubConstants.SUC_EXCEPTIONAL));
				exc.setCreatedate(new Date());
				exc.setFromUserid(entity.getFromUserid());
				exc.setPrice(entity.getZfmoney());
				exc.setType(attach[3]);
				exc.setToUserid(toUserid);
				baseDao.insert(PubConstants.SUC_EXCEPTIONAL, exc);
        		  
        		 wwzService.addjf(mo+"",toUserid,"excep", custid, null);
        		
        	}
        	
        	Struts2Utils.getResponse().getWriter().write(PayCommonUtil.setXML("SUCCESS", ""));
        	
        }else{
        	Struts2Utils.getResponse().getWriter().write(PayCommonUtil.setXML("SUCCESS", ""));
        }
     
	}
	/**
	 * ajax验证任务
	 */
	public  void  ajaxCheckTask(){
		getLscode();
		Map<String, Object>submap=new HashMap<String, Object>();
		String  type =Struts2Utils.getParameter("type");
		//验证任务 
	    Long ref=wwzService.checkTask(type, fromUserid,custid); 
		if(ref!=-1L){ 
			    wwzService.completeTask(ref,custid,fromUserid,type);
				DBObject  db=baseDao.getMessage(PubConstants.SUC_TASK,ref);
				submap.put("state", 0);
				submap.put("expreward",db.get("expreward"));
				submap.put("jfreward",db.get("jfreward"));  
		} 
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}

	@Override
	public BbsInfo getModel() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		
	}
	
	 
}

