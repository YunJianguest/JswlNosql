package com.lsp.shop.web;
 
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
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
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

  
import com.lsp.android.entity.MessageInfo;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.entity.WxToken;
import com.lsp.pub.util.BaseDecimal;
import com.lsp.pub.util.CommonUtil;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.DateUtil;
import com.lsp.pub.util.DictionaryUtil;
import com.lsp.pub.util.JmsService;
import com.lsp.pub.util.PayCommonUtil;
import com.lsp.pub.util.RelativeDate;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.TenpayUtil;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.util.WxhbUtil;
import com.lsp.pub.util.XMLUtil;
import com.lsp.pub.web.GeneralAction;
import com.lsp.shop.entiy.AgentDetail; 
import com.lsp.shop.entiy.Bargainingstati;
import com.lsp.shop.entiy.Bargainingyd;
import com.lsp.shop.entiy.BulkYd;
import com.lsp.shop.entiy.ComMain;
import com.lsp.shop.entiy.OrderForm;
import com.lsp.shop.entiy.OrderFormpro; 
import com.lsp.shop.entiy.Paymentorder;
import com.lsp.shop.entiy.ProductInfo;
import com.lsp.shop.entiy.ShopAgent;
import com.lsp.shop.entiy.ShopMb;
import com.lsp.shop.entiy.Shoppingcart;
import com.lsp.shop.entiy.Useraddress; 
import com.lsp.suc.entity.Comunit; 
import com.lsp.user.entity.UserInfo;
import com.lsp.website.service.WwzService;
import com.lsp.weixin.entity.WxPayConfig; 
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject; 
 

@Namespace("/shop")
@Results({ @org.apache.struts2.convention.annotation.Result(name = "reload", location = "shop.action",type = "redirect") })
public class ShopAction extends GeneralAction {
	private static final long serialVersionUID = -7868703949557549292L;
	 
	@Autowired
	private BaseDao baseDao;
	@Autowired
	private WwzService wwzService;
	@Autowired
	private DictionaryUtil dictionaryUtil;
	private MongoSequence mongoSequence;	
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}
	 
	/**
	 * 主页面
	 * @return
	 * @throws Exception 
	 */
	public String index() throws Exception {  
		String  comid=Struts2Utils.getParameter("comid"); 
		getLscode(); 
		Struts2Utils.getRequest().setAttribute("custid",custid);  
		WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		}
		
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url="";
		if(StringUtils.isNotEmpty(comid)){
			url=SysConfig.getProperty("ip")+"/shop/shop!index.action?comid="+comid+"&custid="+custid+"&agid="+agid;
		}else{
			url=SysConfig.getProperty("ip")+"/shop/shop!index.action?custid="+custid+"&agid="+agid;
		} 
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
	    Struts2Utils.getRequest().setAttribute("cid", comid);
	    List<DBObject>list=wwzService.advertisement(custid, "shopmb-"+comid);
	    Struts2Utils.getRequest().setAttribute("advertising",list);
	    List<DBObject>list1=wwzService.slide(custid, "shopmb-"+comid);
	    Struts2Utils.getRequest().setAttribute("slide",list1);

		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		if(StringUtils.isNotEmpty(comid)){
			whereMap.put("_id",Long.parseLong(comid));	
		}else{
			whereMap.put("lx",1);	
		}  
		whereMap.put("custid", custid);
		DBObject shopmb=baseDao.getMessage(PubConstants.SHOP_SHOPMB,whereMap); 
		if(StringUtils.isEmpty(agid)||agid.equals("null")){  
			agid=wwzService.getAgid(shopmb.get("_id").toString(), wwzService.getVipNo(fromUserid));
			 
			if(StringUtils.isNotEmpty(agid)){
				if(StringUtils.isNotEmpty(comid)){
					url=SysConfig.getProperty("ip")+"/shop/shop!index.action?comid="+comid+"&custid="+custid+"&agid="+agid;
				}else{
					url=SysConfig.getProperty("ip")+"/shop/shop!index.action?custid="+custid+"&agid="+agid;
				} 
				Struts2Utils.getRequest().setAttribute("agid",agid);
			}
			
		}
		wwzService.flow(custid, "shop-"+shopmb.get("_id"));
		wwzService.flow(custid, "shop");
	    Struts2Utils.getRequest().setAttribute("entity",shopmb);
	    //加载分类
		whereMap.clear();
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		whereMap.put("parentid", Long.parseLong(shopmb.get("_id").toString())); 
		sortMap.put("sort", -1);
		//加载滚动
		Struts2Utils.getRequest().setAttribute("roll",wwzService.getRoll(custid, "shopmb-"+shopmb.get("_id").toString()));
		//加载广告
		Struts2Utils.getRequest().setAttribute("slide",wwzService.getslide(custid, "shopmb-"+shopmb.get("_id").toString()));
		//获取店铺分类 
		List<DBObject> typelist=baseDao.getList(PubConstants.SHOP_SHOPTYPE, whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("typelist",typelist);  
		DBObject  share=new BasicDBObject();
		share.put("fxtitle",shopmb.get("name"));
		share.put("fxsummary",shopmb.get("summary"));
		share.put("fximg",shopmb.get("logo"));
		if(StringUtils.isNotEmpty(comid)){
			share.put("fxurl",url);	
		}else{
			share.put("fxurl",url);	
		}
		//加载代理分享 
		DBObject  agent=wwzService.getAgent(agid);
		if(agent!=null){ 
			share.put("fxtitle",wwzService.getWxUsertype(agent.get("fromUserid").toString(), "nickname")+"的小店");
			share.put("fxsummary","我的店铺新到很多产品，大家快来看看！");
			share.put("fximg",wwzService.getWxUsertype(agent.get("fromUserid").toString(), "headimgurl"));
			agent.put("nickname",wwzService.getWxUsertype(agent.get("fromUserid").toString(),"nickname"));
			agent.put("headimgurl",wwzService.getWxUsertype(agent.get("fromUserid").toString(), "headimgurl"));
			Struts2Utils.getRequest().setAttribute("agent",agent);  
		}
		Struts2Utils.getRequest().setAttribute("share",share);
		
		//检测代理 
		if(wwzService.checkAgent(agid, custid, fromUserid)){
			Struts2Utils.getRequest().setAttribute("isAgent","ok");
		}
		//检测全局代理 
		if(wwzService.checkAgent(custid,fromUserid)){
			 Struts2Utils.getRequest().setAttribute("isAgents","ok");
		}
		//检测当前店铺
		if(StringUtils.isNotEmpty(wwzService.getAgid(shopmb.get("_id").toString(),wwzService.getVipNo(fromUserid)))){
			Struts2Utils.getRequest().setAttribute("isAgentcom","ok");
		}
		if(shopmb!=null){
			 if(shopmb.get("type")!=null&&Integer.parseInt(shopmb.get("type").toString())==1){
				 return "jfdh"+shopmb.get("mb");
			 }else{
				 return "index"+shopmb.get("mb"); 
			 } 
		}else{ 
			return "index";
		}
		
	}
	/**
	 * 主页面
	 * @return
	 * @throws Exception 
	 */
	public void ajaxindex() throws Exception {


		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		HashMap<String, Object> backMap =new HashMap<String, Object>();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		if(Struts2Utils.getParameter("fypage")!=null){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));	
		}
		Long comid=Long.parseLong(Struts2Utils.getParameter("comid"));
		whereMap.put("comid",comid);
		
		String sel = Struts2Utils.getParameter("sel");
		if (StringUtils.isNotEmpty(sel)) {
			Pattern pattern = Pattern.compile("^.*" + sel + ".*$",Pattern.CASE_INSENSITIVE);
			whereMap.put("ptitle", pattern);
			
		}
		sortMap.put("sort", -1);
		
		backMap.put("context", 0);
		List<DBObject> proList=baseDao.getList(PubConstants.DATA_PRODUCT,whereMap,fypage,10, sortMap,backMap);
		if(proList.size()==0){
			sub_map.put("state", 1);
		}else{
			sub_map.put("state", 0);
		}
		
		sub_map.put("list", proList);
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	 
	 
	/**
	 * 出货单
	 * @return
	 * @throws IOException 
	 */
	public String orderform() throws IOException{ 
		getLscode();
		Struts2Utils.getRequest().setAttribute("custid",custid);
		Struts2Utils.getRequest().setAttribute("lscode",lscode); 
		//加载订单量
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		whereMap.put("fromUserid", fromUserid); 
		whereMap.put("custid",custid);
		Struts2Utils.getRequest().setAttribute("ordercount",baseDao.getCount(PubConstants.WX_ORDERFORM, whereMap));  
		return "orderform";
	}
	 

	 
	/**
	 * 确认货单
	 * @return
	 * @throws Exception 
	 */
	public String fahuo() throws Exception{
		custid=getCustid();
		lscode=getLscode();
		List<DBObject> relist=new ArrayList<DBObject>();
		Long _id=Long.parseLong(Struts2Utils.getParameter("_id"));
		
		DBObject order=baseDao.getMessage(PubConstants.WX_ORDERFORM, _id);
		OrderForm entity = (OrderForm)UniObject.DBObjectToObject(order,OrderForm.class);
		entity.set_id(_id);
		entity.setState(3);
		baseDao.insert(PubConstants.WX_ORDERFORM, entity);
		orderform();
		Struts2Utils.getRequest().setAttribute("custid", custid);
		Struts2Utils.getRequest().setAttribute("lscode", lscode);
		return "orderform";
	}
	 
	/**
	 * 确认货单
	 * @return
	 * @throws Exception 
	 */
	public String loginout() throws Exception{
		Struts2Utils.getSession().setAttribute("fromLogin", null);
		Struts2Utils.getRequest().setAttribute("method", "/wwz/wwz!fromuser.action");
		return "refresh";
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
		//支付的价格
		String price = Struts2Utils.getParameter("price");
		//获取提交的商品名称
		String remark = Struts2Utils.getParameter("remark");
		//商品类型
		int lx=Integer.parseInt(Struts2Utils.getParameter("lx")); 
		//总金额
		float total=Float.parseFloat(Struts2Utils.getParameter("total"));
		 
		Long recordid=0L;
		//商品编号
		if(org.apache.commons.lang.StringUtils.isNotEmpty(Struts2Utils.getParameter("recordid"))){
			recordid=Long.parseLong(Struts2Utils.getParameter("recordid"));//14
		}
		float remoney=0f;
		//商品价格
		if(org.apache.commons.lang.StringUtils.isNotEmpty(Struts2Utils.getParameter("remoney"))){
			remoney=Float.parseFloat(Struts2Utils.getParameter("remoney"));//14
		}
		//地址信息
		String name=Struts2Utils.getParameter("name");
		String tel=Struts2Utils.getParameter("tel");
		String address=Struts2Utils.getParameter("address");
		String no=Struts2Utils.getParameter("no");
		//店铺编号
		Long comid=0L;
		if(org.apache.commons.lang.StringUtils.isNotEmpty(Struts2Utils.getParameter("comid"))){
			comid=Long.parseLong(Struts2Utils.getParameter("comid"));//14
		}
		//数量
		int num=Integer.parseInt(Struts2Utils.getParameter("num"));
		Long proid=0L;
		if(org.apache.commons.lang.StringUtils.isNotEmpty(Struts2Utils.getParameter("proid"))){
			proid=Long.parseLong(Struts2Utils.getParameter("proid"));//14
		}
		//规格
		String spec=Struts2Utils.getParameter("spec");
		String  kjid=Struts2Utils.getParameter("kjid"); 
		//四位随机数
		String strRandom = TenpayUtil.buildRandom(4) + "";
		//积分返还
		String jffh=Struts2Utils.getParameter("jffh");
		//积分兑换
		String jfdh=Struts2Utils.getParameter("jfdh");
		//10位序列号,可以自行调整。
		//限购
		HashMap<String, Object>backMap=new HashMap<String, Object>();
		backMap.put("context", 0);
		backMap.put("summary", 0);
		DBObject pro=baseDao.getMessage(PubConstants.DATA_PRODUCT,recordid,backMap);
		if(pro.get("gmcs")!=null&&Integer.parseInt(pro.get("gmcs").toString())>0){ 
			HashMap<String, Object>whereMap=new HashMap<>();
			whereMap.put("pid",Integer.parseInt(pro.get("_id").toString()));
			whereMap.put("fromUserid",fromUserid);
			int  ll=0;
			List<DBObject>listdb=baseDao.getList(PubConstants.SHOP_ODERFORMPRO, whereMap,null);
			for (DBObject dbObject : listdb) {
				 DBObject  order=baseDao.getMessage(PubConstants.WX_ORDERFORM, dbObject.get("orderid").toString());
				 if(order!=null&&Integer.parseInt(order.get("state").toString())!=1){
					 ll+=Integer.parseInt(order.get("count").toString());
				 }
			}
			if(ll>=Integer.parseInt(pro.get("gmcs").toString())){
				//购买次数已完
				params.put("state", 10);
				String json = JSONArray.fromObject(params).toString();
				Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
				return;
			}
		}  
		String orderno = DateFormat.getDate() + strRandom+mongoSequence.currval("orderno");
		 	OrderForm entity=new OrderForm();
   		    entity.set_id(orderno);
    		entity.setState(1);
    		entity.setNo(no);
    		entity.setLx(lx);
    		
    		entity.setFromUserid(fromUserid); 
    		entity.setCustid(custid);
   		    entity.setName(name);
    		entity.setTel(tel);
    		entity.setAddress(address);
    		entity.setInsDate(new Date());
    		
    		entity.setComid(comid);//14
    		entity.setCount(num);//15
    		entity.setTotal(total);//6
    		entity.setKjid(kjid);
    		if(StringUtils.isNotEmpty(jfdh)){
    			entity.setJfdh(Float.parseFloat(jfdh));	
    		} 
    		entity.setZfmoney(Float.parseFloat(price));//7 
    		entity.setRecordid(recordid);
    		entity.setRemoney(remoney);
    		
    		entity.setRemark(remark+"-"+spec);
    		if(StringUtils.isNotEmpty(jffh)){
    			entity.setJffh(Float.parseFloat(jffh));
    		}
    		baseDao.insert(PubConstants.WX_ORDERFORM, entity);
    		
    		
    		
    		DBObject com=baseDao.getMessage(PubConstants.SHOP_SHOPMB,comid,backMap);
    		//JmsService.permessageMessage(custid, fromUserid, "订单信息", "用户:"+wwzService.getWxUsertype(fromUserid, "nickname")+"有一条新订单",null,pro.get("picurl").toString(),"shop-nopay","3", com.get("title").toString(),orderno,pro.get("ptitle").toString(), num+"", "0");
    		if(pro!=null){
    			OrderFormpro o=new OrderFormpro();
    			o.set_id(mongoSequence.currval(PubConstants.SHOP_ODERFORMPRO));
    			o.setCount(num);
    			o.setOrderid(orderno);
    			o.setPro(pro);
    			o.setSpec(spec);
    			o.setFromUserid(fromUserid);
    			o.setPid(Long.parseLong(pro.get("_id").toString())); 
    			baseDao.insert(PubConstants.SHOP_ODERFORMPRO, o);  
    		}
    	  
		StringBuffer attach=new StringBuffer(orderno);//0
		attach.append("&").append(custid);//
		attach.append("&").append(jffh);
		attach.append("&").append(fromUserid);
		attach.append("&").append(agid);
	 
		String nonce_str=PayCommonUtil.CreateNoncestr();
		SortedMap<Object,Object> parameters = new TreeMap<Object,Object>();
		parameters.put("appid", wxconfig.getAppid()); 
		parameters.put("mch_id", wxconfig.getPartner());
		parameters.put("nonce_str", nonce_str);
		parameters.put("attach", attach.toString());
		parameters.put("body", remark); 
		parameters.put("is_subscribe", "Y");
		parameters.put("out_trade_no", orderno);
		parameters.put("total_fee", BaseDecimal.round(BaseDecimal.multiplication(price, "100"),0));
		parameters.put("spbill_create_ip",Struts2Utils.getRequest().getRemoteAddr());
		parameters.put("notify_url", this.getCtxurl()+"/shop/shop!payok.action");
		parameters.put("trade_type", "JSAPI");
		parameters.put("openid", wwzService.getWxUser(fromUserid).get("fromUser").toString());


		String sign = PayCommonUtil.createSign("UTF-8", parameters,wxconfig.getPartner_key());
		parameters.put("sign", sign);
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
	    params.put("paySign", paySign);
	    if(StringUtils.isNotEmpty(jffh)&&Float.parseFloat(jffh)>0){
	    	 params.put("jffh",jffh);
	    }//paySign的生成规则和Sign的生成规则一致 
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
        	String jffh=attach[2];
        	String fromUserid=attach[3];
        	String agid=attach[4];
        	//更新订单
        	DBObject orderdb=baseDao.getMessage(PubConstants.WX_ORDERFORM, orderno);
        	OrderForm entity = (OrderForm)UniObject.DBObjectToObject(orderdb,OrderForm.class); 
        	entity.set_id(orderno);
        	entity.setState(2);//2为已经支付成功
        	baseDao.insert(PubConstants.WX_ORDERFORM, entity);
        	//更新库存
        	DBObject pro=baseDao.getMessage(PubConstants.DATA_PRODUCT,entity.getRecordid());
        	if(pro!=null){
        		ProductInfo  obj=(ProductInfo) UniObject.DBObjectToObject(pro, ProductInfo.class);
        		obj.setGmnum(obj.getGmnum()+entity.getCount());
        		obj.setNum(obj.getNum()-entity.getCount()); 
        		baseDao.insert(PubConstants.DATA_PRODUCT, obj);
        		
        		//记录提成
        		double price=(obj.getPrice()-obj.getDlprice())*entity.getCount();
        		if(price>0){
        			
            		wwzService.addAgent(agid, price,orderno,wwzService.getfromUseridVipNo(agid.substring(agid.indexOf("-")+1)),custid);
            		
        		}
        		
            	
        	}
        	DBObject  mb=baseDao.getMessage(PubConstants.SHOP_SHOPMB, Long.parseLong(pro.get("comid").toString()));
        	if(mb!=null){
        		ShopMb  shopmb=(ShopMb) UniObject.DBObjectToObject(mb, ShopMb.class); 
        		shopmb.setSales(shopmb.getSales()+Double.parseDouble(entity.getZfmoney()+""));
        		baseDao.insert(PubConstants.SHOP_SHOPMB, shopmb);
        	}
        	//返还积分
        	if(StringUtils.isNotEmpty(jffh)&&Float.parseFloat(jffh)>0){
        		wwzService.addjf(jffh, fromUserid, "shop-fh", custid, null);
        	}
        	if(entity.getJfdh()>0){
        		wwzService.deljf(entity.getJfdh()+"", fromUserid,"shop-dh", custid, null);
        	}
        	Paymentorder paymentorder=new Paymentorder();
        	paymentorder.set_id(orderno);
        	paymentorder.setComid(entity.getComid());
        	paymentorder.setCustid(custid);
        	paymentorder.setFromUserid(fromUserid);
        	paymentorder.setPrice(Double.parseDouble(entity.getZfmoney()+""));
        	paymentorder.setCreatedate(new Date());
        	paymentorder.setType(3);
        	baseDao.insert(PubConstants.SHOP_PAYMENTORDER, paymentorder);
        	MessageInfo  me=new MessageInfo();
        	me.setCustid(custid);
        	me.setFromUserid(fromUserid);
        	me.setTitle("订单提醒");
        	me.setSummary("您有一条来自"+wwzService.getWxUsertype(fromUserid, "nickname")+"的订单");
        	me.setPicurl("");
        	me.setUrl("");
        	me.setLx("shop-pay");
        	me.setType(3);
        	me.setComname(baseDao.getMessage(PubConstants.SHOP_SHOPMB,entity.getComid()).get("name").toString());
        	me.setProcount(entity.getCount()+"");
        	me.setProtitle(pro.get("ptitle").toString()+" "+entity.getCount()+"件");
        	me.setProstate("2");
        	me.setOrderid(orderno);
        	JmsService.permessageMessage(me);
           
        	
        	Struts2Utils.getResponse().getWriter().write(PayCommonUtil.setXML("SUCCESS", ""));
        	
        }else{
        	Struts2Utils.getResponse().getWriter().write(PayCommonUtil.setXML("SUCCESS", ""));
        }
       
        
       

	}
	/**
	 * 微信支付
	 * @throws Exception
	 */
	public void wxcarpay() throws Exception{
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
		//支付的价格
		String price = Struts2Utils.getParameter("price");
		//获取提交的商品名称
		String remark = Struts2Utils.getParameter("remark");
		//商品类型
		int lx=Integer.parseInt(Struts2Utils.getParameter("lx"));//0 商品 1选号 2扫码付3优惠劵4砍价
		//总金额
		float total=0f;
		  
		String recordid=null;
		//商品编号
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("recordid"))){
			recordid=Struts2Utils.getParameter("recordid");//14
		}
		String remoney=null;
		//商品价格
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("remoney"))){
			remoney=Struts2Utils.getParameter("remoney");//14
		}
		String spec=null;
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("spec"))){
			spec=Struts2Utils.getParameter("spec");
		}
				
		//地址信息
		String name=Struts2Utils.getParameter("name");
		String tel=Struts2Utils.getParameter("tel");
		String address=Struts2Utils.getParameter("address");
		String no=Struts2Utils.getParameter("no");
		//店铺编号
		Long comid=0L;
		if(org.apache.commons.lang.StringUtils.isNotEmpty(Struts2Utils.getParameter("comid"))){
			comid=Long.parseLong(Struts2Utils.getParameter("comid"));//14
		}
		//数量
		String num=Struts2Utils.getParameter("num");
		Long proid=0L;
		if(org.apache.commons.lang.StringUtils.isNotEmpty(Struts2Utils.getParameter("proid"))){
			proid=Long.parseLong(Struts2Utils.getParameter("proid"));//14
		}
	 
		//积分返还
		float jffh=0; 
	 
				//四位随机数
				String strRandom = TenpayUtil.buildRandom(4) + "";
				//10位序列号,可以自行调整。
				String orderno = DateFormat.getDate() + strRandom+mongoSequence.currval("orderno");
				  
				OrderForm entity=new OrderForm();
		   		    entity.set_id(orderno);
		    		entity.setState(1);
		    		entity.setNo(no);
		    		entity.setLx(lx);
		    		
		    		entity.setFromUserid(fromUserid); 
		    		entity.setCustid(custid);
		   		    entity.setName(name);
		    		entity.setTel(tel);
		    		entity.setAddress(address);
		    		entity.setInsDate(new Date());
		    		
		    		entity.setComid(comid);//14
		    		entity.setCounts(num);//15
		    		entity.setTotal(total);//6
		    		
		    		
		    		entity.setZfmoney(Float.parseFloat(price));//7 
		    		entity.setIds(recordid);  
		    		entity.setRemark(remark);
		    		
		    		String[] ids=recordid.split(",");
		    		String[]nums=num.split(","); 
		    		String[]specs=spec.split(",");
		    		for (int i = 0; i < ids.length; i++) {
						if(StringUtils.isNotEmpty(ids[i])){ 
							DBObject  shop=baseDao.getMessage(PubConstants.SUC_SHOPPINGCART, Long.parseLong(ids[i]));
							HashMap<String, Object>backMap=new HashMap<String, Object>();
				    		backMap.put("context", 0);
				    		backMap.put("summary", 0);
							DBObject  pro=baseDao.getMessage(PubConstants.DATA_PRODUCT, Long.parseLong(shop.get("pid").toString()),backMap);
							
							if(pro.get("gmcs")!=null&&Integer.parseInt(pro.get("gmcs").toString())>0){
								HashMap<String, Object>whereMap=new HashMap<>();
								whereMap.put("pid",Integer.parseInt(pro.get("_id").toString()));
								whereMap.put("fromUserid",fromUserid);
								int  ll=0;
								List<DBObject>listdb=baseDao.getList(PubConstants.SHOP_ODERFORMPRO, whereMap,null);
								for (DBObject dbObject : listdb) {
									 DBObject  order=baseDao.getMessage(PubConstants.WX_ORDERFORM, dbObject.get("orderid").toString());
									 if(order!=null&&Integer.parseInt(order.get("state").toString())!=1){
										 ll+=Integer.parseInt(order.get("count").toString());
									 }
								} 
								if(ll>=Integer.parseInt(pro.get("gmcs").toString())){
									//购买次数已完
									params.put("state", 10);
									String json = JSONArray.fromObject(params).toString();
									Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
									return;
								}
							} 
							
							//生成信息
							if(pro!=null){
								if(pro.get("jffh")!=null){
									jffh=jffh+Float.parseFloat(pro.get("jffh").toString());
								}
								OrderFormpro ord=new OrderFormpro();
								ord.set_id(mongoSequence.currval(PubConstants.SHOP_ODERFORMPRO));
								
								ord.setOrderid(orderno);
								ord.setCount(Integer.parseInt(nums[i]));
								ord.setPro(pro);
								ord.setPid(Long.parseLong(pro.get("_id").toString()));
								ord.setSpec(specs[i]);
								baseDao.insert(PubConstants.SHOP_ODERFORMPRO, ord);  
							}
							

							
						}
					}
		 entity.setJffh(jffh);
		 baseDao.insert(PubConstants.WX_ORDERFORM, entity);
		 
		StringBuffer attach=new StringBuffer(orderno);//0
		attach.append("&").append(custid);//
		attach.append("&").append(jffh);//
		attach.append("&").append(fromUserid);//
		attach.append("&").append(agid);//
	    
		String nonce_str=PayCommonUtil.CreateNoncestr();
		SortedMap<Object,Object> parameters = new TreeMap<Object,Object>();
		parameters.put("appid", wxconfig.getAppid()); 
		parameters.put("mch_id", wxconfig.getPartner());
		parameters.put("nonce_str", nonce_str);
		parameters.put("attach", attach.toString());
		parameters.put("body", remark);
		parameters.put("out_trade_no", orderno);
		parameters.put("total_fee", BaseDecimal.round(BaseDecimal.multiplication(price, "100"),0));
		parameters.put("spbill_create_ip",Struts2Utils.getRequest().getRemoteAddr());
		parameters.put("notify_url", this.getCtxurl()+"/shop/shop!paycarok.action");
		parameters.put("trade_type", "JSAPI");
		parameters.put("openid", wwzService.getWxUser(fromUserid).get("fromUser").toString());


		String sign = PayCommonUtil.createSign("UTF-8", parameters,wxconfig.getPartner_key());
		parameters.put("sign", sign);
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
	    params.put("paySign", paySign);
	    if(jffh>0){
	    	 params.put("jffh",jffh);	
	    }//paySign的生成规则和Sign的生成规则一致 
	    params.put("state", 0);
	  
	    params.put("orderno", orderno);
		String json = JSONArray.fromObject(params).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 通知
	 * @throws Exception
	 */
	public void paycarok() throws Exception{ 
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
        	String jffh=attach[2];
        	String fromUserid=attach[3];
        	String agid=attach[4];
        	DBObject orderdb=baseDao.getMessage(PubConstants.WX_ORDERFORM, orderno);
        	OrderForm entity = (OrderForm)UniObject.DBObjectToObject(orderdb,OrderForm.class);
            //支付成功
        	entity.set_id(orderno);
        	entity.setState(2);//2为已经支付成功
        	baseDao.insert(PubConstants.WX_ORDERFORM, entity);
        	HashMap<String, Object>whereMap=new HashMap<String, Object>();
        	whereMap.put("orderid",orderno);
        	List<DBObject>list=baseDao.getList(PubConstants.SHOP_ODERFORMPRO, whereMap, null);
        	String ptitle="";
        	if(list.size()>0){
        		for (DBObject dbObject : list) {
        			OrderFormpro db=(OrderFormpro) UniObject.DBObjectToObject(dbObject, OrderFormpro.class);
        			DBObject  pro=db.getPro();
        			if(pro!=null){
        				ProductInfo obj=(ProductInfo) UniObject.DBObjectToObject(pro, ProductInfo.class);
        				obj.setGmnum(obj.getGmnum()+db.getCount());
        				obj.setNum(obj.getNum()-db.getCount());
        				baseDao.insert(PubConstants.DATA_PRODUCT, obj);
        				ptitle+=obj.getPtitle()+" "+db.getCount()+"件,";
        				DBObject  mb=baseDao.getMessage(PubConstants.SHOP_SHOPMB, obj.getComid());
        	        	if(mb!=null){
        	        		ShopMb  shopmb=(ShopMb) UniObject.DBObjectToObject(mb, ShopMb.class); 
        	        		shopmb.setSales(shopmb.getSales()+obj.getPrice());
        	        		baseDao.insert(PubConstants.SHOP_SHOPMB, shopmb);
        	        	}
        	        	//记录提成
                		double price=(obj.getPrice()-obj.getDlprice())*db.getCount();
                		if(price>0){ 
                    		wwzService.addAgent(agid, price,orderno,wwzService.getfromUseridVipNo(agid.substring(agid.indexOf("-")+1)),custid); 
                		}
        			}
				}
        	}
        	//返还积分
        	if(StringUtils.isNotEmpty(jffh)&&Float.parseFloat(jffh)>0){
        		wwzService.addjf(jffh, fromUserid, "shop-fh", custid, null);
        	}
        	Paymentorder paymentorder=new Paymentorder();
        	paymentorder.set_id(orderno);
        	paymentorder.setComid(entity.getComid());
        	paymentorder.setCustid(custid);
        	paymentorder.setFromUserid(fromUserid);
        	paymentorder.setPrice(Double.parseDouble(entity.getZfmoney()+""));
        	paymentorder.setType(2);
        	paymentorder.setCreatedate(new Date());
        	baseDao.insert(PubConstants.SHOP_PAYMENTORDER, paymentorder);
        	MessageInfo  me=new MessageInfo();
        	me.setCustid(custid);
        	me.setFromUserid(fromUserid);
        	me.setTitle("订单提醒");
        	me.setSummary("您有一条来自"+wwzService.getWxUsertype(fromUserid, "nickname")+"的订单");
        	me.setPicurl("");
        	me.setUrl("");
        	me.setLx("shop-pay");
        	me.setType(3);
        	me.setComname(baseDao.getMessage(PubConstants.SHOP_SHOPMB,entity.getComid()).get("name").toString());
        	me.setProcount("");
        	me.setProtitle(ptitle);
        	me.setProstate("2");
        	me.setOrderid(orderno);
        	JmsService.permessageMessage(me);
        	 
        	Struts2Utils.getResponse().getWriter().write(PayCommonUtil.setXML("SUCCESS", ""));
        	
        }else{
        	Struts2Utils.getResponse().getWriter().write(PayCommonUtil.setXML("SUCCESS", ""));
        }
       

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

	@Override
	public Object getModel() {
		// TODO Auto-generated method stub
		return null;
	}
	/**
	 * ajax获取列表
	 */
	public void ajaxweb(){
		Map<String, Object> sub_map = new HashMap<String, Object>();
		try {
			String  cid=Struts2Utils.getParameter("cid");
			custid=Struts2Utils.getParameter("custid"); 
			String lx=Struts2Utils.getParameter("lx"); 
			String sel=Struts2Utils.getParameter("sel");
			HashMap<String, Object>whereMap=new HashMap<String, Object>(); 
			HashMap<String, Object>sortMap=new HashMap<String, Object>(); 
			HashMap<String, Object> backMap =new HashMap<String, Object>();
			BasicDBObject dateCondition = new BasicDBObject();
			//去除不显示的数据
			dateCondition.append("$ne",1);
			whereMap.put("isxs",dateCondition);
			if(Struts2Utils.getParameter("fypage")!=null){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));	
			}
			if(StringUtils.isNotEmpty(lx)){
				Pattern pattern = Pattern.compile("^.*" + lx + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("hylx", pattern); 
			}
			if(StringUtils.isNotEmpty(sel)){
				Pattern pattern = Pattern.compile("^.*" + sel + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("ptitle", pattern); 
			}
			DBObject  obj=baseDao.getMessage(PubConstants.SHOP_SHOPMB, Long.parseLong(cid)); 
			whereMap.put("comid", Long.parseLong(cid));
			sortMap.put("sort", -1);
			backMap.put("context", 0);
			List<DBObject>list=baseDao.getList(PubConstants.DATA_PRODUCT, whereMap,fypage,10, sortMap,backMap);
			if(list.size()>0){
				sub_map.put("state",0);
				sub_map.put("list", list);
			}else{
				sub_map.put("state", 1);
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			sub_map.put("state", 1);
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * ajax添加购物车
	 */
	public void  ajaxshopcarsave(){
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		try {
			getLscode();
			String  pid=Struts2Utils.getParameter("pid");
			String  spec=Struts2Utils.getParameter("spec");
			String  counts=Struts2Utils.getParameter("count");
			String  price=Struts2Utils.getParameter("price");
			Shoppingcart  shop=new Shoppingcart();
			shop.set_id(mongoSequence.currval(PubConstants.SUC_SHOPPINGCART));
			shop.setCount(1);
			shop.setFromUserid(fromUserid);
			shop.setCreatedate(new Date());
			shop.setCustid(custid); 
			shop.setPid(Long.parseLong(pid));
			shop.setSpec(spec);
			shop.setCount(Integer.parseInt(counts));
			shop.setState(0);
			if(StringUtils.isNotEmpty(price)){
				shop.setPrice(Float.parseFloat(price));
			}
			baseDao.insert(PubConstants.SUC_SHOPPINGCART, shop);
			HashMap<String, Object>whereMap=new HashMap<String, Object>(); 
			whereMap.put("fromUserid", fromUserid);  
			whereMap.put("custid",custid);
			Long count=baseDao.getCount(PubConstants.SUC_SHOPPINGCART,whereMap); 
			sub_map.put("state", 0);
			sub_map.put("value", count);
			
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			sub_map.put("state", 1);
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
		
	}
	/**
	 * 移除购物车
	 */
	public void  ajaxdelshopcar(){
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		String id=Struts2Utils.getParameter("id");
		if(StringUtils.isNotEmpty(id)){
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			whereMap.put("fromUserid", fromUserid);
			whereMap.put("_id", Long.parseLong(id));
			baseDao.delete(PubConstants.SUC_SHOPPINGCART, whereMap);
			sub_map.put("state", 0);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * ajax获取购物车列表
	 */
	public void  ajaxshopcarweb(){
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		try { 
			getLscode(); 
			HashMap<String,Object>whereMap=new HashMap<String, Object>();
			HashMap<String,Object>sortMap=new HashMap<String, Object>();
			whereMap.put("fromUserid", fromUserid);
			whereMap.put("custid", custid);
			sortMap.put("ceatedate",-1);
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			List<DBObject>list=baseDao.getList(PubConstants.SUC_SHOPPINGCART, whereMap,fypage,10,sortMap); 
			if(list.size()>0){
				for (DBObject dbObject : list) {
					DBObject  db=baseDao.getMessage(PubConstants.DATA_PRODUCT,Long.parseLong(dbObject.get("pid").toString()));
					
					if(db!=null){ 
						dbObject.put("product", db);	
					}else{
						//移除已经失效的订单
						baseDao.delete(PubConstants.SUC_SHOPPINGCART, Long.parseLong(dbObject.get("_id").toString()));
						 
					}
				}
				sub_map.put("state", 0);
				sub_map.put("list", list);
			}else{
				sub_map.put("state", 1);
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			sub_map.put("state", 1);
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	 	
	}
	/**
	 * 商品详情
	 * @return
	 */
	public String  shopproduct(){
		getLscode();  
		String  pid=Struts2Utils.getParameter("pid"); 
		WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 }
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/shop/shop!shopproduct.action?custid="+custid+"&pid="+pid+"&agid="+agid;  
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
		wwzService.flow(custid, "shop");
		wwzService.flow(custid, "shop-pro-"+pid);
		DBObject  db=baseDao.getMessage(PubConstants.DATA_PRODUCT, Long.parseLong(pid));  
		HashMap<String, Object>whereMap=new HashMap<String, Object>(); 
		whereMap.put("fromUserid", fromUserid);
		whereMap.put("custid", custid);
		Long count=baseDao.getCount(PubConstants.SUC_SHOPPINGCART,whereMap);
		Struts2Utils.getRequest().setAttribute("custid",custid);
		Struts2Utils.getRequest().setAttribute("entity",db);
		if(Integer.parseInt(db.get("bq").toString())==8){
			double bl= Double.parseDouble(db.get("price").toString())/Double.parseDouble(db.get("oldprice").toString());   
			Struts2Utils.getRequest().setAttribute("bl",new java.text.DecimalFormat("#").format(bl*100)); 	
		}else if(Integer.parseInt(db.get("bq").toString())==9){
			whereMap.clear();
			whereMap.put("proid",Long.parseLong(pid));
			Long   bcount=baseDao.getCount(PubConstants.SHOP_BULKYD, whereMap);
			double bl= Double.parseDouble(bcount+"")/Double.parseDouble(db.get("pcount").toString());   
			Struts2Utils.getRequest().setAttribute("bl",new java.text.DecimalFormat("#").format(bl*100)); 	
			Struts2Utils.getRequest().setAttribute("needcount",Long.parseLong(db.get("pcount").toString())-bcount);
			whereMap.put("fromUserid", fromUserid);
			bcount=baseDao.getCount(PubConstants.SHOP_BULKYD, whereMap);
			if(bcount==1){
				Struts2Utils.getRequest().setAttribute("ispay",true);
			}
		}
		if(StringUtils.isEmpty(agid)){
			agid=wwzService.getAgid(db.get("comid").toString(), wwzService.getVipNo(fromUserid));
			if(StringUtils.isNotEmpty(agid)){
				Struts2Utils.getRequest().setAttribute("agid",agid);
			}
		}
		Struts2Utils.getRequest().setAttribute("shopcount",count);
		Struts2Utils.getRequest().setAttribute("slide",wwzService.getslide(custid, "shoppro-"+pid));
		//加载地址信息
		whereMap.clear();
		whereMap.put("fromUserid",fromUserid);
		whereMap.put("lx", 1);
		DBObject  address=baseDao.getMessage(PubConstants.SHOP_USERADDRESS, whereMap); 
		Struts2Utils.getRequest().setAttribute("address",address); 
		
		//加载商品规格
		whereMap.clear();
		whereMap.put("parentid",Long.parseLong(pid));
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		sortMap.put("sort",-1);
		List<DBObject>spelist=baseDao.getList(PubConstants.SHOP_SPECIFICATION, whereMap, sortMap);
		if(spelist.size()>0){
			Struts2Utils.getRequest().setAttribute("spelist", spelist);	
		}
		//加载用户积分
		Struts2Utils.getRequest().setAttribute("jf", wwzService.getJf(custid, fromUserid));
		DBObject  share=new BasicDBObject();
		share.put("fxtitle",db.get("ptitle"));
		share.put("fximg",db.get("logo"));
		share.put("fxsummary",db.get("summary"));
		share.put("fxurl",url);
		Struts2Utils.getRequest().setAttribute("share", share); 
		
		//加载限购信息 
		if(db.get("gmcs")!=null&&Integer.parseInt(db.get("gmcs").toString())>0){ 
			whereMap.clear();
			whereMap.put("pid", Long.parseLong(pid));
			whereMap.put("fromUserid", fromUserid); 
			int ll=0;
			//预订库检测
			List<DBObject> list=baseDao.getList(PubConstants.SHOP_ODERFORMPRO,whereMap,null); 
			for (DBObject dbObject : list) {
				 DBObject  order=baseDao.getMessage(PubConstants.WX_ORDERFORM, dbObject.get("orderid").toString());
				 if(order!=null&&Integer.parseInt(order.get("state").toString())!=1){
					 ll+=Integer.parseInt(order.get("count").toString());
				 }
			}
			//购物车检测
			whereMap.clear();
			whereMap.put("pid", Long.parseLong(pid));
			whereMap.put("fromUserid", fromUserid);
			
			List<DBObject>listgwc=baseDao.getList(PubConstants.SUC_SHOPPINGCART, whereMap,null);
			for (DBObject dbObject : listgwc) {
				ll+=Integer.parseInt(dbObject.get("count").toString());
			} 
			if(ll>=Integer.parseInt(db.get("gmcs").toString())){
				Struts2Utils.getRequest().setAttribute("gmcs",0);
			}else{
				Struts2Utils.getRequest().setAttribute("gmcs",Integer.parseInt(db.get("gmcs").toString())-ll);
			}
		}
		    
		    //检测代理 
			if(wwzService.checkAgent(agid, custid, fromUserid)){
				Struts2Utils.getRequest().setAttribute("isAgent","ok");
			}
		    //检测全局代理 
			if(wwzService.checkAgent(custid,fromUserid)){
				Struts2Utils.getRequest().setAttribute("isAgents","ok");
			}
			//检测当前店铺
			if(StringUtils.isNotEmpty(wwzService.getAgid(db.get("comid").toString(),wwzService.getVipNo(fromUserid)))){
				Struts2Utils.getRequest().setAttribute("isAgentcom","ok");
			}
		
		return "productdetail"+db.get("bq");
	 
	}
	
	/**
	 * 购物车详情
	 * @return
	 */
	public String  shoppingcar(){
		getLscode();
		Struts2Utils.getRequest().setAttribute("user",wwzService.getWxUser(fromUserid));
		String  pid=Struts2Utils.getParameter("pid");  
		Struts2Utils.getRequest().setAttribute("custid",custid);
		Struts2Utils.getRequest().setAttribute("pid",pid); 
		//加载地址信息
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		whereMap.put("fromUserid",fromUserid);
		whereMap.put("lx", 1); 
		DBObject  address=baseDao.getMessage(PubConstants.SHOP_USERADDRESS, whereMap); 
		Struts2Utils.getRequest().setAttribute("address",address);
		whereMap.clear();
		whereMap.put("custid", custid);
		whereMap.put("lx", 1);
		DBObject  entity=baseDao.getMessage(PubConstants.SHOP_SHOPMB, whereMap);
		Struts2Utils.getRequest().setAttribute("entity",entity);
		
		return "shoppingcar";
	 
	}
	/**
	 * 订单确认
	 * @return
	 */
	public String orderconfirmation(){
		getLscode();
		String  pid=Struts2Utils.getParameter("pid"); 
		DBObject  db=baseDao.getMessage(PubConstants.DATA_PRODUCT, Long.parseLong(pid));
		//加载地址信息
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		whereMap.put("fromUserid",fromUserid);
		whereMap.put("lx", 1);
		DBObject  address=baseDao.getMessage(PubConstants.SHOP_USERADDRESS, whereMap); 
		Struts2Utils.getRequest().setAttribute("address",address); 
		Struts2Utils.getRequest().setAttribute("custid",custid); 
		Struts2Utils.getRequest().setAttribute("entity",db); 
		Struts2Utils.getRequest().setAttribute("user",wwzService.getWxUser(fromUserid));
		Struts2Utils.getRequest().setAttribute("spec",Struts2Utils.getParameter("spec"));
		 
		Struts2Utils.getRequest().setAttribute("count",Struts2Utils.getParameter("count"));
		Struts2Utils.getRequest().setAttribute("byprice",baseDao.getMessage(PubConstants.SHOP_SHOPMB, Long.parseLong(db.get("comid").toString())).get("byprice"));
		Struts2Utils.getRequest().setAttribute("price",Struts2Utils.getParameter("price"));
		return "orderconfirmation";
		
	}
	/**
	 * ajax删除地址
	 */
	public void ajaxdeladdress(){
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		try {
			String id=Struts2Utils.getParameter("id");
			HashMap<String , Object>whereMap=new HashMap<String, Object>();
			whereMap.put("fromUserid", fromUserid);
			whereMap.put("_id", Long.parseLong(id));
			baseDao.delete(PubConstants.SHOP_USERADDRESS, whereMap);
			sub_map.put("state",0);
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * 生成订单
	 */
	public void  shoppay(){
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		try {
			getLscode();
			String  pid=Struts2Utils.getParameter("pid"); 
			String  jfdh=Struts2Utils.getParameter("jfdh");
			String  count=Struts2Utils.getParameter("count");
			String  money=Struts2Utils.getParameter("money");
			String  address=Struts2Utils.getParameter("address");
			String  tel=Struts2Utils.getParameter("tel");
			if(pid.indexOf(",")<0){
				 
				OrderForm  obj=new OrderForm();
				obj.set_id(mongoSequence.currval(PubConstants.WX_ORDERFORM));
				obj.setAddress(address);
				obj.setComid(Long.parseLong(pid));
				obj.setFromUserid(fromUserid);
				obj.setCreatedate(new Date());
				obj.setCustid(custid);
				obj.setJfdh(Float.parseFloat(jfdh));
				obj.setMoney(Double.parseDouble(money));
				obj.setState(0);
				obj.setTel(tel);
				obj.setCount(Integer.parseInt(count));
				baseDao.insert(PubConstants.WX_ORDERFORM, obj);
			}else{
				
				String[]pids=pid.split(",");
				String[]counts=count.split(",");
				for (int i = 0; i < pids.length; i++) {
					if(StringUtils.isNotEmpty(pids[i])){
						OrderForm  obj=new OrderForm();
						obj.set_id(mongoSequence.currval(PubConstants.WX_ORDERFORM));
						obj.setAddress(address);
						obj.setComid(Long.parseLong(pids[i]));
						obj.setFromUserid(fromUserid);
						obj.setCreatedate(new Date());
						obj.setCustid(custid); 
						obj.setState(0);
						obj.setTel(tel);
						obj.setCount(Integer.parseInt(counts[i]));
						baseDao.insert(PubConstants.WX_ORDERFORM, obj); 
					}
				
				}
				
				
				
			}
		
			sub_map.put("state", 0);
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			sub_map.put("state", 1);
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 订单列表
	 */
	public  String  orderfrom(){  
		Struts2Utils.getRequest().setAttribute("custid",Struts2Utils.getParameter("custid"));
		Struts2Utils.getRequest().setAttribute("lscode",Struts2Utils.getParameter("lscode"));
		return "orderfrom";
		
	}
	public void  ajaxdelorder(){ 
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		String id=Struts2Utils.getParameter("id");
		if(StringUtils.isNotEmpty(id)){
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			whereMap.put("fromUserid",fromUserid);
			whereMap.put("_id",id);
			DBObject  db=baseDao.getMessage(PubConstants.WX_ORDERFORM, whereMap); 
			if(db!=null){
				OrderForm  orderForm=(OrderForm) UniObject.DBObjectToObject(db, OrderForm.class);
				orderForm.setIsxs(1);
				baseDao.insert(PubConstants.WX_ORDERFORM, orderForm);
				sub_map.put("state", 0);
			}
			
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	} 
	/**
	 * ajax获取订单列表
	 */
	public  void  ajaxorder(){
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		try { 
			getLscode();
			Struts2Utils.getRequest().setAttribute("custid",Struts2Utils.getParameter("custid"));
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			sortMap.put("insDate", -1);
			whereMap.put("custid",custid);
			whereMap.put("fromUserid", fromUserid);
			
			List<DBObject>list=baseDao.getList(PubConstants.WX_ORDERFORM, whereMap,fypage,10,sortMap);
			List<DBObject>lsodb=new ArrayList<DBObject>();
			if(list.size()>0){ 
				for (DBObject dbObject : list) { 
					if(dbObject.get("recordid")!=null){
						DBObject  db=baseDao.getMessage(PubConstants.DATA_PRODUCT, Long.parseLong(dbObject.get("recordid").toString()));
						if(db!=null){
							dbObject.put("pro",db);	
							lsodb.add(dbObject);
						}else{
							//清空
							 
							baseDao.delete(PubConstants.WX_ORDERFORM,dbObject.get("_id").toString());
							 
						}
						
					}else if(dbObject.get("ids")!=null){ 
						  	String[]sd=dbObject.get("ids").toString().split(",");
							List<DBObject>lists=new ArrayList<DBObject>();
							for (int i = 0; i < sd.length; i++) {
								if(StringUtils.isNotEmpty(sd[i])){
									DBObject  db=baseDao.getMessage(PubConstants.DATA_PRODUCT, Long.parseLong(sd[i]));
									if(db!=null){
										lists.add(db);
									} 
										
								}
							
							}
							if(lists.size()>0){
								dbObject.put("list",lists);
								lsodb.add(dbObject);
							}else{
								//清空  
								baseDao.delete(PubConstants.WX_ORDERFORM,dbObject.get("_id").toString());
								 
							}
						 
					}else{
						//清空
						baseDao.delete(PubConstants.WX_ORDERFORM,dbObject.get("_id").toString());
					}
					
				}  
				sub_map.put("state", 0);
				sub_map.put("list",lsodb);
			}else{
				sub_map.put("state", 1);
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			sub_map.put("state", 1);
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		 
		 
	}
	/**
	 * ajax获取订单列表
	 */
	public  void  ajaxorders(){
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		try {
			getLscode();
			Struts2Utils.getRequest().setAttribute("custid",Struts2Utils.getParameter("custid"));
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			sortMap.put("insDate", -1);
			whereMap.put("custid",custid);
			whereMap.put("isxs",new BasicDBObject("$ne",1));
			whereMap.put("fromUserid", fromUserid); 
			
			List<DBObject>list=baseDao.getList(PubConstants.WX_ORDERFORM, whereMap,fypage,10,sortMap);
			List<DBObject>lsodb=new ArrayList<DBObject>();
			if(list.size()>0){ 
				for (DBObject dbObject : list) { 
					if(dbObject.get("kdcom")!=null){
						dbObject.put("kdcom", wwzService.getKdName(dbObject.get("kdcom").toString()));
					}
					 HashMap<String, Object>wheresMap=new HashMap<String, Object>();
					 HashMap<String, Object>sortsMap=new HashMap<String, Object>();
					 wheresMap.put("orderid",dbObject.get("_id").toString());
					 List<DBObject>lists=baseDao.getList(PubConstants.SHOP_ODERFORMPRO, wheresMap, sortsMap);
					 
					 if(lists.size()>0){
						 dbObject.put("list", lists);
						 lsodb.add(dbObject);
					 }else{
						//清空 
						 baseDao.delete(PubConstants.WX_ORDERFORM,dbObject.get("_id").toString());
					 }
				 	
				} 
				sub_map.put("state", 0);
				sub_map.put("list",lsodb);
			}else{
				sub_map.put("state", 1);
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			sub_map.put("state", 1);
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		 
		 
	}
	/**
	 * 用户地址管理
	 */
	public String  useraddress(){
		getLscode(); 
		Struts2Utils.getRequest().setAttribute("custid",custid);
		Struts2Utils.getRequest().setAttribute("addressis", Struts2Utils.getParameter("addressis"));
		Struts2Utils.getRequest().setAttribute("backurl", Struts2Utils.getParameter("backurl"));
		Struts2Utils.getRequest().setAttribute("count", Struts2Utils.getParameter("count"));
		Struts2Utils.getRequest().setAttribute("price", Struts2Utils.getParameter("price"));
		Struts2Utils.getRequest().setAttribute("spec", Struts2Utils.getParameter("spec"));
		 
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		whereMap.put("fromUserid",fromUserid);
		whereMap.put("lx", 1);
		DBObject  address=baseDao.getMessage(PubConstants.SHOP_USERADDRESS, whereMap);
		Struts2Utils.getRequest().setAttribute("address",address); 
		return "address";
		
	}
	/**
	 * 用户新增管理
	 */
	public String  useraddresssave(){
		getLscode(); 
		Struts2Utils.getRequest().setAttribute("addressis", Struts2Utils.getParameter("addressis"));
		 
		Struts2Utils.getRequest().setAttribute("backurl", Struts2Utils.getParameter("backurl")); 
		Struts2Utils.getRequest().setAttribute("count", Struts2Utils.getParameter("count"));
		Struts2Utils.getRequest().setAttribute("price", Struts2Utils.getParameter("price"));
		Struts2Utils.getRequest().setAttribute("spec", Struts2Utils.getParameter("spec"));
		 
		Struts2Utils.getRequest().setAttribute("custid",custid);
		return "addresssave";
		
	}
	/**
	 * ajax获取用户地址
	 */
	public void  ajaxuseraddress(){
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		try {
			getLscode();
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			sortMap.put("createdate", -1); 
			whereMap.put("fromUserid", fromUserid);
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			List<DBObject>list=baseDao.getList(PubConstants.SHOP_USERADDRESS, whereMap,fypage,10,sortMap);
			if(list.size()>0){
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
	/**
	 * 设置默认地址
	 */
	public void  ajaxsetaddress(){
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		try {
			getLscode();
			
			String  id=Struts2Utils.getParameter("id");
		    //先验证
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			whereMap.put("lx", 1);
			whereMap.put("fromUserid", fromUserid);
			List<DBObject>list=baseDao.getList(PubConstants.SHOP_USERADDRESS, whereMap, null);
			if(list.size()>0){ 
				for (DBObject dbObject : list) {
					Useraddress address=(Useraddress) UniObject.DBObjectToObject(dbObject, Useraddress.class);
					address.setLx(0);
					baseDao.insert(PubConstants.SHOP_USERADDRESS, address);
				}
			}
		    DBObject  db=baseDao.getMessage(PubConstants.SHOP_USERADDRESS, Long.parseLong(id));
		    if(db!=null){ 
		        Useraddress address=(Useraddress) UniObject.DBObjectToObject(db, Useraddress.class); 
			    address.setLx(1);
				baseDao.insert(PubConstants.SHOP_USERADDRESS, address);
				sub_map.put("state", 0);
		    }
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			sub_map.put("state", 1);
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * ajax新增用户地址
	 */
	public void  ajaxuseraddresssave(){
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		try {
			getLscode();
			String  address=Struts2Utils.getParameter("address");
			String  province=Struts2Utils.getParameter("province");
			String  city=Struts2Utils.getParameter("city");
			String  county=Struts2Utils.getParameter("county");
			String  name=Struts2Utils.getParameter("name");
			String  tel=Struts2Utils.getParameter("tel");
			 
			Useraddress  obj=new Useraddress();
			Long id=mongoSequence.currval(PubConstants.SHOP_USERADDRESS);
			obj.set_id(id);
			obj.setAddress(address);
			obj.setCity(city);
			obj.setCounty(county);
			obj.setCreatedate(new Date());
			obj.setFromUserid(fromUserid);
			obj.setName(name);
			obj.setTel(tel);
			obj.setProvince(province);
			baseDao.insert(PubConstants.SHOP_USERADDRESS, obj);
			sub_map.put("state", 0); 
			sub_map.put("value", id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			sub_map.put("state", 1);
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * ajax删除地址
	 */
	public  String   useraddressdel(){
     getLscode();
     HashMap<String, Object>whereMap=new HashMap<String, Object>();
	 String  id=Struts2Utils.getParameter("id");
	 whereMap.put("fromUserid", fromUserid);
	 whereMap.put("_id",Long.parseLong(id));
	 baseDao.delete(PubConstants.SHOP_USERADDRESS,whereMap);
	 return "address";
	 
	}
	/**
	 * ajax获取推广
	 */
	public void   ajaxgettg(){
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		String  comid=Struts2Utils.getParameter("comid");
		if(StringUtils.isNotEmpty(comid)){
		   HashMap<String, Object>whereMap=new HashMap<String, Object>();
		   HashMap<String, Object>sortMap=new HashMap<String, Object>();
		   whereMap.put("comid",Long.parseLong(comid));
		   whereMap.put("custid", custid);
		   sortMap.put("createdate", -1);
		   if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			   fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		   }
		   List<DBObject>list=baseDao.getList(PubConstants.SHOP_SHOPTG, whereMap,fypage,9,sortMap);
		   if(list.size()>0){
			   for (DBObject dbObject : list) {
				dbObject.put("pro", baseDao.getMessage(PubConstants.DATA_PRODUCT, Long.parseLong(dbObject.get("pid").toString())));
			}
			 
			  sub_map.put("state", 0);
			  sub_map.put("list", list);
		   }
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 砍价详情
	 */
	public String  bargaindetail(){
		getLscode();
		String  id=Struts2Utils.getParameter("id"); 
		WxToken token=GetAllFunc.wxtoken.get(custid);
		 if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 } 
	    Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/shop/shop!bargaindetail.action?custid="+custid+"&id="+id;  
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
		DBObject  db=baseDao.getMessage(PubConstants.SHOP_BARGAININGYD,id);
		Bargainingyd yd=(Bargainingyd) UniObject.DBObjectToObject(db, Bargainingyd.class);
		ProductInfo  prd=yd.getPro(); 
		db.put("nickname", wwzService.getWxUsertype(db.get("fromUserid").toString(),"nickname"));
		db.put("headimgurl", wwzService.getWxUsertype(db.get("fromUserid").toString(),"headimgurl"));
		Struts2Utils.getRequest().setAttribute("entity",db);
		//加载库存
		Struts2Utils.getRequest().setAttribute("kcount",baseDao.getMessage(PubConstants.DATA_PRODUCT, yd.getPid()).get("num"));
		double bl= prd.getPrice()/prd.getOldprice();   
		Struts2Utils.getRequest().setAttribute("bl",new java.text.DecimalFormat("#").format(bl*100)); 
	    Struts2Utils.getRequest().setAttribute("custid",custid);
		Struts2Utils.getRequest().setAttribute("slide",wwzService.getslide(custid, "shoppro-"+prd.get_id()));
		if(fromUserid.equals(yd.getFromUserid())){
			Struts2Utils.getRequest().setAttribute("isadmin",true);  
			//加载地址信息
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			whereMap.put("fromUserid",fromUserid);
			whereMap.put("lx", 1);
			DBObject  address=baseDao.getMessage(PubConstants.SHOP_USERADDRESS, whereMap); 
			Struts2Utils.getRequest().setAttribute("address",address); 
			//加载购买状态
			whereMap.clear();
			whereMap.put("formUserid", fromUserid);
			whereMap.put("kjid", id); 
			whereMap.put("state",2);
			whereMap.put("custid",custid);
			Long count=baseDao.getCount(PubConstants.WX_ORDERFORM, whereMap);
			if(count==0){
				Struts2Utils.getRequest().setAttribute("ispay",true);
			}
		}
	
		DBObject  share=new BasicDBObject();
		share.put("fxtitle","砍价("+prd.getPtitle()+")");
		share.put("fximg",wwzService.getWxUsertype(db.get("fromUserid").toString(),"headimgurl"));
		share.put("fxsummary",prd.getSummary());
		share.put("fxurl",url);
		Struts2Utils.getRequest().setAttribute("share", share);
		return "bargaindetail"; 
	}
	/**
	 * 砍价
	 * @throws IllegalAccessException 
	 * @throws IllegalArgumentException 
	 */
	public void  bargain(){ 
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>();  
		String  ydid=Struts2Utils.getParameter("ydid");
		if(StringUtils.isNotEmpty(ydid)){
			DBObject  db=baseDao.getMessage(PubConstants.SHOP_BARGAININGYD,ydid);
			HashMap<String,Object>whereMap=new HashMap<String, Object>();
			whereMap.put("fromUserid", fromUserid);
			whereMap.put("ydid", ydid);
			Long count=baseDao.getCount(PubConstants.SHOP_BARGAININGSTATI,whereMap);
			if(db!=null&count==0){
				Bargainingyd  yd=(Bargainingyd) UniObject.DBObjectToObject(db,Bargainingyd.class);
				ProductInfo  pro=yd.getPro();

				DBObject  bar=baseDao.getMessage(PubConstants.DATA_PRODUCT, Long.parseLong(pro.get_id().toString()));
				if(Integer.parseInt(bar.get("num").toString())>0){
					float iprice=0;
					if(pro.getLowprice()==0){
						float  price=TenpayUtil.buildRandom(1);
						if(pro.getOldprice()/pro.getPcount()<10&&pro.getOldprice()/pro.getPcount()>1){
							price=TenpayUtil.buildRandom(1)*0.1f;
						}else if(pro.getOldprice()/pro.getPcount()<1&&pro.getOldprice()/pro.getPcount()>0.1){
							price=TenpayUtil.buildRandom(1)*0.01f;
						}
						int  fprice=TenpayUtil.buildRandom(1); 
						if(fprice>5){
							iprice=(float)(pro.getOldprice()/pro.getPcount()-price);
						}else{
							iprice=(float)(pro.getOldprice()/pro.getPcount()+price);
						} 
					  	
					}else{
						float  price=TenpayUtil.buildRandom(1);
						if(pro.getOldprice()/pro.getPcount()<10&&pro.getOldprice()/pro.getPcount()>1){
							price=TenpayUtil.buildRandom(1)*0.1f;
						}else if(pro.getOldprice()/pro.getPcount()<1&&pro.getOldprice()/pro.getPcount()>0.1){
							price=TenpayUtil.buildRandom(1)*0.01f;
						}
						int  fprice=TenpayUtil.buildRandom(1); 
						if(fprice>5){
							iprice=(float)((pro.getOldprice()-pro.getLowprice())/pro.getPcount()-price);
						}else{
							iprice=(float)((pro.getOldprice()-pro.getLowprice())/pro.getPcount()+price);
						} 
					} 
					if(iprice>0&&iprice<=pro.getPrice()-pro.getLowprice()&&pro.getPrice()-pro.getLowprice()>0){ 
						pro.setPrice(pro.getPrice()-iprice);
						yd.setPro(pro); 
						baseDao.insert(PubConstants.SHOP_BARGAININGYD, yd);
						//记录用户
						Bargainingstati  obj=new Bargainingstati();
						obj.set_id(mongoSequence.currval(PubConstants.SHOP_BARGAININGSTATI)); 
						obj.setFromUserid(fromUserid);
						obj.setYdid(ydid);
						obj.setKjprice(iprice);
						obj.setCreatedate(new Date());
						baseDao.insert(PubConstants.SHOP_BARGAININGSTATI, obj);
						if(pro.getPrice()==pro.getLowprice()){
							ProductInfo  p=(ProductInfo) UniObject.DBObjectToObject(bar, ProductInfo.class);
							if(p.getNum()-1>=0){
								p.setNum(p.getNum()-1);
							}
							baseDao.insert(PubConstants.DATA_PRODUCT, p);
						}
						
						sub_map.put("value",obj.getKjprice());
						sub_map.put("state",0);
					}else if(iprice>pro.getPrice()-pro.getLowprice()&&pro.getPrice()-pro.getLowprice()>0){ 
						pro.setPrice(Double.parseDouble(pro.getLowprice()+""));
						yd.setPro(pro);
						baseDao.insert(PubConstants.SHOP_BARGAININGYD, yd);
						//记录用户
						Bargainingstati  obj=new Bargainingstati();
						obj.set_id(mongoSequence.currval(PubConstants.SHOP_BARGAININGSTATI)); 
						obj.setFromUserid(fromUserid);
						obj.setYdid(ydid);
						obj.setKjprice(iprice);
						obj.setCreatedate(new Date());
						baseDao.insert(PubConstants.SHOP_BARGAININGSTATI, obj);
						//更新库存
						if(pro.getPrice()==pro.getLowprice()){
							ProductInfo  p=(ProductInfo) UniObject.DBObjectToObject(bar, ProductInfo.class);
							if(p.getNum()-1>=0){
								p.setNum(p.getNum()-1);
								p.setGmnum(p.getGmnum()+1);
							}
							baseDao.insert(PubConstants.DATA_PRODUCT, p);
						}
						sub_map.put("value",pro.getPrice());
						sub_map.put("state",0);
					}else{
						//已经到底
						sub_map.put("state",1);
					}
					 
				}else{
					//库存已完
					sub_map.put("state",2);
				}
			 	
				
			}else{
				//已经砍过
				sub_map.put("state",3);
			}
		} 
		 
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * 砍价预定
	 */
	public void  bargainyd(){ 
		getLscode(); 
		Map<String, Object> sub_map = new HashMap<String, Object>();
		String  id=Struts2Utils.getParameter("id");
		if(StringUtils.isNotEmpty(id)){
			 //检测是否已经预定（单款产品只可预定一次）
			 HashMap<String,Object>whereMap=new HashMap<String, Object>();
			 HashMap<String,Object>sortMap=new HashMap<String, Object>();
			 sortMap.put("createdate", -1);
			 whereMap.put("pid", Long.parseLong(id));
			 whereMap.put("custid",custid);
			 whereMap.put("fromUserid", fromUserid);
			 List<DBObject>list=baseDao.getList(PubConstants.SHOP_BARGAININGYD, whereMap, sortMap);
			 if(list.size()>0){
				 sub_map.put("state", 2);
				 sub_map.put("value", list.get(0).get("_id"));
				 String json = JSONArray.fromObject(sub_map).toString();
				 Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
				 return;	
			 }
			 DBObject  bar=baseDao.getMessage(PubConstants.DATA_PRODUCT, Long.parseLong(id));
			 if(bar!=null&&Integer.parseInt(bar.get("num").toString())>0){
			     ProductInfo  pro=(ProductInfo) UniObject.DBObjectToObject(bar, ProductInfo.class);
			     //pro.set_id(Long.parseLong(id));
				 //pro.setNum(pro.getNum()-1); 
				 //baseDao.insert(PubConstants.DATA_PRODUCT, pro);
			     Bargainingyd db=new Bargainingyd();
				 String  code=DateFormat.getDate()+TenpayUtil.buildRandom(6)+mongoSequence.currval(PubConstants.SHOP_BARGAININGYD);
                 db.set_id(code);
                 db.setPid(Long.parseLong(id));
                 db.setCreatedate(new Date());
                 db.setCustid(custid);
                 db.setFromUserid(fromUserid);
                 db.setPro(pro);
				 baseDao.insert(PubConstants.SHOP_BARGAININGYD, db);
				
				 sub_map.put("state", 0);
				 sub_map.put("value", code);
			 }else{
				 //库存已完
				 sub_map.put("state", 1); 
			 }
			
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 砍价记录
	 */
	public  void   bargaintj(){ 
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		String  ydid=Struts2Utils.getParameter("ydid");
		if(StringUtils.isNotEmpty(ydid)){
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			whereMap.put("ydid", ydid);
			sortMap.put("createdate", -1);
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			List<DBObject>list=baseDao.getList(PubConstants.SHOP_BARGAININGSTATI, whereMap, fypage,10,sortMap);
			if(list.size()>0){
				for (DBObject dbObject : list) {
					dbObject.put("nickname", wwzService.getWxUsertype(dbObject.get("fromUserid").toString(), "nickname"));
					dbObject.put("headimgurl",wwzService.getWxUsertype(dbObject.get("fromUserid").toString(), "headimgurl"));
					
				}
				sub_map.put("state", 0);
				sub_map.put("list",list);
			}
			
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 砍价购买记录
	 */
	public  void   bargaingm(){ 
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		String  id=Struts2Utils.getParameter("id"); 
		String  kjid=Struts2Utils.getParameter("kjid"); 
		if(StringUtils.isNotEmpty(id)){
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>(); 
			whereMap.put("custid",custid);
			if(StringUtils.isNotEmpty(kjid)){
              whereMap.put("kjid",kjid);	
			}
			whereMap.put("recordid",Long.parseLong(id));
			whereMap.put("state",2);
			sortMap.put("insDate", -1);
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			List<DBObject>list=baseDao.getList(PubConstants.WX_ORDERFORM, whereMap,fypage,10, sortMap);
			if(list.size()>0){
				for (DBObject dbObject : list) {
					dbObject.put("nickname", wwzService.getWxUsertype(dbObject.get("fromUserid").toString(), "nickname"));
					dbObject.put("headimgurl",wwzService.getWxUsertype(dbObject.get("fromUserid").toString(), "headimgurl"));
				 
				}
				sub_map.put("state", 0);
				sub_map.put("list", list);
			}
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 团购预定
	 */
	public  void  ajaxbulkyd(){
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		String id=Struts2Utils.getParameter("id");
		if(StringUtils.isNotEmpty(id)){
			DBObject  db=baseDao.getMessage(PubConstants.DATA_PRODUCT, Long.parseLong(id));
			if(db!=null){
				HashMap<String, Object>whereMap=new HashMap<String, Object>();
				whereMap.put("proid",Long.parseLong(id));
				whereMap.put("fromUserid", fromUserid);
				Long  count=baseDao.getCount(PubConstants.SHOP_BULKYD,whereMap);
				if(count>=Long.parseLong(db.get("pcount").toString())){
					sub_map.put("state",2);
					String json = JSONArray.fromObject(sub_map).toString();
					Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);	
					return;
				}
				if(count==0){
					BulkYd  yd=new BulkYd();
					yd.set_id(mongoSequence.currval(PubConstants.SHOP_BULKYD));
					yd.setCreatedate(new Date());
					yd.setCustid(custid);
					yd.setFromUserid(fromUserid);
					yd.setProid(Long.parseLong(id));
					baseDao.insert(PubConstants.SHOP_BULKYD, yd);
					Long  needcount=Long.parseLong(db.get("pcount").toString())-count;
					double bl=Double.parseDouble(count+"")/Double.parseDouble(db.get("pcount").toString());     
					sub_map.put("needcount",needcount);
					sub_map.put("bl",new java.text.DecimalFormat("#").format(bl*100));
					sub_map.put("state", 0);
				}else{
					sub_map.put("state",1);
				} 
				
			}
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 团购预定列表
	 */
    public  void  ajaxbulkydlist(){
    	getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		String id=Struts2Utils.getParameter("id");
		if(StringUtils.isNotEmpty(id)){
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			sortMap.put("createdate", -1);
			whereMap.put("proid", Long.parseLong(id));
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			List<DBObject>list=baseDao.getList(PubConstants.SHOP_BULKYD, whereMap,fypage,10, sortMap);
			if(list.size()>0){
				for (DBObject dbObject : list) {
					if(dbObject.get("fromUserid")!=null){
						dbObject.put("nickname", wwzService.getWxUsertype(dbObject.get("fromUserid").toString(),"nickname"));
						dbObject.put("headimgurl", wwzService.getWxUsertype(dbObject.get("fromUserid").toString(),"headimgurl"));
					}
					if(dbObject.get("insDate")!=null){
						dbObject.put("insDate", RelativeDate.format(DateFormat.getFormat(dbObject.get("insDate").toString()), new Date()));
					}
				}
				sub_map.put("state", 0);
				sub_map.put("list", list); 	
			}
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
    /**
	 * 团购购买列表
	 */
    public  void  ajaxbulkgmlist(){
    	getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		String id=Struts2Utils.getParameter("id");
		if(StringUtils.isNotEmpty(id)){
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			sortMap.put("createdate", -1);
			whereMap.put("recordid", Long.parseLong(id));
			whereMap.put("state",2);
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			List<DBObject>list=baseDao.getList(PubConstants.WX_ORDERFORM, whereMap,fypage,10, sortMap);
			if(list.size()>0){
				for (DBObject dbObject : list) {
					if(dbObject.get("fromUserid")!=null){
						dbObject.put("nickname", wwzService.getWxUsertype(dbObject.get("fromUserid").toString(),"nickname"));
						dbObject.put("headimgurl", wwzService.getWxUsertype(dbObject.get("fromUserid").toString(),"headimgurl"));
					}
					if(dbObject.get("insDate")!=null){
						dbObject.put("insDate", RelativeDate.format(DateFormat.getFormat(dbObject.get("insDate").toString()), new Date()));
					}
				}
				sub_map.put("state", 0);
				sub_map.put("list", list); 	
			}
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 微信退款
	 * @throws Exception
	 */
	public void refund() throws Exception{
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		String orderno=Struts2Utils.getParameter("orderno") ;
		OrderForm entity = (OrderForm) UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.WX_ORDERFORM, orderno),OrderForm.class);
		entity.set_id(orderno);
		String total=BaseDecimal.round(BaseDecimal.multiplication(String.valueOf(entity.getTotal()),"100"),0) ;
		String zfmoney=BaseDecimal.round(BaseDecimal.multiplication(String.valueOf(entity.getZfmoney()),"100"),0) ;
		
		String tkno = "tk"+orderno;
	
		Comunit wxToUser=GetAllFunc.wxTouser.get(toUser);
		WxPayConfig wxconfig=new WxPayConfig();
		if(wxToUser.getQx()==0){
			sub_map.put("state", 1);
			String json = JSONArray.fromObject(sub_map).toString();
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
			return;
		}else if(wxToUser.getQx()==1){
			wxconfig=GetAllFunc.wxPay.get(toUser);
		}else if(wxToUser.getQx()==2){//父类结算
			ComMain commain=GetAllFunc.comToUser.get(toUser);
			if(commain==null){
				sub_map.put("state", 1);
				String json = JSONArray.fromObject(sub_map).toString();
				Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
				return;
			}
			toUser=commain.getToUser();
			wxToUser=GetAllFunc.wxTouser.get(toUser);
			wxconfig=GetAllFunc.wxPay.get(toUser);
		}
		
		if(wxconfig==null||wxconfig.getAppid()==null){
			sub_map.put("state", 1);
			String json = JSONArray.fromObject(sub_map).toString();
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
			return;
		}
		
		String nonce_str=PayCommonUtil.CreateNoncestr();
		SortedMap<Object,Object> parameters = new TreeMap<Object,Object>();
		parameters.put("appid", wxconfig.getAppid());
		parameters.put("mch_id", wxconfig.getPartner());
		parameters.put("nonce_str", nonce_str);
		parameters.put("out_trade_no",orderno);
		parameters.put("out_refund_no",tkno);
		
		parameters.put("total_fee",zfmoney);
		parameters.put("refund_fee",zfmoney);
		
		parameters.put("op_user_id", wxconfig.getAppid());
		
		String sign = PayCommonUtil.createSign("UTF-8", parameters,wxconfig.getPartner_key());
				
		parameters.put("sign", sign);
		String requestXML = PayCommonUtil.getRequestXml(parameters);
		
		Map<String, String> map =WxhbUtil.sendpost(requestXML,wxconfig.getCertLocalPath(),wxconfig.getPartner(),"https://api.mch.weixin.qq.com/secapi/pay/refund");
		if(map==null){
			sub_map.put("state", 1);
		}else if(map.get("result_code").equals("SUCCESS")){
			sub_map.put("state", 0);
			entity.setState(9);
			baseDao.insert(PubConstants.WX_ORDERFORM, entity);
			
			entity.set_id(tkno);
			entity.setTotal(-entity.getTotal());
			entity.setZfmoney(-entity.getZfmoney()); 
			entity.setJfdh(-entity.getJfdh());
			entity.setInsDate(new Date());
			baseDao.insert(PubConstants.WX_ORDERFORM, entity);
			HashMap<String, Object> whereMap =new HashMap<String, Object>();
			whereMap.put("orderid", orderno);
			List<DBObject> buydb=baseDao.getList(PubConstants.WX_ORDERBUY, whereMap, null);
		 
		}
		
	
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 积分兑换
	 */
	public  void  jfpay(){ 
		getLscode(); 
		Map<String, Object> sub_map = new HashMap<String, Object>();
		String remark = Struts2Utils.getParameter("remark");
		//商品类型
		int lx=Integer.parseInt(Struts2Utils.getParameter("lx"));
		 
		Long recordid=0L;
		//商品编号
		if(org.apache.commons.lang.StringUtils.isNotEmpty(Struts2Utils.getParameter("recordid"))){
			recordid=Long.parseLong(Struts2Utils.getParameter("recordid"));//14
		}
		 
		//地址信息
		String name=Struts2Utils.getParameter("name");
		String tel=Struts2Utils.getParameter("tel");
		String address=Struts2Utils.getParameter("address");
		String no=Struts2Utils.getParameter("no");
		//店铺编号
		Long comid=0L;
		if(org.apache.commons.lang.StringUtils.isNotEmpty(Struts2Utils.getParameter("comid"))){
			comid=Long.parseLong(Struts2Utils.getParameter("comid"));//14
		}
		//数量
		int num=Integer.parseInt(Struts2Utils.getParameter("num")); 
		//规格
		String spec=Struts2Utils.getParameter("spec");
		String  kjid=Struts2Utils.getParameter("kjid"); 
		//四位随机数
		String strRandom = TenpayUtil.buildRandom(4) + "";
		//积分返还
		String jffh=Struts2Utils.getParameter("jffh");
		//积分兑换
		String jfdh=Struts2Utils.getParameter("jfdh");
		//10位序列号,可以自行调整。
		String orderno = DateFormat.getDate() + strRandom+mongoSequence.currval("orderno");
		 	OrderForm entity=new OrderForm();
   		    entity.set_id(orderno); 
    		entity.setNo(no);
    		entity.setLx(lx); 
    		entity.setFromUserid(fromUserid); 
    		entity.setCustid(custid);
   		    entity.setName(name);
    		entity.setTel(tel);
    		entity.setAddress(address);
    		entity.setInsDate(new Date());
    		
    		entity.setComid(comid);//14
    		entity.setCount(num);//15 
    		entity.setKjid(kjid);
    		if(StringUtils.isNotEmpty(jfdh)){
    			entity.setJfdh(Float.parseFloat(jfdh));	
    		}  
    		entity.setRecordid(recordid); 
    		
    		entity.setRemark(remark+"-"+spec);
    		if(StringUtils.isNotEmpty(jffh)){
    			entity.setJffh(Float.parseFloat(jffh));
    		}
    		
    		HashMap<String, Object>backMap=new HashMap<String, Object>();
    		backMap.put("context", 0);
    		backMap.put("summary", 0);
    		DBObject pro=baseDao.getMessage(PubConstants.DATA_PRODUCT,recordid,backMap);
    		if(pro!=null){
    			OrderFormpro o=new OrderFormpro();
    			o.set_id(mongoSequence.currval(PubConstants.SHOP_ODERFORMPRO));
    			o.setCount(num);
    			o.setOrderid(orderno);
    			o.setPro(pro);
    			o.setSpec(spec);
    			o.setFromUserid(fromUserid);
    			o.setPid(Long.parseLong(pro.get("_id").toString()));
    			
    			baseDao.insert(PubConstants.SHOP_ODERFORMPRO, o);  
    		} 
    		if(entity.getJfdh()>0){
    			wwzService.deljf(entity.getJfdh()+"", fromUserid, "shop-dh", custid, null);
    		}
    		if(entity.getJffh()>0){
    			wwzService.addjf(entity.getJffh()+"", fromUserid, "shop-fh", custid, null);
    		}
    		entity.setState(2);//14
    		baseDao.insert(PubConstants.WX_ORDERFORM, entity);
    		//更新库存
    		ProductInfo  pr=(ProductInfo) UniObject.DBObjectToObject(pro, ProductInfo.class);
    		if(pr.getNum()-num>0){
    			pr.setNum(pr.getNum()-num);
    			pr.setGmnum(pr.getGmnum()+num);
    		}
    		baseDao.insert(PubConstants.DATA_PRODUCT, pr);
    		sub_map.put("state",0);
    		String json = JSONArray.fromObject(sub_map).toString();
    		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 积分商城验证
	 */
	public  void  checkJfsc(){
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		HashMap<String,Object>whereMap=new HashMap<String, Object>();
		whereMap.put("custid", custid);
		whereMap.put("type",1);
		List<DBObject>list=baseDao.getList(PubConstants.SHOP_SHOPMB, whereMap, null);
		if(list.size()>0){
			sub_map.put("state",0);
			sub_map.put("value",list.get(0).get("_id"));
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 更新状态
	 */
	public  void   gxzt(){
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		String  id=Struts2Utils.getParameter("id");
		DBObject db=baseDao.getMessage(PubConstants.SHOP_BARGAININGYD, Long.parseLong(id));
		if(db!=null){
			Bargainingyd  bargainingyd=(Bargainingyd) UniObject.DBObjectToObject(db, Bargainingyd.class);
			bargainingyd.setState(1);
			baseDao.insert(PubConstants.SHOP_BARGAININGYD, bargainingyd);
			sub_map.put("state",0);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * ajax获取砍价预定列表
	 */
	public  void  ajaxbargainyd(){
		getLscode();
		String id=Struts2Utils.getParameter("id");
		Map<String, Object> sub_map = new HashMap<String, Object>();
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		HashMap<String, Object>backMap=new HashMap<String, Object>();
		whereMap.put("pid", Long.parseLong(id));
		sortMap.put("createdate",-1);
		backMap.put("pro", 0);
		List<DBObject>list=baseDao.getList(PubConstants.SHOP_BARGAININGYD, whereMap, sortMap,backMap);
		if(list.size()>0){
			for (DBObject dbObject : list) {
				if(dbObject.get("fromUserid")!=null){
					DBObject  db=wwzService.getWxUser(dbObject.get("fromUserid").toString());
					dbObject.put("headimgurl",db.get("headimgurl"));
					dbObject.put("nickname",db.get("nickname"));
				}
				if(dbObject.get("createdate")!=null){
					dbObject.put("createdate", RelativeDate.format(DateFormat.getFormat(dbObject.get("createdate").toString()), new Date()));
				}
			}
			sub_map.put("state", 0);
			sub_map.put("list", list);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * 店铺支付列表
	 * @return
	 */
	public  String storepayweb(){
		 getLscode(); 
		 Struts2Utils.getRequest().setAttribute("custid",custid);
		 WxToken token=GetAllFunc.wxtoken.get(custid); 
		 if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 }
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());  
		String  url=SysConfig.getProperty("ip")+"/shop/shop!storepayweb.action?custid="+custid;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		} 
		return "storepayweb";
	}
	/**
	 * ajax获取店铺列表
	 */
	public  void   ajaxshopmb(){
		getLscode(); 
		Map<String, Object> sub_map = new HashMap<String, Object>();
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		HashMap<String, Object>backMap=new HashMap<String, Object>(); 
		whereMap.put("custid",custid);
		String name=Struts2Utils.getParameter("sel");
		if(StringUtils.isNotEmpty(name)){

			Pattern pattern = Pattern.compile("^.*" + name + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("name", pattern);
			Struts2Utils.getRequest().setAttribute("name", name);
		}
		//只加载商家店铺
		whereMap.put("type",2);
		sortMap.put("createdate",-1);
		backMap.put("summary", 0);
		backMap.put("content", 0);
		backMap.put("picurl", 0);
		List<DBObject>list=baseDao.getList(PubConstants.SHOP_SHOPMB, whereMap, sortMap,backMap);
		if(list.size()>0){ 
			sub_map.put("state", 0);
			for (DBObject dbObject : list) {
				 //加载日销售额 
				 double yprice=0;
				 whereMap.clear();
				 whereMap.put("comid",Long.parseLong(dbObject.get("_id").toString()));
				 BasicDBObject dateCondition=new BasicDBObject();	
				 dateCondition.append("$gte",DateUtil.getTimesmorning());
				 dateCondition.append("$lt",DateUtil.getTimesnight()); 
				 whereMap.put("createdate", dateCondition);
				 List<DBObject>paylist=baseDao.getList(PubConstants.SHOP_PAYMENTORDER, whereMap, null);
				 if(paylist.size()>0){
					 for (DBObject pay : paylist) {
						 yprice+=Double.parseDouble(pay.get("price").toString()); 
					}  
				 } 
				 dbObject.put("yprice", yprice);
			}
			sub_map.put("list", list);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	 
	/**
	 * 店铺支付
	 * @return
	 */
	public  String  storepay(){
		 getLscode();
		 String id=Struts2Utils.getParameter("id");
		 WxToken token=GetAllFunc.wxtoken.get(custid); 
		 if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 }
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());  
		String  url=SysConfig.getProperty("ip")+"/shop/shop!storepay.action?custid="+custid+"&id="+id;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}
		Struts2Utils.getRequest().setAttribute("entity",baseDao.getMessage(PubConstants.SHOP_SHOPMB, Long.parseLong(id))); 
		return "storepay"; 
	}
	/**
	 * 微信支付
	 */
	public void  storewxpay()throws Exception{
		SortedMap<Object,Object> params = new TreeMap<Object,Object>();
		getLscode(); 
		DBObject  wx=wwzService.getWxUser(fromUserid);
		if(wx.get("_id").equals("notlogin")){
			params.put("state", 3);
			String json = JSONArray.fromObject(params).toString();
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
			return; 
		} 
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
		//支付的价格
		String price = Struts2Utils.getParameter("price"); 
		//店铺编号
		String comid=Struts2Utils.getParameter("comid");
		String remark=Struts2Utils.getParameter("remark");
		double jffh=0;
		DBObject  mb=baseDao.getMessage(PubConstants.SHOP_SHOPMB, Long.parseLong(comid));
		
		if(mb.get("jfbl")!=null&&Integer.parseInt(mb.get("jfbl").toString())>0){
			jffh=Double.parseDouble(price)*Integer.parseInt(mb.get("jfbl").toString());
		}
		//10位序列号,可以自行调整。
		//四位随机数
		String strRandom = TenpayUtil.buildRandom(4)+"";
		String orderno = DateFormat.getDate()+strRandom+mongoSequence.currval(PubConstants.SHOP_PAYMENTORDER);
		/*MessageInfo  me=new MessageInfo();
    	me.setCustid(custid);
    	me.setFromUserid(fromUserid);
    	me.setTitle("订单提醒");
    	me.setSummary("您有一条来自"+wwzService.getWxUsertype(fromUserid, "nickname")+"的订单");
    	me.setPicurl("");
    	me.setUrl("");
    	me.setLx("shop-pay");
    	me.setType(3);
    	me.setComname(mb.get("name").toString());
    	me.setProcount("");
    	me.setProtitle("");
    	me.setProstate("2");
    	me.setOrderid(orderno);
    	JmsService.permessageMessage(me);*/
		StringBuffer attach=new StringBuffer(orderno);//0
		attach.append("&").append(custid);// 
		attach.append("&").append(fromUserid);
		attach.append("&").append(comid);
		attach.append("&").append(price);
		attach.append("&").append(jffh);
	 
		String nonce_str=PayCommonUtil.CreateNoncestr();
		SortedMap<Object,Object> parameters = new TreeMap<Object,Object>();
		parameters.put("appid", wxconfig.getAppid()); 
		parameters.put("mch_id", wxconfig.getPartner());
		parameters.put("nonce_str", nonce_str);
		parameters.put("attach", attach.toString());
		parameters.put("body", remark); 
		parameters.put("is_subscribe", "Y");
		parameters.put("out_trade_no", orderno);
		parameters.put("total_fee", BaseDecimal.round(BaseDecimal.multiplication(price, "100"),0));
		parameters.put("spbill_create_ip",Struts2Utils.getRequest().getRemoteAddr());
		parameters.put("notify_url", this.getCtxurl()+"/shop/shop!storewxpayok.action");
		parameters.put("trade_type", "JSAPI");
		parameters.put("openid", wwzService.getWxUser(fromUserid).get("fromUser").toString());


		String sign = PayCommonUtil.createSign("UTF-8", parameters,wxconfig.getPartner_key());
		parameters.put("sign", sign);
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
	    params.put("paySign", paySign);
	    if(jffh>0){
	    	 params.put("jffh",jffh);
	    }//paySign的生成规则和Sign的生成规则一致 
	    //paySign的生成规则和Sign的生成规则一致 
	    params.put("state", 0);
	  
	    params.put("orderno", orderno);
		String json = JSONArray.fromObject(params).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * 微信支付回调
	 */
    public void  storewxpayok()throws Exception{
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
        	String fromUserid=attach[2];
        	String comid=attach[3];
        	String price=attach[4];
        	String jffh=attach[5];
        	Paymentorder paymentorder=new Paymentorder();
        	paymentorder.set_id(orderno);
        	paymentorder.setComid(Long.parseLong(comid));
        	paymentorder.setCustid(custid);
        	paymentorder.setFromUserid(fromUserid);
        	paymentorder.setPrice(Double.parseDouble(price));
        	paymentorder.setCreatedate(new Date());
        	paymentorder.setType(1);
        	baseDao.insert(PubConstants.SHOP_PAYMENTORDER, paymentorder); 
        	DBObject mb=baseDao.getMessage(PubConstants.SHOP_SHOPMB,Long.parseLong(comid));
        	if(mb!=null){
        		ShopMb  shopmb=(ShopMb) UniObject.DBObjectToObject(mb, ShopMb.class); 
        		shopmb.setSales(shopmb.getSales()+Double.parseDouble(price));
        		baseDao.insert(PubConstants.SHOP_SHOPMB, shopmb);
        	}
        	//返还
        	if(StringUtils.isNotEmpty(jffh)&&Float.parseFloat(jffh)>0){
            	wwzService.addjf(jffh, fromUserid, "shop-fh", custid, null);
            }
        	MessageInfo  me=new MessageInfo();
        	me.setCustid(custid);
        	me.setFromUserid(fromUserid);
        	me.setTitle("订单提醒");
        	me.setSummary("您有一条来自"+wwzService.getWxUsertype(fromUserid, "nickname")+"的订单");
        	me.setPicurl("");
        	me.setUrl("");
        	me.setLx("shop-pay");
        	me.setType(3);
        	me.setComname(mb.get("name").toString());
        	me.setProcount("");
        	me.setProtitle("");
        	me.setProstate("2");
        	me.setOrderid(orderno);
        	JmsService.permessageMessage(me);
        	Struts2Utils.getResponse().getWriter().write(PayCommonUtil.setXML("SUCCESS", ""));
        	
        }else{
        	Struts2Utils.getResponse().getWriter().write(PayCommonUtil.setXML("SUCCESS", ""));
        }
       
	}
    /**
     * ajax获取支付流水
     */
    public  void   ajaxpayweb(){
    	getLscode();
    	String id=Struts2Utils.getParameter("id");
    	Map<String, Object> sub_map = new HashMap<String, Object>();
    	HashMap<String, Object>whereMap=new  HashMap<>();
    	HashMap<String, Object>sortMap=new  HashMap<>();
    	whereMap.put("custid",custid);
    	if(StringUtils.isNotEmpty(id)){
    		whereMap.put("comid",Long.parseLong(id));
    	}
    	sortMap.put("createdate",-1);
    	if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
    		fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
    	}
    	List<DBObject>list=baseDao.getList(PubConstants.SHOP_PAYMENTORDER, whereMap,fypage,10,sortMap);
    	 
    	if(list.size()>0){
    		sub_map.put("state",0);
    		for (DBObject dbObject : list) {
				if(dbObject.get("comid")!=null){
					dbObject.put("comname",baseDao.getMessage(PubConstants.SHOP_SHOPMB, Long.parseLong(dbObject.get("comid").toString())).get("name"));
				}
				if(dbObject.get("fromUserid")!=null){
					dbObject.put("headimgurl",wwzService.getWxUsertype(dbObject.get("fromUserid").toString(), "headimgurl"));
					dbObject.put("nickname",wwzService.getWxUsertype(dbObject.get("fromUserid").toString(), "nickname"));
				}
				dbObject.put("comname",baseDao.getMessage(PubConstants.SHOP_SHOPMB, Long.parseLong(dbObject.get("comid").toString())).get("name")); 
			}
    		sub_map.put("list",list);
    	}
    	String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    	
    }
    /**
     * ajax获取支付详情
     */
    public  void  ajaxpaydetail(){
    	
    	getLscode();
    	String id=Struts2Utils.getParameter("id");
    	Map<String, Object> sub_map = new HashMap<String, Object>();
    	if(StringUtils.isNotEmpty(id)){ 
    		DBObject db=baseDao.getMessage(PubConstants.SHOP_PAYMENTORDER, id);  
    		if(db!=null){
    			db.put("headimgurl",wwzService.getWxUsertype(db.get("fromUserid").toString(), "headimgurl"));
    			db.put("nickname",wwzService.getWxUsertype(db.get("fromUserid").toString(), "nickname"));
    			db.put("comname",baseDao.getMessage(PubConstants.SHOP_SHOPMB, Long.parseLong(db.get("comid").toString())).get("name"));
    		}
    		if(db!=null&&Integer.parseInt(db.get("type").toString())!=1){
    			 db.put("obj",baseDao.getMessage(PubConstants.WX_ORDERFORM, db.get("_id").toString()));
    		}
    		if(db!=null){
    			sub_map.put("state", 0);
        		sub_map.put("value",db);
    		}
    		
    		
    	}
    	String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    }
    /**
     * 申请代理
     */
    public  void  applyagent(){
    	getLscode();
    	Map<String, Object> sub_map = new HashMap<String, Object>();
    	String id=Struts2Utils.getParameter("id");
    	String name=Struts2Utils.getParameter("name");
    	String tel=Struts2Utils.getParameter("tel");
    	if(StringUtils.isNotEmpty(id)){
    		ShopAgent agent=new ShopAgent();
    		agent.set_id(id+"-"+wwzService.getVipNo(fromUserid));
    		agent.setCreatedate(new Date());
    		agent.setCustid(custid);
    		agent.setWid(Long.parseLong(id));
    		agent.setFromUserid(fromUserid);
    		agent.setName(name);
    		agent.setTel(tel);
    		agent.setState(1);
    		agent.setNickname(wwzService.getWxUsertype(fromUserid, "nickname"));
    		agent.setHeadimgurl(wwzService.getWxUsertype(fromUserid, "headimgurl"));
    		agent.setNo(wwzService.getWxUsertype(fromUserid, "no"));
    		baseDao.insert(PubConstants.SHOP_SHOPAGENT, agent);
    		sub_map.put("state",0);
    		sub_map.put("value",id+"-"+wwzService.getVipNo(fromUserid));
    	}
    	String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
    	
    }
    /**
     * 申请代理
     */
    public  String  agent(){
    	getLscode();
    	Struts2Utils.getRequest().setAttribute("custid",custid);
    	String id=Struts2Utils.getParameter("id");
    	String pid=Struts2Utils.getParameter("pid");
    	Struts2Utils.getRequest().setAttribute("id",id); 
    	Struts2Utils.getRequest().setAttribute("pid",pid); 
		return "agent";
    	
    }  
    /**
     * 佣金统计列表
     * @return
     */
   public String agentweb(){
	  getLscode(); 
	  DBObject  db=wwzService.getAgentPrice(custid, fromUserid);
	  Struts2Utils.getRequest().setAttribute("entity",db);
	  Struts2Utils.getRequest().setAttribute("state", 1);
	return "agentweb";    
   }
   /**
    * ajax获取佣金统计详情
    */
   public  void  ajaxagent(){
	   getLscode();
	   Map<String, Object> sub_map = new HashMap<String, Object>(); 
	   HashMap<String, Object>whereMap=new HashMap<>();
	   HashMap<String, Object>sortMap=new HashMap<>(); 
	   sortMap.put("createdate", -1);
	   String state=Struts2Utils.getParameter("state"); 
	   if(StringUtils.isNotEmpty(state)){
		   whereMap.put("type",Integer.parseInt(state));
	   }
	   whereMap.put("fromUserid", fromUserid);
	   if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
		   fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
	   }
	   List<DBObject>list=baseDao.getList(PubConstants.SHOP_AGENTDETAIL, whereMap,fypage,20, sortMap);
	   
	   if(list.size()>0){
		   sub_map.put("state", 0);
		   //加载订单信息
		   if(state.equals("1")){
			   for (DBObject dbObject : list) {
					DBObject  order=baseDao.getMessage(PubConstants.WX_ORDERFORM,dbObject.get("oid").toString());
					if(order!=null){
						if(order.get("kdcom")!=null){
							order.put("kdcom", wwzService.getKdName(dbObject.get("kdcom").toString()));
						}
						order.put("nickname",wwzService.getWxUsertype(order.get("fromUserid").toString(), "nickname"));
						order.put("headimgurl",wwzService.getWxUsertype(order.get("fromUserid").toString(), "headimgurl"));  
					}
					dbObject.put("obj",order);
					
				}
		   }  
		   sub_map.put("list", list);
	   }
	   String json = JSONArray.fromObject(sub_map).toString();
	   Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	   
   }
   /**
    * 代理提现
    * @return
    */
   public String  agenttx(){
	   getLscode(); 
	   DBObject  db=wwzService.getAgentPrice(custid, fromUserid);
	   db.put("headimgurl", wwzService.getWxUsertype(fromUserid, "headimgurl"));
	   db.put("nickname", wwzService.getWxUsertype(fromUserid, "nickname"));
	   Struts2Utils.getRequest().setAttribute("entity",db); 
	return "agenttx";    
   }
   /**
    * 代理提现记录
    * @return
    */
   public String  agenttxweb(){
	   getLscode();
	   Struts2Utils.getRequest().setAttribute("state", 2);
	return "agenttxweb";    
   }
   /**
    * 微信提现
    */
   public  void  wxtx() throws Exception{
	    SortedMap<Object,Object> params = new TreeMap<Object,Object>();
		getLscode(); 
		DBObject  wx=wwzService.getWxUser(fromUserid);
		if(wx.get("_id").equals("notlogin")){
			params.put("state", 3);
			String json = JSONArray.fromObject(params).toString();
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
			return; 
		} 
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
		//支付的价格
		String price = Struts2Utils.getParameter("price"); 
		if(wwzService.getAgent(custid,fromUserid)<Double.parseDouble(price)){
			//账号余额不足
			params.put("state",2);
			String json = JSONArray.fromObject(params).toString();
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
			return;
		}
		if(Double.parseDouble(price)>200||Double.parseDouble(price)<1){
			//输入金额有误（支持1-200）
			params.put("state",4);
			String json = JSONArray.fromObject(params).toString();
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
			return;
		} 
		//备注
		String remark=Struts2Utils.getParameter("remark");
		//活动名称
		String act_name=Struts2Utils.getParameter("act_name");
		//红包祝福语
		String wishing=Struts2Utils.getParameter("wishing");  
	     
		//10位序列号,可以自行调整。
		//四位随机数
		String strRandom = TenpayUtil.buildRandom(4)+"";
		String orderno = DateFormat.getDate()+strRandom+mongoSequence.currval(PubConstants.SHOP_AGENTDETAIL);
	  
		String nonce_str=PayCommonUtil.CreateNoncestr();
		SortedMap<Object,Object> parameters = new TreeMap<Object,Object>();
		parameters.put("nonce_str", nonce_str);
		parameters.put("mch_billno",orderno); 
		parameters.put("mch_id", wxconfig.getPartner());
		parameters.put("wxappid",wxconfig.getAppid());  
		parameters.put("remark", remark); 
		parameters.put("send_name", wxconfig.getName());//商户名称
		parameters.put("re_openid", wwzService.getWxUsertype(fromUserid,"fromUser"));
		parameters.put("total_amount", BaseDecimal.round(BaseDecimal.multiplication(price, "100"),0));
		parameters.put("total_num", "1");
		parameters.put("wishing",wishing);
		parameters.put("client_ip", Struts2Utils.getRequest().getRemoteAddr());
		parameters.put("act_name",act_name); 
	 


		String sign = PayCommonUtil.createSign("UTF-8", parameters,wxconfig.getPartner_key());
		parameters.put("sign", sign);
		String requestXML = PayCommonUtil.getRequestXml(parameters);
		
		String result =CommonUtil.httpsRequestSSL("https://api.mch.weixin.qq.com/mmpaymkttransfers/sendredpack","POST", requestXML,wxconfig.getPartner(),"D:/certs/"+wxconfig.getPartner()+"_"+wxconfig.getPartner()+"/apiclient_cert.p12");
		
		Map<String, String> map = XMLUtil.doXMLParse(result);
        if(map.get("return_msg").equals("发放成功")&&map.get("err_code_des").equals("发放成功")){
        	//更新账号
        	wwzService.delAgent(agid, Double.parseDouble(price),orderno,fromUserid,custid);
        	 
        }
	    params.put("state", 0); 
	    params.put("value",price);
		String json = JSONArray.fromObject(params).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
   }
   /**
    * 加载限购信息
    */
   public void  ajaxrestriction(){
	   getLscode();
	   Map<String, Object> sub_map = new HashMap<String, Object>(); 
	   String id=Struts2Utils.getParameter("id");
	   if(StringUtils.isNotEmpty(id)){
		   DBObject  db=baseDao.getMessage(PubConstants.DATA_PRODUCT,Long.parseLong(id));
		   //加载限购信息 
		   HashMap<String, Object>whereMap=new HashMap<>();
	 		if(db.get("gmcs")!=null&&Integer.parseInt(db.get("gmcs").toString())>0){ 
	 			whereMap.clear();
	 			whereMap.put("pid", Long.parseLong(id));
	 			whereMap.put("fromUserid", fromUserid); 
	 			int ll=0;
	 			//预订库检测
	 			List<DBObject> list=baseDao.getList(PubConstants.SHOP_ODERFORMPRO,whereMap,null); 
	 			for (DBObject dbObject : list) {
	 				 DBObject  order=baseDao.getMessage(PubConstants.WX_ORDERFORM, dbObject.get("orderid").toString());
	 				 if(order!=null&&Integer.parseInt(order.get("state").toString())!=1){
	 					 ll+=Integer.parseInt(order.get("count").toString());
	 				 }
	 			}
	 			//购物车检测
	 			whereMap.clear();
	 			whereMap.put("pid", Long.parseLong(id));
	 			whereMap.put("fromUserid", fromUserid);
	 			
	 			List<DBObject>listgwc=baseDao.getList(PubConstants.SUC_SHOPPINGCART, whereMap,null);
	 			for (DBObject dbObject : listgwc) {
	 				ll+=Integer.parseInt(dbObject.get("count").toString());
	 			} 
	 			if(ll>=Integer.parseInt(db.get("gmcs").toString())){ 
	 				sub_map.put("value",0);
	 			}else{  
	 				sub_map.put("value", Integer.parseInt(db.get("gmcs").toString())-ll);
	 			}
	 		}
	 		sub_map.put("state",0);
	 		//加载规格
	 		whereMap.clear();
			whereMap.put("parentid",Long.parseLong(id));
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			sortMap.put("sort",-1);
			List<DBObject>spelist=baseDao.getList(PubConstants.SHOP_SPECIFICATION, whereMap, sortMap);
			sub_map.put("list", spelist); 
			
	   }
	   String json = JSONArray.fromObject(sub_map).toString();
	   Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	
   }
   /**
    * 代理的店铺列表
    * @return
    */
   public  String   agentshop(){
	  getLscode();
	return "agentshop";    
   }
   /**
    * ajax获取代理店铺
    */
   public  void   ajaxagentshop(){
	   getLscode();
	   Map<String, Object> sub_map = new HashMap<String, Object>(); 
	   HashMap<String,Object>whereMap=new HashMap<>();
	   HashMap<String,Object>sortMap=new HashMap<>();
	   whereMap.put("fromUserid",fromUserid);
	   sortMap.put("createdate", -1);
	   if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
		   fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
	   }
	   List<DBObject>list=baseDao.getList(PubConstants.SHOP_SHOPAGENT, whereMap,fypage,10,sortMap); 
	   if(list.size()>0){
		   sub_map.put("state",0);
		   for (DBObject dbObject : list) {
			   DBObject  db=baseDao.getMessage(PubConstants.SHOP_SHOPMB,Long.parseLong(dbObject.get("wid").toString()));
			   dbObject.put("picurl", db.get("logo"));
			   dbObject.put("name", db.get("name"));
			   dbObject.put("summary", db.get("summary"));
		  }
		   sub_map.put("list",list);
	   }
	   String json = JSONArray.fromObject(sub_map).toString();
	   Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
   }
   /**
    * 
    */
   public void  check(){
	   HashMap<String, Object>whereMap=new HashMap<>();
	   List<DBObject>list=baseDao.getList("user",whereMap,null);
	   for (DBObject dbObject : list) {
		UserInfo  user=(UserInfo) UniObject.DBObjectToObject(dbObject, UserInfo.class);
		baseDao.insert("user_info", user);
	 }
   }
     
}