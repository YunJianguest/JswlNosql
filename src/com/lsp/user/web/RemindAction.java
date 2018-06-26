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
 * 用户消息提醒
 * @author lsp
 *
 */
@Namespace("/user")
@Results({@org.apache.struts2.convention.annotation.Result(name="reload", location="remind.action",type="redirect")})
public class RemindAction extends GeneralAction<WxUser>{
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
	 
		return RELOAD;
	}

	@Override
	public String delete() throws Exception {
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
	/**
	 * 获取id
	 */
	public  void   getUserid(){
		getLscode();
		Map<String, Object> submap = new HashMap<String, Object>();
		if(StringUtils.isNotEmpty(fromUserid)){
			submap.put("state",0);
			submap.put("value",fromUserid);
		} 
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	} 
	/**
	 * 给用户发消息
	 */
	public  void   sendMsg(){  
		String uid=SpringSecurityUtils.getCurrentUser().getId();
		String id=Struts2Utils.getParameter("id");
		String msg=Struts2Utils.getParameter("msg");
		Map<String, Object> submap = new HashMap<String, Object>();
		JmsService.SendMsg(id, msg); 
		submap.put("state",0); 
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	} 
	/**
	 * 添加未读消息
	 */
	public  void   AddUnread(){  
		getLscode(); 
		String rid=Struts2Utils.getParameter("rid"); 
		Map<String, Object> submap = new HashMap<String, Object>();
		JmsService.AddUnread(fromUserid, rid);
		submap.put("state",0); 
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	} 
	/**
	 * 添加未读消息
	 */
	public  void   AddAllUnread(){  
		getLscode(); 
		String rid=Struts2Utils.getParameter("rid"); 
		String ids=Struts2Utils.getParameter("ids"); 
		Map<String, Object> submap = new HashMap<String, Object>();
		if(ids!=null){
			ids=ids.replace(",","").trim();
			String fromID=wwzservice.getfromUseridVipNo(ids);
			JmsService.AddUnread(fromID, rid);
			submap.put("state",0); 
		} 
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	} 
	 
}
