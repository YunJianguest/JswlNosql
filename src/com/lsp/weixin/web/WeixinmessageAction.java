package com.lsp.weixin.web;

import java.util.HashMap;
import java.util.List;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

 
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.entity.WeiXinMessage;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction;
import com.mongodb.DBObject;
 
/***
 * 资源管理
 * @author lsp
 *
 */
@Namespace("/weixin")
@Results( { @Result(name = WeixinmessageAction.RELOAD, location = "weixinmessage.action", type = "redirect") })
public class WeixinmessageAction extends GeneralAction<WeiXinMessage> {

	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private MongoSequence mongoSequence;	
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}

	private WeiXinMessage entity=new WeiXinMessage();
	private Long _id;


	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		whereMap.put("toUser", SpringSecurityUtils.getCurrentUser().getToUser());
		sortMap.put("sort", 1);
		List<DBObject> list=baseDao.getList(PubConstants.PUB_WEIXINMESSAGE,whereMap,0,100, sortMap);
		Struts2Utils.getRequest().setAttribute("WinXinMessageList", list);
		return SUCCESS;
	}
	
	
	@Override
	public String delete() throws Exception {
		try {
			baseDao.delete(PubConstants.PUB_WEIXINMESSAGE,_id);
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
			entity = (WeiXinMessage)UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.PUB_WEIXINMESSAGE,_id),WeiXinMessage.class);
		} else {
			entity = new WeiXinMessage();
		}
	}
	
	

	@Override
	public String save() throws Exception {
		//注册业务逻辑
		try {
			if(_id == null){
				_id=mongoSequence.currval(PubConstants.PUB_WEIXINMESSAGE);	
			}
			entity.set_id(_id);
			entity.setToUser(SpringSecurityUtils.getCurrentUser().getToUser());
			baseDao.insert(PubConstants.PUB_WEIXINMESSAGE, entity);
			addActionMessage("成功添加!");
	
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return RELOAD;
	}

	@Override
	public WeiXinMessage getModel() {
		return entity;
	}
	public void set_id(Long _id) {
		this._id = _id;
	}
}
