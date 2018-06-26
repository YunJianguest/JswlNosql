package com.lsp.weixin.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Pattern;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
 
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoDbUtil;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.DateUtil;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction;
import com.lsp.weixin.entity.WxMessage;
import com.lsp.weixin.entity.ZdyMessage;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
@Namespace("/weixin")
@Results( { @Result(name = WxmessageAction.RELOAD, location = "wxmessage.action",params={"fypage", "%{fypage}","wid", "%{wid}"}, type = "redirect") })
public class WxmessageAction extends GeneralAction<WxMessage> {

	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private WxMessage entity=new WxMessage();
	private String _id;
	private String wid;
	private MongoSequence mongoSequence;	
	
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}
	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		toUser=SpringSecurityUtils.getCurrentUser().getToUser();
		whereMap.put("toUser", toUser);
		if (Struts2Utils.getParameter("fypage") != null) {
			fypage = Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		wid=Struts2Utils.getParameter("wid");
		String selkey=Struts2Utils.getParameter("selkey");
		if(StringUtils.isNotEmpty(selkey)){
			Pattern pattern = Pattern.compile("^.*" + selkey + ".*$",Pattern.CASE_INSENSITIVE);
			whereMap.put("key", pattern);
			
			Struts2Utils.getRequest().setAttribute("selkey", selkey);
		}
		fycount = baseDao.getCount(PubConstants.DATA_WXMESSAGE, whereMap);
		List<DBObject> list=baseDao.getList(PubConstants.DATA_WXMESSAGE,whereMap, fypage, 10, sortMap);
		if(StringUtils.isEmpty(wid)){
			if(list.size()>0){
				wid=list.get(0).get("_id").toString();
			}
		}
		
		Struts2Utils.getRequest().setAttribute("WxMessageList", list);
		//List<DBObject> funclist=GetAllFunc.wxFunc.get(toUser);
		List<DBObject> refunclist=new ArrayList<DBObject>();
	/**	for(int i=0;i<funclist.size();i++){
			
			if(funclist.get(i).get("type").toString().equals("link")){
				
			}else{
				DBObject db=new BasicDBObject();
				db.put("key" ,funclist.get(i).get("key").toString()+":"+funclist.get(i).get("type").toString());
				db.put("name" , funclist.get(i).get("name").toString());
				refunclist.add(db);	
			}
		}
		Struts2Utils.getRequest().setAttribute("funclist", refunclist);*/
		
		
		whereMap.clear();
		whereMap.put("toUser", SpringSecurityUtils.getCurrentUser().getToUser());
		whereMap.put("wid",wid);
		sortMap.put("sort", 1);
		List<DBObject> zdylist=baseDao.getList(PubConstants.PUB_ZDYMESSAGE,whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("zdylist", zdylist);
		Struts2Utils.getRequest().setAttribute("wid", wid);
		return SUCCESS;
	}
	
	@Override
	public String delete() throws Exception {
		try {
			custid=SpringSecurityUtils.getCurrentUser().getId();
			_id = new String(_id.getBytes("iso-8859-1"),"utf-8");
			baseDao.delete(PubConstants.DATA_WXMESSAGE,_id);
			addActionMessage("成功删除!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,删除过程中出现异常!");
		}
		return RELOAD;
	}
	public String delzdy() throws Exception {
		try {
			custid=SpringSecurityUtils.getCurrentUser().getId();
			baseDao.delete(PubConstants.PUB_ZDYMESSAGE,Long.parseLong(_id));
			addActionMessage("成功删除!");
			String type=Struts2Utils.getParameter("type");
			Struts2Utils.getRequest().setAttribute("type", type);
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,删除过程中出现异常!");
		}
		return RELOAD;
	} 
	@Override
	public String input() throws Exception {
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		HashMap<String, String> map =new HashMap<String, String>();
		toUser=SpringSecurityUtils.getCurrentUser().getToUser();
		List<DBObject> list=GetAllFunc.wxFunc.get(toUser);
		List<DBObject> footlist=GetAllFunc.footFunc.get(toUser);

		whereMap.clear();
		whereMap.put("toUser", toUser);
		List<DBObject> secondlist = baseDao.getList(PubConstants.WX_FUNCSECOND, whereMap,  sortMap);
		for(int i=0;i<list.size();i++){
			DBObject db=list.get(i);
			map.put(db.get("key").toString()+":"+db.get("type").toString(), db.get("name").toString());
		}
		for(int i=0;i<footlist.size();i++){
			DBObject db=footlist.get(i);
			map.put(db.get("key").toString()+":"+db.get("type").toString(), db.get("name").toString());
		}
		for(int i=0;i<secondlist.size();i++){
			DBObject db=secondlist.get(i);
			map.put(db.get("key").toString()+":"+db.get("value").toString(), db.get("name").toString());
		}
		
		map.put("wxsign:wxsign", "签到");
		map.put("huifu:huifu", "回复文本");
		map.put("zidingyi:zidingyi", "自定义回复");
		map.put("java:java", "自定义方法");
		Struts2Utils.getRequest().setAttribute("map", map);
		
		return "add";
	}
	
	@Override
	public String update() throws Exception {
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		HashMap<String, String> map =new HashMap<String, String>();
		toUser=SpringSecurityUtils.getCurrentUser().getToUser();
		List<DBObject> list=GetAllFunc.wxFunc.get(SpringSecurityUtils.getCurrentUser().getToUser());
		List<DBObject> footlist=GetAllFunc.footFunc.get(SpringSecurityUtils.getCurrentUser().getToUser());
		whereMap.clear();
		whereMap.put("toUser", toUser);
		List<DBObject> secondlist = baseDao.getList(PubConstants.WX_FUNCSECOND, whereMap,  sortMap);
		for(int i=0;i<list.size();i++){
			DBObject db=list.get(i);
			map.put(db.get("key").toString()+":"+db.get("type").toString(), db.get("name").toString());
		}
		for(int i=0;i<footlist.size();i++){
			DBObject db=footlist.get(i);
			map.put(db.get("key").toString()+":"+db.get("type").toString(), db.get("name").toString());
		}
		for(int i=0;i<secondlist.size();i++){
			DBObject db=secondlist.get(i);
			map.put(db.get("key").toString()+":"+db.get("value").toString(), db.get("name").toString());
		}
		if(SpringSecurityUtils.getCurrentUser().getOrgid()==20){
			map.put("teacher:teacher", "老师");
			map.put("sbbd:sbbd", "学生绑定");
		}
		map.put("wxsign:wxsign", "签到");
		map.put("huifu:huifu", "回复文本");
		map.put("zidingyi:zidingyi", "自定义回复");
		map.put("java:java", "自定义方法");
		Struts2Utils.getRequest().setAttribute("map", map);
		
		
		if(entity.getMsgType().equals("huifu")){
			entity.setMsgType("huifu:huifu");
		}else if(entity.getMsgType().equals("zidingyi")){
			entity.setMsgType("zidingyi:zidingyi");
		}else if(entity.getMsgType().equals("wxsign")){
			entity.setMsgType("wxsign:wxsign");
		}else if(entity.getMsgType().equals("java")){
			entity.setMsgType("java:java");
		}else{
			entity.setMsgType(entity.getContent()+":"+entity.getMsgType());
		}
		return "add";
	}
	public void upd() throws Exception {
		DBObject db = baseDao.getMessage(PubConstants.DATA_WXMESSAGE, _id);
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}
	@Override
	protected void prepareModel() throws Exception {

		if (StringUtils.isEmpty(_id)) {
			//有custId查出来 用户信息
			entity = new WxMessage();
		} else {
			entity = (WxMessage)UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.DATA_WXMESSAGE,_id),WxMessage.class);
			
		}
	}
	
	

	@Override
	public String save() throws Exception {
		//注册业务逻辑
		try {
			if (StringUtils.isEmpty(_id)) {
				_id=mongoSequence.currval(PubConstants.DATA_WXMESSAGE).toString();	
			}
			entity.set_id(_id);
			entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
			entity.setToUser(SpringSecurityUtils.getCurrentUser().getToUser());
			
			String[] msType=entity.getMsgType().split(":");
			if(msType.length>1){
				entity.setMsgType(msType[1]);
				entity.setContent(msType[0]);
			}else{
				
			}
			
			
			
			
			baseDao.insert(PubConstants.DATA_WXMESSAGE,entity);
			
			
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return RELOAD;
	}
	public String wxmessage() throws Exception {
		String key=Struts2Utils.getParameter("key");
		toUser=SpringSecurityUtils.getCurrentUser().getToUser();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		Pattern pattern = Pattern.compile("^.*" + key + ".*$",Pattern.CASE_INSENSITIVE);
		whereMap.put("key", pattern);
		fycount = baseDao.getCount(PubConstants.DATA_WXMESSAGE, whereMap);
		if(fycount==0){
			
			_id=mongoSequence.currval(PubConstants.DATA_WXMESSAGE).toString();	
			
			entity.set_id(_id);
			entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
			entity.setToUser(toUser);
			entity.setKey(key);
			entity.setCreatedate(new Date());
			entity.setMsgType("zidingyi");
			baseDao.insert(PubConstants.DATA_WXMESSAGE, entity);
		}
		Struts2Utils.getRequest().setAttribute("method", "/wx/wxmessage.action?selkey="+key+"&cate_id=9220");
		return "refresh";
	}
	public String savezdy() throws Exception {
		//注册业务逻辑
		try {
			ZdyMessage zdy=new ZdyMessage();
			if(StringUtils.isEmpty(_id)){
				zdy.set_id(mongoSequence.currval(PubConstants.PUB_ZDYMESSAGE));	
			}else{
				zdy.set_id(Long.parseLong(_id));
			}
			String type=Struts2Utils.getParameter("type");

			zdy.setLx(0);
			zdy.setPicurl(Struts2Utils.getParameter("picurl"));
			zdy.setSort(Integer.parseInt(Struts2Utils.getParameter("sort")));
			zdy.setTitle(Struts2Utils.getParameter("title"));
			zdy.setUrl(Struts2Utils.getParameter("url"));
			toUser=SpringSecurityUtils.getCurrentUser().getToUser();
			zdy.setToUser(toUser);
			String wid=Struts2Utils.getParameter("wid");
			zdy.setWid(wid);
			baseDao.insert(PubConstants.PUB_ZDYMESSAGE,zdy);
		
			
			addActionMessage("成功添加!");
			
			Struts2Utils.getRequest().setAttribute("type", type);
			Struts2Utils.getRequest().setAttribute("wid", wid);
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return RELOAD;
	}
	public String unknow() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		whereMap.put("createdate", new BasicDBObject("$lte", DateUtil.addHour(new Date(),-24)));
		whereMap.put("toUser", SpringSecurityUtils.getCurrentUser().getToUser());
		List<DBObject> list=baseDao.getList(PubConstants.WX_UNKNOWMESS,whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("unknowList", list);
		
		return "unknow";
	}
	public String create() throws Exception {
	
		entity.setKey(Struts2Utils.getParameter("key"));
		
		HashMap<String, String> map =new HashMap<String, String>();
		
		List<DBObject> list=GetAllFunc.wxFunc.get(SpringSecurityUtils.getCurrentUser().getToUser());
	
		
		for(int i=0;i<list.size();i++){
			map.put(list.get(i).get("_id").toString(), list.get(i).get("name").toString());
		}
		if(SpringSecurityUtils.getCurrentUser().getOrgid()==20){
			map.put("teacher", "老师");
			map.put("sbbd", "学生绑定");
		}
		Struts2Utils.getRequest().setAttribute("map", map);
		return "add";
	}
	@Override
	public WxMessage getModel() {
		return entity;
	}
	public void set_id(String _id) {
		this._id = _id;
	}
	public String getWid() {
		return wid;
	}
	public void setWid(String wid) {
		this.wid = wid;
	}
	
}
