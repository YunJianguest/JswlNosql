package com.lsp.suc.web;
 
import java.util.Date;
import java.util.HashMap;
import java.util.List; 
import java.util.regex.Pattern;
 
import net.sf.json.JSONObject;

import org.apache.activemq.filter.function.splitFunction;
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
import com.lsp.suc.entity.MemorialTributeType; 
import com.mongodb.DBObject;
 
/**
 * 祭奠贡品栏目管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name = MemorialtributetypeAction.RELOAD, location = "memorialtributetype.action",params={"fypage", "%{fypage}"}, type = "redirect") })
public class MemorialtributetypeAction extends GeneralAction<MemorialTributeType> {

	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private MongoSequence mongoSequence;	
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	} 
	private MemorialTributeType entity=new MemorialTributeType();
	private Long _id;


	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		HashMap<String, Object> backMap =new HashMap<String, Object>(); 
		String custid=SpringSecurityUtils.getCurrentUser().getId(); 
		String title=Struts2Utils.getParameter("title");
		if(!StringUtils.isEmpty(title)){
			Pattern pattern = Pattern.compile("^.*" + title + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern);
		}
		whereMap.put("custid", custid);
		sortMap.put("sort", -1);
		fycount=baseDao.getCount(PubConstants.MEMORIAL_TRIBUTETYPE, whereMap);
		
		if(Struts2Utils.getParameter("fypage")!=null){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		} 
		List<DBObject> list=baseDao.getList(PubConstants.MEMORIAL_TRIBUTETYPE,whereMap,fypage,10, sortMap,backMap);
		Struts2Utils.getRequest().setAttribute("list", list);
		Struts2Utils.getRequest().setAttribute("custid", custid);
		return SUCCESS;
	}
	

	@Override
	public String delete() throws Exception {
		try {
			custid=SpringSecurityUtils.getCurrentUser().getId();
			baseDao.delete(PubConstants.MEMORIAL_TRIBUTETYPE,_id);
			addActionMessage("成功删除!");
			
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
		return "add";
	}
	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			//有custId查出来 用户信息
			entity = (MemorialTributeType)UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.MEMORIAL_TRIBUTETYPE,_id),MemorialTributeType.class);
		} else {
			entity = new MemorialTributeType();
		}
	}
	public void  upd(){ 
		DBObject db=baseDao.getMessage(PubConstants.MEMORIAL_TRIBUTETYPE, _id); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
		
	}
	
	@Override
	public String save() throws Exception {
		//注册业务逻辑
		try {
			if(_id == null){
				_id=mongoSequence.currval(PubConstants.MEMORIAL_TRIBUTETYPE);	
			}
			entity.set_id(_id);
			entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
			entity.setCreatedate(new Date());
			baseDao.insert(PubConstants.MEMORIAL_TRIBUTETYPE,entity);
			
			
			addActionMessage("成功添加!");
			
		
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return RELOAD;
	} 
	@Override
	public MemorialTributeType getModel() {
		return entity;
	}
	public void set_id(Long _id) {
		this._id = _id;
	}
	 
}


