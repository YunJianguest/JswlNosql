package com.lsp.suc.web;

import java.net.URLEncoder;
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
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.entity.WxToken;
import com.lsp.pub.util.BaseDate;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.DateUtil;
import com.lsp.pub.util.JmsService;
import com.lsp.pub.util.RelativeDate;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.TenpayUtil;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.web.GeneralAction; 
import com.lsp.suc.entity.ActivityCard;
import com.lsp.suc.entity.ActivityDetail;
import com.lsp.suc.entity.ActivityInfo;
import com.lsp.suc.entity.ActivityYd; 
import com.lsp.suc.entity.RewardRecord;
import com.lsp.suc.entity.Share;
import com.lsp.suc.entity.Signindraw;
import com.lsp.suc.entity.SignindrawTj;
import com.lsp.website.service.WwzService;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBObject;

 
/**
 * 签到摇奖
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name ="reload", location = "singindraw.action",params={"fypage","%{fypage}"}, type = "redirect") })
public class SignindrawAction extends GeneralAction<Signindraw>{

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
	
	private Signindraw entity=new Signindraw();
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
		backMap.put("content", 0);
		List<DBObject> list=baseDao.getList(PubConstants.SUC_SIGNINDRAW,whereMap,fypage,10,sortMap,backMap);
		fycount=baseDao.getCount(PubConstants.SUC_SIGNINDRAW,whereMap);
		Struts2Utils.getRequest().setAttribute("list", list);
		Struts2Utils.getRequest().setAttribute("custid", custid);
		
		return SUCCESS;
	}


	@Override
	public Signindraw getModel() {
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
		Struts2Utils.getRequest().setAttribute("entity",baseDao.getMessage(PubConstants.SUC_SIGNINDRAW, _id));
		return "add";
	}
	public void upd() throws Exception { 
		DBObject db = baseDao.getMessage(PubConstants.SUC_SIGNINDRAW, _id); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}


	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id==null){
				_id=mongoSequence.currval(PubConstants.SUC_SIGNINDRAW); 
			}  
			String custid=SpringSecurityUtils.getCurrentUser().getId(); 
			entity.set_id(_id); 
			entity.setCustid(custid);
			entity.setCreatedate(new Date());
			entity.setEwmurl(wwzService.recode("signindraw-sign-"+_id,SysConfig.getProperty("ip")+"/suc/signindraw!sign.action?custid="+custid+"&id="+_id, entity.getPicurl(),true, 200, 1000));
			baseDao.insert(PubConstants.SUC_SIGNINDRAW, entity);
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
		whereMap.put("custid",custid);
		baseDao.delete(PubConstants.SUC_SIGNINDRAW, whereMap);
		return RELOAD;
	}


	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id!=null){
				DBObject db=baseDao.getMessage(PubConstants.SUC_SIGNINDRAW, _id);
				entity= (Signindraw) UniObject.DBObjectToObject(db, Signindraw.class);
			}else{
				entity=new Signindraw();
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
     * 活动主页面
     * @return
     */
    public  String  web(){ 
       Struts2Utils.getRequest().setAttribute("custid",custid);
	  return "web"; 	
    }
    /**
     * 活动签到
     * @return
     */
    public  String  sign(){
    	getLscode();
    	WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		}
		String id=Struts2Utils.getParameter("id");
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/suc/signindraw!sign.action?custid="+custid+"&id="+id;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
		return "sign"; 	
    }
   
    
    /**
     * ajax获取签到列表
     */
    public  void    ajaxweb(){
    	String  id=Struts2Utils.getParameter("id");
    	String  state=Struts2Utils.getParameter("state");
    	if(StringUtils.isNotEmpty(id)){
    		Map<String, Object> sub_map = new HashMap<String, Object>(); 
    		HashMap<String, Object>whereMap=new HashMap<String, Object>();
    	    HashMap<String, Object>sortMap=new HashMap<String, Object>(); 
    		whereMap.put("custid",custid); 
    		if(StringUtils.isNotEmpty(state)){
    			whereMap.put("state",Long.parseLong(state)); 	
    		}
    		whereMap.put("sid",Long.parseLong(id)); 
    		sortMap.put("createdate", -1);  
    		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
    			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
    		}
    		List<DBObject>list=baseDao.getList(PubConstants.SUC_SIGNINDRAWTJ, whereMap,fypage,10,sortMap);
    		if(list.size()>0){
    			sub_map.put("state", 0);
    			sub_map.put("list",list);
    		} 
    		String json = JSONArray.fromObject(sub_map).toString();
    		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    	}
    }
   
    /**
     * 签到
     */
    public  void  ajaxSign(){
    	getLscode();
    	String  id=Struts2Utils.getParameter("id");
    	Map<String, Object> sub_map = new HashMap<String, Object>(); 
    	if(StringUtils.isNotEmpty(id)){ 
    		DBObject  db=baseDao.getMessage(PubConstants.SUC_SIGNINDRAWTJ, id+"-"+fromUserid);
    		if(db==null){
    			SignindrawTj  tj=new SignindrawTj();
    			tj.set_id(id+"-"+fromUserid);
    			tj.setCreatedate(new Date());
    			tj.setCustid(custid);
    			tj.setFromUserid(fromUserid);
    			tj.setSid(Long.parseLong(id));
    			baseDao.insert(PubConstants.SUC_SIGNINDRAWTJ, tj);
    			sub_map.put("state", 0);
    		}else{
    			sub_map.put("state", 1);
    		}
    		 
    	}
    	String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    	
    }
    /**
     * 摇奖
     */
    public   void    draw(){
    	String  id=Struts2Utils.getParameter("id");
    	String  fid=Struts2Utils.getParameter("fid");
    	Map<String, Object> sub_map = new HashMap<String, Object>(); 
    	if(StringUtils.isNotEmpty(id)&&StringUtils.isNotEmpty(fid)){
    		DBObject  db=baseDao.getMessage(PubConstants.SUC_SIGNINDRAWTJ, id+"-"+fid);
    		if(db!=null){
    			SignindrawTj  tj=(SignindrawTj) UniObject.DBObjectToObject(db, SignindrawTj.class);
    			tj.setState(1);
    			tj.setZjdate(new Date());
    			baseDao.insert(PubConstants.SUC_SIGNINDRAWTJ, tj);
    			sub_map.put("db", db);
    			sub_map.put("state",0);
    		}
    				
    	}
    	String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    }
   
}
