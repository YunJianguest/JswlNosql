package com.lsp.suc.web;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.ArrayList;
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
import com.lsp.pub.util.PayCommonUtil;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.TenpayUtil;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.util.XMLUtil;
import com.lsp.pub.web.GeneralAction;
import com.lsp.shop.entiy.OrderForm;
import com.lsp.suc.entity.IntegralInfo;
import com.lsp.suc.entity.IntegralRecord;
import com.lsp.suc.entity.Tourism;
import com.lsp.suc.entity.Comunit;
import com.lsp.website.entity.CommentInfo;
import com.lsp.website.service.WebsiteService;
import com.lsp.website.service.WwzService;
import com.lsp.weixin.entity.WxPayConfig;
import com.lsp.weixin.entity.WxUser;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;

/**
 * 积分管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name ="reload", location = "integral.action", type = "redirect") })
public class IntegralAction  extends GeneralAction<IntegralInfo>{

	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private MongoSequence mongoSequence;
	@Autowired
	private WwzService  wwzService;
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}
	@Autowired
	private WebsiteService webService;
	
	private IntegralInfo entity=new IntegralInfo();
	private Long _id;


	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		HashMap<String, Object> backMap =new HashMap<String, Object>();
		
		toUser=SpringSecurityUtils.getCurrentUser().getToUser();
		sortMap.put("sort", -1); 
		whereMap.put("toUser", toUser);
		String title=Struts2Utils.getParameter("title");
		if(StringUtils.isNotEmpty(title)){
			Pattern pattern = Pattern.compile("^.*" + title + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("fromUser", pattern);
			Struts2Utils.getRequest().setAttribute("title",  title);
		}
	 
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		
		List<DBObject> list=baseDao.getList(PubConstants.INTEGRAL_INFO,whereMap,fypage,10,sortMap,backMap);
		fycount=baseDao.getCount(PubConstants.INTEGRAL_INFO);
		Struts2Utils.getRequest().setAttribute("integralList", list);
		Struts2Utils.getRequest().setAttribute("toUser", toUser);
		
		return SUCCESS;
	}


	@Override
	public IntegralInfo getModel() {
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


	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
	 
		return RELOAD;
	}
	
	 
	public void ajaxsave() throws Exception {
		// TODO Auto-generated method stub
		custid=SpringSecurityUtils.getCurrentUser().getId();
		fromUserid=getFromUserid(); 
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		try {
			DBObject  user=wwzService.getWxUser(fromUserid);
			if(user.get("_id").equals("notlogin")){
				//未登录
				sub_map.put("state",3);
			}else{  
				String price=Struts2Utils.getParameter("price");
				wwzService.addjf(price, fromUserid, "gylcz", custid, user);
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


	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub 
		return RELOAD;
	}


	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		try {
			if(_id!=null){
				DBObject db=baseDao.getMessage(PubConstants.INTEGRAL_INFO, _id);
				entity= (IntegralInfo) UniObject.DBObjectToObject(db, IntegralInfo.class);
			}else{
				entity=new IntegralInfo();
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
	 * 积分详情
	 * @return
	 */
    public String web(){
    	getLscode();
    	HashMap<String, Object>whereMap=new HashMap<String, Object>();
    	whereMap.put("_id", fromUserid);
    	DBObject  wxuser= wwzService.getWxUser(whereMap); 
    	Struts2Utils.getRequest().setAttribute("custid", custid);
    	wxuser.put("jf",wwzService.getJf(custid, fromUserid));
    	Struts2Utils.getRequest().setAttribute("entity", wxuser); 
    	 
		return "web"; 
    }
	/**
	 * 获取个人积分详情列表
	 * @return
	 * @throws Exception 
	 */
	public void ajaxweb() throws Exception {
		getLscode(); 
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		sortMap.put("createdate", -1);
		whereMap.put("fromUserid", fromUserid); 
		whereMap.put("custid", custid); 
		if(Struts2Utils.getParameter("fypage")!=null){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		
		List<DBObject> comList=baseDao.getList(PubConstants.INTEGRAL_INFO, whereMap,fypage,13, sortMap);
		 
		if(comList.size()>0){
			sub_map.put("state", 0);
		}else{
			sub_map.put("state", 1);
		}
		
		sub_map.put("list", comList);
		String json = JSONArray.fromObject(sub_map).toString();
		 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * 充值
	 * @return
	 */
	public  String    blacklist(){
		 getLscode();
		 WxToken token=GetAllFunc.wxtoken.get(custid);
		 if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 }
		 Struts2Utils.getRequest().setAttribute("token",token);
		 token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		 Struts2Utils.getRequest().setAttribute("custid",custid); 
		return "blacklist"; 	
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
		
		int lx=Integer.parseInt(Struts2Utils.getParameter("lx"));//0 商品 1选号 2扫码付3优惠劵4砍价
		//总金钱
		float total=Float.parseFloat(Struts2Utils.getParameter("total"));
		 
		Long recordid=0L;
		if(org.apache.commons.lang.StringUtils.isNotEmpty(Struts2Utils.getParameter("recordid"))){
			recordid=Long.parseLong(Struts2Utils.getParameter("recordid"));//14
		}
		float remoney=0;
		if(org.apache.commons.lang.StringUtils.isNotEmpty(Struts2Utils.getParameter("remoney"))){
			remoney=Float.parseFloat(Struts2Utils.getParameter("remoney"));//14
		}
		int num=Integer.parseInt(Struts2Utils.getParameter("num"));
		Long proid=0L;
		if(org.apache.commons.lang.StringUtils.isNotEmpty(Struts2Utils.getParameter("proid"))){
			proid=Long.parseLong(Struts2Utils.getParameter("proid"));//14
		}
		Long comid=0L;
		if(org.apache.commons.lang.StringUtils.isNotEmpty(Struts2Utils.getParameter("comid"))){
			comid=Long.parseLong(Struts2Utils.getParameter("comid"));//14
		}

		String no=Struts2Utils.getParameter("no");
        String name=Struts2Utils.getParameter("name");
        String address=Struts2Utils.getParameter("address");
        String tel=Struts2Utils.getParameter("tel");
        
		//四位随机数
		String strRandom = TenpayUtil.buildRandom(4) + "";
		
		//10位序列号,可以自行调整。
		String orderno = DateFormat.getDate() + strRandom+mongoSequence.currval(PubConstants.SUC_ORDERNO);
		int zs=0;
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("zs"))){
					zs=Integer.parseInt(Struts2Utils.getParameter("zs"));
		}
		/**
		 * 生成支付订单
		 */
		OrderForm entity=new OrderForm();
		entity.set_id(orderno);
		entity.setState(1);//1为生成订单状态
		entity.setNo(orderno);
		entity.setLx(lx);
		
		entity.setFromUserid(fromUserid);
		entity.setToUser(comtoUser);
		if(zs==0){
			//保存订单地址
			entity.setName(name);
    		entity.setTel(tel);
    		entity.setAddress(address);
		} 
		if(wx!=null){
			//保存微信用户地址
			if(wx.get("province")!=null){
				entity.setProvince(wx.get("province").toString());
			}
			if(wx.get("city")!=null){
				entity.setCity(wx.get("city").toString());
			}
			if(wx.get("ly")!=null){
				entity.setLy(Integer.parseInt(wx.get("ly").toString()));
			}
		}
		entity.setInsDate(new Date());
		
		entity.setComid(comid);//14
		entity.setCount(num);//15
		entity.setTotal(total);//6
		
		
		entity.setZfmoney(Float.parseFloat(price));//7 
		entity.setRecordid(recordid);
		entity.setRemoney(remoney); 
		entity.setRemark(remark);
		baseDao.insert(PubConstants.WX_ORDERFORM, entity);
		StringBuffer attach=new StringBuffer(orderno);//传递订单编号 
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
		parameters.put("notify_url", this.getCtxurl()+"/suc/integral!payok.action");//通知地址 
		parameters.put("trade_type", "JSAPI");//支付类型 
		parameters.put("openid", wwzService.getWxUser(fromUserid).get("fromUser").toString());//用户ID
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
	 * 结算
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
        	DBObject orderdb=baseDao.getMessage(PubConstants.WX_ORDERFORM, orderno);
        	OrderForm entity = (OrderForm)UniObject.DBObjectToObject(orderdb,OrderForm.class);
            //支付成功
        	entity.set_id(orderno);
        	entity.setState(2);//2为已经支付成功
        	baseDao.insert(PubConstants.WX_ORDERFORM, entity);
        	DBObject  obj=wwzService.getWxUser(entity.getFromUserid());
        	if(obj.get("_id").equals("notlogin")){
        		
        	}else{ 
        		//结算 
        		 float  mo=entity.getZfmoney()*100; 
        		 wwzService.addjf(mo+"",wwzService.getfromUserid(fromUser,custid),"jfcz", custid, null);
        		
        	}
        	
        	Struts2Utils.getResponse().getWriter().write(PayCommonUtil.setXML("SUCCESS", ""));
        	
        }else{
        	Struts2Utils.getResponse().getWriter().write(PayCommonUtil.setXML("SUCCESS", ""));
        }
       
        
       

	}
	 
	public void delAllerr(){
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		whereMap.put("value",0);
		baseDao.delete(PubConstants.INTEGRAL_INFO, whereMap); 
	}
	/**
	 * 更新积分
	 */
	public void updIntegral(){
		Map<String, Object>submap=new HashMap<String, Object>();
		String  custid=SpringSecurityUtils.getCurrentUser().getId();
		String  fromUserid=Struts2Utils.getParameter("fromUserid");
		if(StringUtils.isNotEmpty(fromUserid)){
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			whereMap.put("fromUserid", fromUserid);
			whereMap.put("custid", custid);
			List<DBObject>list=baseDao.getList(PubConstants.INTEGRAL_INFO, whereMap, null);
			if(list.size()>0){
				float  value=0;
				for (DBObject dbObject : list) {
					if(dbObject.get("value")!=null){
						float  o=Float.parseFloat(dbObject.get("value").toString());
						if(dbObject.get("state").toString().equals("0")){ 
							value=value+o;
						}else if(dbObject.get("state").toString().equals("1")){ 
							value=value-o;
						}
					}
					 
				} 
			   if(value>0){
				   wwzService.changeJf(custid, fromUserid, value,2);
				   submap.put("state", 0);
			   }else{ 
			   }
			}
		}
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 清空用户积分
	 */
	public void  delIntegral(){
		Map<String, Object>submap=new HashMap<String, Object>();
		String  custid=SpringSecurityUtils.getCurrentUser().getId();
		String  fromUserid=Struts2Utils.getParameter("fromUserid");
		if(StringUtils.isNotEmpty(fromUserid)){
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			whereMap.put("fromUserid", fromUserid);
			whereMap.put("custid", custid);
			baseDao.delete(PubConstants.INTEGRAL_INFO, whereMap);
			submap.put("state", 0);
		}
		String json = JSONArray.fromObject(submap).toString(); 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
 
	
}
