package com.lsp.shop.web;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import net.sf.json.JSONArray;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.entity.WxToken;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.DateUtil;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.web.GeneralAction;
import com.lsp.shop.entiy.ProductInfo;
import com.lsp.suc.entity.Luckydraw;
import com.lsp.website.service.WwzService;
import com.mongodb.DBObject;

/**
* 商城活动总管理
* @author lsp
*
*/
@Namespace("/shop")
@Results( { @Result(name = ShopactivityAction.RELOAD, location = "shopactivity.action", type = "redirect") })
public class ShopactivityAction extends GeneralAction<ProductInfo>{

	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private MongoSequence mongoSequence;	
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}
	@Autowired
	private WwzService wwzService;
	
	@Override
	public ProductInfo getModel() {
		// TODO Auto-generated method stub
		return null;
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
		return null;
	}

	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * 总活动页面
	 * @return
	 */
	public String  web(){ 
		getLscode();
		WxToken token=GetAllFunc.wxtoken.get(custid);
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token.getToUser(),Struts2Utils.getRequest()));
		 if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 } 
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/shop/shopactivity!web.action?custid="+custid;  
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
		Struts2Utils.getRequest().setAttribute("token", token); 
		Struts2Utils.getRequest().setAttribute("custid",custid); 
		//加载广告位
		Struts2Utils.getRequest().setAttribute("slide", wwzService.getslide(custid, "shop_activity"));
		DBObject share=wwzService.getShareFx(custid,"shop_activity_share"); 
		Struts2Utils.getRequest().setAttribute("share", share); 
		return "web";
	}
	/**
	 * ajax获取砍价数据
	 */
	public  void  ajaxkj(){
		getLscode();
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		whereMap.put("fromUserid", fromUserid);
		whereMap.put("custid", custid);
		sortMap.put("createdate",-1);
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject>list=baseDao.getList(PubConstants.SHOP_BARGAININGYD, whereMap,fypage,10,sortMap);
		if(list.size()>0){
			sub_map.put("list",list);
			sub_map.put("state", 0);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);	
	}
	public  void   ajaxdelkj(){
		getLscode();
		String  id=Struts2Utils.getParameter("id");
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		if(StringUtils.isNotEmpty("id")){
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			whereMap.put("_id", id);
			whereMap.put("fromUserid", fromUserid);
			baseDao.delete(PubConstants.SHOP_BARGAININGYD, whereMap);
			sub_map.put("state",0);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);	
		
	}
	public  void   ajaxdelallkj(){
		baseDao.delete(PubConstants.SHOP_BARGAININGYD);
	}
	
	 
}
