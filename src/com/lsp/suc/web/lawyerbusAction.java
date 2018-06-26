package com.lsp.suc.web;
 
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.lsp.suc.entity.LawyerBusiness; 
import com.lsp.website.service.WwzService;
import com.mongodb.DBObject; 
import net.sf.json.JSONObject; 
@Namespace("/suc")
@Results( { @Result(name = lawyerbusAction.RELOAD, location = "lawyerbus.action",params={"fypage", "%{fypage}","lid", "%{lid}"}, type = "redirect") })
public class lawyerbusAction extends GeneralAction<LawyerBusiness>{
 
	private static final long serialVersionUID = -6784469775589971579L;

	@Autowired
	private BaseDao baseDao;
	private MongoSequence mongoSequence;	
	
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	} 
	private LawyerBusiness entity=new LawyerBusiness();
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
			whereMap.put("lid", Long.parseLong(Struts2Utils.getParameter("lid")));
		}else{ 
			//屏蔽默认数据
			whereMap.put("lid",null);
		}  
		List<DBObject>list=baseDao.getList(PubConstants.SUC_LAWYERBUS, whereMap,fypage,10,sortMap);
		if (list.size()>0) {
			Struts2Utils.getRequest().setAttribute("list", list);
		}
		fycount=baseDao.getCount(PubConstants.SUC_LAWYERBUS, whereMap);
		return SUCCESS; 
	}
	
	@Override
	public LawyerBusiness getModel() {
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
		DBObject dbObject=baseDao.getMessage(PubConstants.SUC_LAWYERBUS, _id);
		Struts2Utils.getRequest().setAttribute("entity",dbObject);
		return RELOAD;
	}

	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		if (_id==null) {
			_id=mongoSequence.currval(PubConstants.SUC_LAWYERBUS);
		}
		entity.set_id(_id);
		entity.setCustid(SpringSecurityUtils.getCurrentUser().getId()); 
		baseDao.insert(PubConstants.SUC_LAWYERBUS, entity);
		return RELOAD;
	}

	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		return RELOAD;
	}
	public void upd() throws Exception { 
		DBObject db = baseDao.getMessage(PubConstants.SUC_LAWYERBUS, _id); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}

	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		if (_id != null) {
			//有custId查出来 用户信息
			entity = (LawyerBusiness)UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.SUC_LAWYERBUS,_id),LawyerBusiness.class);
		} else {
			entity = new LawyerBusiness();
		}
	} 
	public void set_id(Long _id) {
		this._id = _id;
	}
	 
}
