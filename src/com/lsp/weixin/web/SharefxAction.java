package com.lsp.weixin.web;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

 
import com.alibaba.fastjson.JSON;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.entity.PubConstants; 
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction;
import com.lsp.suc.entity.Share;
import com.mongodb.DBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
@Namespace("/weixin")
@Results({ @Result(name = SharefxAction.RELOAD, location = "sharefx.action", type = "redirect") })
public class SharefxAction extends GeneralAction<Share> {
	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private Share entity = new Share();;
	private String _id;

	
	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		sortMap.put("sort", 1);
		
		toUser=SpringSecurityUtils.getCurrentUser().getToUser();
		whereMap.put("toUser",toUser );
	
		List<DBObject> list = baseDao.getList(PubConstants.WEIXIN_SHAREFX,whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("shareList", list);
		
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		try {
			
			baseDao.delete(PubConstants.WEIXIN_SHAREFX, _id);
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
		
		DBObject db = baseDao.getMessage(PubConstants.WEIXIN_SHAREFX, _id);

		entity = JSON.parseObject(db.toString(), Share.class);
		entity.set_id((Long) db.get("_id"));
		return "add";
	}
	public void upd() throws Exception {
		String fxtype=Struts2Utils.getParameter("fxtype");
		custid=SpringSecurityUtils.getCurrentUser().getId(); 
		DBObject db = baseDao.getMessage(PubConstants.WEIXIN_SHAREFX, custid+"-"+fxtype); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}
	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			// 有custId查出来 用户信息
			DBObject db = baseDao.getMessage(PubConstants.WEIXIN_SHAREFX, _id);

			entity = JSON.parseObject(db.toString(), Share.class);
			entity.set_id((Long) db.get("_id"));
		} else {
			entity = new Share();
		}
	}

	@Override
	public String save() throws Exception {
		// 注册业务逻辑
		try {
			toUser=SpringSecurityUtils.getCurrentUser().getToUser();
			
			entity.set_id(toUser+"-"+entity.getFxtype());
			entity.setInsdate(new Date());
			entity.setToUser(toUser);
			baseDao.insert(PubConstants.WEIXIN_SHAREFX, entity);
			
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		return RELOAD;
	}
	public void ajaxsave() throws Exception {
		Map<String, Object> sub_map = new HashMap<String, Object>();
			try {
				
				custid=SpringSecurityUtils.getCurrentUser().getId();
				Share  obj=null;  
				DBObject  db=baseDao.getMessage(PubConstants.WEIXIN_SHAREFX,custid+"-"+Struts2Utils.getParameter("fxtype"));
				if(db!=null){ 
					obj=(Share) UniObject.DBObjectToObject(obj, Share.class);
					obj.set_id(custid+"-"+Struts2Utils.getParameter("fxtype"));
				}else{
					obj=new Share();
					obj.set_id(custid+"-"+Struts2Utils.getParameter("fxtype"));
				} 
				obj.setInsdate(new Date());
				obj.setToUser(SpringSecurityUtils.getCurrentUser().getToUser());
				obj.setFximg(Struts2Utils.getParameter("fximg"));
				obj.setFxmb(Integer.parseInt(Struts2Utils.getParameter("fxmb")));
				obj.setFxsummary(Struts2Utils.getParameter("fxsummary"));
				obj.setFxtitle(Struts2Utils.getParameter("fxtitle")); 
				obj.setFxurl(Struts2Utils.getParameter("fxurl"));
				baseDao.insert(PubConstants.WEIXIN_SHAREFX, obj);

				sub_map.put("state", 0);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				sub_map.put("state", 1);
				e.printStackTrace();
			}
			String json = JSONArray.fromObject(sub_map).toString();
			
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	@Override
	public Share getModel() {
		return entity;
	}

	public void set_id(String _id) {
		this._id = _id;
	}
}
