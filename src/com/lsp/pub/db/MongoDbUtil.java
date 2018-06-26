package com.lsp.pub.db;

import com.lsp.pub.util.SysConfig;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.Mongo;
import com.mongodb.MongoOptions;
import com.mongodb.QueryOperators;
import com.mongodb.ReflectionDBObject;
import com.mongodb.ServerAddress;
import com.mongodb.WriteResult; 
import java.util.HashMap;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.bson.types.ObjectId;
import org.springframework.stereotype.Component;
/**
 * mongodb工具类
 * @author lsp
 *
 */
@Component
public class MongoDbUtil {
	private static Log logger = LogFactory.getLog(MongoDbUtil.class);

	private static Mongo mongo = null;
	private static DB db;
	
	
	
	static {
		try {
			if (mongo == null) {
				String host = SysConfig.getProperty("cache.host"); // 缓存主机
				String userName = SysConfig.getProperty("cache.user"); // 缓存主机用户名
				String passWord = SysConfig.getProperty("cache.password"); // 缓存主机密码
				MongoOptions options = new MongoOptions();
				 options.connectionsPerHost = 10;//链接池数量 默认10 。避免Out of semaphores to get db connection error
			        options.autoConnectRetry = true;
			        options.threadsAllowedToBlockForConnectionMultiplier=20;
			        options.slaveOk = true;
				

		        ServerAddress serverAddress=new ServerAddress(host.split(":")[0], Integer.parseInt(host
						.split(":")[1]));
		         mongo=new Mongo(serverAddress,options);
		        
				db = mongo.getDB(SysConfig.getProperty("datebase"));
				
				if (userName != null && !"".equals(userName)
						&& passWord != null && !"".equals(passWord)) {
					boolean auth = db.authenticate(userName,
							passWord.toCharArray());
					if (!auth) {
						logger.error("Mongo用户名或密码不正确!");
					}
				} else {
					logger.error("Mongo用户名或密码没有配置!");
				}
			}
		} catch (Exception 异常) {
			logger.error("static() catch exception:" + 异常.getMessage(), 异常);
		}
	}

	/**
	 * 新增
	 * 
	 * @param 表名
	 * @param 值集合
	 */
	public void insert(String Table, HashMap<String, Object> hashMap) {
		if (hashMap == null) {
			return;
		}
		DBObject dbObject = mapToObj(hashMap);
		DBCollection collection = db.getCollection(Table);
		collection.insert(dbObject);
		
	}

	/**
	 * 新增对象
	 * 
	 * @param 表名
	 * @param 对象
	 */
	public void insert(String Table, ReflectionDBObject object) {
		DBCollection collection = db.getCollection(Table);
		collection.insert(object);
	}

	/**
	 * 删除
	 * 
	 * @param 表名
	 * @param id
	 */
	public int delete(String Table, HashMap<String, Object> whereMap) {
		if (whereMap == null) {
			whereMap = new HashMap<String, Object>();
		}
		DBCollection collection = db.getCollection(Table);
		return collection.remove(mapToObj(whereMap)).getN();
	}

	/**
	 * 删除
	 * 
	 * @param 表名
	 * @param id
	 */
	public int deleteById(String Table, String id) {

		DBCollection collection = db.getCollection(Table);
		int n=collection.remove(new BasicDBObject("_id", id)).getN();
		
		return n;
	}
	/**
	 * 删除
	 * 
	 * @param 表名
	 * @param id
	 */
	public int delAllById(String Table, String id) {

		DBCollection collection = db.getCollection(Table);
		int n=collection.remove(new BasicDBObject("_id", id)).getN();
		if(n==0){
			collection.remove(new BasicDBObject("_id", new ObjectId(id)));
		}
		return n;
	}
	
	/**
	 * 删除
	 * 
	 * @param 表名
	 * @param id
	 */
	public int deleteById(String Table, long id) {

		DBCollection collection = db.getCollection(Table);
		return collection.remove(new BasicDBObject("_id", id)).getN();
		
	}
	/**
	 * 删除
	 * 
	 * @param 表名
	 * @param id
	 */
	public WriteResult deleteObjectId(String Table, String id) {

		DBCollection collection = db.getCollection(Table);
		return collection.remove(new BasicDBObject("_id", new ObjectId(id)));
	}

	/**
	 * 用id修改
	 * 
	 * @param 表名
	 * @param id
	 * @param 值集合
	 */
	public void updateById(String Table, String id,
			ReflectionDBObject object) {
		
		DBCollection collection = db.getCollection(Table);

		collection.update(new BasicDBObject("_id", new ObjectId(id)),
				new BasicDBObject("$set", object), false, true);

	}
	/**
	 * 用id修改
	 * 
	 * @param 表名
	 * @param id
	 * @param 值集合
	 */
	public int insertUpdate(String Table,ReflectionDBObject object) {
		
		DBCollection collection = db.getCollection(Table);
		collection.save(object);
		return 1;
	}
	/**
	 * 用id修改
	 * 
	 * @param 表名
	 * @param id
	 * @param 值集合
	 */
	public void updateById(String Table,ReflectionDBObject object) {
		
		DBCollection collection = db.getCollection(Table);
		collection.save(object);
	}
	/**
	 * 用id修改
	 * 
	 * @param 表名
	 * @param id
	 * @param 值集合
	 */
	public void updateById(String Table, String id,
			HashMap<String, Object> setMap) {
		if (setMap == null) {
			setMap = new HashMap<String, Object>();
		}
		DBCollection collection = db.getCollection(Table);

		collection.update(new BasicDBObject("_id", new ObjectId(id)),
				new BasicDBObject("$set", mapToObj(setMap)), false, true);

	}

	/**
	 * 修改
	 * 
	 * @param 表名
	 * @param id
	 * @param 值集合
	 */
	public int update(String Table, HashMap<String, Object> whereMap,
			HashMap<String, Object> setMap) {
		if (whereMap == null) {
			whereMap = new HashMap<String, Object>();
		}
		if (setMap == null) {
			setMap = new HashMap<String, Object>();
		}
		DBCollection collection = db.getCollection(Table);

		return collection.update(mapToObj(whereMap),
				new BasicDBObject("$set", mapToObj(setMap)), false, true)
				.getN();

	}

	/**
	 * 用id修改
	 * 
	 * @param 表名
	 * @param id
	 * @param 值集合
	 */
	public int update(String Table, HashMap<String, Object> whereMap,
			ReflectionDBObject object) {
		if (whereMap == null) {
			whereMap = new HashMap<String, Object>();
		}

		DBCollection collection = db.getCollection(Table);

		return collection.update(mapToObj(whereMap),
				new BasicDBObject("$set", object), false, true).getN();

	}
	/**
	 * 用id修改
	 * 
	 * @param 表名
	 * @param id
	 * @param 值集合
	 */
	public int update(String Table, String id,ReflectionDBObject object) {
	
		DBCollection collection = db.getCollection(Table);

		return collection.update(new BasicDBObject("_id", new ObjectId(id)),
				new BasicDBObject("$set", object), false, true).getN();

	}
	
	/**
	 * 查询表内全部数据
	 * 
	 * @param Table
	 */
	public DBCursor queryAll(String Table, HashMap<String, Object> whereMap,int numToSkip, int batchSize, HashMap<String, Object> SortMap) {
		if (whereMap == null) {
			whereMap = new HashMap<String, Object>();
		}
		if (SortMap == null) {
			SortMap = new HashMap<String, Object>();
		}

		

		DBCollection collection = db.getCollection(Table);
		DBObject dbObject = mapToObj(whereMap);
		//DBObject backObject = mapToObj(backMap);
		DBCursor cur = collection.find(dbObject).sort(mapToObj(SortMap)).skip(numToSkip*batchSize).limit(batchSize);
		
		return cur;

	}
	
	/**
	 * 查询表内全部数据
	 * 
	 * @param Table
	 */
	public DBCursor queryAll(String Table, HashMap<String, Object> whereMap,int numToSkip, int batchSize, HashMap<String, Object> SortMap,HashMap<String, Object> backMap) {
		if (whereMap == null) {
			whereMap = new HashMap<String, Object>();
		}
		if (SortMap == null) {
			SortMap = new HashMap<String, Object>();
		}

		DBCollection collection = db.getCollection(Table);
		DBObject dbObject = mapToObj(whereMap);
		DBObject backObject = mapToObj(backMap);
		DBCursor cur = collection.find(dbObject,backObject).sort(mapToObj(SortMap)).skip(numToSkip*batchSize).limit(batchSize);
		return cur;

	} 
	public DBCursor queryAll(String Table, HashMap<String, Object> whereMap,HashMap<String, Object> sortMap,Class cla) {
		if (whereMap == null) {
			whereMap = new HashMap<String, Object>();
		}
		if (sortMap == null) {
			sortMap = new HashMap<String, Object>();
		}
		DBCollection collection = db.getCollection(Table);
		collection.setObjectClass(cla);
		DBObject dbObject = mapToObj(whereMap);
	
		DBCursor cur = collection.find(dbObject).sort(mapToObj(sortMap));
		return cur;
	}
	/**
	 * 查询表内全部数据
	 * 
	 * @param Table
	 */
	public DBCursor queryAll(String Table, HashMap<String, Object> whereMap,
			HashMap<String, Object> sortMap) {
		if (whereMap == null) {
			whereMap = new HashMap<String, Object>();
		}
		if (sortMap == null) {
			sortMap = new HashMap<String, Object>();
		}
		DBCollection collection = db.getCollection(Table);
		DBObject dbObject = mapToObj(whereMap);

		DBCursor cur = collection.find(dbObject).sort(mapToObj(sortMap));
		return cur;
	}
	/**
	 * 查询表内全部数据
	 * 
	 * @param Table
	 */
	public DBCursor queryAll(String Table, HashMap<String, Object> whereMap,
			HashMap<String, Object> sortMap,HashMap<String, Object> backMap) {
		if (whereMap == null) {
			whereMap = new HashMap<String, Object>();
		}
		if (sortMap == null) {
			sortMap = new HashMap<String, Object>();
		}
		DBCollection collection = db.getCollection(Table);
		DBObject dbObject = mapToObj(whereMap);
		DBObject backdbObject = mapToObj(backMap);

		DBCursor cur = collection.find(dbObject,backdbObject).sort(mapToObj(sortMap));
		return cur;
	}

	/**
	 * 查询最后一条数据
	 * 
	 * @param Table
	 */
	public DBObject findOne(String Table, HashMap<String, Object> whereMap,HashMap<String, Object> backMap,HashMap<String, Object> sortMap) {
		if (whereMap == null) {
			whereMap = new HashMap<String, Object>();
		}
		DBCollection collection = db.getCollection(Table);
		DBObject dbObject = mapToObj(whereMap);
		DBObject backdbObject = mapToObj(backMap);
		DBObject sortdbObject = mapToObj(sortMap);
		DBObject cur = collection.findOne(dbObject, backdbObject,sortdbObject);
		return cur;
	}
	/**
	 * 查询最后一条数据
	 * 
	 * @param Table
	 */
	public DBObject findOne(String Table, HashMap<String, Object> whereMap) {
		if (whereMap == null) {
			whereMap = new HashMap<String, Object>();
		}
		DBCollection collection = db.getCollection(Table);
		DBObject dbObject = mapToObj(whereMap);

		DBObject cur = collection.findOne(dbObject);
		return cur;
	}
	/**
	 * 查询最后一条数据
	 * 
	 * @param Table
	 */
	public DBObject findOne(String Table, HashMap<String, Object> whereMap,Class<?> cla) {
		if (whereMap == null) {
			whereMap = new HashMap<String, Object>();
		}
		DBCollection collection = db.getCollection(Table);
		collection.setObjectClass(cla);
		DBObject dbObject = mapToObj(whereMap);
	
		DBObject cur = collection.findOne(dbObject);
		return cur;
	}
	/**
	 * 查询最后一条数据
	 * 
	 * @param Table
	 */
	public DBObject findOne(String Table, HashMap<String, Object> whereMap,HashMap<String, Object> sortMap) {
		if (whereMap == null) {
			whereMap = new HashMap<String, Object>();
		}
		if (sortMap == null) {
			whereMap = new HashMap<String, Object>();
		}
		DBCollection collection = db.getCollection(Table);
		
		DBObject dbObject = mapToObj(whereMap);
		DBObject cur = collection.findOne(dbObject, null, mapToObj(sortMap));
		return cur;
		
	}

	/**
	 * 查询最后一条数据
	 * 
	 * @param Table
	 */
	public DBObject findOneById(String Table, String id) {

		DBCollection collection = db.getCollection(Table);

		DBObject cur = collection.findOne(new BasicDBObject("_id",id));
		return cur;
	}
	/**
	 * 查询最后一条数据
	 * 
	 * @param Table
	 */
	public DBObject findOneById(String Table, String id,Class<?> cla) {

		DBCollection collection = db.getCollection(Table);
		collection.setObjectClass(cla);
		DBObject cur = collection.findOne(new BasicDBObject("_id",id));
		return cur;
	}
	/**
	 * 查询最后一条数据
	 * 
	 * @param Table
	 */
	public DBObject findOneByStringId(String Table, String id) {

		DBCollection collection = db.getCollection(Table);

		DBObject cur = collection.findOne(new BasicDBObject("_id",id));
		return cur;
	}
	/**
	 * 查询最后一条数据
	 * 
	 * @param Table
	 */
	public DBObject findOneById(String Table, Long id) {

		DBCollection collection = db.getCollection(Table);

		DBObject cur = collection.findOne(new BasicDBObject("_id",id));
		return cur;
	}
	/**
	 * 查询最后一条数据
	 * 
	 * @param Table
	 */
	public DBObject findOneById(String Table, int id) {

		DBCollection collection = db.getCollection(Table);

		DBObject cur = collection.findOne(new BasicDBObject("_id",id));
		return cur;
	}
	/**
	 * 查询最后一条数据
	 * 
	 * @param Table
	 */
	public DBObject findOneById(String Table, Long id,Class<?> cla) {

		DBCollection collection = db.getCollection(Table);
		collection.setObjectClass(cla);
		DBObject cur = collection.findOne(new BasicDBObject("_id",id));
		return cur;
	}
	/**
	 * 查询最后一条数据
	 * 
	 * @param Table
	 */
	public DBObject findOneById(String Table, Long id,HashMap<String, Object> backMap) {

		DBCollection collection = db.getCollection(Table);
		DBObject backObject = mapToObj(backMap);
		DBObject cur = collection.findOne(new BasicDBObject("_id",id),backObject);
		return cur;
	}
	/**
	 * 查询最后一条数据
	 * 
	 * @param Table
	 */
	public DBObject findOneById(String Table, String id,HashMap<String, Object> backMap) {

		DBCollection collection = db.getCollection(Table);
		DBObject backObject = mapToObj(backMap);
		DBObject cur = collection.findOne(new BasicDBObject("_id",id),backObject);
		return cur;
	}
	/**
	 * 查询表内全部数据
	 * 
	 * @param Table
	 */
	public DBCursor queryAll(String Table, HashMap<String, Object> whereMap) {
		if (whereMap == null) {
			whereMap = new HashMap<String, Object>();
		}
		DBCollection collection = db.getCollection(Table);
		DBObject dbObject = mapToObj(whereMap);

		DBCursor cur = collection.find(dbObject);
		return cur;

	}

	/**
	 * 查询表内全部数据
	 * 
	 * @param Table
	 */
	public DBCursor queryAll(String Table) {

		DBCollection collection = db.getCollection(Table);
		DBCursor cur = collection.find();
		return cur;

	}

	/**
	 * 计算集合总条数
	 * 
	 * @param collection
	 * @param map
	 */
	public long getCount(String Table, HashMap<String, Object> whereMap) {
		DBCollection collection = db.getCollection(Table);
		DBObject dbObject = mapToObj(whereMap);
		return collection.count(dbObject);
	}
	/**
	 * 计算集合总条数
	 * 
	 * @param collection
	 * @param map
	 */
	public int getCount1(String Table, HashMap<String, Object> whereMap) {
		DBCollection collection = db.getCollection(Table);
		DBObject dbObject = mapToObj(whereMap);
		return (int) collection.count(dbObject);
	}
	

	/**
	 * 计算集合总条数
	 * 
	 * @param collection
	 * @param map
	 */
	public long getCount(String Table) {
		DBCollection collection = db.getCollection(Table);
		return collection.count();
	}
	/**
	 * 附近查询
	 * @param Table 表名
	 * @param whereMap 条件
	 * @param loc 经纬度
	 * @param n 返回条数
	 * @return 附近所有点
	 */
	public DBCursor nearSpere(String Table,HashMap<String, Object> whereMap,Double[] loc,int n) {
		if (whereMap == null) {
			whereMap = new HashMap<String, Object>();
		}
		DBCollection collection = db.getCollection(Table);

		whereMap.put("Loc", new BasicDBObject(QueryOperators.NEAR, loc));
		
		DBObject dbObject = mapToObj(whereMap);
		DBCursor db=collection.find(dbObject).limit(n);
		return db;
	}
	/**
	 * 查找最近一个点
	 * @param Table 表名
	 * @param whereMap 条件
	 * @param loc 经纬度
	 * @param n 返回条数
	 * @return 附近所有点
	 */
	public DBObject nearSpere(String Table,HashMap<String, Object> whereMap,Double[] loc) {
		if (whereMap == null) {
			whereMap = new HashMap<String, Object>();
		}
		DBCollection collection = db.getCollection(Table);

		whereMap.put("Loc", new BasicDBObject(QueryOperators.NEAR, loc));
		
		DBObject dbObject = mapToObj(whereMap);
		DBObject db=collection.findOne(dbObject);
		return db;
	}
	public DBCursor centerSpere(String Table,HashMap<String, Object> whereMap,Double[] center,Double radius) {
		if (whereMap == null) {
			whereMap = new HashMap<String, Object>();
		}
		DBCollection collection = db.getCollection(Table);

		//whereMap.put("Loc", new BasicDBObject(QueryOperators.WITHIN,new BasicDBObject(QueryOperators.CENTER,[center,radius+] )));
		
		DBObject dbObject = mapToObj(whereMap);
		DBCursor db=collection.find(dbObject);
		return db;
	}
	public DBCursor boxSpere(String Table,HashMap<String, Object> whereMap,Double[][] box) {
		if (whereMap == null) {
			whereMap = new HashMap<String, Object>();
		}
		DBCollection collection = db.getCollection(Table);
		
		whereMap.put("Loc", new BasicDBObject("$geoWithin",new BasicDBObject(QueryOperators.BOX, box)));
		
		DBObject dbObject = mapToObj(whereMap);
		DBCursor db=collection.find(dbObject);
		return db;
	}
	/**
	 * 将HashMap转化为DBObject
	 * 
	 * @param map
	 * @return
	 */
	private DBObject mapToObj(HashMap<String, Object> hashMap) {
		DBObject dbObject = new BasicDBObject();
		dbObject.putAll(hashMap);
		return dbObject;
	}
	 
	public void close() { 
		
	}

}
 