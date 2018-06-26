package com.lsp.suc.web;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.DateUtil;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.web.GeneralAction;
import com.lsp.suc.entity.Luckydraw;
import com.lsp.website.service.WwzService;
import com.mongodb.DBObject;

/**
* 活动总管理
* @author lsp
*
*/
@Namespace("/suc")
@Results( { @Result(name = LuckydrawAction.RELOAD, location = "totalactivity.action", type = "redirect") })
public class TotalactivityAction extends GeneralAction<Luckydraw>{

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
	
	@Override
	public Luckydraw getModel() {
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
		return null;
	}

	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * 总活动页面
	 * @return
	 */
	public String  web(){ 
		getLscode();
		WxToken token=GetAllFunc.wxtoken.get(custid);
		String type=Struts2Utils.getParameter("type");
		 if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 }
		 Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/totalactivity!web.action?custid="+custid+"&type="+type;  
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
		Struts2Utils.getRequest().setAttribute("token", token); 
		Struts2Utils.getRequest().setAttribute("custid",custid); 
		Struts2Utils.getRequest().setAttribute("type",type); 
		//加载广告位
		Struts2Utils.getRequest().setAttribute("slide", wwzService.getslide(custid, "activity"));
		DBObject share=wwzService.getShareFx(custid,"activity_share"); 
		Struts2Utils.getRequest().setAttribute("share", share); 
		return "web";
	}
	/**
	 * 我的活动
	 */
	public String  personalhome(){
		getLscode();
		Struts2Utils.getRequest().setAttribute("custid",custid);
		Struts2Utils.getRequest().setAttribute("lscode",lscode); 
		return "personalhome";
		
	}
	/**
	 * 获取摇奖活动总页面
	 */
	public void   ajaxlucky(){
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		try {
			String  lx=Struts2Utils.getParameter("lx");
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
			if(StringUtils.isNotEmpty(lx)){
				whereMap.put("lx", Integer.parseInt(lx));
			}
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			} 
			List<DBObject>list=baseDao.getList(PubConstants.SUC_LUCKYDROW, whereMap,fypage,10,sortMap);
			if(list.size()>0){
				 
				for (DBObject dbObject : list) {
					//加载状态 
					String start=dbObject.get("startdate").toString();
					String end=dbObject.get("enddate").toString();   
					if(!DateUtil.checkbig(DateFormat.getFormat(start))&&DateUtil.checkbig(DateFormat.getFormat(end))){
						dbObject.put("state", "进行中");
					}else if(DateUtil.checkbig(DateFormat.getFormat(start))){
						dbObject.put("state", "未开始");
					}else if(DateUtil.checksimal(DateFormat.getFormat(end))){
						dbObject.put("state", "已结束");
					};
					//阅读人数
					dbObject.put("pcount", wwzService.getFlow(custid,"luck-"+dbObject.get("_id").toString()));
					//参与人数
				    whereMap.clear();
				    whereMap.put("wid", Long.parseLong(dbObject.get("_id").toString()));
				    dbObject.put("scount", baseDao.getCount(PubConstants.WHD_WHDCOUNT, whereMap));
					 
				}
				sub_map.put("state",0);
				sub_map.put("list",list);
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			sub_map.put("state",1);
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);	
	}
	/**
	 * 获取投票活动总页面
	 */
	public void   ajaxvotolm(){
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		try {
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			whereMap.put("custid", custid);
			sortMap.put("sort", -1);
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			} 
			List<DBObject>list=baseDao.getList(PubConstants.SUC_VOTELM, whereMap,fypage,10,sortMap);
			if(list.size()>0){
				for (DBObject dbObject : list) {
					String start=dbObject.get("startdate").toString();
					String end=dbObject.get("enddate").toString();   
					if(!DateUtil.checkbig(DateFormat.getFormat(start))&&DateUtil.checkbig(DateFormat.getFormat(end))){
						dbObject.put("state", "进行中");
					}else if(DateUtil.checkbig(DateFormat.getFormat(start))){
						dbObject.put("state", "未开始");
					}else if(DateUtil.checksimal(DateFormat.getFormat(end))){
						dbObject.put("state", "已结束");
					};
					//阅读人数
					dbObject.put("pcount", wwzService.getFlow(custid,custid+"-vote-"+dbObject.get("_id").toString()));
					//参与人数
				    whereMap.clear();
				    whereMap.put("voteid", Long.parseLong(dbObject.get("_id").toString()));
				    dbObject.put("scount", baseDao.getCount(PubConstants.SUC_VOTE, whereMap));
				}
				
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
	 * 获取我的摇奖活动总页面
	 */
	public void   ajaxperlucky(){
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		try {
			String  lx=Struts2Utils.getParameter("lx");
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			whereMap.put("custid",custid);
			whereMap.put("fromUserid",fromUserid);
			sortMap.put("sort", -1);
			String sel=Struts2Utils.getParameter("sel");
			if(StringUtils.isNotEmpty(sel)){
				Pattern pattern = Pattern.compile("^.*" + sel + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("title", pattern); 
			}
			if(StringUtils.isNotEmpty(lx)){
				whereMap.put("lx", Integer.parseInt(lx));
			}
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			} 
			List<DBObject>list=baseDao.getList(PubConstants.SUC_LUCKYDROW, whereMap,fypage,10,sortMap);
			if(list.size()>0){
				 
				for (DBObject dbObject : list) {
					//加载状态 
					String start=dbObject.get("startdate").toString();
					String end=dbObject.get("enddate").toString();   
					if(!DateUtil.checkbig(DateFormat.getFormat(start))&&DateUtil.checkbig(DateFormat.getFormat(end))){
						dbObject.put("state", "进行中");
					}else if(DateUtil.checkbig(DateFormat.getFormat(start))){
						dbObject.put("state", "未开始");
					}else if(DateUtil.checksimal(DateFormat.getFormat(end))){
						dbObject.put("state", "已结束");
					};
					//阅读人数
					dbObject.put("pcount", wwzService.getFlow(custid,"luck-"+dbObject.get("_id").toString()));
					//参与人数
				    whereMap.clear();
				    whereMap.put("wid", Long.parseLong(dbObject.get("_id").toString()));
				    dbObject.put("scount", baseDao.getCount(PubConstants.WHD_WHDCOUNT, whereMap));
					 
				}
				sub_map.put("state",0);
				sub_map.put("list",list);
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			sub_map.put("state",1);
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);	
	}
	/**
	 * 获取我的投票活动总页面
	 */
	public void   ajaxpervotolm(){
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		try {
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			whereMap.put("custid", custid);
			whereMap.put("fromUserid",fromUserid);
			sortMap.put("sort", -1);
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			} 
			List<DBObject>list=baseDao.getList(PubConstants.SUC_VOTELM, whereMap,fypage,10,sortMap);
			if(list.size()>0){
				for (DBObject dbObject : list) {
					String start=dbObject.get("startdate").toString();
					String end=dbObject.get("enddate").toString();   
					if(!DateUtil.checkbig(DateFormat.getFormat(start))&&DateUtil.checkbig(DateFormat.getFormat(end))){
						dbObject.put("state", "进行中");
					}else if(DateUtil.checkbig(DateFormat.getFormat(start))){
						dbObject.put("state", "未开始");
					}else if(DateUtil.checksimal(DateFormat.getFormat(end))){
						dbObject.put("state", "已结束");
					};
					//阅读人数
					dbObject.put("pcount", wwzService.getFlow(custid,custid+"-vote-"+dbObject.get("_id").toString()));
					//参与人数
				    whereMap.clear();
				    whereMap.put("voteid", Long.parseLong(dbObject.get("_id").toString()));
				    dbObject.put("scount", baseDao.getCount(PubConstants.SUC_VOTE, whereMap));
				}
				
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

}
