package com.lsp.weixin.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;

 
import com.alibaba.fastjson.JSON;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.HttpClient;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.entity.WxToken;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.web.GeneralAction;
import com.lsp.website.service.WwzService;
import com.lsp.weixin.entity.WxMenu;
import com.mongodb.DBObject;
 
/***
 * 资源管理
 * @author lsp
 *
 */
@Namespace("/weixin")
@Results( { @Result(name = WxmenuAction.RELOAD, location = "wxmenu.action",params={"parentid", "%{parentid}","toUser", "%{toUser}"}, type = "redirect") })
public class WxmenuAction extends GeneralAction<WxMenu> {

	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private WxMenu entity=new WxMenu();;
	private Long _id;
	@Autowired
	private WwzService wwzService;

	
	private MongoSequence mongoSequence;	
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}
	
	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		sortMap.put("sort", 1);
		Long parentid=0L;
		
		whereMap.put("parentid", 0L);
		custid=SpringSecurityUtils.getCurrentUser().getId();
		whereMap.put("custid", custid);	
		List<DBObject> list=baseDao.getList(PubConstants.DATA_WXMENU,whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("menu1List", list);
		
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("parentid"))){
			parentid=Long.parseLong(Struts2Utils.getParameter("parentid"));
			whereMap.put("parentid", parentid);
			
			List<DBObject> list2=baseDao.getList(PubConstants.DATA_WXMENU,whereMap, sortMap);
			Struts2Utils.getRequest().setAttribute("menu2List", list2);
		}
		
		Struts2Utils.getRequest().setAttribute("toUser", toUser);
		Struts2Utils.getRequest().setAttribute("custid", custid); 
		Struts2Utils.getRequest().setAttribute("parentid", parentid);
		return SUCCESS;
	}
	
	@Override
	public String delete() throws Exception {
		try { 
			custid=SpringSecurityUtils.getCurrentUser().getId();
			Struts2Utils.getRequest().setAttribute("parentid", Struts2Utils.getParameter("parentid"));
			baseDao.delete(PubConstants.DATA_WXMENU,_id);
			
			HashMap<String, Object> whereMap =new HashMap<String, Object>();
			whereMap.put("parentid", _id);
			baseDao.delete(PubConstants.DATA_WXMENU,whereMap);
			addActionMessage("成功删除!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,删除过程中出现异常!");
		}
		return RELOAD;
	}
 
	@Override
	public String input() throws Exception {
		
		Struts2Utils.getRequest().setAttribute("parentid", Struts2Utils.getParameter("parentid"));
		return "add";
	}
	
	@Override
	public String update() throws Exception {
		Struts2Utils.getRequest().setAttribute("parentid", Struts2Utils.getParameter("parentid"));
		return "add";
	}
	public void upd() throws Exception {
		DBObject db = baseDao.getMessage(PubConstants.DATA_WXMENU, _id);
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}
	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			//有custId查出来 用户信息
			entity = (WxMenu)baseDao.getMessage(PubConstants.DATA_WXMENU,_id,WxMenu.class);
		} else {
			entity = new WxMenu();
		}
	}
	
	

	@Override
	public String save() throws Exception {
		//注册业务逻辑
		try {
			if(_id == null){
				_id=mongoSequence.currval(PubConstants.DATA_WXMENU);	
			}
			entity.set_id(_id);
			entity.setKey(entity.getKey().trim());
			entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
			if(StringUtils.isEmpty(Struts2Utils.getParameter("toUser"))){
				toUser=SpringSecurityUtils.getCurrentUser().getToUser();
			}else{
				toUser=Struts2Utils.getParameter("toUser");	
			}
			
			entity.setToUser(toUser);
			
			
			baseDao.insert(PubConstants.DATA_WXMENU,entity);
			Struts2Utils.getRequest().setAttribute("parentid", Struts2Utils.getParameter("parentid"));
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return RELOAD;
	}

	public String creatmenu() throws Exception {
		
		
		toUser=SpringSecurityUtils.getCurrentUser().getToUser();
		custid=SpringSecurityUtils.getCurrentUser().getId();
		WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		}
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String creaturl="https://api.weixin.qq.com/cgi-bin/menu/create?access_token="+token.getAccess_token();

		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		whereMap.put("toUser", toUser);
		whereMap.put("parentid", 0L);
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		sortMap.put("sort", 1);
		List<DBObject> list=baseDao.getList(PubConstants.DATA_WXMENU, whereMap, sortMap);
		Map<String,List<Map<String,Object>>> buttonmap = new HashMap<String,List<Map<String,Object>>>();
		List<Map<String,Object>> buttonlist = new ArrayList<Map<String,Object>>();
		for(int i=0;i<list.size();i++){
			Map<String,Object> map = new HashMap<String,Object>();
			WxMenu menu=(WxMenu)UniObject.DBObjectToObject(list.get(i), WxMenu.class);
			if(menu.getType().equals("click")){
				map.put("type", menu.getType());
				map.put("name", menu.getName());
				map.put("key", menu.getKey());
			}else if(menu.getType().equals("view")){
				map.put("type", menu.getType());
				map.put("name", menu.getName());
				map.put("url", menu.getKey());
			}else if(menu.getType().equals("menu")){
				List<Map<String,String>> sub_buttonlist = new ArrayList<Map<String,String>>();
				map.put("name", menu.getName());
				
				whereMap.put("parentid", Long.parseLong(list.get(i).get("_id").toString()));
				List<DBObject> sub_list=baseDao.getList(PubConstants.DATA_WXMENU, whereMap, sortMap);
				for(int j=0;j<sub_list.size();j++){
					WxMenu sub_menu=(WxMenu)UniObject.DBObjectToObject(sub_list.get(j), WxMenu.class);
					Map<String,String> sub_map = new HashMap<String,String>();
					if(sub_menu.getType().equals("click")){
						sub_map.put("type", sub_menu.getType());
						sub_map.put("name", sub_menu.getName());
						sub_map.put("key", sub_menu.getKey());
					}else if(sub_menu.getType().equals("view")){
						sub_map.put("type", sub_menu.getType());
						sub_map.put("name", sub_menu.getName());
						sub_map.put("url", sub_menu.getKey());
					}
					sub_buttonlist.add(sub_map);
				}
				
				map.put("sub_button",sub_buttonlist);
			}
			buttonlist.add(map);
		}
		buttonmap.put("button", buttonlist);
		String json = JSONArray.fromObject(buttonmap).toString();
		json=json.substring(1, json.length()-1);
		
		String ret=HttpClient.http(creaturl, json);
		addActionMessage(ret);
		return RELOAD;
	}
	public String delmenu() throws Exception {
		
		if(StringUtils.isEmpty(Struts2Utils.getParameter("toUser"))){
			toUser=SpringSecurityUtils.getCurrentUser().getToUser();
			
		}else{
			toUser=Struts2Utils.getParameter("toUser");	

		}
		WxToken token=WeiXinUtil.getTokenByToUser(toUser);
		String delurl="https://api.weixin.qq.com/cgi-bin/menu/delete?access_token="+token.getAccess_token();
		String ret=HttpClient.http(delurl, null);
		
			
		addActionMessage(ret);
		
		return RELOAD;
	}
	@Override
	public WxMenu getModel() {
		return entity;
	}
	public void set_id(Long _id) {
		this._id = _id;
	}
}
