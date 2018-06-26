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
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.RelativeDate;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.UserUtil;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.web.GeneralAction;
import com.lsp.suc.entity.Comunit;
import com.lsp.user.entity.CustomerInfo;
import com.lsp.user.entity.FriendsInfo;
import com.lsp.user.entity.UserInfo;
import com.lsp.website.service.WwzService;
import com.lsp.weixin.entity.WxUser;
import com.lsp.weixin.entity.WxUserToken;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
/**
 * 好友管理
 * @author lsp
 *
 */
@Namespace("/user")
@Results({@org.apache.struts2.convention.annotation.Result(name="reload", location="friends.action", type="redirect")})
public class FriendsAction extends GeneralAction<FriendsInfo>{
	 private static final long serialVersionUID = -6784469775589971579L;

	  @Autowired
	  private BaseDao basedao;
	  private String _id;
	  private FriendsInfo entity = new FriendsInfo();
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

	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		 
		
		return RELOAD;
	}

	@Override
	public String delete() throws Exception {
		 
		return RELOAD;
	}

	@Override
	protected void prepareModel() throws Exception {
	  
	}
	@Override
	public FriendsInfo getModel() {
		// TODO Auto-generated method stub
		return entity;
	}
	/**
	 * 好友管理
	 * @return
	 */
	public  String  web(){
		getLscode();
		Struts2Utils.getRequest().setAttribute("custid", custid);
		Struts2Utils.getRequest().setAttribute("type", Struts2Utils.getParameter("type"));
		return "web"; 	
	}
	 /**
	  * ajax获取好友
	  */
    public void  ajaxweb(){
    	getLscode();
		String  id=Struts2Utils.getParameter("id"); 
		String  state=Struts2Utils.getParameter("state");
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		Map<String, Object>sub_Map=new HashMap<String, Object>();
		sortMap.put("createdate",-1);
	    if(StringUtils.isNotEmpty(id)){
	    	whereMap.put("friendsid",id);
	    }
	    if(StringUtils.isNotEmpty(state)){
	    	whereMap.put("state",Integer.parseInt(state));
	    }
	    whereMap.put("fromUserid",fromUserid);
	    if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			  fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		  }
	    List<DBObject>list=basedao.getList(PubConstants.USER_FRIEDSINFO, whereMap,fypage,10,sortMap);
	    if(list.size()>0){
	    	sub_Map.put("state",0);
	    	for (DBObject dbObject : list) {
				if(dbObject.get("friendsid")!=null){
					DBObject  db= wwzservice.getWxUser(dbObject.get("friendsid").toString());
					dbObject.put("headimgurl",db.get("headimgurl"));
					dbObject.put("no",db.get("no"));
					dbObject.put("nickname",db.get("nickname"));
				}
				if(dbObject.get("createdate")!=null){
					dbObject.put("createdate", RelativeDate.format(DateFormat.getFormat(dbObject.get("createdate").toString()), new Date()));
				}
			}
	    	
	    	sub_Map.put("list", list);
	    }
		String json = JSONArray.fromObject(sub_Map).toString();
		 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		 
	 }
    /**
     * ajax设置好友
     */
    public  void   ajaxset(){
    	getLscode();
		String  id=Struts2Utils.getParameter("id"); 
		String  state=Struts2Utils.getParameter("state"); 
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		Map<String, Object>sub_Map=new HashMap<String, Object>();
		sortMap.put("createdate",-1); 
	    DBObject  db=basedao.getMessage(PubConstants.USER_FRIEDSINFO, Long.parseLong(id));
	    if(db!=null){
	    	FriendsInfo  fr=(FriendsInfo) UniObject.DBObjectToObject(db, FriendsInfo.class);
	    	if(StringUtils.isNotEmpty(state)){
	    		fr.setState(Integer.parseInt(state));
	    		fr.setSetdate(new Date());
	    		basedao.insert(PubConstants.USER_FRIEDSINFO, fr);
	    		sub_Map.put("state", 0);
	    	}
	    }
	    
		String json = JSONArray.fromObject(sub_Map).toString();
		 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    }
	 
}
