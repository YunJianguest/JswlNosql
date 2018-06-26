package com.lsp.android.web;
  
import java.util.ArrayList;
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
import org.directwebremoting.ScriptSession;
import org.directwebremoting.WebContextFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
 
import com.alibaba.fastjson.JSON; 
import com.lsp.android.entity.Message; 
import com.lsp.android.entity.Reply; 
import com.lsp.android.entity.ReplyUnFind;
import com.lsp.dwr.service.MessageEvent;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.PubConstants; 
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.JmsService;
import com.lsp.pub.util.RelativeDate;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils; 
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction;
import com.lsp.shop.entiy.ShopMsg;
import com.lsp.website.service.WwzService; 
import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBObject;
import com.sun.org.apache.commons.collections.Bag;
 

/**
 * 会话
 * 
 * @author lsp
 * 
 */
@Namespace("/android")
@Results({ @Result(name = ReplyAction.RELOAD, location = "reply.action", params = {"fypage", "%{fypage}" }, type = "redirect") })
public class ReplyAction extends GeneralAction<Reply>implements
ApplicationContextAware {
	private static final long serialVersionUID = -6784469775589971579L;
	private ApplicationContext ctx;
	@Autowired
	private BaseDao basedao;
	private Reply entity = new Reply();;
	private Long _id;
	@Autowired
	private WwzService  wwzservice; 
	private MongoSequence mongoSequence;

	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}

	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		sortMap.put("sort", 1);
		custid=SpringSecurityUtils.getCurrentUser().getId();
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject> list = basedao.getList(PubConstants.ANDROID_REPLY,whereMap,fypage,10, sortMap);
		Struts2Utils.getRequest().setAttribute("list", list); 
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		try {
			custid=SpringSecurityUtils.getCurrentUser().getId();
			basedao.delete(PubConstants.ANDROID_REPLY, _id);
			addActionMessage("成功删除!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,删除过程中出现异常!");
		}
		return RELOAD;
	}

	@Override
	public String input() throws Exception { 
		return "add";
	}

	@Override
	public String update() throws Exception { 
		return "add";
	}
	public void upd() throws Exception {
		DBObject db = basedao.getMessage(PubConstants.ANDROID_REPLY, _id);
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}
	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			// 有custId查出来 用户信息
			DBObject db = basedao.getMessage(PubConstants.ANDROID_REPLY, _id);

			entity = JSON.parseObject(db.toString(), Reply.class);
			entity.set_id((Long) db.get("_id"));
		} else {
			entity = new Reply();
		}
	}

	@Override
	public String save() throws Exception {
		// 注册业务逻辑
		try {
			if (_id == null) {
				_id = mongoSequence.currval(PubConstants.ANDROID_REPLY);
			}
			entity.set_id(_id); 
			basedao.insert(PubConstants.ANDROID_REPLY, entity); 
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		return RELOAD;
	}

	@Override
	public Reply getModel() {
		return entity;
	}

	public void set_id(Long _id) {
		this._id = _id;
	}
	/**
	 * 获取会话列表
	 */
	public  void   ajaxweb(){
		getLscode();
		Map<String, Object> submap = new HashMap<String, Object>(); 
		
	    HashMap<String, Object>whereMap=new HashMap<>();
	    HashMap<String, Object>sortMap=new HashMap<>();
	    whereMap.put("custid", custid); 
	    Pattern pattern = Pattern.compile("^.*" + wwzservice.getVipNo(fromUserid) + ".*$",
				Pattern.CASE_INSENSITIVE);
		whereMap.put("ids", pattern);
	    sortMap.put("createdate",-1);
	    if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
	    	fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
	    }
	    List<DBObject>list=basedao.getList(PubConstants.ANDROID_REPLY, whereMap,fypage,10,sortMap); 
	    if(list.size()>0){
	    	submap.put("state", 0); 
	    	for (DBObject dbObject : list) {
				DBObject  wxuser=wwzservice.getWxUser(dbObject.get("fromUserid").toString());
				if(wxuser!=null){
					dbObject.put("headimgurl",wxuser.get("headimgurl").toString());
					dbObject.put("nickname",wxuser.get("nickname").toString());
				}
				dbObject.put("uncount", getunfind(dbObject.get("_id").toString(),fromUserid));
				if(dbObject.get("endupdate")!=null){
					dbObject.put("endupdate",RelativeDate.format(DateFormat.getFormat(dbObject.get("endupdate").toString()), new Date()));
				}
				
			}
	    	submap.put("list",list);
	    }
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	} 
	/**
	 * 获取会话
	 */
	public  void   ajaxdetail(){
		getLscode();
		Map<String, Object> submap = new HashMap<String, Object>();
		String id=Struts2Utils.getParameter("id");
		if(StringUtils.isNotEmpty(id)){
			  HashMap<String, Object>whereMap=new HashMap<>();
			    HashMap<String, Object>sortMap=new HashMap<>();
			    sortMap.put("createdate",-1); 
			    whereMap.put("rid",id);
			    if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			    	fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			    	
			    }
			    List<DBObject>list=basedao.getList(PubConstants.ANDROID_MESSAGE,whereMap,fypage,15,sortMap);
			     
			    if(list.size()>0){
			    	submap.put("state", 0);
			    	submap.put("list", list);
			    	for (DBObject dbObject : list) {
						if(dbObject.get("fromUserid").toString().equals(fromUserid)){
							dbObject.put("location","left"); 
						}else{
							dbObject.put("location","right");
						}
					}
			    }
		} 
	    
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	} 
	/**
	 * 获取客服会话
	 */
	public  void   ajaxdetailkf(){
		getLscode();
		Map<String, Object> submap = new HashMap<String, Object>();
		String id=Struts2Utils.getParameter("id");
		String fid=Struts2Utils.getParameter("fid");
		if(StringUtils.isNotEmpty(fid)){
			fid=wwzservice.getfromUseridVipNo(fid);
			if(StringUtils.isNotEmpty(id)){
				  HashMap<String, Object>whereMap=new HashMap<>();
				    HashMap<String, Object>sortMap=new HashMap<>();
				    sortMap.put("createdate",-1); 
				    whereMap.put("rid",id);
				    if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				    	fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
				    	
				    }
				    List<DBObject>list=basedao.getList(PubConstants.ANDROID_MESSAGE,whereMap,fypage,15,sortMap);
				     
				    if(list.size()>0){
				    	submap.put("state", 0);
				    	submap.put("list", list);
				    	for (DBObject dbObject : list) {
							if(dbObject.get("fromUserid").toString().equals(fid)){
								dbObject.put("location","left"); 
							}else{
								dbObject.put("location","right");
							}
						}
				    }
			} 
		}
		 
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	} 
	/**
	 * 会话页面
	 */
	public  String   detail(){
		getLscode(); 
		Struts2Utils.getRequest().setAttribute("custid", custid);
		Struts2Utils.getRequest().setAttribute("id",Struts2Utils.getParameter("id"));
		String pid=Struts2Utils.getParameter("pid");
		String ids=Struts2Utils.getParameter("ids"); 
		if(StringUtils.isNotEmpty(ids)){
			ids=ids.replace(wwzservice.getVipNo(fromUserid),"");
			Struts2Utils.getRequest().setAttribute("ids", ids); 
		}
		if(StringUtils.isNotEmpty(pid)){
			DBObject db=basedao.getMessage(PubConstants.DATA_PRODUCT, Long.parseLong(pid)); 
			if(db!=null){
				Struts2Utils.getRequest().setAttribute("pro",db);
			}
			
		}
		DBObject  wxuser=wwzservice.getWxUser(fromUserid);
		Struts2Utils.getRequest().setAttribute("no",wxuser.get("no"));
		Struts2Utils.getRequest().setAttribute("headimgurl",wxuser.get("headimgurl"));
		Struts2Utils.getRequest().setAttribute("nickname",wxuser.get("nickname"));
		return "detail";
	}
	/**
	 * 会话页面
	 */
	public  String   index(){
		getLscode(); 
		Struts2Utils.getRequest().setAttribute("custid", custid);
		String id=Struts2Utils.getParameter("id");
		Struts2Utils.getRequest().setAttribute("id", id);
		Struts2Utils.getRequest().setAttribute("pid", Struts2Utils.getParameter("pid"));
		DBObject  wxuser=wwzservice.getWxUser(fromUserid);
		Struts2Utils.getRequest().setAttribute("no",wxuser.get("no"));
		Struts2Utils.getRequest().setAttribute("headimgurl",wxuser.get("headimgurl"));
		Struts2Utils.getRequest().setAttribute("nickname",wxuser.get("nickname"));
		if(StringUtils.isNotEmpty(id)){
			DBObject  db=basedao.getMessage(PubConstants.SHOP_SHOPMB, Long.parseLong(id)); 
			Struts2Utils.getRequest().setAttribute("entity",db);
		}  
		return "index";
	}
	/**
	 * 会话列表
	 */
	public  String   web(){
		getLscode(); 
		Struts2Utils.getRequest().setAttribute("custid", custid); 
		Struts2Utils.getRequest().setAttribute("wid", Struts2Utils.getParameter("wid")); 
		return "web";
	}
	/**
	 * 删除会话
	 */
	public  void   ajaxreplydel(){
		getLscode();
		Map<String, Object> submap = new HashMap<String, Object>();
		String id=Struts2Utils.getParameter("id");
	    HashMap<String, Object>whereMap=new HashMap<>();
	    whereMap.put("fromUserid", fromUserid);
	    whereMap.put("_id",id);
	    int i=basedao.delete(PubConstants.ANDROID_REPLY, whereMap);
	    if(i>0){
	    	submap.put("state", 0); 
	    } 
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 清空会话
	 */
	public  void   ajaxreplydelall(){
		getLscode();
		Map<String, Object> submap = new HashMap<String, Object>();
		String id=Struts2Utils.getParameter("id");
	    HashMap<String, Object>whereMap=new HashMap<>();
	    whereMap.put("fromUserid", fromUserid);
	    whereMap.put("_id",id);
	    DBObject db=basedao.getMessage(PubConstants.ANDROID_REPLY, whereMap);
	    if(db!=null){
	    	Reply  re=(Reply) UniObject.DBObjectToObject(db, Reply.class); 
	    	basedao.insert(PubConstants.ANDROID_REPLY, re);
	    	submap.put("state", 0);
	    }
	     
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	} 
	/**
	 * 创建会话
	 */
	public void  ajaxreplyadd(){
		getLscode(); 
		String ids=Struts2Utils.getParameter("ids");
		String title=Struts2Utils.getParameter("title"); 
		String pid=Struts2Utils.getParameter("pid"); 
		Map<String, Object> submap = new HashMap<String, Object>();
		if(StringUtils.isNotEmpty(ids)&&StringUtils.isNotEmpty(fromUserid)){
			HashMap<String, Object>whereMap=new HashMap<>();
			BasicDBList   dblist=new BasicDBList(); 
			dblist.add(new BasicDBObject("ids",ids));
			dblist.add(new BasicDBObject("ids",ids.split(",")[1]+","+ids.split(",")[0]));
			//or判断
			whereMap.put("$or", dblist);   
			whereMap.put("custid",custid);
			List<DBObject>list=basedao.getList(PubConstants.ANDROID_REPLY, whereMap, null); 
			DBObject db=null;
			if(list.size()>0){
				 db=list.get(0); 	
			}  
			 if(db!=null){
				 Reply r=(Reply) UniObject.DBObjectToObject(db, Reply.class);
					if(StringUtils.isNotEmpty(pid)){
						r.setPid(Long.parseLong(pid));
					}else{
						r.setPid(-1L);	
					}
					
					basedao.insert(PubConstants.ANDROID_REPLY, r); 
					submap.put("state",0);
					submap.put("value", db.get("_id"));
					String json = JSONArray.fromObject(submap).toString(); 
					Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
					return; 
			 }else{
				 
				 Reply  re=new Reply(); 
				 re.set_id(mongoSequence.currval(PubConstants.ANDROID_REPLY));
				 re.setCreatedate(new Date());
				 re.setFromUserid(fromUserid);
				 re.setIds(ids);
				 re.setCustid(custid);
				 if(StringUtils.isNotEmpty(pid)){
					re.setPid(Long.parseLong(pid)); 
				 }else{
					re.setPid(-1L); 
				 }
				 re.setTitle(title); 
				 basedao.insert(PubConstants.ANDROID_REPLY, re); 
				 submap.put("state",0);
				 submap.put("value",re.get_id());
			 } 
			
			 
		}
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	 
	public void onPageLoad(final String custid,final String lscode,final String rid) {
		// 获取当前的ScriptSession
		ScriptSession scriptSession = WebContextFactory.get()
				.getScriptSession();
		scriptSession.setAttribute("fromUserid", wwzservice.getfromUseridfromcode(lscode));
		scriptSession.setAttribute("rid", rid); 
		scriptSession.setAttribute("custid", custid);  
	}
	public void onPageLoads(final String custid,final String lscode,final String rid, final String parentid) {
		// 获取当前的ScriptSession
		ScriptSession scriptSession = WebContextFactory.get()
				.getScriptSession();
		scriptSession.setAttribute("fromUserid", wwzservice.getfromUseridfromcode(lscode));
		scriptSession.setAttribute("rid", rid); 
		scriptSession.setAttribute("custid", custid);  
		scriptSession.setAttribute("parentid",wwzservice.getfromUseridfromcode(parentid)); 
		System.out.println("sgsgsdgsdg"+wwzservice.getfromUseridfromcode(parentid));
		 
	}
	@Override
	public void setApplicationContext(ApplicationContext ctx)
			throws BeansException {
		// TODO Auto-generated method stub
		this.ctx = ctx;

	}

	public void sendMessage(Message msg) {  
		DBObject  wxuser=wwzservice.getWXuserVipNo(msg.getFromUserid()); 
        msg.setFromUserid(wxuser.get("_id").toString());
        String tousers=msg.getToUserid();
        String toUserids="";
        if(StringUtils.isNotEmpty(tousers)){
           String[]lsto=tousers.split(",");
           for (String string : lsto) {
        	   if(StringUtils.isNotEmpty(string)){
        		   String toUserid=wwzservice.getfromUseridVipNo(string);
        		   if(StringUtils.isNotEmpty(toUserid)){
        			   toUserids+=toUserid+",";
        		   };
        	   }
		 }
        } 
        msg.setToUserid(toUserids);  
        msg.setPicurl(wxuser.get("headimgurl").toString());
        msg.setTitle(wxuser.get("nickname").toString());
        msg.setCreatedate(new Date());  
        JmsService.upendMessage(msg.getRid(),msg.getContent(),2);
        JmsService.saveMessage(msg, 3);
		// 发布事件 
		ctx.publishEvent(new MessageEvent(msg));

	} 
	/**
	 * 分配客服
	 */
	public  void   ajaxallotservice(){
		getLscode();
		Map<String, Object> submap = new HashMap<String, Object>();
		try {
			String id=Struts2Utils.getParameter("id");
			//加载客服信息
			List<DBObject>list=GetAllFunc.shopCustService.get(id);
			//获取客服
			int num=0;
			//循环分配客服
			if(GetAllFunc.shopCustServicenum.get(id)!=null){
				num=(int) GetAllFunc.shopCustServicenum.get(id);  
				if(num<list.size()-1){ 
					GetAllFunc.shopCustServicenum.put(id, num+1);
				}else if(num==list.size()-1){
					GetAllFunc.shopCustServicenum.put(id,0);
				} 
			} 
			if(list!=null&&list.size()>0){
				DBObject db=list.get(num);
				//list.remove(db);
				//GetAllFunc.shopCustService.put(id, list);
				submap.put("state", 0);
				submap.put("headimgurl",db.get("headimgurl"));
				submap.put("nickname",db.get("nickname"));
				submap.put("no",db.get("no"));
			}
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	} 
	/**
	 * ajax保存店铺留言
	 */
	public void  ajaxsaveshopmsg(){
		getLscode(); 
		Map<String, Object> submap = new HashMap<String, Object>();
		String msg=Struts2Utils.getParameter("msg");
		String id=Struts2Utils.getParameter("id");
		String kfid=Struts2Utils.getParameter("kfid");
		if(StringUtils.isNotEmpty(id)&&StringUtils.isNotEmpty(msg)){
			ShopMsg shopMsg=new ShopMsg();
			shopMsg.set_id(mongoSequence.currval(PubConstants.SHOP_SHOPMSG));
			shopMsg.setCreatedate(new Date());
			shopMsg.setCustid(custid);
			shopMsg.setFromUserid(fromUserid);
			shopMsg.setWid(Long.parseLong(id));
			if(StringUtils.isNotEmpty(kfid)){
				shopMsg.setKfid(kfid);
				shopMsg.setState(1);
			 }else{
				shopMsg.setState(0);
			 }
			DBObject  wxuser=wwzservice.getWxUser(fromUserid); 
			shopMsg.setHeadimgurl(wxuser.get("headimgurl").toString());
			shopMsg.setNickname(wxuser.get("nickname").toString());
			basedao.insert(PubConstants.SHOP_SHOPMSG, shopMsg);
			submap.put("state", 0);
			submap.put("headimgurl", wxuser.get("headimgurl"));
			submap.put("nickname", wxuser.get("nickname"));
			submap.put("no", wxuser.get("no"));
			}
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	public void  delreply(){
		basedao.delete(PubConstants.ANDROID_REPLY);
	}
	/**
	 * 清除未读信息
	 */
	public void  delunfind(){
		 getLscode();
		 Map<String, Object> submap = new HashMap<String, Object>();
		 String rid=Struts2Utils.getParameter("rid");
		 DBObject db=basedao.getMessage(PubConstants.ANDROID_REPLYUNFIND, rid+"-"+fromUserid);
		 if(db!=null){
			 ReplyUnFind find=(ReplyUnFind) UniObject.DBObjectToObject(db, ReplyUnFind.class);
			 find.setCount(0);
			 basedao.insert(PubConstants.ANDROID_REPLYUNFIND, find);
			 submap.put("state",0);
		 }
		 String json = JSONArray.fromObject(submap).toString(); 
		 Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 获取未读信息
	 * @return
	 */
	public  int  getunfind(String rid,String fromUserid){
		DBObject db=basedao.getMessage(PubConstants.ANDROID_REPLYUNFIND, rid+"-"+fromUserid);
		if(db!=null){
			return Integer.parseInt(db.get("count").toString());
		}
		return 0; 
	}
	 
 
}
