package com.lsp.user.web;


import com.lsp.pub.util.SpringSecurityUtils;

import com.lsp.pub.util.Struts2Utils;

import com.lsp.user.service.LoginService;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired; 
/***
 * 登录管理
 * @author lsp
 *
 */
@Namespace("/")
@Results({@org.apache.struts2.convention.annotation.Result(name="reload", location="login.action", type="redirect")})
public class LoginAction extends ActionSupport
{
  private static final long serialVersionUID = 1L;
  public static final String RELOAD = "reload";

  @Autowired
  private LoginService login;

  public String execute()
    throws Exception
  {    
	 Object qqfromUser=Struts2Utils.getRequest().getSession().getAttribute("qqfromUser"); 
	 if(qqfromUser!=null){
		 //用户使用QQ一键登录后台，
		 SpringSecurityUtils.saveUserDetailsToContext(login.getUserDeatil(qqfromUser.toString()), Struts2Utils.getRequest());
		 Struts2Utils.getRequest().getRequestDispatcher("/index.action").forward(Struts2Utils.getRequest(), Struts2Utils.getResponse());
	 }
    return "success";
  }

  public String error() throws Exception {
    addActionMessage("账号或密码错误");
    return "reload";
  }

  public String logout() throws Exception {
    try {
      Struts2Utils.getSession().invalidate();
    }
    catch (Exception e) {
      e.printStackTrace();
    }
    return "ok";
  }

  public String expired() throws Exception {
    return "expired";
  }

  public String chek()
  {
   /* String name = Struts2Utils.getParameter("name");
    String pwd = Struts2Utils.getParameter("pwd");
    HashMap<String, Object> sortMap = new HashMap<String, Object>();
    HashMap<String, Object> whereMap = new HashMap<String, Object>();

    whereMap.put("account", name);
    sortMap.put("createdate", Integer.valueOf(-1));
    List<DBObject> list = this.baseDao.getList(PubConstants.USER_INFO, whereMap, sortMap);

    if ((list.size() > 0) && (list.get(0) != null)) {
      DBObject emDbObject = (DBObject)list.get(0);
      UserInfo entity = (UserInfo)UniObject.DBObjectToObject(emDbObject, UserInfo.class);

      if (entity.getPassword().equals(pwd)) {
        Struts2Utils.getSession().setAttribute("nickname", entity.getNickname());
      }
    }*/

    return "ok";
  }
  public String  move(){
	  
	return "move";
	   
  }
 
}