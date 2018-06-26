package com.lsp.pub.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
 

import com.lsp.pub.db.MongoDbUtil;
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.PubConstants;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
 
/**
 * 工具
 * @author lsp 
 *   
 */
public class MarkerHtml {
	
	 
	/**
	 * 生成地区分类
	 * @param _id
	 * @param mbname
	 * @throws Exception
	 */
	public void area(String toUser) throws Exception{
		MongoDbUtil mongo = new MongoDbUtil();
		
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		whereMap.put("toUser", toUser);
		whereMap.put("parentid", 0L);
		sortMap.put("sort", 1);
		List<DBObject> areaList = mongo.queryAll(PubConstants.SHOP_AREATYPE,whereMap, sortMap).toArray();
		List<DBObject> reAreaList = new ArrayList<DBObject>();
		for(int i=0;i<areaList.size();i++){
			DBObject area=areaList.get(i);
			whereMap.clear();
			whereMap.put("toUser", toUser);
			whereMap.put("parentid", Long.parseLong(area.get("_id").toString()));
			List<DBObject> comList = mongo.queryAll(PubConstants.SHOP_AREATYPE,whereMap, sortMap).toArray();
			area.put("area", comList);

			reAreaList.add(area);
			
		}
		Map<String, Object> root = new HashMap<String, Object>();  
		root.put("areaList", reAreaList);
		root.put("toUser", toUser);
		root.put("ip", SysConfig.getProperty("ip"));
		
		FreeMarkertUtil fm = new FreeMarkertUtil();  
		String htmlFile="/marker/area/";
		fm.showCourse( "/marker/ftl/area.ftl", root, htmlFile,"area"+toUser+".html");  
		mongo.close();
	}
	/**
	 * 生成字典选择
	 * @param _id
	 * @param mbname
	 * @throws Exception
	 */
	public void citymarker() throws Exception{
		MongoDbUtil mongo = new MongoDbUtil();
		
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		whereMap.put("cj", 2);

		sortMap.put("sort", 1);
		Map<String, Object> root = new HashMap<String, Object>();  
		
		
		String[] zm={"A","B","C","D","E","F","G","H","J","K","L","M","N","P","Q","R","S","T","W","X","Y","Z"};
		List<DBObject> jcdictList = new ArrayList<DBObject>();
		for(int i=0;i<zm.length;i++){
			whereMap.put("jc", zm[i]);
				
			List<DBObject> dictList = mongo.queryAll(PubConstants.SET_PRODICT,whereMap, sortMap).toArray();
			if(dictList.size()>0){
				DBObject area=new BasicDBObject();
				area.put("zm", zm[i]);
				area.put("area", dictList);
				jcdictList.add(area);
			}
		}
		root.put("jcdictList", jcdictList);
	
		root.put("ip", SysConfig.getProperty("ip"));
		
		FreeMarkertUtil fm = new FreeMarkertUtil();  
		String htmlFile="/marker/set/";
		fm.showCourse( "/marker/ftl/citydict.ftl", root, htmlFile,"citydict.html"); 
		 
		mongo.close();
	} 
	 
	/**
	 * 生成字典选择
	 * @param _id
	 * @param mbname
	 * @throws Exception
	 */
	public void promarker() throws Exception{
		MongoDbUtil mongo = new MongoDbUtil();
		
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		whereMap.put("cj", 1);

		sortMap.put("sort", 1);
		Map<String, Object> root = new HashMap<String, Object>();  	
		
		String[] zm={"A","B","C","D","E","F","G","H","J","K","L","M","N","P","Q","R","S","T","W","X","Y","Z"};
		List<DBObject> jcdictList = new ArrayList<DBObject>();
		for(int i=0;i<zm.length;i++){
			whereMap.put("zm", zm[i]);
				
			List<DBObject> dictList = mongo.queryAll(PubConstants.SET_PRODICT,whereMap, sortMap).toArray();
			if(dictList.size()>0){
				DBObject area=new BasicDBObject();
				area.put("zm", zm[i]);
				area.put("area", dictList);
				jcdictList.add(area);
			}
		}
		root.put("jcdictList", jcdictList);
		root.put("ip", SysConfig.getProperty("ip"));
		
		FreeMarkertUtil fm = new FreeMarkertUtil();  
		String htmlFile="/marker/set/";
		fm.showCourse( "/marker/ftl/prodict.ftl", root, htmlFile,"prodict.html"); 
		mongo.close();
		
	}
	 
	/**
	 * 生成公司html
	 * @param _id
	 * @throws Exception
	 */
	public void logisword(List<DBObject> list,String name) throws Exception{
		
		Map<String, Object> root = new HashMap<String, Object>();  
		
		root.put("logisList", list);
		
		FreeMarkertUtil fm = new FreeMarkertUtil();  
		String htmlFile="/marker/ht/";
		fm.showCourse( "/marker/ftl/logis.ftl", root, htmlFile,name+".doc");  
		
	}
	/**
	 * 生成字典选择
	 * @param _id
	 * @param mbname
	 * @throws Exception
	 */
	public void parentdict(String toUser,int type) throws Exception{
		MongoDbUtil mongo = new MongoDbUtil();
		
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		whereMap.put("type", type);
		if(type==4||type==18||type==2||type==7||type==20||type==21){
			
		}else{
			whereMap.put("toUser", toUser);
		}
		
		sortMap.put("sort", 1);
		Map<String, Object> root = new HashMap<String, Object>();  
		
		
		List<DBObject> dictList = mongo.queryAll(PubConstants.SET_DICT,whereMap, sortMap).toArray();
		root.put("jcdictList", dictList);
		
		root.put("toUser", toUser);
		root.put("ip", SysConfig.getProperty("ip"));
		root.put("osshttp", SysConfig.getProperty("osshttp"));
		
		FreeMarkertUtil fm = new FreeMarkertUtil();  
		String htmlFile="/marker/set/";
		fm.showCourse( "/marker/ftl/dict"+type+".ftl", root, htmlFile,"dict"+type+".html"); 
		mongo.close();
		
	}
	/**
	 * 生成拼车城市页面
	 * @param _id
	 * @param mbname
	 * @throws Exception
	 */
	public void parentdict1(String toUser) throws Exception{
		MongoDbUtil mongo = new MongoDbUtil();
		
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		whereMap.put("toUser", toUser);
		whereMap.put("type", 1);
		sortMap.put("sort", 1);
		Map<String, Object> root = new HashMap<String, Object>();  
		List<DBObject> rmdictList = mongo.queryAll(PubConstants.SET_DICT,whereMap,0,12, sortMap).toArray();
		root.put("rmdictList", rmdictList);
		String[] zm={"A","B","C","D","E","F","G","H","J","K","L","M","N","P","Q","R","S","T","W","X","Y","Z"};
		List<DBObject> jcdictList = new ArrayList<DBObject>();
		for(int i=0;i<zm.length;i++){
			whereMap.put("jc", zm[i]);
			
			List<DBObject> dictList = mongo.queryAll(PubConstants.SET_DICT,whereMap, sortMap).toArray();
			if(dictList.size()>0){
			DBObject area=new BasicDBObject();
			area.put("zm", zm[i]);
			area.put("area", dictList);
			jcdictList.add(area);
			}
		}
		
		root.put("jcdictList", jcdictList);
		root.put("toUser", toUser);
		root.put("ip", SysConfig.getProperty("ip"));
		
		FreeMarkertUtil fm = new FreeMarkertUtil();  
		String htmlFile="/marker/pingche/";
		fm.showCourse( "/marker/ftl/pcarea1.ftl", root, htmlFile,"pcarea1"+toUser+".html"); 
		 
		fm.showCourse( "/marker/ftl/pcarea2.ftl", root, htmlFile,"pcarea2"+toUser+".html"); 
		mongo.close();
	}
	/**
	 * 生成拼车城市页面
	 * @param _id
	 * @param mbname
	 * @throws Exception
	 */
	public void wzcity() throws Exception{
		MongoDbUtil mongo = new MongoDbUtil();
		
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		sortMap.put("sort", 1);
		Map<String, Object> root = new HashMap<String, Object>();  
		whereMap.put("parentcode", "");
		List<DBObject> cityList = mongo.queryAll(PubConstants.SET_WZCITY,whereMap, sortMap).toArray();
		root.put("wzcityList", cityList);
		
		root.put("ip", SysConfig.getProperty("ip"));
		
		FreeMarkertUtil fm = new FreeMarkertUtil();  
		String htmlFile="/marker/set/";
		fm.showCourse( "/marker/ftl/wzcity.ftl", root, htmlFile,"wzcity.html"); 
		mongo.close();

	}
	/**
	 * 生成地区分类
	 * @param _id
	 * @param mbname
	 * @throws Exception
	 */
	public void register(String toUser) throws Exception{
		MongoDbUtil mongo = new MongoDbUtil();
		
		DBObject content=mongo.findOneById(PubConstants.WX_WXCONTENT, toUser+"_3");
		DBObject aboutus=mongo.findOneById(PubConstants.DATA_ABOUTUS, toUser);
		Map<String, Object> root = new HashMap<String, Object>();  
		root.put("content", content);
		root.put("aboutus", aboutus);
		root.put("toUser", toUser);
		root.put("ip", SysConfig.getProperty("ip"));
		
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		
		whereMap.put("toUser", toUser);
		whereMap.put("parentid", 0L);
		
		List<DBObject> typeList=mongo.queryAll(PubConstants.SHOP_SHOPTYPE, whereMap,null).toArray();
		root.put("typeList", typeList);
		FreeMarkertUtil fm = new FreeMarkertUtil();  
		String htmlFile="/marker/register/";
		fm.showCourse( "/marker/ftl/register.ftl", root, htmlFile,"register"+toUser+".html");  
		mongo.close();
	}
	/**
	 * 生成公司html
	 * @param _id
	 * @throws Exception
	 */
	public void house(Long _id) throws Exception{
		MongoDbUtil mongo = new MongoDbUtil();
		DBObject comdb=mongo.findOneById(PubConstants.WX_COMPANY, _id);
		Map<String, Object> root = new HashMap<String, Object>();  
		String custid=comdb.get("custid").toString();
		HashMap<String, Object> whereMap=new HashMap<String, Object>();
		HashMap<String, Object> sortMap=new HashMap<String, Object>();
		//商品
		whereMap.put("comid", _id);
		List<DBObject> proList=mongo.queryAll(PubConstants.DATA_PRODUCT, whereMap, sortMap).toArray();
		comdb.put("pro", proList);
		comdb.put("_id", comdb.get("_id").toString());
		root.put("company", comdb);
		root.put("productList", proList);
		if(comdb.get("picurl")!=null){
			root.put("picurl",comdb.get("picurl").toString().split(","));
		} 
		System.out.println(slide(custid, "house-"+_id));
		root.put("slide", slide(custid, "house-"+_id));
		root.put("ip", SysConfig.getProperty("ip"));
		if(SysConfig.getProperty("filehttp").endsWith("0")){
			root.put("filehttp", "/");
		}else{ 
			root.put("filehttp", SysConfig.getProperty("filehttp"));
		}
		root.put("custid", custid);
		root.put("logo",GetAllFunc.wxTouser.get(custid).getLogo());
		sortMap.clear();
		sortMap.put("sort", 1);
		whereMap.clear();
		whereMap.put("parentid", _id); 
		List<DBObject> funcList=mongo.queryAll(PubConstants.SUC_HOUSEFUNC,whereMap, sortMap).toArray();
		root.put("funcList", funcList);
		whereMap.clear(); 
		//滚动条
		root.put("rollList",this.roll(custid, "house-"+_id)); 
		FreeMarkertUtil fm = new FreeMarkertUtil();  
		String htmlFile="/marker/house/";
		fm.showCourse( "/marker/ftl/house"+comdb.get("mb").toString()+".ftl", root, htmlFile,"house"+_id+".html");  
	}
	/**
	 * 生成公司html
	 * @param _id
	 * @throws Exception
	 */
	public void company(Long _id) throws Exception{
		MongoDbUtil mongo = new MongoDbUtil();
		DBObject comdb=mongo.findOneById(PubConstants.WX_COMPANY, _id);
		Map<String, Object> root = new HashMap<String, Object>();  
		String toUser=comdb.get("toUser").toString();
		HashMap<String, Object> whereMap=new HashMap<String, Object>();
		HashMap<String, Object> sortMap=new HashMap<String, Object>();
		//商品
		whereMap.put("comid", _id);
		List<DBObject> proList=mongo.queryAll(PubConstants.DATA_PRODUCT, whereMap, sortMap).toArray();
		comdb.put("pro", proList);
		comdb.put("_id", comdb.get("_id").toString());
		root.put("company", comdb);
		root.put("productList", proList);
		if(comdb.get("picurl")!=null){
			root.put("picurl",comdb.get("picurl").toString().split(","));
		}
		root.put("ip", SysConfig.getProperty("ip"));
		if(SysConfig.getProperty("isossup").endsWith("0")){
			root.put("osshttp", "/MyNosql");
		}else{
			root.put("osshttp", SysConfig.getProperty("osshttp"));
		}
		root.put("toUser", toUser);
		root.put("logo",GetAllFunc.wxTouser.get(toUser).getLogo());
		sortMap.clear();
		sortMap.put("sort", 1);
		whereMap.clear();
		whereMap.put("comid", _id);
		whereMap.put("lx", 0);
		List<DBObject> funcList=mongo.queryAll(PubConstants.WHD_WXFUNCTION,whereMap, sortMap).toArray();
		root.put("funcList", funcList);
		whereMap.clear();
		whereMap.put("comid", _id);
		whereMap.put("lx", 1);
		sortMap.put("sort", -1);
		List<DBObject> footList=mongo.queryAll(PubConstants.WHD_WXFUNCTION,whereMap,0,4, sortMap).toArray();
		root.put("footList", footList);
		//滚动条
		root.put("rollList",this.roll(toUser, "com_"+_id));
		//新闻
		sortMap.clear();
		sortMap.put("sort", -1);
		whereMap.clear();
		whereMap.put("comid", _id);
		whereMap.put("type", "news");
		List<DBObject> newsList=mongo.queryAll(PubConstants.DATA_WXNEWS,whereMap,0,5, sortMap).toArray();
		root.put("newsList", newsList);
			
		//二级分类
		whereMap.clear();
		whereMap.put("toUser", toUser);
		if(comdb.get("type")!=null){
			whereMap.put("type", comdb.get("type").toString());
		}else{
			whereMap.put("type", null);
		}
		
		DBObject typedb=mongo.findOne(PubConstants.SHOP_SHOPTYPE, whereMap);
		
		if(typedb!=null){
			
			whereMap.clear();
			whereMap.put("parentid",Long.parseLong(typedb.get("_id").toString()) );
			
			List<DBObject> secType=mongo.queryAll(PubConstants.SHOP_SHOPTYPE, whereMap,0,4,null).toArray();
			root.put("secTypeList", secType);
		}
		FreeMarkertUtil fm = new FreeMarkertUtil();  
		String htmlFile="/marker/company/";
		fm.showCourse( "/marker/ftl/company"+comdb.get("mb").toString()+".ftl", root, htmlFile,"company"+_id+".html");  
	}
	/**
	 *滚动显示
	 * @param toUser
	 * @param type
	 */
	private List<DBObject> roll(String toUser,String type){
		MongoDbUtil mongo = new MongoDbUtil();
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		whereMap.put("toUser", toUser);
		
		whereMap.put("type", type);
			
		sortMap.put("sort", 1);
		List<DBObject> list=mongo.queryAll(PubConstants.ROLL_INFO,whereMap, sortMap).toArray();
		mongo.close();
		return list;
	}
	/**
	 *广告位
	 * @param toUser
	 * @param type
	 */
	private List<DBObject> slide(String custid,String type){
		MongoDbUtil mongo = new MongoDbUtil();
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		whereMap.put("custid", custid); 
		whereMap.put("type", type); 	
		sortMap.put("sort", 1);
		List<DBObject> list=mongo.queryAll(PubConstants.SUC_SLIDE,whereMap, sortMap).toArray();
		mongo.close();
		return list;
	}
}
