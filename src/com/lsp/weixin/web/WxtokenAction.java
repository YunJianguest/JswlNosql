package com.lsp.weixin.web;

import java.net.URLEncoder;
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
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.entity.WxToken;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.web.GeneralAction;
import com.lsp.website.service.WwzService;
import com.lsp.weixin.entity.WxPayConfig;
import com.mongodb.DBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
@Namespace("/weixin")
@Results( { @Result(name = WxtokenAction.RELOAD, location = "wxtoken.action",params={"_id", "%{_id}"}, type = "redirect") })
public class WxtokenAction extends GeneralAction<WxToken> {

	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	@Autowired
	private WwzService wwzService;
	
	private WxToken entity=new WxToken();
	private String _id;


	@Override
	public String execute() throws Exception {
		
	
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		List<DBObject> tokenList=baseDao.getList(null, whereMap, sortMap);

		Struts2Utils.getRequest().setAttribute("tokenList", tokenList);
		return SUCCESS;
	}
	

	@Override
	public String delete() throws Exception {
		try {
			baseDao.delete(null,_id);
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
		String  toUser=SpringSecurityUtils.getCurrentUser().getToUser();
		String  custid=SpringSecurityUtils.getCurrentUser().getId();
		Struts2Utils.getRequest().setAttribute("entity",baseDao.getMessage(PubConstants.WEIXIN_TOKEN,custid));
		Struts2Utils.getRequest().setAttribute("pay",baseDao.getMessage(PubConstants.WEIXIN_PAYCONFIG,custid));
		Struts2Utils.getRequest().setAttribute("toUser",toUser);
		return "add";
	}
	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			//有custId查出来 用户信息
			entity = (WxToken)UniObject.DBObjectToObject(baseDao.getMessage(null,_id),WxToken.class);
		} else {
			entity = new WxToken();
		}
	}
	
	

	@Override
	public String save() throws Exception {
		//注册业务逻辑
		try {
				entity.set_id(_id);
				
				baseDao.insert(null, entity);
				entity.setExpires_in(0);
				entity.setRemark("");
				GetAllFunc.wxtoken.put(toUser, entity);
				addActionMessage("成功添加!");
			
		
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return this.update();
	}
	public  String  savetoken()throws Exception {
		String   custid=SpringSecurityUtils.getCurrentUser().getId(); 
		String   toUser=SpringSecurityUtils.getCurrentUser().getToUser();
		String   appid=Struts2Utils.getParameter("appid");
		String   secret=Struts2Utils.getParameter("secret");
		String   zhlx=Struts2Utils.getParameter("zhlx");
		String   qx=Struts2Utils.getParameter("qx");
		String   sqlx=Struts2Utils.getParameter("sqlx");
		String   kf=Struts2Utils.getParameter("kf");
		String   isjh=Struts2Utils.getParameter("isjh");
		String   partner=Struts2Utils.getParameter("partner");
		String   partner_key=Struts2Utils.getParameter("partner_key");
		String   isgz=Struts2Utils.getParameter("isgz");
		String   pay_name=Struts2Utils.getParameter("pay_name");
		if(Integer.parseInt(zhlx)>0){
			WxToken token=new WxToken();
			token.set_id(custid);
			token.setAppid(appid);
			token.setSecret(secret);
			token.setExpires_in(0);
			token.setToUser(toUser); 
			token.setZhlx(1);
			token.setSqlx(Integer.parseInt(sqlx));
			token.setKf(Integer.parseInt(kf));
			token.setIsjh(Integer.parseInt(isjh));
			token.setQx(Integer.parseInt(qx));
			if(StringUtils.isNotEmpty(isgz)){
				token.setIsgz(Integer.parseInt(isgz));	
			} 
			baseDao.insert(PubConstants.WEIXIN_TOKEN, token);
			System.out.println("token保存成功"+token);
			System.out.println(custid);
			GetAllFunc.wxtoken.put(custid, token);
		}
		if(Integer.parseInt(qx)==1){
			WxPayConfig wc=new WxPayConfig();
			wc.set_id(custid);
			wc.setAppid(appid);
			wc.setToUser(toUser);
			wc.setAppsecret(secret);
			wc.setAppkey(Struts2Utils.getParameter("appkey"));
			wc.setPartner(partner);
			wc.setPartner_key(partner_key);
			wc.setName(pay_name);
			baseDao.insert(PubConstants.WEIXIN_PAYCONFIG,wc); 
			GetAllFunc.wxPay.put(custid, wc);
			System.out.println("微信支付保存成功");
		}
		return this.update();
	}

	@Override
	public WxToken getModel() {
		return entity;
	}
	public void set_id(String _id) {
		this._id = _id;
	}
	/**
	 * ajax获取微信URL
	 */
	public  void   getwxurl(){ 
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
	    custid=SpringSecurityUtils.getCurrentUser().getId();
		WxToken token=GetAllFunc.wxtoken.get(custid); 
		System.out.println(custid);
		System.out.println(token);
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(SpringSecurityUtils.getCurrentUser().getCustid()); 
		}  
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String  url=Struts2Utils.getParameter("url");
		String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
		sub_map.put("state",0);
		sub_map.put("value",inspection);
		String json = JSONArray.fromObject(sub_map).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
}


