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
import com.lsp.hou.entity.HousewiferyServe;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.web.GeneralAction;
import com.mongodb.DBObject;
 

/**
 * 服务管理
 * 
 * @author lsp
 * 
 */
@Namespace("/hou")
@Results({ @Result(name = HouserveAction.RELOAD, location = "houserve.action", params = {"fypage", "%{fypage}" }, type = "redirect") })
public class HouserveAction extends GeneralAction<HousewiferyServe> {
	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private HousewiferyServe entity = new HousewiferyServe();;
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
		List<DBObject> list = baseDao.getList(PubConstants.HOU_HOUSERVE,whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("list", list); 
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		try {
			custid=SpringSecurityUtils.getCurrentUser().getId(); 
			baseDao.delete(PubConstants.HOU_HOUSERVE, _id);
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
		DBObject db = baseDao.getMessage(PubConstants.HOU_HOUSERVE, _id);

		entity = JSON.parseObject(db.toString(), HousewiferyServe.class);
		entity.set_id((Long) db.get("_id"));
		return "add";
	}
	public void upd() throws Exception {
		DBObject db = baseDao.getMessage(PubConstants.HOU_HOUSERVE, _id);
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}
	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) { 
			DBObject db = baseDao.getMessage(PubConstants.HOU_HOUSERVE, _id);

			entity = JSON.parseObject(db.toString(), HousewiferyServe.class);
			entity.set_id((Long) db.get("_id"));
		} else {
			entity = new HousewiferyServe();
		}
	}

	@Override
	public String save() throws Exception {
		// 注册业务逻辑
		try {
			if (_id == null) {
				_id = mongoSequence.currval(PubConstants.HOU_HOUSERVE);
			}
			entity.set_id(_id); 
			baseDao.insert(PubConstants.HOU_HOUSERVE, entity); 
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		return RELOAD;
	}

	@Override
	public HousewiferyServe getModel() {
		return entity;
	}

	public void set_id(Long _id) {
		this._id = _id;
	}
	/**
	 * ajax获取服务
	 */
	public  void  ajaxweb(){
		Map<String, Object>submap=new HashMap<String, Object>();
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		List<DBObject>list=baseDao.getList(PubConstants.HOU_HOUSERVE, whereMap, null);
		if(list.size()>0){
			submap.put("state",0);
			submap.put("list",list);	
		}
		
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * ajax获取服务分类
	 */
	public  void  ajaxtype(){
		Map<String, Object>submap=new HashMap<String, Object>();
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		List<DBObject>list=baseDao.getList(PubConstants.HOU_SERVETYPE, whereMap, null);
		if(list.size()>0){
			submap.put("state",0);
			submap.put("list",list);	
		}
		
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	public String detail(){
		return "detail";
	}
	/**
	 * 预约
	 */
	public void  subscribe(){
		//验证预约
		if(GetAllFunc.housewifery.get(Struts2Utils.getParameter("id"))!=null){
			
		}
	}
}
