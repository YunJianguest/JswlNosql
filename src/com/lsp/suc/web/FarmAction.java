package com.lsp.suc.web;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
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
import net.sf.json.JSONObject;

import org.apache.activemq.filter.function.splitFunction;
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
import com.lsp.pub.util.BaseDate;
import com.lsp.pub.util.BaseDecimal;
import com.lsp.pub.util.CommonUtil;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.DateUtil;
import com.lsp.pub.util.ExportExcel;
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
import com.lsp.suc.entity.Farm;
import com.lsp.suc.entity.FarmCard;
import com.lsp.suc.entity.FarmFoot;
import com.lsp.suc.entity.FarmProduct;
import com.lsp.suc.entity.FarmYd;
import com.lsp.suc.entity.FarmYdDetail; 
import com.lsp.suc.entity.Ranking; 
import com.lsp.website.service.WwzService;
import com.lsp.weixin.entity.WxPayConfig;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;

 
/**
 * 农场产品管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name ="reload", location = "farmproduct.action",params={"fypage","%{fypage}","type","%{type}"}, type = "redirect") })
public class FarmAction extends GeneralAction<FarmProduct>{

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
	
	private FarmProduct entity=new FarmProduct();
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
		List<DBObject> list=baseDao.getList(PubConstants.SUC_FARMPRODUCT,whereMap,fypage,10,sortMap,backMap);
		fycount=baseDao.getCount(PubConstants.SUC_FARMPRODUCT);
		Struts2Utils.getRequest().setAttribute("list", list);
		Struts2Utils.getRequest().setAttribute("custid", custid);
		
		return SUCCESS;
	}


	@Override
	public FarmProduct getModel() {
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
		Struts2Utils.getRequest().setAttribute("entity",baseDao.getMessage(PubConstants.SUC_FARMPRODUCT, _id));
		return "add";
	}
	public void upd() throws Exception { 
		DBObject db = baseDao.getMessage(PubConstants.SUC_FARMPRODUCT, _id); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}


	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id==null){
				_id=mongoSequence.currval(PubConstants.SUC_FARMPRODUCT); 
			}  
			String custid=SpringSecurityUtils.getCurrentUser().getId(); 
			entity.set_id(_id); 
			entity.setCustid(custid);
			entity.setCreatedate(new Date());
			entity.setEwmurl(wwzService.recode("farm-mbTicket-"+_id,SysConfig.getProperty("ip")+"/suc/farm!mbTicket.action?custid="+custid+"&id="+_id, entity.getPicurl(),true, 200, 1000));
			baseDao.insert(PubConstants.SUC_FARMPRODUCT, entity);
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
		baseDao.delete(PubConstants.SUC_FARMPRODUCT, whereMap);
		return RELOAD;
	}


	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id!=null){
				DBObject db=baseDao.getMessage(PubConstants.SUC_FARMPRODUCT, _id);
				entity= (FarmProduct) UniObject.DBObjectToObject(db, FarmProduct.class);
			}else{
				entity=new FarmProduct();
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
     * 农场首页（全部预订列表，时间最新；排行，活跃度最大，个人中心）
     * @return
     */
    public  String index(){
    	getLscode(); 
    	wwzService.flow(custid, "farm");
    	String id=Struts2Utils.getParameter("id");
    	Struts2Utils.getRequest().setAttribute("fid",wwzService.getVipNo(fromUserid));
    	Struts2Utils.getRequest().setAttribute("custid", custid); 
    	WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/suc/farm!index.action?custid="+custid+"&fid="+Struts2Utils.getParameter("fid")+"&id="+id;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}
		DBObject  db=null;
		if(StringUtils.isNotEmpty(id)){
			db=baseDao.getMessage(PubConstants.SUC_FARM, id);
		}else{
			db=createfarm(custid, fromUserid);
		}
		Struts2Utils.getRequest().setAttribute("entity", db);
		DBObject share=wwzService.getShareFx(custid,"farm_share");  
		if(share==null){
			share=new BasicDBObject();
			share.put("fxtitle", wwzService.getWxUsertype(fromUserid, "nickname"));
			share.put("fximg",wwzService.getWxUsertype(fromUserid, "headimgurl"));
			share.put("fxurl", url);
			share.put("fxsummary", "我在这里玩根本停不下来，小伙伴们还等什么！");
		}else{
			share.put("fxurl", url);
		} 
		Struts2Utils.getRequest().setAttribute("share", share);
		return "index"; 
    }
    /**
     * 预订活动详情
     * @return
     */
    public  String  detail(){
    	String  id=Struts2Utils.getParameter("id");
    	custid=SpringSecurityUtils.getCurrentUser().getId();
    	HashMap<String, Object>whereMap=new HashMap<>();
    	HashMap<String, Object>sortMap=new HashMap<>();
    	whereMap.put("ydid", id);
    	sortMap.put("createdate", -1);
    	if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
    		fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
    	}
    	List<DBObject>list=baseDao.getList(PubConstants.SUC_FARMPYDDETAIL, whereMap,fypage,10, sortMap);
    	 
    	fycount=baseDao.getCount(PubConstants.SUC_FARMPYDDETAIL, whereMap);
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
    	custid=SpringSecurityUtils.getCurrentUser().getId();
    	HashMap<String, Object>whereMap=new HashMap<>();
    	HashMap<String, Object>sortMap=new HashMap<>();
    	whereMap.put("wid", Long.parseLong(id));
    	sortMap.put("createdate", -1);
    	if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
    		fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
    	}
    	List<DBObject>list=baseDao.getList(PubConstants.SUC_FARMPYD, whereMap,fypage,10, sortMap);
    	fycount=baseDao.getCount(PubConstants.SUC_FARMPYD, whereMap);
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
		String url=SysConfig.getProperty("ip")+"/suc/farm!webydlb.action?custid="+custid;
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
     * 手机预订详情
     * @return
     */
    public  String  webyd(){
    	getLscode();
    	Struts2Utils.getRequest().setAttribute("custid", custid);
    	String id=Struts2Utils.getParameter("id");
    	WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/suc/farm!webyd.action?custid="+custid+"&id="+id;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}
		DBObject  db=baseDao.getMessage(PubConstants.SUC_FARMPYD, id);
		DBObject  obj=baseDao.getMessage(PubConstants.SUC_FARMPRODUCT,Long.parseLong(db.get("wid").toString()));
		 
		if(obj!=null){ 
			double bl=Double.parseDouble(db.get("growth").toString())/Double.parseDouble(obj.get("growth").toString());
			db.put("bl",new java.text.DecimalFormat("#").format(bl*100));
			DBObject  share=new BasicDBObject();
			share.put("fxtitle",obj.get("title"));
			share.put("fximg", wwzService.getWxUsertype(db.get("fromUserid").toString(),"headimgurl"));
			share.put("fxsummary",obj.get("summary"));
			share.put("fxurl",url);
			Struts2Utils.getRequest().setAttribute("share", share);
			
			//加载排行信息
			DBObject  rank=baseDao.getMessage(PubConstants.SUC_RANKING, "farm-"+db.get("wid")+"-"+id);
			System.out.println(rank); 
			if(rank!=null&&Integer.parseInt(rank.get("rank").toString())>0){
				Struts2Utils.getRequest().setAttribute("rankno","排名：NO."+rank.get("rank"));
			}else{
				Struts2Utils.getRequest().setAttribute("rankno","未上榜");
			}
		} 
		db.put("headimgurl",wwzService.getWxUsertype(db.get("fromUserid").toString(), "headimgurl"));
		db.put("nickname",wwzService.getWxUsertype(db.get("fromUserid").toString(), "nickname"));
		Struts2Utils.getRequest().setAttribute("entity",db);
		if(db.get("fromUserid").toString().equals(fromUserid)){
			Struts2Utils.getRequest().setAttribute("isadmin","ok");
		} 
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
		String url=SysConfig.getProperty("ip")+"/suc/farm!webcard.action?custid="+custid;
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
     * ajax获取产品列表
     */
    public  void    ajaxweb(){
    	getLscode(); 
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
	    HashMap<String, Object>sortMap=new HashMap<String, Object>(); 
		whereMap.put("custid",custid); 
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
		List<DBObject>list=baseDao.getList(PubConstants.SUC_FARMPRODUCT, whereMap,fypage,12,sortMap);
		if(list.size()>0){
			sub_map.put("state", 0);
			sub_map.put("list",list);
		} 
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    }
    /**
     * ajax获取道具列表
     */
    public  void    ajaxpropsweb(){
    	getLscode(); 
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
	    HashMap<String, Object>sortMap=new HashMap<String, Object>(); 
		whereMap.put("custid",custid); 
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
		List<DBObject>list=baseDao.getList(PubConstants.SUC_FARMPPROPS, whereMap,fypage,12,sortMap);
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
			String  fid=Struts2Utils.getParameter("fid");
			if(StringUtils.isNotEmpty(fid)){
				DBObject db=baseDao.getMessage(PubConstants.SUC_FARM, fid);
				if(db!=null){
					whereMap.put("fromUserid",db.get("fromUserid").toString());
				}else{
					whereMap.put("fromUserid",fromUserid);
				}
			}else{
				whereMap.put("fromUserid",fromUserid);
			}
			
			sortMap.put("createdate", -1);
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			List<DBObject>list=baseDao.getList(PubConstants.SUC_FARMPYD, whereMap,fypage,10,sortMap);
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
    public  void    ajaxydlist(){
    	getLscode();  
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
		    HashMap<String, Object>sortMap=new HashMap<String, Object>(); 
			whereMap.put("custid",custid); 
			sortMap.put("createdate", -1);
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			List<DBObject>list=baseDao.getList(PubConstants.SUC_FARMPYD, whereMap,fypage,10,sortMap);
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
     * ajax获取个人卡卷列表
     */
    public  void    ajaxcard(){
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
			List<DBObject>list=baseDao.getList(PubConstants.SUC_FARMPCARD, whereMap,fypage,10,sortMap);
			 
			if(list.size()>0){
				sub_map.put("state", 0);
				for (DBObject dbObject : list) {
					if(dbObject.get("enddjdate")!=null){ 
						String djenddate=dbObject.get("enddjdate").toString();
						   if(!DateUtil.checkbig(DateFormat.getFormat(djenddate))){
								dbObject.put("state", 2);
							}
					} 
				}
				sub_map.put("list",list);
			} 
		 
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    }
    /**
     * ajax获取农场预订活动详情列表
     */
    public  void    ajaxdetailweb(){
    	getLscode(); 
    	String  id=Struts2Utils.getParameter("id");
    	String  wid=Struts2Utils.getParameter("wid");
		Map<String, Object> sub_map = new HashMap<String, Object>();
		if(StringUtils.isNotEmpty(id)&&StringUtils.isNotEmpty(wid)){
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
		    HashMap<String, Object>sortMap=new HashMap<String, Object>();  
			whereMap.put("ydid",id);
			whereMap.put("state",0);
			sortMap.put("createdate", -1);
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			} 
			List<DBObject>list=baseDao.getList(PubConstants.SUC_FARMPYDDETAIL, whereMap,fypage,12,sortMap);
			 
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
					whereMap.clear();
					whereMap.put("custid",custid);
					whereMap.put("fromUserid", dbObject.get("fromUserid").toString());
					whereMap.put("wid", Long.parseLong(wid));
					List<DBObject>listyd=baseDao.getList(PubConstants.SUC_FARMPYD, whereMap, null);
					if(listyd.size()==1){
						dbObject.put("ydvalue",listyd.get(0).get("_id"));
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
    	createfarm(custid,fromUserid);
    	Map<String, Object> sub_map = new HashMap<String, Object>();
    	String id=Struts2Utils.getParameter("id");
    	if(StringUtils.isNotEmpty(id)){
    		DBObject  db=baseDao.getMessage(PubConstants.SUC_FARMPRODUCT, Long.parseLong(id));
    		if(db!=null){
    			//库存已完
    			if(Integer.parseInt(db.get("num").toString())<=0){
    				sub_map.put("state",1);  
    			}else{
    				//验证是否重复预订
    				HashMap<String, Object>whereMap=new HashMap<>();
    				whereMap.put("wid",Long.parseLong(id));
    				whereMap.put("fromUserid",fromUserid);
    				List<DBObject> list=baseDao.getList(PubConstants.SUC_FARMPYD,whereMap,null);
    				if(list.size()>=1){
    					sub_map.put("state", 2);
    					sub_map.put("value",list.get(0).get("_id"));  
    				}else{
    					String  code=DateFormat.getDate()+TenpayUtil.buildRandom(6)+mongoSequence.currval(PubConstants.SUC_FARMPYD);
    					FarmYd  yd=new FarmYd();
    					yd.set_id(code);
    					yd.setCreatedate(new Date());
    					yd.setCustid(custid);
    					yd.setFromUserid(fromUserid);
    					yd.setWid(Long.parseLong(id));
    					yd.setState(0);
    					yd.setObj((FarmProduct)UniObject.DBObjectToObject(db, FarmProduct.class));
    					baseDao.insert(PubConstants.SUC_FARMPYD, yd);
    					sub_map.put("state", 0);
    					sub_map.put("value", code);
    				}
    			}
    		}
    	}
    	String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    }
    /**
     * ajax预订活动
     */
    public  void    ajaxydpay()throws Exception{
    	SortedMap<Object,Object> params = new TreeMap<Object,Object>();
		getLscode();
		createfarm(custid, fromUserid);
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
		String  id=Struts2Utils.getParameter("id");  
		/**
		 * 生成支付订单
		 */  
    	if(StringUtils.isNotEmpty(id)){
    		DBObject  db=baseDao.getMessage(PubConstants.SUC_FARMPRODUCT, Long.parseLong(id));
    		if(db!=null){
    			//库存已完
    			if(Integer.parseInt(db.get("num").toString())<=0){
    				params.put("state",4); 
    				String json = JSONArray.fromObject(params).toString();
    				Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    				return ;
    			}else{
    				//验证是否重复预订
    				HashMap<String, Object>whereMap=new HashMap<>();
    				whereMap.put("wid",Long.parseLong(id));
    				whereMap.put("fromUserid",fromUserid);
    				List<DBObject> list=baseDao.getList(PubConstants.SUC_FARMPYD,whereMap,null);
    				if(list.size()>=1){
    					params.put("state", 5);
    					params.put("value",list.get(0).get("_id"));
    					String json = JSONArray.fromObject(params).toString();
    					Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    					return ;
    				}else{
    					String  code=DateFormat.getDate()+TenpayUtil.buildRandom(6)+mongoSequence.currval(PubConstants.SUC_FARMPYD);
    					FarmYd  yd=new FarmYd();
    					yd.set_id(code);
    					yd.setCreatedate(new Date());
    					yd.setCustid(custid);
    					yd.setFromUserid(fromUserid);
    					yd.setWid(Long.parseLong(id));
    					if(Double.parseDouble(db.get("price").toString())<=0){
    						yd.setState(0);
        					yd.setObj((FarmProduct)UniObject.DBObjectToObject(db, FarmProduct.class));
        					baseDao.insert(PubConstants.SUC_FARMPYD, yd);
        					params.put("state",6);
        					params.put("value",code);
        					String json = JSONArray.fromObject(params).toString();
        					Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    					}else{ 
    						yd.setState(1);
        					yd.setObj((FarmProduct)UniObject.DBObjectToObject(db, FarmProduct.class));
        					baseDao.insert(PubConstants.SUC_FARMPYD, yd);
        					

        					StringBuffer attach=new StringBuffer(code+"");//传递订单编号 
        					attach.append("&").append(custid); 
        					String nonce_str=PayCommonUtil.CreateNoncestr();
        					SortedMap<Object,Object> parameters = new TreeMap<Object,Object>(); 
        					parameters.put("appid", wxconfig.getAppid());//公众账号ID 
        					parameters.put("mch_id", wxconfig.getPartner());//商户号
        					parameters.put("nonce_str", nonce_str);//随机字符串
        					parameters.put("attach", attach.toString());
        					parameters.put("body", db.get("title"));//商品描述
        					parameters.put("is_subscribe", "Y"); 
        					parameters.put("out_trade_no", code);
        					parameters.put("total_fee",BaseDecimal.round(BaseDecimal.multiplication(db.get("price").toString(), "100"),0));//总金额
        					parameters.put("spbill_create_ip",Struts2Utils.getRequest().getRemoteAddr());//终端ip  
        					parameters.put("notify_url", this.getCtxurl()+"/suc/farm!payok.action");//通知地址 
        					parameters.put("trade_type", "JSAPI");//支付类型 
        					parameters.put("openid", wx.get("fromUser").toString());//用户ID
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
    					 
    				}
    			}
    		}
    	}
		
    }
    /**
	 * 支付回调
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
            DBObject  db=baseDao.getMessage(PubConstants.SUC_FARMPYD,orderno);
            if(db!=null){
            	FarmYd yd=(FarmYd) UniObject.DBObjectToObject(db, FarmYd.class);
            	yd.setState(0);
            	baseDao.insert(PubConstants.SUC_FARMPYD, yd);
            }
        	
        	Struts2Utils.getResponse().getWriter().write(PayCommonUtil.setXML("SUCCESS", ""));
        	
        }else{
        	Struts2Utils.getResponse().getWriter().write(PayCommonUtil.setXML("SUCCESS", ""));
        }
   
	}
    /**
     * ajax删除预订
     */
    public  void   ajaxdelyd(){
    	getLscode();
    	Map<String, Object> sub_map = new HashMap<String, Object>();
    	String id=Struts2Utils.getParameter("id");
    	if(StringUtils.isNotEmpty(id)){
    		baseDao.delete(PubConstants.SUC_FARMPYD, id);
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
		String  url=SysConfig.getProperty("ip")+"/suc/farm!mbTicket.action?custid="+custid+"&id="+id;  
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
			DBObject  yd=baseDao.getMessage(PubConstants.SUC_FARMPYD, whereMap);
			if(yd!=null){
				whereMap.clear();
				whereMap.put("hdid",yd.get("_id").toString());
				whereMap.put("fromUserid", fromUserid);
				whereMap.put("custid",custid);
				whereMap.put("lx",2);
				DBObject  card=baseDao.getMessage(PubConstants.SUC_FARMPCARD, whereMap);
				if(card!=null){
					FarmCard rr=(FarmCard) UniObject.DBObjectToObject(card, FarmCard.class);
					if(DateUtil.checkbig(rr.getEnddjdate())){
						if(rr.getState()==0){
							//未兑奖
							rr.setState(1);
							baseDao.insert(PubConstants.SUC_FARMPCARD, rr);
							Struts2Utils.getRequest().setAttribute("state", 0);
							Struts2Utils.getRequest().setAttribute("jp",rr.getTitle());
						}else{
							//已兑奖
							Struts2Utils.getRequest().setAttribute("state", 4);
							Struts2Utils.getRequest().setAttribute("jp",rr.getTitle());
						} 
						
					 }else{
						 //过期
						 rr.setState(2);
					     baseDao.insert(PubConstants.WHD_REWARDRECORD, rr);
						 Struts2Utils.getRequest().setAttribute("state", 3); 
						 Struts2Utils.getRequest().setAttribute("jp",rr.getTitle());
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
			DBObject  db=baseDao.getMessage(PubConstants.SUC_FARMPRODUCT,Long.parseLong(id));
			if(db!=null){
				FarmProduct  obj=(FarmProduct) UniObject.DBObjectToObject(db, FarmProduct.class);
				obj.setEwmurl(wwzService.recode("activity-mbTicket-"+id,SysConfig.getProperty("ip")+"/suc/activity!mbTicket.action?custid="+custid+"&id="+id, obj.getPicurl(),true, 200, 1000));
				baseDao.insert(PubConstants.SUC_FARMPRODUCT,obj);
				sub_map.put("state", 0);
				sub_map.put("value",obj.getEwmurl());
			}
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * ajax修改农场
	 */
	public  void  ajaxupdfarm(){
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		DBObject  db=baseDao.getMessage(PubConstants.SUC_FARM, custid+"-"+fromUserid);
		if(db!=null){
			Farm farm=(Farm) UniObject.DBObjectToObject(db, Farm.class);
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("picurl"))){
				farm.setPicurl(Struts2Utils.getParameter("picurl"));	
			}
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("summary"))){
				farm.setSummary(Struts2Utils.getParameter("summary"));	
			}
			baseDao.insert(PubConstants.SUC_FARM, farm);
			sub_map.put("state", 0);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 获取排行榜
	 */
	public  void  ajaxrank(){
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>();
	    HashMap<String, Object>whereMap=new HashMap<>();
	    HashMap<String, Object>sortMap=new HashMap<>();
	    HashMap<String, Object>backMap=new HashMap<>();
	    String type=Struts2Utils.getParameter("type"); 
	    whereMap.put("type", type); 
	    whereMap.put("custid", custid);
	    whereMap.put("rank",new BasicDBObject("$gt",0));
	    sortMap.put("rank",1); 
	    List<DBObject>list=baseDao.getList(PubConstants.SUC_RANKING, whereMap,0,50,sortMap,backMap); 
	    if(list.size()>0){
	    	sub_map.put("state",0); 
	    	sub_map.put("list", list);
	    }
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 获取预订排行榜
	 */
	public  void  ajaxrankyd(){
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>();
	    HashMap<String, Object>whereMap=new HashMap<>();
	    HashMap<String, Object>sortMap=new HashMap<>();
	    HashMap<String, Object>backMap=new HashMap<>();
	    whereMap.put("custid", custid); 
	    String ydid=Struts2Utils.getParameter("ydid");
	    String id=Struts2Utils.getParameter("id");
	    whereMap.put("type", "farm-"+ydid);
	    sortMap.put("rank",1); 
	    List<DBObject>list=baseDao.getList(PubConstants.SUC_RANKING, whereMap,0,50,sortMap,backMap);
	    if(list.size()>0){
	    	sub_map.put("state",0);
	    	sub_map.put("list", list);
	    	sub_map.put("value", baseDao.getMessage(PubConstants.SUC_RANKING, "farm-"+ydid+"-"+id));
	    }
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 记录到榜单
	 */
	public  void  saverank(String id,int value,String name,String picurl,String custid){
		//记录到榜单
		Ranking  rank=null;
		DBObject  dbrank=baseDao.getMessage(PubConstants.SUC_RANKING, "farm-"+id);
		if(dbrank==null){ 
			rank=new Ranking();
			rank.set_id("farm-"+id);  
			rank.setType("farm");
			rank.setValue(value); 
			rank.setRankid(id);
			rank.setRankname(name);
			rank.setPicurl(picurl);
			rank.setCustid(custid);
			baseDao.insert(PubConstants.SUC_RANKING, rank);
		}else{
			rank=(Ranking) UniObject.DBObjectToObject(dbrank, Ranking.class);
			rank.setValue(value);
			rank.setCustid(custid);
			baseDao.insert(PubConstants.SUC_RANKING, rank);
		}
	}
	/**
	 * 记录到榜单
	 */
	public  void  saveranking(String id,int value,String name,String picurl,String yd,String custid){
		//记录到榜单
		Ranking  rank=null;
		DBObject  dbrank=baseDao.getMessage(PubConstants.SUC_RANKING, "farm-"+yd+"-"+id);
		if(dbrank==null){ 
			rank=new Ranking();
			rank.set_id("farm-"+yd+"-"+id);  
			rank.setType("farm-"+yd);
			rank.setValue(value); 
			rank.setRankid(id);
			rank.setRankname(name);
			rank.setPicurl(picurl);
			rank.setCustid(custid);
			baseDao.insert(PubConstants.SUC_RANKING, rank);
		}else{
			rank=(Ranking) UniObject.DBObjectToObject(dbrank, Ranking.class);
			rank.setValue(value);
			rank.setCustid(custid);
			baseDao.insert(PubConstants.SUC_RANKING, rank);
		}
	}
	/**
	 * 生成个人农场
	 * @param custid
	 * @param fromUserid
	 */
	public  DBObject  createfarm(String custid,String fromUserid){
		DBObject  db=baseDao.getMessage(PubConstants.SUC_FARM, custid+"-"+fromUserid);
		if(db==null){
			Farm f=new Farm();
			f.set_id(custid+"-"+fromUserid);
			f.setFromUserid(fromUserid);
			f.setCustid(custid);
			baseDao.insert(PubConstants.SUC_FARM, f);
			db=baseDao.getMessage(PubConstants.SUC_FARM, custid+"-"+fromUserid);
		}
		return db;
	}
	/**
	 * 添加足迹
	 */
	public  void createfoot(String custid,String fromUserid,String summary,String wid,String fid,Long pid){
		FarmFoot foot=new FarmFoot();
		foot.set_id(mongoSequence.currval(PubConstants.SUC_FARMPFOOT));
		foot.setCreatedate(new Date());
		foot.setCustid(custid);
		foot.setFromUserid(fromUserid);
		foot.setWid(wid);
		foot.setSummary(summary);
		foot.setFid(fid);
		foot.setPid(pid);
		baseDao.insert(PubConstants.SUC_FARMPFOOT, foot);
	}
	/**
	 * 玩法说明
	 * @return
	 */
	public String playinstructions(){
		getLscode();
		Struts2Utils.getRequest().setAttribute("custid",custid);
		String  id=Struts2Utils.getParameter("id");
		WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		}
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/farm!playinstructions.action?custid="+custid+"&id="+id;  
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
			DBObject  db=baseDao.getMessage(PubConstants.SUC_FARMPRODUCT, Long.parseLong(id));
			Struts2Utils.getRequest().setAttribute("entity",db);
			DBObject  share=new BasicDBObject();
			
			share.put("fxtitle",db.get("title")); 
			share.put("fximg", wwzService.getWxUsertype(fromUserid,"headimgurl"));
			share.put("fxsummary", db.get("summary"));
			share.put("fxurl",url);
		}
		return "playinstructions";
	}
	/**
	 * 获取足迹
	 */
	public  void  ajaxfoot(){
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>();
	    HashMap<String, Object>whereMap=new HashMap<>();
	    HashMap<String, Object>sortMap=new HashMap<>(); 
	    String fid=Struts2Utils.getParameter("fid");
	    if(StringUtils.isNotEmpty(fid)){
	    	 whereMap.put("fid", Struts2Utils.getParameter("fid"));	
	    }else{
	    	 whereMap.put("fid", custid+"-"+fromUserid);
	    }
	   
	    if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
	    	fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
	    }
	    sortMap.put("createdate", -1);
	    List<DBObject>list=baseDao.getList(PubConstants.SUC_FARMPFOOT, whereMap,0,fypage,sortMap);
	    if(list.size()>0){
	    	sub_map.put("state",0);
	    	for (DBObject dbObject : list) {
	    		dbObject.put("nickname",wwzService.getWxUsertype(dbObject.get("fromUserid").toString(), "nickname"));
	    		dbObject.put("headimgurl",wwzService.getWxUsertype(dbObject.get("fromUserid").toString(), "headimgurl"));
	    		
			}
	    	sub_map.put("list", list); 
	    }
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 个人农场首页
	 * @return
	 */
	public  String  myindex(){
		getLscode(); 
		Struts2Utils.getRequest().setAttribute("custid",custid); 
		String id=Struts2Utils.getParameter("id");
		
		WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		}
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/farm!myindex.action?custid="+custid+"&id="+id;  
		if(StringUtils.isEmpty(id)){
			 url=SysConfig.getProperty("ip")+"/suc/farm!myindex.action?custid="+custid;  
		}else{
			Struts2Utils.getRequest().setAttribute("id",id);
		}
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}
		DBObject  db=null; 
		if(StringUtils.isNotEmpty(id)){ 
			db=baseDao.getMessage(PubConstants.SUC_FARM,id); 
			//加载排行信息
			if(db!=null){
				DBObject  rank=baseDao.getMessage(PubConstants.SUC_RANKING, "farm-"+custid+"-"+db.get("fromUserid").toString());
				if(rank!=null&&Integer.parseInt(rank.get("rank").toString())>0){
					Struts2Utils.getRequest().setAttribute("rankno","排名：NO."+rank.get("rank"));
				}else{
					Struts2Utils.getRequest().setAttribute("rankno","未上榜");
				}
			}
			
		}else{ 
			db=createfarm(custid,fromUserid); 
			Struts2Utils.getRequest().setAttribute("isadmin","ok");
			//加载排行信息
			DBObject  rank=baseDao.getMessage(PubConstants.SUC_RANKING, "farm-"+custid+"-"+fromUserid);
			 
			if(rank!=null&&Integer.parseInt(rank.get("rank").toString())>0){
				Struts2Utils.getRequest().setAttribute("rankno","排名：NO."+rank.get("rank"));
			}else{
				Struts2Utils.getRequest().setAttribute("rankno","未上榜");
			}
			
		}
		if(db!=null){
			db.put("headimgurl", wwzService.getWxUsertype(db.get("fromUserid").toString(),"headimgurl"));
			db.put("nickname", wwzService.getWxUsertype(db.get("fromUserid").toString(),"nickname"));
		}  
		Struts2Utils.getRequest().setAttribute("entity",db);
		DBObject share=wwzService.getShareFx(custid,"farm_share");  
		if(share==null){
			share=new BasicDBObject();
			share.put("fxtitle", wwzService.getWxUsertype(fromUserid, "nickname"));
			share.put("fximg",wwzService.getWxUsertype(fromUserid, "headimgurl"));
			share.put("fxurl", url);
			share.put("fxsummary", "我在这里玩根本停不下来，小伙伴们还等什么！");
		}else{
			share.put("fxurl", url);
		} 
		Struts2Utils.getRequest().setAttribute("share",share);
		return "myindex";
	}
	/**
	 * 参与活动
	 */
	public  void   ajaxplay()throws Exception{
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		//活动ID
		String id=Struts2Utils.getParameter("id");
		//道具ID
		String pid=Struts2Utils.getParameter("pid");
		//检测活动
		DBObject  dbyd=baseDao.getMessage(PubConstants.SUC_FARMPYD,id);
		if(dbyd!=null){
			FarmYd  yd=(FarmYd) UniObject.DBObjectToObject(dbyd, FarmYd.class);
			if(DateUtil.checkbig(yd.getObj().getStartdate())){
				//未开始
				sub_map.put("state",1);
				String json = JSONArray.fromObject(sub_map).toString();
				Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
				return;
			}else if(DateUtil.checksimal(yd.getObj().getEnddate())){
				//已结束
				sub_map.put("state",2);
				String json = JSONArray.fromObject(sub_map).toString();
				Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
				return;
			}else if(yd.getObj().getNowgrowth()>=yd.getObj().getGrowth()){
				//经验值已满  
				sub_map.put("state",3);
				String json = JSONArray.fromObject(sub_map).toString();
				Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
				return;
			}else if(Integer.parseInt(baseDao.getMessage(PubConstants.SUC_FARMPRODUCT,yd.getWid()).get("num").toString())<1){
				//库存已完
				sub_map.put("state",4);
				String json = JSONArray.fromObject(sub_map).toString();
				Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
				return;
			}else{
				//检测道具是否可用
				DBObject  props=baseDao.getMessage(PubConstants.SUC_FARMPPROPS, Long.parseLong(pid));
				if(props!=null){
					HashMap<String,Object>whereMap=new HashMap<>();
					whereMap.put("ydid",id);
					whereMap.put("cid", Long.parseLong(pid));
					whereMap.put("fromUserid", fromUserid);
					//每日时间验证
					BasicDBObject dateCondition = new BasicDBObject(); 
					dateCondition.append("$gte",com.lsp.pub.util.DateUtil.getTimesmorning());
					dateCondition.append("$lt",com.lsp.pub.util.DateUtil.getTimesnight()); 
					whereMap.put("createdate", dateCondition);
					Long  count=baseDao.getCount(PubConstants.SUC_FARMPYDDETAIL, whereMap);
					if(Long.parseLong(props.get("bigCount").toString())==-1||count<Long.parseLong(props.get("bigCount").toString())){
						 //参与活动
						 FarmYdDetail detail=new FarmYdDetail();
						 Long did=mongoSequence.currval(PubConstants.SUC_FARMPYDDETAIL);
						 detail.set_id(did);
						 detail.setYdid(id);
						 detail.setCid(Long.parseLong(pid));
						 detail.setFromUserid(fromUserid);
						 detail.setCreatedate(new Date());
						 detail.setCustid(custid); 
						 detail.setGrowth(Integer.parseInt(props.get("growth").toString()));
						
						 //验证支付
						 if(Double.parseDouble(props.get("price").toString())<=0){
							 detail.setState(0);
							 baseDao.insert(PubConstants.SUC_FARMPYDDETAIL, detail);
							 FarmProduct pro=yd.getObj();
							 if(pro.getNowgrowth()+Integer.parseInt(props.get("growth").toString())>pro.getGrowth()){ 
								 pro.setNowgrowth(pro.getGrowth());
							 }else{ 
								 pro.setNowgrowth(pro.getNowgrowth()+Integer.parseInt(props.get("growth").toString()));	 
							 } 
							 yd.setGrowth(yd.getGrowth()+Integer.parseInt(props.get("growth").toString()));
							 yd.setObj(pro);
							 baseDao.insert(PubConstants.SUC_FARMPYD, yd);
							 //更新库存
							 if(pro.getNowgrowth()>=pro.getGrowth()){
								 pro=(FarmProduct) UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.SUC_FARMPRODUCT,yd.getWid()), FarmProduct.class);
								 pro.setNum(pro.getNum()-1);
								 pro.setGmnum(pro.getGmnum()+1);
								 baseDao.insert(PubConstants.SUC_FARMPRODUCT, pro);
								 //生成卡卷
								 /**FarmCard card=new FarmCard();
								 String yhjid=BaseDate.generateShortUuid().toUpperCase();
								 card.set_id(mongoSequence.currval(PubConstants.SUC_FARMPCARD));
								 card.setCreatedate(new Date());
								 card.setCustid(custid);
								 card.setDjm(yhjid);
								 card.setStartdjdate(pro.getStartdate());
								 card.setEnddjdate(pro.getEnddate());
								 card.setFromUserid(yd.getFromUserid());
								 card.setHdid(yd.getWid());
								 card.setTitle(pro.getTitle());
								 card.setState(0);
								 card.setSummary(pro.getTitle()+"兑奖卷");
								 baseDao.insert(PubConstants.SUC_FARMPCARD,card);*/
							 }
							 //更新农场
							 Farm  farm=(Farm) UniObject.DBObjectToObject(createfarm(custid, yd.getFromUserid()), Farm.class);
							  
							 farm.setCharm(farm.getCharm()+Integer.parseInt(props.get("charm").toString()));
							 farm.setGrowth(farm.getGrowth()+Integer.parseInt(props.get("growth").toString()));
							 baseDao.insert(PubConstants.SUC_FARM, farm);
							 //添加足迹
							 String str="为您在 "+pro.getTitle()+" 活动中进行了 "+props.get("title");
							 createfoot(custid, fromUserid,str, id, custid+"-"+yd.getFromUserid(),Long.parseLong(pid));
							 //记录到榜单
							 saverank(custid+"-"+yd.getFromUserid(),farm.getCharm(),wwzService.getWxUsertype(yd.getFromUserid(), "nickname"),wwzService.getWxUsertype(yd.getFromUserid(), "headimgurl"),custid);
							 saveranking(id,yd.getGrowth(), wwzService.getWxUsertype(yd.getFromUserid(), "nickname"),wwzService.getWxUsertype(yd.getFromUserid(), "headimgurl"),yd.getWid()+"",custid);
							 sub_map.put("state",8);
							 String json = JSONArray.fromObject(sub_map).toString();
							 Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
							 return;
						 }else{
							 //支付
							 detail.setState(1);
							 baseDao.insert(PubConstants.SUC_FARMPYDDETAIL, detail);
							 SortedMap<Object,Object> params = new TreeMap<Object,Object>();
							 WxToken wxtoken=GetAllFunc.wxtoken.get(custid);
								WxPayConfig wxconfig=new WxPayConfig();
								if(wxtoken.getQx()==0){
									 sub_map.put("state",6);
									 String json = JSONArray.fromObject(sub_map).toString();
									 Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
									return;
								}else if(wxtoken.getQx()==1){
									wxconfig=GetAllFunc.wxPay.get(custid);
								}else if(wxtoken.getQx()==2){//父类结算   
									wxconfig=GetAllFunc.wxPay.get(wwzService.getparentcustid(custid));
								}
								
								if(wxconfig==null||wxconfig.getAppid()==null){
									 sub_map.put("state",7);
									 String json = JSONArray.fromObject(sub_map).toString();
									 Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
									return;
								}
								String  code=DateFormat.getDate()+TenpayUtil.buildRandom(6)+did;
								StringBuffer attach=new StringBuffer(did+"");//传递订单编号 
	        					attach.append("&").append(custid);
	        					attach.append("&").append(yd.getFromUserid());
	        					String nonce_str=PayCommonUtil.CreateNoncestr();
	        					SortedMap<Object,Object> parameters = new TreeMap<Object,Object>(); 
	        					parameters.put("appid", wxconfig.getAppid());//公众账号ID 
	        					parameters.put("mch_id", wxconfig.getPartner());//商户号
	        					parameters.put("nonce_str", nonce_str);//随机字符串
	        					parameters.put("attach", attach.toString());
	        					parameters.put("body", props.get("title"));//商品描述
	        					parameters.put("is_subscribe", "Y"); 
	        					parameters.put("out_trade_no", code);
	        					parameters.put("total_fee",BaseDecimal.round(BaseDecimal.multiplication(props.get("price").toString(), "100"),0));//总金额
	        					parameters.put("spbill_create_ip",Struts2Utils.getRequest().getRemoteAddr());//终端ip  
	        					parameters.put("notify_url", this.getCtxurl()+"/suc/farm!paypropsok.action");//通知地址 
	        					parameters.put("trade_type", "JSAPI");//支付类型 
	        					parameters.put("openid",wwzService.getWxUsertype(fromUserid, "fromUser"));//用户ID
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
						
						 
					}else{
						//今日次数已完
						sub_map.put("state",5);
						String json = JSONArray.fromObject(sub_map).toString();
						Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
						return;
					}
				}
			}
		}
	
	}
	/**
	 * 支付回调
	 */
	public void  paypropsok() throws Exception{
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
            DBObject  db=baseDao.getMessage(PubConstants.SUC_FARMPYDDETAIL,Long.parseLong(orderno));
            
            if(db!=null){
            	 FarmYdDetail yddetail=(FarmYdDetail) UniObject.DBObjectToObject(db, FarmYdDetail.class);
            	 yddetail.setState(0);
            	 baseDao.insert(PubConstants.SUC_FARMPYDDETAIL, yddetail);
            	 DBObject  yddb=baseDao.getMessage(PubConstants.SUC_FARMPYD,yddetail.getYdid());
            	 DBObject  props=baseDao.getMessage(PubConstants.SUC_FARMPPROPS,yddetail.getCid());
            	  
            	 if(yddb!=null){
            		 FarmYd  yd=(FarmYd) UniObject.DBObjectToObject(yddb, FarmYd.class);
            		 FarmProduct pro=yd.getObj(); 
            		 
            		 if(pro.getNowgrowth()+Integer.parseInt(props.get("growth").toString())>pro.getGrowth()){ 
    					 pro.setNowgrowth(pro.getGrowth());
    				 }else{ 
    					 pro.setNowgrowth(pro.getNowgrowth()+Integer.parseInt(props.get("growth").toString()));	 
    				 } 
    				 yd.setGrowth(yd.getGrowth()+Integer.parseInt(props.get("growth").toString()));
    				 yd.setObj(pro);
    				 baseDao.insert(PubConstants.SUC_FARMPYD, yd);
    				 //更新库存
    				 if(pro.getNowgrowth()>=pro.getGrowth()){
    					 pro=(FarmProduct) UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.SUC_FARMPRODUCT,yd.getWid()), FarmProduct.class);
    					 pro.setNum(pro.getNum()-1);
    					 pro.setGmnum(pro.getGmnum()+1);
    					 baseDao.insert(PubConstants.SUC_FARMPRODUCT, pro);
    					 //生成卡卷
    					/** FarmCard card=new FarmCard();
    					 String yhjid=BaseDate.generateShortUuid().toUpperCase();
    					 card.set_id(mongoSequence.currval(PubConstants.SUC_FARMPCARD));
    					 card.setCreatedate(new Date());
    					 card.setCustid(custid);
    					 card.setDjm(yhjid);
    					 card.setStartdjdate(pro.getStartdate());
    					 card.setEnddjdate(pro.getEnddate());
    					 card.setFromUserid(yd.getFromUserid());
    					 card.setHdid(yd.getWid());
    					 card.setTitle(pro.getTitle());
    					 card.setState(0);
    					 card.setSummary(pro.getTitle()+"兑奖卷");
    					 baseDao.insert(PubConstants.SUC_FARMPCARD,card);*/
    				 }
    				 //更新农场
    				 Farm  farm=(Farm) UniObject.DBObjectToObject(createfarm(custid, yd.getFromUserid()), Farm.class);
    				  
    				 farm.setCharm(farm.getCharm()+Integer.parseInt(props.get("charm").toString()));
    				 farm.setGrowth(farm.getGrowth()+Integer.parseInt(props.get("growth").toString()));
    				 baseDao.insert(PubConstants.SUC_FARM, farm);
    				 //添加足迹 
    				 String str="为您在 "+pro.getTitle()+" 活动中进行了 "+baseDao.getMessage(PubConstants.SUC_FARMPPROPS, yddetail.getCid()).get("title");
    				 createfoot(custid, fromUserid,str, yd.get_id().toString(), custid+"-"+yd.getFromUserid(),yddetail.getCid());
    				 //记录到榜单
    				 saverank(custid+"-"+fromUserid,farm.getCharm(),wwzService.getWxUsertype(yd.getFromUserid(), "nickname"),wwzService.getWxUsertype(yd.getFromUserid(), "headimgurl"),custid);
    				 saveranking(yd.get_id().toString(),yd.getGrowth(), wwzService.getWxUsertype(yd.getFromUserid(), "nickname"),wwzService.getWxUsertype(yd.getFromUserid(), "headimgurl"), yd.getWid()+"",custid);
    				 
            	 }
            	
            }
        	
        	Struts2Utils.getResponse().getWriter().write(PayCommonUtil.setXML("SUCCESS", ""));
        	
        }else{
        	Struts2Utils.getResponse().getWriter().write(PayCommonUtil.setXML("SUCCESS", ""));
        }
   
	}
	/**
	 * 卡卷列表
	 * @return
	 */
	public  String  cardweb(){
		getLscode(); 
		Struts2Utils.getRequest().setAttribute("custid",custid);  
		WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		}
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/farm!card.action?custid="+custid;  
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}
		//加载地址信息
		HashMap<String, Object>whereMap=new HashMap<>(); 
		whereMap.put("fromUserid",fromUserid);
		whereMap.put("lx", 1);
		DBObject  address=baseDao.getMessage(PubConstants.SHOP_USERADDRESS, whereMap);  
		Struts2Utils.getRequest().setAttribute("address",address); 
		return "cardweb";
	}
	/**
	 * 后台卡卷
	 * @return
	 */
	public  String  card(){
		String  id=Struts2Utils.getParameter("id");
		String  djm=Struts2Utils.getParameter("djm");
		String  state=Struts2Utils.getParameter("state");
		custid=SpringSecurityUtils.getCurrentUser().getId();
		HashMap<String, Object>whereMap=new HashMap<>();
		HashMap<String, Object>sortMap=new HashMap<>();
		whereMap.put("hdid",Long.parseLong(id));
		whereMap.put("custid",custid);
		if(StringUtils.isNotEmpty(djm)){
			whereMap.put("djm",djm);
			Struts2Utils.getRequest().setAttribute("djm",djm);
			}
		if(StringUtils.isNotEmpty(state)){
			whereMap.put("state",Integer.parseInt(state));
			Struts2Utils.getRequest().setAttribute("state",state);
			}
		sortMap.put("createdate",-1);
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			
		}
		List<DBObject>list=baseDao.getList(PubConstants.SUC_FARMPCARD, whereMap,fypage,10,sortMap);
		fycount=baseDao.getCount(PubConstants.SUC_FARMPCARD, whereMap);
		for (DBObject dbObject : list) {
			dbObject.put("headimgurl",wwzService.getWxUsertype(dbObject.get("fromUserid").toString(), "headimgurl"));
			dbObject.put("nickname",wwzService.getWxUsertype(dbObject.get("fromUserid").toString(), "nickname"));
		}
		Struts2Utils.getRequest().setAttribute("list",list); 
		Struts2Utils.getRequest().setAttribute("hdid",id);
		
		whereMap.clear();
		whereMap.put("custid", SpringSecurityUtils.getCurrentUser().getId());
		sortMap.clear();
		sortMap.put("createdate",-1);
		List<DBObject>lskd=baseDao.getList(PubConstants.SET_COURIER, whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("lskd", lskd);
		
		return "card";
	}
	/**
	 * ajax兑奖
	 */
	public void  ajaxdj(){
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		String id=Struts2Utils.getParameter("id");
		DBObject  db=baseDao.getMessage(PubConstants.SUC_FARMPCARD, Long.parseLong(id));
		if(db!=null){
			FarmCard card=(FarmCard) UniObject.DBObjectToObject(db, FarmCard.class);
			card.setState(1);
			baseDao.insert(PubConstants.SUC_FARMPCARD, card);
			sub_map.put("state", 0);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * ajax后台兑奖
	 */
	public void  ajaxhtdj(){
		custid=SpringSecurityUtils.getCurrentUser().getId();
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		String id=Struts2Utils.getParameter("id");
		DBObject  db=baseDao.getMessage(PubConstants.SUC_FARMPCARD, Long.parseLong(id));
		if(db!=null){
			FarmCard card=(FarmCard) UniObject.DBObjectToObject(db, FarmCard.class);
			card.setState(1);
			baseDao.insert(PubConstants.SUC_FARMPCARD, card);
			sub_map.put("state", 0);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * ajax生成农场id
	 */
	public void  ajaxcreatefarmid(){
		 getLscode();
		 String id=Struts2Utils.getParameter("id"); 
		 Map<String, Object> sub_map = new HashMap<String, Object>();
		 if(StringUtils.isNotEmpty(id)){ 
			 createfarm(custid, id); 
			 sub_map.put("state",0);
			 sub_map.put("value",  custid+"-"+id);
			  
		 }
		 String json = JSONArray.fromObject(sub_map).toString();
	     Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	} 
	 
	
	/**
	 * 导出卡卷
	 * @throws Exception
	 */
	public void exp() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
	
		String hdid=Struts2Utils.getParameter("hdid");
		Struts2Utils.getRequest().setAttribute("hdid", hdid);
		  
		whereMap.put("hdid",  Long.parseLong(hdid));
		sortMap.put("createdate", -1);
		
		List<DBObject> list=baseDao.getList(PubConstants.SUC_FARMPCARD,whereMap, sortMap);
		List<DBObject> relist=new ArrayList<DBObject>(); 
		//微信用户查询
		for(DBObject db:list){
			db.put("createdate",DateFormat.getDate(DateFormat.getFormat(db.get("createdate").toString())));
			if(db.get("enddjdate")!=null){
				db.put("enddjdate",DateFormat.getDate(DateFormat.getFormat(db.get("enddjdate").toString()))); 	
			}
			if(db.get("fromUserid")!=null){
			DBObject user=baseDao.getMessage(PubConstants.DATA_WXUSER, db.get("fromUserid").toString());
			if(user!=null){ 
				if(user.get("nickname")!=null){
					db.put("nickname", user.get("nickname").toString());
				}else{
					db.put("nickname", "");
				}
				 
			}
			relist.add(db);	
			}
		}
		
		String[] header={"id", "奖品","微信名",   "中奖日期","结束兑奖日期", "兑奖码"};  
		String[] body={"_id", "summary","nickname", "createdate","enddjdate", "djm"}; 
		
		String newtime = new Date().getTime() + ".xls";
		
		HSSFWorkbook wb = ExportExcel.exportByMongo(relist, header, body, newtime);  
		Struts2Utils.getResponse().setHeader("Content-disposition", "attachment;filename="
				+ URLEncoder.encode(newtime, "utf-8"));
        OutputStream ouputStream = Struts2Utils.getResponse().getOutputStream();  
        wb.write(ouputStream);  
        ouputStream.flush();  
        ouputStream.close();  
	}
	/**
	 * 获取用户某款产品的预订ID
	 */
	public  void  getydid(){
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		String id=Struts2Utils.getParameter("id");
		String wid=Struts2Utils.getParameter("wid");
		if(StringUtils.isNotEmpty(id)&&StringUtils.isNotEmpty(wid)){
			HashMap<String, Object>whereMap=new HashMap<>();
			whereMap.put("custid",custid);
			whereMap.put("fromUserid", fromUserid);
			whereMap.put("wid", Long.parseLong(wid));
			List<DBObject>list=baseDao.getList(PubConstants.SUC_FARMPYD, whereMap, null);
			if(list.size()==1){
				sub_map.put("state", 0);
				sub_map.put("value",list.get(0).get("_id"));
			}
		}
		String json = JSONArray.fromObject(sub_map).toString();
	    Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	} 
	/**
	 * ajax生成卡卷
	 */
	public  void  getcard(){
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		String  id=Struts2Utils.getParameter("id");
		if(StringUtils.isNotEmpty(id)){
			DBObject  db=baseDao.getMessage(PubConstants.SUC_FARMPYD,id);
			if(db!=null&&db.get("fromUserid").toString().equals(fromUserid)){
				FarmYd  yd=(FarmYd) UniObject.DBObjectToObject(db,FarmYd.class);
				//验证是否成熟
				if(yd.getObj().getGrowth()<=yd.getGrowth()){
					//生成卡卷
					 HashMap<String,Object>whereMap=new HashMap<>();
					 whereMap.put("hdid",yd.getWid());
					 whereMap.put("custid",custid);
					 whereMap.put("fromUserid",fromUserid);
					 Long count=baseDao.getCount(PubConstants.SUC_FARMPCARD,whereMap);
					 if(count==0){
						 FarmCard card=new FarmCard();
						 String yhjid=BaseDate.generateShortUuid().toUpperCase();
						 card.set_id(mongoSequence.currval(PubConstants.SUC_FARMPCARD));
						 card.setCreatedate(new Date());
						 card.setCustid(custid);
						 card.setDjm(yhjid);
						 card.setStartdjdate(yd.getObj().getStartdate());
						 card.setEnddjdate(yd.getObj().getEnddate());
						 card.setFromUserid(yd.getFromUserid());
						 card.setHdid(yd.getWid());
						 card.setTitle(yd.getObj().getTitle());
						 card.setState(0);
						 card.setSummary(yd.getObj().getTitle()+"兑奖卷");
						 baseDao.insert(PubConstants.SUC_FARMPCARD,card);
						 yd.setState(2);
						 baseDao.insert(PubConstants.SUC_FARMPYD,yd);
						 sub_map.put("state",0); 
					 }else{
						 sub_map.put("state",2); 
					 } 
					 
				}else{
					//没有成熟
					sub_map.put("state",1); 
					
				}
			}else{
				//登录信息错误
				sub_map.put("state",3);  
			}
		}
		String json = JSONArray.fromObject(sub_map).toString();
	    Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * ajax兑奖
	 */
	public  void ajaxchangecard(){
		getLscode();
		String id=Struts2Utils.getParameter("id");
		String type=Struts2Utils.getParameter("type");
		String address=Struts2Utils.getParameter("address");
		String name=Struts2Utils.getParameter("name");
		String tel=Struts2Utils.getParameter("tel");
		Map<String, Object> sub_map = new HashMap<String, Object>();
		if(StringUtils.isNotEmpty(id)){
			DBObject  db=baseDao.getMessage(PubConstants.SUC_FARMPCARD, Long.parseLong(id));
			if(db!=null&&db.get("fromUserid").toString().equals(fromUserid)){
				FarmCard card=(FarmCard) UniObject.DBObjectToObject(db, FarmCard.class);
				if(card.getState()==0&&Integer.parseInt(type)==0){
					//兑奖
					card.setState(1);
					card.setAddress(address);
					card.setName(name);
					card.setTel(tel);
					baseDao.insert(PubConstants.SUC_FARMPCARD, card);
					sub_map.put("state", 0);
				}else if(card.getState()==3&&Integer.parseInt(type)==3){
					//收货
					card.setState(4);
					baseDao.insert(PubConstants.SUC_FARMPCARD, card);
					sub_map.put("state", 0);
				}else if(card.getState()==1){
					//已兑奖
					sub_map.put("state", 1);
				}else if(card.getEnddjdate()!=null&&!DateUtil.checkbig(card.getEnddjdate())){
					//已过期
					sub_map.put("state", 2);
				}
				   
			}
		}
		String json = JSONArray.fromObject(sub_map).toString();
	    Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 后台发货退货
	 * @return
	 */
	public  String  updatecard(){
		custid=SpringSecurityUtils.getCurrentUser().getId();
		String state=Struts2Utils.getParameter("state");
		String cid=Struts2Utils.getParameter("cid");
		if(StringUtils.isNotEmpty(cid)&&StringUtils.isNotEmpty(state)){
			DBObject  db=baseDao.getMessage(PubConstants.SUC_FARMPCARD, Long.parseLong(cid));
			if(db!=null){
				FarmCard card=(FarmCard) UniObject.DBObjectToObject(db, FarmCard.class);
                if(card.getState()==1){
					String courierName=Struts2Utils.getParameter("courierName");
					String courierNo=Struts2Utils.getParameter("courierNo");
					card.setCourierName(courierName);
					card.setCourierNo(courierNo);
				}
				card.setState(Integer.parseInt(state));
				
				baseDao.insert(PubConstants.SUC_FARMPCARD, card); 
			}
			
		}
		return card(); 
	}
	 
	 
}
