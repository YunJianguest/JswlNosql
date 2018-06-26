package com.lsp.shop.web;
 
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
 
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoDbUtil;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.DictionaryUtil;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction;
import com.lsp.shop.entiy.ProductInfo; 
import com.lsp.shop.entiy.Shoptg;
import com.lsp.website.service.WwzService;
import com.mongodb.DBObject;
 
/**
 * 产品信息
 * @author lsp
 *
 */
@Namespace("/shop")
@Results( { @Result(name = ShopproAction.RELOAD, location = "shoppro.action",params={"comid", "%{comid}","fypage", "%{fypage}"}, type = "redirect") })
public class ShopproAction extends GeneralAction<ProductInfo> {

	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private MongoSequence mongoSequence;
	@Autowired
	private WwzService  wwzservice; 
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}
	@Autowired
	private DictionaryUtil dictionaryUtil;
	private ProductInfo entity=new ProductInfo();
	private Long _id;


	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		 
		 	
		String  title=Struts2Utils.getParameter("title");
		if(StringUtils.isNotEmpty(title))
		{
			Pattern pattern = Pattern.compile("^.*" + title + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("ptitle", pattern);
			Struts2Utils.getRequest().setAttribute("title",  title);
		}
		sortMap.put("sort", -1);
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		String  comid=Struts2Utils.getParameter("comid");
		whereMap.put("comid", Long.parseLong(comid));
		fycount=baseDao.getCount(PubConstants.DATA_PRODUCT, whereMap);
		HashMap<String, Object> backMap =new HashMap<String, Object>();
		backMap.put("context", 0);
		List<DBObject> list=baseDao.getList(PubConstants.DATA_PRODUCT,whereMap,fypage,10, sortMap,backMap);
		 for (DBObject dbObject : list) {
				dbObject.put("nickname", wwzservice.getCustName(dbObject.get("custid").toString()));
			}
		Struts2Utils.getRequest().setAttribute("custid",SpringSecurityUtils.getCurrentUser().getId());
		Struts2Utils.getRequest().setAttribute("ProductInfoList", list);
	
		return SUCCESS;
	}
	
	
	@Override
	public String delete() throws Exception {
		try {
			custid=SpringSecurityUtils.getCurrentUser().getId();
			baseDao.delete(PubConstants.DATA_PRODUCT,_id);
			addActionMessage("成功删除!");
			
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,删除过程中出现异常!");
		}
		return RELOAD;
	}
 
	@Override
	public String input() throws Exception {
		entity.setSort(0);
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		whereMap.put("parentid", Long.parseLong(Struts2Utils.getParameter("comid"))); 
		sortMap.put("sort", -1);
		//获取店铺分类 
		List<DBObject> typelist=baseDao.getList(PubConstants.SHOP_SHOPTYPE, whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("typelist",typelist); 
		Struts2Utils.getRequest().setAttribute("bq",Struts2Utils.getParameter("bq"));
		DBObject  db=baseDao.getMessage(PubConstants.SHOP_SHOPMB, Long.parseLong(Struts2Utils.getParameter("comid")));
		if(db.get("type")!=null&&Integer.parseInt(db.get("type").toString())==1){
			Struts2Utils.getRequest().setAttribute("isjf",1); 
		}
		return "add";
	}
	
	@Override
	public String update() throws Exception {	
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		whereMap.put("parentid", Long.parseLong(Struts2Utils.getParameter("comid"))); 
		sortMap.put("sort", -1);
		//获取店铺分类 
		List<DBObject> typelist=baseDao.getList(PubConstants.SHOP_SHOPTYPE, whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("typelist",typelist);
		DBObject pro=baseDao.getMessage(PubConstants.DATA_PRODUCT, _id); 
		Struts2Utils.getRequest().setAttribute("entity",pro);
		if(pro!=null){
			Struts2Utils.getRequest().setAttribute("bq",pro.get("bq"));
		} 
		DBObject  db=baseDao.getMessage(PubConstants.SHOP_SHOPMB, Long.parseLong(Struts2Utils.getParameter("comid")));
		if(db.get("type")!=null&&Integer.parseInt(db.get("type").toString())==1){
			Struts2Utils.getRequest().setAttribute("isjf",1);
		} 
		return "add";
	}
	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			//有custId查出来 用户信息
			entity = (ProductInfo)UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.DATA_PRODUCT,_id),ProductInfo.class);
		} else {
			entity = new ProductInfo();
		}
	}
	
	

	@Override
	public String save() throws Exception {
		//注册业务逻辑
		try {
			if(_id == null){
				_id=mongoSequence.currval(PubConstants.DATA_PRODUCT);	
			}
			
			entity.set_id(_id); 
			entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
			entity.setCreatedate(new Date());
			String comid=Struts2Utils.getParameter("comid");
			if(StringUtils.isNotEmpty(comid)){
				entity.setComid(Long.parseLong(comid));	
			} 
			baseDao.insert(PubConstants.DATA_PRODUCT,entity);
			addActionMessage("成功添加!");
			
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return RELOAD;
	}

	

	public String imp() throws Exception {	
		return "import";
	}
	
	@Override
	public ProductInfo getModel() {
		return entity;
	}
	public void set_id(Long _id) {
		this._id = _id;
	}
	
	/**
	 * ajax添加推广
	 */
	public void  ajaxaddtg(){
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		custid=SpringSecurityUtils.getCurrentUser().getId();
		String comid=Struts2Utils.getParameter("comid"); 
		String lx=Struts2Utils.getParameter("lx");
		if(_id!=null){
			Shoptg tg=new Shoptg();
			tg.set_id(mongoSequence.currval(PubConstants.SHOP_SHOPTG));
			tg.setCustid(custid);
			tg.setComid(Long.parseLong(comid));
			tg.setLx(Integer.parseInt(lx));
			tg.setCreatedate(new Date());
			tg.setPid(_id);
			baseDao.insert(PubConstants.SHOP_SHOPTG, tg);
			DBObject db=baseDao.getMessage(PubConstants.DATA_PRODUCT, _id);
	        if(db!=null){
	        	ProductInfo  pro=(ProductInfo) UniObject.DBObjectToObject(db, ProductInfo.class);
	        	pro.set_id(_id);
	        	pro.setTglx(Integer.parseInt(lx));
	        	baseDao.insert(PubConstants.DATA_PRODUCT, pro);
	        	sub_map.put("state", 0);
	        }	
		}  
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * ajax取消推广
	 */
	public void  ajaxqxtg(){
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		custid=SpringSecurityUtils.getCurrentUser().getId();
		if(_id!=null){
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			whereMap.put("custid",custid);
			whereMap.put("pid", _id);
			baseDao.delete(PubConstants.SHOP_SHOPTG, whereMap);
			DBObject db=baseDao.getMessage(PubConstants.DATA_PRODUCT, _id);
	        if(db!=null){
	        	ProductInfo  pro=(ProductInfo) UniObject.DBObjectToObject(db, ProductInfo.class);
	        	pro.set_id(_id);
	        	pro.setTglx(0);
	        	baseDao.insert(PubConstants.DATA_PRODUCT, pro);
	        	sub_map.put("state", 0);
	        }	
			sub_map.put("state",0);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 砍价列表
	 * @return
	 */
	public  String   barlist(){
		custid=SpringSecurityUtils.getCurrentUser().getId();
		String id=Struts2Utils.getParameter("id");
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		whereMap.put("pid", Long.parseLong(id));
		sortMap.put("createdate", -1);
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		} 
		List<DBObject>list=baseDao.getList(PubConstants.SHOP_BARGAININGYD, whereMap,fypage,10,sortMap); 
		for (DBObject dbObject : list) {
			if(dbObject.get("fromUserid")!=null){
				DBObject  db=wwzservice.getWxUser(dbObject.get("fromUserid").toString());
				dbObject.put("headimgurl",db.get("headimgurl"));
				dbObject.put("nickname",db.get("nickname"));
			}
		}
		Struts2Utils.getRequest().setAttribute("list",list);
		Struts2Utils.getRequest().setAttribute("id",id);
		fycount=baseDao.getCount(PubConstants.SHOP_BARGAININGYD, whereMap);
		return "barlist"; 	
	}
	/**
	 * 砍价详情列表
	 * @return
	 */
	public  String   bardetaillist(){
		custid=SpringSecurityUtils.getCurrentUser().getId();
		String id=Struts2Utils.getParameter("id");
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		whereMap.put("ydid", id);
		sortMap.put("createdate", -1);
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		} 
		List<DBObject>list=baseDao.getList(PubConstants.SHOP_BARGAININGSTATI, whereMap,fypage,10,sortMap); 
		for (DBObject dbObject : list) {
			if(dbObject.get("fromUserid")!=null){
				DBObject  db=wwzservice.getWxUser(dbObject.get("fromUserid").toString());
				dbObject.put("headimgurl",db.get("headimgurl"));
				dbObject.put("nickname",db.get("nickname"));
			}
		}
		Struts2Utils.getRequest().setAttribute("list",list);
		Struts2Utils.getRequest().setAttribute("id",id);
		fycount=baseDao.getCount(PubConstants.SHOP_BARGAININGSTATI, whereMap);
		return "bardetaillist"; 	
	}
}
