package com.lsp.suc.web;

import java.net.URLEncoder;
import java.util.ArrayList;
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
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils; 
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.web.GeneralAction;
import com.lsp.suc.entity.MemorialCircle;
import com.lsp.suc.entity.MemorialComment;
import com.lsp.suc.entity.MemorialCommentPraise;
import com.lsp.suc.entity.MemorialDead;
import com.lsp.suc.entity.MemorialEulogy;
import com.lsp.suc.entity.MemorialEulogyReading;
import com.lsp.suc.entity.MemorialFocuson;
import com.lsp.suc.entity.MemorialInfo; 
import com.lsp.suc.entity.MemorialRelated;
import com.lsp.suc.entity.MemorialTribute;
import com.lsp.suc.entity.MemorialTributeCom;
import com.lsp.website.service.WwzService;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
 
/**
 * 祭奠管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name = MemorialAction.RELOAD, location = "memorial.action",params={"fypage","%{fypage}"}, type = "redirect") })
public class MemorialAction extends GeneralAction<MemorialInfo> {

	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;

	@Autowired
	private WwzService wwzService;
	private MongoSequence mongoSequence;	
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	} 
	private MemorialInfo entity=new MemorialInfo();
	private Long _id;


	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		HashMap<String, Object> backMap =new HashMap<String, Object>();
		String custid=SpringSecurityUtils.getCurrentUser().getId();  
		whereMap.put("custid", custid); 
		String title=Struts2Utils.getParameter("title");
		if(!StringUtils.isEmpty(title)){
			Pattern pattern = Pattern.compile("^.*" + title + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern);
		}
		String  wid=Struts2Utils.getParameter("wid");
		if(StringUtils.isNotEmpty(wid)){
			whereMap.put("wid", Long.parseLong(wid));
		}
		Struts2Utils.getRequest().setAttribute("wid", wid);
		sortMap.put("sort", -1);
		fycount=baseDao.getCount(PubConstants.MEMORIAL_INFO, whereMap);
		
		if(Struts2Utils.getParameter("fypage")!=null){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		backMap.put("content", 0);
		List<DBObject> list=baseDao.getList(PubConstants.MEMORIAL_INFO,whereMap,fypage,10, sortMap,backMap);
		for (DBObject dbObject : list) {
			whereMap.clear();
			sortMap.clear();
			whereMap.put("wid", Long.parseLong(dbObject.get("_id").toString()));
			sortMap.put("sort", -1);
			List<DBObject>lsdead=baseDao.getList(PubConstants.MEMORIAL_DEAD, whereMap, sortMap);
			if(lsdead.size()>0){
				dbObject.put("lsdead",lsdead);
			}
		}
		Struts2Utils.getRequest().setAttribute("MemorialList", list);
		Struts2Utils.getRequest().setAttribute("custid", custid);
		return SUCCESS;
	}
	

	@Override
	public String delete() throws Exception {
		try {
			custid=SpringSecurityUtils.getCurrentUser().getId();
			HashMap<String, Object>whereMap=new HashMap<>();
			whereMap.put("wid", _id);
			baseDao.delete(PubConstants.MEMORIAL_DEAD,whereMap);
			baseDao.delete(PubConstants.MEMORIAL_INFO,_id);
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
			entity = (MemorialInfo)UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.MEMORIAL_INFO,_id),MemorialInfo.class);
		} else {
			entity = new MemorialInfo();
		}
	}
	public void  upd(){ 
		DBObject db=baseDao.getMessage(PubConstants.MEMORIAL_INFO, _id);
		HashMap<String, Object>whereMap=new HashMap<>();
		HashMap<String, Object>sortMap=new HashMap<>();
		sortMap.put("sort", -1);
		whereMap.put("wid", _id);
		List<DBObject>list=baseDao.getList(PubConstants.MEMORIAL_DEAD, whereMap, sortMap);
		db.put("list", list);
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
		
	}
	
	@Override
	public String save() throws Exception {
		//注册业务逻辑
		try {

			if(_id == null){
				_id=mongoSequence.currval(PubConstants.MEMORIAL_INFO);	
			}
			custid=SpringSecurityUtils.getCurrentUser().getId();
			String title=Struts2Utils.getParameter("title");
			String bg=Struts2Utils.getParameter("bg");
			String picurl=Struts2Utils.getParameter("picurl");
			String summary=Struts2Utils.getParameter("summary"); 
			String name=Struts2Utils.getParameter("name"); 
			String nativePlace=Struts2Utils.getParameter("nativePlace"); 
			String professional=Struts2Utils.getParameter("professional"); 
			String birthAddress=Struts2Utils.getParameter("birthAddress"); 
			String burialAddress=Struts2Utils.getParameter("burialAddress"); 
			String birthdate=Struts2Utils.getParameter("birthdate"); 
			String burialdate=Struts2Utils.getParameter("burialdate"); 
			MemorialDead dead=null;
			if(_id == null){
				dead=new MemorialDead();
				dead.set_id(mongoSequence.currval(PubConstants.MEMORIAL_DEAD));
			}else{
				HashMap<String, Object>whereMap=new HashMap<>();
				whereMap.put("wid",_id);
				List<DBObject>list=baseDao.getList(PubConstants.MEMORIAL_DEAD, whereMap, null);
				if(list.size()>0){
					dead=(MemorialDead) UniObject.DBObjectToObject(list.get(0), MemorialDead.class);
				}else{
					dead=new MemorialDead();
					dead.set_id(mongoSequence.currval(PubConstants.MEMORIAL_DEAD));
				}
				
			}  
			dead.setName(name);
			dead.setWid(_id);
			dead.setCustid(custid);
			dead.setFromUserid(custid);
			dead.setCreatedate(new Date());
			dead.setBirthAddress(birthAddress);
			dead.setPicurl(picurl);
			dead.setBirthdate(birthdate);
			dead.setBurialAddress(burialAddress);
			dead.setBurialdate(burialdate);
			dead.setNativePlace(nativePlace);
			dead.setProfessional(professional);
			dead.setSummary(summary);
			dead.setSort(0);
			baseDao.insert(PubConstants.MEMORIAL_DEAD, dead);
			entity.set_id(_id);
			entity.setCustid(custid);
			entity.setFromUserid(custid);
			entity.setCreatedate(new Date()); 
			entity.setTitle(title);
			entity.setPicurl(bg);
			baseDao.insert(PubConstants.MEMORIAL_INFO, entity);  
		
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return RELOAD;
	}

	/**
	 * 祭祀列表
	 * @return
	 * @throws Exception
	 */
	public String web() throws Exception {	
		getLscode();
		WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/suc/memorial!web.action?custid="+custid;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		} 
		Struts2Utils.getRequest().setAttribute("custid", custid);
		DBObject  share=baseDao.getMessage(PubConstants.WEIXIN_SHAREFX, custid+"-memorial_web");
		if(share==null){
			  share=new BasicDBObject();
		  } 
		if(share.get("fxurl")==null||share.get("fxurl").toString().equals("")){
			share.put("fxurl",url);  
		} 
		Struts2Utils.getRequest().setAttribute("share", share); 
		return "web";
	}
	/**
	 * 个人祭祀列表
	 * @return
	 * @throws Exception
	 */
	public String myindex() throws Exception {	
		getLscode();
		WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/suc/memorial!myindex.action?custid="+custid;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		} 
		Struts2Utils.getRequest().setAttribute("custid", custid); 
		DBObject  share=baseDao.getMessage(PubConstants.WEIXIN_SHAREFX, custid+"-memorial_my");
		if(share==null){
			  share=new BasicDBObject();
		  }
		if(share.get("fxurl")==null||share.get("fxurl").toString().equals("")){
			share.put("fxurl",url); 	
		} 
		Struts2Utils.getRequest().setAttribute("share", share); 
		return "myindex";
	}
	 
	/**
	 * 祭祀详情
	 * @return
	 * @throws Exception
	 */
	public String detail()throws Exception{
		getLscode();
		WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/suc/memorial!detail.action?custid="+custid+"&_id="+_id;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		} 
		DBObject  enity=baseDao.getMessage(PubConstants.MEMORIAL_INFO, _id);
		DBObject  wxuser=wwzService.getWxUser(enity.get("fromUserid").toString());
		enity.put("headimgurl",wxuser.get("headimgurl"));
		enity.put("nickname",wxuser.get("nickname"));
		Struts2Utils.getRequest().setAttribute("entity", enity);
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		whereMap.put("wid",_id);
		sortMap.put("sort", 1);
		List<DBObject>list=baseDao.getList(PubConstants.MEMORIAL_DEAD, whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("lsdead", list);
		Struts2Utils.getRequest().setAttribute("custid", custid);
		if(fromUserid.equals(enity.get("fromUserid").toString())){
			Struts2Utils.getRequest().setAttribute("isadmin", true);	
		}else{
			//关注状态
			DBObject db=baseDao.getMessage(PubConstants.MEMORIAL_FOCUSON, _id+"-"+fromUserid);
			if(db!=null){
				Struts2Utils.getRequest().setAttribute("isfoc", true);
			}
		}  
		DBObject  share=baseDao.getMessage(PubConstants.WEIXIN_SHAREFX, custid+"-memorial_detail");
		if(share==null){
			  share=new BasicDBObject();
		  }
		share.put("fxtitle",enity.get("title")); 
		if(share.get("fxurl")==null||share.get("fxurl").toString().equals("")){
			share.put("fxurl",url); 	
		}
		if(share.get("fximg")==null||share.get("fximg").toString().equals("")){ 
			share.put("fximg",wwzService.getWxUser(enity.get("fromUserid").toString()).get("headimgurl")); 
		}
		Struts2Utils.getRequest().setAttribute("share", share);
		
		if(enity.get("mb")!=null&&!enity.get("mb").toString().equals("")){
			return "detail"+enity.get("mb"); 
		}else{
			return "detail";
		}
		
	}
	
	@Override
	public MemorialInfo getModel() {
		return entity;
	}
	public void set_id(Long _id) {
		this._id = _id;
	}
	/**
	 * ajax祭奠列表
	 * @return
	 * @throws Exception 
	 */
	public void ajaxweb() throws Exception { 
		getLscode();
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>(); 
		Map<String, Object> sub_map = new HashMap<String, Object>();
	 
		String sel = Struts2Utils.getParameter("sel");
		if (StringUtils.isNotEmpty(sel)) {
			Pattern pattern = Pattern.compile("^.*" + sel + ".*$",Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern);
			
		}
		whereMap.put("custid", custid);
		String type=Struts2Utils.getParameter("type");
		if(type.equals("1")){
			sortMap.put("comcount", -1); 
		}else if(type.equals("2")){
			sortMap.put("relativescount", -1); 
		}else{
            sortMap.put("createdate", -1); 
		}
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject> proList=baseDao.getList(PubConstants.MEMORIAL_INFO,whereMap,fypage,10, sortMap);
		if(proList.size()>0){
            sub_map.put("state", 0);
            for (DBObject dbObject : proList) {
			      whereMap.clear();
			      sortMap.clear();
			      whereMap.put("wid", Long.parseLong(dbObject.get("_id").toString()));
			      sortMap.put("sort",-1);
			      List<DBObject> lsdead=baseDao.getList(PubConstants.MEMORIAL_DEAD, whereMap, sortMap);
			      if(lsdead.size()>0){
			    	  dbObject.put("lsdead",lsdead); 
			      }
			}
			sub_map.put("list", proList);
			
		}
		
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * ajax评论列表
	 * @return
	 * @throws Exception 
	 */
	public void ajaxcommentweb() throws Exception { 
		getLscode();
		String  id=Struts2Utils.getParameter("id");
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>(); 
		Map<String, Object> sub_map = new HashMap<String, Object>();
	    whereMap.put("wid", Long.parseLong(id));
		sortMap.put("createdate", -1); 
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject> proList=baseDao.getList(PubConstants.MEMORIAL_COMMENT,whereMap,fypage,10, sortMap);
	    if(proList.size()>0){
	    	sub_map.put("state", 0); 
	    	for (DBObject dbObject : proList) { 
	    		if(dbObject.get("tribute")!=null){
	    			String[]ids=dbObject.get("tribute").toString().split(",");
	    			List<DBObject>list=new ArrayList<DBObject>();
	    			for (String string : ids) {
						if(StringUtils.isNotEmpty(string)){
							DBObject db=baseDao.getMessage(PubConstants.MEMORIAL_TRIBUTE, Long.parseLong(string));
							if(db!=null){
								list.add(db);
							}
						}
					}
	    			dbObject.put("lstribute", list);
	    			dbObject.put("lscount", list.size());
	    		}
	    		//加载赞数据
	    		DBObject  db=baseDao.getMessage(PubConstants.MEMORIAL_COMMENTPRAISE, dbObject.get("_id")+"-"+fromUserid);
	    		if(db!=null){
	    			dbObject.put("ispraise", true);
	    		}
				 
			}
	    	sub_map.put("list", proList);
	    }
		
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * ajax添加评论
	 * @return
	 * @throws Exception 
	 */
	public void ajaxcommentadd() throws Exception { 
		getLscode();
		String  id=Struts2Utils.getParameter("id"); 
		Map<String, Object> sub_map = new HashMap<String, Object>();
		if(StringUtils.isNotEmpty(id)){
			String  content=Struts2Utils.getParameter("content");
			String  tribute=Struts2Utils.getParameter("tribute");
			String  cid=Struts2Utils.getParameter("cid"); 
			MemorialComment comment=null;
			if(StringUtils.isNotEmpty(cid)){
			  DBObject  db=baseDao.getMessage(PubConstants.MEMORIAL_COMMENT, Long.parseLong(cid));
			  if(db!=null){
				  comment=(MemorialComment) UniObject.DBObjectToObject(db, MemorialComment.class);
			  }
			}else{
				comment=new MemorialComment();
				comment.set_id(mongoSequence.currval(PubConstants.MEMORIAL_COMMENT));
			}
			if(StringUtils.isNotEmpty(content)){
				comment.setContent(content);
			}
			if(StringUtils.isNotEmpty(tribute)){
				comment.setTribute(tribute);	
			} 
			comment.setWid(Long.parseLong(id));
			DBObject  user=wwzService.getWxUser(fromUserid);
			comment.setHeadimgurl(user.get("headimgurl").toString());
			comment.setNickname(user.get("nickname").toString());
			comment.setCustid(custid);
			comment.setCreatedate(new Date());
			comment.setFromUserid(fromUserid);
			
			baseDao.insert(PubConstants.MEMORIAL_COMMENT, comment);
			
			//增加记录
			//检测是否已经存在 
			DBObject  memo=baseDao.getMessage(PubConstants.MEMORIAL_RELATED, id+"-"+fromUserid);
			if(memo==null){
				MemorialRelated memorialRelated=new MemorialRelated();
				memorialRelated.set_id(id+"-"+fromUserid);
				memorialRelated.setCreatedate(new Date());
				memorialRelated.setCustid(custid);
				memorialRelated.setFromUserid(fromUserid);
				memorialRelated.setWid(Long.parseLong(id));
				baseDao.insert(PubConstants.MEMORIAL_RELATED, memorialRelated);
			}
			 
			DBObject  me=baseDao.getMessage(PubConstants.MEMORIAL_INFO, Long.parseLong(id));
			if(me!=null){
				MemorialInfo info=(MemorialInfo) UniObject.DBObjectToObject(me, MemorialInfo.class);
				info.setComcount(info.getComcount()+1);
				
				if(StringUtils.isNotEmpty(tribute)){
					int val=0;
					String[]values=tribute.split(",");
					for (String string : values) {
						if(StringUtils.isNotEmpty(string)){
							DBObject  db=baseDao.getMessage(PubConstants.MEMORIAL_TRIBUTE, Long.parseLong(string));
							if(db!=null&&db.get("value")!=null){
								val+=Integer.parseInt(db.get("value").toString());
								MemorialTribute memorialTribute=(MemorialTribute) UniObject.DBObjectToObject(db, MemorialTribute.class); 
								if(memorialTribute.getNum()-1>0){
									memorialTribute.setGmnum(memorialTribute.getGmnum()+1);
									memorialTribute.setNum(memorialTribute.getNum()-1);
								} 
								baseDao.insert(PubConstants.MEMORIAL_TRIBUTE, memorialTribute);
							}
							
							
						}
					}
					info.setFamilyValues(info.getFamilyValues()+val);
					
				}
				baseDao.insert(PubConstants.MEMORIAL_INFO, info);
			}
			sub_map.put("state",0);
			sub_map.put("value",comment.get_id());
		}
		
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 添加评论
	 * @return
	 */
	public  String   commentadd(){
		getLscode();
		Struts2Utils.getRequest().setAttribute("id",Struts2Utils.getParameter("id"));
		Struts2Utils.getRequest().setAttribute("custid",custid);
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		whereMap.put("custid",custid);
		sortMap.put("sort", -1);
		Struts2Utils.getRequest().setAttribute("typelist",baseDao.getList(PubConstants.MEMORIAL_TRIBUTETYPE, whereMap, sortMap));
		return "commentadd"; 	
	}
	/**
	 * 添加祈福
	 * @return
	 */
	public  String   commentsave(){
		getLscode();
		Struts2Utils.getRequest().setAttribute("id",Struts2Utils.getParameter("id"));
		Struts2Utils.getRequest().setAttribute("cid",Struts2Utils.getParameter("cid"));
		Struts2Utils.getRequest().setAttribute("custid",custid); 
		return "commentsave"; 	
	}
	/**
	 * ajax添加祭奠活动
	 */
	public void  ajaxwebadd(){
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		String title=Struts2Utils.getParameter("title");
		String picurl=Struts2Utils.getParameter("picurl");
		String summary=Struts2Utils.getParameter("summary");
		String content=Struts2Utils.getParameter("content");
		String name=Struts2Utils.getParameter("name"); 
		String id=Struts2Utils.getParameter("id");
		MemorialInfo  obj=null;
		if(StringUtils.isNotEmpty(id)){
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			whereMap.put("fromUserid", fromUserid);
			whereMap.put("_id",Long.parseLong(id));
			DBObject db=baseDao.getMessage(PubConstants.MEMORIAL_INFO, whereMap);
			if(db!=null){
				obj=(MemorialInfo) UniObject.DBObjectToObject(db, MemorialInfo.class);
			}
			
		}else{
			obj=new MemorialInfo();
			Long cid=mongoSequence.currval(PubConstants.MEMORIAL_INFO);
			obj.set_id(cid);
			String[]lsname=name.split(","); 
			for (String string : lsname) {
				if(StringUtils.isNotEmpty(string)){
					HashMap<String, Object>whereMap=new HashMap<String, Object>();
					whereMap.put("wid", cid);
					Long count=baseDao.getCount(PubConstants.MEMORIAL_DEAD, whereMap);
					MemorialDead dead=new MemorialDead();
					dead.set_id(mongoSequence.currval(PubConstants.MEMORIAL_DEAD));
					dead.setName(string);
					dead.setWid(cid);
					dead.setCustid(custid);
					dead.setFromUserid(fromUserid);
					dead.setCreatedate(new Date());
					dead.setSort(Integer.parseInt(count+1+""));
					baseDao.insert(PubConstants.MEMORIAL_DEAD, dead);
				}
				
			}
			
		}
		obj.setCustid(custid);
		obj.setFromUserid(fromUserid);
		obj.setCreatedate(new Date());
		obj.setPicurl(picurl);
		obj.setSummary(summary);
		obj.setContent(content);
		obj.setTitle(title); 
		baseDao.insert(PubConstants.MEMORIAL_INFO, obj);
		sub_map.put("state", 0);
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	public String  webadd(){
		getLscode();
		Struts2Utils.getRequest().setAttribute("custid",custid);
		return "webadd"; 	
	}
	/**
	 * ajax获取关注列表
	 */
	public  void  ajaxfocusweb(){
		getLscode();
		String  id=Struts2Utils.getParameter("id");
		Map<String, Object> sub_map = new HashMap<String, Object>();
		if(StringUtils.isNotEmpty(id)){
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			whereMap.put("wid",Long.parseLong(id));
			whereMap.put("custid",custid);
			sortMap.put("createdate", -1);
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			List<DBObject>list=baseDao.getList(PubConstants.MEMORIAL_FOCUSON, whereMap,fypage,10,sortMap);
			if(list.size()>0){
				sub_map.put("state", 0);
				sub_map.put("list",list);
			}
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * ajax关注（取消关注）
	 */
	public  void   ajaxfocusupd(){
		getLscode();
		String id=Struts2Utils.getParameter("id");
		Map<String, Object> sub_map = new HashMap<String, Object>();
		if(StringUtils.isNotEmpty(id)){ 
			
			DBObject db=baseDao.getMessage(PubConstants.MEMORIAL_FOCUSON,id+"-"+fromUserid);
			if(db!=null){
				baseDao.delete(PubConstants.MEMORIAL_FOCUSON,id+"-"+fromUserid);
				DBObject  me=baseDao.getMessage(PubConstants.MEMORIAL_INFO, Long.parseLong(id));
				if(me!=null){
					MemorialInfo info=(MemorialInfo) UniObject.DBObjectToObject(me, MemorialInfo.class);
					info.setFocuscount(info.getFocuscount()-1);
					baseDao.insert(PubConstants.MEMORIAL_INFO, info);
				}
				sub_map.put("state", 1);
			}else{
				MemorialFocuson  focuson=new MemorialFocuson();
				focuson.set_id(id+"-"+fromUserid);
				focuson.setCreatedate(new Date());
				focuson.setCustid(custid);
				focuson.setFromUserid(fromUserid);
				focuson.setWid(Long.parseLong(id));
				DBObject  user=wwzService.getWxUser(fromUserid);
				focuson.setHeadimgurl(user.get("headimgurl").toString());
				focuson.setNickname(user.get("nickname").toString());
				baseDao.insert(PubConstants.MEMORIAL_FOCUSON, focuson);
				DBObject  me=baseDao.getMessage(PubConstants.MEMORIAL_INFO, Long.parseLong(id));
				if(me!=null){
					MemorialInfo info=(MemorialInfo) UniObject.DBObjectToObject(me, MemorialInfo.class);
					info.setFocuscount(info.getFocuscount()+1);
					baseDao.insert(PubConstants.MEMORIAL_INFO, info);
				}
				sub_map.put("state", 0);
			}
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * ajax获取亲友圈列表
	 */
	public  void  ajaxcircleweb(){
		getLscode();
		String id=Struts2Utils.getParameter("id");
		Map<String, Object> sub_map = new HashMap<String, Object>();
		if(StringUtils.isNotEmpty(id)){
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			whereMap.put("wid",Long.parseLong(id));
			whereMap.put("state", 2);
			sortMap.put("createdate", -1);
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			List<DBObject>list=baseDao.getList(PubConstants.MEMORIAL_CIRCLE, whereMap,fypage,10,sortMap);
			if(list.size()>0){
				sub_map.put("state", 0);
				sub_map.put("list", list);
			}
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * ajax获取亲友圈列表
	 */
	public  void  ajaxcirclefalseweb(){
		getLscode();
		String id=Struts2Utils.getParameter("id");
		Map<String, Object> sub_map = new HashMap<String, Object>();
		if(StringUtils.isNotEmpty(id)){
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			whereMap.put("wid",Long.parseLong(id));
			whereMap.put("state", 1);
			sortMap.put("createdate", -1);
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			List<DBObject>list=baseDao.getList(PubConstants.MEMORIAL_CIRCLE, whereMap,fypage,10,sortMap);
			if(list.size()>0){
				sub_map.put("state", 0);
				sub_map.put("list", list);
			}
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 亲友圈列表
	 * @return
	 */
	public String circleweb(){
		getLscode();
		Struts2Utils.getRequest().setAttribute("custid",custid);
		String id=Struts2Utils.getParameter("id");
		Struts2Utils.getRequest().setAttribute("id",id);
		DBObject  db=baseDao.getMessage(PubConstants.MEMORIAL_INFO, Long.parseLong(id));
		if(db!=null){ 
			if(fromUserid.equals(db.get("fromUserid").toString())){
				Struts2Utils.getRequest().setAttribute("isadmin","ok"); 
			}
		}
		return "circleweb"; 	
	}
	/**
	 * 亲友圈申请
	 */
	public void  ajaxcircleadd(){
		getLscode();
		String id=Struts2Utils.getParameter("id");
		String text=Struts2Utils.getParameter("text");
		String content=Struts2Utils.getParameter("content");
		Map<String, Object> sub_map = new HashMap<String, Object>();
		if(StringUtils.isNotEmpty(id)){
			//检测是否已经是亲友
			DBObject db=baseDao.getMessage(PubConstants.MEMORIAL_CIRCLE, id+"-"+fromUserid);
			if(db!=null){
				sub_map.put("state", 1);
			}else{
				MemorialCircle circle=new MemorialCircle();
				circle.set_id(id+"-"+fromUserid);
				circle.setCreatedate(new Date());
				circle.setContent(content);
				circle.setCustid(custid);
				circle.setRelashipbetween(text);
				circle.setWid(Long.parseLong(id));
				circle.setState(1);
				DBObject  user=wwzService.getWxUser(fromUserid);
				circle.setHeadimgurl(user.get("headimgurl").toString());
				circle.setNickname(user.get("nickname").toString());
				baseDao.insert(PubConstants.MEMORIAL_CIRCLE, circle);
				sub_map.put("state", 0);
			}
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 审核亲友
	 */
	public  void  ajaxcircleset(){
		getLscode();
		String id=Struts2Utils.getParameter("id");
		String state=Struts2Utils.getParameter("state");
		Map<String, Object> sub_map = new HashMap<String, Object>();
		if(StringUtils.isNotEmpty(id)){
			DBObject  db=baseDao.getMessage(PubConstants.MEMORIAL_CIRCLE, id);
			if(db!=null){
				MemorialCircle circle=(MemorialCircle) UniObject.DBObjectToObject(db, MemorialCircle.class);
				circle.setState(Integer.parseInt(state));
				baseDao.insert(PubConstants.MEMORIAL_CIRCLE, circle);
				
				DBObject  me=baseDao.getMessage(PubConstants.MEMORIAL_INFO, circle.getWid());
				if(me!=null){
					HashMap<String, Object>whereMap=new HashMap<String, Object>();
					whereMap.put("wid", Long.parseLong(me.get("_id").toString()));
					whereMap.put("state", 2);
					MemorialInfo info=(MemorialInfo) UniObject.DBObjectToObject(me, MemorialInfo.class);
					info.setRelativescount(Integer.parseInt(""+baseDao.getCount(PubConstants.MEMORIAL_CIRCLE, whereMap)));
					baseDao.insert(PubConstants.MEMORIAL_INFO, info);
				}
			}
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * ajax献上贡品
	 */
	public  void  ajaxtributeadd(){
		getLscode();
		String tid=Struts2Utils.getParameter("tid");
		String wid=Struts2Utils.getParameter("wid");
		String content=Struts2Utils.getParameter("content");
		Map<String, Object> sub_map = new HashMap<String, Object>();
		if(StringUtils.isNotEmpty(wid)&&StringUtils.isNotEmpty(tid)){
		   	MemorialTributeCom  tributeCom=new  MemorialTributeCom();
		   	tributeCom.set_id(mongoSequence.currval(PubConstants.MEMORIAL_TRIBUTECOM));
		   	tributeCom.setContent(content);
		   	tributeCom.setCreatedate(new Date());
		   	tributeCom.setFromUserid(fromUserid);
		   	tributeCom.setCustid(custid);
		   	tributeCom.setWid(Long.parseLong(wid));
		   	tributeCom.setTid(Long.parseLong(tid));
		   	DBObject  user=wwzService.getWxUser(fromUserid);
		   	tributeCom.setHeadimgurl(user.get("headimgurl").toString());
		   	tributeCom.setNickname(user.get("nickname").toString());
		   	baseDao.insert(PubConstants.MEMORIAL_TRIBUTECOM, tributeCom);
		   	sub_map.put("state", 0);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * ajax获取贡品列表
	 */
	public void  ajaxtribute(){
		getLscode();
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		String type=Struts2Utils.getParameter("type");
		if(StringUtils.isNotEmpty(type)){
			whereMap.put("type", Long.parseLong(type));
		}
		String sel=Struts2Utils.getParameter("sel");
		if(!StringUtils.isEmpty(sel)){
			Pattern pattern = Pattern.compile("^.*" + sel + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern);
		}
		whereMap.put("custid", custid);
		sortMap.put("sort", -1);
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject>list=baseDao.getList(PubConstants.MEMORIAL_TRIBUTE, whereMap,fypage,10, sortMap);
		if(list.size()>0){
			sub_map.put("state", 0); 
			sub_map.put("list",list);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * ajax获取个人祭奠列表
	 */
	public void  ajaxmymemor(){
		getLscode();
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		whereMap.put("fromUserid", fromUserid);
		whereMap.put("custid", custid);
		sortMap.put("createdate", -1);
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject>list=baseDao.getList(PubConstants.MEMORIAL_INFO, whereMap,fypage,10, sortMap);
		if(list.size()>0){
			sub_map.put("state", 0);
			for (DBObject dbObject : list) {
			      whereMap.clear();
			      sortMap.clear();
			      whereMap.put("wid", Long.parseLong(dbObject.get("_id").toString()));
			      sortMap.put("sort",-1);
			      List<DBObject> lsdead=baseDao.getList(PubConstants.MEMORIAL_DEAD, whereMap, sortMap);
			      if(lsdead.size()>0){
			    	  dbObject.put("lsdead",lsdead); 
			      }
			}
			sub_map.put("list",list);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * ajax获取个人祭奠关注列表
	 */
	public void  ajaxmymemorfocus(){
		getLscode();
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		whereMap.put("fromUserid", fromUserid);
		whereMap.put("custid", custid);
		sortMap.put("createdate", -1);
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject>list=baseDao.getList(PubConstants.MEMORIAL_FOCUSON, whereMap,fypage,10, sortMap);
		if(list.size()>0){
			sub_map.put("state", 0);
			for (DBObject dbObject : list) {
				DBObject  me=baseDao.getMessage(PubConstants.MEMORIAL_INFO, Long.parseLong(dbObject.get("wid").toString()));
				if(me!=null){
					whereMap.clear();
				    sortMap.clear();
				    whereMap.put("wid", Long.parseLong(me.get("_id").toString()));
				    sortMap.put("sort",-1);
				    List<DBObject> lsdead=baseDao.getList(PubConstants.MEMORIAL_DEAD, whereMap, sortMap);
				    if(lsdead.size()>0){
				    	  me.put("lsdead",lsdead); 
				     }
					dbObject.put("me", me);
					
				}
			}
			sub_map.put("list",list);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * ajax获取逝者
	 */
	public  void  ajaxdead(){
		getLscode();
		String id=Struts2Utils.getParameter("id");
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		whereMap.put("custid", custid);
		whereMap.put("wid", Long.parseLong(id));
		sortMap.put("sort", -1);
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject>list=baseDao.getList(PubConstants.MEMORIAL_DEAD, whereMap,fypage,10, sortMap);
		if(list.size()>0){
			sub_map.put("state", 0);
			sub_map.put("list",list);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 修改逝者信息
	 * @return
	 */
	public String deadupd(){
		getLscode();
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		whereMap.put("wid", _id);
		sortMap.put("sort",1);
		List<DBObject>list=baseDao.getList(PubConstants.MEMORIAL_DEAD, whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("id", _id);
		Struts2Utils.getRequest().setAttribute("list", list);
		Struts2Utils.getRequest().setAttribute("custid", custid);
 
		return "deadupd"; 
	}
	/**
	 * ajax修改逝者信息
	 */
	public  void  ajaxdeadupd(){
		getLscode();
		String id=Struts2Utils.getParameter("id");
		Map<String, Object> sub_map = new HashMap<String, Object>();
		if(StringUtils.isNotEmpty(id)){
			String name1=Struts2Utils.getParameter("name1");
			String picurl1=Struts2Utils.getParameter("picurl1");
			String nativePlace1=Struts2Utils.getParameter("nativePlace1");
			String professional1=Struts2Utils.getParameter("professional1");
			String relashipbetween1=Struts2Utils.getParameter("relashipbetween1");
			String birthAddress1=Struts2Utils.getParameter("birthAddress1");
			String burialAddress1=Struts2Utils.getParameter("burialAddress1");
			String summary1=Struts2Utils.getParameter("summary1");
			String birthdate1=Struts2Utils.getParameter("birthdate1");
			String burialdate1=Struts2Utils.getParameter("burialdate1");
			
			String name2=Struts2Utils.getParameter("name2");
			String picurl2=Struts2Utils.getParameter("picurl2");
			String nativePlace2=Struts2Utils.getParameter("nativePlace2");
			String professional2=Struts2Utils.getParameter("professional2");
			String relashipbetween2=Struts2Utils.getParameter("relashipbetween2");
			String birthAddress2=Struts2Utils.getParameter("birthAddress2");
			String burialAddress2=Struts2Utils.getParameter("burialAddress2");
			String summary2=Struts2Utils.getParameter("summary2");
			String birthdate2=Struts2Utils.getParameter("birthdate2");
			String burialdate2=Struts2Utils.getParameter("burialdate2");
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			whereMap.put("wid",Long.parseLong(id));
			sortMap.put("sort",1);
			List<DBObject>list=baseDao.getList(PubConstants.MEMORIAL_DEAD, whereMap, sortMap);
			if(list.size()==1){
				MemorialDead  dead=(MemorialDead) UniObject.DBObjectToObject(list.get(0), MemorialDead.class);
				dead.setBirthAddress(birthAddress1);
				dead.setFromUserid(fromUserid);
				dead.setBirthdate(birthdate1);
				dead.setBurialAddress(burialAddress1);
				dead.setCreatedate(new Date());
				dead.setName(name1);
				dead.setNativePlace(nativePlace1);
				dead.setPicurl(picurl1);
				dead.setProfessional(professional1);
				dead.setRelashipbetween(relashipbetween1);
				dead.setSummary(summary1);
				dead.setBurialdate(burialdate1);
				baseDao.insert(PubConstants.MEMORIAL_DEAD, dead);
				sub_map.put("state", 0);
				
			}else if(list.size()==2){
				MemorialDead  dead=(MemorialDead) UniObject.DBObjectToObject(list.get(0), MemorialDead.class);
				dead.setBirthAddress(birthAddress1);
				dead.setFromUserid(fromUserid);
				dead.setBirthdate(birthdate1);
				dead.setBurialAddress(burialAddress1);
				dead.setCreatedate(new Date());
				dead.setName(name1);
				dead.setNativePlace(nativePlace1);
				dead.setPicurl(picurl1);
				dead.setProfessional(professional1);
				dead.setRelashipbetween(relashipbetween1);
				dead.setSummary(summary1);
				dead.setBurialdate(burialdate1);
				baseDao.insert(PubConstants.MEMORIAL_DEAD, dead);
				dead=(MemorialDead) UniObject.DBObjectToObject(list.get(1), MemorialDead.class);
				dead.setBirthAddress(birthAddress2);
				dead.setFromUserid(fromUserid);
				dead.setBirthdate(birthdate2);
				dead.setBurialAddress(burialAddress2);
				dead.setCreatedate(new Date());
				dead.setName(name2);
				dead.setNativePlace(nativePlace2);
				dead.setPicurl(picurl2);
				dead.setProfessional(professional2);
				dead.setRelashipbetween(relashipbetween2);
				dead.setSummary(summary2);
				dead.setBurialdate(burialdate2);
				baseDao.insert(PubConstants.MEMORIAL_DEAD, dead);
				sub_map.put("state", 0);
			}
			 
			
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 添加悼文
	 * @return
	 */
	public String eulogyadd(){
		getLscode();
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		whereMap.put("wid", _id);
		sortMap.put("sort",-1);
		List<DBObject>list=baseDao.getList(PubConstants.MEMORIAL_DEAD, whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("list", list);
		Struts2Utils.getRequest().setAttribute("id", _id);
		Struts2Utils.getRequest().setAttribute("custid", custid);
 
		return "eulogyadd"; 
	}
	/**
	 * 悼文详情
	 * @return
	 */
	public String eulogydetail(){
		getLscode();  
		Struts2Utils.getRequest().setAttribute("custid", custid);
		String id=Struts2Utils.getParameter("id");
		WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/suc/memorial!eulogydetail.action?custid="+custid+"&id="+id;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		} 
		DBObject  db=baseDao.getMessage(PubConstants.MEMORIAL_EULOGY, Long.parseLong(id));
		Struts2Utils.getRequest().setAttribute("entity",db); 
		return "eulogydetail"; 
	}
	/**
	 * ajax添加悼文
	 */
	public void  ajaxeulogyadd(){
		getLscode();
		String id=Struts2Utils.getParameter("id");
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		if(StringUtils.isNotEmpty(id)){
			String title=Struts2Utils.getParameter("title");
			String content=Struts2Utils.getParameter("content");
			MemorialEulogy eulogy=new MemorialEulogy();
			eulogy.set_id(mongoSequence.currval(PubConstants.MEMORIAL_EULOGY));
			eulogy.setContent(content);
			eulogy.setCreatedate(new Date());
			eulogy.setTitle(title);
			eulogy.setCustid(custid);
			eulogy.setFromUserid(fromUserid);
			eulogy.setWid(Long.parseLong(id));
			DBObject  user=wwzService.getWxUser(fromUserid);
			eulogy.setHeadimgurl(user.get("headimgurl").toString());
			eulogy.setNickname(user.get("nickname").toString());
			baseDao.insert(PubConstants.MEMORIAL_EULOGY, eulogy);
			sub_map.put("state", 0);
					
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * ajax悼文列表
	 */
	public void  ajaxeulogyweb(){
		getLscode();
		String id=Struts2Utils.getParameter("id");
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		whereMap.put("custid", custid);
		whereMap.put("wid", Long.parseLong(id));
		sortMap.put("sort", -1);
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject>list=baseDao.getList(PubConstants.MEMORIAL_EULOGY, whereMap,fypage,10, sortMap);
		if(list.size()>0){
			sub_map.put("state", 0);
			sub_map.put("list",list);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * ajax获取与个人相关的祭奠
	 */
	public  void  ajaxrelated(){
		getLscode(); 
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		whereMap.put("fromUserid", fromUserid); 
		sortMap.put("createdate", -1);
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject>list=baseDao.getList(PubConstants.MEMORIAL_RELATED, whereMap,fypage,10, sortMap);
		if(list.size()>0){
			sub_map.put("state", 0);
			for (DBObject dbObject : list) {
				DBObject  me=baseDao.getMessage(PubConstants.MEMORIAL_INFO, Long.parseLong(dbObject.get("wid").toString()));
				if(me!=null){
					whereMap.clear();
				    sortMap.clear();
				    whereMap.put("wid", Long.parseLong(me.get("_id").toString()));
				    sortMap.put("sort",-1);
				    List<DBObject> lsdead=baseDao.getList(PubConstants.MEMORIAL_DEAD, whereMap, sortMap);
				    if(lsdead.size()>0){
				    	  me.put("lsdead",lsdead); 
				     }
					dbObject.put("me", me);
					
				}
			}
			sub_map.put("list",list);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 祈福点赞
	 */
	public  void    praisecom(){
		getLscode();
		String id=Struts2Utils.getParameter("id");
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		if(StringUtils.isNotEmpty(id)){
			DBObject db=baseDao.getMessage(PubConstants.MEMORIAL_COMMENT, Long.parseLong(id));
			if(db!=null){
				//检测是否已赞
				
				DBObject  zan=baseDao.getMessage(PubConstants.MEMORIAL_COMMENTPRAISE, id+"-"+fromUserid);
				if(zan!=null){
					//取消赞
					baseDao.delete(PubConstants.MEMORIAL_COMMENTPRAISE, id+"-"+fromUserid);
					MemorialComment me=(MemorialComment) UniObject.DBObjectToObject(db, MemorialComment.class);
					me.setSort(me.getSort()-1);
					baseDao.insert(PubConstants.MEMORIAL_COMMENT, me);
					sub_map.put("state",1);
					sub_map.put("value",me.getSort());
				}else{
					//记录赞
					MemorialCommentPraise p=new MemorialCommentPraise();
					p.set_id(id+"-"+fromUserid);
					p.setCreatedate(new Date());
					p.setCustid(custid);
					p.setFromUserid(fromUserid);
					p.setWid(Long.parseLong(id));
					DBObject user=wwzService.getWxUser(fromUserid);
					p.setHeadimgurl(user.get("headimgurl").toString());
					p.setNickname(user.get("nickname").toString());
					baseDao.insert(PubConstants.MEMORIAL_COMMENTPRAISE, p);
					MemorialComment me=(MemorialComment) UniObject.DBObjectToObject(db, MemorialComment.class);
					me.setSort(me.getSort()+1);
					baseDao.insert(PubConstants.MEMORIAL_COMMENT, me);
					sub_map.put("state",0);
					sub_map.put("value",me.getSort());
				}
				
				
			}
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 阅读悼文
	 */
    public  void    readingeulogy(){
    	getLscode();
    	String id=Struts2Utils.getParameter("id");
    	Map<String, Object> sub_map = new HashMap<String, Object>(); 
		if(StringUtils.isNotEmpty(id)){
			DBObject db=baseDao.getMessage(PubConstants.MEMORIAL_EULOGY, Long.parseLong(id));
			if(db!=null){
				   //记录阅读
					MemorialEulogyReading p=new MemorialEulogyReading();
					p.set_id(mongoSequence.currval(PubConstants.MEMORIAL_EULOGYREADING));
					p.setCreatedate(new Date());
					p.setCustid(custid);
					p.setFromUserid(fromUserid);
					p.setWid(Long.parseLong(id));
					DBObject user=wwzService.getWxUser(fromUserid);
					p.setHeadimgurl(user.get("headimgurl").toString());
					p.setNickname(user.get("nickname").toString());
					baseDao.insert(PubConstants.MEMORIAL_EULOGYREADING, p);
					MemorialEulogy me=(MemorialEulogy) UniObject.DBObjectToObject(db, MemorialEulogy.class);
					me.setSort(me.getSort()+1);
					baseDao.insert(PubConstants.MEMORIAL_EULOGY, me);
					sub_map.put("state",0);
					sub_map.put("value",me.getSort());
				}
				
				
			}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		}
     public  void  deleteAll(){
    	 custid=SpringSecurityUtils.getCurrentUser().getId();
    	 baseDao.delete(PubConstants.MEMORIAL_CIRCLE);
    	 baseDao.delete(PubConstants.MEMORIAL_COMMENT);
    	 baseDao.delete(PubConstants.MEMORIAL_COMMENTPRAISE);
    	 baseDao.delete(PubConstants.MEMORIAL_DEAD);
    	 baseDao.delete(PubConstants.MEMORIAL_EULOGY);
    	 baseDao.delete(PubConstants.MEMORIAL_EULOGYREADING);
    	 baseDao.delete(PubConstants.MEMORIAL_FOCUSON);
    	 baseDao.delete(PubConstants.MEMORIAL_INFO); 
    	 baseDao.delete(PubConstants.MEMORIAL_RELATED);
     }
	 
	
}


