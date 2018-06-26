package com.lsp.suc.web;

import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.ExportExcel;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction;
import com.lsp.suc.entity.GraphiclmInfo;
import com.lsp.suc.entity.Housecomment;
import com.lsp.website.service.WebsiteService;
import com.lsp.website.service.WwzService;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;

/**
 * 城市评论
 * @author lsp
 *
 */
@Namespace("/suc")
@Results({@org.apache.struts2.convention.annotation.Result(name="reload", location="housecomment.action",params={"parentid", "%{parentid}"},  type="redirect")})
public class HousecommentAction extends GeneralAction<Housecomment>{


	private static final long serialVersionUID = -6784469775589971579L;

	  @Autowired
	  private BaseDao basedao;
	  private Long _id;
	  private Housecomment entity = new Housecomment();
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
			
			toUser=SpringSecurityUtils.getCurrentUser().getToUser();
			sortMap.put("sort", -1); 
			String parentid=Struts2Utils.getParameter("parentid"); 
			if(StringUtils.isNotEmpty(parentid)){
				whereMap.put("parentid", Long.parseLong(parentid));
			}
			String name=Struts2Utils.getParameter("name");
			if(StringUtils.isNotEmpty(name)){
				Pattern pattern = Pattern.compile("^.*" + name + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("content", pattern);
				Struts2Utils.getRequest().setAttribute("name",  name);
			} 
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			
			List<DBObject> list=basedao.getList(PubConstants.SUC_HOUSECOMMENT,whereMap,fypage,10,sortMap,backMap);
			fycount=basedao.getCount(PubConstants.SUC_HOUSECOMMENT,whereMap);
			Struts2Utils.getRequest().setAttribute("list", list);
			Struts2Utils.getRequest().setAttribute("toUser", toUser);
			
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
				_id=mongoSequence.currval(PubConstants.SUC_HOUSECOMMENT);
			} 
			entity.set_id(_id);
			entity.setToUser(SpringSecurityUtils.getCurrentUser().getToUser());
			entity.setCreatedate(new Date()); 
			
			basedao.insert(PubConstants.SUC_HOUSECOMMENT, entity);
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
				basedao.delete(PubConstants.SUC_HOUSECOMMENT,_id);
				Struts2Utils.getRequest().setAttribute("parentid",Struts2Utils.getParameter("parentid"));
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
	public Housecomment getModel() {
		// TODO Auto-generated method stub
		return entity;
	}
	public String deleteAll() throws Exception {
		// TODO Auto-generated method stub
		try {
			 
				basedao.delete(PubConstants.SUC_HOUSECOMMENT);
				System.out.println("ddd");
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
				DBObject db=basedao.getMessage(PubConstants.SUC_HOUSECOMMENT, _id);
				entity= (Housecomment) UniObject.DBObjectToObject(db, Housecomment.class);
			}else{
				entity=new Housecomment();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	public void  upd(){
		String id=Struts2Utils.getParameter("id"); 
		DBObject db=basedao.getMessage(PubConstants.SUC_HOUSECOMMENT, Long.parseLong(id)); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
		
	}
	public  String   web(){
		lscode=getLscode(); 
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		 
		wwzService.flow(toUser, "wxmenu-graphic");
		
	 
		sortMap.put("sort", -1);
		
		whereMap.put("toUser", toUser);
		
		List<DBObject> graphic=basedao.getList(PubConstants.SUC_HOUSECOMMENT,whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("graphicList", graphic);
		
		DBObject bqsel=new BasicDBObject();
		bqsel.put("title", "搜索");
		bqsel.put("marker", "fa-search");
		
		Struts2Utils.getRequest().setAttribute("bqsel", bqsel);
		 
		Struts2Utils.getRequest().setAttribute("advertisement", wwzService.advertisement(toUser, "graphic"));
		return "web";
	}
	/**
	 * ajax
	 */
	public  void   ajaxweb(){
	    lscode=getLscode();
	    custid=getCustid();
		String parentid=Struts2Utils.getParameter("parentid");   
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		 
		 
		whereMap.put("parentid", Long.parseLong(parentid));
		
		if(Struts2Utils.getParameter("fypage")!=null){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		sortMap.put("sort", -1);
		List<DBObject> comList=basedao.getList(PubConstants.SUC_HOUSECOMMENT, whereMap,fypage,10, sortMap);
		 
		if(comList.size()>0){
			sub_map.put("state", 0);
		}else{
			sub_map.put("state", 1);
		}
		
		sub_map.put("list", comList);
		String json = JSONArray.fromObject(sub_map).toString();
		 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
    
	 
	/**
	 * ajax添加
	 */
	public  void   ajaxsave(){

		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		custid=getCustid();
		lscode=getLscode();
		try {
			DBObject user=wwzService.getWxUser(fromUserid);
			if(user.get("_id").equals("notlogin")){
				sub_map.put("state", 3);
				String json = JSONArray.fromObject(sub_map).toString(); 
				Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
				return;
			}
			System.out.println(user);
			String   parentid=Struts2Utils.getParameter("parentid");
			String   content=Struts2Utils.getParameter("content"); 
			HashMap<String, Object>whereMap=new HashMap<String, Object>(); 
			whereMap.put("parentid", Long.parseLong(parentid));
			Housecomment  com=new Housecomment();
			com.set_id(mongoSequence.currval(PubConstants.SUC_HOUSECOMMENT));
			com.setContent(content);
			com.setCreatedate(new Date());
			com.setParentid(Long.parseLong(parentid)); 
			com.setFromUserid(fromUserid);
			com.setPraise(0);
			com.setSort(basedao.getCount(PubConstants.SUC_HOUSECOMMENT,whereMap)+1);
			com.setHeadimg(user.get("headimgurl").toString());
			com.setName(user.get("nickname").toString());
			basedao.insert(PubConstants.SUC_HOUSECOMMENT, com);
			sub_map.put("state", 0);
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			sub_map.put("state", 1);
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString();
		 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 导出评论
	 * @throws Exception
	 */
	public void commentexp() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		
		
		whereMap.put("parentid", Long.parseLong(Struts2Utils.getParameter("parentid")));
		sortMap.put("insdate", -1);
		if(Struts2Utils.getParameter("fypage")!=null){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		fycount=basedao.getCount(PubConstants.SUC_HOUSECOMMENT, whereMap);
		List<DBObject> list=basedao.getList(PubConstants.SUC_HOUSECOMMENT,whereMap, sortMap);
	 
		String[] header={ "编号","姓名", "留言","日期"};  
		String[] body={ "_id","name", "content", "createdate"}; 
		
		String newtime = new Date().getTime() + ".xls";
		
		HSSFWorkbook wb = ExportExcel.exportByMongo(list, header, body, newtime);  
		Struts2Utils.getResponse().setHeader("Content-disposition", "attachment;filename="
				+ URLEncoder.encode(newtime, "utf-8"));
        OutputStream ouputStream = Struts2Utils.getResponse().getOutputStream();  
        wb.write(ouputStream);  
        ouputStream.flush();  
        ouputStream.close();  
	}

}
