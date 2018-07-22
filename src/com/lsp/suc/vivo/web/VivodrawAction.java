package com.lsp.suc.vivo.web; 
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.SortedMap;
import java.util.TreeMap;
import java.util.regex.Pattern;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired; 
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.Code;
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.entity.WxToken;
import com.lsp.pub.util.BaseDate;
import com.lsp.pub.util.BaseDecimal;
import com.lsp.pub.util.CommonUtil;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.DateUtil;
import com.lsp.pub.util.ExportExcel; 
import com.lsp.pub.util.JmsService;
import com.lsp.pub.util.MathUtil;
import com.lsp.pub.util.PayCommonUtil;
import com.lsp.pub.util.RelativeDate;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig; 
import com.lsp.pub.util.TenpayUtil;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.UserUtil;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.util.XMLUtil;
import com.lsp.pub.web.GeneralAction;    
import com.lsp.suc.entity.WhdCount;
import com.lsp.suc.vivo.entity.Card;
import com.lsp.suc.vivo.entity.CardRecord;
import com.lsp.suc.vivo.entity.DjCode;
import com.lsp.suc.vivo.entity.LeaderBoard;
import com.lsp.suc.vivo.entity.LuckyEmployees;
import com.lsp.suc.vivo.entity.Vivodraw;
import com.lsp.suc.vivo.entity.VivoReward;
import com.lsp.suc.vivo.entity.VivoRewardRecord;
import com.lsp.website.service.WwzService;
import com.lsp.weixin.entity.RedpackInfo;
import com.lsp.weixin.entity.WxPayConfig;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBObject;
import com.sun.org.apache.bcel.internal.generic.NEW;
 
/**
 * vivo抽奖管理
 * @author lsp
 *
 */
@Namespace("/suc/vivo")
@Results( { @Result(name = VivodrawAction.RELOAD, location = "vivodraw.action",params={"fypage", "%{fypage}"}, type = "redirect") })
public class VivodrawAction extends GeneralAction<Vivodraw> {

	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private MongoSequence mongoSequence;	
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}
	@Autowired
	private WwzService wwzService;
	
	private Vivodraw entity=new Vivodraw();
	private Long _id;


	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		custid=SpringSecurityUtils.getCurrentUser().getId();
		Struts2Utils.getRequest().setAttribute("custid",custid);
		sortMap.put("sort", -1);
		boolean isxs=false;
		if(SpringSecurityUtils.getCurrentUser().getComid()==null){
			whereMap.put("custid", SpringSecurityUtils.getCurrentUser().getId());
			isxs=true;
		}else{
			whereMap.put("comid", SpringSecurityUtils.getCurrentUser().getComid());
			if(StringUtils.isNotBlank(SpringSecurityUtils.getCurrentUser().getWwzqx())){
				isxs=SpringSecurityUtils.getCurrentUser().getWwzqx().contains("sc_drawbox");
			}
			
		}
		
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		HashMap<String, Object> backMap =new HashMap<String, Object>();
		backMap.put("context", 0);
		backMap.put("summary", 0);
		String name=Struts2Utils.getParameter("name");
		if(StringUtils.isNotEmpty(name)){
			Pattern pattern = Pattern.compile("^.*" + name + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern);
			Struts2Utils.getRequest().setAttribute("name",  name);
		}
		String  lx=Struts2Utils.getParameter("lx");
		if(StringUtils.isNotEmpty(lx))
		{
			whereMap.put("lx", Integer.parseInt(lx));
			
		}
		
		List<DBObject> list=baseDao.getList(PubConstants.SUC_VIVO_LUCKYDROW,whereMap,fypage,10, sortMap,backMap);
		for(DBObject db:list){
			db.put("yds", wwzService.getFlow(custid, "drawvivo_"+db.get("_id").toString()));
			db.put("nickname", wwzService.getCustName(db.get("custid").toString()));
			
			Vivodraw vivodraw=(Vivodraw) UniObject.DBObjectToObject(db,Vivodraw.class);
			List<VivoReward>reward=vivodraw.getReward();
			List<HashMap<String, Object>>lsps=new ArrayList<>();
			for (int i = 0; i < reward.size(); i++) {
				HashMap<String, Object> mp=new HashMap<>();
				//json转换对象的时候需要指定类
				JsonConfig jsonConfig = new JsonConfig(); 
				jsonConfig.setRootClass(VivoReward.class);
				Map<String, Class> classMap = new HashMap<String, Class>();
				classMap.put("students", VivoReward.class); // 指定JsonRpcRequest的request字段的内部类型
				jsonConfig.setClassMap(classMap);
				VivoReward ent = (VivoReward) JSONObject.toBean(JSONObject.fromObject(reward.get(i)), jsonConfig);
			    whereMap.clear();
			    whereMap.put("hdid",Long.parseLong(db.get("_id").toString()));
			    whereMap.put("no",Long.parseLong(ent.get_id().toString()));
			    Long count=baseDao.getCount(PubConstants.SUC_VIVO_REWARDRECORD, whereMap);
			    mp.put("count",count);
			    mp.put("jp",ent.getJp());
			    mp.put("total", ent.getTotal());
			    lsps.add(mp); 
			}
			db.put("lsps", lsps);
			

			whereMap.clear();
			whereMap.put("lx",7);
			whereMap.put("wid",Long.parseLong(db.get("_id").toString()));
			db.put("icount",baseDao.getCount(PubConstants.WHD_WHDCOUNT,whereMap)); 
			whereMap.clear();
			whereMap.put("hdid",Long.parseLong(db.get("_id").toString()));
			db.put("redcount", baseDao.getCount(PubConstants.SUC_VIVO_REWARDRECORD,whereMap));
		}
		Struts2Utils.getRequest().setAttribute("DrawboxList", list);
		Struts2Utils.getRequest().setAttribute("isxs", isxs);
		fycount=baseDao.getCount(PubConstants.SUC_VIVO_LUCKYDROW, whereMap);
		 
		 
		return SUCCESS;
	}
	

	@Override
	public String delete() throws Exception {
		try {
			baseDao.delete(PubConstants.SUC_VIVO_LUCKYDROW,_id);
			HashMap<String, Object> whereMap =new HashMap<String, Object>();
			whereMap.put("custid",SpringSecurityUtils.getCurrentUser().getId()); 
			whereMap.put("hdid", _id);
			baseDao.delete(PubConstants.SUC_VIVO_REWARDRECORD,whereMap);
		
			addActionMessage("成功删除!");
			
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,删除过程中出现异常!");
		}
		return RELOAD;
	}
 
	@Override
	public String input() throws Exception {
		 
		return "add";
	}
	
	@Override
	public String update() throws Exception {	
	    Struts2Utils.getRequest().setAttribute("entity",baseDao.getMessage(PubConstants.SUC_VIVO_LUCKYDROW,_id));
		return "add";
	}
	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			//有custId查出来 用户信息
			DBObject box=baseDao.getMessage(PubConstants.SUC_VIVO_LUCKYDROW,_id);
			entity = (com.lsp.suc.vivo.entity.Vivodraw)UniObject.DBObjectToObject(box,com.lsp.suc.vivo.entity.Vivodraw.class);
			JSONArray  json = JSONArray.fromObject(box.get("reward"));
			Struts2Utils.getRequest().setAttribute("reward", json);
		} else {
			entity = new com.lsp.suc.vivo.entity.Vivodraw();
		}
	}
	
	

	@Override
	public String save() throws Exception {
		//注册业务逻辑
		try {
			if(_id == null){
				_id=mongoSequence.currval(PubConstants.SUC_VIVO_LUCKYDROW);	
			}
			custid=SpringSecurityUtils.getCurrentUser().getId();
			entity.set_id(_id);
			entity.setCustid(custid); 
			entity.setCreatedate(new Date());
			entity.setStartdate(DateFormat.StringToDate(Struts2Utils.getParameter("startdate")+":00"));
			entity.setEnddate(DateFormat.StringToDate(Struts2Utils.getParameter("enddate")+":00"));
		    double  counts=Double.parseDouble(Struts2Utils.getParameter("counts")); 
			List<VivoReward> reward=new ArrayList<VivoReward>();
			for(int i=0;i<6;i++){ 
				Double bl=Double.parseDouble(Struts2Utils.getParameter("jpnum"+i))/counts; 
				VivoReward re=new VivoReward();
				re.set_id(i);
				re.setNo(i);
				re.setJp(Struts2Utils.getParameter("jp"+i));
				re.setTotal(Integer.parseInt(Struts2Utils.getParameter("jpnum"+i)));
				re.setZjl(Integer.parseInt(new java.text.DecimalFormat("#").format(bl*1000)));
				if(re.getZjl()<=0){
					re.setZjl(1);
				}
				if(StringUtils.isNotEmpty(Struts2Utils.getParameter("jjid"+i))){
					re.setJjid(Long.parseLong(Struts2Utils.getParameter("jjid"+i)));
					re.setMethod(SysConfig.getProperty("ip")+"/wwz/wwz!preferential.action?_id="+re.getJjid()+"&toUser="+toUser);
				}
				
				reward.add(re);
				if(entity.getLx()==2){
					//ImagesUtil.createImage(" "+re.getJp()+" ",new Font("黑体",Font.PLAIN,24),new File(SysConfig.getProperty("filePath")+"/whd/images/drawbox-"+entity.get_id().toString()+re.getNo()+".png"));
				}
			}
			entity.setReward(reward);
			entity.setSummary(entity.getSummary().trim().replaceAll("\n", "").replaceAll("\"", ""));
			//entity.setEwmurl(wwzService.recode("luckydraw-mbTicket-"+_id,SysConfig.getProperty("ip")+"/suc/luckydraw!mbTicket.action?custid="+custid+"&lucid="+_id, entity.getPicurl(),true, 200, 1000));
			baseDao.insert(PubConstants.SUC_VIVO_LUCKYDROW,entity);
			
			
			addActionMessage("成功添加!");
			
		
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return RELOAD;
	}
	public String hdtj() throws Exception {
		custid=SpringSecurityUtils.getCurrentUser().getId();
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		String hdid=Struts2Utils.getParameter("hdid");
		Struts2Utils.getRequest().setAttribute("hdid", hdid); 
		//中奖码
		String zjm=Struts2Utils.getParameter("zjm");
		if(StringUtils.isNotEmpty(zjm)){
			Pattern pattern = Pattern.compile("^.*" + zjm + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("yhj", pattern);
			Struts2Utils.getRequest().setAttribute("zjm",  zjm);
		}
		//会员号
		String vno=Struts2Utils.getParameter("vno");
		if(StringUtils.isNotEmpty(vno)){
			whereMap.put("fromUserid", wwzService.getfromUseridVipNo(vno));		 
		   Struts2Utils.getRequest().setAttribute("vno",  vno);
		}
		//奖品
		String jp=Struts2Utils.getParameter("jp");
		if(StringUtils.isNotEmpty(jp)){
			Pattern pattern = Pattern.compile("^.*" + jp + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("jp", pattern);
			Struts2Utils.getRequest().setAttribute("jp",  jp);
		}
		String state=Struts2Utils.getParameter("state");
		if(StringUtils.isNotEmpty(state)){
			whereMap.put("state", Integer.parseInt(state));
			Struts2Utils.getRequest().setAttribute("state",  state);
		}
		whereMap.put("hdid", Long.parseLong(hdid));
		sortMap.put("insDate", -1);
		if(Struts2Utils.getParameter("fypage")!=null){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		fycount=baseDao.getCount(PubConstants.SUC_VIVO_REWARDRECORD, whereMap);
		List<DBObject> list=baseDao.getList(PubConstants.SUC_VIVO_REWARDRECORD,whereMap,fypage,10, sortMap);
		for(DBObject db:list){
			if(db.get("fromUserid")!=null){
				HashMap<String, Object>uMap=new HashMap<>();
				uMap.put("fromid", db.get("fromUserid").toString()); 
				DBObject dbObject2=baseDao.getMessage(PubConstants.SUC_VIVO_EMPLOYEES, uMap);
				if (dbObject2!=null) {
					db.put("uname",dbObject2.get("name"));
				}
			 
			}
			
				
		} 
		Struts2Utils.getRequest().setAttribute("rewardList", list);

		return "hdtj";
	}
	
	public String cardtj() throws Exception {
		custid=SpringSecurityUtils.getCurrentUser().getId();
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		String hdid=Struts2Utils.getParameter("hdid");
		Struts2Utils.getRequest().setAttribute("hdid", hdid); 
		String selfromid=Struts2Utils.getParameter("selfromid");
		if (StringUtils.isNotEmpty(selfromid)) {
			whereMap.put("fromUserid", selfromid);
		}
		Struts2Utils.getRequest().setAttribute("selfromid", selfromid);
		//中奖码
		String zjm=Struts2Utils.getParameter("zjm");
		if(StringUtils.isNotEmpty(zjm)){
			Pattern pattern = Pattern.compile("^.*" + zjm + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("yhj", pattern);
			Struts2Utils.getRequest().setAttribute("zjm",  zjm);
		}
		//会员号
		String vno=Struts2Utils.getParameter("vno");
		if(StringUtils.isNotEmpty(vno)){
			whereMap.put("fromUserid", wwzService.getfromUseridVipNo(vno));		 
		   Struts2Utils.getRequest().setAttribute("vno",  vno);
		}
		//奖品
		String jp=Struts2Utils.getParameter("jp");
		if(StringUtils.isNotEmpty(jp)){
			Pattern pattern = Pattern.compile("^.*" + jp + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("jp", pattern);
			Struts2Utils.getRequest().setAttribute("jp",  jp);
		}
		String state=Struts2Utils.getParameter("state");
		if(StringUtils.isNotEmpty(state)){
			whereMap.put("state", Integer.parseInt(state));
			Struts2Utils.getRequest().setAttribute("state",  state);
		} 
		if(Struts2Utils.getParameter("fypage")!=null){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		fycount=baseDao.getCount(PubConstants.SUC_VIVO_CARDREWARD, whereMap);
		List<DBObject> list=baseDao.getList(PubConstants.SUC_VIVO_CARDREWARD,whereMap,fypage,10, sortMap);
		for(DBObject db:list){
			if(db.get("fromid")!=null){
				HashMap<String, Object>uMap=new HashMap<>();
				uMap.put("fromid", db.get("fromUserid")); 
				DBObject dbObject2=baseDao.getMessage(PubConstants.SUC_VIVO_EMPLOYEES, uMap);
				if (dbObject2!=null) {
					db.put("uname",dbObject2.get("name"));
				}
			 
			}
			
				
		} 
		Struts2Utils.getRequest().setAttribute("rewardList", list);

		return "cardtj";
	}
	/**
	 * 卡片管理
	 * @return
	 * @throws Exception
	 */
	public String card() throws Exception {
		custid=SpringSecurityUtils.getCurrentUser().getId();
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		String hdid=Struts2Utils.getParameter("hdid");
		Struts2Utils.getRequest().setAttribute("hdid", hdid);
		//中奖码
		String title=Struts2Utils.getParameter("title");
		if(StringUtils.isNotEmpty(title)){
			Pattern pattern = Pattern.compile("^.*" + title + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern);
			Struts2Utils.getRequest().setAttribute("title",  title);
		}
		//会员号
		String vno=Struts2Utils.getParameter("vno");
		if(StringUtils.isNotEmpty(vno)){
			whereMap.put("fromUserid", wwzService.getfromUseridVipNo(vno));		 
		   Struts2Utils.getRequest().setAttribute("vno",  vno);
		}
		//奖品
		String jp=Struts2Utils.getParameter("jp");
		if(StringUtils.isNotEmpty(jp)){
			Pattern pattern = Pattern.compile("^.*" + jp + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("jp", pattern);
			Struts2Utils.getRequest().setAttribute("jp",  jp);
		}
		String state=Struts2Utils.getParameter("state");
		if(StringUtils.isNotEmpty(state)){
			whereMap.put("state", Integer.parseInt(state));
			Struts2Utils.getRequest().setAttribute("state",  state);
		} 
		sortMap.put("createdate", -1);
		if(Struts2Utils.getParameter("fypage")!=null){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		fycount=baseDao.getCount(PubConstants.SUC_VIVO_CARD, whereMap);
		List<DBObject> list=baseDao.getList(PubConstants.SUC_VIVO_CARD,whereMap,fypage,10, sortMap);
		//加载卡片活动信息
		for (DBObject dbObject : list) {
			Long id=Long.parseLong(dbObject.get("_id").toString());
			HashMap<String,Object>ucMap=new HashMap<>();
			ucMap.put("card._id",id); 
			Long count=baseDao.getCount(PubConstants.SUC_VIVO_CARDREWARD,ucMap);
			dbObject.put("ucount", count);
		} 
		Struts2Utils.getRequest().setAttribute("list", list);
		Struts2Utils.getRequest().setAttribute("cardcount",baseDao.getCount(PubConstants.SUC_VIVO_CARDREWARD));
		whereMap.clear();
		whereMap.put("lx",8);
		Struts2Utils.getRequest().setAttribute("icount",baseDao.getCount(PubConstants.WHD_WHDCOUNT,whereMap));
		

		return "card";
	}
	
	/**
	 * 会员管理
	 * @return
	 * @throws Exception
	 */
	public String members() throws Exception {
		custid=SpringSecurityUtils.getCurrentUser().getId();
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		String hdid=Struts2Utils.getParameter("hdid");
		Struts2Utils.getRequest().setAttribute("hdid", hdid);
		//中奖码
		String title=Struts2Utils.getParameter("title");
		if(StringUtils.isNotEmpty(title)){
			Pattern pattern = Pattern.compile("^.*" + title + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("name", pattern);
			Struts2Utils.getRequest().setAttribute("title",  title);
		}
		//会员号
		String vno=Struts2Utils.getParameter("vno");
		if(StringUtils.isNotEmpty(vno)){
			whereMap.put("fromUserid", wwzService.getfromUseridVipNo(vno));		 
		   Struts2Utils.getRequest().setAttribute("vno",  vno);
		}
		//奖品
		String jp=Struts2Utils.getParameter("jp");
		if(StringUtils.isNotEmpty(jp)){
			Pattern pattern = Pattern.compile("^.*" + jp + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("jp", pattern);
			Struts2Utils.getRequest().setAttribute("jp",  jp);
		}
		String state=Struts2Utils.getParameter("state");
		if(StringUtils.isNotEmpty(state)){
			whereMap.put("state", Integer.parseInt(state));
			Struts2Utils.getRequest().setAttribute("state",  state);
		}
		sortMap.put("createdate", -1);
		if(Struts2Utils.getParameter("fypage")!=null){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		fycount=baseDao.getCount(PubConstants.SUC_VIVO_EMPLOYEES, whereMap);
		List<DBObject> list1=baseDao.getList(PubConstants.SUC_VIVO_EMPLOYEES,whereMap,fypage,10, sortMap);
	 
		for (DBObject dbObject1 : list1) {
			HashMap<String, Object>whereqMap=new HashMap<>();
			if(dbObject1.get("fromid")!=null){
				whereqMap.put("fromUserid", dbObject1.get("fromid").toString());
				HashMap<String, Object>sortqMap=new HashMap<>();
				sortMap.put("createdate", -1);
				List<DBObject>list=baseDao.getList(PubConstants.SUC_VIVO_CARDREWARD, whereqMap, sortqMap);
				List<DBObject>nelist=new ArrayList<>(); 
				System.out.println("-------"+list.size());
				
				HashMap<String, Integer>sMap=new HashMap<>(); 
				for (DBObject dbObject : list) {
					CardRecord cardRecord=(CardRecord) UniObject.DBObjectToObject(dbObject, CardRecord.class);
					cardRecord.getCard();
					 
					if(nelist.size()==0) {
						nelist.add(cardRecord);
						sMap.put(cardRecord.getCard().get_id().toString(), 1);
					}else {
						if(sMap.get(cardRecord.getCard().get_id().toString())==null) {
							nelist.add(cardRecord);
							sMap.put(cardRecord.getCard().get_id().toString(), 1);
							System.out.println("添加成功"); 
						}else { 
							sMap.put(cardRecord.getCard().get_id().toString(), sMap.get(cardRecord.getCard().get_id().toString())+1);
						}
						 
					}
				
					
				} 
				
				for (DBObject dbObject : nelist) {
					CardRecord cardRecord=(CardRecord) UniObject.DBObjectToObject(dbObject, CardRecord.class);
					cardRecord.getCard();
					dbObject.put("lx",sMap.get(cardRecord.getCard().get_id().toString()));
				}
				System.out.println("-------11"+list.size());
				//Struts2Utils.getRequest().setAttribute("list", list); 
				//Struts2Utils.getRequest().setAttribute("nelist", nelist);
				dbObject1.put("list_size", list.size());
				dbObject1.put("nelist_size", nelist.size());
				if (list.size()>=32) {
					Struts2Utils.getRequest().setAttribute("isdj",0);
				}else {
					Struts2Utils.getRequest().setAttribute("isdj",-1);
				}
			}
			
		}
		Struts2Utils.getRequest().setAttribute("list", list1);

		return "members";
	}
	
	/**
	 * 会员卡包
	 * @return
	 * @throws Exception
	 */
	public String cardrecord() throws Exception {
		custid=SpringSecurityUtils.getCurrentUser().getId();
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		String hdid=Struts2Utils.getParameter("hdid");
		Struts2Utils.getRequest().setAttribute("hdid", hdid);
		//中奖码
		String zjm=Struts2Utils.getParameter("zjm");
		if(StringUtils.isNotEmpty(zjm)){
			Pattern pattern = Pattern.compile("^.*" + zjm + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("yhj", pattern);
			Struts2Utils.getRequest().setAttribute("zjm",  zjm);
		}
		//会员号
		String vno=Struts2Utils.getParameter("vno");
		if(StringUtils.isNotEmpty(vno)){
			whereMap.put("fromUserid", wwzService.getfromUseridVipNo(vno));		 
		   Struts2Utils.getRequest().setAttribute("vno",  vno);
		}
		//奖品
		String jp=Struts2Utils.getParameter("jp");
		if(StringUtils.isNotEmpty(jp)){
			Pattern pattern = Pattern.compile("^.*" + jp + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("jp", pattern);
			Struts2Utils.getRequest().setAttribute("jp",  jp);
		}
		String state=Struts2Utils.getParameter("state");
		if(StringUtils.isNotEmpty(state)){
			whereMap.put("state", Integer.parseInt(state));
			Struts2Utils.getRequest().setAttribute("state",  state);
		} 
		sortMap.put("createdate", -1);
		if(Struts2Utils.getParameter("fypage")!=null){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		fycount=baseDao.getCount(PubConstants.SUC_VIVO_CARD, whereMap);
		List<DBObject> list=baseDao.getList(PubConstants.SUC_VIVO_CARD,whereMap,fypage,10, sortMap);
	 
		Struts2Utils.getRequest().setAttribute("list", list);

		return "cardrecord";
	}
	

	/**
	 * 兑奖码管理
	 * @return
	 * @throws Exception
	 */
	public String djcode() throws Exception {
		custid=SpringSecurityUtils.getCurrentUser().getId();
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		String hdid=Struts2Utils.getParameter("hdid");
		Struts2Utils.getRequest().setAttribute("hdid", hdid);
		//中奖码
		String djcode=Struts2Utils.getParameter("djcode");
		if(StringUtils.isNotEmpty(djcode)){
			Pattern pattern = Pattern.compile("^.*" + djcode + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("code", pattern);
			Struts2Utils.getRequest().setAttribute("djcode",  djcode);
		}
		String djtel=Struts2Utils.getParameter("djtel");
		if(StringUtils.isNotEmpty(djtel)) {
			HashMap<String, Object> telMap =new HashMap<String, Object>();
			telMap.put("tel",djtel);
			whereMap.put("fromid", baseDao.getMessage(PubConstants.SUC_VIVO_EMPLOYEES, telMap).get("fromid").toString());
			Struts2Utils.getRequest().setAttribute("djtel",  djtel);
		}
		//会员号
		String vno=Struts2Utils.getParameter("vno");
		if(StringUtils.isNotEmpty(vno)){
			whereMap.put("fromUserid", wwzService.getfromUseridVipNo(vno));		 
		   Struts2Utils.getRequest().setAttribute("vno",  vno);
		}
		//奖品
		String jp=Struts2Utils.getParameter("jp");
		if(StringUtils.isNotEmpty(jp)){
			Pattern pattern = Pattern.compile("^.*" + jp + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("jp", pattern);
			Struts2Utils.getRequest().setAttribute("jp",  jp);
		}
		String state=Struts2Utils.getParameter("state");
		if(StringUtils.isNotEmpty(state)){
			whereMap.put("state", Integer.parseInt(state));
			Struts2Utils.getRequest().setAttribute("state",  state);
		} 
		sortMap.put("createdate", -1);
		if(Struts2Utils.getParameter("fypage")!=null){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		fycount=baseDao.getCount(PubConstants.SUC_VIVO_DJCODE, whereMap);
		List<DBObject> list=baseDao.getList(PubConstants.SUC_VIVO_DJCODE,whereMap,fypage,10, sortMap); 
		for (DBObject dbObject : list) {
			if (dbObject.get("fromid")!=null) {
				String fromid=dbObject.get("fromid").toString();
				HashMap<String, Object>uMap=new HashMap<>();
				uMap.put("fromid", fromid); 
				DBObject dbObject2=baseDao.getMessage(PubConstants.SUC_VIVO_EMPLOYEES, uMap);
				if (dbObject2!=null) {
					dbObject.put("uname",dbObject2.get("name"));
				}
				
				
			}
			
		}
		Struts2Utils.getRequest().setAttribute("list", list);

		return "djcode";
	}
	/**
	 * 卡片保存
	 * @return
	 * @throws Exception
	 */
	public void cardsave() throws Exception {
		Map<String, Object>map=new HashMap<>();
		map.put("state",1);
		custid=SpringSecurityUtils.getCurrentUser().getId();
		String title=Struts2Utils.getParameter("title");
		String picurl=Struts2Utils.getParameter("picurl");
		String total=Struts2Utils.getParameter("total");
		String sort=Struts2Utils.getParameter("sort");
		String zjl=Struts2Utils.getParameter("zjl");
		String url=Struts2Utils.getParameter("url");
		Card card=null;
		if (_id==null) {
			card=new Card();
			card.set_id(mongoSequence.currval(PubConstants.SUC_VIVO_CARD));
		}else {
			card=(Card) UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.SUC_VIVO_CARD, _id), Card.class);
			card.set_id(_id);
		}
		
		card.setCreatedate(new Date());
		card.setLogo(picurl);
		card.setCustid(SpringSecurityUtils.getCurrentUser().getId());
		if (StringUtils.isNotEmpty(sort)) {
			card.setSort(Integer.parseInt(sort));
		} 
		if (StringUtils.isNotEmpty(total)) {
			card.setTotal(Integer.parseInt(total));
		}
		if (StringUtils.isNotEmpty(zjl)) {
			card.setZjl(Integer.parseInt(zjl));
		} 
		card.setUrl(url);
		card.setTitle(title);
		baseDao.insert(PubConstants.SUC_VIVO_CARD, card); 
		map.put("state",0); 
		String json = JSONArray.fromObject(map).toString();
	    Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * 卡片修改
	 * @throws Exception
	 */
	public void cardupd() throws Exception { 
		DBObject db = baseDao.getMessage(PubConstants.SUC_VIVO_CARD, _id); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}
	/**
	 * 兑换码修改
	 * @throws Exception
	 */
	public void djcodeupd() throws Exception { 
		DBObject db = baseDao.getMessage(PubConstants.SUC_VIVO_DJCODE, _id); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}
	/**
	 * 员工修改
	 * @throws Exception
	 */
	public void membersupd() throws Exception { 
		DBObject db = baseDao.getMessage(PubConstants.SUC_VIVO_EMPLOYEES, _id); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}
	/**
	 * 兑奖码保存
	 * @return
	 * @throws Exception
	 */
	public void djcodesave() throws Exception {
		Map<String, Object>map=new HashMap<>();
		map.put("state",1);
		custid=SpringSecurityUtils.getCurrentUser().getId();
		String djcode=Struts2Utils.getParameter("djcode"); 
		DjCode code=null;
		if (_id==null) {
			code=new DjCode();
			code.set_id(mongoSequence.currval(PubConstants.SUC_VIVO_DJCODE));
		}else {
			code=(DjCode) UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.SUC_VIVO_DJCODE, _id), DjCode.class);
			code.set_id(_id);
		}
		
		code.setCreatedate(new Date()); 
		code.setCustid(SpringSecurityUtils.getCurrentUser().getId());
		code.setCode(djcode); 
		baseDao.insert(PubConstants.SUC_VIVO_DJCODE, code);
		map.put("state",0); 
		String json = JSONArray.fromObject(map).toString();
	    Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 会员保存
	 * @return
	 * @throws Exception
	 */
	public void memberssave() throws Exception {
		Map<String, Object>map=new HashMap<>();
		map.put("state",1);
		custid=SpringSecurityUtils.getCurrentUser().getId();
		String name=Struts2Utils.getParameter("name");
		String address=Struts2Utils.getParameter("address");
		String tel=Struts2Utils.getParameter("tel"); 
		LuckyEmployees employees=null;
		if (_id==null) {
			employees=new LuckyEmployees();
			employees.set_id(mongoSequence.currval(PubConstants.SUC_VIVO_EMPLOYEES));
		}else {
			employees=(LuckyEmployees) UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.SUC_VIVO_EMPLOYEES, _id), LuckyEmployees.class);
			employees.set_id(_id);
		} 
		employees.setCustid(custid);
		employees.setName(name);
		employees.setTel(tel);
		employees.setAddress(address);
		employees.setCreatedate(new Date());
		baseDao.insert(PubConstants.SUC_VIVO_EMPLOYEES, employees); 
		map.put("state",0); 
		String json = JSONArray.fromObject(map).toString();
	    Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 会员删除
	 * @return
	 * @throws Exception
	 */
	public String membersdel() throws Exception {
		custid=SpringSecurityUtils.getCurrentUser().getId(); 
		HashMap<String, Object>whereMap=new HashMap<>();
		whereMap.put("custid", custid);
		whereMap.put("_id", _id);
		baseDao.delete(PubConstants.SUC_VIVO_EMPLOYEES, whereMap);
		return members();
	}
	/**
	 * 卡片删除
	 * @return
	 * @throws Exception
	 */
	public String carddel() throws Exception {
		custid=SpringSecurityUtils.getCurrentUser().getId(); 
		HashMap<String, Object>whereMap=new HashMap<>();
		whereMap.put("custid", custid);
		whereMap.put("_id",_id);
		baseDao.delete(PubConstants.SUC_VIVO_CARD, whereMap);
		return card();
	}
	/**
	 * 兑奖码删除
	 * @return
	 * @throws Exception
	 */
	public String djcodedel() throws Exception {
		custid=SpringSecurityUtils.getCurrentUser().getId(); 
		HashMap<String, Object>whereMap=new HashMap<>();
		whereMap.put("custid", custid);
		whereMap.put("_id",_id);
		baseDao.delete(PubConstants.SUC_VIVO_DJCODE, whereMap);
		return djcode();
	}
	public void exp() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
	
		String hdid=Struts2Utils.getParameter("hdid");
		Struts2Utils.getRequest().setAttribute("hdid", hdid);
		
		DBObject box = baseDao.getMessage(PubConstants.SUC_LUCKYDROW, Long.parseLong(hdid));
		Vivodraw entity = new Vivodraw();
		if (box != null) {
			entity = (Vivodraw) UniObject.DBObjectToObject(box, Vivodraw.class);
		}
		 
		whereMap.put("hdid",  Long.parseLong(hdid));
		sortMap.put("insDate", -1);
		
		List<DBObject> list=baseDao.getList(PubConstants.SUC_VIVO_REWARDRECORD,whereMap, sortMap);
		List<DBObject> relist=new ArrayList<DBObject>(); 
		//微信用户查询
		for(DBObject db:list){
			if(db.get("insDate")!=null) {
				db.put("insDate",DateFormat.getDate(DateFormat.getFormat(db.get("insDate").toString())));
			} 
			if(db.get("fromUserid")!=null){
		    whereMap.clear();
		    whereMap.put("fromid", db.get("fromUserid").toString());
			DBObject user=baseDao.getMessage(PubConstants.SUC_VIVO_EMPLOYEES,whereMap);
			if(user!=null){
				
				if(user.get("tel")!=null){
					db.put("tel", user.get("tel").toString());
				} 
				if(user.get("name")!=null){
					db.put("name", user.get("name").toString());
				}else{
					db.put("name", "");
				}
				 
			}
			relist.add(db);	
			}
		}
		
		String[] header={"id", "奖品","用户名称",  "电话", "中奖日期"};  
		String[] body={"_id", "jp","name", "tel", "insDate"}; 
		
		String newtime = new Date().getTime() + ".xls";
		
		HSSFWorkbook wb = ExportExcel.exportByMongo(relist, header, body, newtime);  
		Struts2Utils.getResponse().setHeader("Content-disposition", "attachment;filename="
				+ URLEncoder.encode(newtime, "utf-8"));
        OutputStream ouputStream = Struts2Utils.getResponse().getOutputStream();  
        wb.write(ouputStream);  
        ouputStream.flush();  
        ouputStream.close();  
	}
	
	public void expcard() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
	
		String hdid=Struts2Utils.getParameter("hdid");
		Struts2Utils.getRequest().setAttribute("hdid", hdid);
		
		DBObject box = baseDao.getMessage(PubConstants.SUC_LUCKYDROW, Long.parseLong(hdid));
		Vivodraw entity = new Vivodraw();
		if (box != null) {
			entity = (Vivodraw) UniObject.DBObjectToObject(box, Vivodraw.class);
		}
		 
		whereMap.put("hdid",  Long.parseLong(hdid));
		sortMap.put("createdate", -1);
		
		List<DBObject> list=baseDao.getList(PubConstants.SUC_VIVO_CARDREWARD,whereMap, sortMap);
		List<DBObject> relist=new ArrayList<DBObject>(); 
		//微信用户查询
		for(DBObject db:list){
			db.put("createdate",DateFormat.getDate(DateFormat.getFormat(db.get("createdate").toString())));
			if(db.get("fromUserid")!=null){
		    whereMap.clear();
		    whereMap.put("fromid", db.get("fromUserid").toString());
			DBObject user=baseDao.getMessage(PubConstants.SUC_VIVO_EMPLOYEES,whereMap);
			if(user!=null){
				
				if(user.get("tel")!=null){
					db.put("tel", user.get("tel").toString());
				} 
				if(user.get("name")!=null){
					db.put("name", user.get("name").toString());
				}else{
					db.put("name", "");
				}
				 
			} 
			CardRecord cardRecord=(CardRecord) UniObject.DBObjectToObject(db, CardRecord.class);
			db.put("kp",cardRecord.getCard().getTitle());
			relist.add(db);	
			}
		}
		
		String[] header={"id", "串码","卡片","用户名称",  "电话", "中奖日期"};  
		String[] body={"_id", "jp","kp","name", "tel", "createdate"}; 
		
		String newtime = new Date().getTime() + ".xls";
		
		HSSFWorkbook wb = ExportExcel.exportByMongo(relist, header, body, newtime);  
		Struts2Utils.getResponse().setHeader("Content-disposition", "attachment;filename="
				+ URLEncoder.encode(newtime, "utf-8"));
        OutputStream ouputStream = Struts2Utils.getResponse().getOutputStream();  
        wb.write(ouputStream);  
        ouputStream.flush();  
        ouputStream.close();  
	}
	public void hddj() throws Exception {
	Map<String, Object> sub_map = new HashMap<String, Object>();
	custid=SpringSecurityUtils.getCurrentUser().getId();
	Long id=Long.parseLong(Struts2Utils.getParameter("id"));
		VivoRewardRecord card = (VivoRewardRecord)UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.WHD_REWARDRECORD,id),VivoRewardRecord.class);
		card.set_id(id);
		if(card.getState()!=0){
			sub_map.put("state", 1); 
			sub_map.put("value","兑奖异常"); 
			String json = JSONArray.fromObject(sub_map).toString();
		    Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		    return;
		}
		String jp=card.getJp(); 
		 if(jp.indexOf("元红包")>0){ 
			jp=jp.substring(0,jp.indexOf("元红包")).trim(); 
			if(StringUtils.isNotEmpty(jp)){ 
				//开始红包发送
				String str=wxhb(card.getCustid(),card.getFromUserid(),jp,"活动促销","活动促销","活动促销",0);
				if(str.equals(jp)){
				    card.setState(1); 
				}else{
					sub_map.put("state", 1); 
					sub_map.put("value",str); 
					String json = JSONArray.fromObject(sub_map).toString();
				    Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
				    return;
				}
				
			}
		 }else{
			 card.setState(1); 
		 }  
		baseDao.insert(PubConstants.WHD_REWARDRECORD, card);
		sub_map.put("state", 0); 
		String json = JSONArray.fromObject(sub_map).toString();
	    Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	    return;
	}
	public String  web()throws Exception{
		getLscode();
		String  lucid=Struts2Utils.getParameter("lucid"); 
		WxToken token=GetAllFunc.wxtoken.get(custid);
		
		 if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 }
		 Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/luckydraw!web.action?custid="+custid+"&lucid="+lucid;  
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
		wwzService.flow(custid,"luck-"+lucid);
		Struts2Utils.getRequest().setAttribute("custid",custid); 
		Struts2Utils.getRequest().setAttribute("user",wwzService.getWxUser(fromUserid)); 
		DBObject  db=baseDao.getMessage(PubConstants.SUC_LUCKYDROW, Long.parseLong(lucid));
		Struts2Utils.getRequest().setAttribute("entity",db);
		Struts2Utils.getRequest().setAttribute("reading", wwzService.getFlow(custid, "luck-"+lucid)); 
		Struts2Utils.getRequest().setAttribute("slide",wwzService.getslide(custid, "luckydraw-"+lucid));
		if(db!=null){
			HashMap<String,Object>whereMapc=new HashMap<>();
			whereMapc.put("hdid",Long.parseLong(lucid));
			whereMapc.put("lx",1);
			whereMapc.put("custid",custid);
			Long recount=baseDao.getCount(PubConstants.WHD_REWARDRECORD, whereMapc);
			Vivodraw  luck=(Vivodraw) UniObject.DBObjectToObject(db, Vivodraw.class);
			Long res=0L;
			if(luck.getReward().size()>0){
				for (int i = 0; i < luck.getReward().size(); i++) {
					JsonConfig jsonConfig = new JsonConfig(); 
					jsonConfig.setRootClass(VivoReward.class);
					Map<String, Class> classMap = new HashMap<String, Class>();
					classMap.put("students", VivoReward.class); // 指定JsonRpcRequest的request字段的内部类型
					jsonConfig.setClassMap(classMap);
					VivoReward ent = (VivoReward) JSONObject.toBean(JSONObject.fromObject(luck.getReward().get(i)), jsonConfig);
					res+=ent.getTotal();
				}
				 
			}
			if(res-recount>=0){ 
				Struts2Utils.getRequest().setAttribute("recount",res-recount);
			}
			
			 
		}
		
		
		DBObject share =new BasicDBObject();
		share.put("fxtitle", db.get("title"));
		share.put("fximg", db.get("picurl")); 
		share.put("fxurl",url);
		share.put("fxsummary", db.get("summary"));
		Struts2Utils.getRequest().setAttribute("share", share);
		if(StringUtils.isNotEmpty(db.get("lx").toString())){
			if(Integer.parseInt(db.get("lx").toString())==2){
				HashMap<String, Object>whereMap=new HashMap<String, Object>();
				whereMap.put("lid", Long.parseLong(lucid));
				int icount=Integer.parseInt(baseDao.getCount(PubConstants.SUC_LUCKYDROWYD, whereMap)+"");
				int needcount=Integer.parseInt(db.get("pcount").toString())-icount;
				Struts2Utils.getRequest().setAttribute("needcount",needcount);
				double bl=Double.parseDouble(icount+"")/Double.parseDouble(db.get("pcount").toString()); 
				Struts2Utils.getRequest().setAttribute("bl",new java.text.DecimalFormat("#").format(bl*100)); 
			}
				return "web"+db.get("lx").toString(); 	 
		} 
		return "web";
	}
 
	/**
	 * 摇奖
	 * @throws Exception 
	 */
	public  void  drawbox() throws Exception{
		getLscode();
		DBObject  user=wwzService.getWxUser(fromUserid);
		Map<String, Object> sub_map = new HashMap<String, Object>();
		String lucid=Struts2Utils.getParameter("lucid"); 
		if(user.get("_id").equals("notlogin")){
			//未登录
			System.out.println("88888");
			sub_map.put("state", 3); 
			String json = JSONArray.fromObject(sub_map).toString();
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
			return;
		}else{
			DBObject  obj=baseDao.getMessage(PubConstants.SUC_VIVO_LUCKYDROW, Long.parseLong(lucid));
			System.out.println(obj);
			if(obj!=null){
				Vivodraw  luck=(Vivodraw) UniObject.DBObjectToObject(obj, Vivodraw.class);
				    //验证时间 
				System.out.println("222");
				if(DateUtil.checkbig(luck.getStartdate())){
					//未开始
					System.out.println("22222");
					sub_map.put("state", 4);
					sub_map.put("tsy", luck.getStartts());
				}else if(DateUtil.checksimal(luck.getEnddate())){
					//已结束
					sub_map.put("state", 5);
					System.out.println("2223333");
					sub_map.put("tsy", luck.getOverts());
				}else{
					System.out.println("33");
					//验证是否是员工登录状态
					System.out.println("kais1");
					HashMap<String, Object> whereMap = new HashMap<String, Object>();
					whereMap.put("fromid",fromUserid);
					whereMap.put("tel",new BasicDBObject("$ne",null));
					DBObject wuser=baseDao.getMessage(PubConstants.SUC_VIVO_EMPLOYEES, whereMap);
					if (wuser==null||wuser.get("tel")==null||StringUtils.isEmpty(wuser.get("tel").toString())) {
						//未登录
						sub_map.put("state", 3);
						String json = JSONArray.fromObject(sub_map).toString();
						Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);	
						return ; 	
						
					}else {
						 
					}  
					
					//开始摇奖
					List<VivoReward> reward = luck.getReward();
					VivoReward re = new VivoReward();
					whereMap.clear();
					String insdate = DateFormat.getSampleDate(new Date());
					//判断频率
					HashMap<String, Object> wcMap = new HashMap<String, Object>();
					long zjcs=0;
					wcMap.clear();
					wcMap.put("fromUserid", fromUserid);
					wcMap.put("hdid",Long.parseLong(lucid));
					
					
					Long cardcount=baseDao.getCount(PubConstants.SUC_VIVO_CARDREWARD, wcMap);
					wcMap.clear();
					wcMap.put("wid",Long.parseLong(lucid)); 
					wcMap.put("fromUserid", fromUserid); 
					wcMap.put("lx",7);
					zjcs=baseDao.getCount(PubConstants.WHD_WHDCOUNT, wcMap);
					
					
					System.out.println("中奖次数了zjcs"+zjcs);
					System.out.println("cardcount"+cardcount);
					if (cardcount-zjcs<=0) {
						System.out.println("没有次数了zjcs"+zjcs);
						System.out.println("没有次数了cardcount"+cardcount);
						//未登录
						sub_map.put("state", 2);
						String json = JSONArray.fromObject(sub_map).toString();
						Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);	
						return ; 	
					} 
					zjcs=0; 
					System.out.println("888");
					if(luck.getDjcs()==1){
						wcMap.clear();
						wcMap.put("fromUserid", fromUserid);
						wcMap.put("hdid",Long.parseLong(lucid));
						zjcs=baseDao.getCount(PubConstants.SUC_VIVO_REWARDRECORD, wcMap);
						if(zjcs>0L){
							//重复中奖
							sub_map.put("state",7);
							sub_map.put("tsy", "您已经中奖！");
							String json = JSONArray.fromObject(sub_map).toString();
							Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);	
							return ; 	
						}
					}
					System.out.println("33888");
					WhdCount wc = new WhdCount();
					wc.set_id(mongoSequence.currval(PubConstants.WHD_WHDCOUNT));
					wc.setFromUserid(fromUserid); 
					wc.setWid(Long.parseLong(lucid)); 
					wc.setLx(7);
					wc.setInsdate(insdate);
					wc.setCreatedate(new Date());
					baseDao.insert(PubConstants.WHD_WHDCOUNT, wc);  
					if(luck.getRate()!=4){
						wcMap.clear();
						if (luck.getRate() == 0) {

							luck.setRate(1);
						} else {
							wcMap.put("insdate", insdate);
							wcMap.put("wid", Long.parseLong(lucid));
							wcMap.put("lx",2);
						}
						wcMap.put("fromUserid", fromUserid);
						//判断用户参与次数 
						long cs = baseDao.getCount(PubConstants.WHD_WHDCOUNT, wcMap); 
						//记录用户参与足迹
						 
						if (cs >= luck.getRate()) {
							sub_map.put("state",2);
							sub_map.put("tsy", "今天的机会用完了,明天再来哦！");
							String json = JSONArray.fromObject(sub_map).toString();
							Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);	
							return ;
						}
					  }
						//开始摇奖
						Random rand = new Random();
						if(luck.getJfxh()>0){
							//消耗积分
							if(!wwzService.deljf(luck.getJfxh()+"", fromUserid, "luck-xh", custid, null)){
								//积分不够
								sub_map.put("state",9);
								sub_map.put("tsy", "积分不够！");
								String json = JSONArray.fromObject(sub_map).toString();
								Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);	
								return ;
							};
						}
						int now = 0;   
							int num=0;
							if(luck.getZjl()>0){
								num=rand.nextInt(luck.getZjl());
							}else{
								num=rand.nextInt(3000);	
							}
							System.out.println("摇奖....");
							System.out.println(num);
							for (int i = 0; i < reward.size(); i++) {
								//json转换对象的时候需要指定类
								JsonConfig jsonConfig = new JsonConfig(); 
								jsonConfig.setRootClass(VivoReward.class);
								Map<String, Class> classMap = new HashMap<String, Class>();
								classMap.put("students", VivoReward.class); // 指定JsonRpcRequest的request字段的内部类型
								jsonConfig.setClassMap(classMap);
								VivoReward ent = (VivoReward) JSONObject.toBean(JSONObject.fromObject(reward.get(i)), jsonConfig);
								//Reward ent = (Reward) UniObject.DBObjectToObject(reward.get(i),Reward.class); 
								//Reward ent = reward.get(i);
								System.out.println(ent.getZjl());
								System.out.println("---------");
								if (ent.getZjl()>=num) {
									
									re = ent;
									now=re.getTotal();
									System.out.println(re.getZjl());
									System.out.println("*****");
									break;
								}
							

							}
							System.out.println(re.getZjl());
						  
						if(now>0){
							//中奖保存
							
							wcMap.clear(); 
							wcMap.put("hdid",Long.parseLong(lucid));
							wcMap.put("no", re.getNo());
							zjcs = baseDao.getCount(PubConstants.SUC_VIVO_REWARDRECORD, wcMap);
							if(zjcs>=re.getTotal()){
								//库存已完
								sub_map.put("state",8);
								sub_map.put("tsy", "库存已完");
								String json = JSONArray.fromObject(sub_map).toString();
								Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);	
								return ; 	
							}
							//保存中奖记录
							VivoRewardRecord  rr=new VivoRewardRecord();
							String yhjid=BaseDate.generateShortUuid().toUpperCase();
							Long id=mongoSequence.currval(PubConstants.SUC_VIVO_REWARDRECORD);
							rr.set_id(id);
							rr.setCustid(custid);
							rr.setHdid(Long.parseLong(lucid));
							rr.setLx(1);
							rr.setInsDate(new Date());
							rr.setState(0);
							rr.setHdtitle(luck.getTitle());
							rr.setNo(re.getNo());
							rr.setJp(re.getJp());
							rr.setYhj(yhjid);
							rr.setDjenddate(luck.getDjenddate());
							rr.setFromUserid(fromUserid); 
							baseDao.insert(PubConstants.SUC_VIVO_REWARDRECORD, rr);
							 
							if (re.getJp().indexOf("元红包")>0) {
								String val=re.getJp().replaceAll("元红包", "");
								//发红包
								System.out.println("红包"+val);
								wxhb(rr.getCustid(),rr.getFromUserid(),val,luck.getTitle(),"活动促销","活动促销",0);
								 
							}
							if(luck.getLx()==3){
								String remark=Struts2Utils.getParameter("remark");
								String act_name=Struts2Utils.getParameter("act_name");
								String wishing=Struts2Utils.getParameter("wishing");
								String str=shakejs(custid,fromUserid,rr,remark,act_name,wishing);
								if(str.equals("ok")){
									DBObject db=baseDao.getMessage(PubConstants.SUC_VIVO_REWARDRECORD,id);
									if(db!=null){
										VivoRewardRecord res=(VivoRewardRecord) UniObject.DBObjectToObject(db, VivoRewardRecord.class);
										res.setState(1);
										baseDao.insert(PubConstants.SUC_VIVO_REWARDRECORD, res);
									}
								}else{
									sub_map.put("return_msg",str);
								};
							}
							sub_map.put("state",0);
							sub_map.put("no", re.getNo());
							sub_map.put("text", re.getJp());
							sub_map.put("headimgurl",wwzService.getWxUsertype(fromUserid, "headimgurl"));
							sub_map.put("nickname",wwzService.getWxUsertype(fromUserid, "nickname"));
							 
							
						}else{
							//未中奖
							sub_map.put("state",6);
							sub_map.put("tsy", "未中奖");
							sub_map.put("headimgurl",wwzService.getWxUsertype(fromUserid, "headimgurl"));
							sub_map.put("nickname",wwzService.getWxUsertype(fromUserid, "nickname"));
							String json = JSONArray.fromObject(sub_map).toString();
							Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);	
							return ; 	
						}
						
					
				 	
				 
				}
				
				
			}
			
			
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);	
		
	}
	/**
	 * 兑换卡片
	 * @throws Exception 
	 */
	public  void  drawcard() throws Exception{
		getLscode();
		DBObject  user=wwzService.getWxUser(fromUserid);
		Map<String, Object> sub_map = new HashMap<String, Object>();
		String lucid=Struts2Utils.getParameter("lucid"); 
		if(user.get("_id").equals("notlogin")){
			//未登录
			System.out.println("88888888");
			sub_map.put("state", 3); 
			String json = JSONArray.fromObject(sub_map).toString();
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
			return;
		}else{
			System.out.println("88888");
			DBObject  obj=baseDao.getMessage(PubConstants.SUC_VIVO_LUCKYDROW, Long.parseLong(lucid));
			System.out.println(obj);
			if(obj!=null){
				Vivodraw  luck=(Vivodraw) UniObject.DBObjectToObject(obj, Vivodraw.class);
				    //验证时间 
				if(DateUtil.checkbig(luck.getStartdate())){
					//未开始
					sub_map.put("state", 4);
					sub_map.put("tsy", luck.getStartts());
				}else if(DateUtil.checksimal(luck.getEnddate())){
					//已结束
					sub_map.put("state", 5);
					sub_map.put("tsy", luck.getOverts());
				}else{
					//判断串码是否可用
					System.out.println("kais222");
					String djcode=Struts2Utils.getParameter("djcode");
					HashMap<String,Object>dJHashMap=new HashMap<>();
					dJHashMap.put("code", djcode);
					List<DBObject>codelist=baseDao.getList(PubConstants.SUC_VIVO_DJCODE, dJHashMap, null);
					System.out.println("kais2");
					if (codelist.size()==1) {
						System.out.println("kais222333");
						String state=codelist.get(0).get("state").toString();
						if (!state.equals("0")) {
							//已结束
							sub_map.put("state", 9);
							sub_map.put("tsy", "串码不可用！");
							String json = JSONArray.fromObject(sub_map).toString();
							Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);	
							return ; 	
						}
					}else {
						//已结束
						sub_map.put("state", 10);
						sub_map.put("tsy", "串码不可用！");
						String json = JSONArray.fromObject(sub_map).toString();
						Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);	
						return ; 	
					}
					//验证是否是员工登录状态
					System.out.println("kais1");
					HashMap<String, Object> whereMap = new HashMap<String, Object>();
					whereMap.put("fromid",fromUserid);
					whereMap.put("tel",new BasicDBObject("$ne",null));
					DBObject wuser=baseDao.getMessage(PubConstants.SUC_VIVO_EMPLOYEES, whereMap);
					if (wuser==null||wuser.get("tel")==null||StringUtils.isEmpty(wuser.get("tel").toString())) {
						//未登录
						sub_map.put("state", 3);
						String json = JSONArray.fromObject(sub_map).toString();
						Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);	
						return ; 	
						
					}else {
						 
					}  
					System.out.println("kais");
					//开始摇奖
					List<DBObject> cards =baseDao.getList(PubConstants.SUC_VIVO_CARD, null, null);
					Card re = new Card();
					
					String insdate = DateFormat.getSampleDate(new Date());
					//判断频率
					HashMap<String, Object> wcMap = new HashMap<String, Object>();
					long zjcs=0;
					if(luck.getDjcs()==1){
						wcMap.clear();
						wcMap.put("fromUserid", fromUserid);
						wcMap.put("hdid",Long.parseLong(lucid));
						zjcs=baseDao.getCount(PubConstants.SUC_VIVO_CARDREWARD, wcMap);
						if(zjcs>0L){
							//重复中奖
							sub_map.put("state",7);
							sub_map.put("tsy", "您已经中奖！");
							String json = JSONArray.fromObject(sub_map).toString();
							Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);	
							return ; 	
						}
					}
					
					WhdCount wc = new WhdCount();
					wc.set_id(mongoSequence.currval(PubConstants.WHD_WHDCOUNT));
					wc.setFromUserid(fromUserid); 
					wc.setWid(Long.parseLong(lucid)); 
					wc.setLx(8);
					wc.setInsdate(insdate);
					wc.setCreatedate(new Date());
					baseDao.insert(PubConstants.WHD_WHDCOUNT, wc);  
					
					if(luck.getRate()!=4){
						wcMap.clear();
						if (luck.getRate() == 0) {

							luck.setRate(1);
						} else {
							wcMap.put("insdate", insdate);
							wcMap.put("wid", Long.parseLong(lucid));
							wcMap.put("lx",2);
						}
						wcMap.put("fromUserid", fromUserid);
						//判断用户参与次数 
						long cs = baseDao.getCount(PubConstants.WHD_WHDCOUNT, wcMap); 
						//记录用户参与足迹
					  
						if (cs >= luck.getRate()) {
							sub_map.put("state",2);
							sub_map.put("tsy", "今天的机会用完了,明天再来哦！");
							String json = JSONArray.fromObject(sub_map).toString();
							Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);	
							return ;
						}
					  }
						//开始摇奖
						Random rand = new Random();
						if(luck.getJfxh()>0){
							//消耗积分
							if(!wwzService.deljf(luck.getJfxh()+"", fromUserid, "luck-xh", custid, null)){
								//积分不够
								sub_map.put("state",9);
								sub_map.put("tsy", "积分不够！");
								String json = JSONArray.fromObject(sub_map).toString();
								Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);	
								return ;
							};
						}
						
						int now = 0;
						while (true) {
							int num=0;
							if(luck.getZjl()>0){
								num=rand.nextInt(luck.getZjl());
							}else{
								num=rand.nextInt(3000);	
							}
							
							for (int i = 0; i < cards.size(); i++) {
								 
								Card ent = (Card)UniObject.DBObjectToObject(cards.get(i), Card.class);
								//Reward ent = (Reward) UniObject.DBObjectToObject(reward.get(i),Reward.class); 
								//Reward ent = reward.get(i); 
								System.out.println("***********");
								System.out.println(ent.getLogo());
								System.out.println(ent.getZjl());
								System.out.println(num);
								System.out.println("------------");
								if (ent.getZjl()>=num) {
									//验证库存 
									HashMap<String, Object>kcMap=new HashMap<>();
									kcMap.put("card._id",Long.parseLong(ent.get_id().toString()));
									Long count=baseDao.getCount(PubConstants.SUC_VIVO_CARDREWARD,kcMap);
									if(ent.getTotal()-Integer.parseInt(count.toString())>0) {
										re = ent; 
										now=re.getTotal(); 
										break;	
									}else {
										continue;
									}
									
									
								}
							

							}  
							if (re.getZjl()>0) {
								break;
							}
						}
						System.out.println("-------------");
						System.out.println(now);
						if(now>0){
						
							//保存中奖记录
							CardRecord  rr=new CardRecord();
							String yhjid=BaseDate.generateShortUuid().toUpperCase();
							Long id=mongoSequence.currval(PubConstants.SUC_VIVO_CARDREWARD);
							rr.set_id(id);
							rr.setCustid(custid);
							rr.setHdid(Long.parseLong(lucid));
							rr.setLx(1);
							rr.setCreatedate(new Date());
							rr.setCard(re);
							rr.setCid(Long.parseLong(re.get_id().toString()));
							rr.setState(0);
							rr.setHdtitle(luck.getTitle()); 
							rr.setYhj(yhjid);
							rr.setJp(codelist.get(0).get("code").toString());
							rr.setDjenddate(luck.getDjenddate());
							rr.setFromUserid(fromUserid); 
							baseDao.insert(PubConstants.SUC_VIVO_CARDREWARD, rr);
							
							whereMap.clear();
							whereMap.put("fromid", fromUserid);
							List<DBObject>lsph=baseDao.getList(PubConstants.SUC_VIVO_RANKING, whereMap, null);
							if (lsph.size()==1) {
								LeaderBoard board=(LeaderBoard) UniObject.DBObjectToObject(lsph.get(0), LeaderBoard.class);
								board.set_id(Long.parseLong(board.get_id().toString()));
								board.setCount(board.getCount()+1);
								board.setUpdatedate(new Date());
								baseDao.insert(PubConstants.SUC_VIVO_RANKING, board);
							}else {
								LeaderBoard board=new LeaderBoard();
								board.set_id(mongoSequence.currval(PubConstants.SUC_VIVO_RANKING));
								board.setCount(board.getCount()+1);
								board.setUpdatedate(new Date());
								board.setAddress(wuser.get("address").toString());
								board.setFromid(fromUserid);
								board.setNickname(wuser.get("name").toString());
								board.setHeadimgurl(user.get("headimgurl").toString());
								baseDao.insert(PubConstants.SUC_VIVO_RANKING, board);
							}
							
							
							
							//upRanking();
							//失效卡片 
							DjCode code=(DjCode) UniObject.DBObjectToObject(codelist.get(0), DjCode.class); 
							code.setState(1);
							code.setFromid(fromUserid);
							code.setDjdate(new Date());
							baseDao.insert(PubConstants.SUC_VIVO_DJCODE, code);
							System.out.println("-------11116666");
							sub_map.put("state",0);  
							sub_map.put("cardimg",re.getLogo());
							String json = JSONArray.fromObject(sub_map).toString();
							Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]); 
							return ; 
							
						}else{
							//未中奖
							sub_map.put("state",6);
							sub_map.put("tsy", "未中奖");
							sub_map.put("headimgurl",wwzService.getWxUsertype(fromUserid, "headimgurl"));
							sub_map.put("nickname",wwzService.getWxUsertype(fromUserid, "nickname"));
							String json = JSONArray.fromObject(sub_map).toString();
							Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);	
							return ; 	
						}
						
					
				 	
				 
				}
				
				
			}
			
			
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);	
		
	}
	public String deletejp() throws Exception {
		try {
			HashMap<String, Object> whereMap =new HashMap<String, Object>();
			whereMap.put("hdid", _id);
			baseDao.delete(PubConstants.WHD_REWARDRECORD,whereMap);
			addActionMessage("成功删除!");
			
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,删除过程中出现异常!");
		}
		return RELOAD;
	}
	@Override
	public Vivodraw getModel() {
		return entity;
	}
	public void set_id(Long _id) {
		this._id = _id;
	}
	/**
	 * 手机添加
	 */
	public String  webadd(){
		getLscode();
		Struts2Utils.getRequest().setAttribute("custid", custid); 
		 
		return "webadd";
	 
	}
	/**
	 * ajax添加
	 */
	public void    ajaxadd(){
		getLscode();;
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		try {
			String title=Struts2Utils.getParameter("title");
			String context=Struts2Utils.getParameter("context");
			String picurl=Struts2Utils.getParameter("picurl");
			String startdate=Struts2Utils.getParameter("startdate");
			String enddate=Struts2Utils.getParameter("enddate");
			String djenddate=Struts2Utils.getParameter("djenddate");
			String lx=Struts2Utils.getParameter("lx");
			String fromUsername=Struts2Utils.getParameter("fromUsername");
			String fromUsertel=Struts2Utils.getParameter("fromUsertel");
			String fromUserqq=Struts2Utils.getParameter("fromUserqq");
			Vivodraw obj=new Vivodraw();
			Long id=mongoSequence.currval(PubConstants.SUC_LUCKYDROW);
			obj.set_id(id);
			obj.setFromUserid(fromUserid);
			obj.setTitle(title);
			obj.setContext(context);
			obj.setCustid(custid);
			obj.setStartdate(DateFormat.getFormat(startdate));
			obj.setEnddate(DateFormat.getFormat(enddate));
			obj.setPicurl(picurl);
			obj.setLx(Integer.parseInt(lx));
			obj.setFromUsername(fromUsername);
			obj.setFromUsertel(fromUsertel);
			obj.setFromUserqq(fromUserqq);
			baseDao.insert(PubConstants.SUC_LUCKYDROW, obj);
			sub_map.put("state", 0);
			sub_map.put("value", id);
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			sub_map.put("state", 1);
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);	
		
		
	}
	/**
	 * 全部活动列表
	 */
	public String  weball(){
		getLscode(); 
		Struts2Utils.getRequest().setAttribute("custid", custid); 
		Struts2Utils.getRequest().setAttribute("user",wwzService.getWxUser(fromUserid));
		return "weball";
		
	}
	/**
	 * 个人活动列表
	 */
	public String  weblist(){
		getLscode(); 
		Struts2Utils.getRequest().setAttribute("custid", custid); 
		return "weblist";
		
	}
	/**
	 * ajax获取全部活动列表
	 */
	public void  ajaxweball(){
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		try {
			String  lx=Struts2Utils.getParameter("lx");
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			whereMap.put("custid",custid);
			String sel=Struts2Utils.getParameter("sel");
			if(StringUtils.isNotEmpty(sel)){
				Pattern pattern = Pattern.compile("^.*" + sel + ".*$",
						Pattern.CASE_INSENSITIVE);
				whereMap.put("title", pattern); 
			}
			if(StringUtils.isNotEmpty(lx)){
				whereMap.put("lx", Integer.parseInt(lx));
			}
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			} 
			List<DBObject>list=baseDao.getList(PubConstants.SUC_LUCKYDROW, whereMap,fypage,10,sortMap);
			if(list.size()>0){
				 
				for (DBObject dbObject : list) {
					//加载状态 
					String start=dbObject.get("startdate").toString();
					String end=dbObject.get("enddate").toString();   
					if(DateUtil.checkbig(DateFormat.getFormat(start))&&DateUtil.checksimal(DateFormat.getFormat(end))){
						dbObject.put("state", "进行中");
					}else if(!DateUtil.checkbig(DateFormat.getFormat(start))){
						dbObject.put("state", "未开始");
					}else if(!DateUtil.checksimal(DateFormat.getFormat(end))){
						dbObject.put("state", "已结束");
					};
					//阅读人数
					dbObject.put("pcount", wwzService.getFlow(custid,"luck-"+dbObject.get("_id").toString()));
					//参与人数
				    whereMap.clear();
				    whereMap.put("wid", Long.parseLong(dbObject.get("_id").toString()));
				    dbObject.put("scount", baseDao.getCount(PubConstants.WHD_WHDCOUNT, whereMap));
					 
				}
				sub_map.put("state",0);
				sub_map.put("list",list);
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			sub_map.put("state",1);
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);	
	}
	/**
	 * ajax获取个人活动列表
	 */
	public void  ajaxweblist(){
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		try {
			String  lx=Struts2Utils.getParameter("lx");
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			HashMap<String, Object>sortMap=new HashMap<String, Object>();
			whereMap.put("custid",custid);
			whereMap.put("fromUserid",fromUserid);
			if(StringUtils.isNotEmpty(lx)){
				whereMap.put("lx", Integer.parseInt(lx));
			}
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			} 
			List<DBObject>list=baseDao.getList(PubConstants.SUC_LUCKYDROW, whereMap,fypage,10,sortMap);
			if(list.size()>0){
				sub_map.put("state",0);
				sub_map.put("list",list);
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			sub_map.put("state",1);
			e.printStackTrace();
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);	
	}
	/**
	 * 获奖结果
	 * @return
	 */
	public String  reward(){
		getLscode();
		Struts2Utils.getRequest().setAttribute("custid", custid);  
		WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		}
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/luckydraw!reward.action?custid="+custid;  
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
		return "reward"; 
	}
	/**
	 * ajax获取奖品结果
	 */
	public void ajaxreward(){
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		getLscode();
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		whereMap.put("fromUserid", fromUserid);
		whereMap.put("custid",custid);
		sortMap.put("insDate", -1);
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject>list=baseDao.getList(PubConstants.WHD_REWARDRECORD, whereMap,fypage,10, sortMap);
		if(list.size()>0){ 
			for (DBObject dbObject : list) {
				if(dbObject.get("djenddate")!=null){ 
					String djenddate=dbObject.get("djenddate").toString();
					   if(!DateUtil.checkbig(DateFormat.getFormat(djenddate))){
							dbObject.put("state", 2);
						}
				} 
			}
			sub_map.put("state", 0);
			sub_map.put("list", list);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);	
	}
	/**
	 * ajax获取中奖统计
	 */
	public void ajaxrewardhd(){
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		custid=getCustid(); 
		String  lucid=Struts2Utils.getParameter("lucid");
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>(); 
		whereMap.put("custid",custid);  
		if(StringUtils.isNotEmpty(lucid)){
			whereMap.put("hdid",Long.parseLong(lucid));
		}
		sortMap.put("insDate",-1);
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject>list=baseDao.getList(PubConstants.WHD_REWARDRECORD, whereMap,fypage,5, sortMap);
		if(list.size()>0){
			for (DBObject dbObject : list) {
				if(dbObject.get("fromUserid")!=null){
					DBObject  user=wwzService.getWxUser(dbObject.get("fromUserid").toString());
					dbObject.put("headimgurl", user.get("headimgurl"));
					dbObject.put("nickname",user.get("nickname"));
				}
				if(dbObject.get("insDate")!=null){
					dbObject.put("insDate", RelativeDate.format(DateFormat.getFormat(dbObject.get("insDate").toString()), new Date()));
				}
			}
			sub_map.put("state", 0);
			sub_map.put("list", list);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);	
	}
	 
	 
	/**
	 * 手机扫码兑奖
	 */
	public String mbTicket(){
		getLscode(); 
		Struts2Utils.getRequest().setAttribute("custid",custid);
		String  lucid=Struts2Utils.getParameter("lucid");
		WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		}
		Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/luckydraw!mbTicket.action?custid="+custid+"&lucid="+lucid;  
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
		if(StringUtils.isNotEmpty(lucid)){
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			whereMap.put("custid", custid);
			whereMap.put("fromUserid",fromUserid);
			whereMap.put("hdid", Long.parseLong(lucid));
			List<DBObject> list=baseDao.getList(PubConstants.WHD_REWARDRECORD,whereMap,null);
			if(list.size()==1){
				//仅提供一次中奖的兑奖功能
				VivoRewardRecord  rr=(VivoRewardRecord) UniObject.DBObjectToObject(list.get(0), VivoRewardRecord.class);
				if(DateUtil.checkbig(rr.getDjenddate())){
					if(rr.getState()==0){
						//未兑奖
						rr.setState(1);
						baseDao.insert(PubConstants.WHD_REWARDRECORD, rr);
						Struts2Utils.getRequest().setAttribute("state", 0);
						Struts2Utils.getRequest().setAttribute("jp",rr.getJp());
					}else{
						//已兑奖
						Struts2Utils.getRequest().setAttribute("state", 4);
						Struts2Utils.getRequest().setAttribute("jp",rr.getJp());
					} 
					
				 }else{
					 //过期
					 rr.setState(2);
				     baseDao.insert(PubConstants.WHD_REWARDRECORD, rr);
					 Struts2Utils.getRequest().setAttribute("state", 3); 
					 Struts2Utils.getRequest().setAttribute("jp",rr.getJp());
				 } 
				
			}else if(list.size()>1){
				//多次中奖
				Struts2Utils.getRequest().setAttribute("state",2);
			}else if(list.size()==0){
				//未中奖
				Struts2Utils.getRequest().setAttribute("state",1);
			}
		}
		
		return "mbticket"; 
	}
	/**
	 * ajax兑奖
	 * @throws Exception 
	 */
	public  void ajaxchangecard() throws Exception{
		getLscode();
		String id=Struts2Utils.getParameter("id");
		Map<String, Object> sub_map = new HashMap<String, Object>();
		if(StringUtils.isNotEmpty(id)){
			DBObject  db=baseDao.getMessage(PubConstants.WHD_REWARDRECORD, Long.parseLong(id));
			if(db!=null&&db.get("fromUserid").toString().equals(fromUserid)){
				VivoRewardRecord card=(VivoRewardRecord) UniObject.DBObjectToObject(db, VivoRewardRecord.class);
				if(card.getState()==0){
					//兑奖  
					String jp=card.getJp(); 
					 if(jp.indexOf("元红包")>0){ 
						jp=jp.substring(0,jp.indexOf("元红包")).trim(); 
						if(StringUtils.isNotEmpty(jp)){ 
							//开始红包发送
							String str=wxhb(card.getCustid(),card.getFromUserid(),jp,"活动促销","活动促销","活动促销",0);
							if(str.equals(jp)){
							    card.setState(1); 
							}else{
								sub_map.put("state", 3); 
								sub_map.put("value",str); 
								String json = JSONArray.fromObject(sub_map).toString();
							    Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
							    return;
							}
							
						}
					 }else{
						 card.setState(1); 
					 } 
					
					baseDao.insert(PubConstants.WHD_REWARDRECORD, card);
					sub_map.put("state", 0);
				}else if(card.getState()==1){
					//已兑奖
					sub_map.put("state", 1);
				}else if(card.getDjenddate()!=null&&!DateUtil.checkbig(card.getDjenddate())){
					//已过期
					sub_map.put("state", 2);
				}
				   
			}
		}
		String json = JSONArray.fromObject(sub_map).toString();
	    Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 摇一摇奖品结算
	 * @throws Exception 
	 */
	public  String shakejs(String custid,String fromUserid,VivoRewardRecord re,String remark,String act_name,String wishing) throws Exception{
		 
		String jp=re.getJp(); 
		 if(jp.indexOf("元红包")>0){ 
			jp=jp.substring(0,jp.indexOf("元红包")).trim(); 
			if(StringUtils.isNotEmpty(jp)){ 
				//开始红包发送
				wxhb(custid,fromUserid,jp,remark,act_name,wishing,0,re.get_id().toString());
			 	
			}
		 }else if(jp.indexOf("积分")>0){
			jp=jp.substring(0,jp.indexOf("积分")).trim();
			if(StringUtils.isNotEmpty(jp)){ 
				//开始积分结算 
				if(wwzService.addjf(jp, fromUserid,"luck-zj", custid,null)){
					return "ok";
				};
			}
		 }
		return "error";
	}
	/**
	 * 微信红包
	 * @return
	 */
	public  String  wxhb(String custid,String fromUserid,String price,String remark,String act_name,String wishing,int lx) throws Exception{
	    SortedMap<Object,Object> params = new TreeMap<Object,Object>();
		getLscode(); 
		DBObject  wx=wwzService.getWxUser(fromUserid);
		if(wx.get("_id").equals("notlogin")){
			 
			return ""; 
		} 
		WxToken wxtoken=GetAllFunc.wxtoken.get(custid);
		WxPayConfig wxconfig=new WxPayConfig();
		if(wxtoken.getQx()==0){
			 
			return "";
		}else if(wxtoken.getQx()==1){
			wxconfig=GetAllFunc.wxPay.get(custid);
		}else if(wxtoken.getQx()==2){//父类结算   
			wxconfig=GetAllFunc.wxPay.get(wwzService.getparentcustid(custid));
		} 
		if(Double.parseDouble(price)>200||Double.parseDouble(price)<1){
			//输入金额有误（支持1-200）
			params.put("state",4);
			String json = JSONArray.fromObject(params).toString();
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
			return "";
		}     
	     
		//10位序列号,可以自行调整。
		//四位随机数
		String strRandom = TenpayUtil.buildRandom(4)+"";
		String orderno = DateFormat.getDate()+strRandom+mongoSequence.currval(PubConstants.WEIXIN_REDPACKINFO);
		String nonce_str=PayCommonUtil.CreateNoncestr();
	 
		SortedMap<Object,Object> parameters = new TreeMap<Object,Object>();
		parameters.put("nonce_str", nonce_str);
		parameters.put("mch_billno",orderno); 
		parameters.put("mch_id", wxconfig.getPartner());
		parameters.put("wxappid",wxconfig.getAppid());  
		parameters.put("remark", remark); 
		parameters.put("send_name", wxconfig.getName());//商户名称
		parameters.put("re_openid", wwzService.getWxUsertype(fromUserid,"fromUser"));
		parameters.put("total_amount", BaseDecimal.round(BaseDecimal.multiplication(price, "100"),0));
		parameters.put("total_num", "1");
		parameters.put("wishing",wishing);
		parameters.put("client_ip", Struts2Utils.getRequest().getRemoteAddr());
		parameters.put("act_name",act_name); 
	 


		String sign = PayCommonUtil.createSign("UTF-8", parameters,wxconfig.getPartner_key());
		parameters.put("sign", sign);
		RedpackInfo  redpackInfo =new RedpackInfo();
		redpackInfo.set_id(orderno);
		redpackInfo.setRemark(remark);
		redpackInfo.setMch_billno(orderno);
		redpackInfo.setMch_id(wxconfig.getPartner());
		redpackInfo.setWxappid(wxconfig.getAppid());
		redpackInfo.setSign(sign);
		redpackInfo.setState(0);
		redpackInfo.setCustid(custid);
		redpackInfo.setClient_ip(Struts2Utils.getRequest().getRemoteAddr());
		redpackInfo.setWishing(wishing);
		redpackInfo.setFromUserid(fromUserid);
		redpackInfo.setTotal_num(1);
		redpackInfo.setTotal_amount(Double.parseDouble(price));
		redpackInfo.setCreatedate(new Date());
		redpackInfo.setSend_name( wxconfig.getName());
		redpackInfo.setAct_name(act_name);
		redpackInfo.setLx(lx);
		baseDao.insert(PubConstants.WEIXIN_REDPACKINFO, redpackInfo);
		String requestXML = PayCommonUtil.getRequestXml(parameters);
		
		String result =CommonUtil.httpsRequestSSL("https://api.mch.weixin.qq.com/mmpaymkttransfers/sendredpack","POST", requestXML,wxconfig.getPartner(),"C:/certs/"+wxconfig.getPartner()+"_"+wxconfig.getPartner()+"/apiclient_cert.p12");
		System.out.println(result); 
		Map<String, String> map = XMLUtil.doXMLParse(result);
        if(map.get("return_msg").equals("发放成功")&&map.get("err_code_des").equals("发放成功")){
        	DBObject  db=baseDao.getMessage(PubConstants.WEIXIN_REDPACKINFO, orderno);
        	if(db!=null){
        		RedpackInfo re=(RedpackInfo) UniObject.DBObjectToObject(db, RedpackInfo.class);
        		re.setState(1);
        	}
        	return price; 
        } 
		return map.get("return_msg"); 
	}
	/**
	 * 微信红包
	 * @return
	 */
	public  void  wxhb(String custid,String fromUserid,String price,String remark,String act_name,String wishing,int lx,String reward) throws Exception{
	    SortedMap<Object,Object> params = new TreeMap<Object,Object>();
		getLscode(); 
		DBObject  wx=wwzService.getWxUser(fromUserid);
		if(wx.get("_id").equals("notlogin")){
			 
			return; 
		} 
		WxToken wxtoken=GetAllFunc.wxtoken.get(custid);
		WxPayConfig wxconfig=new WxPayConfig();
		if(wxtoken.getQx()==0){
			 
			return;
		}else if(wxtoken.getQx()==1){
			wxconfig=GetAllFunc.wxPay.get(custid);
		}else if(wxtoken.getQx()==2){//父类结算   
			wxconfig=GetAllFunc.wxPay.get(wwzService.getparentcustid(custid));
		} 
		if(Double.parseDouble(price)>200||Double.parseDouble(price)<1){
			//输入金额有误（支持1-200）
			params.put("state",4);
			String json = JSONArray.fromObject(params).toString();
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
			return;
		}     
	     
		//10位序列号,可以自行调整。
		//四位随机数
		String strRandom = TenpayUtil.buildRandom(4)+"";
		String orderno = DateFormat.getDate()+strRandom+mongoSequence.currval(PubConstants.WEIXIN_REDPACKINFO);
		String nonce_str=PayCommonUtil.CreateNoncestr();
	 
		SortedMap<Object,Object> parameters = new TreeMap<Object,Object>();
		parameters.put("nonce_str", nonce_str);
		parameters.put("mch_billno",orderno); 
		parameters.put("mch_id", wxconfig.getPartner());
		parameters.put("wxappid",wxconfig.getAppid());  
		parameters.put("remark", remark); 
		parameters.put("send_name", wxconfig.getName());//商户名称
		parameters.put("re_openid", wwzService.getWxUsertype(fromUserid,"fromUser"));
		parameters.put("total_amount", BaseDecimal.round(BaseDecimal.multiplication(price, "100"),0));
		parameters.put("total_num", "1");
		parameters.put("wishing",wishing);
		parameters.put("client_ip", Struts2Utils.getRequest().getRemoteAddr());
		parameters.put("act_name",act_name); 
	 


		String sign = PayCommonUtil.createSign("UTF-8", parameters,wxconfig.getPartner_key());
		parameters.put("sign", sign);
		RedpackInfo  redpackInfo =new RedpackInfo();
		redpackInfo.set_id(orderno);
		redpackInfo.setRemark(remark);
		redpackInfo.setMch_billno(orderno);
		redpackInfo.setMch_id(wxconfig.getPartner());
		redpackInfo.setWxappid(wxconfig.getAppid());
		redpackInfo.setSign(sign);
		redpackInfo.setState(0);
		redpackInfo.setCustid(custid);
		redpackInfo.setClient_ip(Struts2Utils.getRequest().getRemoteAddr());
		redpackInfo.setWishing(wishing);
		redpackInfo.setFromUserid(fromUserid);
		redpackInfo.setTotal_num(1);
		redpackInfo.setTotal_amount(Double.parseDouble(price));
		redpackInfo.setCreatedate(new Date());
		redpackInfo.setSend_name( wxconfig.getName());
		redpackInfo.setAct_name(act_name);
		redpackInfo.setLx(lx);
		baseDao.insert(PubConstants.WEIXIN_REDPACKINFO, redpackInfo);
		//发送红包
		JmsService.redpacketMessage(orderno, reward,0); 
	}
	
	/**
	 * 微信红包
	 * @return
	 */
	public  void  wxhb(String custid,String fromUserid,String price,String remark,String act_name,String wishing,int lx,String reward,int type) throws Exception{
	    SortedMap<Object,Object> params = new TreeMap<Object,Object>();
		getLscode(); 
		DBObject  wx=wwzService.getWxUser(fromUserid);
		if(wx.get("_id").equals("notlogin")){
			 
			return; 
		} 
		WxToken wxtoken=GetAllFunc.wxtoken.get(custid);
		WxPayConfig wxconfig=new WxPayConfig();
		System.out.println(wxtoken.getQx());
		if(wxtoken.getQx()==0){
			 
			return;
		}else if(wxtoken.getQx()==1){
			wxconfig=GetAllFunc.wxPay.get(custid);
		}else if(wxtoken.getQx()==2){//父类结算   
			wxconfig=GetAllFunc.wxPay.get(wwzService.getparentcustid(custid));
		} 
		if(Double.parseDouble(price)>200||Double.parseDouble(price)<0.01){
			//输入金额有误（支持1-200）
			params.put("state",4);
			String json = JSONArray.fromObject(params).toString();
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
			return;
		}     
	    System.out.println("*****发送"); 
		//10位序列号,可以自行调整。
		//四位随机数
		String strRandom = TenpayUtil.buildRandom(4)+"";
		String orderno = DateFormat.getDate()+strRandom+mongoSequence.currval(PubConstants.WEIXIN_REDPACKINFO);
		String nonce_str=PayCommonUtil.CreateNoncestr();
	 
		SortedMap<Object,Object> parameters = new TreeMap<Object,Object>();
		parameters.put("nonce_str", nonce_str);
		parameters.put("mch_billno",orderno); 
		parameters.put("mch_id", wxconfig.getPartner());
		parameters.put("wxappid",wxconfig.getAppid());  
		parameters.put("remark", remark); 
		parameters.put("send_name", wxconfig.getName());//商户名称
		parameters.put("re_openid", wwzService.getWxUsertype(fromUserid,"fromUser"));
		parameters.put("total_amount", BaseDecimal.round(BaseDecimal.multiplication(price, "100"),0));
		parameters.put("total_num", "1");
		parameters.put("wishing",wishing);
		parameters.put("client_ip", Struts2Utils.getRequest().getRemoteAddr());
		parameters.put("act_name",act_name); 
	 


		String sign = PayCommonUtil.createSign("UTF-8", parameters,wxconfig.getPartner_key());
		parameters.put("sign", sign);
		RedpackInfo  redpackInfo =new RedpackInfo();
		redpackInfo.set_id(orderno);
		redpackInfo.setRemark(remark);
		redpackInfo.setMch_billno(orderno);
		redpackInfo.setMch_id(wxconfig.getPartner());
		redpackInfo.setWxappid(wxconfig.getAppid());
		redpackInfo.setSign(sign);
		redpackInfo.setState(0);
		redpackInfo.setCustid(custid);
		redpackInfo.setClient_ip(Struts2Utils.getRequest().getRemoteAddr());
		redpackInfo.setWishing(wishing);
		redpackInfo.setFromUserid(fromUserid);
		redpackInfo.setTotal_num(1);
		redpackInfo.setTotal_amount(Double.parseDouble(price));
		redpackInfo.setCreatedate(new Date());
		redpackInfo.setSend_name( wxconfig.getName());
		redpackInfo.setAct_name(act_name);
		redpackInfo.setLx(lx);
		baseDao.insert(PubConstants.WEIXIN_REDPACKINFO, redpackInfo);
		//发送红包
		System.out.println("------发送");
		JmsService.redpacketMessage(orderno, reward,type); 
	}
	
	
	
	/**
	 * 首页
	 * @return
	 */
	public String index() {
		//计算摇奖次数
		getLscode();
		String id=Struts2Utils.getParameter("lucid");
    	WxToken token=GetAllFunc.wxtoken.get(custid); 
		if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		} 
		Struts2Utils.getRequest().setAttribute("token", WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest());
		String url=SysConfig.getProperty("ip")+"/suc/vivo/vivodraw!index.action?custid="+custid+"&lucid="+id;
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}
		HashMap<String, Object>whereMap=new HashMap<>();
		whereMap.put("fromid", fromUserid);
		Long count1=baseDao.getCount(PubConstants.SUC_VIVO_CARDREWARD, whereMap);
		Long count2=baseDao.getCount(PubConstants.SUC_VIVO_REWARDRECORD, whereMap);
		if (count1-count2>0) {
			Struts2Utils.getRequest().setAttribute("playnum", count1-count2);
		}else {
			Struts2Utils.getRequest().setAttribute("playnum", 0);
		}
		Struts2Utils.getRequest().setAttribute("lucid",Struts2Utils.getParameter("lucid"));
		List<DBObject>list1=wwzService.slide(custid, "vivodraw-"+Struts2Utils.getParameter("lucid"));
		Struts2Utils.getRequest().setAttribute("slide",list1);
		DBObject db=baseDao.getMessage(PubConstants.SUC_VIVO_LUCKYDROW, Long.parseLong(Struts2Utils.getParameter("lucid")));
		DBObject  share=new BasicDBObject(); 
		share.put("fximg",SysConfig.getProperty("filehttp")+"/"+db.get("picurl"));
		share.put("fxsummary",db.get("summary"));
		share.put("fxurl",url);
		Struts2Utils.getRequest().setAttribute("share", share);
		//加载登录状态
		whereMap.clear();
		whereMap.put("fromid",fromUserid);
		whereMap.put("tel",new BasicDBObject("$ne",null));
		List<DBObject>list=baseDao.getList(PubConstants.SUC_VIVO_EMPLOYEES, whereMap,null);
		if (list.size()==1&&list.get(0).get("tel")!=null) {
			Struts2Utils.getRequest().setAttribute("vivo_user", list.get(0));
		} 
		
		return "index";
	}
	/**
	 * 卡包
	 * @return
	 */
	public String cardpackage() {
		getLscode();
		//获取卡包数据
		String lucid=Struts2Utils.getParameter("lucid");
		Struts2Utils.getRequest().setAttribute("lucid", lucid);
		HashMap<String, Object>whereMap=new HashMap<>();
		whereMap.put("fromUserid", fromUserid);
		HashMap<String, Object>sortMap=new HashMap<>();
		sortMap.put("createdate", -1);
		List<DBObject>list=baseDao.getList(PubConstants.SUC_VIVO_CARDREWARD, whereMap, sortMap);
		List<DBObject>nelist=new ArrayList<>();
		HashMap<String, Integer>sMap=new HashMap<>(); 
		for (DBObject dbObject : list) {
			CardRecord cardRecord=(CardRecord) UniObject.DBObjectToObject(dbObject, CardRecord.class);
			cardRecord.getCard();
			System.out.println("------"+cardRecord.getCard().get_id().toString());
			if(nelist.size()==0) {
				nelist.add(cardRecord);
				sMap.put(cardRecord.getCard().get_id().toString(), 1);
			}else {
				if(sMap.get(cardRecord.getCard().get_id().toString())==null) {
					nelist.add(cardRecord);
					sMap.put(cardRecord.getCard().get_id().toString(), 1);
					System.out.println("添加成功"); 
				}else {
					System.out.println("存在");
					sMap.put(cardRecord.getCard().get_id().toString(), sMap.get(cardRecord.getCard().get_id().toString())+1);
				}
				 
			}
		
			
		} 
		
		for (DBObject dbObject : nelist) {
			CardRecord cardRecord=(CardRecord) UniObject.DBObjectToObject(dbObject, CardRecord.class);
			cardRecord.getCard();
			dbObject.put("lx",sMap.get(cardRecord.getCard().get_id().toString()));
		}
		Struts2Utils.getRequest().setAttribute("list", list);
		System.out.println(nelist.size());
		System.out.println(list.size());
		Struts2Utils.getRequest().setAttribute("nelist", nelist);
		if (nelist.size()>=32) {
			Struts2Utils.getRequest().setAttribute("isdj",0);
		}else {
			Struts2Utils.getRequest().setAttribute("isdj",-1);
		}
		List<DBObject>list1=wwzService.slide(custid, "vivodraw-"+Struts2Utils.getParameter("lucid"));
		Struts2Utils.getRequest().setAttribute("slide",list1);
		return "cardpackage";
	}
	/**
	 * 规则
	 * @return
	 */
	public String rules() {
		String lucid=Struts2Utils.getParameter("lucid");
		Struts2Utils.getRequest().setAttribute("lucid", lucid);
		DBObject dbObject=baseDao.getMessage(PubConstants.SUC_VIVO_LUCKYDROW,Long.parseLong(lucid));
		Struts2Utils.getRequest().setAttribute("entity",dbObject);
		
		List<DBObject>list1=wwzService.slide(custid, "vivodraw-"+Struts2Utils.getParameter("lucid"));
		Struts2Utils.getRequest().setAttribute("slide",list1);
		return "rules";
	}
	/**
	 * 排行榜
	 */
	public String list() {
		getLscode();
		//获取排行榜数据
		String lucid=Struts2Utils.getParameter("lucid");
		Struts2Utils.getRequest().setAttribute("lucid", lucid);
		HashMap<String, Object>whereMap=new HashMap<>();
		whereMap.put("fromid", fromUserid);
		HashMap<String, Object>sortMap=new HashMap<>();
		sortMap.put("ranking",1);
		List<DBObject>list=baseDao.getList(PubConstants.SUC_VIVO_RANKING, whereMap, sortMap); 
		if (list.size()>0) {
			Struts2Utils.getRequest().setAttribute("entity", list.get(0));
		} 
		list=baseDao.getList(PubConstants.SUC_VIVO_RANKING, null, sortMap);
		Struts2Utils.getRequest().setAttribute("list",list);
		List<DBObject>list1=wwzService.slide(custid, "vivodraw-"+Struts2Utils.getParameter("lucid"));
		Struts2Utils.getRequest().setAttribute("slide",list1);
		return "list";
	}
	/**
	 * 移动端登录
	 */
	public void  weblogin() {
		getLscode();
		HashMap<String, Object>sub_map=new HashMap<>();
		sub_map.put("state",1);
		String tel=Struts2Utils.getParameter("tel");
		String yzcode=Struts2Utils.getParameter("yzcode"); 
		Code code=GetAllFunc.telcode.get(tel); 
		if (code!=null&&code.getCode().equals(yzcode)) {
			System.out.println("验证开始");
			 //验证时间
			if(DateUtil.checkbig(DateUtil.addMinute(code.getCreatedate(),10))) {
				System.out.println("验证结束");
				//登录成功，绑定用户信息到员工
				HashMap<String,Object>whereMap=new HashMap<>();
				whereMap.put("tel",tel);
				List<DBObject>list=baseDao.getList(PubConstants.SUC_VIVO_EMPLOYEES, whereMap,null);
				if (list.size()==1) {
					DBObject dbObject=list.get(0);
					LuckyEmployees employees=(LuckyEmployees) UniObject.DBObjectToObject(dbObject, LuckyEmployees.class);
					employees.setFromid(fromUserid);
					baseDao.insert(PubConstants.SUC_VIVO_EMPLOYEES, employees);
					sub_map.put("state",0);
				}
				
			}
		}
		String json = JSONArray.fromObject(sub_map).toString();
	    Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * 更新排行榜
	 */
	public void upRanking() {
		//获取排行榜数据 
		
		HashMap<String, Object>sortMap=new HashMap<>();
		sortMap.put("count", -1);
		List<DBObject>list=baseDao.getList(PubConstants.SUC_VIVO_RANKING, null,sortMap);
		for (int i =0; i < list.size(); i++) {
			LeaderBoard  board=(LeaderBoard) UniObject.DBObjectToObject(list.get(i), LeaderBoard.class);
			board.set_id(Long.parseLong(board.get_id().toString()));
			board.setRanking(i+1);
			baseDao.insert(PubConstants.SUC_VIVO_RANKING, board);
			 
			 
		}
		 
	}
	/**
	 * 生成验证码
	 */
	public void   createTelCode() {
		getLscode();
		HashMap<String, Object>sub_map=new HashMap<>();
		sub_map.put("state",1);
		String tel=Struts2Utils.getParameter("tel");
		String code=UserUtil.createVipNo(6);
		if (code!=null&&tel!=null) {
			System.out.println(code);
			Code code2=new Code();
			code2.setCode(code);
			code2.setCreatedate(new Date());
			code2.setType(0);
			code2.setValue(tel);
			GetAllFunc.telcode.put(tel, code2);
			boolean bl=wwzService.sendSMS(tel, "您的验证码为"+code+"，有效时间10分钟。");
			if (bl) {
				sub_map.put("state",0);
			} 
		}
		
		String json = JSONArray.fromObject(sub_map).toString();
	    Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}
	/**
	 * 清空员工
	 */
	public void delALLyg() {
		SpringSecurityUtils.getCurrentUser().getId();
		//baseDao.delete(PubConstants.SUC_VIVO_EMPLOYEES); 
	}
	/**
	 * 清空指定排行榜
	 */
	public void delALLphb() {
		HashMap<String, Object>whereMap=new HashMap<>(); 
		String string=Struts2Utils.getParameter("str");
		SpringSecurityUtils.getCurrentUser().getId();
		Pattern pattern = Pattern.compile("^.*" + string + ".*$",
				Pattern.CASE_INSENSITIVE);
		whereMap.put("nickname", pattern);
		if(StringUtils.isNotEmpty(string)) {
			baseDao.delete(PubConstants.SUC_VIVO_RANKING, whereMap);
		}
		
		
	}
	/**
	 * 删除卡包记录
	 */
	public void delcardreload() {
		HashMap<String, Object>sub_map=new HashMap<>();
		sub_map.put("state",1);
		SpringSecurityUtils.getCurrentUser().getId();
		DBObject db=baseDao.getMessage(PubConstants.SUC_VIVO_CARDREWARD, _id);
		if(db!=null&&db.get("fromUserid")!=null) {
			
			baseDao.delete(PubConstants.SUC_VIVO_CARDREWARD,_id);
			//更新排行榜
			HashMap<String, Object>whereMap=new HashMap<>();
			whereMap.put("fromid", db.get("fromUserid").toString());
			DBObject ph=baseDao.getMessage(PubConstants.SUC_VIVO_RANKING, whereMap);
			if(ph!=null) {
				LeaderBoard board=(LeaderBoard) UniObject.DBObjectToObject(ph, LeaderBoard.class);
				if(board.getCount()-1>=0) {
					board.setCount(board.getCount()-1);
					baseDao.insert(PubConstants.SUC_VIVO_RANKING, board);
					upRanking();
					sub_map.put("state",0);
				} 
			}
			
		}
		

		String json = JSONArray.fromObject(sub_map).toString();
	    Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
		
	}
	/**
	 * 验证排行榜
	 */
	public void  yzphb() {
		SpringSecurityUtils.getCurrentUser().getId();
		List<DBObject>list=baseDao.getList(PubConstants.SUC_VIVO_RANKING, null, null);
		for (DBObject dbObject : list) {
			LeaderBoard board=(LeaderBoard) UniObject.DBObjectToObject(dbObject, LeaderBoard.class);
			int count=board.getCount();
			HashMap<String,Object>whereMap=new HashMap<>();
			whereMap.put("fromid",board.getFromid());
			Long icount=baseDao.getCount(PubConstants.SUC_VIVO_DJCODE,whereMap);
			if(icount<count) {
				board.setCount(Integer.parseInt(icount+""));
				baseDao.insert(PubConstants.SUC_VIVO_RANKING, board);
			}
		}
		upRanking();
	}
	public void  carred() {
		CardRecord cardRecord=new CardRecord();
		cardRecord.set_id(mongoSequence.currval(PubConstants.SUC_VIVO_CARDREWARD));
		
		cardRecord.setCard((Card)UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.SUC_VIVO_CARD, _id), Card.class));
		cardRecord.setCreatedate(new Date());
		baseDao.insert(PubConstants.SUC_VIVO_CARDREWARD, cardRecord);
	}
	public void  carredr() {
	 //同步记录
		List<DBObject>list=baseDao.getList(PubConstants.SUC_VIVO_CARDREWARD, null, null);
		for (DBObject dbObject : list) {
			CardRecord cardRecord=(CardRecord) UniObject.DBObjectToObject(dbObject, CardRecord.class);
			WhdCount count=new WhdCount();
			count.set_id(mongoSequence.currval(PubConstants.WHD_WHDCOUNT));
			count.setWid(cardRecord.getHdid());
			count.setLx(8);
			count.setFromUserid(cardRecord.getFromUserid());
			count.setCreatedate(cardRecord.getCreatedate());
			baseDao.insert(PubConstants.WHD_WHDCOUNT, count);
		}
		List<DBObject>list1=baseDao.getList(PubConstants.SUC_VIVO_REWARDRECORD, null, null);
		for (DBObject dbObject : list1) {
			VivoRewardRecord cardRecord=(VivoRewardRecord) UniObject.DBObjectToObject(dbObject, VivoRewardRecord.class);
			WhdCount count=new WhdCount();
			count.set_id(mongoSequence.currval(PubConstants.WHD_WHDCOUNT));
			count.setWid(cardRecord.getHdid());
			count.setLx(7);
			count.setFromUserid(cardRecord.getFromUserid());
			count.setCreatedate(cardRecord.getInsDate());
			baseDao.insert(PubConstants.WHD_WHDCOUNT, count);
		}
	}
	/**
	 * 根据卡片导出明细
	 * @throws Exception
	 */
	public void expcardfro() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
	
		 
		String cid=Struts2Utils.getParameter("cid");  
		if(StringUtils.isNotEmpty(cid)){
			whereMap.put("cid",  Long.parseLong(cid));
		}
		sortMap.put("createdate", -1);
		
		List<DBObject> list=baseDao.getList(PubConstants.SUC_VIVO_CARDREWARD,whereMap, sortMap);
		List<DBObject> relist=new ArrayList<DBObject>(); 
		//微信用户查询
		for(DBObject db:list){
			db.put("createdate",DateFormat.getDate(DateFormat.getFormat(db.get("createdate").toString())));
			if(db.get("fromUserid")!=null){
		    whereMap.clear();
		    whereMap.put("fromid", db.get("fromUserid").toString());
			DBObject user=baseDao.getMessage(PubConstants.SUC_VIVO_EMPLOYEES,whereMap);
			if(user!=null){
				
				if(user.get("tel")!=null){
					db.put("tel", user.get("tel").toString());
				} 
				if(user.get("name")!=null){
					db.put("name", user.get("name").toString());
				}else{
					db.put("name", "");
				}
				 
			} 
			CardRecord cardRecord=(CardRecord) UniObject.DBObjectToObject(db, CardRecord.class);
			db.put("kp",cardRecord.getCard().getTitle());
			relist.add(db);	
			}
		}
		
		String[] header={"id", "串码","卡片","用户名称",  "电话", "中奖日期"};  
		String[] body={"_id", "jp","kp","name", "tel", "createdate"}; 
		
		String newtime = new Date().getTime() + ".xls";
		
		HSSFWorkbook wb = ExportExcel.exportByMongo(relist, header, body, newtime);  
		Struts2Utils.getResponse().setHeader("Content-disposition", "attachment;filename="
				+ URLEncoder.encode(newtime, "utf-8"));
        OutputStream ouputStream = Struts2Utils.getResponse().getOutputStream();  
        wb.write(ouputStream);  
        ouputStream.flush();  
        ouputStream.close();  
	}
	/**
	 * 根据员工导出卡包明细
	 * @throws Exception
	 */
	public void expcardpagefro() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
	 
		sortMap.put("createdate", -1);
		
		List<DBObject> list=baseDao.getList(PubConstants.SUC_VIVO_EMPLOYEES,whereMap, sortMap);
		List<DBObject> relist=new ArrayList<DBObject>(); 

		for (DBObject dbObject1 : list) {
			HashMap<String, Object>whereqMap=new HashMap<>();
			if(dbObject1.get("fromid")!=null){
				whereqMap.put("fromUserid", dbObject1.get("fromid").toString());
				HashMap<String, Object>sortqMap=new HashMap<>();
				sortMap.put("createdate", -1);
				List<DBObject>list1=baseDao.getList(PubConstants.SUC_VIVO_CARDREWARD, whereqMap, sortqMap);
				List<DBObject>nelist=new ArrayList<>();  
				
				HashMap<String, Integer>sMap=new HashMap<>(); 
				for (DBObject dbObject : list1) {
					CardRecord cardRecord=(CardRecord) UniObject.DBObjectToObject(dbObject, CardRecord.class);
					cardRecord.getCard();
					 
					if(nelist.size()==0) {
						nelist.add(cardRecord);
						sMap.put(cardRecord.getCard().get_id().toString(), 1);
					}else {
						if(sMap.get(cardRecord.getCard().get_id().toString())==null) {
							nelist.add(cardRecord);
							sMap.put(cardRecord.getCard().get_id().toString(), 1); 
						}else { 
							sMap.put(cardRecord.getCard().get_id().toString(), sMap.get(cardRecord.getCard().get_id().toString())+1);
						}
						 
					}
				
					
				} 
				
				for (DBObject dbObject : nelist) {
					CardRecord cardRecord=(CardRecord) UniObject.DBObjectToObject(dbObject, CardRecord.class);
					cardRecord.getCard();
					dbObject.put("lx",sMap.get(cardRecord.getCard().get_id().toString()));
				}  
				dbObject1.put("list_size", list1.size());
				dbObject1.put("nelist_size", nelist.size());
			 
			}
			relist.add(dbObject1);
		}
		
		String[] header={"id", "姓名","电话","卡包总记录",  "卡片种类"};  
		String[] body={"_id", "name","tel","list_size", "nelist_size",}; 
		
		String newtime = new Date().getTime() + ".xls";
		
		HSSFWorkbook wb = ExportExcel.exportByMongo(relist, header, body, newtime);  
		Struts2Utils.getResponse().setHeader("Content-disposition", "attachment;filename="
				+ URLEncoder.encode(newtime, "utf-8"));
        OutputStream ouputStream = Struts2Utils.getResponse().getOutputStream();  
        wb.write(ouputStream);  
        ouputStream.flush();  
        ouputStream.close();  
	}
 
	  
}
