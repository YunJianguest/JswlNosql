package com.lsp.shop.web;
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
import com.alibaba.fastjson.JSON;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction;
import com.lsp.shop.entiy.ShopAgent;
import com.lsp.shop.entiy.ShopMb;
import com.lsp.website.service.WwzService;
import com.mongodb.DBObject;
import com.sun.org.apache.commons.beanutils.WrapDynaBean;
/**
 * 店铺代理
 * 
 * @author lsp
 * 
 */
@Namespace("/shop")
@Results({ @Result(name = ShopagentAction.RELOAD, location = "shopagent.action", params={"fypage", "%{fypage}","wid", "%{wid}"}, type = "redirect") })
public class ShopagentAction extends GeneralAction<ShopAgent> {
	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private ShopAgent entity = new ShopAgent();;
	private String _id;
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
		if(StringUtils.isNotEmpty(wid)){
			whereMap.put("wid", Long.parseLong(wid));
		} 
		String no=Struts2Utils.getParameter("no");
		if(StringUtils.isNotEmpty(no)){
			whereMap.put("no", no);
			Struts2Utils.getRequest().setAttribute("no",no);
		}
		String name=Struts2Utils.getParameter("name");
		if(StringUtils.isNotEmpty(name)){

			Pattern pattern = Pattern.compile("^.*" + name + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("name", pattern);
			Struts2Utils.getRequest().setAttribute("name", name);
		}
		String tel=Struts2Utils.getParameter("tel");
		if(StringUtils.isNotEmpty(tel)){

			Pattern pattern = Pattern.compile("^.*" + tel + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("tel", pattern);
			Struts2Utils.getRequest().setAttribute("tel", tel);
		}
		String nickname=Struts2Utils.getParameter("nickname");
		if(StringUtils.isNotEmpty(nickname)){

			Pattern pattern = Pattern.compile("^.*" + nickname + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("nickname", pattern);
			Struts2Utils.getRequest().setAttribute("nickname", nickname);
		}
		String state=Struts2Utils.getParameter("state");
		if(StringUtils.isNotEmpty(state)){
			whereMap.put("state", Integer.parseInt(state));
			Struts2Utils.getRequest().setAttribute("state", state);
		}
		List<DBObject> list = baseDao.getList(PubConstants.SHOP_SHOPAGENT,whereMap, sortMap); 
		Struts2Utils.getRequest().setAttribute("list", list);
		Struts2Utils.getRequest().setAttribute("custid", SpringSecurityUtils.getCurrentUser().getId()); 
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		try {
			custid=SpringSecurityUtils.getCurrentUser().getId();
			baseDao.delete(PubConstants.SHOP_SHOPAGENT, _id);
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
		
		DBObject db = baseDao.getMessage(PubConstants.SHOP_SHOPAGENT, _id);

		entity = JSON.parseObject(db.toString(), ShopAgent.class);
		entity.set_id((Long) db.get("_id"));
		return "add";
	}
	public void upd() throws Exception {
		DBObject db = baseDao.getMessage(PubConstants.SHOP_SHOPAGENT, _id);
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}
	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			// 有custId查出来 用户信息
			DBObject db = baseDao.getMessage(PubConstants.SHOP_SHOPAGENT, _id);

			entity = JSON.parseObject(db.toString(), ShopAgent.class);
			entity.set_id((Long) db.get("_id"));
		} else {
			entity = new ShopAgent();
		}
	}

	@Override
	public String save() throws Exception {
		 
		return RELOAD;
	}

	@Override
	public ShopAgent getModel() {
		return entity;
	}

	public void set_id(String _id) {
		this._id = _id;
	}
	/**
	 * ajax审核
	 */
    public void ajaxset(){
    	custid=SpringSecurityUtils.getCurrentUser().getId();
    	String state=Struts2Utils.getParameter("state");
    	String id=Struts2Utils.getParameter("id");
    	Map<String, Object> sub_map = new HashMap<String, Object>();
    	DBObject  db=baseDao.getMessage(PubConstants.SHOP_SHOPAGENT,id);
    	if(db!=null&&StringUtils.isNotEmpty(state)){
    		ShopAgent  agent=(ShopAgent) UniObject.DBObjectToObject(db, ShopAgent.class);
    		agent.setState(Integer.parseInt(state));
    		agent.setSetdate(new Date());
    		baseDao.insert(PubConstants.SHOP_SHOPAGENT, agent);
    		sub_map.put("state",0);
    	}
    	String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    }
}
