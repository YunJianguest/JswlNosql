package com.lsp.shop.web;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.lsp.shop.entiy.ShopMb;
import com.lsp.shop.entiy.Specification;
import com.lsp.website.service.WwzService;
import com.mongodb.DBObject;
import com.sun.org.apache.commons.beanutils.WrapDynaBean;
/**
 * 商品规格
 * 
 * @author lsp
 * 
 */
@Namespace("/shop")
@Results({ @Result(name = SpecificationAction.RELOAD, location = "specification.action", params={"parentid", "%{parentid}","fypage", "%{fypage}"}, type = "redirect") })
public class SpecificationAction extends GeneralAction<Specification> {
	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private Specification entity = new Specification();
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
		whereMap.put("parentid",Long.parseLong(Struts2Utils.getParameter("parentid")));
	
		List<DBObject> list = baseDao.getList(PubConstants.SHOP_SPECIFICATION,whereMap, sortMap);
		for (DBObject dbObject : list) {
			dbObject.put("nickname", wwzservice.getCustName(dbObject.get("custid").toString()));
		}
		Struts2Utils.getRequest().setAttribute("specificaList", list);
		Struts2Utils.getRequest().setAttribute("custid", SpringSecurityUtils.getCurrentUser().getId()); 
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		try {
			custid=SpringSecurityUtils.getCurrentUser().getId();
			baseDao.delete(PubConstants.SHOP_SPECIFICATION, _id);
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
		 
		return "add";
	}
	public void upd() throws Exception {
		DBObject db = baseDao.getMessage(PubConstants.SHOP_SPECIFICATION, _id);
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}
	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			// 有custId查出来 用户信息
			DBObject db = baseDao.getMessage(PubConstants.SHOP_SPECIFICATION, _id);

			entity = JSON.parseObject(db.toString(), Specification.class);
			entity.set_id((Long) db.get("_id"));
		} else {
			entity = new Specification();
		}
	}

	@Override
	public String save() throws Exception {
		// 注册业务逻辑
		try {
			if (_id == null) {
				_id = mongoSequence.currval(PubConstants.SHOP_SPECIFICATION);
			}
			entity.set_id(_id);
			entity.setParentid(Long.parseLong(Struts2Utils.getParameter("parentid")));
			entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
			baseDao.insert(PubConstants.SHOP_SPECIFICATION, entity); 
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		return RELOAD;
	}

	@Override
	public Specification getModel() {
		return entity;
	}

	public void set_id(Long _id) {
		this._id = _id;
	}
     
}
