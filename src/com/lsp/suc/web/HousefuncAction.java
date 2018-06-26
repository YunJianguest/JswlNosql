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
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.MarkerHtml;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction;
import com.lsp.suc.entity.CompanyInfo;
import com.lsp.suc.entity.HouseFunc;
import com.lsp.website.service.WwzService;
import com.mongodb.DBObject;

/**
 * 城市菜单
 * @author lsp
 *
 */
@Namespace("/suc")
@Results({@org.apache.struts2.convention.annotation.Result(name="reload", location="housefunc.action",params={"parentid", "%{parentid}","fypage","%{fypage}"},  type="redirect")})
public class HousefuncAction extends GeneralAction<HouseFunc>{


	private static final long serialVersionUID = -6784469775589971579L;

	  @Autowired
	  private BaseDao basedao;
	  private Long _id;
	  private HouseFunc entity = new HouseFunc();
	  private MongoSequence mongoSequence;
	  @Autowired
	  private WwzService wwzService;
	  @Autowired
	  public void setMongoSequence(MongoSequence mongoSequence)
	  {
	    this.mongoSequence = mongoSequence;
	  }
	  public void set_id(Long _id) {
	    this._id = _id;
	  }
	  @Override
	  public String execute() throws Exception {
		  
		    HashMap<String, Object> sortMap =new HashMap<String, Object>();
			HashMap<String, Object> whereMap =new HashMap<String, Object>();
			HashMap<String, Object> backMap =new HashMap<String, Object>();
			
			custid=SpringSecurityUtils.getCurrentUser().getId();
			sortMap.put("sort", -1); 
			String parentid=Struts2Utils.getParameter("parentid"); 
			if(StringUtils.isNotEmpty(parentid)){
				whereMap.put("parentid", Long.parseLong(parentid));
			}
			String name=Struts2Utils.getParameter("name");
			if(StringUtils.isNotEmpty(name)){
				Pattern pattern = Pattern.compile("^.*" + name + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("content", pattern);
				Struts2Utils.getRequest().setAttribute("name",  name);
			} 
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			
			List<DBObject> list=basedao.getList(PubConstants.SUC_HOUSEFUNC,whereMap,fypage,10,sortMap,backMap);
			fycount=basedao.getCount(PubConstants.SUC_HOUSEFUNC,whereMap);
			Struts2Utils.getRequest().setAttribute("list", list);
			Struts2Utils.getRequest().setAttribute("custid", custid);
			
		  return SUCCESS;
	  }
	@Override
	public String input() throws Exception {
		// TODO Auto-generated method stub
		return "add";
	}

	@Override
	public String update() throws Exception {
		// TODO Auto-generated method stub
		return "add";
	}

	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id==null){
				_id=mongoSequence.currval(PubConstants.SUC_HOUSEFUNC);
			} 
			entity.set_id(_id);
			entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
			entity.setCreatedate(new Date());  
			basedao.insert(PubConstants.SUC_HOUSEFUNC, entity);
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
				basedao.delete(PubConstants.SUC_HOUSEFUNC,_id);
				Struts2Utils.getRequest().setAttribute("parentid",Struts2Utils.getParameter("parentid"));
				addActionMessage("删除成功");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			addActionMessage("删除失败");
		}
		return RELOAD;
	}
	@Override
	public HouseFunc getModel() {
		// TODO Auto-generated method stub
		return entity;
	}
	public String deleteAll() throws Exception {
		// TODO Auto-generated method stub
		try {
			 
				basedao.delete(PubConstants.SUC_HOUSEFUNC);
				System.out.println("ddd");
				addActionMessage("删除成功");
			 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			addActionMessage("删除失败");
		}
		return RELOAD;
	}

	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		
		try {
			if(_id!=null){
				DBObject db=basedao.getMessage(PubConstants.SUC_HOUSEFUNC, _id);
				entity= (HouseFunc) UniObject.DBObjectToObject(db, HouseFunc.class);
			}else{
				entity=new HouseFunc();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}
	public void  upd(){
		String id=Struts2Utils.getParameter("id"); 
		DBObject db=basedao.getMessage(PubConstants.SUC_HOUSEFUNC, Long.parseLong(id)); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
		
	}
	/**
	 * 生成菜单
	 */
	public  void   create()throws Exception{
		String parentid=Struts2Utils.getParameter("parentid");
		Map<String, Object> sub_map = new HashMap<String, Object>();
		if(StringUtils.isNotEmpty(parentid)){
		
			CompanyInfo  com=(CompanyInfo)UniObject.DBObjectToObject(basedao.getMessage(PubConstants.WX_COMPANY, Long.parseLong(parentid)), CompanyInfo.class);
			if(com!=null){
				MarkerHtml  mh=new MarkerHtml();
				mh.house(Long.parseLong(parentid));
				com.setUrl(SysConfig.getProperty("ip")+"/marker/house/house"+parentid+".html");
				basedao.insert(PubConstants.WX_COMPANY, com);
				sub_map.put("state", 0);
				sub_map.put("value",SysConfig.getProperty("ip")+"/marker/house/house"+parentid+".html");
			}
		}
		String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);
	}
	 
}
