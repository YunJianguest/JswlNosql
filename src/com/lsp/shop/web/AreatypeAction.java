package com.lsp.shop.web;

import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

 
import com.alibaba.fastjson.JSON;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.MarkerHtml;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.web.GeneralAction;
import com.lsp.shop.entiy.AreaType;
import com.mongodb.DBObject;
 

/**
 * 资源管理
 * 
 * @author lsp
 * 
 */
@Namespace("/shop")
@Results({ @Result(name = AreatypeAction.RELOAD, location = "areatype.action", params = {"parentid", "%{parentid}" }, type = "redirect") })
public class AreatypeAction extends GeneralAction<AreaType> {
	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private AreaType entity = new AreaType();;
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
		sortMap.put("sort", 1);
		Long parentid = 0L;
		if (!StringUtils.isEmpty(Struts2Utils.getParameter("parentid"))) {
			parentid = Long.parseLong(Struts2Utils.getParameter("parentid"));
		}
		
		whereMap.put("toUser", SpringSecurityUtils.getCurrentUser().getToUser());
		whereMap.put("parentid", parentid);
		List<DBObject> list = baseDao.getList(PubConstants.SHOP_AREATYPE,whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("funcList", list);
		Struts2Utils.getRequest().setAttribute("parentid",whereMap.get("parentid"));
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		try {
			Struts2Utils.getRequest().setAttribute("parentid",
					Struts2Utils.getParameter("parentid"));
			baseDao.delete(PubConstants.SHOP_AREATYPE, _id);
			addActionMessage("成功删除!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,删除过程中出现异常!");
		}
		return RELOAD;
	}

	@Override
	public String input() throws Exception {
		Struts2Utils.getRequest().setAttribute("parentid",
				Struts2Utils.getParameter("parentid"));
		return "add";
	}

	@Override
	public String update() throws Exception {
		Struts2Utils.getRequest().setAttribute("parentid",
				Struts2Utils.getParameter("parentid"));
		DBObject db = baseDao.getMessage(PubConstants.SHOP_AREATYPE, _id);

		entity = JSON.parseObject(db.toString(), AreaType.class);
		entity.set_id((Long) db.get("_id"));
		return "add";
	}

	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			// 有custId查出来 用户信息
			DBObject db = baseDao.getMessage(PubConstants.SHOP_AREATYPE, _id);

			entity = JSON.parseObject(db.toString(), AreaType.class);
			entity.set_id((Long) db.get("_id"));
		} else {
			entity = new AreaType();
		}
	}

	@Override
	public String save() throws Exception {
		// 注册业务逻辑
		try {
			if (_id == null) {
				_id = mongoSequence.currval(PubConstants.SHOP_AREATYPE);
			}
			entity.set_id(_id);
			entity.setToUser(SpringSecurityUtils.getCurrentUser().getToUser());
			baseDao.insert(PubConstants.SHOP_AREATYPE, entity);
			Struts2Utils.getRequest().setAttribute("parentid",
					Struts2Utils.getParameter("parentid"));
			baseDao.insertString(PubConstants.UPD_FREEMARKER,"area-"+_id);
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		return RELOAD;
	}
	public String create() throws Exception {
		Struts2Utils.getRequest().setAttribute("parentid",
				Struts2Utils.getParameter("parentid"));
		MarkerHtml mh=new MarkerHtml();
    	mh.area(SpringSecurityUtils.getCurrentUser().getToUser());
    	
		return RELOAD;
	}

	@Override
	public AreaType getModel() {
		return entity;
	}

	public void set_id(Long _id) {
		this._id = _id;
	}
}
