package com.lsp.suc.web;

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
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction;
import com.lsp.suc.entity.Bbsstick;
import com.lsp.suc.entity.Exceptional;
import com.lsp.suc.entity.IntegralInfo;
import com.lsp.website.service.WwzService;
import com.lsp.weixin.entity.WxUser;
import com.mongodb.DBObject;

/**
 * 打赏管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name ="reload", location = "exceptional.action", type = "redirect") })
public class ExceptionalAction extends GeneralAction<Exceptional>{

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
	
	private Exceptional entity=new Exceptional();
	private Long _id;


	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		HashMap<String, Object> backMap =new HashMap<String, Object>();
		
		custid=SpringSecurityUtils.getCurrentUser().getCustid();
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
		
		List<DBObject> list=baseDao.getList(PubConstants.SUC_EXCEPTIONAL,whereMap,fypage,10,sortMap,backMap);
		for (DBObject dbObject : list) {
			DBObject  wx=wwzService.getWxUser(dbObject.get("fromUserid").toString());
			dbObject.put("user", wx);
		}
		fycount=baseDao.getCount(PubConstants.SUC_EXCEPTIONAL,whereMap);
		Struts2Utils.getRequest().setAttribute("exceptionalList", list);
		Struts2Utils.getRequest().setAttribute("custid", custid);
		
		return SUCCESS;
	}


	@Override
	public Exceptional getModel() {
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
		DBObject db = baseDao.getMessage(PubConstants.SUC_EXCEPTIONAL, _id); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}


	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id==null){
				_id=mongoSequence.currval(PubConstants.SUC_EXCEPTIONAL); 
			}  
			String custid=SpringSecurityUtils.getCurrentUser().getId();
			
			entity.set_id(_id); 
			entity.setCustid(custid); 
			entity.setCreatedate(new Date());
			baseDao.insert(PubConstants.SUC_EXCEPTIONAL, entity);
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
		//String custid=SpringSecurityUtils.getCurrentUser().getId();
		//HashMap<String,Object>whereMap=new HashMap<String, Object>();
		//whereMap.put("_id", _id);
		//whereMap.put("custid",custid);
		//baseDao.delete(PubConstants.BBS_STICK, whereMap);
		return RELOAD;
	}


	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id!=null){
				DBObject db=baseDao.getMessage(PubConstants.SUC_EXCEPTIONAL, _id);
				entity= (Exceptional) UniObject.DBObjectToObject(db, Exceptional.class);
			}else{
				entity=new Exceptional();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	 	
	}
	public void set_id(Long _id) {
		this._id = _id;
	}
	/**
	 * ajax打赏
	 */
	public void  ajaxAdd(){
		getLscode(); 
		DBObject user=wwzService.getWxUser(fromUserid);
		Map<String, Object>submap=new HashMap<String, Object>();
		try {
			if(user.get("_id").toString().equals("notlogin")){
				//未登录
				
			}else{
				//打赏
				String  type=Struts2Utils.getParameter("type");
				String  price=Struts2Utils.getParameter("price");
				String  toUserid=Struts2Utils.getParameter("toUserid");
				Exceptional  exc=new Exceptional();
				exc.set_id(mongoSequence.currval(PubConstants.SUC_EXCEPTIONAL));
				exc.setCreatedate(new Date());
				exc.setFromUserid(fromUserid);
				exc.setPrice(Integer.parseInt(price));
				exc.setType(type);
				exc.setToUserid(toUserid);
				baseDao.insert(PubConstants.SUC_EXCEPTIONAL, exc);
				//结算
				wwzService.deljf(price, fromUserid,"excep", custid,user); 
				wwzService.addjf(price, toUserid,"excep", custid,wwzService.getWxUser(toUserid)); 
				submap.put("state",0);
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			submap.put("state",1);
			e.printStackTrace();
		}
		
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);	
		
	}
     

}
