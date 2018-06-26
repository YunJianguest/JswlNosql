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
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.RelativeDate;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig; 
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.web.GeneralAction;  
import com.lsp.suc.entity.Mark; 
import com.lsp.suc.entity.MarkComment;
import com.lsp.website.service.WwzService;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;

 
/**
 * 纪念馆通用管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name ="reload", location = "mark.action",params={"fypage","%{fypage}"}, type = "redirect") })
public class MarkAction extends GeneralAction<Mark>{

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
	
	private Mark entity=new Mark();
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
		List<DBObject> list=baseDao.getList(PubConstants.SUC_MARK,whereMap,fypage,10,sortMap,backMap);
		fycount=baseDao.getCount(PubConstants.SUC_MARK);
		Struts2Utils.getRequest().setAttribute("list", list);
		Struts2Utils.getRequest().setAttribute("custid", custid);
		
		return SUCCESS;
	}


	@Override
	public Mark getModel() {
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
		Struts2Utils.getRequest().setAttribute("entity",baseDao.getMessage(PubConstants.SUC_MARK, _id));
		return "add";
	}
	public void upd() throws Exception { 
		DBObject db = baseDao.getMessage(PubConstants.SUC_MARK, _id); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}


	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id==null){
				_id=mongoSequence.currval(PubConstants.SUC_MARK); 
			}  
			custid=SpringSecurityUtils.getCurrentUser().getId(); 
			entity.set_id(_id); 
			entity.setCustid(custid);
			entity.setCreatedate(new Date());
			baseDao.insert(PubConstants.SUC_MARK, entity);
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
		custid=SpringSecurityUtils.getCurrentUser().getId();
		HashMap<String,Object>whereMap=new HashMap<String, Object>();
		whereMap.put("_id", _id);
		whereMap.put("custid",custid);
		baseDao.delete(PubConstants.SUC_MARK, whereMap);
		return RELOAD;
	}


	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id!=null){
				DBObject db=baseDao.getMessage(PubConstants.SUC_MARK, _id);
				entity= (Mark) UniObject.DBObjectToObject(db, Mark.class);
			}else{
				entity=new Mark();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	 	
	}
	public void set_id(Long _id) {
		this._id = _id;
	}
    public  String  web(){
		return "web"; 
    } 
    /**
     * 纪念馆详情
     * @return
     */
    public  String  webdetail(){
    	getLscode();
    	String id=Struts2Utils.getParameter("id");
    	Struts2Utils.getRequest().setAttribute("custid",custid);
    	WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/suc/mark!webdetail.action?custid="+custid+"&id="+id;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}
		DBObject  db=baseDao.getMessage(PubConstants.SUC_MARK, Long.parseLong(id));
		Struts2Utils.getRequest().setAttribute("entity",db);
		DBObject  share=new BasicDBObject(); 
		if(db!=null){ 
			share.put("fximg",wwzService.getWxUser(fromUserid).get("headimgurl")); 
			share.put("fxsummary", db.get("summary"));
			share.put("fxurl",url);
			Struts2Utils.getRequest().setAttribute("share", share);
			if(db.get("mb")!=null){
				return "webdetail"+db.get("mb"); 
			}
		} 
		return "webdetail"; 
    }
    /**
     * ajax获取评论
     */
    public  void    ajaxwebcom(){
    	getLscode();
    	String  id=Struts2Utils.getParameter("id");
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
	    HashMap<String, Object>sortMap=new HashMap<String, Object>(); 
		whereMap.put("custid",custid);
		whereMap.put("id",Long.parseLong(id));
		sortMap.put("createdate", -1);
		 
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject>list=baseDao.getList(PubConstants.SUC_MARKCOMMENT, whereMap,fypage,10,sortMap);
		if(list.size()>0){
			sub_map.put("state", 0);
			for (DBObject dbObject : list) {
				if(dbObject.get("fromUserid")!=null){
					DBObject  db=wwzService.getWxUser(dbObject.get("fromUserid").toString());
					dbObject.put("headimgurl",db.get("headimgurl"));
					dbObject.put("nickname",db.get("nickname"));
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
     * ajax添加评论
     */
    /**
     * 
     */
    public  void  ajaxaddcom(){
    	getLscode(); 
    	String type=Struts2Utils.getParameter("type");
    	String content=Struts2Utils.getParameter("content");
    	MarkComment comment=new MarkComment();
    	comment.set_id(mongoSequence.currval(PubConstants.SUC_MARKCOMMENT));
    	comment.setContent(content);
    	comment.setCustid(custid);
    	comment.setFromUserid(fromUserid);
    	comment.setWid(_id);
    	comment.setType(Integer.parseInt(type));
    	comment.setCreatedate(new Date());
    	baseDao.insert(PubConstants.SUC_MARKCOMMENT,comment);
    	Map<String, Object> sub_map = new HashMap<String, Object>();
    	String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    }
    /**
     * 评论
     * @return
     */
    public  String  comment(){
    	HashMap<String, Object>whereMap=new HashMap<>();
    	HashMap<String, Object>sortMap=new HashMap<>();
    	whereMap.put("wid", _id);
    	sortMap.put("createdate",-1);
    	if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
    	List<DBObject>list=baseDao.getList(PubConstants.SUC_MARKCOMMENT, whereMap,fypage,10,sortMap);
    	for (DBObject dbObject : list) {
    		if(dbObject.get("fromUserid")!=null){
				DBObject  db=wwzService.getWxUser(dbObject.get("fromUserid").toString());
				dbObject.put("headimgurl",db.get("headimgurl"));
				dbObject.put("nickname",db.get("nickname"));
			}
			if(dbObject.get("createdate")!=null){
				dbObject.put("createdate", RelativeDate.format(DateFormat.getFormat(dbObject.get("createdate").toString()), new Date()));
			}
		}
    	fycount=baseDao.getCount(PubConstants.SUC_MARKCOMMENT, whereMap);
    	Struts2Utils.getRequest().setAttribute("list",list);
    	Struts2Utils.getRequest().setAttribute("id", _id);
    	return "comment"; 
    }
    /**
     * 删除评论
     * @return
     */
    public  String  delcom(){
        custid=SpringSecurityUtils.getCurrentUser().getId();
        baseDao.delete(PubConstants.SUC_MARKCOMMENT, _id);
        Struts2Utils.getRequest().setAttribute("id", _id);
		return "comment"; 	
    }
     
}
