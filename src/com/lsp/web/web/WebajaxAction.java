package com.lsp.web.web;

import java.io.File; 
import java.io.FileOutputStream; 
import java.io.OutputStream; 
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map; 
import java.util.regex.Pattern;

import net.sf.json.JSONArray; 
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
 
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence; 
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.entity.WxToken; 
import com.lsp.pub.util.BaseDate; 
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.EncodeUtils; 
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig; 
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.WeiXinUtil; 
import com.lsp.pub.web.TotalAction; 
import com.lsp.suc.entity.Board;  
import com.lsp.suc.entity.RewardRecord; 
import com.lsp.suc.entity.WhdCount; 
import com.lsp.suc.entity.WxFriend; 
import com.lsp.user.entity.WxLoc;
import com.lsp.website.service.WwzService;
import com.lsp.weixin.entity.OilInfo; 
import com.lsp.weixin.entity.WxUserParam; 
import com.lsp.weixin.util.OtherUtil;
import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
 
/***
 * 资源管理
 * @author lsp
 *
 */
@Namespace("/web")
@Results({ @org.apache.struts2.convention.annotation.Result(name = "reload", location = "webajax.action", type = "redirect") })
public class WebajaxAction extends TotalAction {
	private static final long serialVersionUID = -7868703949557549292L;

	@Autowired
	private BaseDao baseDao;
	@Autowired
	private WwzService wwzService;
	private MongoSequence mongoSequence;

	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}
	 
	 
	/**
	 * 分享
	 * @throws Exception 
	 * @throws NumberFormatException 
	 */
	public void share() throws NumberFormatException, Exception { 
		 

	}

	public void addNews(){

		HashMap<String, Object> newssortMap = new HashMap<String, Object>();
		HashMap<String, Object> newswhereMap = new HashMap<String, Object>();
		int page = Integer.parseInt(Struts2Utils.getParameter("page"));
		String type = Struts2Utils.getParameter("type");
		String school = Struts2Utils.getParameter("school");
		if(school!=""){
			newswhereMap.put("school", school);
		}
		newswhereMap.put("type", type);

		
		newswhereMap.put("toUser", Struts2Utils.getParameter("toUser"));
		newssortMap.put("sort", 1);
		HashMap<String, Object> backMap = new HashMap<String, Object>();
		backMap.put("_id", 1);
		backMap.put("newtitle", 1);
		backMap.put("picUrl", 1);
		backMap.put("lx", 1);
		List<DBObject> newsList = baseDao.getList(PubConstants.DATA_WXNEWS,
				newswhereMap, page * 10 , 10, newssortMap, backMap);

		Struts2Utils.renderJson(newsList, new String[0]);
	}
	public void board() throws Exception{

		String toUser = Struts2Utils.getParameter("toUser");
		String fromUser = Struts2Utils.getParameter("fromUser");
		String name = Struts2Utils.getParameter("nickname");
		String sort = Struts2Utils.getParameter("sort");
		String type = Struts2Utils.getParameter("type");
		String schooltype = Struts2Utils.getParameter("schooltype");
		String fromto = Struts2Utils.getParameter("fromto");
		String content = Struts2Utils.getParameter("info");
		Board board=new Board();
		board.set_id(mongoSequence.currval(PubConstants.PRO_BOARD));
		board.setName(name);
		board.setToUser(toUser);
		board.setContent(content);
		board.setCreatedate(new Date());
		if(fromto.equals("fromto")){
			board.setFromUser(fromUser);
		}else{
			board.setFromUser(fromto);
		}

//		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		
		Map<String, Object> sub_map = new HashMap<String, Object>();
		sub_map.put("success", true);
		
		
		board.setType(type);
		board.setToUser(toUser);
		if(sort!=null){
			board.setSort(Integer.parseInt(sort));
			sub_map.put("msg", "回复成功,谢谢");
		}else{
			board.setSort(Integer.parseInt(board.get_id().toString()));
			sub_map.put("msg", "发表成功,请等待管理员的回复");
		}
 	
		baseDao.insert(PubConstants.PRO_BOARD, board);
		
		
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	public void boardone() throws Exception{

		String toUser = Struts2Utils.getParameter("toUser");
		fromUser=this.getCodeFromUser();
		String name = Struts2Utils.getParameter("nickname");
		String sort = Struts2Utils.getParameter("sort");
		String type = Struts2Utils.getParameter("type");
		String schooltype = Struts2Utils.getParameter("schooltype");
		String fromto = Struts2Utils.getParameter("fromto");
		String to=fromUser;
		String content = Struts2Utils.getParameter("info");
		Board board=new Board();
		board.set_id(mongoSequence.currval(PubConstants.PRO_BOARD));
		board.setName(name);
		board.setToUser(toUser);
		board.setContent(content);
		board.setCreatedate(new Date());
		board.setFromUser(fromUser);
		if(fromUser.equals(schooltype)){
			if(fromto.equals("fromto")){
				board.setFromUserto(fromUser);
			}else{
				board.setFromUserto(fromto);
				to=fromto;
			}
			
		}else{
			board.setFromUserto(fromUser);
			to=schooltype;
		}

//		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		
		Map<String, Object> sub_map = new HashMap<String, Object>();
		sub_map.put("success", true);
		
		
		board.setType(type);
		board.setToUser(toUser);
		if(sort!=null){
			board.setSort(Integer.parseInt(sort));
			sub_map.put("msg", "回复成功,谢谢");
		}else{
			board.setSort(Integer.parseInt(board.get_id().toString()));
			sub_map.put("msg", "发表成功,请等待管理员的回复");
		}
		

		baseDao.insert(PubConstants.PRO_BOARD, board);
		
		
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
 
	/**
	 * 签到
	 * @throws Exception
	 */
	public void wxsign() throws Exception{
		fromUser=Struts2Utils.getSession().getAttribute("fromLogin").toString();
		
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		
			
			String insdate = DateFormat.getSampleDate(new Date());
			whereMap.clear();	
			whereMap.put("insdate", insdate);
			whereMap.put("fromUser", fromUser);
			whereMap.put("lx", 99);
			long wc = baseDao.getCount(PubConstants.WHD_WHDCOUNT, whereMap);
			if(wc>0){//已签到过
				sub_map.put("status", "2");
				
			}else{
				sub_map.put("status", "0");
				
				 
				
				WhdCount wcc = new WhdCount();
		
				wcc.setFromUser(fromUser);
				wcc.setInsdate(insdate);
				wcc.setWid(1L);
				wcc.setTpid(0L);
				wcc.setLx(99);
				wcc.setCreatedate(new Date());
				baseDao.insert(PubConstants.WHD_WHDCOUNT, wcc);
				 
			
		}
		
		
		
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	
	}
	/**
	 * 签到
	 * @throws Exception
	 */
	public void addfriend() throws Exception{
		fromUser=this.getCodeFromUser();
		String friend=Struts2Utils.getParameter("friend");
		
		Map<String, Object> sub_map = new HashMap<String, Object>();
		
		WxFriend wf=new WxFriend();
		wf.setFromUser(fromUser);
		wf.setFriendUser(friend);
		wf.setCreatedate(new Date());
		wf.setType("查找");
		wf.set_id(wf.getFromUser()+"-"+wf.getFriendUser());
		baseDao.insert(PubConstants.WX_FRIEND, wf);
		
		WxFriend wf1=new WxFriend();
		wf1.setFromUser(friend);
		wf1.setFriendUser(fromUser);
		wf1.setCreatedate(new Date());
		wf1.setType("查找");
		wf1.set_id(wf1.getFromUser()+"-"+wf1.getFriendUser());
		baseDao.insert(PubConstants.WX_FRIEND, wf1);
		
		sub_map.put("state", 1);
		
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	
	}
	/**
	 * 删除用户
	 * @throws Exception
	 */
	public void delfriend() throws Exception{
		fromUser=this.getCodeFromUser();
		String friend=Struts2Utils.getParameter("friend");
		
		Map<String, Object> sub_map = new HashMap<String, Object>();
		
		baseDao.delete(PubConstants.WX_FRIEND, fromUser+"-"+friend);

		sub_map.put("state", 1);
		
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	
	}
	/**
	 * 保存位置
	 * @throws Exception
	 */
	public void putloc() throws Exception{
		fromUser=this.getCodeFromUser();
		String lon=Struts2Utils.getParameter("lon");
		String lat=Struts2Utils.getParameter("lat");
		WxLoc wxloc=new WxLoc();
		toUser=Struts2Utils.getParameter("toUser");
		List<Double> loc=new ArrayList<Double>();
		loc.add(Double.parseDouble(lon));
		loc.add(Double.parseDouble(lat));
		wxloc.set_id(fromUser);
		wxloc.setToUser(toUser); 
		wxloc.setFromUser(fromUser);
		wxloc.setLoc(loc);
		wxloc.setCreatedate(new Date().getTime());
		baseDao.insert(PubConstants.WX_LOC, wxloc);
		wxloc.set_id(mongoSequence.currval(PubConstants.WX_LOC));
		baseDao.insert(PubConstants.WX_LOCHIS, wxloc);
		Map<String, Object> sub_map = new HashMap<String, Object>();
		sub_map.put("state", 1);
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
 
	/**
	 * 获取位置
	 * @throws Exception
	 */
	public void getoil() throws Exception{
		
		String province=Struts2Utils.getParameter("province").replace("省", "").replace("市", "");
		String rybh=Struts2Utils.getParameter("rybh");
		String price="";
		DBObject oil=baseDao.getMessage(PubConstants.SET_OIL, province);
		if(oil==null){
			OilInfo oilentity= OtherUtil.getOil(province);
			if(rybh.equals("0")){
				price=oilentity.getOil0();
			}else if(rybh.equals("90")){
				price=oilentity.getOil90();
			}else if(rybh.equals("93")){
				price=oilentity.getOil93();
			}else if(rybh.equals("97")){
				price=oilentity.getOil97();
			}else{
				price=oilentity.getOil93();
			}
		}else{
			if(rybh.equals("0#")){
				price=oil.get("oil0").toString();
			}else if(rybh.equals("90")){
				price=oil.get("oil90").toString();
			}else if(rybh.equals("93")){
				price=oil.get("oil93").toString();
			}else if(rybh.equals("97")){
				price=oil.get("oil97").toString();
			}else{
				price=oil.get("oil93").toString();
			}
		}
		
		Map<String, Object> sub_map = new HashMap<String, Object>();
		sub_map.put("state", 1);
		sub_map.put("price", price);
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	 
	/**
	 * 获得更多客户资源
	 * @return
	 * @throws Exception 
	 */
	public void ajaxticket() throws Exception {

		fromUser=this.getCodeFromUser();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		BasicDBList dbList=new BasicDBList();  //翻译数组对象
		whereMap.put("fromUser", fromUser);
	
		Pattern pattern = Pattern.compile("^.*ticket.*$",
				Pattern.CASE_INSENSITIVE);
		whereMap.put("wid", pattern);
		List<DBObject> ticket = baseDao.getList(PubConstants.RF_FROMADMIN, whereMap,sortMap);//我的客户
		for(DBObject db:ticket){
			dbList.add(Integer.parseInt(db.get("wid").toString().replace("ticket", "")));
		}
		whereMap.clear();
		sortMap.put("createdate", -1);
		whereMap.put("ly",  new BasicDBObject("$in",dbList));
		List<DBObject> userList = baseDao.getList(PubConstants.DATA_WXUSER, whereMap,fypage,10,sortMap);//我的客户
		for(DBObject db:userList){
			DBObject car=baseDao.getMessage(PubConstants.CMP_CAR, db.get("_id").toString());
			if(car==null||car.get("pp")==null||car.get("cx")==null){
				
			}else{
				db.put("pp", car.get("pp").toString());
				db.put("cx", car.get("cx").toString());
			}
			if(db.get("createdate")!=null){
				db.put("createdate", DateFormat.getSampleDate(DateFormat.getFormat(db.get("createdate").toString())));
			}
			if(db.get("nickname")==null){
				db.put("nickname", "");
			}
		}

		sub_map.put("state", 0);
		sub_map.put("list", userList);
		String json = JSONArray.fromObject(sub_map).toString();
		
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * 获得更多客户资源
	 * @return
	 * @throws Exception 
	 */
	public void ajaxdrawbox() throws Exception {

		
		Map<String, Object> sub_map = new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		
		whereMap.put("hdid", Long.parseLong(Struts2Utils.getParameter("_id")));
	
		List<DBObject> list=baseDao.getList(PubConstants.WHD_REWARDRECORD,whereMap,fypage,10, sortMap);
		for(DBObject db:list){
			if(db.get("fromUser")!=null){
				if(db.get("insDate")!=null){
					db.put("insDate", DateFormat.getSampleDate(DateFormat.getFormat(db.get("insDate").toString())));
				}
				DBObject user=baseDao.getMessage(PubConstants.DATA_WXUSER, db.get("fromUser").toString());
				if(user!=null){
					if(user.get("headimgurl")!=null){
						db.put("headimgurl", user.get("headimgurl").toString());
					}
					if(user.get("tel")!=null){
						db.put("tel", user.get("tel").toString());
					}else{
						db.put("tel", "");
					}
					if(user.get("no")!=null){
						db.put("no", user.get("no").toString());
					}else{
						db.put("no", "");
					}
					if(user.get("nickname")!=null){
						db.put("nickname", user.get("nickname").toString());
					}
					
				}
			}
			
				
		}
		if(list.size()>0){
			sub_map.put("state", 0);
			sub_map.put("list", list);
		}else{
			sub_map.put("state",1);
		}
		
		String json = JSONArray.fromObject(sub_map).toString();
		
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * 获得更多客户资源
	 * @return
	 * @throws Exception 
	 */
	public void drawboxdj() throws Exception {

		
		Map<String, Object> sub_map = new HashMap<String, Object>();
		
		Long _id=Long.parseLong(Struts2Utils.getParameter("_id"));
		DBObject db=baseDao.getMessage(PubConstants.WHD_REWARDRECORD,_id);
		RewardRecord rr=(RewardRecord)UniObject.DBObjectToObject(db,RewardRecord.class);
		rr.set_id(_id);
		rr.setState(1);
		baseDao.insert(PubConstants.WHD_REWARDRECORD, rr);
		sub_map.put("state", 0);
		
		String json = JSONArray.fromObject(sub_map).toString();
		
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}

	/**
	 * 裁剪上传图片
	 * @return
	 * @throws Exception 
	 */
	public void upimage() throws Exception {

		String baseurl=Struts2Utils.getParameter("baseurl"); 
		String type=baseurl.substring(0,baseurl.indexOf(";"));
		type=type.substring(type.indexOf("/")+1);
		String path=BaseDate.getDayUuid()+"-upimage."+type;  
		String imgBase64=baseurl.substring(baseurl.indexOf(",")+1); 
		byte[]files=EncodeUtils.decodeBuffer(imgBase64); 
	    File filess=new File(SysConfig.getProperty("imgpath"));
		if(!filess.exists()){
			filess.mkdir();  
		}  
		File  createFile=new File(SysConfig.getProperty("imgpath")+"/"+path); 
		OutputStream  fileWrite=new FileOutputStream(createFile);  
		fileWrite.write(files); 
		    
		fileWrite.flush();
		fileWrite.close();
		   
		//File file=CodeImageUtil.base64StringToImage(baseurl,"/uploads/"+path);
		Map<String, Object> sub_map = new HashMap<String, Object>();
		sub_map.put("state", 0); 
		sub_map.put("path", path);
		String json = JSONArray.fromObject(sub_map).toString();
		 
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
 
	/**
	 * 微信通知
	 * @return
	 * @throws Exception 
	 */
	public void userwxtz() throws Exception {
		fromUser=this.getCodeFromUser();
		
		Map<String, Object> sub_map = new HashMap<String, Object>();
		sub_map.put("state", 0);
		int state=Integer.parseInt(Struts2Utils.getParameter("state"));
		WxUserParam param=new WxUserParam();
		DBObject pdb=baseDao.getMessage(PubConstants.WX_USERPARAM,fromUser);
		if(pdb!=null){
			param=(WxUserParam) UniObject.DBObjectToObject(pdb, WxUserParam.class);
		}
		
		param.set_id(fromUser);
		param.setWx(state);
		param.setInsdate(new Date());
		param.setToUser(toUser);
		baseDao.insert(PubConstants.WX_USERPARAM, param);
		
		String json = JSONArray.fromObject(sub_map).toString();
		
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	 
  
 
}
