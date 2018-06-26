package com.lsp.suc.web;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;
 

import net.sf.json.JSONObject;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction;
import com.lsp.suc.entity.Bbstypeinfo;
import com.lsp.suc.entity.IntegralInfo;
import com.lsp.suc.entity.Slide;
import com.lsp.web.entity.AdvertisingInfo;
import com.lsp.website.service.WebsiteService;
import com.mongodb.DBObject;

 
/**
 * 幻灯片管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name ="reload", location = "slide.action",params={"type","%{type}","fypage","%{fypage}","width","%{width}","height","%{height}"}, type = "redirect") })
public class SlideAction extends GeneralAction<Slide>{

	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private MongoSequence mongoSequence;	
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}
	@Autowired
	private WebsiteService webService;
	
	private Slide entity=new Slide();
	private Long _id;


	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		HashMap<String, Object> backMap =new HashMap<String, Object>();
		
		custid=SpringSecurityUtils.getCurrentUser().getId();
	    String type=Struts2Utils.getParameter("type");
		sortMap.put("sort", -1); 
		whereMap.put("custid", custid);
		if(StringUtils.isNotEmpty(type)){
			whereMap.put("type", type);	
		}
		String title=Struts2Utils.getParameter("title");
		if(StringUtils.isNotEmpty(title)){
			Pattern pattern = Pattern.compile("^.*" + title + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern);
			Struts2Utils.getRequest().setAttribute("title",  title);
		}
	 
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		
		List<DBObject> list=baseDao.getList(PubConstants.SUC_SLIDE,whereMap,fypage,10,sortMap,backMap);
		fycount=baseDao.getCount(PubConstants.SUC_SLIDE,whereMap);
		Struts2Utils.getRequest().setAttribute("list", list);
		Struts2Utils.getRequest().setAttribute("custid", custid);
		
		return SUCCESS;
	}
    public  String slidehouse(){
    	HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		HashMap<String, Object> backMap =new HashMap<String, Object>();
		
		custid=SpringSecurityUtils.getCurrentUser().getId();
	    String type=Struts2Utils.getParameter("type");
		sortMap.put("sort", -1); 
		whereMap.put("custid", custid);
		if(StringUtils.isNotEmpty(type)){
			whereMap.put("type", type);	
		}
		String title=Struts2Utils.getParameter("title");
		if(StringUtils.isNotEmpty(title)){
			Pattern pattern = Pattern.compile("^.*" + title + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern);
			Struts2Utils.getRequest().setAttribute("title",  title);
		}
	 
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		
		List<DBObject> list=baseDao.getList(PubConstants.SUC_SLIDE,whereMap,fypage,10,sortMap,backMap);
		fycount=baseDao.getCount(PubConstants.SUC_SLIDE,whereMap);
		Struts2Utils.getRequest().setAttribute("list", list);
		Struts2Utils.getRequest().setAttribute("custid", custid);
		return "huse"; 
    }
	public String savehouse() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id==null){
				_id=mongoSequence.currval(PubConstants.SUC_SLIDE); 
			} 
			String custid=SpringSecurityUtils.getCurrentUser().getId();  
			entity.set_id(_id);
			entity.setCustid(custid);  
			baseDao.insert(PubConstants.SUC_SLIDE, entity);
			addActionMessage("添加成功");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			addActionMessage("添加失败");
		}
		return slidehouse();
	}
	@Override
	public Slide getModel() {
		// TODO Auto-generated method stub
		return entity;
	}


	@Override
	public String input() throws Exception {
		// TODO Auto-generated method stub
		return "add";
	}


	@Override
	public String update() throws Exception {
	 
		return "add";
	}
	public void upd() throws Exception { 
		DBObject db = baseDao.getMessage(PubConstants.SUC_SLIDE, _id); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}


	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id==null){
				_id=mongoSequence.currval(PubConstants.SUC_SLIDE); 
			} 
			String custid=SpringSecurityUtils.getCurrentUser().getId();  
			entity.set_id(_id);
			entity.setCustid(custid);
			String  mp4url=entity.getMp4url(); 
			if(mp4url.startsWith("https://v.qq.com")||mp4url.startsWith("http://v.qq.com")){
				if(mp4url.indexOf("vid=")>0){
					entity.setMp4url("https://v.qq.com/iframe/player.html?vid="+mp4url.substring(mp4url.indexOf("vid=")+4));
				}
				if(mp4url.indexOf("html")>0){
					entity.setMp4url("https://v.qq.com/iframe/player.html?vid="+mp4url.substring(mp4url.lastIndexOf("/")+1,mp4url.indexOf("html")-1));
				}
			}
			if(mp4url.startsWith("https://v.youku.com")||mp4url.startsWith("http://v.youku.com")){
				if(mp4url.indexOf("html")>0){
					mp4url=mp4url.substring(0, mp4url.indexOf("html"));
					mp4url=mp4url.substring(mp4url.indexOf("id_")+3, mp4url.lastIndexOf("."));
					entity.setMp4url("http://player.youku.com/embed/"+mp4url+"==");
				}
			}
			baseDao.insert(PubConstants.SUC_SLIDE, entity);
			addActionMessage("添加成功");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			addActionMessage("添加失败");
		}
		return RELOAD;
	}
	
	 
	 

	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub 
		if(_id!=null){
			baseDao.delete(PubConstants.SUC_SLIDE,_id);
		}
		return RELOAD;
	}


	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id!=null){
				DBObject db=baseDao.getMessage(PubConstants.SUC_SLIDE, _id);
				entity= (Slide) UniObject.DBObjectToObject(db, Slide.class);
			}else{
				entity=new Slide();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	 	
	}
	public void set_id(Long _id) {
		this._id = _id;
	}
	/**
	 * 手机添加幻灯片
	 * @return
	 */
	public  String  webadd(){
		custid=getCustid();
		lscode=getLscode();
		Struts2Utils.getRequest().setAttribute("lscode", "lscode");
		Struts2Utils.getRequest().setAttribute("custid", custid);
		String type=Struts2Utils.getParameter("type");
		Struts2Utils.getRequest().setAttribute("type", type);
		Struts2Utils.getRequest().setAttribute("backurl", Struts2Utils.getParameter("backurl"));
		return "webadd";
	}
	/**
	 * ajax添加
	 */
	public  void  ajaxadd(){
		custid=getCustid();
		lscode=getLscode();
		String  type=Struts2Utils.getParameter("type");
		String  picurl=Struts2Utils.getParameter("picurl");
		String  title=Struts2Utils.getParameter("title");
		String  url=Struts2Utils.getParameter("url");
		Slide obj=new Slide();
		obj.set_id(mongoSequence.currval(PubConstants.SUC_SLIDE));
		obj.setCreatedate(new Date());
		obj.setCustid(custid);
		obj.setUrl(url);
		obj.setPicurl(picurl);
		obj.setTitle(title);
		obj.setType(type);
		obj.setFromUserid(fromUserid);
		baseDao.insert(PubConstants.SUC_SLIDE, obj);
		 
	}
     

}
