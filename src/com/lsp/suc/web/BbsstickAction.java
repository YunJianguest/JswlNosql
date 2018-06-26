package com.lsp.suc.web;

import java.util.Calendar;
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
import com.lsp.suc.entity.BbsInfo;
import com.lsp.suc.entity.Bbsstick;
import com.lsp.suc.entity.Bbstypeinfo;
import com.lsp.suc.entity.IntegralInfo;
import com.lsp.website.service.WebsiteService;
import com.lsp.website.service.WwzService;
import com.lsp.weixin.entity.WxUser;
import com.mongodb.DBObject;

/**
 * 论坛置顶管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name ="reload", location = "bbsstick.action", type = "redirect") })
public class BbsstickAction extends GeneralAction<Bbsstick>{

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
	
	private Bbsstick entity=new Bbsstick();
	private Long _id;


	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>(); 
		
		custid=SpringSecurityUtils.getCurrentUser().getId(); 
		sortMap.put("createdate", -1); 
		whereMap.put("custid", custid); 
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		
		List<DBObject> list=baseDao.getList(PubConstants.BBS_STICK,whereMap,fypage,10,sortMap); 
		for (DBObject dbObject : list) {
			DBObject  wx=wwzService.getWxUser(dbObject.get("fromUserid").toString());
			dbObject.put("user", wx);
			DBObject  bbs=baseDao.getMessage(PubConstants.BBS_INFO,Long.parseLong(dbObject.get("bmtid").toString()));
			if(bbs!=null){
				dbObject.put("content", bbs.get("content"));	
			}
			
		}
	
		fycount=baseDao.getCount(PubConstants.BBS_STICK,whereMap);
		
		Struts2Utils.getRequest().setAttribute("bbsstickList", list);
		Struts2Utils.getRequest().setAttribute("custid", custid);
		
		return SUCCESS;
	}


	@Override
	public Bbsstick getModel() {
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
		DBObject db = baseDao.getMessage(PubConstants.BBS_STICK, _id); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}


	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id==null){
				_id=mongoSequence.currval(PubConstants.BBS_STICK); 
			}  
			String custid=SpringSecurityUtils.getCurrentUser().getId();
			
			entity.set_id(_id); 
			entity.setCustid(custid); 
			entity.setCreatedate(new Date());
			baseDao.insert(PubConstants.BBS_STICK, entity);
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
		String custid=SpringSecurityUtils.getCurrentUser().getId();
		HashMap<String,Object>whereMap=new HashMap<String, Object>();
		whereMap.put("_id", _id);
		//whereMap.put("custid",custid);
		baseDao.delete(PubConstants.BBS_STICK,whereMap);
		return RELOAD;
	}


	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id!=null){
				DBObject db=baseDao.getMessage(PubConstants.BBS_STICK, _id);
				entity= (Bbsstick) UniObject.DBObjectToObject(db, Bbsstick.class);
			}else{
				entity=new Bbsstick();
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
	 * 管理员取消审核
	 * @return
	 */
	
	public String auditcancel(){
		custid=SpringSecurityUtils.getCurrentUser().getId(); 
	    DBObject  obj=baseDao.getMessage(PubConstants.BBS_STICK, _id);
	    if(obj!=null){ 
	       Bbsstick  db=(Bbsstick) UniObject.DBObjectToObject(obj, Bbsstick.class);
	       db.set_id(_id);
	       db.setState(1);
	       baseDao.insert(PubConstants.BBS_STICK, db);
	    }
		return RELOAD;
		
	}
	/**
	 * 管理员审核通过
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public String audit(){
		custid=SpringSecurityUtils.getCurrentUser().getId();
	    DBObject  obj=baseDao.getMessage(PubConstants.BBS_STICK, _id);
	    if(obj!=null){  
	       Bbsstick  db=(Bbsstick) UniObject.DBObjectToObject(obj, Bbsstick.class);
	       Calendar cal = Calendar.getInstance();
	       cal.add(Calendar.HOUR_OF_DAY,+Integer.parseInt(db.getTime().toString()));  
	       db.setState(0);
	       db.setStartdate(new Date());
	       db.setEnddate(cal.getTime()); 
	       baseDao.insert(PubConstants.BBS_STICK, db);
	    }
		return RELOAD;
		
	}
	/**
	 * 验证置顶
	 */
	public  void  check(){
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		whereMap.put("state",0);
		Long  count=baseDao.getCount(PubConstants.BBS_STICK,whereMap);
		if(count<3L){
			sub_map.put("state",0);  
		}
		String json = JSONArray.fromObject(sub_map).toString();

		Struts2Utils.renderJson(json.substring(1, json.length() - 1),
				new String[0]);
	}
	 
	/**
	 * ajax置顶
	 */
	public void   ajaxAdd(){
		lscode=getLscode();
		custid=getCustid();
		Map<String, Object>submap=new HashMap<String, Object>();
		try {
			DBObject user=wwzService.getWxUser(fromUserid);
			if(user.get("_id").toString().equals("notlogin")){
				//未登录
				submap.put("state",3);
			}else{
				String  bmtid=Struts2Utils.getParameter("bmtid");
				String  time=Struts2Utils.getParameter("time"); 
				String  price=Struts2Utils.getParameter("price");
				
				//验证是否已经置顶
				HashMap<String,Object>whereMap=new HashMap<String, Object>();
				whereMap.put("bmtid",Long.parseLong(bmtid));
			    Long count=baseDao.getCount(PubConstants.BBS_STICK,whereMap);
			    System.out.println(count);
			    if(count==0L){
			    	//开始置顶
			    	Bbsstick  obj=new Bbsstick();
			    	obj.set_id(mongoSequence.currval(PubConstants.BBS_STICK));
			    	obj.setBmtid(Long.parseLong(bmtid));
			    	obj.setCustid(custid);
			    	obj.setFromUserid(fromUserid);
			    	obj.setState(1);
			    	obj.setPrice(Double.parseDouble(price));
			        obj.setTime(Long.parseLong(time));
			    	obj.setCreatedate(new Date());
			    	baseDao.insert(PubConstants.BBS_STICK, obj);
			    	//设置帖子状态
			    	DBObject db=baseDao.getMessage(PubConstants.BBS_INFO, Long.parseLong(bmtid));
			    	BbsInfo  bbs=(BbsInfo) UniObject.DBObjectToObject(db,BbsInfo.class);
			    	System.out.println("*****************************");
			    	System.out.println(bbs);
			    	System.out.println("*****************************");
			    	bbs.set_id(Long.parseLong(bmtid));
			    	bbs.setStick(1);
			    	baseDao.insert(PubConstants.BBS_INFO, bbs);
			    	//积分结算   
			    	System.out.println(user);
			    	wwzService.deljf(price, fromUserid, "bbsstick", custid, user);
					 
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
     

}
