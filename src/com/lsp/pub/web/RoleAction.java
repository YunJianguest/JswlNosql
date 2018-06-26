package com.lsp.pub.web;

import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.FuncInfo;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.entity.RoleInfo;
import com.lsp.pub.util.ListUtil;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.user.entity.UserInfo;
import com.lsp.website.service.WwzService;
import com.mongodb.DBObject;
import java.io.IOException; 
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern; 
import net.sf.json.JSONArray;
import net.sf.json.JSONObject; 

import org.apache.activemq.filter.function.splitFunction;
import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
/**
 * 权限管理
 * @author lsp 
 *   
 */ 
@Namespace("/pub")
@Results({@org.apache.struts2.convention.annotation.Result(name="reload", location="role.action", type="redirect")})
public class RoleAction extends GeneralAction<RoleInfo>
{
  private static final long serialVersionUID = -6784469775589971579L;

  @Autowired
  private BaseDao basedao;
  private Long _id;
  private RoleInfo entity = new RoleInfo();
  private MongoSequence mongoSequence;
  @Autowired
  private WwzService  wwzservice; 
  @Autowired
  public void setMongoSequence(MongoSequence mongoSequence)
  {
    this.mongoSequence = mongoSequence;
  }

  public void set_id(Long _id) {
    this._id = _id;
  }

  public String execute() throws Exception {
    HashMap<String, Object> sortMap = new HashMap<String, Object>();
    HashMap<String, Object> whereMap = new HashMap<String, Object>();
    sortMap.put("sort", Integer.valueOf(-1));
    if ((Struts2Utils.getParameter("fypage") != null) && 
      (!Struts2Utils.getParameter("fypage").endsWith(""))) {
      this.fypage = Integer.parseInt(Struts2Utils.getParameter("fypage"));
      Struts2Utils.getRequest().setAttribute("fypage", Integer.valueOf(this.fypage));
    }
    String title = Struts2Utils.getParameter("title");
    if (StringUtils.isNotEmpty(title)) {
      Pattern pattern = Pattern.compile("^.*" + title + ".*$", 
        2);
      whereMap.put("rolename", pattern);
      Struts2Utils.getRequest().setAttribute("title", title);
    }
    if(!SpringSecurityUtils.getCurrentUser().getId().equals("chongzi")){
    	 whereMap.put("custid",SpringSecurityUtils.getCurrentUser().getId());
    }
   
    List<DBObject> list = this.basedao.getList(PubConstants.ROLE_INFO, whereMap, this.fypage, 10, sortMap);
    for (DBObject dbObject : list) {
		//dbObject.put("nickname", wwzservice.getCustName(dbObject.get("custid").toString()));
	}
    Struts2Utils.getRequest().setAttribute("roleList", list);
    Struts2Utils.getRequest().setAttribute("custid",SpringSecurityUtils.getCurrentUser().getId());
    this.fycount = this.basedao.getCount(PubConstants.ROLE_INFO,whereMap);
    Struts2Utils.getRequest().setAttribute("fycount", Long.valueOf(this.fycount));
    return "success";
  }

  public String input()
    throws Exception
  {
    return "add";
  }

  public String update()
    throws Exception
  {
    return "add";
  }

  public String save() throws Exception
  {
    try
    {
      if (this._id == null)
      {
        this._id = this.mongoSequence.currval(PubConstants.ROLE_INFO);
      }

      entity.set_id(this._id); 
      entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
      entity.setCreatedate(new Date());
      String ls = Struts2Utils.getParameter("funclist"); 
      String[] s = ls.split(",");
      List<Long> lsfunc = new ArrayList<Long>();
      for (int i = 0; i < s.length; i++) {
        lsfunc.add(Long.valueOf(Long.parseLong(s[i])));
      }
      entity.setFuncList(lsfunc);
      basedao.insert(PubConstants.ROLE_INFO, entity);
      addActionMessage("添加成功!");
    }
    catch (Exception e) {
      e.printStackTrace();
      addActionMessage("添加失败!");
    }
    return "reload";
  }

  public String delete() throws Exception
  {
    try
    {
      if (this._id != null) {
        this.basedao.delete(PubConstants.ROLE_INFO, this._id);
        addActionMessage("添加成功");
      }
    }
    catch (Exception e)
    {
      e.printStackTrace();
      addActionMessage("添加失败");
    }
    return "reload";
  }

  protected void prepareModel()
    throws Exception
  {
    if (this._id != null)
    {
      DBObject emDbObject = this.basedao.getMessage(PubConstants.ROLE_INFO, 
        this._id);
      this.entity = ((RoleInfo)UniObject.DBObjectToObject(emDbObject, 
        RoleInfo.class));
    } else {
      this.entity = new RoleInfo();
    }
  }

  public RoleInfo getModel()
  {
    return this.entity;
  }

  public void getfunclist() {
    HashMap<String, Object> sortMap = new HashMap<String, Object>();
    sortMap.put("sort", Integer.valueOf(-1));
    List<Map<String, Object>> items = new ArrayList<Map<String, Object>>(); 
    DBObject  db=basedao.getMessage(PubConstants.ROLE_INFO, SpringSecurityUtils.getCurrentUser().getRoleid()); 
    RoleInfo role=(RoleInfo) UniObject.DBObjectToObject(db, RoleInfo.class);
    List<Long>lslong=role.getFuncList();
    List<DBObject> list=new ArrayList<DBObject>();
    if(lslong!=null){
    	for (int i = 0; i < lslong.size(); i++) {  
    		DBObject func=basedao.getMessage(PubConstants.FUNC_INFO,Long.parseLong(lslong.get(i)+""));
	    	if(func!=null){
	    		list.add(func);
	    	}
		} 
    	
    	for (int i = 0; i < list.size(); i++)
        {
          Map<String, Object> item = new HashMap<String, Object>();
          FuncInfo entity = (FuncInfo)UniObject.DBObjectToObject((DBObject)list.get(i), 
            FuncInfo.class);
          if (entity.getParentid().longValue() == 0L)
          {
            item.put("id", entity.get_id());
            item.put("name", entity.getName());
            item.put("isParent", Boolean.valueOf(true));

            if (entity.getTfunc() != null) {
              List<FuncInfo> listfunc = entity.getTfunc();
              List<Map<String, Object>> childitems = new ArrayList<Map<String, Object>>();

              for (int j = 0; j < listfunc.size(); j++)
              {
                FuncInfo childfunc = (FuncInfo)JSONObject.toBean(JSONObject.fromObject(listfunc.get(j)), FuncInfo.class);
                Map<String, Object> childitem = new HashMap<String, Object>();
                childitem.put("id", childfunc.get_id());
                childitem.put("name", childfunc.getName());

                DBObject emDbObject11 = this.basedao.getMessage(PubConstants.FUNC_INFO, 
                  Long.valueOf(Long.parseLong(childfunc.get_id().toString())));
                FuncInfo entity11 = (FuncInfo)UniObject.DBObjectToObject(emDbObject11, 
                  FuncInfo.class); 
                if (entity11.getTfunc() != null)
                {
                  childitem.put("isParent", Boolean.valueOf(true));
                  List<FuncInfo> listfunc1 = entity11.getTfunc();
                  List<Map<String, Object>> childitems1 = new ArrayList<Map<String, Object>>();

                  for (int k = 0; k < listfunc1.size(); k++) {
                    FuncInfo childfunc1 = (FuncInfo)JSONObject.toBean(JSONObject.fromObject(listfunc1.get(k)), FuncInfo.class);
                    Map<String, Object> childitem1 = new HashMap<String, Object>();
                    childitem1.put("id", childfunc1.get_id());
                    childitem1.put("name", childfunc1.getName());
                    if(ListUtil.isEmpty(lslong, Long.parseLong(childfunc1.get_id().toString()))){
                    	 childitems1.add(childitem1);
                    }
                   
                  }
                 
                  childitem.put("children", childitems1);  
                 
                 
                }
                if(ListUtil.isEmpty(lslong, Long.parseLong(childfunc.get_id().toString()))){

                    childitems.add(childitem);
                }

              }

              item.put("children", childitems);
            }

            items.add(item);
          }

        }
    } 
   if(SpringSecurityUtils.getCurrentUser().getId().equals("js")){
	   list= this.basedao.getList(PubConstants.FUNC_INFO, null, sortMap); 
	   for (int i = 0; i < list.size(); i++)
	    {
	      Map<String, Object> item = new HashMap<String, Object>();
	      FuncInfo entity = (FuncInfo)UniObject.DBObjectToObject((DBObject)list.get(i), 
	        FuncInfo.class);
	      if (entity.getParentid().longValue() == 0L)
	      {
	        item.put("id", entity.get_id());
	        item.put("name", entity.getName());
	        item.put("isParent", Boolean.valueOf(true));

	        if (entity.getTfunc() != null) {
	          List<FuncInfo> listfunc = entity.getTfunc();
	          List<Map<String, Object>> childitems = new ArrayList<Map<String, Object>>();

	          for (int j = 0; j < listfunc.size(); j++)
	          {
	            FuncInfo childfunc = (FuncInfo)JSONObject.toBean(JSONObject.fromObject(listfunc.get(j)), FuncInfo.class);
	            Map<String, Object> childitem = new HashMap<String, Object>();
	            childitem.put("id", childfunc.get_id());
	            childitem.put("name", childfunc.getName());

	            DBObject emDbObject11 = this.basedao.getMessage(PubConstants.FUNC_INFO, 
	              Long.valueOf(Long.parseLong(childfunc.get_id().toString())));
	            FuncInfo entity11 = (FuncInfo)UniObject.DBObjectToObject(emDbObject11, 
	              FuncInfo.class); 
	            if (entity11.getTfunc() != null)
	            {
	              childitem.put("isParent", Boolean.valueOf(true));
	              List<FuncInfo> listfunc1 = entity11.getTfunc();
	              List<Map<String, Object>> childitems1 = new ArrayList<Map<String, Object>>();

	              for (int k = 0; k < listfunc1.size(); k++) {
	                FuncInfo childfunc1 = (FuncInfo)JSONObject.toBean(JSONObject.fromObject(listfunc1.get(k)), FuncInfo.class);
	                Map<String, Object> childitem1 = new HashMap<String, Object>();
	                childitem1.put("id", childfunc1.get_id());
	                childitem1.put("name", childfunc1.getName());

	                childitems1.add(childitem1);
	              }
	              childitem.put("children", childitems1);
	            }

	            childitems.add(childitem);
	          }

	          item.put("children", childitems);
	        }

	        items.add(item);
	      }

	    }
   }
    

    JSONArray json = JSONArray.fromObject(items);

    try
    {
      Struts2Utils.getResponse().getWriter().print(json.toString());
    }
    catch (IOException e) {
      e.printStackTrace();
    }
  }
}