package com.lsp.weixin.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

 
import com.alibaba.fastjson.JSON;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoDbUtil;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.JmsService;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction;
import com.lsp.weixin.entity.SendEail;
import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
 
/***
 * 资源管理
 * @author lsp
 *
 */
@Namespace("/weixin")
@Results({ @Result(name = SendemailAction.RELOAD, location = "sendemail.action", type = "redirect") })
public class SendemailAction extends GeneralAction<SendEail> {
	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private SendEail entity = new SendEail();;
	private String _id;

	private MongoSequence mongoSequence;

	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}

	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		sortMap.put("insdate", -1);
		BasicDBList dbList=new BasicDBList();  //翻译数组对象
		BasicDBObject dateCondition = new BasicDBObject();
		String startdate = Struts2Utils.getParameter("startdate");
		String enddate = Struts2Utils.getParameter("enddate");
		if (StringUtils.isNotEmpty(startdate)) {
			dateCondition.append("$gte",DateFormat.getFormat(startdate + " 00:00:01"));
			Struts2Utils.getRequest().setAttribute("enddate", enddate);
		}
		if (StringUtils.isNotEmpty(enddate)) {
			dateCondition.append("$lte",DateFormat.getFormat(enddate + " 23:59:59"));
			Struts2Utils.getRequest().setAttribute("startdate", startdate);
		}
		if (StringUtils.isNotEmpty(startdate)|| StringUtils.isNotEmpty(enddate)) {
			whereMap.put("insdate", dateCondition);
		}
		String email = Struts2Utils.getParameter("email");
		if (StringUtils.isNotEmpty(email)) {
			Pattern pattern = Pattern.compile("^.*" + email + ".*$",Pattern.CASE_INSENSITIVE);
			HashMap<String, Object> whereMap1 = new HashMap<String, Object>();
			whereMap1.put("email", pattern);
			List<DBObject> listdb=baseDao.getList(PubConstants.DATA_WXUSER, whereMap1, sortMap);
			for(DBObject db:listdb){
				dbList.add(db.get("_id").toString());
			}
			Struts2Utils.getRequest().setAttribute("email", email);
		}
		String no = Struts2Utils.getParameter("no");
		String tel = Struts2Utils.getParameter("tel");
		if (StringUtils.isNotEmpty(tel)) {

			Pattern pattern = Pattern.compile("^.*" + tel + ".*$",Pattern.CASE_INSENSITIVE);
			HashMap<String, Object> whereMap1 = new HashMap<String, Object>();
			whereMap1.put("tel", pattern);
			List<DBObject> listdb=baseDao.getList(PubConstants.DATA_WXUSER, whereMap1, sortMap);
			for(DBObject db:listdb){
				dbList.add(db.get("_id").toString());
			}
			Struts2Utils.getRequest().setAttribute("tel", tel);
		}
		if (StringUtils.isNotEmpty(no)) {

			Pattern pattern = Pattern.compile("^.*" + no + ".*$",Pattern.CASE_INSENSITIVE);
			HashMap<String, Object> whereMap1 = new HashMap<String, Object>();
			whereMap1.put("no", pattern);
			List<DBObject> listdb=baseDao.getList(PubConstants.DATA_WXUSER, whereMap1, sortMap);
			for(DBObject db:listdb){
				dbList.add(db.get("_id").toString());
			}
			Struts2Utils.getRequest().setAttribute("no", no);
		}
		if(dbList.size()>0){
			whereMap.put("_id", new BasicDBObject("$in",dbList));
		}
		
		fycount=baseDao.getCount(PubConstants.WEIXIN_SENDMAIL, whereMap);
		
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject> list = baseDao.getList(PubConstants.WEIXIN_SENDMAIL,whereMap,fypage,10, sortMap);
		for(DBObject db:list){
			if(db.get("fromUser")!=null){
			DBObject user=baseDao.getMessage(PubConstants.DATA_WXUSER, db.get("fromUser").toString());
			if(user!=null){
				if(user.get("headimgurl")!=null){
					db.put("headimgurl", user.get("headimgurl").toString());
				}
				if(user.get("tel")!=null){
					db.put("tel", user.get("tel").toString());
				}
				if(user.get("no")!=null){
					db.put("no", user.get("no").toString());
				}
				if(user.get("nickname")!=null){
					db.put("nickname", user.get("nickname").toString());
				}
				if(user.get("email")!=null){
					db.put("email", user.get("email").toString());
				}
			}
			}
		}
		Struts2Utils.getRequest().setAttribute("emailList", list);
		
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		try {
			Struts2Utils.getRequest().setAttribute("parentid",
					Struts2Utils.getParameter("parentid"));
			baseDao.delete(PubConstants.WEIXIN_SENDMAIL, _id);
			addActionMessage("成功删除!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,删除过程中出现异常!");
		}
		return RELOAD;
	}

	@Override
	public String input() throws Exception {
		Struts2Utils.getRequest().setAttribute("parentid",
				Struts2Utils.getParameter("parentid"));
		return "add";
	}

	@Override
	public String update() throws Exception {
		Struts2Utils.getRequest().setAttribute("parentid",
				Struts2Utils.getParameter("parentid"));
		DBObject db = baseDao.getMessage(PubConstants.WEIXIN_SENDMAIL, _id);

		entity = JSON.parseObject(db.toString(), SendEail.class);
		entity.set_id((Long) db.get("_id"));
		return "add";
	}
	public void upd() throws Exception {
		DBObject db = baseDao.getMessage(PubConstants.WEIXIN_SENDMAIL, _id);
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}
	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			// 有custId查出来 用户信息
			DBObject db = baseDao.getMessage(PubConstants.WEIXIN_SENDMAIL, _id);

			entity = JSON.parseObject(db.toString(), SendEail.class);
			entity.set_id((Long) db.get("_id"));
		} else {
			entity = new SendEail();
		}
	}

	@Override
	public String save() throws Exception {
		// 注册业务逻辑
		try {
			
			entity.set_id(_id);
			
			baseDao.insert(PubConstants.WEIXIN_SENDMAIL, entity);
			Struts2Utils.getRequest().setAttribute("parentid",
					Struts2Utils.getParameter("parentid"));
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		return RELOAD;
	}
	/**
	 * 获取激活代码
	 * @return
	 * @throws Exception 
	 */
	public void sendemail() throws Exception {
	
		Map<String, Object> sub_map = new HashMap<String, Object>();
		fromUser=Struts2Utils.getParameter("fromUser");
		String email="";
		String type="sendnck";
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("type"))){
			type=Struts2Utils.getParameter("type");
		}
		DBObject user=baseDao.getMessage(PubConstants.DATA_WXUSER, fromUser);
		if(user==null||user.get("email")==null){
			sub_map.put("state",1);
			
			String json = JSONArray.fromObject(sub_map).toString();
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
			return;
		}else{
			email=user.get("email").toString();
			
		}
		
		String comid = Struts2Utils.getParameter("comid");
		String no = "";
		if(user.get("no")!=null){
			no=user.get("no").toString();
		}
		toUser=SpringSecurityUtils.getCurrentUser().getToUser();
		HashMap<String,Object> map=new HashMap<String,Object>();
		map.put("comid", comid);
		map.put("email", email);
		map.put("no", no);
		JmsService.jsonMessage(toUser, fromUser, type,map);//推送消息
		
		
		sub_map.put("state",0);
		
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	public static void main(String[] args) throws Exception {
		MongoDbUtil mongoDbUtil = new MongoDbUtil();
		List<DBObject> list = mongoDbUtil.queryAll(PubConstants.WEIXIN_SENDMAIL,null, null).toArray();
		mongoDbUtil.delete(PubConstants.WEIXIN_SENDMAIL, null);
		for(DBObject db:list){
			SendEail entity = (SendEail) UniObject.DBObjectToObject(db, SendEail.class); 
			entity.set_id(entity.getFromUser());
			mongoDbUtil.insertUpdate(PubConstants.WEIXIN_SENDMAIL, entity);
		}
	}
	@Override
	public SendEail getModel() {
		return entity;
	}

	public void set_id(String _id) {
		this._id = _id;
	}
}
