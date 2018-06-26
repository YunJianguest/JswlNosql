package com.lsp.user.web;

import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results;
/***
 * 资源管理
 * @author lsp
 *
 */
@Namespace("/")
@Results({@org.apache.struts2.convention.annotation.Result(name="reload", location="index.action", type="redirect")})
public class IndexAction extends ActionSupport
{
  private static final long serialVersionUID = 1L;
  public static final String RELOAD = "reload";

  public String execute()
    throws Exception
  {
	   
    return "success";
  }
}