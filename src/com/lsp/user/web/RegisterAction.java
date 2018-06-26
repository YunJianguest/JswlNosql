package com.lsp.user.web;


import java.util.HashMap;

import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.SpringSecurityUtils;

import com.lsp.pub.util.Struts2Utils;

import com.lsp.user.service.LoginService;
import com.mongodb.DBObject;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired; 
/***
 * 资源管理
 * @author lsp
 *
 */
@Namespace("/")
@Results({@org.apache.struts2.convention.annotation.Result(name="reload", location="register.action", type="redirect")})
public class RegisterAction extends ActionSupport
{
  @Autowired
  private BaseDao basedao;
  private static final long serialVersionUID = 1L;
  public static final String RELOAD = "reload";
 

  public String execute()
    throws Exception
  {    
	//加载区域（默认）
	HashMap<String, Object>whereMap=new HashMap<String, Object>();
	whereMap.put("account", "admin");
	DBObject  db=basedao.getMessage(PubConstants.USER_INFO, whereMap);
	if(db!=null){
	  Struts2Utils.getRequest().setAttribute("id", db.get("_id"));
	} 
    return "success";
  }
  
}