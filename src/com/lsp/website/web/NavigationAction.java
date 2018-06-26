package com.lsp.website.web;
 

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction;
import com.lsp.website.entity.NavigationInfo; 
import com.mongodb.DBObject;

/**
 * 导航条管理
 * @author lsp
 *
 */
@Namespace("/website")
@Results({@org.apache.struts2.convention.annotation.Result(name="reload", location="navigation.action", type="redirect")})
public class NavigationAction extends GeneralAction<NavigationInfo> {

	private static final long serialVersionUID = -6784469775589971579L;

	  @Autowired
	  private BaseDao basedao;
	  private Long _id;
	  private NavigationInfo entity = new NavigationInfo();
	  private MongoSequence mongoSequence;

	  @Autowired
	  public void setMongoSequence(MongoSequence mongoSequence)
	  {
	    this.mongoSequence = mongoSequence;
	  }

	  public void set_id(Long _id) {
	    this._id = _id;
	  }
	  public String execute() throws Exception{
		
		  return SUCCESS;
	  }
	@Override
	public String input() throws Exception {
		
		return "add";
	}

	@Override
	public String update() throws Exception {
		// TODO Auto-generated method stub
		return "add";
	}

	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id==null){
				_id=mongoSequence.currval(PubConstants.NAVIGATION_INFO);
			}
			entity.set_id(_id);
			String webid=Struts2Utils.getParameter("webid");
			if(StringUtils.isNotEmpty(webid)){
				entity.setWebid(Long.parseLong(webid));
			}
			basedao.insert(PubConstants.NAVIGATION_INFO, entity);
			addActionMessage("添加成功!");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			addActionMessage("添加失败!");
		}
		
		return RELOAD;
	}
	

	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id!=null){
				basedao.delete(PubConstants.NAVIGATION_INFO,_id);
			}
			addActionMessage("删除成功！");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			addActionMessage("删除失败！");
		}
		return RELOAD;
	}

	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		if(_id!=null){
			  DBObject emDbObject = this.basedao.getMessage(PubConstants.NAVIGATION_INFO, 
				        this._id);
				        this.entity = ((NavigationInfo)UniObject.DBObjectToObject(emDbObject, 
				        		NavigationInfo.class));
		}else{
			entity=new NavigationInfo();
		}
		
	}
	public NavigationInfo getModel()
	  {
	    return this.entity;
	  }

}
