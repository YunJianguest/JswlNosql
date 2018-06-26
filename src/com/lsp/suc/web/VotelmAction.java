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
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.RelativeDate;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.web.GeneralAction;
import com.lsp.suc.entity.Ranking;
import com.lsp.suc.entity.Tourism;
import com.lsp.suc.entity.VoteInfo;
import com.lsp.suc.entity.Votelm;
import com.lsp.website.service.WebsiteService;
import com.lsp.website.service.WwzService;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;

/**
 * 投票管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name ="reload", location = "votelm.action",params={"fypage", "%{fypage}"}, type = "redirect") })
public class VotelmAction extends GeneralAction<Votelm> {

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
	
	private Votelm entity=new Votelm();
	private Long _id;  
	public void set_id(Long _id) {
		this._id = _id;
	}
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
		backMap.put("content", 0); 
		
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		
		List<DBObject> list=baseDao.getList(PubConstants.SUC_VOTELM,whereMap,fypage,10,sortMap,backMap);
		 for (DBObject dbObject : list) {
				dbObject.put("nickname", wwzService.getCustName(dbObject.get("custid").toString()));
			}
		fycount=baseDao.getCount(PubConstants.SUC_VOTELM,whereMap);
		Struts2Utils.getRequest().setAttribute("votelmList", list);
		Struts2Utils.getRequest().setAttribute("custid", custid);
		
		return SUCCESS;
	}
	@Override
	public Votelm getModel() {
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
		Struts2Utils.getRequest().setAttribute("entity", baseDao.getMessage(PubConstants.SUC_VOTELM, _id));
		return "add";
	}

	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		if(_id==null){
			_id=mongoSequence.currval(PubConstants.SUC_VOTELM);
		}
		custid=SpringSecurityUtils.getCurrentUser().getId();
		entity.setCustid(custid);
		entity.set_id(_id);
		entity.setCreatedate(new Date());
		baseDao.insert(PubConstants.SUC_VOTELM, entity);
		return RELOAD;
	}

	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id!=null){
				String custid=SpringSecurityUtils.getCurrentUser().getId();
				HashMap<String, Object> whereMap=new HashMap<String, Object>();
				whereMap.put("_id", _id);
				whereMap.put("custid", custid);
				baseDao.delete(PubConstants.SUC_VOTELM, whereMap);
				//删除评论
				whereMap.clear();
				whereMap.put("wid", _id);
				baseDao.delete(PubConstants.SUC_VOTE,whereMap);
				addActionMessage("删除成功");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			addActionMessage("删除失败");
		}
		return RELOAD;
	}

	@Override
	protected void prepareModel() throws Exception {
		try {
			if(_id!=null){
				DBObject db=baseDao.getMessage(PubConstants.SUC_VOTELM, _id);
				entity= (Votelm) UniObject.DBObjectToObject(db, Votelm.class);
			}else{
				entity=new Votelm();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void  upd(){ 
		DBObject db=baseDao.getMessage(PubConstants.SUC_VOTELM, _id); 
		String json = JSONObject.fromObject(db).toString(); 
		Struts2Utils.renderJson(json, new String[0]);
		
	}
	/**
	 * 投票主页面
	 * @return
	 */
	public String  index(){
		getLscode();
		WxToken token=GetAllFunc.wxtoken.get(custid);
		
		 if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 }
		 Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/votelm!index.action?custid="+custid+"&_id="+_id;  
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
		wwzService.flow(custid, custid+"-vote-"+_id);
		DBObject  db=baseDao.getMessage(PubConstants.SUC_VOTELM, _id);
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		whereMap.put("voteid", _id);
		Long  bmcount=baseDao.getCount(PubConstants.SUC_VOTE,whereMap);
		whereMap.clear();
		whereMap.put("wid", _id);
		Long  tpcount=baseDao.getCount(PubConstants.WHD_WHDCOUNT,whereMap);
		int  llcount=wwzService.getFlow(custid, custid+"-vote-"+_id);
		db.put("bmcount", bmcount);
		db.put("tpcount", tpcount);
		db.put("llcount", llcount);
		Struts2Utils.getRequest().setAttribute("slide",wwzService.slide(custid, "votelm-"+_id));
		Struts2Utils.getRequest().setAttribute("entity", db);
		DBObject share =new BasicDBObject();
		share.put("fxtitle", db.get("title"));
		share.put("fximg", db.get("picurl"));  
		share.put("fxurl",url);
		share.put("fxsummary", db.get("summary"));
		Struts2Utils.getRequest().setAttribute("share", share);
		if(db.get("mb")!=null){
			 
			return "index"+db.get("mb");
 	
		}
		return "index";
		
	}
	/**
	 * 清空榜单
	 * @return
	 */
	public String delranking(){
		custid=SpringSecurityUtils.getCurrentUser().getId();
		String voteid=Struts2Utils.getParameter("voteid");
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		whereMap.put("type", "vote-"+voteid);
		baseDao.delete(PubConstants.SUC_RANKING, whereMap);
		return RELOAD;
		
	}
	/**
	 * 投票列表页面
	 */
	public String  list(){
		getLscode();
		Struts2Utils.getRequest().setAttribute("lscode",lscode);
		Struts2Utils.getRequest().setAttribute("custid", custid);
		wwzService.flow(custid, "vote-"+_id);
		DBObject  db=baseDao.getMessage(PubConstants.SUC_VOTELM, _id); 
		Struts2Utils.getRequest().setAttribute("entity", db);
		if(db.get("mb")!=null){
			return "list"+db.get("mb");
		}
		return "list";
		
	} 
	/**
	 * ajax获取投票内容
	 */
	public void   ajaxweb(){

		Map<String, Object> sub_map = new HashMap<String, Object>();
		try {
			String vtid=Struts2Utils.getParameter("vtid");
			String sel=Struts2Utils.getParameter("sel");  
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			if(StringUtils.isNotEmpty(sel)){
				if(StringUtils.isNumeric(sel)){
					whereMap.put("_id", Long.parseLong(sel));
				}else{
					Pattern pattern = Pattern.compile("^.*" + sel + ".*$",
							Pattern.CASE_INSENSITIVE);
					whereMap.put("title", pattern);
				}
				
			}
			whereMap.put("voteid", Long.parseLong(vtid));
			sortMap.put("sort",-1);
			String fypage=Struts2Utils.getParameter("fypage");
			List<DBObject>list=baseDao.getList(PubConstants.SUC_VOTE, whereMap,Integer.parseInt(fypage),12,sortMap);
			if(list.size()>0){ 
				sub_map.put("state", 0);
				sub_map.put("list", list);
			}else{
				sub_map.put("state", 1);
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			sub_map.put("state", 1);
			e.printStackTrace();
		}
		 
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * ajax添加投票内容
	 */
	public void   ajaxadd(){
        getLscode(); 
		Map<String, Object> sub_map = new HashMap<String, Object>();
		try {
			DBObject  wxuer=wwzService.getWxUser(fromUserid);
	        if(wxuer.get("_id").equals("notlogin")){
	        	sub_map.put("state", 3);
	        	return ;
	        }
			String vtid=Struts2Utils.getParameter("vtid");
		    VoteInfo  obj=new VoteInfo();
		    Long _id=mongoSequence.currval(PubConstants.SUC_VOTE);
		    obj.set_id(_id);
		    obj.setContext(Struts2Utils.getParameter("context"));
		    obj.setCreatedate(new Date());
		    obj.setPicurl(Struts2Utils.getParameter("picurl"));
		    obj.setBgurl(Struts2Utils.getParameter("bgurl"));
		    obj.setSort(0);
		    obj.setTitle(Struts2Utils.getParameter("title"));
		    obj.setTel(Struts2Utils.getParameter("tel"));
		    obj.setVoteid(Long.parseLong(vtid));
		    obj.setCustid(custid);
		    obj.setFromUserid(fromUserid);
		    String  varieties=Struts2Utils.getParameter("varieties");
		    String  production=Struts2Utils.getParameter("production");
		    String  region=Struts2Utils.getParameter("region");
		    String  price=Struts2Utils.getParameter("price");
		    if(StringUtils.isNotEmpty(varieties)){
		    	obj.setVarieties(varieties);
		    }
		    if(StringUtils.isNotEmpty(production)){
		    	obj.setProduction(production);
		    }
		    if(StringUtils.isNotEmpty(region)){
		    	obj.setRegion(region);
		    }
		    if(StringUtils.isNotEmpty(price)){
		    	obj.setPrice(price);
		    }
		    baseDao.insert(PubConstants.SUC_VOTE, obj);
		    

			Ranking rank=new Ranking();
			rank.set_id("vote-"+vtid+"-"+_id);  
			rank.setType("vote-"+vtid);
			rank.setValue(0); 
			rank.setRankno(_id);
			rank.setRankname(entity.getTitle());
			baseDao.insert(PubConstants.SUC_RANKING, rank);
		    sub_map.put("state", 0); 
			 
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			sub_map.put("state", 1);
			e.printStackTrace();
		}
		 
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * ajax获取投排行榜
	 */
	public void   ajaxphb(){

		Map<String, Object> sub_map = new HashMap<String, Object>();
		try {
			String vtid=Struts2Utils.getParameter("vtid");
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>(); 
			whereMap.put("voteid", Long.parseLong(vtid));
			sortMap.put("count",-1);
			String fypage=Struts2Utils.getParameter("fypage");
			List<DBObject>list=baseDao.getList(PubConstants.SUC_VOTE, whereMap,Integer.parseInt(fypage),10,sortMap);
			if(list.size()>0){
				sub_map.put("state", 0);
				sub_map.put("list", list);
			}else{
				sub_map.put("state", 1);
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			sub_map.put("state", 1);
			e.printStackTrace();
		}
		 
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * 排行榜
	 * @return
	 */
	public String  ranking(){
		getLscode();
		Struts2Utils.getRequest().setAttribute("custid",custid);
		Struts2Utils.getRequest().setAttribute("fromUserid", fromUserid); 
		DBObject  db=baseDao.getMessage(PubConstants.SUC_VOTELM, _id);
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		whereMap.put("voteid", _id);
		Long  bmcount=baseDao.getCount(PubConstants.SUC_VOTE,whereMap);
		whereMap.clear();
		whereMap.put("wid", _id);
		Long  tpcount=baseDao.getCount(PubConstants.WHD_WHDCOUNT,whereMap);
		int  llcount=wwzService.getFlow(custid, custid+"-vote-"+_id);
		db.put("bmcount", bmcount);
		db.put("tpcount", tpcount);
		db.put("llcount", llcount);
		
		Struts2Utils.getRequest().setAttribute("entity", db);
		Struts2Utils.getRequest().setAttribute("slide",wwzService.slide(custid, "votelm-"+_id));
		if(db.get("mb")!=null){
			 
			return "ranking"+db.get("mb");
 	
		} 
		return "ranking"; 	
	}
	/**
	 * ajax获取排行榜
	 */
	public void   ajaxranking(){

		Map<String, Object> sub_map = new HashMap<String, Object>();
		try {
			String vtid=Struts2Utils.getParameter("vtid");
			String sel=Struts2Utils.getParameter("sel"); 
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			if(StringUtils.isNotEmpty(sel)){
				Pattern pattern = Pattern.compile("^.*" + sel + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("rankname", pattern);
			}
			whereMap.put("type", "vote-"+vtid);
			sortMap.put("value",-1);
			String fypage=Struts2Utils.getParameter("fypage");
			List<DBObject>list=baseDao.getList(PubConstants.SUC_RANKING, whereMap,Integer.parseInt(fypage),12,sortMap);
			if(list.size()>0){ 
				sub_map.put("state", 0);
				sub_map.put("list", list);
			}else{
				sub_map.put("state", 1);
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			sub_map.put("state", 1);
			e.printStackTrace();
		}
		 
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * 移动端添加
	 * @return
	 */
	public String  moveadd(){
		getLscode();
		Struts2Utils.getRequest().setAttribute("custid",custid);  
		wwzService.flow(custid, custid+"-vote-"+_id);
		DBObject  db=baseDao.getMessage(PubConstants.SUC_VOTELM, _id);
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		whereMap.put("voteid", _id);
		Long  bmcount=baseDao.getCount(PubConstants.SUC_VOTE,whereMap);
		whereMap.clear();
		whereMap.put("wid", _id);
		Long  tpcount=baseDao.getCount(PubConstants.WHD_WHDCOUNT,whereMap);
		int  llcount=wwzService.getFlow(custid, custid+"-vote-"+_id);
		db.put("bmcount", bmcount);
		db.put("tpcount", tpcount);
		db.put("llcount", llcount);
		Struts2Utils.getRequest().setAttribute("entity", db);
		
		if(db.get("mb")!=null){
			 
			return "moveadd"+db.get("mb");
 	
		}
		
		return "moveadd"; 	
	}
	/**
	 * 更新榜单(每天12点)
	 */
	public  void   updranking(){
		String  vtid=Struts2Utils.getParameter("vtid");
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		whereMap.put("type", "vote-"+vtid);
		sortMap.put("value", -1);
		List<DBObject>db=baseDao.getList(PubConstants.SUC_RANKING, whereMap, sortMap);
		for (int i = 0; i < db.size(); i++) {
			Ranking  rank=(Ranking) UniObject.DBObjectToObject(db.get(i),Ranking.class);
			rank.setRank(i);
			baseDao.insert(PubConstants.SUC_RANKING, rank);
		}
	}
	/**
	 * 投票栏目列表
	 * @return
	 */
	public String web(){
		getLscode();
		Struts2Utils.getRequest().setAttribute("custid", custid);
		return "web";
		
	}
	/**
	 * ajax投票栏目列表
	 * @return
	 */
	public void ajaxlist(){
		getLscode();
		String  fypage=Struts2Utils.getParameter("fypage"); 
		Map<String, Object> sub_map = new HashMap<String, Object>();
		try {
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			whereMap.put("custid", custid);
			sortMap.put("sort", -1);
			List<DBObject>list=baseDao.getList(PubConstants.SUC_VOTELM, whereMap,Integer.parseInt(fypage),10,sortMap);
			if(list.size()>0){
				sub_map.put("state", 0);
				sub_map.put("list", list);
			}else{
				sub_map.put("state", 1);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			sub_map.put("state", 1);
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * 个人投票
	 * @return
	 */
	public String  personalhome(){
		getLscode();
		DBObject  db=baseDao.getMessage(PubConstants.SUC_VOTELM, _id);
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		whereMap.put("voteid", _id);
		Long  bmcount=baseDao.getCount(PubConstants.SUC_VOTE,whereMap);
		whereMap.clear();
		whereMap.put("wid", _id);
		Long  tpcount=baseDao.getCount(PubConstants.WHD_WHDCOUNT,whereMap);
		int  llcount=wwzService.getFlow(custid, custid+"-vote-"+_id);
		db.put("bmcount", bmcount);
		db.put("tpcount", tpcount);
		db.put("llcount", llcount);
		Struts2Utils.getRequest().setAttribute("slide",wwzService.slide(custid, "votelm-"+_id));
		Struts2Utils.getRequest().setAttribute("entity", db);
		
		Struts2Utils.getRequest().setAttribute("custid",custid); 
		if(db.get("mb")!=null){
			 
			return "personalhome"+db.get("mb");
 	
		} 
		return "personalhome";
		
	}
	/**
	 * ajax获取投票内容
	 */
	public void   ajaxpersonalhome(){
        getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		try {
			String vtid=Struts2Utils.getParameter("vtid");
			String sel=Struts2Utils.getParameter("sel"); 
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			if(StringUtils.isNotEmpty(sel)){
				 
				whereMap.put("_id", Long.parseLong(sel));
			} 
			whereMap.put("fromUserid", fromUserid);
			whereMap.put("custid", custid);
			whereMap.put("voteid", Long.parseLong(vtid));
			sortMap.put("createdate",-1);
			String fypage=Struts2Utils.getParameter("fypage");
			List<DBObject>list=baseDao.getList(PubConstants.SUC_VOTE, whereMap,Integer.parseInt(fypage),12,sortMap);
			if(list.size()>0){ 
				sub_map.put("state", 0);
				sub_map.put("list", list);
			}else{
				sub_map.put("state", 1);
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			sub_map.put("state", 1);
			e.printStackTrace();
		}
		 
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * 投票详情
	 * @return
	 */
	public   String    help(){
		getLscode();
		Struts2Utils.getRequest().setAttribute("custid",custid);
		Struts2Utils.getRequest().setAttribute("voteid", Struts2Utils.getParameter("voteid"));
		DBObject  db=baseDao.getMessage(PubConstants.SUC_VOTELM, _id);
	    Struts2Utils.getRequest().setAttribute("entity", db); 
		if(db.get("mb")!=null){ 
			return "help"+db.get("mb"); 
		}
		return "help"; 	
	}
	/**
	 * ajax获取投票详情
	 */
	public  void    ajaxhelp(){
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		String voteid=Struts2Utils.getParameter("voteid"); 
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		whereMap.put("tpid", Long.parseLong(voteid));
		whereMap.put("lx",4);
		sortMap.put("createdate", -1);
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		} 
		List<DBObject> list=baseDao.getList(PubConstants.WHD_WHDCOUNT, whereMap,fypage,10,sortMap);
		if(list.size()>0){
			for (DBObject dbObject : list) {
				DBObject  user=wwzService.getWxUser(dbObject.get("fromUserid").toString());
				dbObject.put("headimgurl", user.get("headimgurl"));
				dbObject.put("nickname",user.get("nickname"));
				if(dbObject.get("createdate")!=null){
					dbObject.put("createdate", RelativeDate.format(DateFormat.getFormat(dbObject.get("createdate").toString()), new Date()));
				}
			}
			
			sub_map.put("state",0);
			sub_map.put("list", list);
		} 
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		 	
	}
	 
}
