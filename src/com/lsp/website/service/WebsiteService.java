package com.lsp.website.service;

 
import java.util.HashMap;
import java.util.List;

 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

 
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.UniObject;
import com.lsp.user.entity.UserInfo;
import com.lsp.website.entity.Readinginfo;
import com.lsp.website.entity.WebsiteFlowInfo;
import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
 
@Component
@Transactional
public class WebsiteService {
	 
		@Autowired
		private BaseDao baseDao;
		 
		/**
		 * 网站流量
		 * @param toUser
		 * @param type
		 */
		public int flow(String toUser,String type){
			DBObject wwz=baseDao.getMessage(PubConstants.WEBSITEFLOW_INFO, toUser+type);
			int count=1;
			if(wwz!=null){
				count=Integer.parseInt(wwz.get("count").toString())+1;
			}
			WebsiteFlowInfo flow=new WebsiteFlowInfo();
			flow.set_id(toUser+type);
			flow.setToUser(toUser);
			flow.setType(type);
			flow.setCount(count);
			baseDao.insert(PubConstants.WEBSITEFLOW_INFO, flow);
			return count;
		}
		/**
		 * 获取模块流量
		 * @param toUser
		 * @param type
		 */
		public int getFlow(String toUser,String type){
			DBObject wwz=baseDao.getMessage(PubConstants.WEBSITEFLOW_INFO, toUser+type);
			int count=1;
			if(wwz!=null){
				count=Integer.parseInt(wwz.get("count").toString());
			}
			return count;
		}
		/**
		 * 广告位显示
		 * @param toUser
		 * @param type
		 */
		public List<DBObject> advertisement(String toUser,String type){
			HashMap<String, Object> sortMap =new HashMap<String, Object>();
			HashMap<String, Object> whereMap =new HashMap<String, Object>();
			whereMap.put("toUser", toUser);
			
			whereMap.put("type", type);
				
			sortMap.put("sort", 1);
			List<DBObject> list=baseDao.getList(PubConstants.ADVERT_INFO,whereMap, sortMap);
			
			return list;
		}
		/**
		 * 广告位显示
		 * @param toUser
		 * @param type
		 */
		public List<DBObject> advertising(String toUser,String type){
			HashMap<String, Object> sortMap =new HashMap<String, Object>();
			HashMap<String, Object> whereMap =new HashMap<String, Object>();
			whereMap.put("toUser", toUser);
			
			whereMap.put("type", type);
				
			sortMap.put("sort", 1);
			List<DBObject> list=baseDao.getList(PubConstants.ADVERTISEMENT,whereMap, sortMap);
			
			return list;
		}
		/**
		 * 广告位显示
		 * @param toUser
		 * @param type
		 */
		public List<DBObject> slide(String toUser,String type){
			HashMap<String, Object> sortMap =new HashMap<String, Object>();
			HashMap<String, Object> whereMap =new HashMap<String, Object>();
			whereMap.put("toUser", toUser);
			
			whereMap.put("type", type);
				
			sortMap.put("sort", 1);
			List<DBObject> list=baseDao.getList(PubConstants.SUC_SLIDE,whereMap, sortMap);
			
			return list;
		}
		/**
		 * 广告位显示
		 * @param toUser
		 * @param type
		 */
		public List<DBObject> noadvertisement(String toUser,String type){
			HashMap<String, Object> sortMap =new HashMap<String, Object>();
			HashMap<String, Object> whereMap =new HashMap<String, Object>();
			whereMap.put("toUser", toUser);
			
			whereMap.put("type", type);
				
			sortMap.put("sort", 1);
			List<DBObject> list=baseDao.getList(PubConstants.ADVERT_INFO,whereMap, sortMap);
			
			return list;
		}
		/**
		 *滚动显示
		 * @param toUser
		 * @param type
		 */
		public List<DBObject> roll(String toUser,String type){
			HashMap<String, Object> sortMap =new HashMap<String, Object>();
			HashMap<String, Object> whereMap =new HashMap<String, Object>();
			whereMap.put("toUser", toUser);
			
			whereMap.put("type", type);
				
			sortMap.put("sort", 1);
			List<DBObject> list=baseDao.getList(PubConstants.ADVERT_INFO,whereMap, sortMap);
			
			return list;
		}
		/**
		 * 广告位显示
		 * @param toUser
		 * @param type
		 */
		public List<DBObject> advertisement(String toUser,String type,int num){
			HashMap<String, Object> sortMap =new HashMap<String, Object>();
			HashMap<String, Object> whereMap =new HashMap<String, Object>();
			whereMap.put("toUser", toUser);
			
			whereMap.put("type", type);
				
			sortMap.put("sort", 1);
			List<DBObject> list=baseDao.getList(PubConstants.ADVERT_INFO,whereMap,0,num, sortMap);
			if(list.size()==0){
				whereMap.clear();
				whereMap.put("toUser", null);
				list=baseDao.getList(PubConstants.ADVERT_INFO,whereMap, sortMap);
			}
			return list;
		}
//		/**
//		 * 获取分享说明
//		 * @param toUser
//		 * @param type
//		 */
//		public DBObject getShareFx(String toUser,WxToken token,String type){
//			
//			DBObject fx=baseDao.getMessage(PubConstants.WEIXIN_SHAREFX, toUser+"-"+type);
//			if(fx==null){
//				fx=new BasicDBObject();
//				DBObject userdb=baseDao.getMessage(PubConstants.DATA_WXTOUSER, toUser);
//				if(userdb==null){
//					fx.put("fxtitle", "");
//					fx.put("fxsummary", "");
//					fx.put("fximg", "");
//					if(token!=null){
//						fx.put("fxurl", token.getUrl());
//					}
//					
//					return fx;
//				}
//				if(userdb.get("title")==null){
//					fx.put("fxtitle","");
//				}else{
//					fx.put("fxtitle", userdb.get("title"));
//				}
//				if(userdb.get("summary")==null){
//					fx.put("fxsummary","");
//				}else{
//					fx.put("fxsummary", userdb.get("summary"));
//				}
//				if(userdb.get("bj3")==null){
//					fx.put("fximg","");
//				}else{
//					fx.put("fximg", userdb.get("bj3"));
//				}
//				
//				if(token!=null){
//					fx.put("fxurl", token.getUrl());
//				}
//				return fx;
//			}
//			if(fx.get("fxurl")==null||StringUtils.isEmpty(fx.get("fxurl").toString())){
//				if(token==null||token.getUrl()==null){
//					fx.put("fxurl", "");
//				}else{
//					fx.put("fxurl", token.getUrl());
//				}
//				
//			}
//			if(fx.get("fxtitle")==null){
//				fx.put("fxtitle", "");
//				
//			}
//			return fx;
//		
//		}
		/**
		 * 获取用户昵称
		 * @param toUser
		 * @param type
		 */
		public String getUserName(String fromUser){
			DBObject db = baseDao.getMessage(PubConstants.USER_INFO, fromUser);
			String name="游客";
			if (db != null && db.get("nickname") != null) {
				name=db.get("nickname").toString();
			}
			return name;
		}
		/**
		 * 获取是否管理员
		 * @param toUser
		 * @param type
		 */
		public boolean isAdmin(String fromUser,String wid){
			boolean re=false;
			DBObject user=baseDao.getMessage(PubConstants.USER_INFO, fromUser);
			if(user.get("toUser")!=null){
				re=true;
			}
			 
			return re;
		}
		
		/**
		 * 获取是否管理员
		 * @param toUser
		 * @param type
		 */
		public boolean getComUser(String fromUser,String toUser,String url){
			
//			HashMap<String, Object> whereMap =new HashMap<String, Object>();
//			UserInfo commain=GetAllFunc.comToUser.get(toUser);
//			if(commain==null){//主账号
//				return false;
//			}
//			whereMap.put("comUser", fromUser);
//			whereMap.put("toUser", toUser);
//			if(baseDao.getCount(PubConstants.USER_INFO, whereMap)>0){
//				return false;
//			}
//			WxToUser wxtoUser=GetAllFunc.wxTouser.get(toUser);
//			if(wxtoUser.getZhlx()!=2){
//				return false;
//			}
//			String dlurl=SysConfig.getProperty("ip")+"/wwz/wwz!combd.action?fromUser="+fromUser+"&toUser="+toUser+"&method="+URLEncoder.encode(url);
//			String tzurl="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+wxtoUser.getAppid()+"&redirect_uri="+URLEncoder.encode(dlurl)+"&response_type=code&scope=snsapi_base&state=123#wechat_redirect";
//			Struts2Utils.getRequest().setAttribute("method", tzurl);
			return true;
		}
		/**
		 * 检测会员
		 * @return
		 */
		public  String  getFromUser(String toUser,String fromUser){
			 
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			
			whereMap.put("toUser", toUser);
			whereMap.put("fromUser",fromUser);
			DBObject db=baseDao.getMessage(PubConstants.CUSTOMER_INFO, whereMap);
			if(db!=null){
				return db.get("fromUser").toString();
			}
			return null;
		 
		}
		
		 
        public  void  getComment(){
			
		}
        public  Long  getReading(String toUser,String wid,String type){
        	String id=toUser+wid+type;
        	
    		DBObject  db=baseDao.getMessage(PubConstants.READING_INFO, id);
    		if(db!=null){
    			Readinginfo readinginfo=(Readinginfo) UniObject.DBObjectToObject(db, Readinginfo.class);
    			if(readinginfo.getCount()==null){
    				readinginfo.setCount(1L);
    			}
    			readinginfo.setCount(readinginfo.getCount()+1);
    			baseDao.insert(PubConstants.READING_INFO, readinginfo);
    			return readinginfo.getCount();
    		}else{
    			Readinginfo readinginfo=new Readinginfo(); 
    			readinginfo.setCount(1L);
    			readinginfo.set_id(id);
    			baseDao.insert(PubConstants.READING_INFO, readinginfo);
    			return readinginfo.getCount();
    		}
    		
			
		}
		
}
