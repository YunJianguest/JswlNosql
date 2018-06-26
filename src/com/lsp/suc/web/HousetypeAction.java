package com.lsp.suc.web;

import java.util.HashMap;
import java.util.List;
import java.util.regex.Pattern;

import net.sf.json.JSONObject;

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
import com.lsp.suc.entity.Bbstypeinfo;
import com.lsp.suc.entity.HouseType;
import com.lsp.website.service.WebsiteService;
import com.mongodb.DBObject;
/**
 * 企业分类管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name ="reload", location = "housetype.action", type = "redirect") })
public class HousetypeAction extends GeneralAction<HouseType>{


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
	
	private HouseType entity=new HouseType();
	private Long _id;


	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		HashMap<String, Object> backMap =new HashMap<String, Object>();
		
		custid=SpringSecurityUtils.getCurrentUser().getId();
		sortMap.put("sort", -1); 
		whereMap.put("custid", custid);
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
		
		List<DBObject> list=baseDao.getList(PubConstants.SUC_HOUSETYPE,whereMap,fypage,10,sortMap,backMap);
		fycount=baseDao.getCount(PubConstants.SUC_HOUSETYPE,whereMap);
		Struts2Utils.getRequest().setAttribute("comunittypeList", list);
		Struts2Utils.getRequest().setAttribute("custid", custid);
		
		return SUCCESS;
	}


	@Override
	public HouseType getModel() {
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
		DBObject db = baseDao.getMessage(PubConstants.SUC_HOUSETYPE, _id); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}


	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id==null){
				_id=mongoSequence.currval(PubConstants.SUC_HOUSETYPE); 
			} 
			String custid=SpringSecurityUtils.getCurrentUser().getId();  
			entity.set_id(_id);
			entity.setCustid(custid); 
			entity.setCoding(_id+""); 
			baseDao.insert(PubConstants.SUC_HOUSETYPE, entity);
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
			baseDao.delete(PubConstants.SUC_HOUSETYPE, _id);
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
				DBObject db=baseDao.getMessage(PubConstants.SUC_HOUSETYPE, _id);
				entity= (HouseType) UniObject.DBObjectToObject(db, HouseType.class);
			}else{
				entity=new HouseType();
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
