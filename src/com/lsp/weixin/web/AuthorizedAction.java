package com.lsp.weixin.web;

import java.io.BufferedReader;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;
import java.util.regex.Pattern;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSONObject;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.entity.WxToken;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.JmsService;
import com.lsp.pub.util.ParseXml;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.web.TotalAction;
import com.lsp.shop.entiy.ComMain;
import com.lsp.suc.entity.WhdCount;
import com.lsp.suc.entity.Comunit; 
import com.lsp.user.entity.WxLoc;
import com.lsp.website.service.WwzService;
import com.lsp.weixin.entity.WeixinRequest;
import com.lsp.weixin.entity.WxMessage;
import com.lsp.weixin.entity.WxUser;
import com.lsp.weixin.util.JuheUtil;
import com.mongodb.DBObject;
/**
 * 公共号授权管理
 * @author Ccjh
 *
 */
@Namespace("/weixin")
@Results({ @Result(name ="reload", location = "authorized.action", type = "redirect") })
public class AuthorizedAction extends TotalAction{
	private static final long serialVersionUID = -7868703949557549292L;
	private Log log = LogFactory.getLog(getClass());
	@Autowired
	private BaseDao baseDao;
	@Autowired
	private WwzService wwzService; 
	
	
	public String accept(){
	   
		try {
			BufferedReader reader = new BufferedReader(Struts2Utils
					.getRequest().getReader());
			String line = null;
			StringBuffer buffer = new StringBuffer();

			while ((line = reader.readLine()) != null) {
				buffer.append(line);
			}
			String xml = buffer.toString();
			
			if(xml.length()==0){
				//验证 开始
				String signature = Struts2Utils.getParameter("signature");
				String timestamp = Struts2Utils.getParameter("timestamp");
				String nonce = Struts2Utils.getParameter("nonce");
				String echostr = Struts2Utils.getParameter("echostr");

				Struts2Utils.getSession().setAttribute("echostr", echostr);
				if(StringUtils.isNotEmpty(echostr)){
					Struts2Utils.getResponse().getWriter().write(echostr);
				}
				
				//验证 结束
				return null;
			}
			String resultXml=""; 
			Date dt = new Date();
			WeixinRequest weixin=ParseXml.getElements(xml);
			System.out.println(xml);
			String toUser=weixin.getToUser();
			String key=weixin.getContent();
			if(key!=null){
				key=key.replace(")", "");
			}
			
			DBObject db=null;
			String fromUser=weixin.getFromUser(); 
			custid=wwzService.getCustid(toUser);
			DBObject wxuser=wwzService.getWxUser(fromUser);
			if(!wxuser.get("_id").toString().equals("notlogin")){
				
				//JmsService.zdyMessage(weixin.getToUser(), weixin.getFromUser(), "getuser");//更新用户
			}
			HashMap<String, Object> whereMap = new HashMap<String, Object>();
			HashMap<String, Object> sortMap =new HashMap<String, Object>();
			ComMain commain=GetAllFunc.comToUser.get(toUser);
			boolean b=true;
			if(wxuser==null||wxuser.get("comUser")==null||StringUtils.isEmpty(wxuser.get("comUser").toString())){
				b=true;
			}else{
				b=false;
				fromUser=wxuser.get("comUser").toString();
			}
			
			DBObject comUserDb=baseDao.getMessage(PubConstants.DATA_WXUSER,fromUser);
			
			if(weixin.getMsgType().equals("text")){
				key=weixin.getContent();
				if(key!=null){
					key=key.replace(")", "");
				}
				
				
			}else if(weixin.getMsgType().equals("event")){
				if(weixin.getEvent().equals("subscribe")){  
					if(StringUtils.isEmpty(weixin.getFromUser())){
						Struts2Utils.getResponse().getWriter().write("");
						return null;
					} 
					
					if(wxuser.get("_id").toString().equals("notlogin")){
						WxUser user= new WxUser();
						user.set_id(UUID.randomUUID().toString()); 
						user.setLx(0);
						user.setCustid(user.getCustid()+","+"custid"); 
						user.setFromUser(weixin.getFromUser());
						user.setCreatedate(new Date());
						user.setToUser(weixin.getToUser());
						if(StringUtils.isEmpty(weixin.getEventKey())||weixin.getEventKey().length()<9){
							
						}else{
							String[] k=weixin.getEventKey().split("_");
							if(k.length==2){
								user.setLy(Integer.parseInt(k[1]));
								user.setLx(1);
							}
						}
						if(custid!=null){
							baseDao.insert(PubConstants.DATA_WXUSER, user);
						}
					} 
					//验证积分
					HashMap<String, Object>whereMapsub=new HashMap<>();
					whereMapsub.put("type", "subscribe-wx");
					whereMapsub.put("custid",custid);
					whereMapsub.put("fromUserid", wwzService.getfromUserid(weixin.getFromUser(), custid));
					Long  countsub=baseDao.getCount(PubConstants.INTEGRAL_INFO, whereMapsub); 
					if(countsub==0){
						//验证任务 
					    Long ref=wwzService.checkTask("subscribe-wx", wwzService.getfromUserid(weixin.getFromUser(), custid),custid);
					    
						if(ref!=-1L){
							wwzService.completeTask(ref,custid,wwzService.getfromUserid(weixin.getFromUser(), custid),"subscribe-wx");  
						}
					}
					
					//JmsService.zdyMessage(weixin.getToUser(), fromUser, "subscribe");//推送消息
					
					whereMap.clear();
					sortMap.clear();
					whereMap.put("toUser", toUser);
					whereMap.put("type", "subscribe");
					sortMap.put("sort", 1);
					List<DBObject> list=baseDao.getList(PubConstants.DATA_SUBSCRIBE,whereMap,0,10,sortMap); 	
				
					int size=list.size();
					if(size>0){
						if(list.get(0).get("url").toString().equals("text")){
							resultXml=WeiXinUtil.getTextXml(weixin, list.get(0).get("context").toString());		
						}else{
							resultXml=WeiXinUtil.getSubscribeXml(weixin, list,commain,b);	
							
					
						}
					}
				}else if(weixin.getEvent().equals("unsubscribe")){
					
					Struts2Utils.getResponse().getWriter().write("");
					return null;
				} else if(weixin.getEvent().equals("CLICK")){
					key=weixin.getEventKey();					
				}else if(weixin.getEvent().equals("LOCATION")){
					
					WxLoc wxloc=new WxLoc();
					
					List<Double> loc=new ArrayList<Double>();
					loc.add(weixin.getLocation_Y());
					loc.add(weixin.getLocation_X());
					wxloc.set_id(fromUser);
					wxloc.setToUser(weixin.getToUser());
					wxloc.setFromUser(fromUser);
					wxloc.setLoc(loc);
					wxloc.setCreatedate(new Date().getTime());
					baseDao.insert(PubConstants.WX_LOC, wxloc);
					//wxloc.set_id(mongoSequence.currval(PubConstants.WX_LOC));
					//baseDao.insert(PubConstants.WX_LOCHIS, wxloc);
					Struts2Utils.getResponse().getWriter().write("");
					return null;
				}
				
			}else if(weixin.getMsgType().equals("location")){
				
				WxLoc wxloc=new WxLoc();
				
				List<Double> loc=new ArrayList<Double>();
				loc.add(weixin.getLocation_Y());
				loc.add(weixin.getLocation_X());
				wxloc.set_id(fromUser);
				wxloc.setToUser(weixin.getToUser());
				wxloc.setFromUser(fromUser);
				wxloc.setLoc(loc);
				wxloc.setCreatedate(new Date().getTime());
				baseDao.insert(PubConstants.WX_LOC, wxloc);
				//wxloc.set_id(mongoSequence.currval(PubConstants.WX_LOC));
				//baseDao.insert(PubConstants.WX_LOCHIS, wxloc);
				Struts2Utils.getResponse().getWriter().write("");
				return null;
			}
			if(resultXml.length()==0){
				whereMap.clear();
				Pattern pattern = Pattern.compile("^.*" + key + ".*$",
					Pattern.CASE_INSENSITIVE);

				whereMap.put("key", pattern);
				whereMap.put("toUser", weixin.getToUser());
				
				db=baseDao.getMessage(PubConstants.DATA_WXMESSAGE, whereMap);	
				
			}

			if(resultXml.length()==0&&db!=null){
				
				WxMessage  message = (WxMessage)UniObject.DBObjectToObject(db,WxMessage.class);
				if(message.getMsgType().equals("wxnewscommon")){
					
					whereMap.clear();
					whereMap.put("type", message.getContent());
					sortMap.clear();
					
					sortMap.put("sort", -1);
					whereMap.put("toUser", weixin.getToUser());
					List<DBObject> list=baseDao.getList(PubConstants.DATA_WXNEWS,whereMap,0,9,sortMap); 	
					resultXml=WeiXinUtil.getNewsXml(weixin, list,commain,b);
				}else if(message.getMsgType().equals("zidingyi")){//自定义回复
					
					whereMap.clear();			
					
					sortMap.clear();
					
					sortMap.put("sort", 1);
					whereMap.put("toUser", weixin.getToUser());
					whereMap.put("wid",message.get_id().toString());
					List<DBObject> list=baseDao.getList(PubConstants.PUB_ZDYMESSAGE,whereMap,0,10,sortMap);  
					resultXml=WeiXinUtil.getZdyMessageXml(weixin, list,commain,b);
					
				}else if(message.getMsgType().equals("huifu")){//回复文本
					resultXml=WeiXinUtil.getTextXml(weixin, message.getContent());			
					
				}else if(message.getMsgType().equals("company")){
					
					HashMap<String, Object> newsMap = new HashMap<String, Object>();
					
					sortMap.clear();
					
					sortMap.put("sort", 1);
					newsMap.put("toUser", weixin.getToUser());
					List<DBObject> list=baseDao.getList(PubConstants.WX_COMPANY,newsMap,0,10,sortMap); 	
			
					resultXml=WeiXinUtil.getCompanyXml(weixin, list,commain,b);;	
				
				}else if(message.getMsgType().equals("wxsign")){
					 	
					
				}
				
			}
			if(resultXml.length()==0){
				//默认查找系统资源
				whereMap.clear();
				
				
				HashMap<String, Object> backMap =new HashMap<String, Object>();
				Pattern pattern = Pattern.compile("^.*" + key + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("keyword", pattern);
				whereMap.put("toUser", weixin.getToUser());
				sortMap.clear();
				sortMap.put("sort", -1);
				
			
				backMap.put("_id", 1);
				backMap.put("name", 1);
				backMap.put("logo", 1);
				backMap.put("toUserid", 1);
				List<DBObject> comList = baseDao.getList(PubConstants.WX_COMPANY,whereMap, 0, 9, sortMap, backMap);
				int size=comList.size(); 
				if(size>0){ 
					whereMap.clear();
					whereMap.put("toUser", weixin.getToUser());
					whereMap.put("type", "welcome");
					sortMap.put("sort", 1);
					
					DBObject weldb=baseDao.getMessage(PubConstants.DATA_SUBSCRIBE,whereMap,sortMap);  
					resultXml=WeiXinUtil.getSSCompanyXml(weixin, comList, commain, b, weldb);
				}
			}
			
			if(resultXml.length()==0){
				//没有找到资源的的默认回复 
				WxToken wxtoken=GetAllFunc.wxtoken.get(wwzService.getCustid(toUser));
				if(wxtoken.getKf()==0){//客服关闭
					HashMap<String, Object> subMap = new HashMap<String, Object>();
					sortMap.clear();
					subMap.put("toUser", weixin.getToUser());
					subMap.put("type", "welcome");
					sortMap.put("sort", 1); 
					List<DBObject> list=baseDao.getList(PubConstants.DATA_SUBSCRIBE,subMap,0,10,sortMap); 	
					int size=list.size();
					if(size>0){
						if(list.get(0).get("url").toString().equals("text")){
							resultXml=WeiXinUtil.getTextXml(weixin,list.get(0).get("context").toString());		
							
						}else{
							
							resultXml=WeiXinUtil.getSubscribeXml(weixin, list,commain,b);	
						}
					}
				}else{
					//跳转到多客服
					resultXml=WeiXinUtil.getDkfXml(weixin);
				}
				
				
			} 
			Struts2Utils.getResponse().getWriter().write(resultXml);
			return null;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;

	
	   
	   
	   
   }
}
