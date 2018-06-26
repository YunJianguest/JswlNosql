package com.lsp.suc.web;

import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

 
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction;
import com.lsp.suc.entity.DrawboxYzm;
import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
 
/**
 * 图文资源管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name = DrawboxyzmAction.RELOAD, location = "drawboxyzm.action",params={"wid", "%{wid}"}, type = "redirect") })
public class DrawboxyzmAction extends GeneralAction<DrawboxYzm> {

	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private MongoSequence mongoSequence;	
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}

	private DrawboxYzm entity=new DrawboxYzm();
	private String _id;


	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		
		String wid=Struts2Utils.getParameter("wid");
		whereMap.put("wid", Long.parseLong(wid));
		
		sortMap.put("sort", 1);
		fycount=baseDao.getCount(PubConstants.WHD_DRAWBOXYZM, whereMap);
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject> list=baseDao.getList(PubConstants.WHD_DRAWBOXYZM,whereMap,fypage,10, sortMap);
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
				if(user.get("name")!=null){
					db.put("name", user.get("name").toString());
				}
			}
			}
				
		}
		Struts2Utils.getRequest().setAttribute("predeList", list);
		
		Struts2Utils.getRequest().setAttribute("wid", wid);
		return SUCCESS;
	}
	
	
	@Override
	public String delete() throws Exception {
		try {
			baseDao.delete(PubConstants.WHD_DRAWBOXYZM,_id);
			addActionMessage("成功删除!");
			
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,删除过程中出现异常!");
		}
		return RELOAD;
	}
	public void delall() throws Exception {
		String[] id=Struts2Utils.getParameter("ids").split(",");
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		BasicDBList dbList=new BasicDBList();  //翻译数组对象
		for(int i=0;i<id.length;i++){
			if(StringUtils.isEmpty(id[i])||id[i].equals("ck")){
				
			}else{
				dbList.add(id[i]);
			}
		}
		whereMap.put("_id", new BasicDBObject("$in",dbList));
		baseDao.delete(PubConstants.WHD_DRAWBOXYZM, whereMap);
		
	}
 
	@Override
	public String input() throws Exception {
		
		return "add";
	}

		public String imp() throws Exception {
			
			return "imp";
		}
	
	@Override
	public String update() throws Exception {	
		
		return "add";
	}
	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			//有custId查出来 用户信息
			entity = (DrawboxYzm)UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.WHD_DRAWBOXYZM,_id),DrawboxYzm.class);
		} else {
			entity = new DrawboxYzm();
		}
	}
	


	@Override
	public String save() throws Exception {
		//注册业务逻辑
		try {
			
			
			entity.set_id(_id);
		
			baseDao.insert(PubConstants.WHD_DRAWBOXYZM,entity);
			addActionMessage("成功添加!");

		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return RELOAD;
	}
	
	@Override
	public DrawboxYzm getModel() {
		return entity;
	}
	public void set_id(String _id) {
		this._id = _id;
	}
}
