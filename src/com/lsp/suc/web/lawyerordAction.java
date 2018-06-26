package com.lsp.suc.web;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction; 
import com.lsp.suc.entity.LawyerInfo;
import com.lsp.suc.entity.LawyerOrder;
import com.lsp.website.service.WwzService;
import com.mongodb.DBObject;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject; 
@Namespace("/suc")
@Results( { @Result(name = lawyerordAction.RELOAD, location = "lawyerord.action",params={"fypage", "%{fypage}","lid", "%{lid}","gid", "%{gid}"}, type = "redirect") })
public class lawyerordAction extends GeneralAction<LawyerOrder>{
 
	private static final long serialVersionUID = -6784469775589971579L;

	@Autowired
	private BaseDao baseDao;
	private MongoSequence mongoSequence;	
	
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}
	@Autowired
	private WwzService wwzService; 
	private LawyerOrder entity=new LawyerOrder();
	private Long _id;
	@Override
	public String execute() throws Exception {
		HashMap<String,Object>whereMap=new HashMap<>();
		HashMap<String,Object>sortMap=new HashMap<>();
		custid=SpringSecurityUtils.getCurrentUser().getId();
		whereMap.put("custid",custid);
		sortMap.put("createdate",-1);
		if (StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))) {
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		if (StringUtils.isNotEmpty(Struts2Utils.getParameter("lid"))) {
			whereMap.put("lid",Long.parseLong(Struts2Utils.getParameter("lid")));
		}
		if (StringUtils.isNotEmpty(Struts2Utils.getParameter("gid"))) {
			whereMap.put("gid",Long.parseLong(Struts2Utils.getParameter("gid")));
		}
		List<DBObject>list=baseDao.getList(PubConstants.SUC_LAWYERORD, whereMap,fypage,10,sortMap);
		if (list.size()>0) {
			Struts2Utils.getRequest().setAttribute("list", list);
		}
		fycount=baseDao.getCount(PubConstants.SUC_LAWYERORD, whereMap);
		return SUCCESS; 
	}
	
	@Override
	public LawyerOrder getModel() {
		// TODO Auto-generated method stub
		return entity;
	}

	@Override
	public String input() throws Exception {
		// TODO Auto-generated method stub
		return "add";
	}

	@Override
	public String update() throws Exception {
		// TODO Auto-generated method stubr
		DBObject dbObject=baseDao.getMessage(PubConstants.SUC_LAWYERORD, _id);
		Struts2Utils.getRequest().setAttribute("entity",dbObject);
		return RELOAD;
	}

	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		if (_id==null) {
			_id=mongoSequence.currval(PubConstants.SUC_LAWYERORD);
		}
		entity.set_id(_id);
		entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
		entity.setCreatedate(new Date());
		baseDao.insert(PubConstants.SUC_LAWYERORD, entity);
		return RELOAD;
	}

	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		return RELOAD;
	}
	public void upd() throws Exception { 
		DBObject db = baseDao.getMessage(PubConstants.SUC_LAWYERORD, _id); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}

	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		if (_id != null) {
			//有custId查出来 用户信息
			entity = (LawyerOrder)UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.SUC_LAWYERORD,_id),LawyerOrder.class);
		} else {
			entity = new LawyerOrder();
		}
	}
	 
}
