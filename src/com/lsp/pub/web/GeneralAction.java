package com.lsp.pub.web; 
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.WxToken;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.WeiXinUtil;  
import com.lsp.website.service.WwzService;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable; 

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory; 
import org.springframework.beans.factory.annotation.Autowired;
/**
 * 通用action
 * @author lsp 
 *   
 */
public abstract class GeneralAction<T> extends ActionSupport implements ModelDriven<T>, Preparable {

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
	public String agid;
	public String fromUser;
	public String qqfromUser;
	public String osshttp;
	public String filehttp;
	public String ctxurl;
	public String custid;
	public String fromUserid;
	public String lscode;
	public int css;
	//分页数据
	public long fycount;
	public int fypage=0;
	public int fyts=10;
	public String logo;
	
	//定义公共参数
	public long  parentid;
	public String type;
	//-- CRUD Action函数 --//
	/**
	 * Action函数,显示Entity列表界面.
	 * 建议return SUCCESS.
	 */

	/**
	 * Action函数,显示新增或修改Entity界面.
	 * 建议return INPUT.
	 */
	@Override
	public abstract String input() throws Exception;
	
	public abstract String update() throws Exception;
	
	//public abstract String sch() throws Exception;

	public  String list() throws Exception{
		return null;
	}
	
	public abstract String save() throws Exception;

	/**
	 * Action函数,删除Entity.
	 * 建议return RELOAD.
	 */
	public abstract String delete() throws Exception;

	//-- Preparable函数 --//
	/**
	 * 实现空的prepare()函数,屏蔽了所有Action函数都会执行的公共的二次绑定.
	 */
	public void prepare() throws Exception {
	}

	/**
	 * 定义在input()前执行二次绑定.
	 */
	public void prepareInput() throws Exception {
		prepareModel();
	}
	/**
	 * 定义在update()前执行二次绑定.
	 */
	public void prepareUpdate() throws Exception {
		prepareModel();
	}
	/**
	 * 定义在save()前执行二次绑定.
	 */
	
	/**
	 * 定义在sch()前执行二次绑定.
	 */
	public void prepareSch() throws Exception {
		prepareModel();
	}
	/**
	 * 定义在save()前执行二次绑定.
	 */

	/**
	 * 等同于prepare()的内部函数,供prepardMethodName()函数调用. 
	 */
	protected abstract void prepareModel() throws Exception;

	public String getCate_id() {
		return cate_id;
	}

	public void setCate_id(String cate_id) {
		this.cate_id = cate_id;
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

	public String getCodeFromUserid() { 
		String code=Struts2Utils.getParameter("code"); 
		if(StringUtils.isEmpty(code)){
			 
		}else{
			WxToken wxtoken=GetAllFunc.wxtoken.get(custid);
			if(wxtoken.getSqlx()==0){ 
				fromUser=WeiXinUtil.getOpenId(custid,code);	
			}else{  
				fromUser=WeiXinUtil.getOpenId(wwzService.getparentcustid(custid),code);
			}
 
		}
		fromUserid=wwzService.getcodefromUserid(fromUser,custid);
		
		return fromUserid;
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
		String code=Struts2Utils.getParameter("code");
		Struts2Utils.getRequest().setAttribute("state", Struts2Utils.getParameter("state"));
		custid=Struts2Utils.getParameter("custid"); 
		if(StringUtils.isEmpty(code)){
			Object fromUser=Struts2Utils.getRequest().getSession().getAttribute("fromUserid"); 
			if(fromUser!=null){
				fromUserid=fromUser.toString();
			}else{
				fromUserid=Struts2Utils.getParameter("fromUserid");	
			}
		}else{ 
			WxToken wxtoken=GetAllFunc.wxtoken.get(custid);
			if(wxtoken.getSqlx()==0){ 
				fromUser=WeiXinUtil.getOpenIdToKen(custid,code).getFromUser();	
			}else{  
				fromUser=WeiXinUtil.getOpenIdToKen(wwzService.getparentcustid(custid),code).getFromUser();
			} 
			fromUserid=wwzService.getfromUserid(fromUser,custid);
 
		} 
  
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

	public String getLscode() {
		//验证浏览器  
		getAgid();
		String lscode=Struts2Utils.getParameter("lscode");
		if(StringUtils.isEmpty(lscode)){
			String state=Struts2Utils.getParameter("state");
			if(StringUtils.isNotEmpty(state)){
				if(state.equals("c1c2j3h4")){
					getCodeFromUserid();
				}else{
					getFromUserid();
				}
			}  
			if(StringUtils.isNotEmpty(fromUserid)){
				lscode=wwzService.createcode(fromUserid); 
		        Struts2Utils.getRequest().setAttribute("lscode",lscode);  
				//加载用户
				Struts2Utils.getRequest().setAttribute("user",wwzService.getWxUser(fromUserid));
				 
				
		        wwzService.recordlogin(custid, fromUserid);
		        
		        
		        String fid=Struts2Utils.getParameter("fid");  
				if(StringUtils.isNotEmpty(fid)&&StringUtils.isNotEmpty(wwzService.getfromUseridVipNo(fid))){
					wwzService.addFriends(fromUserid, wwzService.getfromUseridVipNo(fid));
				}
				
				//邮件提醒验证
				Long  emailcount=wwzService.chekEmail(fromUserid, custid); 
				if(emailcount!=null&&emailcount>0){
					Struts2Utils.getRequest().setAttribute("emailcount", emailcount);
				}
				//好友提醒验证
				Long  friedcount=wwzService.chekfireds(fromUserid, custid); 
				if(friedcount!=null&&friedcount>0){
					Struts2Utils.getRequest().setAttribute("friedcount",friedcount);
				}
				return lscode;	
			}else{
				return "";
			}
			
		}else{  
	        Struts2Utils.getRequest().setAttribute("lscode",lscode); 
			fromUserid=wwzService.getfromUseridfromcode(lscode); 
			//加载用户
			Struts2Utils.getRequest().setAttribute("user",wwzService.getWxUser(fromUserid));
			//邮件提醒验证
			Long  emailcount=wwzService.chekEmail(fromUserid, custid); 
			if(emailcount!=null&&emailcount>0){
				Struts2Utils.getRequest().setAttribute("emailcount", emailcount);
			}
			//好友提醒验证
			Long  friedcount=wwzService.chekfireds(fromUserid, custid); 
			if(friedcount!=null&&friedcount>0){
				Struts2Utils.getRequest().setAttribute("friedcount",friedcount);
			}  
			return lscode;
		}
		
	}

	public void setLscode(String lscode) {
		this.lscode = lscode;
	}

	public String getAgid() {
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("agid"))){
			agid=Struts2Utils.getParameter("agid");
			Struts2Utils.getRequest().setAttribute("agid",agid);
		} 
		return agid;
	}

	public void setAgid(String agid) {
		this.agid = agid;
	}
	
 
}