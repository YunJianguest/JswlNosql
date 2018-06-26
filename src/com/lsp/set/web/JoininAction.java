package com.lsp.set.web;

import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import net.sf.json.JSONArray;

import org.apache.commons.lang3.StringUtils;
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
import com.lsp.set.entity.Joinin;
import com.lsp.set.entity.Price;
import com.lsp.set.entity.SensitiveWord;
import com.lsp.website.service.WwzService;
import com.mongodb.DBObject;
import com.mongodb.util.JSON;
/**
 * 加盟管理
 * 
 * @author lsp
 * 
 */
@Namespace("/set")
@Results({ @Result(name = JoininAction.RELOAD, location = "joinin.action",params={"fypage", "%{fypage}"},  type = "redirect") })
public class JoininAction extends GeneralAction<Joinin>{
	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private MongoSequence mongoSequence;
	private Joinin entity = new Joinin();
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
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject> list = baseDao.getList(PubConstants.SET_JOININ,whereMap,fypage,10,sortMap);
		for (DBObject dbObject : list) {
			dbObject.put("nickname", wwzservice.getCustName(dbObject.get("custid").toString()));
		}
		fycount=baseDao.getCount(PubConstants.SET_JOININ, whereMap);
		Struts2Utils.getRequest().setAttribute("list", list);
		
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		try {
			custid=SpringSecurityUtils.getCurrentUser().getId();
			baseDao.delete(PubConstants.SET_JOININ, _id);
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
		DBObject db = baseDao.getMessage(PubConstants.SET_JOININ, _id);
		
		String json = JSONArray.fromObject(db).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}


	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			// 有custId查出来 用户信息
			entity = (Joinin)UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.SET_JOININ,_id),Price.class);
			
		} else {
			entity = new Joinin();
		}
	}

	@Override
	public String save() throws Exception {
		// 注册业务逻辑
		try {
			if(_id==null){
				_id=mongoSequence.currval(PubConstants.SET_JOININ);
			} 
			entity.set_id(_id);
			entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
			entity.setCreatedate(new Date());
			baseDao.insert(PubConstants.SET_JOININ, entity); 
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		return RELOAD;
	}
	 
	@Override
	public Joinin getModel() {
		return entity;
	}

	public void set_id(Long _id) {
		this._id = _id;
	}
	public String  webadd(){
		getLscode();
		Struts2Utils.getRequest().setAttribute("custid", custid);
		return "webadd";
		
	}
	public void  ajaxwebadd(){
		getLscode(); 
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		Joinin  join=new Joinin();
		join.set_id(mongoSequence.currval(PubConstants.SET_JOININ));
		join.setCreatedate(new Date());
		join.setCustid(custid);
		join.setFromUserid(fromUserid);
		join.setName(Struts2Utils.getParameter("name"));
		join.setState(0);
		join.setAddress(Struts2Utils.getParameter("address"));
		join.setSummary(Struts2Utils.getParameter("summary"));
		join.setTel(Struts2Utils.getParameter("tel"));
		baseDao.insert(PubConstants.SET_JOININ, join);
		sub_map.put("state",0);
		String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1),
				new String[0]); 
	}
	public void  updstate(){
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		DBObject  obj=baseDao.getMessage(PubConstants.SET_JOININ, _id);
		if(obj!=null){
			Joinin  join=(Joinin) UniObject.DBObjectToObject(obj, Joinin.class);
			join.set_id(_id);
			join.setState(Integer.parseInt(Struts2Utils.getParameter("state")));
			baseDao.insert(PubConstants.SET_JOININ, join);
			sub_map.put("state", 0);
		}
		String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]); 
	}
	 
}
