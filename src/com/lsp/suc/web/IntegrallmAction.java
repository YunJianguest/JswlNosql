package com.lsp.suc.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

 
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction;
import com.lsp.suc.entity.IntegralInfo;
import com.lsp.suc.entity.Integrallm;
import com.lsp.suc.entity.Tourism;
import com.lsp.website.entity.CommentInfo;
import com.lsp.website.service.WebsiteService;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;

/**
 * 积分栏目管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name ="reload", location = "integrallm.action", type = "redirect") })
public class IntegrallmAction  extends GeneralAction<Integrallm>{

	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private MongoSequence mongoSequence;	
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}
	@Autowired
	private WebsiteService webService;
	
	private Integrallm entity=new Integrallm();
	private Long _id;


	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		HashMap<String, Object> backMap =new HashMap<String, Object>();
		
		toUser=SpringSecurityUtils.getCurrentUser().getToUser();
		sortMap.put("sort", -1); 
		whereMap.put("toUser", toUser);
		String title=Struts2Utils.getParameter("title");
		if(StringUtils.isNotEmpty(title)){
			Pattern pattern = Pattern.compile("^.*" + title + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern);
			Struts2Utils.getRequest().setAttribute("title",  title);
		}
	 
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		
		List<DBObject> list=baseDao.getList(PubConstants.INTEGRALM,whereMap,fypage,10,sortMap,backMap);
		fycount=baseDao.getCount(PubConstants.INTEGRALM);
		Struts2Utils.getRequest().setAttribute("integrallmList", list);
		Struts2Utils.getRequest().setAttribute("toUser", toUser);
		
		return SUCCESS;
	}


	@Override
	public Integrallm getModel() {
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
	 
		return "add";
	}
	public void upd() throws Exception {  
		DBObject db = baseDao.getMessage(PubConstants.INTEGRALM,_id); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}


	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id==null){
				_id=mongoSequence.currval(PubConstants.TOURISM_INFRO);
			} 
			String toUser=Struts2Utils.getParameter("toUser");  
			entity.set_id(_id);
			entity.setToUser(toUser);
			entity.setCreatedate(new Date());
			baseDao.insert(PubConstants.INTEGRAL_INFO, entity);
			addActionMessage("添加成功");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			addActionMessage("添加失败");
		}
		return RELOAD;
	}


	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub 
		try {
			if(_id!=null){
				baseDao.delete(PubConstants.INTEGRALM, _id);
			}
			addActionMessage("删除成功！");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			addActionMessage("删除失败！");
			e.printStackTrace();
		}
		return RELOAD;
	}


	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id!=null){
				DBObject db=baseDao.getMessage(PubConstants.INTEGRALM, _id);
				entity= (Integrallm) UniObject.DBObjectToObject(db, Integrallm.class);
			}else{
				entity=new Integrallm();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	 	
	}
	public void set_id(Long _id) {
		this._id = _id;
	}
   
	 
 
	
}
