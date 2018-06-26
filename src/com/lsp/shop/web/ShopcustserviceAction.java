package com.lsp.shop.web;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.directwebremoting.ScriptSession;
import org.springframework.beans.factory.annotation.Autowired; 
import com.alibaba.fastjson.JSON;
import com.lsp.dwr.service.DWRScriptSessionListener;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.DBobjectUtil;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction;
import com.lsp.shop.entiy.ShopCustService;
import com.lsp.shop.entiy.ShopMb;
import com.lsp.website.service.WwzService;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import com.sun.org.apache.commons.beanutils.WrapDynaBean;
/**
 * 
 * 店铺客服
 * @author lsp
 * 
 */
@Namespace("/shop")
@Results({ @Result(name = ShopcustserviceAction.RELOAD, location = "shopcustservice.action", params={"fypage", "%{fypage}","wid", "%{wid}"}, type = "redirect") })
public class ShopcustserviceAction extends GeneralAction<ShopCustService> {
	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private ShopCustService entity = new ShopCustService();;
	private Long _id;
	@Autowired
	private WwzService  wwzservice; 
	private MongoSequence mongoSequence;

	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}

	@Override
	public String execute() throws Exception { 
		 
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		sortMap.put("_id", -1);  
		whereMap.put("custid", SpringSecurityUtils.getCurrentUser().getId());
	
		String wid=Struts2Utils.getParameter("wid");
		whereMap.put("wid",Long.parseLong(wid));
		List<DBObject> list = baseDao.getList(PubConstants.SHOP_SHOPCUSTSERVICE,whereMap, sortMap);
		for (DBObject dbObject : list) {
			dbObject.put("no", wwzservice.getWxUsertype(dbObject.get("fromUserid").toString(),"no"));
		}
		Struts2Utils.getRequest().setAttribute("List", list);
		Struts2Utils.getRequest().setAttribute("custid", SpringSecurityUtils.getCurrentUser().getId()); 
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		try {
			custid=SpringSecurityUtils.getCurrentUser().getId();
			baseDao.delete(PubConstants.SHOP_SHOPCUSTSERVICE, _id);
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
		
		DBObject db = baseDao.getMessage(PubConstants.SHOP_SHOPCUSTSERVICE, _id);

		entity = JSON.parseObject(db.toString(), ShopCustService.class);
		entity.set_id((Long) db.get("_id"));
		return "add";
	}
	public void upd() throws Exception {
		DBObject db = baseDao.getMessage(PubConstants.SHOP_SHOPCUSTSERVICE, _id);
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}
	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			// 有custId查出来 用户信息
			DBObject db = baseDao.getMessage(PubConstants.SHOP_SHOPCUSTSERVICE, _id);

			entity = JSON.parseObject(db.toString(), ShopCustService.class);
			entity.set_id((Long) db.get("_id"));
		} else {
			entity = new ShopCustService();
		}
	}

	@Override
	public String save() throws Exception {
		// 注册业务逻辑
		try {
			if (_id == null) {
				_id = mongoSequence.currval(PubConstants.SHOP_SHOPCUSTSERVICE);
			}
			entity.set_id(_id);
			entity.setCreatedate(new Date());
			String no=Struts2Utils.getParameter("no");
			String fromUserid=wwzservice.getfromUseridVipNo(no);
			if(StringUtils.isNotEmpty(fromUserid)){
				entity.setFromUserid(fromUserid);
				entity.setHeadimgurl(wwzservice.getWxUsertype(fromUserid, "headimgurl"));
				entity.setNickname(wwzservice.getWxUsertype(fromUserid, "nickname"));
				entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
				baseDao.insert(PubConstants.SHOP_SHOPCUSTSERVICE, entity); 
				addActionMessage("成功添加!");
			}
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		return RELOAD;
	}

	@Override
	public ShopCustService getModel() {
		return entity;
	}

	public void set_id(Long _id) {
		this._id = _id;
	}
	/**
	 * 客服登录
	 * @return
	 */
	public String login(){
		Struts2Utils.getRequest().setAttribute("custid",custid);
		Struts2Utils.getRequest().setAttribute("wid",Struts2Utils.getParameter("wid")); 
		return "login"; 
	}
	public void ajaxlogin(){ 
		Map<String, Object> submap = new HashMap<String, Object>();
	    String id=Struts2Utils.getParameter("id");
	    String wid=Struts2Utils.getParameter("wid");
	    String password=Struts2Utils.getParameter("password"); 
	     
	    DBObject  db=wwzservice.getWXuserVipNo(id); 
	    if(db!=null){
	    	if(db.get("password")!=null&&db.get("password").toString().equals(password)){ 
	    		HashMap<String,Object>whereMap=new HashMap<>(); 
	    		whereMap.put("custid",custid);
	    		whereMap.put("wid",Long.parseLong(wid));
	    		whereMap.put("fromUserid",db.get("_id").toString());
	    		DBObject  cust=baseDao.getMessage(PubConstants.SHOP_SHOPCUSTSERVICE, whereMap); 
	    		//检测登录
	    		Collection<ScriptSession> sessions = DWRScriptSessionListener.getScriptSessions();
	    		for (ScriptSession scriptSession : sessions) {
					if(scriptSession.getAttribute("fromUserid")!=null&&scriptSession.getAttribute("fromUserid").toString().equals(db.get("_id").toString())){
						//移除登录信息
						//sessions.remove(scriptSession.getId());
					}
				}
	    		if(cust!=null){ 
		    		submap.put("state", 0);
		    		submap.put("value",wwzservice.getcode(db.get("_id").toString()));  
		    		List<DBObject>list=GetAllFunc.shopCustService.get(Struts2Utils.getParameter("wid"));
		    		if(list==null){
		    			list=new ArrayList<DBObject>();
		    			list.add(db);
		    			GetAllFunc.shopCustService.put(Struts2Utils.getParameter("wid"), list);
		    		}else{
		    			if(!DBobjectUtil.contains(list,db,"_id")){
			    			list.add(db);
			    			GetAllFunc.shopCustService.put(Struts2Utils.getParameter("wid"), list);
			    		}
		    		}
		    		
		    		
		    		
	    		}
	    		
	    	}
	    }
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	} 
	/**
	 * 获取店铺列表
	 */
    public void  getAllshop(){
    	Map<String, Object> submap = new HashMap<String, Object>();
		HashMap<String, Object>whereMap=new HashMap<>();
		HashMap<String, Object>sortMap=new HashMap<>();
		HashMap<String, Object>backMap=new HashMap<>();
		sortMap.put("createdate",-1);
		backMap.put("name",1);
		backMap.put("custid",1);
		backMap.put("_id",1);
		whereMap.put("name", new BasicDBObject("$ne",null));
		whereMap.put("_id", new BasicDBObject("$gte",0));
		List<DBObject>list=baseDao.getList(PubConstants.SHOP_SHOPMB, whereMap, sortMap,backMap);
		if(list.size()>0){ 
			submap.put("state", 0);
			submap.put("list",list);
		}
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
    
}
