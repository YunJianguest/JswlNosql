package com.lsp.pub.entity;  
import com.lsp.shop.entity.ComMain;
import com.lsp.suc.entity.Comunit;
import com.lsp.user.entity.CustomerInfo;
import com.lsp.user.entity.UserInfo;
import com.lsp.weixin.entity.WxPayConfig;
import com.lsp.weixin.entity.WxUserToken;
import com.mongodb.DBObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
/**
 * 总集合
 * @author lsp
 *
 */
public class GetAllFunc {
	public static List<FuncInfo> getAllFunc = new ArrayList<FuncInfo>();

	public static List<FuncInfo> getGetAllFunc() {
		return getAllFunc;
	}

	public static void setGetAllFunc(FuncInfo linkInfo) {
		getAllFunc.add(linkInfo);
	}

	public static HashMap<String, List<DBObject>> wxFunc = new HashMap<String, List<DBObject>>();
	public static HashMap<String, List<DBObject>> footFunc = new HashMap<String, List<DBObject>>(); 
	public static HashMap<String, String> wxfunc = new HashMap<String, String>();
	public static HashMap<String, DBObject> wxmenu = new HashMap<String, DBObject>();
	public static HashMap<String, Integer> wxMb = new HashMap<String, Integer>();
	public static HashMap<String, CustomerInfo> cust = new HashMap<String, CustomerInfo>();
	public static HashMap<String, UserInfo> user = new HashMap<String, UserInfo>();  
	public static HashMap<String, Comunit> wxTouser = new HashMap<String, Comunit>(); 
	public static HashMap<String, ComMain> comToUser = new HashMap<String, ComMain>();
	public static HashMap<String, String> wxtitle = new HashMap<String, String>();
	public static HashMap<String, WxToken> wxtoken = new HashMap<String, WxToken>();
	public static HashMap<String, WxUserToken> usertoken = new HashMap<String, WxUserToken>();
	public static HashMap<String, List<DBObject>> wzMenu = new HashMap<String, List<DBObject>>();
	public static HashMap<String, List<DBObject>> wzScroll = new HashMap<String, List<DBObject>>();
	public static Set<String> wordSet=new HashSet<String>();
	public static HashMap<String, WxPayConfig> wxPay = new HashMap<String, WxPayConfig>();
	//店铺客服
	public static HashMap<String,List<DBObject>>shopCustService= new HashMap<String,List<DBObject>>();
	//店铺客服
	public static HashMap<String,Object>shopCustServicenum= new HashMap<String,Object>();
	//婚恋客服
	public static HashMap<String,List<DBObject>>datingCustServicenum= new HashMap<String,List<DBObject>>();
	 
	//电话验证码
	public static HashMap<String, Code>telcode = new HashMap<String, Code>();
	

}