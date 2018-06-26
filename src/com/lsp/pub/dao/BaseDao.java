package com.lsp.pub.dao;

import com.lsp.pub.db.MongoDbUtil;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.ReflectionDBObject;
import java.util.HashMap;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * 数据工具类
 * @author lsp
 *
 */
@Component
public class BaseDao {
	
	private MongoDbUtil mongoDbUtil;
	@Autowired
	public void setMongoDbUtil(MongoDbUtil mongoDbUtil) {
		this.mongoDbUtil = mongoDbUtil;
	}
	
	/**
	 * 全部查询
	 * @param table 表名
	 * @param whereMap 条件
	 * @param sortMap 排序
	 * @return
	 */
	public  List<DBObject> getList(String table,HashMap<String, Object> whereMap,HashMap<String, Object> sortMap) {
		
		DBCursor cur = mongoDbUtil.queryAll(table, whereMap, sortMap);
		return cur.toArray();
	}
	/**
	 * 全部查询
	 * @param table 表名
	 * @param whereMap 条件
	 * @param sortMap 排序
	 * @param backName 要返回字段名称
	 * @return
	 */
	public  List<DBObject> getList(String table,HashMap<String, Object> whereMap,HashMap<String, Object> sortMap,List<String> backName) {
		
		HashMap<String, Object> backMap = new HashMap<String, Object>();	
		for(int i=0;i<backName.size();i++){
			backMap.put(backName.get(i), 1);
		}
		DBCursor cur = mongoDbUtil.queryAll(table, whereMap, sortMap,backMap);
		return cur.toArray();
	}
	/**
	 * 全部查询
	 * @param table 表名
	 * @param whereMap 条件
	 * @param sortMap 排序
	 * @param backName 要返回字段名称
	 * @return
	 */
	public  List<DBObject> getList(String table,HashMap<String, Object> whereMap,HashMap<String, Object> sortMap,HashMap<String, Object> backMap) {
		
		
		DBCursor cur = mongoDbUtil.queryAll(table, whereMap, sortMap,backMap);
		return cur.toArray();
	}
	/**
	 * 安装分页查询相应数据
	 * @param table 表名
	 * @param whereMap 条件
	 * @param numToSkip 数据起始点
	 * @param batchSize 查询数据条数
	 * @param sortMap 排序
	 * @param backName 要返回字段名称
	 * @return
	 */
	public  List<DBObject> getList(String table, HashMap<String, Object> whereMap,int numToSkip, int batchSize, HashMap<String, Object> sortMap, HashMap<String, Object> backName) {
		
		
		
		DBCursor cur = mongoDbUtil.queryAll(table, whereMap,numToSkip, batchSize,sortMap,backName);
		return cur.toArray();
	}
	
	/**
	 * 安装分页查询相应数据
	 * @param table 表名
	 * @param whereMap 条件
	 * @param numToSkip 数据起始点
	 * @param batchSize 查询数据条数
	 * @param sortMap 排序
	 * @return
	 */
	public  List<DBObject> getList(String table, HashMap<String, Object> whereMap,int numToSkip, int batchSize, HashMap<String, Object> sortMap) {
		
		DBCursor cur = mongoDbUtil.queryAll(table, whereMap,numToSkip, batchSize,sortMap);
		return cur.toArray();
	}
	/**
	 * 计算集合总条数
	 * @param table 表名
	 * @param whereMap 条件
	 * @return long
	 */
	public long getCount(String table, HashMap<String, Object> whereMap) {
		
		return mongoDbUtil.getCount(table,whereMap);
	}
	/**
	 * 计算集合总条数
	 * @param table 表名
	 * @param whereMap 条件
	 * @return long
	 */
	public long getCount(String table) {
		
		return mongoDbUtil.getCount(table);
	}
	/**
	 * 按照主键查询数据
	 * @param table 表名
	 * @param id 主键
	 * @param cla 返回实体类
	 * @return DBObject
	 */
	public DBObject getMessage(String table,HashMap<String, Object> whereMap,Class cla){
		
		
		DBObject message=mongoDbUtil.findOne(table, whereMap, cla);
		return message;
	}
	/**
	 * 按照主键查询数据
	 * @param table 表名
	 * @param id 主键
	 * @param cla 返回实体类
	 * @return DBObject
	 */
	public DBObject getMessage(String table,HashMap<String, Object> whereMap,HashMap<String, Object> sortMap){
		
		
		DBObject message=mongoDbUtil.findOne(table, whereMap, sortMap);
		return message;
	}
	/**
	 * 按照主键查询数据
	 * @param table 表名
	 * @param id 主键
	 * @param cla 返回实体类
	 * @return DBObject
	 */
	public DBObject getMessage(String table,Long id,HashMap<String, Object> backMap){
		
		
		DBObject message=mongoDbUtil.findOneById(table, id,backMap);
		return message;
	}
	/**
	 * 按照主键查询数据
	 * @param table 表名
	 * @param id 主键
	 * @param cla 返回实体类
	 * @return DBObject
	 */
	public DBObject getMessage(String table,HashMap<String, Object> whereMap){
		
		
		DBObject message=mongoDbUtil.findOne(table, whereMap);
		return message;
	}
	/**
	 * 按照主键查询数据
	 * @param table 表名
	 * @param id 主键
	 * @param cla 返回实体类
	 * @return DBObject
	 */
	public DBObject getMessage(String table,HashMap<String, Object> whereMap,HashMap<String, Object> backMap,HashMap<String, Object> sortMap){
		
		
		DBObject message=mongoDbUtil.findOne(table, whereMap,backMap,sortMap);
		return message;
	}
	/**
	 * 按照主键查询数据
	 * @param table 表名
	 * @param id 主键
	 * @param cla 返回实体类
	 * @return DBObject
	 */
	public DBObject getMessage(String table,String id,Class cla){
		
		
		DBObject message=mongoDbUtil.findOneById(table, id, cla);
		return message;
	}
	/**
	 * 按照主键查询数据
	 * @param table 表名
	 * @param id 主键
	 * @param cla 返回实体类
	 * @return DBObject
	 */
	public DBObject getMessage(String table,Long id,Class cla){
		
		
		DBObject message=mongoDbUtil.findOneById(table, id, cla);
		return message;
	}
	/**
	 * 按照主键查询数据
	 * @param table 表名
	 * @param id 主键
	 * @return DBObject
	 */
	public DBObject getMessage(String table,Long id){
		
		
		DBObject message=mongoDbUtil.findOneById(table, id);
		return message;
	}
	/**
	 * 按照主键查询数据
	 * @param table 表名
	 * @param id 主键
	 * @return DBObject
	 */
	public DBObject getMessage(String table,int id){
		
		
		DBObject message=mongoDbUtil.findOneById(table, id);
		return message;
	}
	/**
	 * 按照主键查询数据
	 * @param table 表名
	 * @param id 主键
	 * @return DBObject
	 */
	public DBObject getMessage(String table,String id){
		
		
		DBObject message=mongoDbUtil.findOneById(table, id);
		return message;
	}	
	/**
	 * 按照主键查询数据
	 * @param table 表名
	 * @param id 主键
	 * @return DBObject
	 */
	public DBObject getMessage(String table,String id,HashMap<String, Object> backMap){
		
		
		DBObject message=mongoDbUtil.findOneById(table, id,backMap);
		return message;
	}	
	
	/**
	 * 按照主键查询数据
	 * @param table 表名
	 * @param id 主键
	 * @param backName 要返回字段名称
	 * @return DBObject
	 */
	public DBObject getMessage(String table,Long id,List<String> backName){
		HashMap<String, Object> backMap = new HashMap<String, Object>();	
		for(int i=0;i<backName.size();i++){
			backMap.put(backName.get(i), 1);
		}
		
		DBObject message=mongoDbUtil.findOneById(table, id,backMap);
		return message;
	}	
	/**
	 * 新增信息
	 * @param table 表名
	 * @param object 实体类
	 */
	public int insert(String table,ReflectionDBObject object){
			
		return mongoDbUtil.insertUpdate(table, object);	
	}
	/**
	 * 新增信息
	 * @param table 表名
	 * @param object 实体类
	 */
	public void insertString(String table,String _id){
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("_id", _id);
	    mongoDbUtil.insert(table, map);	
	}
	
	/**
	 * 删除信息
	 * @param table 表名
	 * @param id 主键
	 */
	public int delete(String table,Long id){
	
		return mongoDbUtil.deleteById(table, id);
	}
	/**
	 * 删除信息
	 * @param table 表名
	 * @param id 主键
	 */
	public int delete(String table,int id){
	
		return mongoDbUtil.deleteById(table, id);
	}
	/**
	 * 删除信息
	 * @param table 表名
	 * @param id 主键
	 */
	public int delete(String table,String id){
	
		return mongoDbUtil.deleteById(table, id);
	}
	/**
	 * 删除信息
	 * @param table 表名
	 * @param id 主键
	 */
	public int deleteAll(String table,String id){
	
		return mongoDbUtil.delAllById(table, id);
	}
	
	/**
	 * 删除信息
	 * @param table 表名
	 * @param id 主键
	 */
	public int delete(String table,HashMap<String, Object> whereMap){
	
		return mongoDbUtil.delete(table, whereMap);
	}
	/**
	 * 全部删除
	 * @param table 表名
	 */
	public void delete(String table){	

		mongoDbUtil.delete(table, null);
	}
	/**
	 *矩形区域搜索
	 * @param whereMap
	 * @return
	 */
	public List<DBObject> getBoxSpere(String table, HashMap<String, Object> whereMap,Double[][] box){
		DBCursor dBCursor=mongoDbUtil.boxSpere(table, whereMap, box);	
		if(dBCursor.count()==0){
			return null;
		}
		return dBCursor.toArray();
	}
	/**
	 *原型 区域搜索
	 * @param whereMap
	 * @return
	 */
	public List<DBObject> getCenterSpere(String table, HashMap<String, Object> whereMap,Double[] center,Double radius){
		DBCursor dBCursor=mongoDbUtil.centerSpere(table, whereMap, center, radius);
		if(dBCursor.count()==0){
			return null;
		}
		return dBCursor.toArray();
	}
}