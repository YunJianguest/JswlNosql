package com.lsp.pub.web;

import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.shop.entiy.ComMain;
import com.lsp.suc.entity.Comunit;
import com.lsp.website.service.WwzService;
import com.opensymphony.xwork2.ActionSupport; 
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
/**
 * 通用action
 * @author lsp 
 *   
 */
public class TotalAction extends ActionSupport
{
	private static final long serialVersionUID = -1653204626115064950L;
	@Autowired
	private WwzService wwzService;
	/** 进行增删改操作后,以redirect方式重新打开action默认页的result名.*/
	public static final String RELOAD = "reload";
	public static final String UPDATE = "update";
	public static final String LIST = "list";
	protected Logger logger = LoggerFactory.getLogger(getClass());
	private String cate_id;
	
	public String toUser;
	public String fromUser;
	public String qqfromUser;
	public String osshttp;
	public String filehttp;
	public String ctxurl;
	public String custid;
	public String fromUserid;
	public int css;//css样式
	//分页数据
	public long fycount;
	public int fypage=0;
	public int fyts=10;
	public String logo;///企业底部说明
	
	//定义公共参数
	public long  parentid;
	public String type;
	//-- CRUD Action函数 --//
	/**
	 * Action函数,显示Entity列表界面.
	 * 建议return SUCCESS.
	 */

	 
	
	//public abstract String sch() throws Exception;

	public  String list() throws Exception{
		return null;
	}
 
	 
	/**
	 * 定义在save()前执行二次绑定.
	 */
 

	public String getCate_id() {
		return cate_id;
	}

	public void setCate_id(String cate_id) {
		this.cate_id = cate_id;
	}

	
	public int getCss() {
		return  GetAllFunc.wxTouser.get(toUser).getCss();
	}
	public void setCss(int css) {
		this.css = css;
	} 
	public Logger getLogger() {
		return logger;
	}

	public void setLogger(Logger logger) {
		this.logger = logger;
	} 
	public String getToUser() {
		return toUser;
	}

	public void setToUser(String toUser) {
		this.toUser = toUser;
	}
	public String getLogo() {
		return  GetAllFunc.wxTouser.get(toUser).getLogo();
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public static String getReload() {
		return RELOAD;
	}

	public static String getUpdate() {
		return UPDATE;
	}

	public static String getList() {
		return LIST;
	}

	public String getOsshttp() {
		
			return SysConfig.getProperty("osshttp");
		
	}

	public void setOsshttp(String osshttp) {
		this.osshttp = osshttp;
	}
	public String getCtxurl() {
		return SysConfig.getProperty("ip");
	}
	public long getFycount() {
		return fycount;
	}

	public void setFycount(long fycount) {
		this.fycount = fycount;
	}

	public int getFypage() {
		return fypage;
	}

	public void setFypage(int fypage) {
		this.fypage = fypage;
	}

	public int getFyts() {
		return fyts;
	}

	public void setFyts(int fyts) {
		this.fyts = fyts;
	}
	
	public long getParentid() {
		return parentid;
	}

	public void setParentid(long parentid) {
		this.parentid = parentid;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getFilehttp() {
		return SysConfig.getProperty("filehttp");
	}

	public void setFilehttp(String filehttp) {
		this.filehttp = filehttp;
	}

	public String getCodeFromUser() { 
		String code=Struts2Utils.getParameter("code"); 
		if(StringUtils.isEmpty(code)){
			if(StringUtils.isEmpty(Struts2Utils.getParameter("fromUser"))||Struts2Utils.getParameter("fromUser").equals("fromUserData")){
				if(Struts2Utils.getSession().getAttribute("fromLogin")!=null){
					fromUser=Struts2Utils.getSession().getAttribute("fromLogin").toString();
				}
				
			}else{
				fromUser=Struts2Utils.getParameter("fromUser");
				Struts2Utils.getRequest().setAttribute("fromUser", fromUser); 
			}
		}else{
			Comunit wxToUser=GetAllFunc.wxTouser.get(custid);
			if(wxToUser.getSqlx()==0){
				fromUser=WeiXinUtil.getOpenId(wxToUser.getToUser(),Struts2Utils.getParameter("code"));	
			}else{
				fromUser=WeiXinUtil.getOpenId(wwzService.gettoUser(wxToUser.getCustid()),Struts2Utils.getParameter("code"));
			}
 
		}
		Struts2Utils.getRequest().setAttribute("fromUser", fromUser);
		return fromUser;
	}
	public String getCodeFromUser2() { 
		String code=Struts2Utils.getParameter("code"); 
		if(StringUtils.isEmpty(code)){
			if(StringUtils.isEmpty(Struts2Utils.getParameter("fromUser"))||Struts2Utils.getParameter("fromUser").equals("fromUserData")){
				if(Struts2Utils.getSession().getAttribute("fromLogin")!=null){
					fromUser=Struts2Utils.getSession().getAttribute("fromLogin").toString();
				}
				
			}else{
				fromUser=Struts2Utils.getParameter("fromUser");
				Struts2Utils.getRequest().setAttribute("fromUser", fromUser); 
			}
		}else{
			Comunit wxToUser=GetAllFunc.wxTouser.get(custid);
			if(wxToUser.getSqlx()==0){
				fromUser=WeiXinUtil.getOpenIdToKen(wxToUser.getToUser(),Struts2Utils.getParameter("code")).getFromUser();	
			}else{
				fromUser=WeiXinUtil.getOpenIdToKen(wwzService.gettoUser(wxToUser.getCustid()),Struts2Utils.getParameter("code")).getFromUser();
			}
 
		}
		Struts2Utils.getRequest().setAttribute("fromUser", fromUser);
		return fromUser;
	}

	public String getQqfromUser(){
		 Object fromUser=Struts2Utils.getRequest().getSession().getAttribute("qqfromUser"); 
		 if(fromUser!=null){
			 qqfromUser=fromUser.toString(); 
		 }
		
		return qqfromUser;
	}

	public String getCustid() {
		Object fromUser=Struts2Utils.getRequest().getSession().getAttribute("custid");
		if(fromUser!=null){
			custid=fromUser.toString();
		}else{
			custid=Struts2Utils.getParameter("custid");	
		}  
		 
		return custid;
	}

	public String getFromUserid() {
		Object fromUser=Struts2Utils.getRequest().getSession().getAttribute("fromUserid");
		if(fromUser!=null){
			fromUserid=fromUser.toString();
		}else{
			fromUserid=Struts2Utils.getParameter("fromUserid");	
		}
		
		/**if(org.apache.commons.lang3.StringUtils.isEmpty(fromUserid)){ 
		  getCodeFromUser();//进行授权登录	
		  WwzService  wwzService=new WwzService();
		  System.out.println("bbs-"+fromUser);
		  fromUserid=wwzService.getfromUserid(fromUser);
		}*/
		
		return fromUserid;
	}

	public void setQqfromUser(String qqfromUser) {
		this.qqfromUser = qqfromUser;
	}

	public void setCustid(String custid) {
		this.custid = custid;
	}

	public void setFromUserid(String fromUserid) {
		this.fromUserid = fromUserid;
	}
	
}