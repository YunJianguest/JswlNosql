package com.lsp.weixin.web;

import java.util.HashMap;
import java.util.List;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

 
import com.alibaba.fastjson.JSON;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.web.GeneralAction;
import com.lsp.weixin.entity.WxTicket;
import com.mongodb.DBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
@Namespace("/weixin")
@Results({ @Result(name = WxticketAction.RELOAD, location = "wxticket.action", params = {"fypage", "%{fypage}" }, type = "redirect") })
public class WxticketAction extends GeneralAction<WxTicket> {
	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private WxTicket entity = new WxTicket();;
	private int _id;

	private MongoSequence mongoSequence;

	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}

	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		sortMap.put("_id", 1);
		
		
		whereMap.put("toUser", SpringSecurityUtils.getCurrentUser().getToUser());
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject> list = baseDao.getList(PubConstants.WEIXIN_TICKET,whereMap,fypage,10, sortMap);
		Struts2Utils.getRequest().setAttribute("ticketList", list);
	
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		try {
			
			baseDao.delete(PubConstants.WEIXIN_TICKET, _id);
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
		Struts2Utils.getRequest().setAttribute("parentid",
				Struts2Utils.getParameter("parentid"));
		DBObject db = baseDao.getMessage(PubConstants.WEIXIN_TICKET, _id);

		entity = JSON.parseObject(db.toString(), WxTicket.class);
		entity.set_id((Long) db.get("_id"));
		return "add";
	}
	public void upd() throws Exception {
		DBObject db = baseDao.getMessage(PubConstants.WEIXIN_TICKET, _id);
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}
	@Override
	protected void prepareModel() throws Exception {
		if (_id ==0) {
			// 有custId查出来 用户信息
			DBObject db = baseDao.getMessage(PubConstants.WEIXIN_TICKET, _id);

			entity = JSON.parseObject(db.toString(), WxTicket.class);
			entity.set_id((Long) db.get("_id"));
		} else {
			entity = new WxTicket();
		}
	}

	@Override
	public String save() throws Exception {
		// 注册业务逻辑
		try {
			toUser=SpringSecurityUtils.getCurrentUser().getToUser();
			if (_id == 0) {
				_id = Integer.parseInt(mongoSequence.currval(PubConstants.WEIXIN_TICKET+toUser).toString());
				HashMap<String, Object> whereMap = new HashMap<String, Object>();
				whereMap.put("_id", _id);
				whereMap.put("toUser", toUser);
				long count=1;
				while(count>0){
					count=baseDao.getCount(PubConstants.WEIXIN_TICKET,whereMap);
					_id = Integer.parseInt(mongoSequence.currval(PubConstants.WEIXIN_TICKET+toUser).toString());
				}
			}
			
			entity.set_id(_id);
			entity.setToUser(SpringSecurityUtils.getCurrentUser().getToUser());
			baseDao.insert(PubConstants.WEIXIN_TICKET, entity);
			
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		return RELOAD;
	}
	public String scurl() throws Exception {
		// 注册业务逻辑
		try {
			toUser=SpringSecurityUtils.getCurrentUser().getToUser();
			
			com.alibaba.fastjson.JSONObject object=WeiXinUtil.getTicket(WeiXinUtil.getTokenByToUser(toUser).getAccess_token(), String.valueOf(_id));
			DBObject db = baseDao.getMessage(PubConstants.WEIXIN_TICKET, _id);

			entity = JSON.parseObject(db.toString(), WxTicket.class);

			entity.set_id(_id);
			entity.setUrl(object.getString("url"));
			entity.setTicket(object.getString("ticket"));
			baseDao.insert(PubConstants.WEIXIN_TICKET, entity);
			
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		return RELOAD;
	}

	@Override
	public WxTicket getModel() {
		return entity;
	}

	public void set_id(int _id) {
		this._id = _id;
	}
}
