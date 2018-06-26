package com.lsp.weixin.util;


import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
 
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.lsp.pub.db.MongoDbUtil;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.SysConfig;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
/***
 * 资源管理
 * @author lsp
 *
 */ 

@Component
public class JuheUtil {

	/**
	 * 获取Token
	 * 
	 * @param toUser
	 * @param appid
	 * @param secret
	 * @return
	 * @throws Exception
	 */
	public static JSONObject getWz(DBObject wzcity, String hphm,
			String engineno, String classno) {
		StringBuffer url = new StringBuffer("http://v.juhe.cn/wz/query?key=")
				.append(SysConfig.getProperty("wz_AppKey")).append("&city=");
		int length = 0;
		url.append(wzcity.get("code").toString());// 城市
		url.append("&hphm=").append(hphm);
		url.append("&hpzl=").append(2);
		if (wzcity.get("engine").toString().equals("0")
				&& wzcity.get("classa").toString().equals("0")) {
			return null;
		}
		if (wzcity.get("engine").toString().equals("1")) {// 是否需要发动机号0,不需要 1,需要
			length = engineno.length();
			if (wzcity.get("engineno").toString().equals("0")) {
				url.append("&engineno=").append(engineno);
			} else {
				url.append("&engineno=").append(
						engineno.substring(length
								- Integer.parseInt(wzcity.get("engineno")
										.toString())));
			}
		}
		if (wzcity.get("classa").toString().equals("1")) {// 是否需要发动机号0,不需要 1,需要
			length = classno.length();
			if (wzcity.get("classno").toString().equals("0")) {
				url.append("&classno=").append(classno);
			} else {
				url.append("&classno=").append(
						classno.substring(length
								- Integer.parseInt(wzcity.get("classno")
										.toString())));
			}
		}

		String ret = get(url.toString());

		JSONObject object = JSONObject.parseObject(ret);
		return object;
	}
//	/**
//	 * 请求违章查询接口
//	 * @param cardb
//	 * @param fromUser
//	 * @param toUser
//	 * @return
//	 */
//	public WzInfo setWz(DBObject cardb, String fromUser, String toUser) {
//		MongoDbUtil mongoDbUtil = new MongoDbUtil();
//		HashMap<String, Object> whereMap = new HashMap<String, Object>();
//		UUIDGenerator uu = new UUIDGenerator();
//		whereMap.put("fromUser", fromUser);
//		Long now = new Date().getTime();
//		DBObject wzdb = mongoDbUtil.findOneById(PubConstants.CMP_WZINFO,fromUser);
//
//		WzInfo entity = new WzInfo();
//		if (wzdb != null) {
//			try {
//				entity = (WzInfo) UniObject.DBObjectToObject(wzdb, WzInfo.class);
//			} catch (Exception e) {
//
//			}
//		}
//		entity.set_id(fromUser);
//		int fen = entity.getFen();
//		int money = entity.getMoney();
//		String hphm = "";
//		if (entity.getInsertdate() == null|| now - entity.getInsertdate() > 864000000) {
//
//			DBObject wzcity = mongoDbUtil.findOneById(PubConstants.SET_WZCITY,
//					cardb.get("wzcity").toString());
//			hphm = JuheUtil.toUtf8String(cardb.get("carno1").toString())
//					+ cardb.get("carno2").toString()
//					+ cardb.get("carno3").toString();
//			JSONObject wz = JuheUtil.getWz(wzcity, hphm, cardb.get("fdjno")
//					.toString(), cardb.get("cjh").toString());
//			entity.set_id(fromUser);
//			entity.setFromUser(fromUser);
//			entity.setCity(cardb.get("wzcity").toString());
//			entity.setHphm(cardb.get("carno1").toString()
//					+ cardb.get("carno2").toString()
//					+ cardb.get("carno3").toString());
//			entity.setInsertdate(now);
//
//			entity.setToUser(toUser);
//			entity.setState(0);
//			if (wz == null || wz.get("result") == null) {
//			} else {
//				if (wz.getString("resultcode").equals("200")) {
//					mongoDbUtil.delete(PubConstants.CMP_WZDETAIL, whereMap);
//					fen = 0;
//					money = 0;
//
//					JSONObject wzre = wz.getJSONObject("result");
//					entity.setProvince(wzre.getString("province"));
//					com.alibaba.fastjson.JSONArray array = wzre
//							.getJSONArray("lists");
//
//					entity.setState(1);// 已查到
//					UUIDGenerator uuid=new UUIDGenerator();
//					for (int i = 0; i < array.size(); i++) {
//
//						WzDetail detail = new WzDetail();
//						JSONObject de = (JSONObject) array.get(i);
//
//						detail.set_id(uu.getNextValue());
//						detail.setAct(de.getString("act"));
//						detail.setArea(de.getString("area"));
//						detail.setCode(de.getString("code"));
//						detail.setDate(de.getString("date"));
//						detail.setFen(de.getString("fen"));
//						detail.setHandled(de.getString("handled"));
//						detail.setMoney(de.getString("money"));
//						detail.setFromUser(fromUser);
//						
//						
//						whereMap.clear();
//						whereMap.put("act", detail.getAct());
//						whereMap.put("wid", wzcity.get("parentcode").toString());
//						DBObject dictdb=mongoDbUtil.findOne(PubConstants.SET_WZDICT, whereMap);
//						if(dictdb==null){
//							WzDict wzdict = new WzDict();
//							wzdict.setAct(detail.getAct());
//							wzdict.setWid(wzcity.get("code").toString());
//							wzdict.setFen(de.getString("fen"));
//							wzdict.setMoney(de.getString("money"));
//							wzdict.setCode(de.getString("code"));
//							wzdict.set_id(uuid.getNextValue(PubConstants.SET_WZDICT));
//							mongoDbUtil.insertUpdate(PubConstants.SET_WZDICT,wzdict);
//						}else{
//							if(dictdb.get("info")!=null){
//								detail.setInfo(dictdb.get("info").toString());
//							}
//							if(dictdb.get("fen")!=null){
//								detail.setFen(dictdb.get("fen").toString());
//							}
//							if(dictdb.get("money")!=null){
//								detail.setMoney(dictdb.get("money").toString());
//							}
//						}
//						if (StringUtils.isNotEmpty(detail.getFen())) {
//							fen = fen + Integer.parseInt(detail.getFen());
//						}
//						if (StringUtils.isNotEmpty(detail.getMoney())) {
//							money = money + Integer.parseInt(detail.getMoney());
//						}
//						mongoDbUtil.insertUpdate(PubConstants.CMP_WZDETAIL,detail);
//						
//					}
//				}
//				
//			}
//	
//		}
//		if(SysConfig.getProperty("ismq").equals("1")&&entity.getState()==0){
//			HashMap<String,Object> map=new HashMap<String,Object>();
//			map.put("keyword0", cardb.get("carno1").toString()+ cardb.get("carno2").toString()+ cardb.get("carno3").toString()+"在查询违章");
//			map.put("keyword1", "未查到！尽快处理");
//			map.put("keyword2", DateFormat.getDate(new Date()));
//			map.put("size", 3);
//			whereMap.clear();
//			whereMap.put("wid", "weizhang");
//			whereMap.put("toUser",toUser);
//
//			List<DBObject> fromAdmin=mongoDbUtil.queryAll(PubConstants.RF_FROMADMIN, whereMap).toArray(); 
//			
//			for(int i=0;i<fromAdmin.size();i++){
//				JmsService.jsonMessage(toUser, fromAdmin.get(i).get("fromUser").toString(), "tongzhi",map);//推送消息
//				
//			}
//			
//		}
//		entity.setFen(fen);
//		entity.setMoney(money);
//		mongoDbUtil.insertUpdate(PubConstants.CMP_WZINFO, entity);
//		return entity;
//
//	}
//	/**
//	 * 请求违章查询接口
//	 * @param cardb
//	 * @param fromUser
//	 * @param toUser
//	 * @return 0 未查到  1 已查到
//	 */
//	public int gxwz(String fromUser, String toUser) {
//		MongoDbUtil mongoDbUtil = new MongoDbUtil();
//		HashMap<String, Object> whereMap = new HashMap<String, Object>();
//		UUIDGenerator uu = new UUIDGenerator();
//		whereMap.put("fromUser", fromUser);
//		Long now = new Date().getTime();
//		DBObject cardb = mongoDbUtil.findOneById(PubConstants.CMP_CAR,fromUser);
//		DBObject wzdb = mongoDbUtil.findOneById(PubConstants.CMP_WZINFO,fromUser);
//
//		WzInfo entity = new WzInfo();
//		if (wzdb != null) {
//			try {
//				entity = (WzInfo) UniObject.DBObjectToObject(wzdb, WzInfo.class);
//			} catch (Exception e) {
//
//			}
//		}
//		entity.set_id(fromUser);
//		entity.setFromUser(fromUser);
//		entity.setCity(cardb.get("wzcity").toString());
//		entity.setHphm(cardb.get("carno1").toString()+ cardb.get("carno2").toString()+ cardb.get("carno3").toString());
//		entity.setInsertdate(now);
//
//		entity.setToUser(toUser);
//		entity.setState(0);
//		int fen = entity.getFen();
//		int money = entity.getMoney();
//		String hphm = "";
//		
//
//		DBObject wzcity = mongoDbUtil.findOneById(PubConstants.SET_WZCITY,cardb.get("wzcity").toString());
//		
//		if(wzcity==null){//无法查询
//			mongoDbUtil.insertUpdate(PubConstants.CMP_WZINFO, entity);
//			HashMap<String,Object> map=new HashMap<String,Object>();
//			map.put("keyword0", entity.getHphm()+"在查询违章");
//			map.put("keyword1", " 违章城市不对，请核对");
//			map.put("keyword2", DateFormat.getDate(new Date()));
//			map.put("size", 3);
//			whereMap.clear();
//			whereMap.put("wid", "weizhang");
//			whereMap.put("toUser",toUser);
//
//			List<DBObject> fromAdmin=mongoDbUtil.queryAll(PubConstants.RF_FROMADMIN, whereMap).toArray(); 
//			
//			for(int i=0;i<fromAdmin.size();i++){
//				JmsService.jsonMessage(toUser, fromAdmin.get(i).get("fromUser").toString(), "tongzhi",map);//推送消息
//				
//			}
//			return 0;
//		}
//		if(wzcity.get("classa").toString().equals("0")&&wzcity.get("engine").toString().equals("0")&&wzcity.get("regist").toString().equals("0")){
//			mongoDbUtil.insertUpdate(PubConstants.CMP_WZINFO, entity);
//			HashMap<String,Object> map=new HashMap<String,Object>();
//			map.put("keyword0", entity.getHphm()+"在查询违章");
//			map.put("keyword1", " 该地区不能查询，请手动查询");
//			map.put("keyword2", DateFormat.getDate(new Date()));
//			map.put("size", 3);
//			whereMap.clear();
//			whereMap.put("wid", "weizhang");
//			whereMap.put("toUser",toUser);
//
//			List<DBObject> fromAdmin=mongoDbUtil.queryAll(PubConstants.RF_FROMADMIN, whereMap).toArray(); 
//			
//			for(int i=0;i<fromAdmin.size();i++){
//				JmsService.jsonMessage(toUser, fromAdmin.get(i).get("fromUser").toString(), "tongzhi",map);//推送消息
//				
//			}
//			return 0;
//		}
//		
//		hphm = JuheUtil.toUtf8String(cardb.get("carno1").toString())+ cardb.get("carno2").toString()+ cardb.get("carno3").toString();
//		JSONObject wz = JuheUtil.getWz(wzcity, hphm, cardb.get("fdjno").toString(), cardb.get("cjh").toString());
//		
//		if (wz == null || wz.get("result") == null) {
//			mongoDbUtil.insertUpdate(PubConstants.CMP_WZINFO, entity);
//			mongoDbUtil.insertUpdate(PubConstants.CMP_WZINFO, entity);
//			HashMap<String,Object> map=new HashMap<String,Object>();
//			map.put("keyword0", cardb.get("carno1").toString()+ cardb.get("carno2").toString()+ cardb.get("carno3").toString()+"在查询违章");
//			map.put("keyword1", "查询过程中错误，请手动查询");
//			map.put("keyword2", DateFormat.getDate(new Date()));
//			map.put("size", 3);
//			whereMap.clear();
//			whereMap.put("wid", "weizhang");
//			whereMap.put("toUser",toUser);
//
//			List<DBObject> fromAdmin=mongoDbUtil.queryAll(PubConstants.RF_FROMADMIN, whereMap).toArray(); 
//			
//			for(int i=0;i<fromAdmin.size();i++){
//				JmsService.jsonMessage(toUser, fromAdmin.get(i).get("fromUser").toString(), "tongzhi",map);//推送消息
//				
//			}
//			return 0;
//		} else {
//			if (wz.getString("resultcode").equals("200")) {
//				
//				mongoDbUtil.delete(PubConstants.CMP_WZDETAIL, whereMap);
//					fen = 0;
//					money = 0;
//
//					JSONObject wzre = wz.getJSONObject("result");
//					entity.setProvince(wzre.getString("province"));
//					com.alibaba.fastjson.JSONArray array = wzre.getJSONArray("lists");
//
//					entity.setState(1);// 已查到
//					UUIDGenerator uuid=new UUIDGenerator();
//					for (int i = 0; i < array.size(); i++) {
//
//						WzDetail detail = new WzDetail();
//						JSONObject de = (JSONObject) array.get(i);
//
//						detail.set_id(uu.getNextValue());
//						detail.setAct(de.getString("act"));
//						detail.setArea(de.getString("area"));
//						detail.setCode(de.getString("code"));
//						detail.setDate(de.getString("date"));
//						detail.setFen(de.getString("fen"));
//						detail.setHandled(de.getString("handled"));
//						detail.setMoney(de.getString("money"));
//						detail.setFromUser(fromUser);
//						
//						
//						whereMap.clear();
//						whereMap.put("act", detail.getAct());
//						whereMap.put("wid", wzcity.get("parentcode").toString());
//						DBObject dictdb=mongoDbUtil.findOne(PubConstants.SET_WZDICT, whereMap);
//						if(dictdb==null){
//							WzDict wzdict = new WzDict();
//							wzdict.setAct(detail.getAct());
//							wzdict.setWid(wzcity.get("code").toString());
//							wzdict.setFen(de.getString("fen"));
//							wzdict.setMoney(de.getString("money"));
//							wzdict.setCode(de.getString("code"));
//							wzdict.set_id(uuid.getNextValue(PubConstants.SET_WZDICT));
//							mongoDbUtil.insertUpdate(PubConstants.SET_WZDICT,wzdict);
//						}else{
//							if(dictdb.get("info")!=null){
//								detail.setInfo(dictdb.get("info").toString());
//							}
//							if(dictdb.get("fen")!=null){
//								detail.setFen(dictdb.get("fen").toString());
//							}
//							if(dictdb.get("money")!=null){
//								detail.setMoney(dictdb.get("money").toString());
//							}
//						}
//						if (StringUtils.isNotEmpty(detail.getFen())) {
//							fen = fen + Integer.parseInt(detail.getFen());
//						}
//						if (StringUtils.isNotEmpty(detail.getMoney())) {
//							money = money + Integer.parseInt(detail.getMoney());
//						}
//						mongoDbUtil.insertUpdate(PubConstants.CMP_WZDETAIL,detail);
//						
//					}
//					entity.setFen(fen);
//					entity.setMoney(money);
//					mongoDbUtil.insertUpdate(PubConstants.CMP_WZINFO, entity);
//					return 1;
//				}else{//未查询到
//					mongoDbUtil.insertUpdate(PubConstants.CMP_WZINFO, entity);
//					HashMap<String,Object> map=new HashMap<String,Object>();
//					map.put("keyword0", cardb.get("carno1").toString()+ cardb.get("carno2").toString()+ cardb.get("carno3").toString()+"在查询违章");
//					map.put("keyword1", "未查到！尽快处理");
//					map.put("keyword2", DateFormat.getDate(new Date()));
//					map.put("size", 3);
//					whereMap.clear();
//					whereMap.put("wid", "weizhang");
//					whereMap.put("toUser",toUser);
//
//					List<DBObject> fromAdmin=mongoDbUtil.queryAll(PubConstants.RF_FROMADMIN, whereMap).toArray(); 
//					
//					for(int i=0;i<fromAdmin.size();i++){
//						JmsService.jsonMessage(toUser, fromAdmin.get(i).get("fromUser").toString(), "tongzhi",map);//推送消息
//						
//					}
//					return 0;
//				}
//				
//			}
//		
//	}
//	/**
//	 * 获取支持城市参数接口
//	 */
//	public void setWzCity() {
//		MongoDbUtil mongoDbUtil = new MongoDbUtil();
//		HashMap<String, Object> whereMap = new HashMap<String, Object>();
//		
//		String ret = get("http://v.juhe.cn/wz/citys?key="+SysConfig.getProperty("wz_AppKey"));
//
//		JSONObject object = JSONObject.parseObject(ret);
//		String[] cs= {"BJ","SX","CQ","SH","TJ", "HB","XS", "NM","LN","JL","HLJ","JS","ZJ","AH","FJ",  "JX","SD","HN","FB","HUN", "GD","BJ","HAN","SC", "GZ",   "YN","XZ","GS","QH","NX", "XJ"};
//		String[] cs1={"京","陕","渝","沪","津",  "冀","晋","蒙","辽","吉",  "黑","苏","浙","皖","闽",   "赣","鲁","豫","鄂","湘",   "粤","桂","琼","川","贵",  "云","藏","甘","青","宁",  "新"};
//		if (object.getString("resultcode").equals("200")) {
//			
//			JSONObject result=object.getJSONObject("result");
//			for(int i=0;i<cs.length;i++){
//				JSONObject nr = result.getJSONObject(cs[i]);
//				
//				if(nr!=null){
//					com.alibaba.fastjson.JSONArray citys = nr.getJSONArray("citys");
//					for(int j=0;j<citys.size();j++){
//						JSONObject de = (JSONObject) citys.get(j);
//						String city_name=de.getString("city_name");
//						String city_code=de.getString("city_code");
//						String engine=de.getString("engine");
//						String engineno=de.getString("engineno");
//						String classa=de.getString("classa");
//						String classno=de.getString("classno");
//						String regist=de.getString("regist");
//						String registno=de.getString("registno");
//						whereMap.clear();
//						whereMap.put("code", city_code);
//						List<DBObject> list = mongoDbUtil.queryAll(PubConstants.SET_WZCITY,whereMap, null).toArray();
//						if(list.size()==0){
//							WzCity entity =new WzCity();
//							entity.set_id(city_code);
//							entity.setCode(city_code);
//							entity.setJc("NO");
//							entity.setName(city_name);;
//							entity.setParentcode(de.getString("abbr"));
//							entity.setClassa(Integer.parseInt(classa));
//							entity.setClassno(Integer.parseInt(classno));
//							entity.setEngine(Integer.parseInt(engine));
//							entity.setEngineno(Integer.parseInt(engineno));
//							entity.setRegist(Integer.parseInt(regist));
//							entity.setRegistno(Integer.parseInt(registno));
//							entity.setInsdate(new Date());
//							mongoDbUtil.insertUpdate(PubConstants.SET_WZCITY, entity);
//						}else{
//							for(int k=0;k<list.size();k++){
//								WzCity entity = (WzCity)UniObject.DBObjectToObject(list.get(k),WzCity.class);
//								entity.set_id(list.get(k).get("_id").toString());
//								entity.setClassa(Integer.parseInt(classa));
//								entity.setClassno(Integer.parseInt(classno));
//								entity.setEngine(Integer.parseInt(engine));
//								entity.setEngineno(Integer.parseInt(engineno));
//								entity.setRegist(Integer.parseInt(regist));
//								entity.setRegistno(Integer.parseInt(registno));
//								entity.setInsdate(new Date());
//								mongoDbUtil.insertUpdate(PubConstants.SET_WZCITY, entity);
//							}
//						}
//						
//						
//					}
//				}else{//无法查询违章地区
//					whereMap.clear();
//					whereMap.put("parentcode", cs1[i]);
//					List<DBObject> list = mongoDbUtil.queryAll(PubConstants.SET_WZCITY,whereMap, null).toArray();
//					for(DBObject db:list){
//						WzCity entity = (WzCity)UniObject.DBObjectToObject(db,WzCity.class);
//						entity.set_id(db.get("_id").toString());
//						entity.setClassa(0);
//						entity.setClassno(0);
//						entity.setEngine(0);
//						entity.setEngineno(0);
//						entity.setRegist(0);
//						entity.setRegistno(0);
//						entity.setInsdate(new Date());
//						mongoDbUtil.insertUpdate(PubConstants.SET_WZCITY, entity);
//					}
//					
//				}
//		    } 
//			
//			
//		}
//		//查询更新所有不能更新的城市
//		whereMap.clear();
//		whereMap.put("insdate", new BasicDBObject("$lte",DateUtil.addHour(new Date(),-24)));
//		List<DBObject> list = mongoDbUtil.queryAll(PubConstants.SET_WZCITY,whereMap, null).toArray();
//		for(DBObject db:list){
//			WzCity entity = (WzCity)UniObject.DBObjectToObject(db,WzCity.class);
//			entity.set_id(db.get("_id").toString());
//			entity.setClassa(0);
//			entity.setClassno(0);
//			entity.setEngine(0);
//			entity.setEngineno(0);
//			entity.setRegist(0);
//			entity.setRegistno(0);
//			entity.setInsdate(new Date());
//			mongoDbUtil.insertUpdate(PubConstants.SET_WZCITY, entity);
//		}
//		
//		
//	}
//
//	/**
//	 * VIN(车辆识别码)查询
//	 * 
//	 * @param toUser
//	 * @param appid
//	 * @param secret
//	 * @return
//	 * @throws Exception
//	 */
//	public static CarInfo getVin(String vin, CarInfo car) throws Exception {
//		vin = vin.replaceAll("O", "0").replaceAll("Q", "0")
//				.replaceAll("I", "1");
//		String url = "http://op.juhe.cn/vin/query?key="
//				+ SysConfig.getProperty("vin_AppKey") + "&vin=" + vin;
//		String ret = httpClient.http(url.toString(), null);
//		JSONObject object = JSONObject.parseObject(ret);
//		if (object.get("error_code").toString().equals("0")) {
//			if (object.get("result") != null) {
//				JSONObject object1 = JSONObject.parseObject(object
//						.get("result").toString());
//				if (StringUtils.isNotEmpty(object1.getString("PP"))) {
//					car.setCjmc(object1.getString("CJMC"));
//					car.setPp(object1.getString("PP"));
//					car.setCx(object1.getString("CX"));
//					car.setPl(object1.getString("PL"));
//					car.setFdjxh(object1.getString("FDJXH"));
//					car.setBsqlx(object1.getString("BSQLX"));
//					car.setDws(object1.getString("DWS"));
//					car.setPfbz(object1.getString("PFBZ"));
//					car.setCldm(object1.getString("CLDM"));
//					car.setSsnf(object1.getString("SSNF"));
//					car.setTcnf(object1.getString("TCNF"));
//					car.setZdjg(object1.getString("ZDJG"));
//					car.setNlevelid(object1.getString("NLevelID"));
//					car.setSsye(object1.getString("SSYF"));
//					car.setScnf(object1.getString("SCNF"));
//					car.setNk(object1.getString("NK"));
//					car.setNx(object1.getString("NX"));
//					car.setXsmc(object1.getString("XSMC"));
//					car.setCllx(object1.getString("CLLX"));
//					car.setJb(object1.getString("JB"));
//					car.setCsxs(object1.getString("CSXS"));
//					car.setCms(object1.getString("CMS"));
//					car.setZws(object1.getString("ZWS"));
//					car.setGl(object1.getString("GL"));
//					car.setRylx(object1.getString("RYLX"));
//					car.setBsqms(object1.getString("BSQMS"));
//					car.setRybh(object1.getString("RYBH"));
//					car.setQdfs(object1.getString("QDFS"));
//					car.setFdjgs(object1.getString("FDJGS"));
//				}
//
//			}
//
//		}
//		return car;
//	}
	/**
	 * 手机号码归属地
	 * 
	 * @param toUser
	 * @param appid
	 * @param secret
	 * @return
	 * @throws Exception
	 */
	public static JSONObject getMobile( String tel) {
		StringBuffer url = new StringBuffer("http://apis.juhe.cn/mobile/get?phone=").append(tel).append("&key=d3376c6e3139bbce83baa410e00f703c");
		String ret = get(url.toString());
		
		JSONObject object = JSONObject.parseObject(ret);
		if(object.getString("resultcode").equals("200")){
			return object.getJSONObject("result");
		}else{
			return object;
		}
		
	}
	/**
	 *
	 * @param urlAll
	 *            :请求接口
	 * @param charset
	 *            :字符编码
	 * @return 返回json结果
	 */
	public static String get(String urlAll) {
		BufferedReader reader = null;
		String result = null;
		StringBuffer sbf = new StringBuffer();
		String userAgent = "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.66 Safari/537.36";// 模拟浏览器
		try {

			URL url = new URL(urlAll);

			HttpURLConnection connection = (HttpURLConnection) url
					.openConnection();

			connection.setRequestMethod("GET");
			connection.setReadTimeout(30000);
			connection.setConnectTimeout(30000);
			connection.setRequestProperty("User-agent", userAgent);
			connection.connect();
			InputStream is = connection.getInputStream();
			reader = new BufferedReader(new InputStreamReader(is, "UTF-8"));
			String strRead = null;
			while ((strRead = reader.readLine()) != null) {
				sbf.append(strRead);
				sbf.append("\r\n");
			}
			reader.close();
			result = sbf.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public static String toUtf8String(String s) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < s.length(); i++) {
			char c = s.charAt(i);
			if (c >= 0 && c <= 255) {
				sb.append(c);
			} else {
				byte[] b;
				try {
					b = String.valueOf(c).getBytes("utf-8");
				} catch (Exception ex) {

					b = new byte[0];
				}
				for (int j = 0; j < b.length; j++) {
					int k = b[j];
					if (k < 0)
						k += 256;
					sb.append("%" + Integer.toHexString(k).toUpperCase());
				}
			}
		}
		return sb.toString();
	}

	// public static void main(String[] args) throws Exception {
	// // String city = "suzhou";//参数
	// // String url =
	// "http://v.juhe.cn/wz/query?key=0d7327696435dce67ab035e44f57dcd1&city=FB_WH&hphm=%E9%84%82AZX320&hpzl=2&classno=03460";//url为请求的api接口地址
	// //
	// // String jsonResult = get(url);//得到JSON字符串
	// // System.err.print(jsonResult);
	// UUIDGenerator uu=new UUIDGenerator();
	// MongoDbUtil mongoDbUtil =new MongoDbUtil();
	// List<DBObject>
	// wzlist=mongoDbUtil.queryAll(PubConstants.CMP_WZINFO).toArray();
	// HashMap<String, Object> whereMap = new HashMap<String, Object>();
	// for(int i=0;i<wzlist.size();i++){
	// DBObject wz =wzlist.get(i);
	// WzInfo entity = (WzInfo)UniObject.DBObjectToObject(wz,WzInfo.class);
	// entity.setState(1);
	// entity.set_id(wz.get("_id").toString());
	// whereMap.put("fromUser", wz.get("_id").toString());
	// int fen=0;
	// int money=0;
	// List<DBObject>
	// lists=mongoDbUtil.queryAll(PubConstants.CMP_WZDETAIL,whereMap).toArray();
	// for(int j=0;j<lists.size();j++){
	// WzDetail wd =
	// (WzDetail)UniObject.DBObjectToObject(lists.get(j),WzDetail.class);
	// wd.setFromUser(entity.get_id().toString());
	// wd.set_id(uu.getNextValue());
	// if(StringUtils.isNotEmpty(wd.getFen())){
	// fen=fen+Integer.parseInt(wd.getFen());
	// }
	// if(StringUtils.isNotEmpty(wd.getMoney())){
	// money=money+Integer.parseInt(wd.getMoney());
	// }
	//
	// }
	// entity.setFen(fen);
	// entity.setMoney(money);
	// mongoDbUtil.insertUpdate(PubConstants.CMP_WZINFO, entity);
	//
	// }
	// }
	public static void main(String[] args) throws Exception {

//		HashMap<String, Object> whereMap = new HashMap<String, Object>();
//		
//		JuheUtil jh=new JuheUtil();
//		jh.setWzCity();
		//JSONObject js=jh.getMobile("13991284269");
		//System.err.println(js.getString("province"));
		//System.err.println(js.getString("error_code")==null);
		// String city = "suzhou";//参数
		// String url =
		// "http://v.juhe.cn/wz/query?key=0d7327696435dce67ab035e44f57dcd1&city=FB_WH&hphm=%E9%84%82AZX320&hpzl=2&classno=03460";//url为请求的api接口地址
		//
		// String jsonResult = get(url);//得到JSON字符串
		// System.err.print(jsonResult);

//		MongoDbUtil mongoDbUtil = new MongoDbUtil();
//		List<DBObject> wzlist = mongoDbUtil.queryAll(PubConstants.CMP_CAR)
//				.toArray();
//
//		for (int i = 0; i < wzlist.size(); i++) {
//			DBObject cardb = wzlist.get(i);
//
//			if (cardb.get("pP") != null) {
//				CarInfo car = (CarInfo) UniObject.DBObjectToObject(cardb,
//						CarInfo.class);
//				car.set_id(cardb.get("_id").toString());
//				car.setCjmc(cardb.get("cJMC").toString());
//				car.setPp(cardb.get("pP").toString());
//				car.setCx(cardb.get("cX").toString());
//				car.setPl(cardb.get("pL").toString());
//				car.setFdjxh(cardb.get("fDJXH").toString());
//				car.setBsqlx(cardb.get("bSQLX").toString());
//				car.setDws(cardb.get("dWS").toString());
//				car.setPfbz(cardb.get("pFBZ").toString());
//				car.setCldm(cardb.get("cLDM").toString());
//				car.setSsnf(cardb.get("sSNF").toString());
//				car.setTcnf(cardb.get("tCNF").toString());
//				car.setZdjg(cardb.get("zDJG").toString());
//				car.setNlevelid(cardb.get("nLevelID").toString());
//				car.setSsye(cardb.get("sSYF").toString());
//				car.setScnf(cardb.get("sCNF").toString());
//				car.setNk(cardb.get("nK").toString());
//				if (cardb.get("nX") != null) {
//					car.setNx(cardb.get("nX").toString());
//				}
//
//				car.setXsmc(cardb.get("xSMC").toString());
//				car.setCllx(cardb.get("cLLX").toString());
//				car.setJb(cardb.get("jB").toString());
//				car.setCsxs(cardb.get("cSXS").toString());
//				car.setCms(cardb.get("cMS").toString());
//				car.setZws(cardb.get("zWS").toString());
//				car.setGl(cardb.get("gL").toString());
//				car.setRylx(cardb.get("rYLX").toString());
//				car.setBsqms(cardb.get("bSQMS").toString());
//				car.setRybh(cardb.get("rYBH").toString());
//				car.setQdfs(cardb.get("qDFS").toString());
//				car.setFdjgs(cardb.get("fDJGS").toString());
//				mongoDbUtil.insertUpdate(PubConstants.CMP_CAR, car);
//			}

//		}
	}
}

