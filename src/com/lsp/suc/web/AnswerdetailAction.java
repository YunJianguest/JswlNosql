package com.lsp.suc.web;

import java.util.HashMap;
import java.util.List;
import java.util.regex.Pattern;

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
import com.lsp.suc.entity.AnswerDetail;
import com.mongodb.DBObject;
 
/**
 * 答题答案管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name = AnswerdetailAction.RELOAD, location = "answerdetail.action",params={"wid", "%{wid}"}, type = "redirect") })
public class AnswerdetailAction extends GeneralAction<AnswerDetail> {

	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private MongoSequence mongoSequence;	
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}
	
	private AnswerDetail entity=new AnswerDetail();
	private Long _id;


	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		Long wid=Long.parseLong(Struts2Utils.getParameter("wid"));
		whereMap.put("wid", wid);
		
		String title=Struts2Utils.getParameter("title");
		if(!StringUtils.isEmpty(title)){
			Pattern pattern = Pattern.compile("^.*" + title + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("wt", pattern);
		}
		sortMap.put("sort", -1);
		fycount=baseDao.getCount(PubConstants.SUC_ANSREDETAIL, whereMap);
		
		if(Struts2Utils.getParameter("fypage")!=null){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject> list=baseDao.getList(PubConstants.SUC_ANSREDETAIL,whereMap,fypage,10, sortMap);
		Struts2Utils.getRequest().setAttribute("AnswerDetailList", list);
		return SUCCESS;
	}
	

	@Override
	public String delete() throws Exception {
		try {
			baseDao.delete(PubConstants.SUC_ANSREDETAIL,_id);
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
			entity = (AnswerDetail)UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.SUC_ANSREDETAIL,_id),AnswerDetail.class);
		} else {
			entity = new AnswerDetail();
		}
	}
	
	
	@Override
	public String save() throws Exception {
		//注册业务逻辑
		try {
			if(_id == null){
				_id=mongoSequence.currval(PubConstants.SUC_ANSREDETAIL);	
			}
			entity.set_id(_id);
			entity.setToUser(SpringSecurityUtils.getCurrentUser().getToUser());
			
			baseDao.insert(PubConstants.SUC_ANSREDETAIL,entity);
			
			
			addActionMessage("成功添加!");
			
		
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return RELOAD;
	}

	
	@Override
	public AnswerDetail getModel() {
		return entity;
	}
	public void set_id(Long _id) {
		this._id = _id;
	}
}


