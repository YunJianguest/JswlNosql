package com.lsp.weixin.web;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

 
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.web.GeneralAction;
import com.lsp.weixin.entity.WxSendMessage;
import com.mongodb.DBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
@Namespace("/weixin")
@Results( { @Result(name = WxsendmessageAction.RELOAD, location = "wxsendmessage.action",params={"wid", "%{wid}"}, type = "redirect") })
public class WxsendmessageAction extends GeneralAction<WxSendMessage> {

	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private MongoSequence mongoSequence;	
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}
	
	private WxSendMessage entity=new WxSendMessage();
	private Long _id;


	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		String wid=Struts2Utils.getParameter("wid");
		whereMap.put("toUser",SpringSecurityUtils.getCurrentUser().getToUser());
		whereMap.put("wid", Long.parseLong(wid));
		sortMap.put("sort", 1);
		List<DBObject> list=baseDao.getList(PubConstants.WX_SENDMESSAGE,whereMap,0,10, sortMap);
		Struts2Utils.getRequest().setAttribute("WxSendMessageList", list);
		Struts2Utils.getRequest().setAttribute("wid", wid);
		return SUCCESS;
	}
	

	@Override
	public String delete() throws Exception {
		try {
			baseDao.delete(PubConstants.WX_SENDMESSAGE,_id);
			addActionMessage("成功删除!");
			String wid=Struts2Utils.getParameter("wid");
			Struts2Utils.getRequest().setAttribute("wid",wid);
			
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,删除过程中出现异常!");
		}
		return RELOAD;
	}
 
	@Override
	public String input() throws Exception {
		
		String wid=Struts2Utils.getParameter("wid");
		Struts2Utils.getRequest().setAttribute("wid", wid);
		return "add";
	}
	
	@Override
	public String update() throws Exception {	
		
		String wid=Struts2Utils.getParameter("wid");
		Struts2Utils.getRequest().setAttribute("wid", wid);
		return "add";
	}
	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			//有custId查出来 用户信息
			entity = (WxSendMessage)UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.WX_SENDMESSAGE,_id),WxSendMessage.class);
		} else {
			entity = new WxSendMessage();
		}
	}
	
	

	@Override
	public String save() throws Exception {
		//注册业务逻辑
		String wid=Struts2Utils.getParameter("wid");
		try {
			if(_id == null){
				_id=mongoSequence.currval(PubConstants.WX_SENDMESSAGE);	
			}
			String toUser=SpringSecurityUtils.getCurrentUser().getToUser();
 
			String access_token=WeiXinUtil.getTokenByToUser(toUser).getAccess_token();
			String filePath=SysConfig.getProperty("filePath")+entity.getPicurl();
			String media_id=WeiXinUtil.uploadFile(access_token,filePath,"images");
			entity.set_id(_id);
			entity.setMedia_id(media_id);
			entity.setCreatdate(new Date());
			entity.setToUser(SpringSecurityUtils.getCurrentUser().getToUser());
			entity.setWid(Long.parseLong(wid));
			entity.setUrl(SysConfig.getProperty("ip")+"/wwz/wwz!index.action?toUser="+toUser+"&fromUser=fromUserData");
			baseDao.insert(PubConstants.WX_SENDMESSAGE,entity);
			
			Struts2Utils.getRequest().setAttribute("wid", wid);
			addActionMessage("成功添加!");
			
		
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return RELOAD;
	}

	@Override
	public WxSendMessage getModel() {
		return entity;
	}
	public void set_id(Long _id) {
		this._id = _id;
	}
}


