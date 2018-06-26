package com.lsp.pub.service;

 
import java.util.HashMap;
import java.util.List;
import java.util.regex.Pattern;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
 
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.DateUtil;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.shop.entiy.ShopMb;
import com.lsp.suc.entity.Ranking;
import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import com.mongodb.QueryOperators;
 
/**
 * 定时任务
 * @author lsp
 *
 */
public class TimerService {
	/** LOG4J对象 */
	private static Logger logger = LoggerFactory.getLogger(TimerService.class);

	private static TimerService timerService;
	@Autowired
	private BaseDao baseDao; 
	private MongoSequence mongoSequence;	
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}
    /**
	 * 服务类实例化
	 * 
	 * @return CzrzService
	 */
	public synchronized static TimerService getInstance() {
		if (timerService == null) {
			timerService = new TimerService();
		}
		return timerService;
	}
	/**
	 * 更新投票榜单
	 */
	public synchronized void updVoteRanking(){
	 
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		sortMap.put("sort", -1);
		List<DBObject>list=baseDao.getList(PubConstants.SUC_VOTELM,null, sortMap);
		if(list.size()>0){
			sortMap.clear();
			for (DBObject dbObject : list) {
				HashMap<String, Object>whereMap=new HashMap<String, Object>();	
				whereMap.put("type", "vote-"+dbObject.get("_id")); 
				sortMap.put("value", -1);
				List<DBObject>db=baseDao.getList(PubConstants.SUC_RANKING, whereMap, sortMap);
				for (int i =0; i < db.size(); i++) {
					Ranking  rank=(Ranking) UniObject.DBObjectToObject(db.get(i),Ranking.class);
					rank.setRank(i+1);
					baseDao.insert(PubConstants.SUC_RANKING, rank);
				}
			}
			
		}
		
	}
	/**
	 * 清除无效榜单
	 */
	public synchronized void delVoteRanking(){ 
	    HashMap<String, Object>whereMap=new HashMap<String, Object>();
	    String type="vote";
		Pattern pattern = Pattern.compile("^.*" + type + ".*$",
				Pattern.CASE_INSENSITIVE);
		whereMap.put("type", pattern); 
		List<DBObject>list=baseDao.getList(PubConstants.SUC_RANKING, whereMap, null);
		if(list.size()>0){
			for (DBObject dbObject : list) {
				String id=dbObject.get("_id").toString().substring(dbObject.get("_id").toString().lastIndexOf("-"));
				if(StringUtils.isNotEmpty(id)){
					DBObject  db=baseDao.getMessage(PubConstants.SUC_VOTE, Long.parseLong(id));
					baseDao.delete(PubConstants.SUC_RANKING,dbObject.get("_id").toString());
				}
			}
		}
		 
		
	}
	/**
	 * 更新农场榜单
	 */
	public synchronized void updFarmRanking(){
	 
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		sortMap.put("value", -1);
		whereMap.put("type", "farm");
		List<DBObject>list=baseDao.getList(PubConstants.SUC_RANKING, whereMap, sortMap);
		for (int i = 0; i <list.size(); i++) {
			Ranking  rank=(Ranking) UniObject.DBObjectToObject(list.get(i),Ranking.class);
			rank.setRank(i+1);
			baseDao.insert(PubConstants.SUC_RANKING, rank);
		} 
	}
	/**
	 * 更新农场榜单
	 */
	public synchronized void updFarmRankingYd(){
	 
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		sortMap.put("sort", -1);
		List<DBObject>list=baseDao.getList(PubConstants.SUC_FARMPRODUCT,null, sortMap);
		if(list.size()>0){
			sortMap.clear();
			for (DBObject dbObject : list) {
				HashMap<String, Object>whereMap=new HashMap<String, Object>();	
				whereMap.put("type", "farm-"+dbObject.get("_id")); 
				sortMap.put("value", -1);
				List<DBObject>db=baseDao.getList(PubConstants.SUC_RANKING, whereMap, sortMap);
				for (int i =0; i < db.size(); i++) {
					Ranking  rank=(Ranking) UniObject.DBObjectToObject(db.get(i),Ranking.class);
					rank.setRank(i+1);
					baseDao.insert(PubConstants.SUC_RANKING, rank);
				}
			}
			
		}
	}
	/**
	 * 更新店铺销售额
	 */
	public synchronized void updSales(){ 
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		sortMap.put("sort", -1);
		List<DBObject>list=baseDao.getList(PubConstants.SHOP_SHOPMB,null, sortMap);
		if(list.size()>0){
			for (DBObject dbObject : list) {
				 //加载月销售额
                 if(dbObject.get("_id")!=null&&StringUtils.isNumeric(dbObject.get("_id").toString())){
                	 ShopMb  shop=(ShopMb) UniObject.DBObjectToObject(dbObject, ShopMb.class);
    				 HashMap<String, Object>whereMap=new HashMap<>(); 
    				 BasicDBObject dateCondition = new BasicDBObject();
    				 double yprice=0;
    				
    				 whereMap.put("comid",Long.parseLong(dbObject.get("_id").toString()));
    				 dateCondition.append("$gte", DateUtil.getfirstday());
    				 dateCondition.append("$lt", DateUtil.getlastday());
    				 List<DBObject>paylist=baseDao.getList(PubConstants.SHOP_PAYMENTORDER, whereMap, null);
    				 if(paylist.size()>0){
    					for (DBObject pay : paylist) {
    						yprice+=Double.parseDouble(pay.get("price").toString()); 
    					}
    					 
    				 }
    				 shop.setMonthsales(yprice);
    				 
    				 //加载日销售额 
    				 yprice=0;
    				 whereMap.clear();
    				 whereMap.put("comid",Long.parseLong(dbObject.get("_id").toString()));
    				 dateCondition=new BasicDBObject();	
    				 dateCondition.append("$gte",DateUtil.getTimesmorning());
    				 dateCondition.append("$lt",DateUtil.getTimesnight()); 
    				 whereMap.put("createdate", dateCondition);
    				 paylist=baseDao.getList(PubConstants.SHOP_PAYMENTORDER, whereMap, null);
    				 if(paylist.size()>0){
    					 for (DBObject pay : paylist) {
    						 yprice+=Double.parseDouble(pay.get("price").toString()); 
    					}  
    				 }
    				 shop.setDaysales(yprice);
    				 
    				 baseDao.insert(PubConstants.SHOP_SHOPMB, shop);
				 }
				
				
			}
		}
		 
	}
  
}