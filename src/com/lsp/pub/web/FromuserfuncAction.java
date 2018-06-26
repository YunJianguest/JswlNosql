package com.lsp.pub.web;
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
import com.lsp.pub.entity.Fromuserfunc;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction;
import com.lsp.shop.entiy.ShopMb;
import com.mongodb.DBObject;
import com.sun.org.apache.commons.beanutils.WrapDynaBean;
/**
 * 个人中心菜单管理
 * 
 * @author lsp
 * 
 */
@Namespace("/pub")
@Results({ @Result(name = FromuserfuncAction.RELOAD, location = "fromuserfunc.action", params={"fypage", "%{fypage}"}, type = "redirect") })
public class FromuserfuncAction extends GeneralAction<Fromuserfunc> {
	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private Fromuserfunc entity = new Fromuserfunc();;
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
		custid=SpringSecurityUtils.getCurrentUser().getId();
		sortMap.put("sort", -1);   
		List<DBObject> list = baseDao.getList(PubConstants.PUB_FROMUSERFUNC,whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("list", list); 
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		try {
			custid=SpringSecurityUtils.getCurrentUser().getId();
			baseDao.delete(PubConstants.PUB_FROMUSERFUNC, _id);
			addActionMessage("成功删除成功!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("删除失败!");
		}
		return RELOAD;
	}

	@Override
	public String input() throws Exception {
		
		return "add";
	}

	@Override
	public String update() throws Exception {
		
		DBObject db = baseDao.getMessage(PubConstants.PUB_FROMUSERFUNC, _id);

		entity = JSON.parseObject(db.toString(), Fromuserfunc.class);
		entity.set_id((Long) db.get("_id"));
		return "add";
	}
	public void upd() throws Exception {
		DBObject db = baseDao.getMessage(PubConstants.PUB_FROMUSERFUNC, _id);
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}
	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			// 有custId查出来 用户信息
			DBObject db = baseDao.getMessage(PubConstants.PUB_FROMUSERFUNC, _id);

			entity = JSON.parseObject(db.toString(), Fromuserfunc.class);
			entity.set_id((Long) db.get("_id"));
		} else {
			entity = new Fromuserfunc();
		}
	}

	@Override
	public String save() throws Exception {
		// 注册业务逻辑
		try {
			if (_id == null) {
				_id = mongoSequence.currval(PubConstants.PUB_FROMUSERFUNC);
			}
			entity.set_id(_id); 
			baseDao.insert(PubConstants.PUB_FROMUSERFUNC, entity); 
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		return RELOAD;
	}

	@Override
	public Fromuserfunc getModel() {
		return entity;
	}

	public void set_id(Long _id) {
		this._id = _id;
	}
   
}
