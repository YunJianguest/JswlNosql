package com.lsp.weixin.web;

import java.util.HashMap;
import java.util.List;
import java.util.regex.Pattern;

import net.sf.json.JSONObject;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

 
import com.alibaba.fastjson.JSON;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.entity.WxToken;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.web.GeneralAction;
import com.lsp.website.service.WwzService;
import com.lsp.weixin.entity.ButtonSm;
import com.mongodb.DBObject;
 
/***
 * 资源管理
 * @author lsp
 *
 */
@Namespace("/weixin")
@Results({ @Result(name = ButtonsmAction.RELOAD, location = "buttonsm.action", params = { }, type = "redirect") })
public class ButtonsmAction extends GeneralAction<ButtonSm> {
	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private ButtonSm entity = new ButtonSm();;
	private Long _id;
	
	private MongoSequence mongoSequence;

	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}
	@Autowired
	private WwzService wwzService;
	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		sortMap.put("sort", -1);
		
		toUser=SpringSecurityUtils.getCurrentUser().getToUser();
		Struts2Utils.getRequest().setAttribute("toUser", toUser);
		whereMap.put("toUser", toUser);
	
		List<DBObject> list = baseDao.getList(PubConstants.WX_BUTTONSM,whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("printList", list);
		
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		try {
		
			baseDao.delete(PubConstants.WX_BUTTONSM, _id);
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
		
		DBObject db = baseDao.getMessage(PubConstants.WX_BUTTONSM, _id);

		entity = JSON.parseObject(db.toString(), ButtonSm.class);
		entity.set_id((Long) db.get("_id"));
		return "add";
	}
	public void upd() throws Exception {
		DBObject db = baseDao.getMessage(PubConstants.WX_BUTTONSM, _id);
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}
	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			// 有custId查出来 用户信息
			DBObject db = baseDao.getMessage(PubConstants.WX_BUTTONSM, _id);

			entity = JSON.parseObject(db.toString(), ButtonSm.class);
			entity.set_id((Long) db.get("_id"));
		} else {
			entity = new ButtonSm();
		}
	}

	@Override
	public String save() throws Exception {
		// 注册业务逻辑
		try {
			if(_id == null){
				_id=mongoSequence.currval(PubConstants.WX_BUTTONSM);	
			}
			entity.set_id(_id);
			
			entity.setToUser(SpringSecurityUtils.getCurrentUser().getToUser());
			baseDao.insert(PubConstants.WX_BUTTONSM, entity);
			
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		return RELOAD;
	}
	/**
	 * 主页面
	 * 
	 * @return
	 * @throws Exception
	 */
	public String web() throws Exception { 
		WxToken token=WeiXinUtil.getSignature(toUser,Struts2Utils.getRequest());
		Struts2Utils.getRequest().setAttribute("token", token);
	
		HashMap<String, Object> whereMap=new HashMap<String, Object>();
		HashMap<String, Object> sortMap=new HashMap<String, Object>();
		sortMap.put("sort", -1);
		whereMap.put("toUser", toUser);
		
		List<DBObject> list = baseDao.getList(PubConstants.WX_BUTTONSM,whereMap, sortMap);
		
		Struts2Utils.getRequest().setAttribute("list", list);
		
		
		DBObject fx=wwzService.getShareFx(toUser, "rukou");
		Struts2Utils.getRequest().setAttribute("fx", fx);
		
		return "web";
	}
	@Override
	public ButtonSm getModel() {
		return entity;
	}

	public void set_id(Long _id) {
		this._id = _id;
	}
}
