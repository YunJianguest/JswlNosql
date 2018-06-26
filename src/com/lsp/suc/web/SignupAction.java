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
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.web.GeneralAction;
import com.lsp.suc.entity.MemorialComment;
import com.lsp.suc.entity.MemorialInfo;
import com.lsp.suc.entity.Comunit; 
import com.lsp.suc.entity.Signcomment;
import com.lsp.suc.entity.Signup;
import com.lsp.website.service.WwzService;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
 
/**
 * 报名管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name = SignupAction.RELOAD, location = "signup.action",params={"fypage","%{fypage}"}, type = "redirect") })
public class SignupAction extends GeneralAction<Signup> {

	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;

	@Autowired
	private WwzService wwzService;
	private MongoSequence mongoSequence;	
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	} 
	private Signup entity=new Signup();
	private Long _id;


	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		HashMap<String, Object> backMap =new HashMap<String, Object>();
		String custid=SpringSecurityUtils.getCurrentUser().getId();  
		whereMap.put("custid", custid); 
		String title=Struts2Utils.getParameter("title");
		if(!StringUtils.isEmpty(title)){
			Pattern pattern = Pattern.compile("^.*" + title + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern);
		} 
		sortMap.put("sort", -1);
		fycount=baseDao.getCount(PubConstants.SUC_SIGNUP, whereMap);
		
		if(Struts2Utils.getParameter("fypage")!=null){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		backMap.put("content", 0);
		List<DBObject> list=baseDao.getList(PubConstants.SUC_SIGNUP,whereMap,fypage,10, sortMap,backMap);
		Struts2Utils.getRequest().setAttribute("list", list);
		Struts2Utils.getRequest().setAttribute("custid", custid);
		return SUCCESS;
	}
	

	@Override
	public String delete() throws Exception {
		try {
			custid=SpringSecurityUtils.getCurrentUser().getId();
			baseDao.delete(PubConstants.SUC_SIGNUP,_id); 
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
	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			//有custId查出来 用户信息
			entity = (Signup)UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.SUC_SIGNUP,_id),Signup.class);
		} else {
			entity = new Signup();
		}
	}
	public void  upd(){ 
		DBObject db=baseDao.getMessage(PubConstants.SUC_SIGNUP, _id); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
		
	}
	
	@Override
	public String save() throws Exception {
		//注册业务逻辑
		try {

			if(_id == null){
				_id=mongoSequence.currval(PubConstants.SUC_SIGNUP);	
			}
			entity.set_id(_id);
			entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
			entity.setCreatedate(new Date());
			baseDao.insert(PubConstants.SUC_SIGNUP,entity); 
			addActionMessage("成功添加!");
			
		
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return RELOAD;
	}

	/**
	 * 祭祀列表
	 * @return
	 * @throws Exception
	 */
	public String web() throws Exception {	
		getLscode();
		WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/suc/signup!web.action?custid="+custid;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		} 
		Struts2Utils.getRequest().setAttribute("custid", custid);
		return "web";
	}
	/**
	 * 祭祀详情
	 * @return
	 * @throws Exception
	 */
	public String detail()throws Exception{
		getLscode();
		WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/suc/signup!detail.action?custid="+custid+"_id="+_id;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		} 
		DBObject  enity=baseDao.getMessage(PubConstants.SUC_SIGNUP, _id);
		Struts2Utils.getRequest().setAttribute("entity", enity);
		Struts2Utils.getRequest().setAttribute("custid", custid);

		DBObject  share=new BasicDBObject();
		share.put("fxtitle",enity.get("title"));
		share.put("fxsummary",enity.get("summary"));
		share.put("fximg",enity.get("picurl"));
		Struts2Utils.getRequest().setAttribute("share", share);
		return "detail";
	}
	
	@Override
	public Signup getModel() {
		return entity;
	}
	public void set_id(Long _id) {
		this._id = _id;
	}
	/**
	 * ajax列表
	 * @return
	 * @throws Exception 
	 */
	public void ajaxweb() throws Exception { 
		getLscode();
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>(); 
		Map<String, Object> sub_map = new HashMap<String, Object>();
	 
		String sel = Struts2Utils.getParameter("sel");
		if (StringUtils.isNotEmpty(sel)) {
			Pattern pattern = Pattern.compile("^.*" + sel + ".*$",Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern);
			
		}
		sortMap.put("createdate", -1); 
		List<DBObject> proList=baseDao.getList(PubConstants.SUC_SIGNUP,whereMap,fypage,10, sortMap);
		if(proList.size()==0){
			sub_map.put("state", 1);
		}else{
			sub_map.put("state", 0);
		}
		
		sub_map.put("list", proList);
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * ajax报名列表
	 * @return
	 * @throws Exception 
	 */
	public void ajaxcommentweb() throws Exception { 
		getLscode();
		String  id=Struts2Utils.getParameter("id");
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>(); 
		Map<String, Object> sub_map = new HashMap<String, Object>();
	    whereMap.put("wid", Long.parseLong(id));
		sortMap.put("createdate", -1); 
		List<DBObject> proList=baseDao.getList(PubConstants.SUC_SIGNCOMMENT,whereMap,fypage,10, sortMap);
		if(proList.size()==0){
			sub_map.put("state", 1);
		}else{
			sub_map.put("state", 0);
		}
		
		sub_map.put("list", proList);
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * ajax报名
	 * @return
	 * @throws Exception 
	 */
	public void ajaxcommentadd() throws Exception { 
		getLscode();
		String  id=Struts2Utils.getParameter("id"); 
		Map<String, Object> sub_map = new HashMap<String, Object>();
		if(StringUtils.isNotEmpty(id)){
			String  content=Struts2Utils.getParameter("content");
			String  name=Struts2Utils.getParameter("name");
			String  tel=Struts2Utils.getParameter("tel");
			HashMap<String, Object> whereMap =new HashMap<String, Object>(); 
		    whereMap.put("wid", Long.parseLong(id)); 
			Signcomment comment=new Signcomment();
			comment.set_id(mongoSequence.currval(PubConstants.MEMORIAL_COMMENT));
			comment.setContent(content);
			comment.setWid(Long.parseLong(id));
			DBObject  user=wwzService.getWxUser(fromUserid);
			comment.setHeadimgurl(user.get("headimgurl").toString());
			comment.setNickname(user.get("nickname").toString());
			comment.setCustid(custid);
			comment.setFromUserid(fromUserid);
			comment.setName(name);
			comment.setTel(tel);
			baseDao.insert(PubConstants.MEMORIAL_COMMENT, comment);
			sub_map.put("state",0);
		}
		
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	    
	
}


