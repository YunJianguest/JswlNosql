package com.lsp.suc.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.swing.plaf.ListUI;

import net.sf.json.JSONArray;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.ListUtil;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction;
import com.lsp.suc.entity.GraphicInfo; 
import com.lsp.suc.entity.GraphiclmInfo;
import com.lsp.web.entity.FolderInfo;
import com.lsp.website.entity.CommentInfo;
import com.lsp.website.entity.Readinginfo;
import com.lsp.website.service.WebsiteService;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
/**
 * 图文管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results({@org.apache.struts2.convention.annotation.Result(name="reload", location="graphic.action",params={"fypage","%{fypage}",}, type="redirect")})
public class GraphicAction  extends GeneralAction<GraphicInfo>{

	private static final long serialVersionUID = -6784469775589971579L;

	  @Autowired
	  private BaseDao basedao;
	  private Long _id;
	  private GraphicInfo entity = new GraphicInfo();
	  private MongoSequence mongoSequence;
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
		    custid=SpringSecurityUtils.getCurrentUser().getId();
		    HashMap<String, Object> sortMap =new HashMap<String, Object>();
			HashMap<String, Object> whereMap =new HashMap<String, Object>();
			HashMap<String, Object> backMap =new HashMap<String, Object>(); 
			String type=Struts2Utils.getParameter("type");
			if(StringUtils.isNotEmpty(type)){
				whereMap.put("type",  type);
			} 
			
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
			backMap.put("context", 0);
			
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			
			List<DBObject> list=basedao.getList(PubConstants.GRAPHIC_INFO,whereMap,fypage,10,sortMap,backMap);
			fycount=basedao.getCount(PubConstants.GRAPHIC_INFO,whereMap);
			System.out.println(list.size());  
			Struts2Utils.getRequest().setAttribute("graphicList", list);
			Struts2Utils.getRequest().setAttribute("custid", custid); 
		  return SUCCESS;
	  }
	@Override
	public String input() throws Exception { 
		HashMap<String,Object>whereMap=new HashMap<>();
		HashMap<String,Object>sortMap=new HashMap<>();
		custid=SpringSecurityUtils.getCurrentUser().getId();
		whereMap.put("custid",custid);
		sortMap.put("createdate", -1);
		List<DBObject>typelist=basedao.getList(PubConstants.GRAPHICLM_INFO, whereMap,0,500,sortMap);
		Struts2Utils.getRequest().setAttribute("typelist", typelist);
		
		return "add";
	}

	@Override
	public GraphicInfo getModel() {
		// TODO Auto-generated method stub
		return entity;
	}
	@Override
	public String update() throws Exception {
		// TODO Auto-generated method stub 
		HashMap<String,Object>whereMap=new HashMap<>();
		HashMap<String,Object>sortMap=new HashMap<>();
		custid=SpringSecurityUtils.getCurrentUser().getId();
		whereMap.put("custid",custid);
		sortMap.put("createdate", -1);
		List<DBObject>typelist=basedao.getList(PubConstants.GRAPHICLM_INFO, whereMap,0,500,sortMap);
		Struts2Utils.getRequest().setAttribute("typelist", typelist);
		DBObject db=basedao.getMessage(PubConstants.GRAPHIC_INFO,_id);
		Struts2Utils.getRequest().setAttribute("entity", db); 
		return "add";
	}

	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id==null){
				_id=mongoSequence.currval(PubConstants.GRAPHIC_INFO);
			}
			custid=SpringSecurityUtils.getCurrentUser().getId();
			entity.set_id(_id);
			entity.setCustid(custid);
			entity.setCreatedate(new Date());
			
			System.out.println(entity.get_id());
			System.out.println(entity.getCustid());
			basedao.insert(PubConstants.GRAPHIC_INFO, entity);
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
				basedao.delete(PubConstants.GRAPHIC_INFO,_id);
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
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		
		try {
			if(_id!=null){
				DBObject db=basedao.getMessage(PubConstants.GRAPHIC_INFO, _id);
				entity= (GraphicInfo) UniObject.DBObjectToObject(db, GraphicInfo.class);
			}else{
				entity=new GraphicInfo();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	

}
