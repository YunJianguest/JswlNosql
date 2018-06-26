package com.lsp.hou.web;
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
import com.lsp.hou.entity.HousewiferyFeatures;
import com.lsp.hou.entity.HousewiferyProblem;
import com.lsp.hou.entity.ServeType;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence; 
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.web.GeneralAction; 
import com.mongodb.DBObject;

/**
 * 服务问题
 * 
 * @author lsp
 * 
 */
@Namespace("/hou")
@Results({ @Result(name = HouproblemAction.RELOAD, location = "houproblem.action", params = {"fypage", "%{fypage}" }, type = "redirect") })
public class HouproblemAction extends GeneralAction<HousewiferyProblem> {
	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private HousewiferyProblem entity = new HousewiferyProblem();
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
		List<DBObject> list = baseDao.getList(PubConstants.HOU_HOUSEWIFERYPROBLEM,whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("list", list); 
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		try {
			custid=SpringSecurityUtils.getCurrentUser().getId(); 
			baseDao.delete(PubConstants.HOU_HOUSEWIFERYPROBLEM, _id);
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
		DBObject db = baseDao.getMessage(PubConstants.HOU_HOUSEWIFERYPROBLEM, _id);

		entity = JSON.parseObject(db.toString(), HousewiferyProblem.class);
		entity.set_id((Long) db.get("_id"));
		return "add";
	}
	public void upd() throws Exception {
		DBObject db = baseDao.getMessage(PubConstants.HOU_HOUSEWIFERYPROBLEM, _id);
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}
	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) { 
			DBObject db = baseDao.getMessage(PubConstants.HOU_HOUSEWIFERYPROBLEM, _id);

			entity = JSON.parseObject(db.toString(), HousewiferyProblem.class);
			entity.set_id((Long) db.get("_id"));
		} else {
			entity = new HousewiferyProblem();
		}
	}

	@Override
	public String save() throws Exception {
		// 注册业务逻辑
		try {
			if (_id == null) {
				_id = mongoSequence.currval(PubConstants.HOU_HOUSEWIFERYPROBLEM);
			}
			entity.set_id(_id); 
			baseDao.insert(PubConstants.HOU_HOUSEWIFERYPROBLEM, entity); 
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		return RELOAD;
	}

	@Override
	public HousewiferyProblem getModel() {
		return entity;
	}

	public void set_id(Long _id) {
		this._id = _id;
	}
	 
}
