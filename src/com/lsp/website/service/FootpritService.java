package com.lsp.website.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants; 
import com.lsp.suc.entity.Footprint;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject; 

@Component
@Transactional
public class FootpritService {

	@Autowired
	private BaseDao baseDao;
	@Autowired
	private MongoSequence mongoSequence;
	/**
	 * 添加足迹
	 * @return
	 */
	@SuppressWarnings("unused")
	private  boolean  addFoot(String toUser,String fromUser,String type,int page,String sel){
		try {
			Footprint  foot=new Footprint();
			foot.set_id(mongoSequence.currval(PubConstants.FOOTPRIT));
			foot.setCreatedate(new Date());
			foot.setFromUser(fromUser);
			foot.setPage(page);
			foot.setSel(sel);
			foot.setType(type);
			foot.setToUser(toUser);
			baseDao.insert(PubConstants.FOOTPRIT, foot);
			return true;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return false;
		
	}
	/**
	 * 查询足迹
	 * @param whereMap
	 * @param sortMap
	 * @return
	 */
	@SuppressWarnings("unused")
	private List<DBObject>  findFoot(String toUser,String fromUser,String type,int ref){
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		whereMap.put("toUser", toUser);
		whereMap.put("fromUser", fromUser);
		whereMap.put("type", type);  
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		sortMap.put("createdate", ref);
		List<DBObject>list=baseDao.getList(PubConstants.FOOTPRIT, whereMap, sortMap);
		return list;
		
	}
	/**
	 * 查询足迹
	 * @param whereMap
	 * @param sortMap
	 * @return
	 */
	@SuppressWarnings("unused")
	private List<DBObject>  findFoot(String toUser,String fromUser,String type,int ref,Date enddate){
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		whereMap.put("toUser", toUser);
		whereMap.put("fromUser", fromUser);
		whereMap.put("type", type);
		BasicDBObject dateCondition = new BasicDBObject();  
	    dateCondition.append("$gte",enddate);
		whereMap.put("createdate", dateCondition);
		 
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		sortMap.put("createdate", ref);
		List<DBObject>list=baseDao.getList(PubConstants.FOOTPRIT, whereMap, sortMap);
		return list;
		
	}
	/**
	 * 查询足迹
	 * @param whereMap
	 * @param sortMap
	 * @return
	 */
	@SuppressWarnings("unused")
	private List<DBObject>  findFoot(String toUser,String fromUser,String type,int ref,Date startdate,Date enddate){
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		whereMap.put("toUser", toUser);
		whereMap.put("fromUser", fromUser);
		whereMap.put("type", type);
		BasicDBObject dateCondition = new BasicDBObject();  
	    dateCondition.append("$gte",enddate);
	    dateCondition.append("$lte", startdate);
		whereMap.put("createdate", dateCondition);
		 
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		sortMap.put("createdate", ref);
		List<DBObject>list=baseDao.getList(PubConstants.FOOTPRIT, whereMap, sortMap);
		return list;
		
	}
	/**
	 * 删除足迹
	 * @param toUser
	 * @param fromUser
	 * @return
	 */
	public boolean  deleteFoot(String toUser,String fromUser,String type){
		try {
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			whereMap.put("toUser", toUser);
			whereMap.put("fromUser", fromUser);
			whereMap.put("type", type);
			baseDao.delete(PubConstants.FOOTPRIT, whereMap);
			return true;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
		
	}
	/**
	 * 删除足迹
	 * @param toUser
	 * @param fromUser
	 * @return
	 */
	public boolean  deleteFoot(String toUser,String fromUser,String type,Date enddate){
		try {
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			whereMap.put("toUser", toUser);
			whereMap.put("fromUser", fromUser);
			whereMap.put("type", type);
			BasicDBObject dateCondition = new BasicDBObject();  
		    dateCondition.append("$gte",enddate); 
			whereMap.put("createdate", dateCondition);
			baseDao.delete(PubConstants.FOOTPRIT, whereMap);
			return true;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
		
	}
	/**
	 * 删除足迹
	 * @param toUser
	 * @param fromUser
	 * @return
	 */
	public boolean  deleteFoot(String toUser,String fromUser,String type,Date startdate,Date enddate){
		try {
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			whereMap.put("toUser", toUser);
			whereMap.put("fromUser", fromUser);
			whereMap.put("type", type);
			BasicDBObject dateCondition = new BasicDBObject();  
		    dateCondition.append("$gte",enddate);
		    dateCondition.append("$lte", startdate);
			whereMap.put("createdate", dateCondition);
			baseDao.delete(PubConstants.FOOTPRIT, whereMap);
			return true;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
		
	}
	/**
	 * 查询特定时间前最后一条数据(以秒为单位);
	 * @return
	 */
	public  DBObject  getLastFoot(String toUser,String fromUser,String type,int time){
		try {
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			whereMap.put("toUser", toUser);
			whereMap.put("fromUser", fromUser); 
			whereMap.put("type", type);
			BasicDBObject dateCondition = new BasicDBObject(); 
		    dateCondition.append("$gte", new Date(new Date().getTime()-time*1000));
			whereMap.put("createdate", dateCondition);
			sortMap.put("createdate", -1);
			List<DBObject>list=baseDao.getList(PubConstants.FOOTPRIT, whereMap, sortMap);
			return list.get(list.size()-1);
		} catch (Exception e) {
			// TODO Auto-generated catch block 
			e.printStackTrace();
			
		}
		return  null;
	}
}
