package com.lsp.suc.web;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import net.sf.json.JSONArray;
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
import com.lsp.suc.entity.Areward;
import com.lsp.suc.entity.BbsInfo;
import com.lsp.suc.entity.Bbscomments;
import com.lsp.suc.entity.Bbsstick;
import com.lsp.suc.entity.Bbstypeinfo;
import com.lsp.suc.entity.IntegralInfo;
import com.lsp.website.service.WebsiteService;
import com.lsp.website.service.WwzService;
import com.lsp.weixin.entity.WxUser;
import com.mongodb.DBObject;

/**
 * 论坛悬赏管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name ="reload", location = "areward.action", type = "redirect") })
public class ArewardAction extends GeneralAction<Areward>{

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
	
	private Areward entity=new Areward();
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
	 
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		
		List<DBObject> list=baseDao.getList(PubConstants.BBS_STICK,whereMap,fypage,10,sortMap,backMap);
		for (DBObject dbObject : list) {
			DBObject  wx=wwzService.getWxUser(dbObject.get("fromUserid").toString());
			dbObject.put("user", wx);
			DBObject  bbs=baseDao.getMessage(PubConstants.BBS_AREWARD,Long.parseLong(dbObject.get("bmtid").toString()));
			dbObject.put("content", bbs.get("content"));
		}
		fycount=baseDao.getCount(PubConstants.BBS_AREWARD,whereMap);
		
		Struts2Utils.getRequest().setAttribute("bbsarewardList", list);
		Struts2Utils.getRequest().setAttribute("custid", custid);
		
		return SUCCESS;
	}


	@Override
	public Areward getModel() {
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
		DBObject db = baseDao.getMessage(PubConstants.BBS_AREWARD, _id); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}


	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id==null){
				_id=mongoSequence.currval(PubConstants.BBS_AREWARD); 
			}  
			String custid=SpringSecurityUtils.getCurrentUser().getId();
			
			entity.set_id(_id); 
			entity.setCustid(custid); 
			entity.setCreatedate(new Date());
			baseDao.insert(PubConstants.BBS_AREWARD, entity);
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
		//String custid=SpringSecurityUtils.getCurrentUser().getId();
		//HashMap<String,Object>whereMap=new HashMap<String, Object>();
		//whereMap.put("_id", _id);
		//whereMap.put("custid",custid);
		//baseDao.delete(PubConstants.BBS_STICK, whereMap);
		return RELOAD;
	}


	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id!=null){
				DBObject db=baseDao.getMessage(PubConstants.BBS_AREWARD, _id);
				entity= (Areward) UniObject.DBObjectToObject(db, Areward.class);
			}else{
				entity=new Areward();
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
	 * ajax悬赏
	 */
	public void   ajaxAdd(){
		lscode=getLscode();
		custid=getCustid();
		Map<String, Object>submap=new HashMap<String, Object>();
		try {
			DBObject user=wwzService.getWxUser(fromUserid);
			if(user.get("_id").equals("notlogin")){
				//未登录
				submap.put("state",3);
			}else{
				String  bmtid=Struts2Utils.getParameter("bmtid"); 
				String  price=Struts2Utils.getParameter("price");
				
				//验证是否已经悬赏
				HashMap<String,Object>whereMap=new HashMap<String, Object>();
				whereMap.put("bmtid",Long.parseLong(bmtid));
			    Long count=baseDao.getCount(PubConstants.BBS_AREWARD,whereMap);
			    if(count==0L){
			    	//开始悬赏
			    	Areward  obj=new Areward();
			    	obj.set_id(mongoSequence.currval(PubConstants.BBS_AREWARD));
			    	obj.setBmtid(Long.parseLong(bmtid));
			    	obj.setCustid(custid);
			    	obj.setFromUserid(fromUserid);
			    	obj.setState(0);
			    	obj.setPrice(Integer.parseInt(price));  
			    	obj.setCreatedate(new Date());
			    	baseDao.insert(PubConstants.BBS_STICK, obj);
			    	//设置帖子状态
			    	DBObject db=baseDao.getMessage(PubConstants.BBS_INFO, Long.parseLong(bmtid));
			    	BbsInfo  bbs=(BbsInfo) UniObject.DBObjectToObject(db,BbsInfo.class);
			    	bbs.set_id(Long.parseLong(bmtid));
			    	bbs.setActivity(1);
			    	baseDao.insert(PubConstants.BBS_INFO, bbs);
			    	//积分结算
			    	wwzService.deljf(price, fromUserid, "bbsareward", custid, user);
					submap.put("state",0);
			    	
			    }
			    submap.put("state",2);
				
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			submap.put("state",1);
			e.printStackTrace();
		}
		
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);	
		
	}
	/**
	 * ajax加载
	 */
	public  void  ajaxweb(){
		lscode=getLscode();
		custid=getCustid();
		Map<String, Object>submap=new HashMap<String, Object>();
		DBObject user=wwzService.getWxUser(fromUserid);
		try {
			if(user.get("_id").toString().equals("notlogin")){
				//未登录
				submap.put("state",3);
			}else{
				HashMap<String, Object>whereMap=new HashMap<String, Object>();
				HashMap<String, Object>sortMap=new HashMap<String, Object>();
				whereMap.put("custid", custid);
				whereMap.put(fromUserid, fromUserid);
				sortMap.put("createdate", -1);
				List<DBObject>list=baseDao.getList(PubConstants.BBS_AREWARD, whereMap, sortMap);
				if(list.size()>0){
					submap.put("state", 0);
					submap.put("list", list);
				}
			}
		  } catch (Exception e) {
			// TODO Auto-generated catch block
			submap.put("state", 1);
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * ajax设置悬赏答案
	 */
	public void  ajaxreward(){
		lscode=getLscode();
		custid=getCustid();
		Map<String, Object>submap=new HashMap<String, Object>(); 
		DBObject user=wwzService.getWxUser(fromUserid);
		try {
			if(user.get("_id").toString().equals("notlogin")){
				//未登录
				submap.put("state",3);
			}else{  
				String  bmtid=Struts2Utils.getParameter("bmtid"); 
				String  answerid=Struts2Utils.getParameter("answerid"); 
				String  toUserid=Struts2Utils.getParameter("toUserid");
				
				//验证悬赏
				HashMap<String,Object>whereMap=new HashMap<String, Object>();
				whereMap.put("bmtid",Long.parseLong(bmtid));
			    Long count=baseDao.getCount(PubConstants.BBS_AREWARD,whereMap); 
			    if(count==1L){
			    	DBObject  db=baseDao.getMessage(PubConstants.BBS_AREWARD,whereMap);
			    	if(db!=null){
			    		 Areward  obj=(Areward) UniObject.DBObjectToObject(db,Areward.class);
			    		 if(obj.getState()==0){
			    			 obj.setAnswerid(Long.parseLong(answerid));
			    			 obj.setState(1);
			    			 obj.setCreatedate(new Date());
			    			 baseDao.insert(PubConstants.BBS_AREWARD, obj);
			    			 
			    			 //同步到回复
			    			 DBObject  com=baseDao.getMessage(PubConstants.BBS_COMMENTS, Long.parseLong(answerid));
			    			 if(com!=null){
			    				 Bbscomments  bbscom=(Bbscomments) UniObject.DBObjectToObject(com, Bbscomments.class);
			    				 bbscom.setActivity(1);
			    				 baseDao.insert(PubConstants.BBS_COMMENTS, bbscom);
			    			 }
			    			//积分结算
						    	wwzService.addjf(obj.getPrice()+"", toUserid, "bbsareward", custid,wwzService.getWxUser(toUserid));
						    	 
							    submap.put("state", 0);
			    			 
			    		 }else {
			    			 submap.put("state", 2);
			    		 }
			    		
			    	}
			     
			    }
			   
				
			 }
		  } catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			submap.put("state", 1);
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);	
		
	}
     
 
}
