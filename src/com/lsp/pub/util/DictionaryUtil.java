package com.lsp.pub.util;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
 
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.entity.PubConstants;
import com.mongodb.DBObject;
/**
 * 工具
 * @author lsp 
 *   
 */ 

@Component
public class DictionaryUtil {
	@Autowired
	private  BaseDao baseDao;
	/**
	 * 从mongo中查询数据字典
	 * @param type
	 * @return
	 */
	public  HashMap<String,String> dictionaryByMongo(String type){
		HashMap<String,String> map = new LinkedHashMap<String,String> ();
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		sortMap.put("sort", 1);
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		whereMap.put("type", type);
		List<DBObject> list=baseDao.getList("dictionary",whereMap, sortMap);
		for(int i=0;i<list.size();i++){
			DBObject db=list.get(i);
			map.put(db.get("key").toString(), db.get("value").toString());
		}
		return map;
	}
	/**
	 * 从mongo中查询数据字典
	 * @param type
	 * @return
	 */
	public  HashMap<String,String> dictionaryBytype(String type){
		HashMap<String,String> map = new LinkedHashMap<String,String> ();
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		sortMap.put("sort", 1);
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		whereMap.put("type", type);
		List<DBObject> list=baseDao.getList(PubConstants.DICTIONARY_INFO,whereMap, sortMap);
		for(int i=0;i<list.size();i++){
			DBObject db=list.get(i);
			map.put(db.get("key").toString(), db.get("value").toString());
		}
		return map;
	}
	/**
	 * 从mongo中查询数据字典
	 * @param type
	 * @return
	 */
	public  List<DBObject> dicListByMongo(String type){
		
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		sortMap.put("sort", 1);
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		whereMap.put("type", type);
		List<DBObject> list=baseDao.getList("dictionary",whereMap, sortMap);
		
		return list;
	}
	 
	 
	/**
	 * 从mongo中查询数据字典
	 * @param type
	 * @return
	 */
	public  HashMap<String,String> dictionaryByMongo(String type,Long orgid){
		HashMap<String,String> map = new LinkedHashMap<String,String> ();
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		sortMap.put("sort", 1);
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		whereMap.put("type", type);
		whereMap.put("orgid", orgid);
		List<DBObject> list=baseDao.getList("dictionary",whereMap, sortMap);
		for(int i=0;i<list.size();i++){
			DBObject db=list.get(i);
			map.put(db.get("key").toString(), db.get("value").toString());
		}
		return map;
	}
	/**
	 * 从mongo中查询数据字典
	 * @param type
	 * @return
	 */
	public  HashMap<String,String> dictionaryByMongo(String type,String toUser){
		HashMap<String,String> map = new LinkedHashMap<String,String> ();
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		sortMap.put("sort", 1);
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		whereMap.put("type", type);
		whereMap.put("toUser", toUser);
		List<DBObject> list=baseDao.getList("dictionary",whereMap, sortMap);
		for(int i=0;i<list.size();i++){
			DBObject db=list.get(i);
			map.put(db.get("key").toString(), db.get("value").toString());
		}
		return map;
	}
	/**
	 * 从配置文件中查询数据字典
	 * @param type
	 * @return
	 */
	public  HashMap<String,String> dictionaryByConfig(String type){
		HashMap<String,String> map = new LinkedHashMap<String,String> ();
		String[] clcs=SysConfig.getProperty(type).split(",");
		for(int i=0;i<clcs.length;i++){
			map.put(clcs[i], clcs[i]);
		}	
		
		return map;
	}
	/**
	 * 从mongo中查询数据字典
	 * @param type
	 * @return
	 */
	public  List<DBObject> parentDicList(int type){
		
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		sortMap.put("sort", 1);
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		whereMap.put("type", type);
		
		List<DBObject> list=baseDao.getList(PubConstants.SET_DICT,whereMap, sortMap);
		
		return list;
	}
	 

}

