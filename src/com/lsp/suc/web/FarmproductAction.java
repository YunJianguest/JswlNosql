package com.lsp.suc.web; 
import java.util.Date;
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
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction; 
import com.lsp.suc.entity.FarmProduct;
import com.lsp.suc.entity.FarmProps; 
import com.lsp.website.service.WwzService; 
import com.mongodb.DBObject; 
 
/**
 * 农产品管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name ="reload", location = "farmproduct.action",params={"fypage","%{fypage}"}, type = "redirect") })
public class FarmproductAction extends GeneralAction<FarmProduct>{

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
	
	private FarmProduct entity=new FarmProduct();
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
		backMap.put("content", 0);
		List<DBObject> list=baseDao.getList(PubConstants.SUC_FARMPRODUCT,whereMap,fypage,10,sortMap,backMap);
		fycount=baseDao.getCount(PubConstants.SUC_FARMPRODUCT);
		Struts2Utils.getRequest().setAttribute("list", list);
		Struts2Utils.getRequest().setAttribute("custid", custid); 
		return SUCCESS;
	}


	@Override
	public FarmProduct getModel() {
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
		Struts2Utils.getRequest().setAttribute("entity",baseDao.getMessage(PubConstants.SUC_FARMPRODUCT, _id));
		return "add";
	}
	public void upd() throws Exception { 
		DBObject db = baseDao.getMessage(PubConstants.SUC_FARMPRODUCT, _id);   
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}


	@Override
	public String save() throws Exception {
 
		// TODO Auto-generated method stub
		try {
			if(_id==null){
				_id=mongoSequence.currval(PubConstants.SUC_FARMPRODUCT); 
			}  
			String custid=SpringSecurityUtils.getCurrentUser().getId(); 
			entity.set_id(_id); 
			entity.setCustid(custid); 
			entity.setCreatedate(new Date()); 
			entity.setStartdate(DateFormat.getFormat(Struts2Utils.getParameter("startdate")+":00"));
			entity.setEnddate(DateFormat.getFormat(Struts2Utils.getParameter("enddate")+":00"));
			entity.setStartdjdate(DateFormat.getFormat(Struts2Utils.getParameter("startdjdate")+":00"));
			entity.setEnddjdate(DateFormat.getFormat(Struts2Utils.getParameter("enddjdate")+":00")); 
			
			baseDao.insert(PubConstants.SUC_FARMPRODUCT, entity);
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
		String custid=SpringSecurityUtils.getCurrentUser().getId();
		HashMap<String,Object>whereMap=new HashMap<String, Object>();
		whereMap.put("_id", _id);
		whereMap.put("custid",custid);
		baseDao.delete(PubConstants.SUC_FARMPRODUCT, whereMap);
		return RELOAD;
	}


	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id!=null){
				DBObject db=baseDao.getMessage(PubConstants.SUC_FARMPRODUCT, _id);
				entity= (FarmProduct) UniObject.DBObjectToObject(db, FarmProduct.class);
			}else{
				entity=new FarmProduct();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	 	
	}
	public void set_id(Long _id) {
		this._id = _id;
	}
    public  String  web(){
		return "web"; 
    }  

}
