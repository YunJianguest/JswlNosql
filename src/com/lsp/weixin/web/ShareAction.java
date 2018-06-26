package com.lsp.weixin.web;

import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

 
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.GetAllFunc; 
import com.lsp.pub.entity.WxToken;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.web.GeneralAction;
import com.lsp.shop.entiy.ComMain;
import com.lsp.suc.entity.Comunit;
import com.lsp.website.service.WwzService;
import com.lsp.weixin.entity.ShortUrl;
import com.lsp.weixin.entity.WxReflash;
import com.mongodb.DBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
@Namespace("/weixin")
@Results( { @Result(name = ShareAction.RELOAD, location = "share.action",params={"_id", "%{_id}"}, type = "redirect") })
public class ShareAction extends GeneralAction<WxReflash> {

	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private MongoSequence mongoSequence;
	@Autowired
	private WwzService wwzService;
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}
	
	private WxReflash entity=new WxReflash();
	private String method;


	@Override
	public String execute() throws Exception {
		custid =SpringSecurityUtils.getCurrentUser().getId();
		toUser=SpringSecurityUtils.getCurrentUser().getToUser();
		WxToken wxtoken=GetAllFunc.wxtoken.get(custid);
		if(wxtoken.getSqlx()==1){
			toUser=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)).getToUser();
		}
		String method=Struts2Utils.getParameter("method");
		
		Struts2Utils.getRequest().setAttribute("method",method);

		String dlurl=method; 
		if(toUser!=null){
			String ddurl=WeiXinUtil.getinqurl(toUser,dlurl);  
			Struts2Utils.getRequest().setAttribute("ddurl", ddurl);
		}  
		Struts2Utils.getRequest().setAttribute("dlurl", dlurl);
		 
		return SUCCESS;
	}
	public String js() throws Exception {
		toUser =SpringSecurityUtils.getCurrentUser().getToUser();
		Comunit toUserentity=GetAllFunc.wxTouser.get(toUser);
		if(toUserentity.getQx()==1){
			
		}else{
			ComMain commain=GetAllFunc.comToUser.get(toUser);
			if(commain!=null){
				toUser=commain.getToUser();
			}
		}
		
		String method=Struts2Utils.getParameter("method");
		
		Struts2Utils.getRequest().setAttribute("method",method);

		String dlurl=method.replace("&fromUser=fromUserData", "");
		
		ShortUrl cmpsu=WeiXinUtil.getDwz(toUser,dlurl);
		String ddurl=cmpsu.getLurl();
		
		Struts2Utils.getRequest().setAttribute("ddurl", ddurl);

		Struts2Utils.getRequest().setAttribute("dlurl", dlurl);
		Struts2Utils.getRequest().setAttribute("surl", SysConfig.getProperty("ym")+"d?id="+cmpsu.get_id().toString());
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		
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
		
	}
	
	

	@Override
	public String save() throws Exception {
		
		return RELOAD;
	}

	@Override
	public WxReflash getModel() {
		return entity;
	}
	public void setMethod(String method) {
		this.method = method;
	}
}


