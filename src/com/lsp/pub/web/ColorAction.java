package com.lsp.pub.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
 
import com.alibaba.fastjson.JSON;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.Color;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.web.GeneralAction;
import com.lsp.shop.entiy.ShopType;
import com.mongodb.DBObject;
 

/**
 * 色值管理
 * 
 * @author lsp
 * 
 */
@Namespace("/pub")
@Results({ @Result(name = ColorAction.RELOAD, location = "color.action", params = {"fypage", "%{fypage}" }, type = "redirect") })
public class ColorAction extends GeneralAction<Color> {
	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private Color entity = new Color();;
	private Long _id;

	private MongoSequence mongoSequence;

	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}

	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();  
		List<DBObject> list = baseDao.getList(PubConstants.PUB_COLOR,whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("colorList", list); 
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		try {
			custid=SpringSecurityUtils.getCurrentUser().getId(); 
			baseDao.delete(PubConstants.PUB_COLOR, _id);
			addActionMessage("成功删除");
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
		DBObject db = baseDao.getMessage(PubConstants.PUB_COLOR, _id);

		entity = JSON.parseObject(db.toString(), Color.class);
		entity.set_id((Long) db.get("_id"));
		return "add";
	}
	public void upd() throws Exception {
		DBObject db = baseDao.getMessage(PubConstants.PUB_COLOR, _id);
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}
	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) { 
			DBObject db = baseDao.getMessage(PubConstants.PUB_COLOR, _id);

			entity = JSON.parseObject(db.toString(), Color.class);
			entity.set_id((Long) db.get("_id"));
		} else {
			entity = new Color();
		}
	}

	@Override
	public String save() throws Exception {
		// 注册业务逻辑
		try {
			if (_id == null) {
				_id = mongoSequence.currval(PubConstants.PUB_COLOR);
			}
			entity.set_id(_id); 
			baseDao.insert(PubConstants.PUB_COLOR, entity); 
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		return RELOAD;
	}

	@Override
	public Color getModel() {
		return entity;
	}

	public void set_id(Long _id) {
		this._id = _id;
	}
	/**
	 * ajax获取色值
	 */
	public  void  ajaxweb(){
		Map<String, Object>submap=new HashMap<String, Object>();
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		List<DBObject>list=baseDao.getList(PubConstants.PUB_COLOR, whereMap, null);
		if(list.size()>0){
			submap.put("state",0);
			submap.put("list",list);	
		}
		
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
}
