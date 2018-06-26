package com.lsp.weixin.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

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
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction;
import com.lsp.weixin.entity.WxSubscribe;
import com.lsp.weixin.entity.ZdyMessage;
import com.mongodb.DBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
@Namespace("/weixin")
@Results( { @Result(name = WxsubscribeAction.RELOAD, location = "wxsubscribe.action",params={"type", "%{type}"}, type = "redirect") })
public class WxsubscribeAction extends GeneralAction<WxSubscribe> {

	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private MongoSequence mongoSequence;	
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}

	private WxSubscribe entity=new WxSubscribe();
	private Long _id;


	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		String type=Struts2Utils.getParameter("type");
		if(StringUtils.isEmpty(Struts2Utils.getParameter("toUser"))){
			toUser=SpringSecurityUtils.getCurrentUser().getToUser();
		}else{
			toUser=Struts2Utils.getParameter("toUser");
		}
		
		whereMap.put("toUser",toUser );
		whereMap.put("type", type);
		sortMap.put("sort", 1);
		List<DBObject> list=baseDao.getList(PubConstants.DATA_SUBSCRIBE,whereMap,0,100, sortMap);
		Struts2Utils.getRequest().setAttribute("WxSubscribeList", list);
		Struts2Utils.getRequest().setAttribute("type", type);
		if(type.equals("subscribe")){
			Struts2Utils.getRequest().setAttribute("h1", "关注回复语");
		}else if(type.equals("welcome")){
			Struts2Utils.getRequest().setAttribute("h1", "无法识别回复语");
		}else{
			Struts2Utils.getRequest().setAttribute("h1", "关注回复语");
		}
		Struts2Utils.getRequest().setAttribute("toUser", toUser);
		
		whereMap.clear();
		whereMap.put("wid",toUser+"-"+type);
		sortMap.put("sort", 1);
		List<DBObject> zdylist=baseDao.getList(PubConstants.PUB_ZDYMESSAGE,whereMap,0,100, sortMap);
		Struts2Utils.getRequest().setAttribute("ZdyMessageList", zdylist);
		//List<DBObject> funclist=GetAllFunc.wxFunc.get(toUser);
		List<DBObject> refunclist=new ArrayList<DBObject>();
		/**for(int i=0;i<funclist.size();i++){
			if(funclist.get(i).get("type").toString().equals("link")){
				
			}else{
				refunclist.add(funclist.get(i));	
			}
		}
		Struts2Utils.getRequest().setAttribute("funclist", refunclist);*/
		return SUCCESS;
	}
	
	
	@Override
	public String delete() throws Exception {
		try {
			custid=SpringSecurityUtils.getCurrentUser().getId();
			baseDao.delete(PubConstants.DATA_SUBSCRIBE,_id);
			addActionMessage("成功删除!");
			String type=Struts2Utils.getParameter("type");
			Struts2Utils.getRequest().setAttribute("type", type);
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,删除过程中出现异常!");
		}
		return RELOAD;
	}
	public String delzdy() throws Exception {
		try {
			custid=SpringSecurityUtils.getCurrentUser().getId();
			baseDao.delete(PubConstants.PUB_ZDYMESSAGE,_id);
			addActionMessage("成功删除!");
			String type=Struts2Utils.getParameter("type");
			Struts2Utils.getRequest().setAttribute("type", type);
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,删除过程中出现异常!");
		}
		return RELOAD;
	}
	//新增车辆
	@Override
	public String input() throws Exception {
		String type=Struts2Utils.getParameter("type");
		Struts2Utils.getRequest().setAttribute("type", type);
		if(type.equals("subscribe")){
			Struts2Utils.getRequest().setAttribute("h1", "关注回复语");
		}else if(type.equals("welcome")){
			Struts2Utils.getRequest().setAttribute("h1", "无法恢复回复语");
		}
		
		HashMap<String, String> map =new HashMap<String, String>();
		map.put("index.action?1=1", "首页");
		map.put("link", "链接");
		map.put("text", "文字回复");
		String toUser=SpringSecurityUtils.getCurrentUser().getToUser();
	
		List<DBObject> list=GetAllFunc.wxFunc.get(toUser);
		for(int i=0;i<list.size();i++){
			if(list.get(i).get("type").toString().equals("link")){
				map.put(list.get(i).get("url").toString(), list.get(i).get("name").toString());
			}else{
				map.put(list.get(i).get("type").toString()+".action?type="+list.get(i).get("key").toString(), list.get(i).get("name").toString());
			}
		}
		Struts2Utils.getRequest().setAttribute("map", map);
		return "add";
	}
	
	
	@Override
	public String update() throws Exception {	
		String type=entity.getType();
		
		if(type.equals("subscribe")){
			Struts2Utils.getRequest().setAttribute("h1", "关注回复语");
		}else if(type.equals("welcome")){
			Struts2Utils.getRequest().setAttribute("h1", "无法恢复回复语");
		}
		HashMap<String, String> map =new HashMap<String, String>();
		map.put("index.action?1=1", "首页");
		map.put("link", "链接");
		map.put("text", "文字回复");
		String toUser=SpringSecurityUtils.getCurrentUser().getToUser();
	
		List<DBObject> list=GetAllFunc.wxFunc.get(toUser);
		for(int i=0;i<list.size();i++){
			if(list.get(i).get("type").toString().equals("link")){
				map.put(list.get(i).get("url").toString(), list.get(i).get("name").toString());
			}else{
				map.put(list.get(i).get("type").toString()+".action?type="+list.get(i).get("key").toString(), list.get(i).get("name").toString());
			}
			
		}
		Struts2Utils.getRequest().setAttribute("map", map);
		return "add";
	}
	public void upd() throws Exception {
		DBObject db = baseDao.getMessage(PubConstants.DATA_SUBSCRIBE, _id);
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}
	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			//有custId查出来 用户信息
			entity = (WxSubscribe)UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.DATA_SUBSCRIBE,_id),WxSubscribe.class);
		} else {
			entity = new WxSubscribe();
		}
	}
	
	

	@Override
	public String save() throws Exception {
		//注册业务逻辑
		try {
			if(_id == null){
				_id=mongoSequence.currval(PubConstants.DATA_SUBSCRIBE);	
			}
			
			entity.set_id(_id);
			entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
			entity.setToUser(SpringSecurityUtils.getCurrentUser().getToUser());
			entity.setCreatedate(new Date());
			baseDao.insert(PubConstants.DATA_SUBSCRIBE,entity);
		
			
			addActionMessage("成功添加!");
			String type=Struts2Utils.getParameter("type");
			Struts2Utils.getRequest().setAttribute("type", type);
			
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return RELOAD;
	}
	public String savezdy() throws Exception {
		//注册业务逻辑
		try {
			if(_id == null){
				_id=mongoSequence.currval(PubConstants.PUB_ZDYMESSAGE);	
			}
			String type=Struts2Utils.getParameter("type");
			ZdyMessage zdy=new ZdyMessage();
			zdy.set_id(_id);
			zdy.setLx(0);
			zdy.setPicurl(Struts2Utils.getParameter("picurl"));
			zdy.setSort(Integer.parseInt(Struts2Utils.getParameter("sort")));
			zdy.setTitle(Struts2Utils.getParameter("title"));
			zdy.setUrl(Struts2Utils.getParameter("url"));
			toUser=SpringSecurityUtils.getCurrentUser().getToUser();
			zdy.setToUser(toUser);
			zdy.setWid(toUser+"-"+type);
			baseDao.insert(PubConstants.PUB_ZDYMESSAGE,zdy);
		
			
			addActionMessage("成功添加!");
			
			Struts2Utils.getRequest().setAttribute("type", type);
			
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return RELOAD;
	}

	
	@Override
	public WxSubscribe getModel() {
		return entity;
	}
	public void set_id(Long _id) {
		this._id = _id;
	}
}
