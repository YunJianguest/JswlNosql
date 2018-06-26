package com.lsp.set.web;
 
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap; 
import java.util.List; 
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;
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
import com.lsp.pub.util.BaseDecimal;
import com.lsp.pub.util.CommonUtil;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.PayCommonUtil;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.TenpayUtil;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.util.XMLUtil;
import com.lsp.pub.web.GeneralAction; 
import com.lsp.set.entity.ComboOrder;  
import com.lsp.user.entity.UserInfo;
import com.lsp.website.service.WwzService;
import com.lsp.weixin.entity.WxPayConfig;
import com.mongodb.DBObject; 
/**
 * 系统订单
 * 
 * @author lsp
 * 
 */
@Namespace("/set")
@Results({ @Result(name = ComboorderAction.RELOAD, location = "comboorder.action",params={"fypage", "%{fypage}"}, type = "redirect") })
public class ComboorderAction extends GeneralAction<ComboOrder>{
	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private MongoSequence mongoSequence;
	private ComboOrder entity = new ComboOrder();;
	private Long _id;
	@Autowired
    private WwzService wwzService;
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}

	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		sortMap.put("createdate", -1);  
		String title=Struts2Utils.getParameter("title");
		if(StringUtils.isNotEmpty(title)){
			Pattern pattern = Pattern.compile("^.*" + title + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern);
			Struts2Utils.getRequest().setAttribute("title",  title);
		}
		whereMap.put("custid", SpringSecurityUtils.getCurrentUser().getId());
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject> list = baseDao.getList(PubConstants.SET_COMBOORDER,whereMap,fypage,10,sortMap);
		fycount=baseDao.getCount(PubConstants.SET_COMBOORDER, whereMap);
		Struts2Utils.getRequest().setAttribute("list", list);
		
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		try {
			custid=SpringSecurityUtils.getCurrentUser().getId();
			baseDao.delete(PubConstants.SET_COMBOORDER, Struts2Utils.getParameter("id")); 
			addActionMessage("删除成功!");

		
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,删除失败!");
		}
		return RELOAD;
	}

	@Override
	public String input() throws Exception {
	
		return "add";
	}

	@Override
	public String update() throws Exception {
	     
		DBObject db=baseDao.getMessage(PubConstants.SET_COMBOORDER,_id);
			
		Struts2Utils.getRequest().setAttribute("entity",db); 
		 
		return "add";
	}
	public void upd() throws Exception {
		DBObject db = baseDao.getMessage(PubConstants.SET_COMBOORDER, _id);
		
		String json = JSONArray.fromObject(db).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}


	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			// 有custId查出来 用户信息
			entity = (ComboOrder)UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.SET_COMBOORDER,_id),ComboOrder.class);
			
		} else {
			entity = new ComboOrder();
		}
	}

	@Override
	public String save() throws Exception {
		// 注册业务逻辑
		try {
			if(_id==null){
				_id=mongoSequence.currval(PubConstants.SET_COMBOORDER);
			} 
			entity.set_id(_id);
			entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
			entity.setCreatedate(new Date()); 
			baseDao.insert(PubConstants.SET_COMBOORDER, entity); 
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		return RELOAD;
	}
	 
	@Override
	public ComboOrder getModel() {
		return entity;
	}

	public void set_id(Long _id) {
		this._id = _id;
	}
	/**
	 * 微信支付
	 * @throws Exception
	 */
	public void wxpay() throws Exception{
		SortedMap<Object,Object> params = new TreeMap<Object,Object>();
		//getLscode();  
		
		WxPayConfig wxconfig=new WxPayConfig();
		custid=Struts2Utils.getParameter("custid");  
		wxconfig=GetAllFunc.wxPay.get(wwzService.getparentcustid(custid)); 
	    DBObject  comb=baseDao.getMessage(PubConstants.SET_COMBO, _id);
		//四位随机数
		String strRandom = TenpayUtil.buildRandom(4) + ""; 
		//10位序列号,可以自行调整。
		String orderno = DateFormat.getDate() + strRandom+mongoSequence.currval(PubConstants.SET_COMBOORDER);
		ComboOrder entity=new ComboOrder();
		entity.set_id(orderno);
		entity.setComboid(_id);
		entity.setCustid(custid);
		entity.setPrice(Float.parseFloat(comb.get("price").toString()));
		entity.setState(1);
		entity.setRoleid(Long.parseLong(comb.get("roleid").toString()));
		entity.setSummary("系统套餐"); 
		entity.setCreatedate(new Date());
        baseDao.insert(PubConstants.SET_COMBOORDER, entity);
    	  
		StringBuffer attach=new StringBuffer(orderno);//0
		attach.append("&").append(custid);// 
	 
		String nonce_str=PayCommonUtil.CreateNoncestr();
		SortedMap<Object,Object> parameters = new TreeMap<Object,Object>();
		parameters.put("appid", wxconfig.getAppid()); 
		parameters.put("mch_id", wxconfig.getPartner());
		parameters.put("nonce_str", nonce_str);
		parameters.put("attach", attach.toString());
		parameters.put("body", "系统套餐"); 
		parameters.put("is_subscribe", "Y");
		parameters.put("out_trade_no", orderno);
		parameters.put("total_fee", BaseDecimal.round(BaseDecimal.multiplication(comb.get("price").toString(), "100"),0));
		parameters.put("spbill_create_ip",Struts2Utils.getRequest().getRemoteAddr());
		parameters.put("notify_url", this.getCtxurl()+"/set/comboorder!payok.action");
		parameters.put("trade_type", "NATIVE");
		//parameters.put("openid", wwzService.getWxUser(fromUserid).get("fromUser").toString());


		String sign = PayCommonUtil.createSign("UTF-8", parameters,wxconfig.getPartner_key());
		parameters.put("sign", sign);
		String requestXML = PayCommonUtil.getRequestXml(parameters);
		
		String result =CommonUtil.httpsRequest("https://api.mch.weixin.qq.com/pay/unifiedorder", "POST", requestXML);
		System.out.println(result);
		Map<String, String> map = XMLUtil.doXMLParse(result);


	    params.put("appId", wxconfig.getAppid());
	    params.put("timeStamp", Long.toString(new Date().getTime()));
	    params.put("nonceStr",nonce_str);
	    params.put("package", "prepay_id="+map.get("prepay_id"));
	    params.put("signType", "MD5");
	    String paySign =  PayCommonUtil.createSign("UTF-8", params,wxconfig.getPartner_key());
	    params.put("packageValue", "prepay_id="+map.get("prepay_id"));    //这里用packageValue是预防package是关键字在js获取值出错
	    params.put("paySign", paySign);
	    params.put("code_url", map.get("code_url"));
	   
	    params.put("state", 0);
	  
	    params.put("orderno", orderno);
		String json = JSONArray.fromObject(params).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	
	/**
	 * 通知
	 * @throws Exception
	 */
	public void payok() throws Exception{ 
		InputStream inStream = Struts2Utils.getRequest().getInputStream();
        ByteArrayOutputStream outSteam = new ByteArrayOutputStream();
        byte[] buffer = new byte[1024];
        int len = 0;
        while ((len = inStream.read(buffer)) != -1) {
            outSteam.write(buffer, 0, len);
        }
       
        outSteam.close();
        inStream.close();
        String result  = new String(outSteam.toByteArray(),"utf-8");
     
        Map<Object, Object> map = XMLUtil.doXMLParse(result);
        String return_code=map.get("return_code").toString();
       
        if(return_code.equals("SUCCESS")){ 
        	fromUser=map.get("openid").toString(); //推送信息时用到
        	String[] attach=map.get("attach").toString().split("&");
        	String orderno=attach[0];  
        	String custid=attach[1]; 
        	//更新订单
        	DBObject orderdb=baseDao.getMessage(PubConstants.SET_COMBOORDER, orderno);
        	ComboOrder entity = (ComboOrder)UniObject.DBObjectToObject(orderdb,ComboOrder.class); 
        	entity.setState(2);//2为已经支付成功
        	entity.setPaydate(new Date());
        	baseDao.insert(PubConstants.SET_COMBOORDER, entity);
        	DBObject  db=baseDao.getMessage(PubConstants.USER_INFO,custid);
        	if(db!=null){
        		UserInfo user=(UserInfo) UniObject.DBObjectToObject(db, UserInfo.class);
        		user.setRoleid(entity.getRoleid());
        		baseDao.insert(PubConstants.USER_INFO, user);
        	}
        	 
        	Struts2Utils.getResponse().getWriter().write(PayCommonUtil.setXML("SUCCESS", ""));
        	
        }else{
        	Struts2Utils.getResponse().getWriter().write(PayCommonUtil.setXML("SUCCESS", ""));
        }
          

	}
	public  String payup(){
		getLscode();
		Struts2Utils.getRequest().setAttribute("custid",custid);
		Struts2Utils.getRequest().setAttribute("id",Struts2Utils.getParameter("id"));
		WxToken token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/set/comboorder!payup.action?custid="+custid+"&id="+Struts2Utils.getParameter("id");  
		if(StringUtils.isEmpty(fromUserid)){ 
				String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
				Struts2Utils.getRequest().setAttribute("inspection",inspection);  
				return "refresh";
		}else if(fromUserid.equals("register")){ 
				String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
				Struts2Utils.getRequest().setAttribute("inspection",inspection);  
				return "refresh";
		}
		System.out.println(custid);
		return "payup";  
		  
	}

	 
}
