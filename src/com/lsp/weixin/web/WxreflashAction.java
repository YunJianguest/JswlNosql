package com.lsp.weixin.web;

import java.util.Date;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

 
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction;
import com.lsp.weixin.entity.WxReflash;
import com.mongodb.DBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
@Namespace("/weixin")
@Results( { @Result(name = WxreflashAction.RELOAD, location = "wxreflash.action",params={"_id", "%{_id}"}, type = "redirect") })
public class WxreflashAction extends GeneralAction<WxReflash> {

	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	
	
	private WxReflash entity=new WxReflash();
	private String _id;


	@Override
	public String execute() throws Exception {
		
		_id=Struts2Utils.getParameter("_id");
		if(StringUtils.isEmpty(_id)){
			_id=SpringSecurityUtils.getCurrentUser().getToUser()+"_1";	
		}
		DBObject db=baseDao.getMessage(PubConstants.WX_REFLASH,_id);
		
		Struts2Utils.getRequest().setAttribute("toUser",SpringSecurityUtils.getCurrentUser().getToUser());
		Struts2Utils.getRequest().setAttribute("entity", db);
		Struts2Utils.getRequest().setAttribute("_id", _id);
		return SUCCESS;
	}
	

	@Override
	public String delete() throws Exception {
		try {
			baseDao.delete(PubConstants.WX_REFLASH,_id);
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
			entity = (WxReflash)UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.WX_REFLASH,_id),WxReflash.class);
		} else {
			entity = new WxReflash();
		}
	}
	
	

	@Override
	public String save() throws Exception {
		//注册业务逻辑
		try {
				entity.set_id(_id);
				entity.setToUser(SpringSecurityUtils.getCurrentUser().getToUser());
				entity.setCreatdate(new Date());
				baseDao.insert(PubConstants.WX_REFLASH, entity);
				addActionMessage("成功添加!");
			
		
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return RELOAD;
	}

	@Override
	public WxReflash getModel() {
		return entity;
	}
	public void set_id(String _id) {
		this._id = _id;
	}
}


