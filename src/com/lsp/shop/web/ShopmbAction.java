package com.lsp.shop.web;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired; 
import com.alibaba.fastjson.JSON;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction;
import com.lsp.shop.entiy.ShopMb;
import com.lsp.website.service.WwzService;
import com.mongodb.DBObject;
import com.sun.org.apache.commons.beanutils.WrapDynaBean;
/**
 * 模板
 * 
 * @author lsp
 * 
 */
@Namespace("/shop")
@Results({ @Result(name = ShopmbAction.RELOAD, location = "shopmb.action", params={"fypage", "%{fypage}"}, type = "redirect") })
public class ShopmbAction extends GeneralAction<ShopMb> {
	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private ShopMb entity = new ShopMb();;
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
		sortMap.put("_id", -1);  
		whereMap.put("custid", SpringSecurityUtils.getCurrentUser().getId());
	
		List<DBObject> list = baseDao.getList(PubConstants.SHOP_SHOPMB,whereMap, sortMap);
		for (DBObject dbObject : list) {
			dbObject.put("nickname", wwzservice.getCustName(dbObject.get("custid").toString()));
		}
		Struts2Utils.getRequest().setAttribute("shopmbList", list);
		Struts2Utils.getRequest().setAttribute("custid", SpringSecurityUtils.getCurrentUser().getId()); 
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		try {
			custid=SpringSecurityUtils.getCurrentUser().getId();
			baseDao.delete(PubConstants.SHOP_SHOPMB, _id);
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
		
		DBObject db = baseDao.getMessage(PubConstants.SHOP_SHOPMB, _id);

		entity = JSON.parseObject(db.toString(), ShopMb.class);
		entity.set_id((Long) db.get("_id"));
		return "add";
	}
	public void upd() throws Exception {
		DBObject db = baseDao.getMessage(PubConstants.SHOP_SHOPMB, _id);
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}
	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			// 有custId查出来 用户信息
			DBObject db = baseDao.getMessage(PubConstants.SHOP_SHOPMB, _id);

			entity = JSON.parseObject(db.toString(), ShopMb.class);
			entity.set_id((Long) db.get("_id"));
		} else {
			entity = new ShopMb();
		}
	}

	@Override
	public String save() throws Exception {
		// 注册业务逻辑
		try {
			if (_id == null) {
				_id = mongoSequence.currval(PubConstants.SHOP_SHOPMB);
			}
			entity.set_id(_id);
			entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
			baseDao.insert(PubConstants.SHOP_SHOPMB, entity);
			Struts2Utils.getRequest().setAttribute("parentid",
					Struts2Utils.getParameter("parentid"));
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		return RELOAD;
	}

	@Override
	public ShopMb getModel() {
		return entity;
	}

	public void set_id(Long _id) {
		this._id = _id;
	}
    public void  setadminshop(){
    	Map<String, Object> sub_map = new HashMap<String, Object>(); 
		try {
		   String  id=Struts2Utils.getParameter("id");
		   if(StringUtils.isNotEmpty(id)){
			   //验证
			   HashMap<String, Object>whereMap=new HashMap<String, Object>();
			   whereMap.put("lx", 1);
			   whereMap.put("custid",SpringSecurityUtils.getCurrentUser().getId());
			   List<DBObject>list=baseDao.getList(PubConstants.SHOP_SHOPMB, whereMap, null);
			   if(list.size()>0){
				   for (DBObject dbObject : list) {
					   ShopMb  mb=(ShopMb) UniObject.DBObjectToObject(dbObject, ShopMb.class);
					   mb.setLx(0);
					   baseDao.insert(PubConstants.SHOP_SHOPMB, mb);
					   sub_map.put("state", 0);
				}
			   }
			   DBObject  db=baseDao.getMessage(PubConstants.SHOP_SHOPMB, Long.parseLong(id));
			   if(db!=null){
				   ShopMb  mb=(ShopMb) UniObject.DBObjectToObject(db, ShopMb.class);
				   mb.setLx(1);
				   baseDao.insert(PubConstants.SHOP_SHOPMB, mb);
				   sub_map.put("state", 0);
			   }
		   }
		} catch (Exception e) {
			// TODO Auto-generated catch block
			sub_map.put("state", 1);
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    	
    	
    	
    }
}
