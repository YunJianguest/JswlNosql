package com.lsp.sys.security;

import com.alibaba.fastjson.JSON;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.entity.FuncInfo;
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.entity.WxToken;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.UniObject;
import com.lsp.suc.entity.WxFunc;
import com.lsp.suc.entity.Comunit;
import com.lsp.weixin.entity.WxPayConfig;
import com.mongodb.DBObject;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
/***
 * 资源管理
 * @author lsp
 *
 */
@Transactional(readOnly=true)
public class ResourceDetailsServiceImpl  implements ResourceDetailsService{

  @Autowired
  private BaseDao baseDao;

  public LinkedHashMap<String, String> getRequestMap()
  {
	  HashMap<String, Object> funcsortMap =new HashMap<String, Object>();
	  funcsortMap.put("sort", 1);
	  List<DBObject> funcinfo=baseDao.getList(PubConstants.FUNC_INFO,null, funcsortMap);
	  List<FuncInfo> resourceList = new ArrayList<FuncInfo>();
		for(int i=0;i<funcinfo.size();i++){
			FuncInfo func=new FuncInfo();
			func=JSON.parseObject(funcinfo.get(i).toString(), FuncInfo.class);
			func.set_id((Long)funcinfo.get(i).get("_id"));
			resourceList.add(func);
		}

    ResourceScope.ALL_RESOURCE_LIST = resourceList;

    HashMap<String, Object> whereMap =new HashMap<String, Object>();
	LinkedHashMap<String, String> requestMap = new LinkedHashMap<String, String>(resourceList.size());
    for (FuncInfo resource : resourceList) {
    	//初始化加载一级菜单
      requestMap.put(resource.getUrl(), resource.getAuthName()); 
      if (resource.getParentid().longValue() == 0L) {
        whereMap.clear();
        whereMap.put("parentid", (Long)resource.get_id());
        List<FuncInfo> wfuncList=new ArrayList<FuncInfo>();
		List<DBObject> funcinfo2= baseDao.getList(PubConstants.FUNC_INFO,whereMap, funcsortMap);
        for (int i = 0; i < funcinfo2.size(); i++) {
          FuncInfo func = (FuncInfo)UniObject.DBObjectToObject((DBObject)funcinfo2.get(i), FuncInfo.class);

          func.set_id((Long)((DBObject)funcinfo2.get(i)).get("_id"));
          wfuncList.add(func);
        }
        resource.setTfunc(wfuncList);
        GetAllFunc.setGetAllFunc(resource);
      }
    }
   String toUser = "";
    whereMap.clear();

    whereMap.put("method", "wxnewscommon");
    List<DBObject> hylist = this.baseDao.getList(PubConstants.WHD_WXFUNCTION, whereMap, null);
    for (int i = 0; i < hylist.size(); i++) {
      DBObject func = (DBObject)hylist.get(i);
      if (func.get("type") != null) {
        GetAllFunc.wxmenu.put(func.get("toUser").toString() + func.get("type").toString(), func);
        if (func.get("mb") != null) {
          GetAllFunc.wxMb.put(func.get("toUser").toString() + func.get("type").toString(), Integer.valueOf(Integer.parseInt(func.get("mb").toString())));
        }
      }

    }
    
   //初始化微网站
    HashMap<String, Object> sortMap =new HashMap<String, Object>();
	sortMap.put("sort", 1);
	List<DBObject> wxtouserlist=baseDao.getList(PubConstants.DATA_WXTOUSER,null, null);
	List<DBObject> wxtokenlist=baseDao.getList(PubConstants.WEIXIN_TOKEN,null, null);
	for (DBObject dbObject : wxtokenlist) {
		WxToken wxtoken=(WxToken)UniObject.DBObjectToObject(dbObject,WxToken.class);
		GetAllFunc.wxtoken.put(wxtoken.get_id().toString(),wxtoken);
	}
	List<DBObject> wxpaylist=baseDao.getList(PubConstants.WEIXIN_PAYCONFIG,null, null);
	for (DBObject dbObject : wxpaylist) {
		WxPayConfig wxpay=(WxPayConfig)UniObject.DBObjectToObject(dbObject,WxPayConfig.class);
		GetAllFunc.wxPay.put(wxpay.get_id().toString(),wxpay);
	}
	for(int i=0;i<wxtouserlist.size();i++){
		Comunit wxToUser=(Comunit)UniObject.DBObjectToObject(wxtouserlist.get(i),Comunit.class);
		wxToUser.set_id(wxtouserlist.get(i).get("_id").toString());
		String custid=wxtouserlist.get(i).get("_id").toString(); 
		whereMap.clear();
		whereMap.put("custid", custid);
		sortMap.put("sort", 1);
		
		List<DBObject> footlist=baseDao.getList(PubConstants.WX_FOOTFUNCTION,whereMap, sortMap);
		GetAllFunc.footFunc.put(custid, footlist);
		List<DBObject> list=baseDao.getList(PubConstants.DATA_WXFUNCTION,whereMap,sortMap);
		for(int j=0;j<list.size();j++){
			WxFunc func=(WxFunc)UniObject.DBObjectToObject(list.get(j),WxFunc.class);
			GetAllFunc.wxtitle.put(custid+func.getKey(), func.getName());
			GetAllFunc.wxmenu.put(custid+func.getKey(), list.get(j));
			GetAllFunc.wxMb.put(custid+func.getKey(), func.getMb());
		}
		for(int j=0;j<footlist.size();j++){
			WxFunc func=(WxFunc)UniObject.DBObjectToObject(footlist.get(j),WxFunc.class);
			GetAllFunc.wxtitle.put(custid+func.getKey(), func.getName());
			GetAllFunc.wxmenu.put(custid+func.getKey(), footlist.get(j));
			GetAllFunc.wxMb.put(custid+func.getKey(), func.getMb());
		}
		whereMap.put("value", "wxnewscommon");
		List<DBObject> secondlist=baseDao.getList(PubConstants.WX_FUNCSECOND,whereMap, sortMap);
		for(int j=0;j<secondlist.size();j++){
			WxFunc func=(WxFunc)UniObject.DBObjectToObject(secondlist.get(j),WxFunc.class);
			GetAllFunc.wxtitle.put(custid+func.getKey(), func.getName());
			GetAllFunc.wxmenu.put(custid+func.getKey(), secondlist.get(j));
			GetAllFunc.wxMb.put(custid+func.getKey(), func.getMb());
		}
		GetAllFunc.wxFunc.put(custid, list);
		GetAllFunc.wxTouser.put(custid, wxToUser);
		/**if(wxToUser.getQx()==1){
			DBObject pay=baseDao.getMessage(PubConstants.WEIXIN_PAYCONFIG, custid);
			if(pay!=null){
				WxPayConfig wxpay=(WxPayConfig)UniObject.DBObjectToObject(pay,WxPayConfig.class);
				wxpay.set_id(custid);
				//GetAllFunc.wxPay.put(custid, wxpay);
			}
		}
		if(wxToUser.getSecret()==null||StringUtils.isEmpty(wxToUser.getSecret())){
		}else{
			WxToken token=new WxToken();
			token.set_id(toUser);
			token.setAppid(wxToUser.getAppid());
			token.setSecret(wxToUser.getSecret());
			token.setExpires_in(0);
			token.setToUser(toUser);
			token.setZhlx(wxToUser.getZhlx());
			//GetAllFunc.wxtoken.put(toUser, token);
		}*/
		whereMap.clear(); 
		whereMap.put("custid", custid);
		List<DBObject> wzmenu=baseDao.getList(PubConstants.WZ_WEBMENU, whereMap, sortMap);
		if(wzmenu.size()>0){
			GetAllFunc.wzMenu.put(custid, wzmenu);
		}
		 
		//DBObject   wxpay=baseDao.getMessage(PubConstants.WEIXIN_PAYCONFIG, wxtouserlist.get(i).get("_id").toString());
		//if(wxpay!=null){
		//	WxPayConfig cif=(WxPayConfig) UniObject.DBObjectToObject(wxpay, WxPayConfig.class);
		//	GetAllFunc.wxPay.put(wxtouserlist.get(i).get("toUser").toString(), cif);
		//}
		
	
	}
	
	
	
	sortMap.clear();//首页滚动消息
	whereMap.clear();
	HashMap<String, Object> backMap = new HashMap<String, Object>();
	sortMap.put("insdate", -1);
	backMap.put("context", 0);
	whereMap.put("state", 1);
	List<DBObject> list = baseDao.getList(PubConstants.NEW_ROLL,whereMap,0,5, sortMap,backMap);
	GetAllFunc.wzScroll.put("scroll", list);

    requestMap.put("/index.action", "ROLE_0");

    return requestMap;
  }
}