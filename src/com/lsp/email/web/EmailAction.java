package com.lsp.email.web;

import com.lsp.email.entity.EmailInfo;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.RelativeDate;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction; 
import com.lsp.website.service.WwzService;
import com.mongodb.DBObject;
import java.util.Date;
import java.util.HashMap;
import java.util.List; 
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
/**
 * 资源管理
 * @author lsp 
 *   
 */
@Namespace("/email")
@Results({@org.apache.struts2.convention.annotation.Result(name="reload", location="email.action",params={"fypage", "%{fypage}"}, type="redirect")})
public class EmailAction extends GeneralAction<EmailInfo>
{
  private static final long serialVersionUID = -6784469775589971579L;

  @Autowired
  private BaseDao basedao;
  private Long _id;
  private EmailInfo entity = new EmailInfo();
  private MongoSequence mongoSequence;
  @Autowired
  private WwzService wwzService;

  @Autowired
  public void setMongoSequence(MongoSequence mongoSequence)
  {
    this.mongoSequence = mongoSequence;
  }
  public void set_id(Long _id) {
    this._id = _id;
  }
  public String execute() throws Exception {
    HashMap<String, Object> sortMap = new HashMap<String, Object>();
    HashMap<String, Object> whereMap = new HashMap<String, Object>();
    sortMap.put("createdate", Integer.valueOf(-1));
    custid=SpringSecurityUtils.getCurrentUser().getId();
    if ((Struts2Utils.getParameter("fypage") != null) && (!Struts2Utils.getParameter("fypage").endsWith(""))) {
      this.fypage = Integer.parseInt(Struts2Utils.getParameter("fypage"));
      Struts2Utils.getRequest().setAttribute("fypage", Integer.valueOf(this.fypage));
    }
    whereMap.put("custid", custid);
    whereMap.put("fromUserid",custid);
    List<DBObject> list = this.basedao.getList(PubConstants.EMAIL_EMALIINFO, whereMap, sortMap);
    Struts2Utils.getRequest().setAttribute("emaillList", list);
    this.fycount = this.basedao.getCount(PubConstants.EMAIL_EMALIINFO);
    Struts2Utils.getRequest().setAttribute("fycount", Long.valueOf(this.fycount));
    return "success";
  }

  public String input()
    throws Exception
  {
    return "add";
  }

  public String update()
    throws Exception
  {
    return "add";
  }

  public String save() throws Exception
  {
    try
    {
      if (this._id == null)
      {
        this._id = this.mongoSequence.currval(PubConstants.EMAIL_EMALIINFO);
      }

      entity.set_id(this._id);
      entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
      entity.setCreatedate(new Date());
      entity.setType(0);
      basedao.insert(PubConstants.EMAIL_EMALIINFO, this.entity);
      
      EmailInfo   email=new EmailInfo();
      email.set_id(PubConstants.EMAIL_EMALIINFO);
      email.setContent(entity.getContent());
      email.setCreatedate(new Date());
      email.setTitle(entity.getTitle());
      email.setCustid(entity.getCustid());
      email.setType(1);
      email.setToUserid(entity.getToUserid());
      email.setFromUserid(entity.getFromUserid());
      email.setState(0);
      basedao.insert(PubConstants.EMAIL_EMALIINFO,email);
      addActionMessage("添加成功!");
    }
    catch (Exception e) {
      e.printStackTrace();
      addActionMessage("添加失败!");
    }
    return "reload";
  }
  public void upd() throws Exception {
		DBObject db = basedao.getMessage(PubConstants.EMAIL_EMALIINFO, _id);
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
  }
  public String delete() throws Exception
  {
    try
    {
      if (this._id != null) {
        this.basedao.delete(PubConstants.EMAIL_EMALIINFO, this._id);
        addActionMessage("删除成功");
      }
    }
    catch (Exception e)
    {
      e.printStackTrace();
      addActionMessage("删除失败");
    }
    return "reload";
  }

  protected void prepareModel()
    throws Exception
  {
    if (this._id != null)
    {
      DBObject emDbObject = this.basedao.getMessage(PubConstants.EMAIL_EMALIINFO, this._id);
      this.entity = ((EmailInfo)UniObject.DBObjectToObject(emDbObject, EmailInfo.class));
    } else {
      this.entity = new EmailInfo();
    }
  }

  public EmailInfo getModel()
  {
    return this.entity;
  }
  /**
   * ajax阅读
   * @throws Exception
   */
  public void   ajaxreading() throws Exception {
	    getLscode();
		Long id=Long.parseLong(Struts2Utils.getParameter("id"));

		Map<String, Object> sub_map = new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		whereMap.put("_id", id);
	    EmailInfo  email=(EmailInfo)UniObject.DBObjectToObject(basedao.getMessage(PubConstants.EMAIL_EMALIINFO, whereMap), EmailInfo.class);
		if(email!=null){
			email.setReaddate(new Date());
			email.setState(1); 
			basedao.insert(PubConstants.EMAIL_EMALIINFO, email);
			sub_map.put("state",0);
		}
		
		String json = JSONArray.fromObject(sub_map).toString();
		
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
    /**
     * 发件箱  
     */
  public  void   ajaxoutbox(){
	  getLscode();
	  Map<String, Object> sub_map = new HashMap<String, Object>();
	  HashMap<String, Object> whereMap =new HashMap<String, Object>();
	  HashMap<String, Object> sortMap =new HashMap<String, Object>(); 
	  whereMap.put("custid", custid);  
	  whereMap.put("fromUserid",fromUserid);
	  sortMap.put("createdate", -1);
	  if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
		  fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
	  }
	  List<DBObject>list=basedao.getList(PubConstants.EMAIL_EMALIOUTINFO, whereMap,fypage,10, sortMap);
	  if(list.size()>0){
		  sub_map.put("state",0);
		  for (DBObject dbObject : list) {
			if(dbObject.get("fromUserid")!=null){
				DBObject  db=wwzService.getWxUser(dbObject.get("fromUserid").toString());
				dbObject.put("fromheadimgurl",db.get("headimgurl"));
				dbObject.put("fromno",db.get("no"));
				dbObject.put("fromnickname",db.get("nickname"));
			}
			if(dbObject.get("toUserid")!=null){
				DBObject  db=wwzService.getWxUser(dbObject.get("toUserid").toString());
				dbObject.put("toheadimgurl",db.get("headimgurl"));
				dbObject.put("tono",db.get("no"));
				dbObject.put("tonickname",db.get("nickname"));
			}
			if(dbObject.get("createdate")!=null){
				dbObject.put("createdate", RelativeDate.format(DateFormat.getFormat(dbObject.get("createdate").toString()), new Date()));
			}
		}
		  sub_map.put("list",list);
	  }
	  String json = JSONArray.fromObject(sub_map).toString();
		
	  Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
  }
  /**
   * 收件箱
   */
  public  void   ajaxinbox(){
	  getLscode();
	  Map<String, Object> sub_map = new HashMap<String, Object>();
	  HashMap<String, Object> whereMap =new HashMap<String, Object>();
	  HashMap<String, Object> sortMap =new HashMap<String, Object>(); 
	  whereMap.put("custid", custid);  
	  whereMap.put("toUserid",fromUserid);
	  sortMap.put("createdate", -1);
	  if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
		  fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
	  }
	  List<DBObject>list=basedao.getList(PubConstants.EMAIL_EMALIINFO, whereMap,fypage,10, sortMap);
	  if(list.size()>0){
		  sub_map.put("state",0);
		  for (DBObject dbObject : list) {
				if(dbObject.get("fromUserid")!=null){
					DBObject  db=wwzService.getWxUser(dbObject.get("fromUserid").toString());
					dbObject.put("fromheadimgurl",db.get("headimgurl"));
					dbObject.put("fromno",db.get("no"));
					dbObject.put("fromnickname",db.get("nickname"));
				}
				if(dbObject.get("toUserid")!=null){
					DBObject  db=wwzService.getWxUser(dbObject.get("toUserid").toString());
					dbObject.put("toheadimgurl",db.get("headimgurl"));
					dbObject.put("tono",db.get("no"));
					dbObject.put("tonickname",db.get("nickname"));
				}
				if(dbObject.get("createdate")!=null){
					dbObject.put("createdate", RelativeDate.format(DateFormat.getFormat(dbObject.get("createdate").toString()), new Date()));
				}
		 }
		  sub_map.put("list",list);
	  }
	  String json = JSONArray.fromObject(sub_map).toString();
		
	  Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
  }
  /**
   * 手机添加页面
   * @return
   */
  public  String movesave(){
	  getLscode();
	  Struts2Utils.getRequest().setAttribute("custid", custid);
	  Struts2Utils.getRequest().setAttribute("toUserid", Struts2Utils.getParameter("toUserid"));
	return "movesave";   
  }
  /**
   * 邮件列表页面
   * @return
   */
  public  String web(){
	  getLscode();
	  Struts2Utils.getRequest().setAttribute("custid", custid);
	  Struts2Utils.getRequest().setAttribute("state", Struts2Utils.getParameter("state"));
	return "web";   
  }
  public  void   ajaxsave(){
	  getLscode();
	  Map<String, Object> sub_map = new HashMap<String, Object>();
	  String  title=Struts2Utils.getParameter("title");
	  String  content=Struts2Utils.getParameter("content");
	  String  toUserid=Struts2Utils.getParameter("toUserid"); 
	  if(StringUtils.isNotEmpty(toUserid)){
		  toUserid=wwzService.getfromUseridVipNo(toUserid);   
	  } 
	  String  picurl=Struts2Utils.getParameter("picurl");
	  //增加到发件箱
	  EmailInfo  emailInfo=new EmailInfo();
	  emailInfo.set_id(mongoSequence.currval(PubConstants.EMAIL_EMALIOUTINFO));
	  emailInfo.setContent(content);
	  emailInfo.setTitle(title);
	  emailInfo.setType(0);
	  emailInfo.setToUserid(toUserid);
	  emailInfo.setCreatedate(new Date());
	  emailInfo.setCustid(custid);
	  emailInfo.setFromUserid(fromUserid);
	  emailInfo.setState(1);
	  if(StringUtils.isNotEmpty(picurl)){
		  emailInfo.setPicurl(picurl);
	  }
	  basedao.insert(PubConstants.EMAIL_EMALIOUTINFO, emailInfo);
	  //增加到收件箱
	  emailInfo.set_id(mongoSequence.currval(PubConstants.EMAIL_EMALIINFO)); ;
	  basedao.insert(PubConstants.EMAIL_EMALIINFO, emailInfo); 
	  sub_map.put("state",0);
	  String json = JSONArray.fromObject(sub_map).toString();
		
	  Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
  }
  /**
   * 设置邮件
   */
  public  void  ajaxset(){
	  getLscode();
	  Map<String, Object> sub_map = new HashMap<String, Object>();
	  String id=Struts2Utils.getParameter("id");
	  String state=Struts2Utils.getParameter("state");
	  String type=Struts2Utils.getParameter("type");
	  if(StringUtils.isNotEmpty(id)){
		 if(StringUtils.isNotEmpty(state)){
			 if(Integer.parseInt(state)==3){
				 if(Integer.parseInt(type)==0){
					 basedao.delete(PubConstants.EMAIL_EMALIINFO,Long.parseLong(id)); 
				 }
				 if(Integer.parseInt(type)==1){
					 basedao.delete(PubConstants.EMAIL_EMALIOUTINFO,Long.parseLong(id)); 
				 }
				
			 }else{
				 if(Integer.parseInt(state)==0){
					 DBObject obj=basedao.getMessage(PubConstants.EMAIL_EMALIINFO, Long.parseLong(id));
					 if(obj!=null){
						 EmailInfo  emailInfo=(EmailInfo) UniObject.DBObjectToObject(obj, EmailInfo.class);
						 emailInfo.setState(Integer.parseInt(state));
						 basedao.insert(PubConstants.EMAIL_EMALIINFO, emailInfo);
					 }
				 }
				 if(Integer.parseInt(state)==1){
					 DBObject obj=basedao.getMessage(PubConstants.EMAIL_EMALIOUTINFO, Long.parseLong(id));
					 if(obj!=null){
						 EmailInfo  emailInfo=(EmailInfo) UniObject.DBObjectToObject(obj, EmailInfo.class);
						 emailInfo.setState(Integer.parseInt(state));
						 basedao.insert(PubConstants.EMAIL_EMALIINFO, emailInfo);
					 }
				 }
				 
			 }
			 
			 sub_map.put("state",0);
		 }
	  }
	  String json = JSONArray.fromObject(sub_map).toString(); 
	  Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);   
  }
  /**
   * 邮件详情
   * @return
   */
  public String  detail(){
	  getLscode();
	  Struts2Utils.getRequest().setAttribute("custid",custid);
	  String id=Struts2Utils.getParameter("id");
	  String state=Struts2Utils.getParameter("state");
	  Struts2Utils.getRequest().setAttribute("state", state);
	  if(StringUtils.isNotEmpty(id)){
		  DBObject  db;
		  if(Integer.parseInt(state)==1){
			  db=basedao.getMessage(PubConstants.EMAIL_EMALIOUTINFO, Long.parseLong(id)); 
			  EmailInfo  emailInfo=(EmailInfo) UniObject.DBObjectToObject(db, EmailInfo.class);
			  emailInfo.setState(0);
			  basedao.insert(PubConstants.EMAIL_EMALIOUTINFO, emailInfo);
		  }else{
			  db=basedao.getMessage(PubConstants.EMAIL_EMALIINFO, Long.parseLong(id));
			  EmailInfo  emailInfo=(EmailInfo) UniObject.DBObjectToObject(db, EmailInfo.class);
			  emailInfo.setState(0);
			  basedao.insert(PubConstants.EMAIL_EMALIINFO, emailInfo);
		  }
		 
		  if(db!=null){
			 
			  DBObject  obj;
			  if(fromUserid.equals(db.get("fromUserid").toString())){ 
				obj=wwzService.getWxUser(db.get("toUserid").toString()); 
			  }else{
				obj=wwzService.getWxUser(db.get("fromUserid").toString());  
			  }
			  if(db.get("toUserid")!=null){ 
				  db.put("headimgurl", obj.get("headimgurl"));
			      db.put("nickname", obj.get("nickname"));
			      db.put("no", obj.get("no"));
			  }
			  
			  Struts2Utils.getRequest().setAttribute("entity",db);
		  } 
	  }
	return "detail";   
  }
  
}