package com.lsp.shop.web;

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
 
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.DictionaryUtil;
import com.lsp.pub.util.ListUtil;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction;
import com.lsp.shop.entiy.OrderForm;
import com.mongodb.DBObject;
 
/**
 * 订单统计
 * @author lsp
 *
 */
@Namespace("/shop")
@Results( { @Result(name = ShopstatisticalAction.RELOAD, location = "shopstatistical.action", type = "redirect") })
public class ShopstatisticalAction extends GeneralAction<OrderForm> {

	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	
	@Autowired
	private DictionaryUtil dictionaryUtil;
	private OrderForm entity=new OrderForm();
	private String _id;


	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();

	 
		String  comid=Struts2Utils.getParameter("comid");
		if(StringUtils.isNotEmpty(comid)){
			whereMap.put("comid", Long.parseLong(comid));
		}
		String  name=Struts2Utils.getParameter("name");
		if(StringUtils.isNotEmpty(name))
		{
			Pattern pattern = Pattern.compile("^.*" + name + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("name", pattern);
			Struts2Utils.getRequest().setAttribute("name",  name);
		}
		String  no=Struts2Utils.getParameter("no");
		if(StringUtils.isNotEmpty(no))
		{
			whereMap.put("no", no);
			Struts2Utils.getRequest().setAttribute("no",  no);
		}
		String  tel=Struts2Utils.getParameter("tel");
		if(StringUtils.isNotEmpty(tel))
		{
			whereMap.put("tel", tel);
			Struts2Utils.getRequest().setAttribute("tel",  tel);
		}
		
		sortMap.put("insDate", -1);
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		fycount=baseDao.getCount(PubConstants.WX_ORDERFORM, whereMap);
		List<DBObject> list=baseDao.getList(PubConstants.WX_ORDERFORM,whereMap,fypage,10, sortMap);
		for(DBObject db:list){
			if(db.get("fromUser")!=null){
				DBObject userdb=baseDao.getMessage(PubConstants.CUSTOMER_INFO, db.get("fromUser").toString());
				if(userdb!=null){
					if(userdb.get("nickname")!=null){
						db.put("nickname", userdb.get("nickname").toString());
					}
					if(userdb.get("headimgurl")!=null){
						db.put("headimgurl", userdb.get("headimgurl").toString());
					}
				}
			}
		  
		  db.put("ordercount", ListUtil.statisicalDuplicate(list, db.get("fromUser").toString(), "fromUser")) ;
			
		}
	    
	    list=ListUtil.removeDuplicate(list, "fromUser");
		
		Struts2Utils.getRequest().setAttribute("OrderFormList", list);
	 
		return SUCCESS;
	}
	
	
	@Override
	public String delete() throws Exception {
	 
		return null;
	}
 
	@Override
	public String input() throws Exception {
	 
		return null;
	}
	
	@Override
	public String update() throws Exception {	
		String type=Struts2Utils.getParameter("type");
		Struts2Utils.getRequest().setAttribute("type", type);
		if(Struts2Utils.getParameter("fypage")!=null){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
	
		}
		return "add";
	}
	public void upd() throws Exception {
		DBObject db = baseDao.getMessage(PubConstants.WX_ORDERFORM, _id);
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}
	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			//有custId查出来 用户信息
			entity = (OrderForm)UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.WX_ORDERFORM,_id),OrderForm.class);
		} else {
			entity = new OrderForm();
		}
	}
	 
	@Override
	public String save() throws Exception {
		 
		
		return RELOAD;
	}
  
	@Override
	public OrderForm getModel() {
		return entity;
	}
	public void set_id(String _id) {
		this._id = _id;
	}
 
	
}
