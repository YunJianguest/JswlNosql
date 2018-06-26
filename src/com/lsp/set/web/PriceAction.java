package com.lsp.set.web;

import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import net.sf.json.JSONArray;

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
import com.lsp.set.entity.Blacklist;
import com.lsp.set.entity.Price;
import com.lsp.set.entity.SensitiveWord;
import com.lsp.website.service.WwzService;
import com.mongodb.DBObject;
import com.mongodb.util.JSON;
/**
 * 价格管理
 * 
 * @author lsp
 * 
 */
@Namespace("/set")
@Results({ @Result(name = PriceAction.RELOAD, location = "price.action", type = "redirect") })
public class PriceAction extends GeneralAction<Price>{
	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private MongoSequence mongoSequence;
	private Price entity = new Price();
	private Long _id;
	@Autowired
	private WwzService  wwzservice; 
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}

	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		sortMap.put("createdate", -1);
		whereMap.put("custid", SpringSecurityUtils.getCurrentUser().getId());
		List<DBObject> list = baseDao.getList(PubConstants.SET_PRICE,whereMap, sortMap);
		for (DBObject dbObject : list) {
			dbObject.put("nickname", wwzservice.getCustName(dbObject.get("custid").toString()));
		}
		Struts2Utils.getRequest().setAttribute("priceList", list);
		
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		try {
			custid=SpringSecurityUtils.getCurrentUser().getId();
			baseDao.delete(PubConstants.SET_PRICE, _id);
			addActionMessage("删除成功!");

		
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,删除失败!");
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
	public void upd() throws Exception {
		DBObject db = baseDao.getMessage(PubConstants.SET_PRICE, _id);
		
		String json = JSONArray.fromObject(db).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}


	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			// 有custId查出来 用户信息
			entity = (Price)UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.SET_PRICE,_id),Price.class);
			
		} else {
			entity = new Price();
		}
	}

	@Override
	public String save() throws Exception {
		// 注册业务逻辑
		try {
			if(_id==null){
				_id=mongoSequence.currval(PubConstants.SET_PRICE);
			} 
			entity.set_id(_id);
			entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
			entity.setCreatedate(new Date());
			baseDao.insert(PubConstants.SET_PRICE, entity); 
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		return RELOAD;
	}
	 
	@Override
	public Price getModel() {
		return entity;
	}

	public void set_id(Long _id) {
		this._id = _id;
	}
	 
}
