package com.lsp.suc.web;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;
import java.util.regex.Pattern;
 

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.activemq.filter.function.splitFunction;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.entity.WxToken;
import com.lsp.pub.util.BaseDate;
import com.lsp.pub.util.BaseDecimal;
import com.lsp.pub.util.CommonUtil;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.DateUtil;
import com.lsp.pub.util.ExportExcel;
import com.lsp.pub.util.PayCommonUtil;
import com.lsp.pub.util.RelativeDate;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.TenpayUtil;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.util.XMLUtil;
import com.lsp.pub.web.GeneralAction;  
import com.lsp.suc.entity.DatingAudit;
import com.lsp.suc.entity.DatingInfo;
import com.lsp.suc.entity.DatingPhoto;
import com.lsp.suc.entity.Farm;
import com.lsp.suc.entity.FarmCard;
import com.lsp.suc.entity.FarmFoot;
import com.lsp.suc.entity.FarmProduct;
import com.lsp.suc.entity.FarmYd;
import com.lsp.suc.entity.FarmYdDetail; 
import com.lsp.suc.entity.Ranking; 
import com.lsp.website.service.WwzService;
import com.lsp.weixin.entity.WxPayConfig;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBObject;

 
/**
 * 婚恋审核机制
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name ="reload", location = "datingaudit.action",params={"fypage","%{fypage}","state","%{state}"}, type = "redirect") })
public class DatingauditAction extends GeneralAction<DatingAudit>{

	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private MongoSequence mongoSequence;	
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}
	@Autowired
	private WwzService wwzService;
	
	private DatingAudit entity=new DatingAudit();
	private Long _id;


	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		HashMap<String, Object> backMap =new HashMap<String, Object>();
		
		custid=SpringSecurityUtils.getCurrentUser().getId();
		sortMap.put("sort", -1); 
		whereMap.put("custid", custid);
		String title=Struts2Utils.getParameter("title"); 
		if(StringUtils.isNotEmpty(title)){
			Pattern pattern = Pattern.compile("^.*" + title + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern);
			Struts2Utils.getRequest().setAttribute("title",  title);
		}
		String state=Struts2Utils.getParameter("state");
	    if(StringUtils.isNotEmpty(state)){
	    	//whereMap.put("state", Integer.parseInt(state));
	    }
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		backMap.put("content", 0);
		List<DBObject> list=baseDao.getList(PubConstants.SUC_DATINGAUDIT,whereMap,fypage,10,sortMap,backMap);
		fycount=baseDao.getCount(PubConstants.SUC_DATINGAUDIT);
		if(list.size()>0){
			for (DBObject dbObject : list) {
				dbObject.put("nickname", baseDao.getMessage(PubConstants.SUC_DATING, dbObject.get("fromUserid").toString()).get("nickname"));
			}
		}
		Struts2Utils.getRequest().setAttribute("list", list);
		Struts2Utils.getRequest().setAttribute("custid", custid);
		
		return SUCCESS;
	}


	@Override
	public DatingAudit getModel() {
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
		Struts2Utils.getRequest().setAttribute("entity",baseDao.getMessage(PubConstants.SUC_DATINGAUDIT, _id));
		return "add";
	}
	public void upd() throws Exception { 
		DBObject db = baseDao.getMessage(PubConstants.SUC_DATINGAUDIT, _id); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}


	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
	 
		return RELOAD;
	}
	
	 
	 

	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub 
		String custid=SpringSecurityUtils.getCurrentUser().getId();
		HashMap<String,Object>whereMap=new HashMap<String, Object>();
		whereMap.put("_id", _id);
		whereMap.put("custid",custid);
		baseDao.delete(PubConstants.SUC_DATINGAUDIT, whereMap);
		return RELOAD;
	}


	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id!=null){
				DBObject db=baseDao.getMessage(PubConstants.SUC_DATINGAUDIT, _id);
				entity= (DatingAudit) UniObject.DBObjectToObject(db, DatingAudit.class);
			}else{
				entity=new DatingAudit();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	 	
	}
	public void set_id(Long _id) {
		this._id = _id;
	} 
    public  String  audit() throws Exception{
    	String state=Struts2Utils.getParameter("state");
    	if(StringUtils.isNotEmpty(state)){
    		if(_id!=null){
    			DBObject obj=baseDao.getMessage(PubConstants.SUC_DATINGAUDIT, _id); 
    			if(obj!=null){
    				DatingAudit audit=(DatingAudit) UniObject.DBObjectToObject(obj, DatingAudit.class);
    				audit.setState(Integer.parseInt(state));
    				audit.setAuditdate(new Date());
    				audit.setAuditid(SpringSecurityUtils.getCurrentUser().getId());
    				baseDao.insert(PubConstants.SUC_DATINGAUDIT, audit);
    				if(Integer.parseInt(state)==1){
        				if(audit.getType()==0){
            				DBObject db=baseDao.getMessage(PubConstants.SUC_DATING, audit.getFromUserid());
            				if(db!=null){
            					DatingInfo info=(DatingInfo) UniObject.DBObjectToObject(db, DatingInfo.class);
            					info.setHeadimgurl(audit.getPicurl());
            					info.setHeadimgrz(1);
            					baseDao.insert(PubConstants.SUC_DATING, info);
            				}
            				
            			}else if(audit.getType()==1){
            				DatingPhoto  photo=new DatingPhoto();
            				photo.set_id(mongoSequence.currval(PubConstants.SUC_DATINGPHOTO));
            				photo.setCreatedate(new Date());
            				photo.setFromUserid(audit.getFromUserid());
            				photo.setPicurl(audit.getPicurl());
            				photo.setTitle(audit.getContent());
            				baseDao.insert(PubConstants.SUC_DATINGPHOTO, photo);
            			}
        			}
    			}
    		
    			
    		}
    	}
    	return  RELOAD;
    }   
}
