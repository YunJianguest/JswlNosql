package com.lsp.suc.web;

import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.activemq.filter.function.splitFunction;
import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results;
import org.apache.velocity.tools.generic.ClassTool.Sub;
import org.springframework.beans.factory.annotation.Autowired;

import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.entity.WxToken;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.web.GeneralAction; 
import com.lsp.suc.entity.GraphicInfo;
import com.lsp.suc.entity.GraphiclmInfo;
import com.lsp.suc.entity.Tourism;
 
import com.lsp.website.service.WebsiteService;
import com.lsp.website.service.WwzService;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
/**
 * 图文栏目
 * @author lsp
 *
 */
@Namespace("/suc")
@Results({@org.apache.struts2.convention.annotation.Result(name="reload", location="graphiclm.action", params={"fypage", "%{fypage}",}, type="redirect")})
public class GraphiclmAction extends GeneralAction<GraphiclmInfo>{

	private static final long serialVersionUID = -6784469775589971579L;

	  @Autowired
	  private BaseDao basedao;
	  private Long _id;
	  private GraphiclmInfo entity = new GraphiclmInfo();
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
			 
			backMap.put("summary", 0);
			
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			
			List<DBObject> list=basedao.getList(PubConstants.GRAPHICLM_INFO,whereMap,fypage,10,sortMap,backMap);
			fycount=basedao.getCount(PubConstants.GRAPHICLM_INFO,whereMap);
			Struts2Utils.getRequest().setAttribute("graphiclmList", list);
			Struts2Utils.getRequest().setAttribute("custid", custid);
			
		  return SUCCESS;
	  }
	@Override
	public String input() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String update() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id==null){
				_id=mongoSequence.currval(PubConstants.GRAPHICLM_INFO);
			}
			custid=SpringSecurityUtils.getCurrentUser().getId();
			entity.set_id(_id);
			entity.setCustid(custid);
			entity.setCreatedate(new Date()); 
			
			basedao.insert(PubConstants.GRAPHICLM_INFO, entity);
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
		try {
			if(_id!=null){
				custid=SpringSecurityUtils.getCurrentUser().getId();
				basedao.delete(PubConstants.GRAPHICLM_INFO,_id);
				addActionMessage("删除成功");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			addActionMessage("删除失败");
		}
		return RELOAD;
	}
	@Override
	public GraphiclmInfo getModel() {
		// TODO Auto-generated method stub
		return entity;
	}
	public String deleteAll() throws Exception {
		// TODO Auto-generated method stub
		try {
			     custid=SpringSecurityUtils.getCurrentUser().getId();
				//basedao.delete(PubConstants.GRAPHICLM_INFO); 
				addActionMessage("删除成功");
			 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			addActionMessage("删除失败");
		}
		return RELOAD;
	}

	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		
		try {
			if(_id!=null){
				DBObject db=basedao.getMessage(PubConstants.GRAPHICLM_INFO, _id);
				entity= (GraphiclmInfo) UniObject.DBObjectToObject(db, GraphiclmInfo.class);
			}else{
				entity=new GraphiclmInfo();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	public void  upd(){
		String id=Struts2Utils.getParameter("id"); 
		DBObject db=basedao.getMessage(PubConstants.GRAPHICLM_INFO, Long.parseLong(id)); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
		
	}
	public  String   web(){
		getLscode();  
		wwzService.flow(custid, "wxmenu-graphic");
		WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		}
		String type=Struts2Utils.getParameter("type"); 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/suc/graphiclm!web.action?custid="+custid+"&type="+type;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}
		Struts2Utils.getRequest().setAttribute("slide", wwzService.slide(custid, "graphiclm-"+type));
		DBObject  db=basedao.getMessage(PubConstants.GRAPHICLM_INFO, Long.parseLong(type));
		DBObject  share=new BasicDBObject();
		share.put("fxtitle",db.get("title"));
		share.put("fxsummary",db.get("summary"));
		share.put("fxpicurl",db.get("picurl"));
		share.put("fxurl", url);
		Struts2Utils.getRequest().setAttribute("share",share);
		if(db.get("mb")!=null){
			return "web"+db.get("mb");
		}
		return "web";
	}
	/**
	 * 图文详情
	 * @return
	 */
	public  String   detail(){
		getLscode();
		String id=Struts2Utils.getParameter("id");
		WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/suc/graphiclm!detail.action?custid="+custid+"&id="+id;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}
		Struts2Utils.getRequest().setAttribute("slide", wwzService.slide(custid, "graphic-"+id));
		DBObject  db=basedao.getMessage(PubConstants.GRAPHIC_INFO, Long.parseLong(id));
		ajaxreading(id);
		DBObject  share=new BasicDBObject();
		share.put("fxtitle",db.get("title"));
		share.put("fxsummary",db.get("summary"));
		share.put("fxpicurl",db.get("picurl"));
		share.put("fxurl", url);
		Struts2Utils.getRequest().setAttribute("share",share);
		Struts2Utils.getRequest().setAttribute("entity",db);
		if(db.get("mb")!=null){
			return "detail"+db.get("mb");
		}
		return "detail";
	}
	/**
	 * 图文详情
	 * @return
	 */
	public  String   detailcss(){ 
		String id=Struts2Utils.getParameter("id"); 
		DBObject  db=basedao.getMessage(PubConstants.GRAPHIC_INFO, Long.parseLong(id)); 
		Struts2Utils.getRequest().setAttribute("entity",db);
		if(db.get("mb")!=null){
			return "detail"+db.get("mb");
		}
		return "detail";
	}
	/**
	 * ajax
	 */
	public  void   ajaxweb(){
		getLscode();
		String sel=Struts2Utils.getParameter("sel"); 
		String type=Struts2Utils.getParameter("type");
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		
		if(StringUtils.isNotEmpty(sel)){
			Pattern pattern = Pattern.compile("^.*" + sel + ".*$",Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern);
		} 
		String sortby=Struts2Utils.getParameter("sortby");
		if(sortby==null){
			sortMap.put("createdate", -1);
		}else if(sortby.equals("1")){
			sortMap.put("sort", -1);
		}else{
			sortMap.put("sort", -1);
		} 
		whereMap.put("custid", custid);
		whereMap.put("type", Long.parseLong(type));
		if(Struts2Utils.getParameter("fypage")!=null){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		
		List<DBObject> comList=basedao.getList(PubConstants.GRAPHIC_INFO, whereMap,fypage,10, sortMap);
		 
		for(DBObject db:comList){
			if(db.get("createdate")!=null){
				db.put("createdate", DateFormat.getSampleDate(DateFormat.getFormat(db.get("createdate").toString())));
			}
		  	 
		}
		if(comList.size()>0){
			sub_map.put("state", 0);
		}else{
			sub_map.put("state", 1);
		}
		
		sub_map.put("list", comList);
		String json = JSONArray.fromObject(sub_map).toString();
		 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
    
	public   void    ajaxreading(String id){   
	    if(StringUtils.isNotEmpty(id)){
	    	DBObject db=basedao.getMessage(PubConstants.GRAPHIC_INFO, Long.parseLong(id));
	    	if(db!=null){
	    		GraphicInfo graphicInfo=(GraphicInfo) UniObject.DBObjectToObject(db, GraphicInfo.class);
	    		graphicInfo.setSort(graphicInfo.getSort()+1);
	    		basedao.insert(PubConstants.GRAPHIC_INFO, graphicInfo);  
	    	}
	    } 	
	}

}
