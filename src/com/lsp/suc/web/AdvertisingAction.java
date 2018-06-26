package com.lsp.suc.web;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;
import java.util.regex.Pattern;
 

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

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
import com.lsp.pub.util.DateUtil;
import com.lsp.pub.util.PayCommonUtil;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.TenpayUtil;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.XMLUtil;
import com.lsp.pub.web.GeneralAction;
import com.lsp.shop.entiy.OrderForm;
import com.lsp.suc.entity.Bbstypeinfo;
import com.lsp.suc.entity.IntegralInfo;
import com.lsp.suc.entity.Comunit;
import com.lsp.web.entity.AdvertisingInfo;
import com.lsp.website.service.WebsiteService;
import com.lsp.website.service.WwzService;
import com.lsp.weixin.entity.WxPayConfig;
import com.lsp.weixin.entity.WxUser;
import com.mongodb.DBObject;

 
/*
 * 广告位管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name ="reload", location = "advertising.action",params={"type","%{type}"}, type = "redirect") })
public class AdvertisingAction extends GeneralAction<AdvertisingInfo>{

	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private MongoSequence mongoSequence;
	@Autowired
	private WwzService wwzService;
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}
	 
	private AdvertisingInfo entity=new AdvertisingInfo();
	private Long _id;


	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		HashMap<String, Object> backMap =new HashMap<String, Object>();
		custid=SpringSecurityUtils.getCurrentUser().getId();
	    String type=Struts2Utils.getParameter("type");
		sortMap.put("createdate", -1); 
		whereMap.put("custid", custid);
		if(StringUtils.isNotEmpty(type)){
			whereMap.put("type", type);	
		}
		String title=Struts2Utils.getParameter("title");
		if(StringUtils.isNotEmpty(title)){
			Pattern pattern = Pattern.compile("^.*" + title + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern);
			Struts2Utils.getRequest().setAttribute("title",  title);
		}
	 
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		
		List<DBObject> list=baseDao.getList(PubConstants.ADVERTISEMENT,whereMap,fypage,10,sortMap,backMap);
		fycount=baseDao.getCount(PubConstants.ADVERTISEMENT,whereMap);
		Struts2Utils.getRequest().setAttribute("list", list);
		Struts2Utils.getRequest().setAttribute("toUser", toUser);
		
		return SUCCESS;
	}


	@Override
	public AdvertisingInfo getModel() {
		// TODO Auto-generated method stub
		return entity;
	}


	@Override
	public String input() throws Exception {
		// TODO Auto-generated method stub
		return "add";
	}


	@Override
	public String update() throws Exception {
	 
		return "add";
	}
	public void upd() throws Exception { 
		DBObject db = baseDao.getMessage(PubConstants.ADVERTISEMENT, _id); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}


	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id==null){
				_id=mongoSequence.currval(PubConstants.ADVERTISEMENT); 
			} 
			String toUser=SpringSecurityUtils.getCurrentUser().getToUser();  
			entity.set_id(_id);
			entity.setToUser(toUser); 
			 
			baseDao.insert(PubConstants.ADVERTISEMENT, entity);
			addActionMessage("添加成功");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			addActionMessage("添加失败");
		}
		return RELOAD;
	}
	
	 
	 

	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub 
		if(_id!=null){
			baseDao.delete(PubConstants.ADVERTISEMENT,_id);
		}
		return RELOAD;
	}


	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id!=null){
				DBObject db=baseDao.getMessage(PubConstants.ADVERTISEMENT, _id);
				entity= (AdvertisingInfo) UniObject.DBObjectToObject(db, AdvertisingInfo.class);
			}else{
				entity=new AdvertisingInfo();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	 	
	}
	public void set_id(Long _id) {
		this._id = _id;
	}
	/**
	 * 手机添加广告
	 */
	public void  ajaxadd(){
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		try { 
			getLscode();
			String  picurl=Struts2Utils.getParameter("picurl");
			String  url=Struts2Utils.getParameter("url");
		    String  id=Struts2Utils.getParameter("id");
		    HashMap<String, Object>whereMap=new HashMap<String, Object>();
		    whereMap.put("custid", custid);
		    whereMap.put("fromUserid", fromUserid);
		    whereMap.put("_id", Long.parseLong(id));
		    DBObject  db=baseDao.getMessage(PubConstants.ADVERTISEMENT, whereMap);
		    if(db!=null){ 
		    	AdvertisingInfo  advertisingInfo=(AdvertisingInfo) UniObject.DBObjectToObject(db, AdvertisingInfo.class);	
		    	advertisingInfo.setPicurl(picurl);
				advertisingInfo.setUrl(url);  
				baseDao.insert(PubConstants.ADVERTISEMENT, advertisingInfo);
				sub_map.put("state",0);
		    }
			 
			
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			sub_map.put("state",1);
			e.printStackTrace();
			
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
		
	}
	/**
	 * 手机添加页面
	 */
	public  String  webadd(){ 
		getLscode();
		String id=Struts2Utils.getParameter("id");
		if(StringUtils.isNotEmpty(id)){
			DBObject  db=baseDao.getMessage(PubConstants.ADVERTISEMENT,Long.parseLong(id));
			Struts2Utils.getRequest().setAttribute("entity", db);
		}
		Struts2Utils.getRequest().setAttribute("price", wwzService.getprice(custid, "bbs_adv"));
		Struts2Utils.getRequest().setAttribute("custid", custid); 
		return "webadd";
	}
	/**
	 * ajax获取手机广告列表
	 * @return
	 */
	public void  ajaxweb(){ 
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		try {
			getLscode();
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			sortMap.put("createdate", -1);
			whereMap.put("fromUserid", fromUserid);
			whereMap.put("custid", custid);
			List<DBObject>list=baseDao.getList(PubConstants.ADVERTISEMENT, whereMap, sortMap);
			if(list.size()>0){
			    for (DBObject dbObject : list) { 
					if(Integer.parseInt(dbObject.get("state").toString())==3&&DateUtil.checksimal(DateFormat.getFormat(dbObject.get("enddate").toString()))){
						//投放结束
						dbObject.put("state",1);
						AdvertisingInfo  adv=(AdvertisingInfo) UniObject.DBObjectToObject(dbObject, AdvertisingInfo.class); 
						adv.setState(1);
						baseDao.insert(PubConstants.ADVERTISEMENT, adv);
					}
					if(dbObject.get("enddate")!=null){
						dbObject.put("enddate",DateFormat.getDate(DateFormat.getFormat(dbObject.get("enddate").toString())));
					}
					if(dbObject.get("createdate")!=null){
						dbObject.put("createdate",DateFormat.getDate(DateFormat.getFormat(dbObject.get("createdate").toString())));
					}
				}
			 	sub_map.put("state", 0);
			 	sub_map.put("list",list);
			}else{
				sub_map.put("state", 1);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			   sub_map.put("state", 1);
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	 
	}
	public  String  weblist(){
		getLscode();
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		whereMap.put("custid", custid);
		whereMap.put("fromUserid", fromUserid);
		Long count=baseDao.getCount(PubConstants.ADVERTISEMENT, whereMap);
		Struts2Utils.getRequest().setAttribute("count",count);
		Struts2Utils.getRequest().setAttribute("custid", custid); 
		
		return "web";
		
	}
	/**
	 * 微信支付
	 * @throws Exception
	 */
	public void wxpay() throws Exception{
		SortedMap<Object,Object> params = new TreeMap<Object,Object>();
		getLscode();
		DBObject  wx=wwzService.getWxUser(fromUserid);
		 
		if(wx.get("_id").equals("notlogin")){
			params.put("state", 3);
			String json = JSONArray.fromObject(params).toString();
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
			return; 
		}
		String comtoUser=toUser;
		WxToken wxtoken=GetAllFunc.wxtoken.get(custid);
		WxPayConfig wxconfig=new WxPayConfig();
		if(wxtoken.getQx()==0){
			params.put("state", 1);
			String json = JSONArray.fromObject(params).toString();
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
			return;
		}else if(wxtoken.getQx()==1){
			wxconfig=GetAllFunc.wxPay.get(custid);
		}else if(wxtoken.getQx()==2){//父类结算   
			wxconfig=GetAllFunc.wxPay.get(wwzService.getparentcustid(custid));
		}
		
		if(wxconfig==null||wxconfig.getAppid()==null){
			params.put("state", 1); 
			String json = JSONArray.fromObject(params).toString();
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
			return;
		}
		//获取提交的商品价格
		String price = Struts2Utils.getParameter("price");
		//获取提交的商品名称
		String remark = Struts2Utils.getParameter("remark");
		
		String  type=Struts2Utils.getParameter("type");
		custid=Struts2Utils.getParameter("custid");  
		String  picurl=Struts2Utils.getParameter("picurl");
		String  url=Struts2Utils.getParameter("url"); 
		String  time=Struts2Utils.getParameter("time");
        
		//四位随机数
		String strRandom = TenpayUtil.buildRandom(4) + "";
		
		//10位序列号,可以自行调整。
		String orderno = DateFormat.getDate() + strRandom+mongoSequence.currval(PubConstants.SUC_ORDERNO);
	 
		/**
		 * 生成支付订单
		 */ 
		AdvertisingInfo  advertisingInfo=new AdvertisingInfo();
		Long id=mongoSequence.currval(PubConstants.ADVERTISEMENT);
		advertisingInfo.set_id(id);
		advertisingInfo.setCreatedate(new Date());
		advertisingInfo.setCustid(custid);
		advertisingInfo.setFromUserid(fromUserid);
		advertisingInfo.setPicurl(picurl);
		advertisingInfo.setUrl(url);
		advertisingInfo.setType(type);
		advertisingInfo.setState(0);
		advertisingInfo.setTime(Integer.parseInt(time));
		advertisingInfo.setPrice(Double.parseDouble(price)); 
		baseDao.insert(PubConstants.ADVERTISEMENT, advertisingInfo); 
		StringBuffer attach=new StringBuffer(id+"");//传递订单编号 
		attach.append("&").append(custid); 
		String nonce_str=PayCommonUtil.CreateNoncestr();
		SortedMap<Object,Object> parameters = new TreeMap<Object,Object>(); 
		parameters.put("appid", wxconfig.getAppid());//公众账号ID 
		parameters.put("mch_id", wxconfig.getPartner());//商户号
		parameters.put("nonce_str", nonce_str);//随机字符串
		parameters.put("attach", attach.toString());
		parameters.put("body", remark);//商品描述
		parameters.put("is_subscribe", "Y"); 
		parameters.put("out_trade_no", orderno);
		parameters.put("total_fee",BaseDecimal.round(BaseDecimal.multiplication(price, "100"),0));//总金额
		parameters.put("spbill_create_ip",Struts2Utils.getRequest().getRemoteAddr());//终端ip  
		parameters.put("notify_url", this.getCtxurl()+"/suc/advertising!payok.action");//通知地址 
		parameters.put("trade_type", "JSAPI");//支付类型 
		parameters.put("openid", wx.get("fromUser").toString());//用户ID
		String sign = PayCommonUtil.createSign("UTF-8", parameters,wxconfig.getPartner_key());
				
		parameters.put("sign", sign);//签名
		String requestXML = PayCommonUtil.getRequestXml(parameters);
		
		String result =CommonUtil.httpsRequest("https://api.mch.weixin.qq.com/pay/unifiedorder", "POST", requestXML);
		
		Map<String, String> map = XMLUtil.doXMLParse(result); 
	    params.put("appId", wxconfig.getAppid());
	    params.put("timeStamp", Long.toString(new Date().getTime()));
	    params.put("nonceStr",nonce_str);
	    params.put("package", "prepay_id="+map.get("prepay_id"));
	    params.put("signType", "MD5");
	    String paySign =  PayCommonUtil.createSign("UTF-8", params,wxconfig.getPartner_key());
	    params.put("packageValue", "prepay_id="+map.get("prepay_id"));    //这里用packageValue是预防package是关键字在js获取值出错
	    params.put("paySign", paySign);                                                          //paySign的生成规则和Sign的生成规则一致
	    params.put("state", 0);
	   
		String json = JSONArray.fromObject(params).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 打电话
	 * @throws Exception
	 */
	public void payok() throws Exception{
		System.out.println("支付成功");
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
            DBObject  db=baseDao.getMessage(PubConstants.ADVERTISEMENT, Long.parseLong(orderno));
            if(db!=null){
            	AdvertisingInfo adv=(AdvertisingInfo) UniObject.DBObjectToObject(db,AdvertisingInfo.class);
            	adv.setState(2);
            	baseDao.insert(PubConstants.ADVERTISEMENT, adv);
            }
        	
        	Struts2Utils.getResponse().getWriter().write(PayCommonUtil.setXML("SUCCESS", ""));
        	
        }else{
        	Struts2Utils.getResponse().getWriter().write(PayCommonUtil.setXML("SUCCESS", ""));
        }
       
        
       

	}
	/**
	 * 审核通过
	 */
	public  void   startadv(){
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		try {
			String id=Struts2Utils.getParameter("id");
			DBObject  db=baseDao.getMessage(PubConstants.ADVERTISEMENT, Long.parseLong(id)); 
			if(db!=null&&Integer.parseInt(db.get("state").toString())==2){
				//已经支付 
				AdvertisingInfo  obj=(AdvertisingInfo) UniObject.DBObjectToObject(db, AdvertisingInfo.class);
				obj.setState(3); 
				Calendar cal = Calendar.getInstance();
			    cal.add(Calendar.HOUR_OF_DAY,+Integer.parseInt(obj.getTime()+"")); 
			    obj.setStartdate(new Date());
				obj.setEnddate(cal.getTime());
				baseDao.insert(PubConstants.ADVERTISEMENT, obj);
				
				sub_map.put("state", 0);
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 取消审核
	 */
	public  void   stopadv(){
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		try {
			String id=Struts2Utils.getParameter("id");
			DBObject  db=baseDao.getMessage(PubConstants.ADVERTISEMENT, Long.parseLong(id));
			if(db!=null){ 
				AdvertisingInfo  obj=(AdvertisingInfo) UniObject.DBObjectToObject(db, AdvertisingInfo.class);
				obj.setState(1);
				baseDao.insert(PubConstants.ADVERTISEMENT, obj);
				sub_map.put("state", 0);
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
 
     

}
