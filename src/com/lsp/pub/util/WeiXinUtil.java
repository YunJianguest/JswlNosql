package com.lsp.pub.util; 

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.Formatter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.activation.MimetypesFileTypeMap;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;

 
 
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.aliyun.oss.OSSClient;
import com.aliyun.oss.model.ObjectMetadata;
import com.aliyun.oss.model.PutObjectResult;
import com.lsp.pub.db.MongoDbUtil;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.HttpClient;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.entity.WeiXinMessage; 
import com.lsp.pub.entity.WxToken;
import com.lsp.shop.entiy.ComMain;
import com.lsp.suc.entity.CompanyInfo;
import com.lsp.suc.entity.Comunit; 
import com.lsp.weixin.entity.ShortUrl;
import com.lsp.weixin.entity.WeixinRequest; 
import com.lsp.weixin.entity.WxUser;
import com.lsp.weixin.entity.WxUserToken;
import com.mongodb.DBObject;
/**
 * 工具
 * @author lsp 
 *   
 */
public class WeiXinUtil {
	
	
	/**
	 * 获取Token
	 * @param toUser
	 * @param appid
	 * @param secret
	 * @return
	 * @throws Exception
	 */
	public static WxToken getTokenByToUser(String toUser) {
		if("test".equals(SysConfig.getProperty("test"))){
			return null;
		}
		
		WxToken token=GetAllFunc.wxtoken.get(toUser); 
		if(token==null){
			return null;
		} 
		long now=new Date().getTime();
		if( now-token.getExpires_in()>6100000){
			String url="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="+token.getAppid()+"&secret="+token.getSecret();

			String ret1=HttpClient.http(url, null);
			JSONObject obj = (JSONObject) JSON.parse(ret1);
			if(obj==null||obj.get("access_token")==null){
				return null;
			}
			token.set_id(toUser);
			token.setAppid(token.getAppid());
			token.setSecret(token.getSecret());
			token.setExpires_in(now);
			token.setToUser(toUser);
			token.setAccess_token(obj.get("access_token").toString());
			
			url ="https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token="+token.getAccess_token()+"&type=jsapi";
			String ret2=HttpClient.http(url, null);
			JSONObject obj2 = (JSONObject) JSON.parse(ret2);
			if(obj2==null||obj2.get("ticket")==null||StringUtils.isEmpty(obj2.getString("ticket"))){
				return token;
			}
			token.setJsapi_ticket(obj2.getString("ticket"));
			GetAllFunc.wxtoken.put(toUser, token);
			
		} 
		return token;
	}
	
	
	/**
	 * 获取Token
	 * @param toUser
	 * @param requerst 
	 * @param appid
	 * @param secret
	 * @return
	 * @throws Exception
	 */
	public static WxToken getSignature(String toUser, HttpServletRequest request) {
		
		
		ComMain commain=GetAllFunc.comToUser.get(toUser);
		if(commain!=null){
			toUser=commain.getToUser();
		}
		WxToken token=GetAllFunc.wxtoken.get(toUser);
		
		if(token==null||token.getZhlx()==0||"test".equals(SysConfig.getProperty("test"))){
			return token;
		}
		
		long now=new Date().getTime();
		if( now-token.getExpires_in()>6100000){
			String url1="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="+token.getAppid()+"&secret="+token.getSecret();

			String ret1=HttpClient.http(url1, null);
			JSONObject obj = (JSONObject) JSON.parse(ret1);
			token.set_id(toUser);
			token.setAppid(token.getAppid());
			token.setSecret(token.getSecret());
			token.setExpires_in(now);
			token.setToUser(toUser);
			token.setAccess_token(obj.get("access_token").toString());
			
			url1 ="https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token="+token.getAccess_token()+"&type=jsapi";
			String ret2=HttpClient.http(url1, null);
			JSONObject obj2 = (JSONObject) JSON.parse(ret2);
			if(obj2==null||obj2.get("ticket")==null||StringUtils.isEmpty(obj2.getString("ticket"))){
				return token;
			}
			token.setJsapi_ticket(obj2.getString("ticket"));
			GetAllFunc.wxtoken.put(toUser, token);
		}
		String d=create_timestamp();
		token.setTimestamp(d);
		UUIDGenerator uu=new UUIDGenerator();
		String noncestr=uu.getNextValue();
		token.setNoncestr(noncestr);
		String strBackUrl = "http://" + request.getServerName() //服务器地址  
               
                + request.getContextPath()      //项目名称  
                + request.getServletPath()      //请求页面或其他地址  
            + "?" + (request.getQueryString());
		token.setUrl(strBackUrl.split("&fromUser=")[0].split("&code=")[0]);


		StringBuffer urlkey=new StringBuffer("jsapi_ticket=").append(token.getJsapi_ticket())
				.append("&noncestr=").append(noncestr)
				.append("&timestamp=").append(d)
				.append("&url=").append(strBackUrl);
		MessageDigest crypt;
		try {
			crypt = MessageDigest.getInstance("SHA-1");
		
			crypt.reset();
			crypt.update(urlkey.toString().getBytes("UTF-8"));
		
			String signature = byteToHex(crypt.digest());
        
			token.setSignature(signature);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(token.getZhlx()==2){
			token.setUrl("https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(token.getUrl())+"&response_type=code&scope=snsapi_base&state=123#wechat_redirect");
		}
		return token;
	}
	/**
	 * 获取Token
	 * @param toUser
	 * @param requerst 
	 * @param appid
	 * @param secret
	 * @return
	 * @throws Exception
	 */
	public static WxToken getSignature(WxToken token, HttpServletRequest request) {
		
		
		//ComMain commain=GetAllFunc.comToUser.get(toUser);
		//if(commain!=null){
	    //		toUser=commain.getToUser();
	   //	}
	//	WxToken token=GetAllFunc.wxtoken.get(toUser);
		
		if(token==null||token.getZhlx()==0||"test".equals(SysConfig.getProperty("test"))){
			return token;
		}
		
		long now=new Date().getTime();
		if(now-token.getExpires_in()>6100000){
			String url1="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="+token.getAppid()+"&secret="+token.getSecret();

			String ret1=HttpClient.http(url1, null);
			System.out.println(ret1);
			JSONObject obj = (JSONObject) JSON.parse(ret1);
			
			token.set_id(token.get_id());
			token.setAppid(token.getAppid());
			token.setSecret(token.getSecret());
			token.setExpires_in(now);
			token.setToUser(token.getToUser());
			token.setAccess_token(obj.get("access_token").toString());
			
			url1 ="https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token="+token.getAccess_token()+"&type=jsapi";
			String ret2=HttpClient.http(url1, null);
			JSONObject obj2 = (JSONObject) JSON.parse(ret2);
			if(obj2==null||obj2.get("ticket")==null||StringUtils.isEmpty(obj2.getString("ticket"))){
				return token;
			}
			token.setJsapi_ticket(obj2.getString("ticket"));
			GetAllFunc.wxtoken.put(token.get_id().toString(), token);
		}
		String d=create_timestamp();
		token.setTimestamp(d);
		UUIDGenerator uu=new UUIDGenerator();
		String noncestr=uu.getNextValue();
		token.setNoncestr(noncestr);
		String strBackUrl = "http://" + request.getServerName() //服务器地址  
               
                + request.getContextPath()      //项目名称  
                + request.getServletPath()      //请求页面或其他地址  
            + "?" + (request.getQueryString());
		token.setUrl(strBackUrl.split("&fromUser=")[0].split("&code=")[0]);


		StringBuffer urlkey=new StringBuffer("jsapi_ticket=").append(token.getJsapi_ticket())
				.append("&noncestr=").append(noncestr)
				.append("&timestamp=").append(d)
				.append("&url=").append(strBackUrl);
		MessageDigest crypt;
		try {
			crypt = MessageDigest.getInstance("SHA-1");
		
			crypt.reset();
			crypt.update(urlkey.toString().getBytes("UTF-8"));
		
			String signature = byteToHex(crypt.digest());
        
			token.setSignature(signature);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(token.getZhlx()==2){
			token.setUrl("https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(token.getUrl())+"&response_type=code&scope=snsapi_base&state=123#wechat_redirect");
		}
		return token;
	}
	/**
	 * 获取Token
	 * @param toUser
	 * @param requerst 
	 * @param appid
	 * @param secret
	 * @return
	 * @throws Exception
	 */
	public static WxToken getToken(String toUser, HttpServletRequest request) {
		
		WxToken token=GetAllFunc.wxtoken.get(toUser);
		
		if(token==null||token.getZhlx()==0||"test".equals(SysConfig.getProperty("test"))){
			return token;
		}
		
		long now=new Date().getTime();
		if( now-token.getExpires_in()>6100000){
			String url1="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="+token.getAppid()+"&secret="+token.getSecret();

			String ret1=HttpClient.http(url1, null);
			JSONObject obj = (JSONObject) JSON.parse(ret1);
			token.set_id(toUser);
			token.setAppid(token.getAppid());
			token.setSecret(token.getSecret());
			token.setExpires_in(now);
			token.setToUser(toUser);
			token.setAccess_token(obj.get("access_token").toString());
			
			url1 ="https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token="+token.getAccess_token()+"&type=jsapi";
			String ret2=HttpClient.http(url1, null);
			JSONObject obj2 = (JSONObject) JSON.parse(ret2);
			if(obj2==null||obj2.get("ticket")==null||StringUtils.isEmpty(obj2.getString("ticket"))){
				return token;
			}
			token.setJsapi_ticket(obj2.getString("ticket"));
			GetAllFunc.wxtoken.put(toUser, token);
		}

		return token;
	}
	/**
	 * 获取结算Token
	 * @param toUser
	 * @param requerst 
	 * @param appid
	 * @param secret
	 * @return
	 * @throws Exception
	 */
	public static WxToken getJsSignature(String toUser, HttpServletRequest request) {
		WxToken token=GetAllFunc.wxtoken.get(toUser); 
		if(token==null||token.getZhlx()==0||"test".equals(SysConfig.getProperty("test"))){
			return token;
		}
		
		Long now=new Date().getTime();
		if( now-token.getExpires_in()>6100000){
			String url1="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="+token.getAppid()+"&secret="+token.getSecret();

			String ret1=HttpClient.http(url1, null);
			JSONObject obj = (JSONObject) JSON.parse(ret1);
			token.set_id(toUser);
			token.setAppid(token.getAppid());
			token.setSecret(token.getSecret());
			token.setExpires_in(now);
			token.setToUser(toUser);
			token.setAccess_token(obj.get("access_token").toString());
			
			url1 ="https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token="+token.getAccess_token()+"&type=jsapi";
			String ret2=HttpClient.http(url1, null);
			JSONObject obj2 = (JSONObject) JSON.parse(ret2);
			if(obj2==null||obj2.get("ticket")==null||StringUtils.isEmpty(obj2.getString("ticket"))){
				return token;
			}
			token.setJsapi_ticket(obj2.getString("ticket"));
			GetAllFunc.wxtoken.put(toUser, token);
		}
		String d=create_timestamp();
		token.setTimestamp(d);
		UUIDGenerator uu=new UUIDGenerator();
		String noncestr=uu.getNextValue();
		token.setNoncestr(noncestr);
		String strBackUrl = "http://" + request.getServerName() //服务器地址  
               
                + request.getContextPath()      //项目名称  
                + request.getServletPath()      //请求页面或其他地址  
            + "?" + (request.getQueryString());
		token.setUrl(strBackUrl.split("&fromUser=")[0].split("&code=")[0]);


		StringBuffer urlkey=new StringBuffer("jsapi_ticket=").append(token.getJsapi_ticket())
				.append("&noncestr=").append(noncestr)
				.append("&timestamp=").append(d)
				.append("&url=").append(strBackUrl);
		MessageDigest crypt;
		try {
			crypt = MessageDigest.getInstance("SHA-1");
		
			crypt.reset();
			crypt.update(urlkey.toString().getBytes("UTF-8"));
		
			String signature = byteToHex(crypt.digest());
        
			token.setSignature(signature);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(token.getZhlx()==2){
			token.setUrl("https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(token.getUrl())+"&response_type=code&scope=snsapi_base&state=123#wechat_redirect");
		}
		return token;
	}
	/**
	 * 获取Token
	 * @param toUser
	 * @param requerst 
	 * @param appid
	 * @param secret
	 * @return
	 * @throws Exception
	 */
	public static WxToken getAjaxSignature(WxToken token,String url) throws Exception{
		 
		Long now=new Date().getTime();
		if( now-token.getExpires_in()>6100000){
			String url1="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="+token.getAppid()+"&secret="+token.getSecret();

			String ret1=HttpClient.http(url1, null);
			JSONObject obj = (JSONObject) JSON.parse(ret1);
			token.set_id(token.getToUser());
			token.setAppid(token.getAppid());
			token.setSecret(token.getSecret());
			token.setExpires_in(now);
			token.setToUser(token.getToUser());
			token.setAccess_token(obj.get("access_token").toString());
			
			url1 ="https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token="+token.getAccess_token()+"&type=jsapi";
			String ret2=HttpClient.http(url1, null);
			JSONObject obj2 = (JSONObject) JSON.parse(ret2);
			if(obj2==null||obj2.get("ticket")==null||StringUtils.isEmpty(obj2.getString("ticket"))){
				return token;
			}
			token.setJsapi_ticket(obj2.getString("ticket"));
			GetAllFunc.wxtoken.put(token.getToUser(), token);
		}
		String d=create_timestamp();
		token.setTimestamp(d);
		UUIDGenerator uu=new UUIDGenerator();
		String noncestr=uu.getNextValue();
		token.setNoncestr(noncestr);
		String strBackUrl = url;
		token.setUrl(strBackUrl.split("&fromUser=")[0]);

		StringBuffer urlkey=new StringBuffer("jsapi_ticket=").append(token.getJsapi_ticket())
				.append("&noncestr=").append(noncestr)
				.append("&timestamp=").append(d)
				.append("&url=").append(strBackUrl);
		MessageDigest crypt = MessageDigest.getInstance("SHA-1");
        crypt.reset();
        crypt.update(urlkey.toString().getBytes("UTF-8"));
        String signature = byteToHex(crypt.digest());
		token.setSignature(signature);
		
		return token;
	}
	/**
	 * 获取Token
	 * @param toUser
	 * @param requerst 
	 * @param appid
	 * @param secret
	 * @return
	 * @throws Exception
	 */
	public static WxToken getSignature(String toUser, HttpServletRequest request,int fx) throws Exception{
		
		WxToken token=GetAllFunc.wxtoken.get(toUser);
		
		if(token==null||token.getZhlx()==0){
			return null;
		}
		
		Long now=new Date().getTime();
		if( now-token.getExpires_in()>6100000){
			String url1="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="+token.getAppid()+"&secret="+token.getSecret();

			String ret1=HttpClient.http(url1, null);
			JSONObject obj = (JSONObject) JSON.parse(ret1);
			token.set_id(toUser);
			token.setAppid(token.getAppid());
			token.setSecret(token.getSecret());
			token.setExpires_in(now);
			token.setToUser(toUser);
			token.setAccess_token(obj.get("access_token").toString());
			
			url1 ="https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token="+token.getAccess_token()+"&type=jsapi";
			String ret2=HttpClient.http(url1, null);
			JSONObject obj2 = (JSONObject) JSON.parse(ret2);
			if(obj2==null||obj2.get("ticket")==null||StringUtils.isEmpty(obj2.getString("ticket"))){
				return token;
			}
			token.setJsapi_ticket(obj2.getString("ticket"));
			GetAllFunc.wxtoken.put(toUser, token);
		}
		String d=create_timestamp();
		token.setTimestamp(d);
		UUIDGenerator uu=new UUIDGenerator();
		String noncestr=uu.getNextValue();
		token.setNoncestr(noncestr);
		String strBackUrl = "http://" + request.getServerName() //服务器地址  
               
                + request.getContextPath()      //项目名称  
                + request.getServletPath()      //请求页面或其他地址  
            + "?" + (request.getQueryString());
		token.setUrl(strBackUrl.split("&fromUser=")[0]);
 
		StringBuffer urlkey=new StringBuffer("jsapi_ticket=").append(token.getJsapi_ticket())
				.append("&noncestr=").append(noncestr)
				.append("&timestamp=").append(d)
				.append("&url=").append(strBackUrl);
		MessageDigest crypt = MessageDigest.getInstance("SHA-1");
        crypt.reset();
        crypt.update(urlkey.toString().getBytes("UTF-8"));
        String signature = byteToHex(crypt.digest());
		token.setSignature(signature);
		if(fx==1){
			token.setUrl("https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+token.getUrl()+"&response_type=code&scope=snsapi_base&state=123#wechat_redirect");
		}
		
		return token;
	}
	 private static String byteToHex(final byte[] hash) {
	        Formatter formatter = new Formatter();
	        for (byte b : hash)
	        {
	            formatter.format("%02x", b);
	        }
	        String result = formatter.toString();
	        formatter.close();
	        return result;
	    }
	private static String create_timestamp() {
        return Long.toString(System.currentTimeMillis() / 1000);
    }
	
	public static JSONObject getOpenid(String token,String openid) throws Exception{
		
		
		String url="https://api.weixin.qq.com/cgi-bin/user/get?access_token="+token+"&next_openid="+openid;

		String ret1=HttpClient.http(url, null);
		
		JSONObject obj =(JSONObject) JSON.parse(ret1);
		return obj;
	}
	 
	/**
	 * 创建分组信息
	 * @param token
	 * @return
	 * @throws Exception
	 */
	public static String creatGroup(String token,String name) throws Exception{
		
		
		String url="https://api.weixin.qq.com/cgi-bin/groups/create?access_token="+token;
		
		Map<String,Object> newsmap = new HashMap<String,Object>();
		Map<String,String> map1 = new HashMap<String,String>();
		
		map1.put("name", name);
		newsmap.put("group", map1);
		
		String json = JSONArray.fromObject(newsmap).toString();
		json=json.substring(1, json.length()-1);
		ObjectMapper mapper = new ObjectMapper();  
		JSONObject obj =(JSONObject) JSON.parse(HttpClient.http(url, json));
		Map<String, Object> map  = mapper.readValue(obj.get("group").toString(),Map.class);

		return map.get("id").toString();
	}
	/**
	 * 修改分组信息
	 * @param token
	 * @return
	 * @throws Exception
	 */
	public static String updGroup(String token,int id,String name) throws Exception{
		
		
		String url="https://api.weixin.qq.com/cgi-bin/groups/update?access_token="+token;
		
		Map<String,Object> newsmap = new HashMap<String,Object>();
		Map<String,Object> map1 = new HashMap<String,Object>();
		map1.put("id", id);
		map1.put("name", name);
		newsmap.put("group", map1);
		
		String json = JSONArray.fromObject(newsmap).toString();
		json=json.substring(1, json.length()-1);
	
		JSONObject obj =(JSONObject) JSON.parse(HttpClient.http(url, json));
		return obj.getString("errcode");
	}
	/**
	 * 查询用户所在分组
	 * @param token
	 * @return
	 * @throws Exception
	 */
	public static int getGroupId(String token,String fromUser) throws Exception{
		
		
		String url="https://api.weixin.qq.com/cgi-bin/groups/getid?access_token="+token;
		
		Map<String,Object> newsmap = new HashMap<String,Object>();
		
		newsmap.put("openid", fromUser);
		
		
		
		String json = JSONArray.fromObject(newsmap).toString();
		json=json.substring(1, json.length()-1);
	
		JSONObject obj =(JSONObject) JSON.parse(HttpClient.http(url, json));
		if(obj.getString("groupid")==null){
			return 0;
		}else{
			return Integer.parseInt(obj.getString("groupid").toString());
		}
		
	}
	/**
	 * 查询用户所在分组
	 * @param token
	 * @return
	 * @throws Exception
	 */
	public static String updUserGroup(String token,String fromUser,int groupid) throws Exception{
		
		
		String url="https://api.weixin.qq.com/cgi-bin/groups/members/update?access_token="+token;
		
		Map<String,Object> newsmap = new HashMap<String,Object>();
		
		newsmap.put("openid", fromUser);
		newsmap.put("to_groupid ", groupid);
		
		
		String json = JSONArray.fromObject(newsmap).toString();
		json=json.substring(1, json.length()-1);
	
		JSONObject obj =(JSONObject) JSON.parse(HttpClient.http(url, json));
	
		return obj.getString("errcode").toString();
		
		
	}
	
	/**
	 * 通过code换取网页授权access_token
	 * @param token
	 * @return
	 * @throws Exception
	 */
	public static String getOpenId(String toUser,String code) {
		
		WxToken token=WeiXinUtil.getTokenByToUser(toUser);
		if(token==null){
			return "";
		}
		String url="https://api.weixin.qq.com/sns/oauth2/access_token?appid="+token.getAppid()+"&secret="+token.getSecret()+"&code="+code+"&grant_type=authorization_code";
		String json = WeiXinUtil.getHttpConnHtml(url);
		
		JSONObject obj = (JSONObject) JSON.parse(json);
		if(obj==null||obj.get("openid")==null){
			return "";
		}else{
			return obj.getString("openid");
		}
		
		
	}
	/**
	 * 通过code换取网页授权
	 * @param token
	 * @return
	 * @throws Exception
	 */
	public static WxUserToken getOpenIdToKen(String toUser,String code) {
		
		Long now=new Date().getTime();
		
			WxToken token=WeiXinUtil.getTokenByToUser(toUser); 
			String url="https://api.weixin.qq.com/sns/oauth2/access_token?appid="+token.getAppid()+"&secret="+token.getSecret()+"&code="+code+"&grant_type=authorization_code";
			String json = WeiXinUtil.getHttpConnHtml(url);
			JSONObject obj = (JSONObject) JSON.parse(json);
			WxUserToken ut=new WxUserToken();
			String fromUser=obj.getString("openid");
			ut.set_id(fromUser);
			ut.setFromUser(fromUser);
			ut.setExpires_in(now);
			ut.setToken(obj.getString("access_token"));
			GetAllFunc.usertoken.put(fromUser, ut);
			
		
		
		return ut;
	}
	
	/**
	 * 拉取用户信息(需scope为 snsapi_userinfo)
	 * @param token
	 * @return
	 * @throws Exception
	 */
	public static JSONObject getUserinfo(String toUser,String fromUser) {
		
		WxUserToken usertoken=GetAllFunc.usertoken.get(fromUser);
		String url="https://api.weixin.qq.com/sns/userinfo?access_token="+usertoken.getToken()+"&openid="+fromUser+"&lang=zh_CN";
		
		String json = WeiXinUtil.getHttpConnHtml(url);
		
		JSONObject obj = (JSONObject) JSON.parse(json);
	
		return obj;
	}

	

	
	/**
	 * 微信上传文件接口
	 * @param access_token
	 * @param filePath
	 * @param type
	 * @return
	 * @throws Exception
	 */
	public static String uploadFile(String access_token,String filePath,String type) throws Exception {
		 File file = new File(filePath);
	        if (!file.exists() || !file.isFile()) {
	            return "文件路径错误";
	        }
	        /**
	         * 第一部分
	         */


	        
	        String url = "http://file.api.weixin.qq.com/cgi-bin/media/upload?access_token="+access_token+"&type="+type;
	        URL urlObj = new URL(url);
	        HttpURLConnection con = (HttpURLConnection) urlObj.openConnection();

	        /**
	         * 设置关键值
	         */
	        con.setRequestMethod("POST"); // 以Post方式提交表单，默认get方式
	        con.setDoInput(true);
	        con.setDoOutput(true);
	        con.setUseCaches(false); // post方式不能使用缓存
	        // 设置请求头信息
	        con.setRequestProperty("Connection", "Keep-Alive");
	        con.setRequestProperty("Charset", "UTF-8");
	
	        // 设置边界
	        String BOUNDARY = "----------" + System.currentTimeMillis();
	        con.setRequestProperty("content-type", "multipart/form-data; boundary=" + BOUNDARY);
	        //con.setRequestProperty("Content-Type", "multipart/mixed; boundary=" + BOUNDARY);
	        //con.setRequestProperty("content-type", "text/html");
	        // 请求正文信息
	
	        // 第一部分：
	        StringBuilder sb = new StringBuilder();
	        sb.append("--"); // ////////必须多两道线
	        sb.append(BOUNDARY);
	        sb.append("\r\n");
	        sb.append("Content-Disposition: form-data;name=\"file\";filename=\""
	                + file.getName() + "\"\r\n");
	        sb.append("Content-Type:application/octet-stream\r\n\r\n");
	        byte[] head = sb.toString().getBytes("utf-8");
	        // 获得输出流
	        OutputStream out = new DataOutputStream(con.getOutputStream());
	        out.write(head);
	        
	        // 文件正文部分
	        DataInputStream in = new DataInputStream(new FileInputStream(file));
	        int bytes = 0;
	        byte[] bufferOut = new byte[1024];
	        while ((bytes = in.read(bufferOut)) != -1) {
	            out.write(bufferOut, 0, bytes);
	        }
	        in.close();
	        // 结尾部分
	        byte[] foot = ("\r\n--" + BOUNDARY + "--\r\n").getBytes("utf-8");// 定义最后数据分隔线
	        out.write(foot);
	        out.flush();
	        out.close();
	        /**
	         * 读取服务器响应，必须读取,否则提交不成功
	         */
	       // con.getResponseCode();

	        /**
	         * 下面的方式读取也是可以的
	         */

	         try {

	         // 定义BufferedReader输入流来读取URL的响应
	        	 StringBuffer buffer = new StringBuffer();
		         BufferedReader reader = new BufferedReader(new InputStreamReader(
		         con.getInputStream(),"UTF-8"));
		         String line = null;
		         while ((line = reader.readLine()) != null) {
		           
		            buffer.append(line);
		         }
		         JSONObject obj = (JSONObject) JSON.parse(buffer.toString());
		         return obj.getString("media_id");
	         } catch (Exception e) {
	        	 System.out.println("发送POST请求出现异常！" + e);
	        	 e.printStackTrace();
	         }
	         return "1";
	}
	/**
	   * 获取媒体文件
	   * @param accessToken 接口访问凭证
	   * @param media_id 媒体文件id
	   * @param savePath 文件在服务器上的存储路径
	   * */
	  public static File downloadMedia(String access_token, String mediaId, String savePath) {
	    String filePath = null;
	    // 拼接请求地址
	    String requestUrl = "https://api.weixin.qq.com/cgi-bin/media/get?access_token="+access_token+"&media_id="+mediaId;
	    String fileExt = "";
	    File file = new File(savePath); // 判断文件夹是否存在,如果不存在则创建文件夹
	    if (!file.exists()) {
	      file.mkdir();
	    }
	
	    try {
	      URL url = new URL(requestUrl);
	      HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	      conn.setDoInput(true);
	      conn.setRequestMethod("GET");

	     
	      // 根据内容类型获取扩展名
	      String type=conn.getHeaderField("Content-Type");
	     
	     
	      if(type.equals("image/jpeg")){
	    	  fileExt=".jpg";
	      }
	    
	      // 将mediaId作为文件名
	      filePath = savePath + mediaId + fileExt;

	      BufferedInputStream bis = new BufferedInputStream(conn.getInputStream());
	      FileOutputStream fos = new FileOutputStream(new File(filePath));
	      byte[] buf = new byte[8096];
	      int size = 0;
	      while ((size = bis.read(buf)) != -1)
	        fos.write(buf, 0, size);
	      fos.close();
	      bis.close();

	      conn.disconnect();
	      
	    } catch (Exception e) {
	      filePath = null;
	    
	    }
	    return new File(filePath);
	  }
	/**
	 * 上传图文消息素材
	 * @param token
	 */
	public static String SendNews(String token,List<DBObject> news){
		String url="https://api.weixin.qq.com/cgi-bin/media/uploadnews?access_token="+token;
		ObjectMapper mapper = new ObjectMapper();  
		Map<String,List<Map<String,Object>>> newsmap = new HashMap<String,List<Map<String,Object>>>();
		List<Map<String,Object>> newslist = new ArrayList<Map<String,Object>>();
		for(int i=0;i<news.size();i++){
			DBObject newsdb=news.get(i);
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("thumb_media_id", newsdb.get("media_id").toString());
			map.put("author", newsdb.get("author").toString());
			map.put("title", newsdb.get("title").toString());
			map.put("content_source_url", newsdb.get("url").toString());
			map.put("content", newsdb.get("content").toString());
			map.put("digest",newsdb.get("summary").toString());
			map.put("show_cover_pic",newsdb.get("show_cover_pic").toString());
			newslist.add(map);
		}
		newsmap.put("articles", newslist);
		String json = JSONArray.fromObject(newsmap).toString();
		json=json.substring(1, json.length()-1);
		
		String ret=HttpClient.http(url, json);
		Map<String, Object> map = null;
		try {
			map = mapper.readValue(ret,Map.class);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return map.get("media_id").toString();
	}
	
	
	/**
	 * 根据分组进行群发
	 * @param token
	 */
	public static String SendNewsByGroup(String token,String group_id,String media_id){
		String url="https://api.weixin.qq.com/cgi-bin/message/mass/sendall?access_token="+token;
		ObjectMapper mapper = new ObjectMapper();  
		Map<String,Object> newsmap = new HashMap<String,Object>();
		Map<String,String> map1 = new HashMap<String,String>();
		Map<String,String> map2 = new HashMap<String,String>();
		map1.put("group_id", group_id);
		newsmap.put("filter", map1);
		map2.put("media_id", media_id);
		newsmap.put("mpnews", map2);
		
		
		newsmap.put("msgtype", "mpnews");
		
		String json = JSONArray.fromObject(newsmap).toString();
		json=json.substring(1, json.length()-1);
		
		String ret=HttpClient.http(url, json);
		Map<String, Object> map = null;
		try {
			map = mapper.readValue(ret,Map.class);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return map.get("errcode").toString();
	}
	
	
	
	public static String getHttpConnHtml(String url) {
		HttpURLConnection conn = null;

		String valueString = "";
		StringBuffer bufferRes = new StringBuffer();
		try {
			URL realUrl = new URL(url);
			conn = (HttpURLConnection) realUrl.openConnection();
			// 连接超时
			conn.setConnectTimeout(3000);
			// 读取超时 --服务器响应比较慢，增大时间
			conn.setReadTimeout(3000);
			// 请求方式
			conn.setRequestMethod("GET");
			conn.setDoInput(true);
			conn.connect();
	
			InputStream in = conn.getInputStream();
			BufferedReader read = new BufferedReader(new InputStreamReader(in,"UTF-8"));
			while ((valueString=read.readLine())!=null){
				bufferRes.append(valueString);
			}
			in.close();
			
		} catch (Exception e) {
			System.out.println("访问【" + url + "】出现异常!");
		} finally {
			if (conn != null) {
				conn.disconnect();
			}
		}
		return bufferRes.toString();
	}
	/** 永久二维码请求说明
	 * @param appid  
	 * @param secret
	 */
	public static JSONObject getTicket(String token,String id){
		String url = "https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token="+token;
		
		Map<String,Object> newsmap = new HashMap<String,Object>();
		Map<String,Object> map1 = new HashMap<String,Object>();
		Map<String,String> map2 = new HashMap<String,String>();
		newsmap.put("action_name", "QR_LIMIT_SCENE");
		map2.put("scene_id", id);
		map1.put("scene", map2);
		newsmap.put("action_info", map1);
		
		String json = JSONArray.fromObject(newsmap).toString();
		json=json.substring(1, json.length()-1);
		
		JSONObject obj =(JSONObject) JSON.parse(HttpClient.http(url, json));
		
		return obj;
	}
	/** 永久二维码请求说明
	 * @param appid  
	 * @param secret
	 */
	public static JSONObject getShorturl1(String token,String lurl){
		String url = "https://api.weixin.qq.com/cgi-bin/shorturl?access_token="+token;
		
		Map<String,Object> newsmap = new HashMap<String,Object>();
		 
		newsmap.put("access_token", token);
		newsmap.put("action", "long2short");
		
		newsmap.put("long_url", lurl);
		
		String json = JSONArray.fromObject(newsmap).toString();
		json=json.substring(1, json.length()-1);
		JSONObject obj =(JSONObject) JSON.parse(HttpClient.http(url, json));
		
		return obj;
	}
	public static String   getsqurl(String toUser,String surl){
		WxToken token=GetAllFunc.wxtoken.get(toUser);
		String ddurl="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(surl)+"&response_type=code&scope=snsapi_base&state=123#wechat_redirect";
		return ddurl;
	}  
	public static String   getinqurl(String toUser,String surl){
		WxToken token=GetAllFunc.wxtoken.get(toUser);
		String ddurl="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(surl)+"&response_type=code&scope=snsapi_userinfo&state=123#wechat_redirect";
		return ddurl;
	}  
	public static ShortUrl getDwz(String toUser,String surl){
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		
		whereMap.clear();
		whereMap.put("surl", surl);
		MongoDbUtil mongoDbUtil=new MongoDbUtil(); 
		DBObject surlDb=mongoDbUtil.findOne(PubConstants.WEIXIN_SHORTURL, whereMap);
		ShortUrl entity = new ShortUrl();
		
		if(surlDb==null){
				WxToken token=GetAllFunc.wxtoken.get(toUser);
				if(token==null){
					entity.set_id(121L);
					entity.setDwz(SysConfig.getProperty("ym")+"d?id="+entity.get_id().toString());
					return entity;
				}
				MongoSequence mongoSequence=new MongoSequence();

				String ddurl="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(surl)+"&response_type=code&scope=snsapi_base&state=123#wechat_redirect";
				
				entity.set_id(mongoSequence.currval(PubConstants.WEIXIN_SHORTURL));
				entity.setSurl(surl);
				entity.setLurl(ddurl);
				entity.setInsdate(new Date());
				entity.setToUser(toUser);
				
				mongoDbUtil.insertUpdate(PubConstants.WEIXIN_SHORTURL, entity);
			
		}else{
			entity = (ShortUrl)UniObject.DBObjectToObject(surlDb,ShortUrl.class);
			entity.set_id((Long)surlDb.get("_id"));
		}
		entity.setDwz(SysConfig.getProperty("ym")+"d?id="+entity.get_id().toString());
		return entity;
	}
	/** 获得微信的Access_token
	 * @param appid  
	 * @param secret
	 */
	public static String getTicketImg(String ticket){
		String url_str = "https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket="+ticket;
		String json = WeiXinUtil.getHttpConnHtml(url_str);
		JSONObject obj = (JSONObject) JSON.parse(json);
		return obj.get("access_token").toString();
	}
	/** 发送图文消息 48小时内
	 * @param appid  
	 * @param secret
	 */
	public static String sendMessage(String token,String fromUser,List<WeiXinMessage> wxMessage){
		String url = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token="+token;
		
		Map<String,Object> newsmap = new HashMap<String,Object>();
		Map<String,Object> map1 = new HashMap<String,Object>();
		
		newsmap.put("touser", fromUser);
		newsmap.put("msgtype", "news");
		List<Map<String,String>> newslist = new ArrayList<Map<String,String>>();
		for(int i=0;i<wxMessage.size();i++){
			WeiXinMessage news=wxMessage.get(i);
			Map<String,String> map = new HashMap<String,String>();
			map.put("title", news.getTitle());
			map.put("description", news.getDescription());
			map.put("url", news.getUrl());
			map.put("picurl", news.getPicurl());
			newslist.add(map);
		}
		map1.put("articles", newslist);
		newsmap.put("news", map1);

		String json = JSONArray.fromObject(newsmap).toString();
		json=json.substring(1, json.length()-1);
		
		JSONObject obj =(JSONObject) JSON.parse(HttpClient.http(url, json));
		
		return null;
	}
	
	/**
	 * 发送模板消息
	 * @param token
	 */
	public static String SendTemplate(String toUser,String fromUser,String template_id,String ljurl,HashMap<String,String>  data){
		WxToken token =WeiXinUtil.getTokenByToUser(toUser);
		if(token==null){
			return null;
		}
		String t=token.getAccess_token();
		String url="https://api.weixin.qq.com/cgi-bin/message/template/send?access_token="+t;
	
		Map<String,Object> newsmap = new HashMap<String,Object>();
		newsmap.put("touser", fromUser);
		newsmap.put("template_id", template_id);
		newsmap.put("url", ljurl);
		newsmap.put("topcolor", "#FF0000");
		
		Map<String,Object> jsonMap = new HashMap<String,Object>();
		if(data!=null || !data.isEmpty())
		{
		    Set set = data.keySet();
		    Iterator it = set.iterator();
		    
		    while(it.hasNext())
		    {
		    Map<String,Object> v1 = new HashMap<String,Object>();
			
			 v1.put("color", "#173177");
		     String key = (String)it.next();
		     String value = data.get(key);
		     v1.put("value", value);
		     jsonMap.put(key, v1);
		     }
		}
		
		newsmap.put("data", jsonMap);
		
		String json = JSONArray.fromObject(newsmap).toString();
		json=json.replaceAll("fromUserData", fromUser);
		json=json.substring(1, json.length()-1);
		
		String ret=HttpClient.http(url, json);
		
		return ret;
	}
	
	/**
	 * 获取用户基本信息
	 * @param token
	 * @param fromUser
	 * @return
	 * @throws Exception
	 */
	public static JSONObject getUserInfo(String token,String fromUser) {
		
		
		String url="https://api.weixin.qq.com/cgi-bin/user/info?access_token="+token+"&openid="+fromUser;
		
		String ret1=HttpClient.http(url, null);
		JSONObject jsonObject=JSONObject.parseObject(ret1);

		return jsonObject;
	}
	
	
	/**
	 * 发送文本消息
	 * @param token
	 * @param fromUser
	 * @return
	 * @throws Exception
	 */
	public  static void sendKfText(String token,String fromUser,String msg,WxUser user) throws Exception{
		
		
		String url="https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token="+token;
		Map<String,Object> newsmap = new HashMap<String,Object>();
		Map<String,Object> newsmap1 = new HashMap<String,Object>();
		newsmap.put("touser", fromUser);
		newsmap.put("msgtype", "text");
		newsmap1.put("content", msg);
		
		newsmap.put("text", newsmap1);
		String json = JSONArray.fromObject(newsmap).toString();
		json=json.replaceAll("fromUserData", fromUser);
		json=json.replaceAll("NO", user.getNo());
		json=json.replaceAll("NAME", user.getNickname());
		//json=json.replaceAll("JIFEN", String.valueOf(user.getJf()));
		json=json.substring(1, json.length()-1);
		String ret=HttpClient.http(url, json);

	}
	/**
	 * 发送文本消息
	 * @param token
	 * @param fromUser
	 * @return
	 * @throws Exception
	 */
	public  static void sendKfText(String token,String fromUser,String msg) throws Exception{
		
		
		String url="https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token="+token;
		Map<String,Object> newsmap = new HashMap<String,Object>();
		Map<String,Object> newsmap1 = new HashMap<String,Object>();
		newsmap.put("touser", fromUser);
		newsmap.put("msgtype", "text");
		newsmap1.put("content", msg);
		
		newsmap.put("text", newsmap1);
		String json = JSONArray.fromObject(newsmap).toString();
		
		json=json.substring(1, json.length()-1);
		String ret=HttpClient.http(url, json);

	}
	/** 发送图文消息 48小时内
	 * @param appid  
	 * @param secret
	 */
	public static void sendNews(String token,String fromUser,DBObject wxMessage,WxUser user){
		String url = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token="+token;
		
		Map<String,Object> newsmap = new HashMap<String,Object>();
		Map<String,Object> map1 = new HashMap<String,Object>();
		
		newsmap.put("touser", fromUser);
		newsmap.put("msgtype", "news");
		List<Map<String,String>> newslist = new ArrayList<Map<String,String>>();
	
			Map<String,String> map = new HashMap<String,String>();
			map.put("title", wxMessage.get("title").toString());
			map.put("description", wxMessage.get("summary").toString());
			map.put("url", wxMessage.get("url").toString());
			map.put("picurl", getOsshttp()+wxMessage.get("picurl").toString());
			newslist.add(map);
		
		map1.put("articles", newslist);
		newsmap.put("news", map1);
		
		String json = JSONArray.fromObject(newsmap).toString();
		json=json.replaceAll("NO", user.getNo());
		if(user.getNickname()!=null){
			json=json.replaceAll("NAME", user.getNickname());
		}
		json=json.replaceAll("fromUserData", fromUser);
		//json=json.replaceAll("JIFEN", String.valueOf(user.getJf()));
		json=json.substring(1, json.length()-1);
		
		HttpClient.http(url, json);
		
	}
	/** 发送图文消息 48小时内
	 * @param appid  
	 * @param secret
	 */
	public static void sendTjNews(String token,String fromUser,DBObject wxMessage,WxUser user,DBObject tjUser){
		String url = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token="+token;
		
		Map<String,Object> newsmap = new HashMap<String,Object>();
		Map<String,Object> map1 = new HashMap<String,Object>();
		
		newsmap.put("touser", fromUser);
		newsmap.put("msgtype", "news");
		List<Map<String,String>> newslist = new ArrayList<Map<String,String>>();
	
			Map<String,String> map = new HashMap<String,String>();
			map.put("title", wxMessage.get("title").toString());
			map.put("description", wxMessage.get("summary").toString());
			map.put("url", wxMessage.get("url").toString());
			map.put("picurl", getOsshttp()+wxMessage.get("picurl").toString());
			newslist.add(map);
		
		map1.put("articles", newslist);
		newsmap.put("news", map1);
		
		String json = JSONArray.fromObject(newsmap).toString();
		json=json.replaceAll("NO", user.getNo());
		if(user.getNickname()!=null){
			json=json.replaceAll("NAME", user.getNickname());
		}
		if(tjUser.get("NAME")!=null){
			json=json.replaceAll("TJNAME", tjUser.get("NAME").toString());
		}
		
		//json=json.replaceAll("JIFEN", String.valueOf(user.getJf()));
		json=json.substring(1, json.length()-1);
		
		HttpClient.http(url, json);
		
	}
	/** 发送图文消息 48小时内
	 * @param appid  
	 * @param secret
	 */
	public static void sendNews(String token,String fromUser,List<DBObject> messageList,WxUser user){
		String url = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token="+token;
		
		Map<String,Object> newsmap = new HashMap<String,Object>();
		Map<String,Object> map1 = new HashMap<String,Object>();
		
		newsmap.put("touser", fromUser);
		newsmap.put("msgtype", "news");
		List<Map<String,String>> newslist = new ArrayList<Map<String,String>>();
		int size=messageList.size();
		if(size>9){
			size=9;
		}
		for(int i=0;i<size;i++){
			DBObject wxMessage =messageList.get(i);
		
			Map<String,String> map = new HashMap<String,String>();
			map.put("title", wxMessage.get("title").toString());
			map.put("description", "");
			map.put("url", wxMessage.get("url").toString());
			map.put("picurl", getOsshttp()+wxMessage.get("picurl").toString());
			newslist.add(map);

		}
		map1.put("articles", newslist);
		newsmap.put("news", map1);
		String json = JSONArray.fromObject(newsmap).toString();
		
		if(user.getNo()!=null){
			json=json.replaceAll("NO", user.getNo());
		}
		if(user.getNickname()!=null){
			json=json.replaceAll("NAME", user.getNickname());
		}
		json=json.replaceAll("fromUserData", fromUser);
		//json=json.replaceAll("JIFEN", String.valueOf(user.getJf()));
		json=json.substring(1, json.length()-1);
		
		HttpClient.http(url, json);
		
	}
	/** 发送图文消息 48小时内
	 * @param appid  
	 * @param secret
	 */
	public static void sendNews(String token,String fromUser,DBObject wxMessage){
		String url = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token="+token;
		
		Map<String,Object> newsmap = new HashMap<String,Object>();
		Map<String,Object> map1 = new HashMap<String,Object>();
		
		newsmap.put("touser", fromUser);
		newsmap.put("msgtype", "news");
		List<Map<String,String>> newslist = new ArrayList<Map<String,String>>();
	
			Map<String,String> map = new HashMap<String,String>();
			map.put("title", wxMessage.get("title").toString());
			map.put("description", wxMessage.get("summary").toString());
			if(wxMessage.get("url")==null){
				map.put("url", "");
			}else{
				map.put("url", wxMessage.get("url").toString());
			}
			
			map.put("picurl", getOsshttp()+wxMessage.get("picurl").toString());
			newslist.add(map);
		
		map1.put("articles", newslist);
		newsmap.put("news", map1);
		
		String json = JSONArray.fromObject(newsmap).toString();
		
		json=json.substring(1, json.length()-1);
		
		HttpClient.http(url, json);
		
	}
	/** 发送图文消息 48小时内
	 * @param appid  
	 * @param secret
	 */
	public static void sendWzNews(String token,String fromUser,DBObject wxMessage,List<DBObject> wzList,WxUser user,String carno){
		String url = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token="+token;
		
		Map<String,Object> newsmap = new HashMap<String,Object>();
		Map<String,Object> map1 = new HashMap<String,Object>();
		
		newsmap.put("touser", fromUser);
		newsmap.put("msgtype", "news");
		List<Map<String,String>> newslist = new ArrayList<Map<String,String>>();
		Map<String,String> map = new HashMap<String,String>();
			map.put("title", wxMessage.get("title").toString());
			map.put("description", wxMessage.get("summary").toString());
			map.put("url", wxMessage.get("url").toString());
			map.put("picurl", getOsshttp()+wxMessage.get("picurl").toString());
			newslist.add(map);
			
		
		int size=wzList.size();
		if(size>9){
			size=9;
		}
		for(int i=0;i<size;i++){
			Map<String,String> wzmap = new HashMap<String,String>();
			DBObject detail=wzList.get(i);
			StringBuffer resultXml=new StringBuffer();
			if(detail.get("date")!=null){
				resultXml.append(detail.get("date").toString());
			}
			if(detail.get("area")!=null){
				resultXml.append("在").append(detail.get("area").toString()).append("违章;");
			}
//			if(detail.get("act")!=null){
//				resultXml.append(detail.get("act").toString()).append(";");
//			}
//			if(detail.get("code")!=null){
//				resultXml.append("代码：").append(detail.get("code").toString()).append(";");
//			}
			if(detail.get("fen")!=null){
				resultXml.append("扣分：").append(detail.get("fen").toString()).append(";");
			}
			if(detail.get("money")!=null){
				resultXml.append("罚款：").append(detail.get("money").toString()).append(";");
			}
			
			wzmap.put("title", resultXml.toString());
			
			newslist.add(wzmap);
			
			
		}
		map1.put("articles", newslist);
		newsmap.put("news", map1);

		String json = JSONArray.fromObject(newsmap).toString();
		json=json.replaceAll("NO", user.getNo());
		json=json.replaceAll("NAME", user.getNickname());
		//json=json.replaceAll("JIFEN", String.valueOf(user.getJf()));
		json=json.replaceAll("CARPZ", carno);
		json=json.substring(1, json.length()-1);
		json=json.replaceAll("fromUserData",user.getFromUser());
		HttpClient.http(url, json);
		
	}
	/** 发送图文消息 48小时内
	 * @param appid  
	 * @param secret
	 */
	public static void sendWzNews(String token,String fromUser,DBObject wxMessage,List<DBObject> wzList,WxUser user,String carno,String img){
		String url = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token="+token;
		
		Map<String,Object> newsmap = new HashMap<String,Object>();
		Map<String,Object> map1 = new HashMap<String,Object>();
		
		newsmap.put("touser", fromUser);
		newsmap.put("msgtype", "news");
		List<Map<String,String>> newslist = new ArrayList<Map<String,String>>();
		Map<String,String> map = new HashMap<String,String>();
			map.put("title", wxMessage.get("title").toString());
			map.put("description", wxMessage.get("summary").toString());
			map.put("url", wxMessage.get("url").toString());
			map.put("picurl", img);
			newslist.add(map);
			
		int size=wzList.size();
		if(size>9){
			size=9;
		}
		for(int i=0;i<size;i++){
			Map<String,String> wzmap = new HashMap<String,String>();
			DBObject detail=wzList.get(i);
			StringBuffer resultXml=new StringBuffer();
			if(detail.get("date")!=null){
				resultXml.append(detail.get("date").toString());
			}
			if(detail.get("area")!=null){
				resultXml.append("在").append(detail.get("area").toString()).append("违章;");
			}
//			if(detail.get("act")!=null){
//				resultXml.append(detail.get("act").toString()).append(";");
//			}
//			if(detail.get("code")!=null){
//				resultXml.append("代码：").append(detail.get("code").toString()).append(";");
//			}
			if(detail.get("fen")!=null){
				resultXml.append("扣分：").append(detail.get("fen").toString()).append(";");
			}
			if(detail.get("money")!=null){
				resultXml.append("罚款：").append(detail.get("money").toString()).append(";");
			}
			
			wzmap.put("title", resultXml.toString());
			
			newslist.add(wzmap);
			
			
		}
		map1.put("articles", newslist);
		newsmap.put("news", map1);

		String json = JSONArray.fromObject(newsmap).toString();
		if(user.getNo()!=null){
			json=json.replaceAll("NO", user.getNo());
		}
		
		if(user.getNickname()!=null){
			json=json.replaceAll("NAME", user.getNickname());
		}
		if(carno!=null){
			json=json.replaceAll("CARPZ", carno);
		}
		
		json=json.substring(1, json.length()-1);
		if(user.getFromUser()!=null){
			json=json.replaceAll("fromUserData",user.getFromUser());
		}
		
		String re=HttpClient.http(url, json);
		
	}
	public static String getOsshttp(){
		String osshttp="";
		if(SysConfig.getProperty("isossup").endsWith("0")){
			osshttp=SysConfig.getProperty("ip");
		}else{
			osshttp=SysConfig.getProperty("filehttp");
		}
		return osshttp;
	}
	/**
	 * 获取车辆xml
	 * @param weixin
	 * @param list
	 * @return
	 */
	public static String getPubMessageXml(WeixinRequest weixin,List<DBObject> list,ComMain commain,boolean b) {
		StringBuffer resultXml=new StringBuffer();
		Date dt = new Date();
		
		int size=list.size();
		resultXml.append("<xml> <ToUserName><![CDATA[")
		.append(weixin.getFromUser()).append("]]></ToUserName> <FromUserName><![CDATA[")
		.append(weixin.getToUser()).append("]]></FromUserName> <CreateTime>").append(dt.getTime())
		.append("</CreateTime> <MsgType><![CDATA[news]]></MsgType>")
		.append("<ArticleCount>").append(size).append("</ArticleCount><Articles> ");
		 
		for(int i=0;i<size;i++){
			DBObject zdy=list.get(i);
			resultXml.append("<item><Title><![CDATA[").append(zdy.get("title").toString()).append("]]></Title> ");
			if(size==1){
				resultXml.append("<Description><![CDATA[").append(zdy.get("summary").toString()).append("]]></Description>");
			}
			else {
				resultXml.append("<Description><![CDATA[]]></Description>");
			}
			
			resultXml.append(" <PicUrl><![CDATA[").append(getOsshttp()).append(zdy.get("picurl").toString()).append("]]></PicUrl>");
			resultXml.append("<Url><![CDATA[").append(WeiXinUtil.getBdUrl(commain,weixin.getFromUser(),zdy.get("url").toString(),b)).append("]]></Url></item>");										
		}
		
		resultXml.append("</Articles></xml>");	
		
		return resultXml.toString();
	}
	
	/**
	 * 获取欢迎页xml
	 * @param weixin
	 * @param list
	 * @return
	 */
	public static String getSubscribeXml(WeixinRequest weixin,List<DBObject> list,ComMain commain,boolean b) {
		StringBuffer resultXml=new StringBuffer();
		Date dt = new Date();
		
		resultXml.append("<xml> <ToUserName><![CDATA[")
		.append(weixin.getFromUser()).append("]]></ToUserName> <FromUserName><![CDATA[")
		.append(weixin.getToUser()).append("]]></FromUserName> <CreateTime>").append(dt.getTime())
		.append("</CreateTime> <MsgType><![CDATA[news]]></MsgType>")
		.append("<ArticleCount>").append(list.size()).append("</ArticleCount><Articles> ");

		for(int i=0;i<list.size();i++){
			DBObject sub=list.get(i);
			resultXml.append("<item><Title><![CDATA[").append(sub.get("newtitle").toString()).append("]]></Title> ");
		
			resultXml.append("<Description><![CDATA[]]></Description>");
			
	
			resultXml.append(" <PicUrl><![CDATA[").append(getOsshttp()).append(sub.get("picurl").toString()).append("]]></PicUrl>");
	
			if(sub.get("url")==null||sub.get("url").toString().equals("link")){
				resultXml.append("<Url><![CDATA[").append(WeiXinUtil.getBdUrl(commain,weixin.getFromUser(),sub.get("context").toString(),b)).append("]]></Url></item>");
			}else{
				resultXml.append("<Url><![CDATA[").append(WeiXinUtil.getBdUrl(commain,weixin.getFromUser(),SysConfig.getProperty("ip")+"/wwz/wwz!"+sub.get("url").toString()+"&toUser="+weixin.getToUser()+"&fromUser=fromUserData",b)).append("]]></Url></item>");
			}

		}

		resultXml.append("</Articles></xml>");
		
		return resultXml.toString();
	}
	public static String getTextXml(WeixinRequest weixin,String message) {
		StringBuffer resultXml=new StringBuffer();
		Date dt = new Date();
		
		resultXml.append("<xml> <ToUserName><![CDATA[")
		.append(weixin.getFromUser()).append("]]></ToUserName> <FromUserName><![CDATA[")
		.append(weixin.getToUser()).append("]]></FromUserName> <CreateTime>").append(dt.getTime())
		.append("</CreateTime> <MsgType><![CDATA[text]]></MsgType>")
		.append("<Content><![CDATA[").append(message).append("]]></Content></xml>");
		
		
		return resultXml.toString();
	}
	/**
	 * 获取图文xml
	 * @param weixin
	 * @param list
	 * @return
	 */
	public static String getNewsXml(WeixinRequest weixin,List<DBObject> list,ComMain commain,boolean b) {
		StringBuffer resultXml=new StringBuffer();
		Date dt = new Date();
		
		resultXml.append("<xml> <ToUserName><![CDATA[")
		.append(weixin.getFromUser()).append("]]></ToUserName> <FromUserName><![CDATA[")
		.append(weixin.getToUser()).append("]]></FromUserName> <CreateTime>").append(dt.getTime())
		.append("</CreateTime> <MsgType><![CDATA[news]]></MsgType>")
		.append("<ArticleCount>").append(list.size()).append("</ArticleCount><Articles> ");
		
		
		for(DBObject db:list){
			
			resultXml.append("<item><Title><![CDATA[").append(db.get("newtitle").toString()).append("]]></Title> ");
			
			resultXml.append("<Description><![CDATA[]]></Description>");
		
			resultXml.append(" <PicUrl><![CDATA[").append(getOsshttp()).append(db.get("picUrl").toString()).append("]]></PicUrl>");	
			if(db.get("lx").toString().equals("2")){
				resultXml.append("<Url><![CDATA[").append(db.get("url").toString()).append("]]></Url></item>");	
				
			}else{
				resultXml.append("<Url><![CDATA[").append(SysConfig.getProperty("ip")).append("/wwz/wwz!wxnewscommondetail.action?_id=").append(db.get("_id").toString()).append("&toUser=").append(weixin.getToUser()).append("&fromUser=fromUserData]]></Url></item>");											
			}
		}
		
		resultXml.append("</Articles></xml>");
		return resultXml.toString();
	}
	/**
	 * //自定义回复
	 * @param weixin
	 * @param list
	 * @return
	 */
	public static String getZdyMessageXml(WeixinRequest weixin,List<DBObject> list,ComMain commain,boolean b) {
		StringBuffer resultXml=new StringBuffer();
		Date dt = new Date();
		
		resultXml.append("<xml> <ToUserName><![CDATA[")
		.append(weixin.getFromUser()).append("]]></ToUserName> <FromUserName><![CDATA[")
		.append(weixin.getToUser()).append("]]></FromUserName> <CreateTime>").append(dt.getTime())
		.append("</CreateTime> <MsgType><![CDATA[news]]></MsgType>")
		.append("<ArticleCount>").append(list.size()).append("</ArticleCount><Articles> ");
		 
		for(int i=0;i<list.size();i++){
			DBObject zdy=list.get(i);
			resultXml.append("<item><Title><![CDATA[").append(zdy.get("title").toString()).append("]]></Title> ");
			
			resultXml.append("<Description><![CDATA[]]></Description>");
			resultXml.append(" <PicUrl><![CDATA[").append(getOsshttp()).append(zdy.get("picurl").toString()).append("]]></PicUrl>");
			if(zdy.get("url").toString().indexOf(SysConfig.getProperty("ip"))>=0){
				System.out.println(">0");
				resultXml.append("<Url><![CDATA[").append(WeiXinUtil.getBdUrl(commain,weixin.getFromUser(),zdy.get("url").toString(),b)).append("]]></Url></item>");
			}else{
				resultXml.append("<Url><![CDATA[").append(zdy.get("url").toString()).append("]]></Url></item>");
			}
													
		}
		
		resultXml.append("</Articles></xml>");	
		return resultXml.toString();
	}
	/**
	 * //搜索商家
	 * @param weixin
	 * @param list
	 * @return
	 */
	public static String getSSCompanyXml(WeixinRequest weixin,List<DBObject> list,ComMain commain,boolean b,DBObject weldb) {
		StringBuffer resultXml=new StringBuffer();
		Date dt = new Date();
		int size=list.size();
		if(weldb!=null){
			size=size+1;
		}
		resultXml.append("<xml> <ToUserName><![CDATA[")
		.append(weixin.getFromUser()).append("]]></ToUserName> <FromUserName><![CDATA[")
		.append(weixin.getToUser()).append("]]></FromUserName> <CreateTime>").append(dt.getTime())
		.append("</CreateTime> <MsgType><![CDATA[news]]></MsgType>")
		.append("<ArticleCount>").append(size).append("</ArticleCount><Articles> ");
		
		
		if(weldb!=null){
			resultXml.append("<item><Title><![CDATA[").append(weldb.get("newtitle").toString()).append("]]></Title> ");
			resultXml.append("<Description><![CDATA[]]></Description>");
			
			
			resultXml.append(" <PicUrl><![CDATA[").append(getOsshttp()).append(weldb.get("picurl").toString()).append("]]></PicUrl>");
			if(weldb.get("url")==null||weldb.get("url").toString().equals("link")){
				resultXml.append("<Url><![CDATA[").append(WeiXinUtil.getBdUrl(commain,weixin.getFromUser(),weldb.get("context").toString(),b)).append("]]></Url></item>");
			}else{
				resultXml.append("<Url><![CDATA[").append(WeiXinUtil.getBdUrl(commain,weixin.getFromUser(),SysConfig.getProperty("ip")+"/wwz/wwz!"+weldb.get("url").toString()+"&toUser="+weixin.getToUser()+"&fromUser=fromUserData",b)).append("]]></Url></item>");
			}
			
		}
		
		for(int i=0;i<list.size();i++){
			DBObject company=list.get(i);
			resultXml.append("<item><Title><![CDATA[").append(company.get("name").toString()).append("]]></Title> ");
			
			resultXml.append("<Description><![CDATA[]]></Description>");
			
			resultXml.append(" <PicUrl><![CDATA[").append(getOsshttp()).append(company.get("logo").toString()).append("]]></PicUrl>");						
			if(company.get("toUserid")==null||company.get("toUserid").toString().length()==0){
				resultXml.append("<Url><![CDATA[").append(WeiXinUtil.getBdUrl(commain,weixin.getFromUser(),SysConfig.getProperty("ip")+"/wwz/wwz!companydetail.action?_id="+list.get(i).get("_id").toString()+"&toUser="+weixin.getToUser()+"&fromUser=fromUserData",b)).append("]]></Url></item>");
				//resultXml.append("<Url><![CDATA[").append(SysConfig.getProperty("ip")).append("/wwz/wwz!companydetail").append(".action?_id=").append(company.get("_id").toString()).append("&toUser=").append(weixin.getToUser()).append("&fromUser=fromUserData]]></Url></item>");						
				
			}else{
				resultXml.append("<Url><![CDATA[").append(company.get("toUserid").toString()).append("]]></Url></item>");
			}
			
		}
		
		resultXml.append("</Articles></xml>");	
		return resultXml.toString();
	}
	/**
	 * //自定义回复
	 * @param weixin
	 * @param list
	 * @return
	 */
	public static String getCompanyXml(WeixinRequest weixin,List<DBObject> list,ComMain commain,boolean b) {
		StringBuffer resultXml=new StringBuffer();
		Date dt = new Date();
		
		resultXml.append("<xml> <ToUserName><![CDATA[")
		.append(weixin.getFromUser()).append("]]></ToUserName> <FromUserName><![CDATA[")
		.append(weixin.getToUser()).append("]]></FromUserName> <CreateTime>").append(dt.getTime())
		.append("</CreateTime> <MsgType><![CDATA[news]]></MsgType>")
		.append("<ArticleCount>").append(list.size()).append("</ArticleCount><Articles> ");
		
		for(int i=0;i<list.size();i++){
			CompanyInfo company=(CompanyInfo)UniObject.DBObjectToObject(list.get(i),CompanyInfo.class);
			resultXml.append("<item><Title><![CDATA[").append(company.getName()).append("]]></Title> ");
			if(list.size()==1){
				resultXml.append("<Description><![CDATA[").append(company.getSummary()).append("]]></Description>");
			}
			else {
				resultXml.append("<Description><![CDATA[]]></Description>");
			}
			resultXml.append(" <PicUrl><![CDATA[").append(getOsshttp()).append(company.getPicurl()).append("]]></PicUrl>");	
			if(StringUtils.isEmpty(company.getUrl())){
				resultXml.append("<Url><![CDATA[").append(WeiXinUtil.getBdUrl(commain,weixin.getFromUser(),SysConfig.getProperty("ip")+"/wwz/wwz!companydetail.action?_id="+list.get(i).get("_id").toString()+"&toUser="+weixin.getToUser()+"&fromUser=fromUserData",b)).append("]]></Url></item>");
				//resultXml.append("<Url><![CDATA[").append(SysConfig.getProperty("ip")).append("/wwz/wwz!companydetail").append(".action?_id=").append(list.get(i).get("_id").toString()).append("&toUser=").append(weixin.getToUser()).append("&fromUser=fromUserData]]></Url></item>");									
			}else{
				resultXml.append("<Url><![CDATA[").append(company.getUrl()).append("]]></Url></item>");							
			}
		}
		
		resultXml.append("</Articles></xml>");	
		return resultXml.toString();
	}
	/**
	 * //自定义回复
	 * @param weixin
	 * @param list
	 * @return
	 */
	public static String getDkfXml(WeixinRequest weixin) {
		StringBuffer resultXml=new StringBuffer();
		Date dt = new Date();
		
		//跳转到多客服
		resultXml.append("<xml><ToUserName><![CDATA[").append(weixin.getFromUser()).append("]]></ToUserName>")
		.append("<FromUserName><![CDATA[").append(weixin.getToUser()).append("]]></FromUserName>")
		.append("<CreateTime>").append(dt.getTime()).append("</CreateTime>")
		.append("<MsgType><![CDATA[transfer_customer_service]]></MsgType></xml>");
		return resultXml.toString();
	}
	/**
	 * 获取绑定地址
	 * @param commain
	 * @param fromUser
	 * @param url
	 * @param b
	 * @return
	 */
	public static String getBdUrl(ComMain commain,String fromUser,String url,boolean b){
	
		if(commain==null){
			return url+"&fromUser="+fromUser;
		}
		if(b){
			WxToken token=GetAllFunc.wxtoken.get(commain.getToUser());
			url=url.replace("&fromUser=fromUserData", "");
			String  reurl="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(SysConfig.getProperty("ip")+"/wwz/wwz!bd.action?toUser="+token.getToUser()+"&comUser="+fromUser+"&method="+URLEncoder.encode(url))+"&response_type=code&scope=snsapi_base&state=123#wechat_redirect";
			
			return reurl;
		}else{
			return url;
		}
		
	}
	/**
	 * 图文分析数据接口
	 * @param commain
	 * @param fromUser
	 * @param url
	 * @param b
	 * @return
	 */
	public static String getArticletotal(String access_token){
	
		String  reurl="https://api.weixin.qq.com/datacube/getarticletotal?access_token="+access_token;
		Map<String,String> map1 = new HashMap<String,String>();
		
		map1.put("begin_date", "2015-10-29");
		map1.put("end_date", "2015-10-29");
		
		String json = JSONArray.fromObject(map1).toString();
		json=json.substring(1, json.length()-1);
		String re=HttpClient.http(reurl, json);
	
		return "aa";	
		
	}
	/**
	 * 获取素材列表
	 * @param commain
	 * @param fromUser
	 * @param url
	 * @param b
	 * @return
	 */
	public static com.alibaba.fastjson.JSONArray getNews(String access_token,String offset,String count){
	
		String  reurl="https://api.weixin.qq.com/cgi-bin/material/batchget_material?access_token="+access_token;
		Map<String,String> map1 = new HashMap<String,String>();
		
		map1.put("type", "news");
		map1.put("offset", offset);
		map1.put("count", count);
		String json = JSONArray.fromObject(map1).toString();
		json=json.substring(1, json.length()-1);
		String re=HttpClient.http(reurl, json);
		JSONObject obj =(JSONObject) JSON.parse(re);
		
		com.alibaba.fastjson.JSONArray item =obj.getJSONArray("item");
	
		return item;	
		
	}
	/**
	 * 获取素材列表
	 * @param commain
	 * @param fromUser
	 * @param url
	 * @param b
	 * @return
	 */
	public static String getImage(String access_token,String media_id){
	
		String  reurl="https://api.weixin.qq.com/cgi-bin/material/get_material?access_token="+access_token;
		Map<String,String> map1 = new HashMap<String,String>();
		
		map1.put("media_id", media_id);
		
		String json = JSONArray.fromObject(map1).toString();
		json=json.substring(1, json.length()-1);
		
		
		URL u = null;
		HttpURLConnection con = null;

		try {
			u = new URL(reurl);
			
				// TODO Auto-generated catch block
				
			
				con = (HttpURLConnection) u.openConnection();
			
			con.setRequestMethod("POST");
			con.setConnectTimeout(30000);
			con.setReadTimeout(30000);
			con.setDoOutput(true);
			con.setDoInput(true);
			con.setUseCaches(false);
			con.setRequestProperty("Content-Type",
					"application/x-www-form-urlencoded");
			OutputStreamWriter osw = new OutputStreamWriter(
					con.getOutputStream(), "UTF-8");
			
			osw.write(json);
			osw.flush();
			osw.close();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		
		} finally {
			if (con != null) {
				con.disconnect();
			}
		}
		
		// 璇诲彇杩斿洖鍐呭
		
		try {
		
			 BufferedInputStream bis = new BufferedInputStream(con.getInputStream());
			
			 FileOutputStream fos = new FileOutputStream(SysConfig.getProperty("filePath")+"/uploads/wx/"+media_id+".jpg");
		      byte[] buf = new byte[8096];
		      int size = 0;
		      while ((size = bis.read(buf)) != -1)
		        fos.write(buf, 0, size);
		      fos.close();
		      bis.close();
		      
		     
		} catch (Exception e) {
			
		}
		return SysConfig.getProperty("ip")+"/uploads/wx/"+media_id+".jpg";	
		
	}
	 
}
