package com.lsp.pub.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

 
import com.alibaba.fastjson.JSON;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.ProDict;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.MarkerHtml;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.mongodb.DBObject;
 

/**
 * 资源管理
 * 
 * @author lsp
 * 
 */
@Namespace("/pub")
@Results({ @Result(name = ProdictAction.RELOAD, location = "prodict.action", params = {"value1", "%{value1}","value2", "%{value2}"}, type = "redirect") })
public class ProdictAction extends GeneralAction<ProDict> {
	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private ProDict entity = new ProDict();;
	private Long _id;
	private String value1;
	private String value2;
	private MongoSequence mongoSequence;

	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}

	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		sortMap.put("sort", 1);
		
		String value1 = Struts2Utils.getParameter("value1");
		String value2 = Struts2Utils.getParameter("value2");
		whereMap.put("cj", 1);
		List<DBObject> prolist1 = baseDao.getList(PubConstants.SET_PRODICT,whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("prolist1", prolist1);
		
		whereMap.clear();
		whereMap.put("parentkey", value1);
		whereMap.put("cj", 2);
		List<DBObject> prolist2 = baseDao.getList(PubConstants.SET_PRODICT,whereMap, sortMap);
		
		whereMap.clear();
		whereMap.put("parentkey", value2);
		whereMap.put("cj",3);
		List<DBObject> prolist3 = baseDao.getList(PubConstants.SET_PRODICT,whereMap, sortMap);
		
		Struts2Utils.getRequest().setAttribute("prolist1", prolist1);
		Struts2Utils.getRequest().setAttribute("prolist2", prolist2);
		Struts2Utils.getRequest().setAttribute("prolist3", prolist3);
		
		Struts2Utils.getRequest().setAttribute("value1", value1);
		Struts2Utils.getRequest().setAttribute("value2", value2);
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		try {
			
			baseDao.delete(PubConstants.SET_PRODICT, _id);
			addActionMessage("成功删除车辆!");
			
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,删除车辆过程中出现异常!");
		}
		return RELOAD;
	}
	public String delcx() throws Exception {
		try {
			
			baseDao.delete(PubConstants.SET_CARCX, _id);
			addActionMessage("成功删除车辆!");
			
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,删除车辆过程中出现异常!");
		}
		return RELOAD;
	}
	@Override
	public String input() throws Exception {
		
		return "add";
	}

	@Override
	public String update() throws Exception {
		
		
		return "add";
	}
	public void updpp() throws Exception {
		DBObject db = baseDao.getMessage(PubConstants.SET_PRODICT, _id);
		
		String json = JSONArray.fromObject(db).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	public void updcx() throws Exception {
		DBObject db = baseDao.getMessage(PubConstants.SET_CARCX, _id);
		
		String json = JSONArray.fromObject(db).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}


	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			// 有custId查出来 用户信息
			DBObject db = baseDao.getMessage(PubConstants.SET_DICT, _id);

			entity = JSON.parseObject(db.toString(), ProDict.class);
			entity.set_id((Long) db.get("_id"));
		} else {
			entity = new ProDict();
		}
	}

	@Override
	public String save() throws Exception {
		// 注册业务逻辑
		try {
			if (_id == null) {
				_id = mongoSequence.currval(PubConstants.SET_PRODICT);
			}
			entity.set_id(_id);
			
			baseDao.insert(PubConstants.SET_PRODICT, entity);
			Struts2Utils.getRequest().setAttribute("pp", Struts2Utils.getParameter("pp"));
			Struts2Utils.getRequest().setAttribute("cxp", Struts2Utils.getParameter("cxp"));
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return RELOAD;
	}
	 
	public String scdict1() throws Exception {
		
		MarkerHtml mh=new MarkerHtml();
    	mh.parentdict1(SpringSecurityUtils.getCurrentUser().getToUser());
    	
		return RELOAD;
	}
	public String scdict() throws Exception {
		
		int type=0;
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("type"))){
			type=Integer.parseInt(Struts2Utils.getParameter("type"));
		}
		MarkerHtml mh=new MarkerHtml();
    	mh.parentdict(SpringSecurityUtils.getCurrentUser().getToUser(),type);
    	
		return RELOAD;
	}
	public String imp() throws Exception {
		return "imp";
	}
	@Override
	public ProDict getModel() {
		return entity;
	}

	public void set_id(Long _id) {
		this._id = _id;
	}
	
	
	public BaseDao getBaseDao() {
		return baseDao;
	}

	public void setBaseDao(BaseDao baseDao) {
		this.baseDao = baseDao;
	}

	public ProDict getEntity() {
		return entity;
	}

	public void setEntity(ProDict entity) {
		this.entity = entity;
	}

	

	public String getValue1() {
		return value1;
	}

	public void setValue1(String value1) {
		this.value1 = value1;
	}

	public String getValue2() {
		return value2;
	}

	public void setValue2(String value2) {
		this.value2 = value2;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Long get_id() {
		return _id;
	}

	public MongoSequence getMongoSequence() {
		return mongoSequence;
	}
	public String promarker() throws Exception {
		
		
		MarkerHtml mh=new MarkerHtml();
    	mh.promarker();
    	
		return RELOAD;
	}
	public String citymarker() throws Exception {
		
		
		MarkerHtml mh=new MarkerHtml();
    	mh.citymarker();
    	
		return RELOAD;
	}
 
	
}
