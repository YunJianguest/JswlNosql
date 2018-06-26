package com.lsp.suc.web; 
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
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.util.XMLUtil;
import com.lsp.pub.web.GeneralAction;
import com.lsp.suc.entity.FarmCard;
import com.lsp.suc.entity.LuckydarwYd;
import com.lsp.suc.entity.Luckydraw;
import com.lsp.suc.entity.Reward;
import com.lsp.suc.entity.RewardRecord;
import com.lsp.suc.entity.WhdCount; 
import com.lsp.website.service.WwzService;
import com.lsp.weixin.entity.RedpackInfo;
import com.lsp.weixin.entity.WxPayConfig;
import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
 
/**
 * 抽奖管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name = LuckydrawAction.RELOAD, location = "luckydraw.action",params={"fypage", "%{fypage}"}, type = "redirect") })
public class LuckydrawAction extends GeneralAction<Luckydraw> {

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
	
	private Luckydraw entity=new Luckydraw();
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
		
		List<DBObject> list=baseDao.getList(PubConstants.SUC_LUCKYDROW,whereMap,fypage,10, sortMap,backMap);
		for(DBObject db:list){
			db.put("yds", wwzService.getFlow(custid, "drawbox_"+db.get("_id").toString()));
			db.put("nickname", wwzService.getCustName(db.get("custid").toString()));
		}
		Struts2Utils.getRequest().setAttribute("DrawboxList", list);
		Struts2Utils.getRequest().setAttribute("isxs", isxs);
		fycount=baseDao.getCount(PubConstants.SUC_LUCKYDROW, whereMap);
		 
		return SUCCESS;
	}
	

	@Override
	public String delete() throws Exception {
		try {
			baseDao.delete(PubConstants.SUC_LUCKYDROW,_id);
			HashMap<String, Object> whereMap =new HashMap<String, Object>();
			whereMap.put("custid",SpringSecurityUtils.getCurrentUser().getId()); 
			whereMap.put("hdid", _id);
			baseDao.delete(PubConstants.SUC_LUCKYDROWRESULTS,whereMap);
		
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
	    Struts2Utils.getRequest().setAttribute("entity",baseDao.getMessage(PubConstants.SUC_LUCKYDROW,_id));
		return "add";
	}
	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			//有custId查出来 用户信息
			DBObject box=baseDao.getMessage(PubConstants.SUC_LUCKYDROW,_id);
			entity = (Luckydraw)UniObject.DBObjectToObject(box,Luckydraw.class);
			JSONArray  json = JSONArray.fromObject(box.get("reward"));
			Struts2Utils.getRequest().setAttribute("reward", json);
		} else {
			entity = new Luckydraw();
		}
	}
	
	

	@Override
	public String save() throws Exception {
		//注册业务逻辑
		try {
			if(_id == null){
				_id=mongoSequence.currval(PubConstants.SUC_LUCKYDROW);	
			}
			custid=SpringSecurityUtils.getCurrentUser().getId();
			entity.set_id(_id);
			entity.setCustid(custid); 
			entity.setCreatedate(new Date());
			entity.setStartdate(DateFormat.StringToDate(Struts2Utils.getParameter("startdate")+":00"));
			entity.setEnddate(DateFormat.StringToDate(Struts2Utils.getParameter("enddate")+":00"));
		    double  counts=Double.parseDouble(Struts2Utils.getParameter("counts")); 
			List<Reward> reward=new ArrayList<Reward>();
			for(int i=0;i<6;i++){ 
				Double bl=Double.parseDouble(Struts2Utils.getParameter("jpnum"+i))/counts; 
				Reward re=new Reward();
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
			entity.setEwmurl(wwzService.recode("luckydraw-mbTicket-"+_id,SysConfig.getProperty("ip")+"/suc/luckydraw!mbTicket.action?custid="+custid+"&lucid="+_id, entity.getPicurl(),true, 200, 1000));
			baseDao.insert(PubConstants.SUC_LUCKYDROW,entity);
			
			
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
		fycount=baseDao.getCount(PubConstants.WHD_REWARDRECORD, whereMap);
		List<DBObject> list=baseDao.getList(PubConstants.WHD_REWARDRECORD,whereMap,fypage,10, sortMap);
		for(DBObject db:list){
			if(db.get("fromUserid")!=null){
				DBObject user=wwzService.getWxUser(db.get("fromUserid").toString());
				if(user!=null){
					if(user.get("headimgurl")!=null){
						db.put("headimgurl", user.get("headimgurl").toString());
					}
					if(user.get("tel")!=null){
						db.put("tel", user.get("tel").toString());
					}
					if(user.get("no")!=null){
						db.put("no", user.get("no").toString());
					}
					if(user.get("nickname")!=null){
						db.put("nickname", user.get("nickname").toString());
					}
					if(user.get("name")!=null){
						db.put("name", user.get("name").toString());
					}
				}
			}
			
				
		} 
		Struts2Utils.getRequest().setAttribute("rewardList", list);

		return "hdtj";
	}
	public void exp() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
	
		String hdid=Struts2Utils.getParameter("hdid");
		Struts2Utils.getRequest().setAttribute("hdid", hdid);
		
		DBObject box = baseDao.getMessage(PubConstants.SUC_LUCKYDROW, Long.parseLong(hdid));
		Luckydraw entity = new Luckydraw();
		if (box != null) {
			entity = (Luckydraw) UniObject.DBObjectToObject(box, Luckydraw.class);
		}
		 
		whereMap.put("hdid",  Long.parseLong(hdid));
		sortMap.put("insDate", -1);
		
		List<DBObject> list=baseDao.getList(PubConstants.WHD_REWARDRECORD,whereMap, sortMap);
		List<DBObject> relist=new ArrayList<DBObject>(); 
		//微信用户查询
		for(DBObject db:list){
			db.put("insDate",DateFormat.getDate(DateFormat.getFormat(db.get("insDate").toString())));
			if(db.get("fromUserid")!=null){
			DBObject user=baseDao.getMessage(PubConstants.DATA_WXUSER, db.get("fromUserid").toString());
			if(user!=null){
				
				if(user.get("tel")!=null){
					db.put("tel", user.get("tel").toString());
				} 
				if(user.get("nickname")!=null){
					db.put("nickname", user.get("nickname").toString());
				}else{
					db.put("nickname", "");
				}
				 
			}
			relist.add(db);	
			}
		}
		
		String[] header={"id", "奖品","微信名",  "电话", "中奖日期", "兑奖码"};  
		String[] body={"_id", "jp","nickname", "tel", "insDate", "yhj"}; 
		
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
		RewardRecord card = (RewardRecord)UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.WHD_REWARDRECORD,id),RewardRecord.class);
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
			Luckydraw  luck=(Luckydraw) UniObject.DBObjectToObject(db, Luckydraw.class);
			Long res=0L;
			if(luck.getReward().size()>0){
				for (int i = 0; i < luck.getReward().size(); i++) {
					JsonConfig jsonConfig = new JsonConfig(); 
					jsonConfig.setRootClass(Reward.class);
					Map<String, Class> classMap = new HashMap<String, Class>();
					classMap.put("students", Reward.class); // 指定JsonRpcRequest的request字段的内部类型
					jsonConfig.setClassMap(classMap);
					Reward ent = (Reward) JSONObject.toBean(JSONObject.fromObject(luck.getReward().get(i)), jsonConfig);
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
			sub_map.put("state", 3); 
			String json = JSONArray.fromObject(sub_map).toString();
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
			return;
		}else{
			DBObject  obj=baseDao.getMessage(PubConstants.SUC_LUCKYDROW, Long.parseLong(lucid));
			if(obj!=null){
				Luckydraw  luck=(Luckydraw) UniObject.DBObjectToObject(obj, Luckydraw.class);
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
					
					//开始摇奖
					List<Reward> reward = luck.getReward();
					Reward re = new Reward();
					HashMap<String, Object> whereMap = new HashMap<String, Object>();
					String insdate = DateFormat.getSampleDate(new Date());
					//判断频率
					HashMap<String, Object> wcMap = new HashMap<String, Object>();
					long zjcs=0;
					if(luck.getDjcs()==1){
						wcMap.clear();
						wcMap.put("fromUserid", fromUserid);
						wcMap.put("hdid",Long.parseLong(lucid));
						zjcs=baseDao.getCount(PubConstants.WHD_REWARDRECORD, wcMap);
						if(zjcs>0L){
							//重复中奖
							sub_map.put("state",7);
							sub_map.put("tsy", "您已经中奖！");
							String json = JSONArray.fromObject(sub_map).toString();
							Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);	
							return ; 	
						}
					}
					
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
						WhdCount wc = new WhdCount();
						wc.set_id(mongoSequence.currval(PubConstants.WHD_WHDCOUNT));
						wc.setFromUserid(fromUserid); 
						wc.setWid(Long.parseLong(lucid)); 
						wc.setLx(2);
						wc.setInsdate(insdate);
						wc.setCreatedate(new Date());
						baseDao.insert(PubConstants.WHD_WHDCOUNT, wc);  
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
						int num=0;
						if(luck.getZjl()>0){
							num=rand.nextInt(luck.getZjl());
						}else{
							num=rand.nextInt(3000);	
						}
						int now = 0;
						for (int i = 0; i < reward.size(); i++) {
							//json转换对象的时候需要指定类
							JsonConfig jsonConfig = new JsonConfig(); 
							jsonConfig.setRootClass(Reward.class);
							Map<String, Class> classMap = new HashMap<String, Class>();
							classMap.put("students", Reward.class); // 指定JsonRpcRequest的request字段的内部类型
							jsonConfig.setClassMap(classMap);
							Reward ent = (Reward) JSONObject.toBean(JSONObject.fromObject(reward.get(i)), jsonConfig);
							//Reward ent = (Reward) UniObject.DBObjectToObject(reward.get(i),Reward.class); 
							//Reward ent = reward.get(i); 
							if (ent.getZjl()>=num) {
								re = ent;
								now=re.getTotal();
								break;
							}
						

						}
						if(now>0){
							//中奖保存
							
							wcMap.clear(); 
							wcMap.put("hdid",Long.parseLong(lucid));
							wcMap.put("no", re.getNo());
							zjcs = baseDao.getCount(PubConstants.WHD_REWARDRECORD, wcMap);
							if(zjcs>=re.getTotal()){
								//库存已完
								sub_map.put("state",8);
								sub_map.put("tsy", "库存已完");
								String json = JSONArray.fromObject(sub_map).toString();
								Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);	
								return ; 	
							}
							//保存中奖记录
							RewardRecord  rr=new RewardRecord();
							String yhjid=BaseDate.generateShortUuid().toUpperCase();
							Long id=mongoSequence.currval(PubConstants.WHD_REWARDRECORD);
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
							baseDao.insert(PubConstants.WHD_REWARDRECORD, rr);
							if(luck.getLx()==3){
								String remark=Struts2Utils.getParameter("remark");
								String act_name=Struts2Utils.getParameter("act_name");
								String wishing=Struts2Utils.getParameter("wishing");
								String str=shakejs(custid,fromUserid,rr,remark,act_name,wishing);
								if(str.equals("ok")){
									DBObject db=baseDao.getMessage(PubConstants.WHD_REWARDRECORD,id);
									if(db!=null){
										RewardRecord res=(RewardRecord) UniObject.DBObjectToObject(db, RewardRecord.class);
										res.setState(1);
										baseDao.insert(PubConstants.WHD_REWARDRECORD, res);
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
	public Luckydraw getModel() {
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
			Luckydraw obj=new Luckydraw();
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
	 * ajax报名
	 */
	public  void   ajaxbm(){
		getLscode();
		String  id=Struts2Utils.getParameter("id"); 
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		if(StringUtils.isNotEmpty(id)){
			DBObject  db=baseDao.getMessage(PubConstants.SUC_LUCKYDROW, Long.parseLong(id));
			if(db!=null){
				HashMap<String,Object>whereMap=new HashMap<String, Object>();
				whereMap.put("lid", Long.parseLong(id));
				whereMap.put("fromUserid", fromUserid);
				Long  count =baseDao.getCount(PubConstants.SUC_LUCKYDROWYD, whereMap);
				whereMap.clear();
				whereMap.put("lid", Long.parseLong(id));
				Long  pcount=baseDao.getCount(PubConstants.SUC_LUCKYDROWYD, whereMap);
				if(pcount>=Long.parseLong(db.get("pcount").toString())){
					sub_map.put("state",2);
					String json = JSONArray.fromObject(sub_map).toString();
					Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);	
					return;
				}
				if(count==0){
					LuckydarwYd  yd=new LuckydarwYd();
					yd.set_id(mongoSequence.currval(PubConstants.SUC_LUCKYDROWYD));
					yd.setCreatedate(new Date());
					yd.setCustid(custid);
					yd.setFromUserid(fromUserid);
					yd.setLid(Long.parseLong(id));
					pcount=pcount+1;
					yd.setSort(Integer.parseInt(pcount+""));
					baseDao.insert(PubConstants.SUC_LUCKYDROWYD, yd); 
					if(pcount>=Long.parseLong(db.get("pcount").toString())){
						//开奖 
						runlottery(db,custid);
					}
					sub_map.put("state",0);
					Long  needcount=Long.parseLong(db.get("pcount").toString())-pcount;
					double bl=Double.parseDouble(pcount+"")/Double.parseDouble(db.get("pcount").toString());     
					sub_map.put("needcount",needcount);
					sub_map.put("bl",new java.text.DecimalFormat("#").format(bl*100));
				}else{
					sub_map.put("state",1);
				} 
			}
			
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);	
	}
	/**
	 * 开奖
	 * @param id
	 */
	public  void   runlottery(DBObject db,String custid){
	    Luckydraw  luck=(Luckydraw) UniObject.DBObjectToObject(db, Luckydraw.class);
	    List<Reward>lsre=luck.getReward();
	    for (int i = 0; i < lsre.size(); i++) {
	    	//Reward re=lsre.get(i);
	    	//json转换对象的时候需要指定类
			JsonConfig jsonConfig = new JsonConfig(); 
			jsonConfig.setRootClass(Reward.class);
			Map<String, Class> classMap = new HashMap<String, Class>();
			classMap.put("students", Reward.class); // 指定JsonRpcRequest的request字段的内部类型
			jsonConfig.setClassMap(classMap);
			Reward re = (Reward) JSONObject.toBean(JSONObject.fromObject(lsre.get(i)), jsonConfig);
	    	 while(true) {
	    		int count=MathUtil.getMathRandom(luck.getPcount()*10); 
	    		HashMap<String,Object>whereMap=new HashMap<String, Object>();
	    		whereMap.clear();
				whereMap.put("hdid",Long.parseLong(db.get("_id").toString()));
				whereMap.put("no",re.getNo());
				
				Long hdcount=baseDao.getCount(PubConstants.WHD_REWARDRECORD, whereMap);
				if(hdcount>=re.getTotal()){ 
					break;
				}
				whereMap.clear();
				whereMap.put("hdid",Long.parseLong(db.get("_id").toString()));
				hdcount=baseDao.getCount(PubConstants.WHD_REWARDRECORD, whereMap);
				if(hdcount>=Long.parseLong(db.get("pcount").toString())){
					break;
				}
				if(re.getJp()==null){
					break;
				}
				whereMap.clear();
	    		whereMap.put("lid",Long.parseLong(db.get("_id").toString()));
	    		whereMap.put("sort",count);
	    		DBObject  dbuser=baseDao.getMessage(PubConstants.SUC_LUCKYDROWYD, whereMap);
	    		if(dbuser!=null){
	    			String  fromUserid=dbuser.get("fromUserid").toString();
		    		whereMap.clear();
		    		whereMap.put("fromUserid", fromUserid);
		    		whereMap.put("hdid",Long.parseLong(db.get("_id").toString())); 
					long zjcs = baseDao.getCount(PubConstants.WHD_REWARDRECORD, whereMap);  
					if(zjcs==0){
						
						RewardRecord  rr=new RewardRecord();
						String yhjid=BaseDate.generateShortUuid().toUpperCase();
						rr.set_id(mongoSequence.currval(PubConstants.WHD_REWARDRECORD));
						rr.setCustid(custid);
						rr.setHdid(Long.parseLong(db.get("_id").toString()));
						rr.setLx(1);
						rr.setInsDate(new Date());
						rr.setState(0);
						rr.setHdtitle(luck.getTitle());
						rr.setNo(re.getNo());
						rr.setJp(re.getJp());
						rr.setYhj(yhjid);
						rr.setDjenddate(luck.getDjenddate());
						rr.setFromUserid(fromUserid); 
						baseDao.insert(PubConstants.WHD_REWARDRECORD, rr); 
					}
				
	    		}
	    		
			}
		}  	
	}
	/**
	 * ajax获取预定名单
	 */
	public  void  ajaxluckyd(){
		getLscode();
		String id=Struts2Utils.getParameter("id");
		Map<String, Object> sub_map = new HashMap<String, Object>(); 
		if(StringUtils.isNotEmpty(id)){
			HashMap<String,Object>whereMap=new HashMap<String, Object>();
			HashMap<String,Object>sortMap=new HashMap<String, Object>();
			whereMap.put("lid",Long.parseLong(id));
			sortMap.put("createdate", -1);
			if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
				fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
			}
			List<DBObject>list=baseDao.getList(PubConstants.SUC_LUCKYDROWYD, whereMap,fypage,10, sortMap);
			if(list.size()>0){
				for (DBObject dbObject : list) {
					if(dbObject.get("createdate")!=null){
						dbObject.put("createdate", RelativeDate.format(DateFormat.getFormat(dbObject.get("createdate").toString()), new Date()));
					}
					if(dbObject.get("fromUserid")!=null){
						dbObject.put("nickname", wwzService.getWxUsertype(dbObject.get("fromUserid").toString(),"nickname"));
						dbObject.put("headimgurl", wwzService.getWxUsertype(dbObject.get("fromUserid").toString(),"headimgurl"));
					}
				}
				sub_map.put("state", 0);
				sub_map.put("list",list);
				
			}
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length()-1), new String[0]);	
	}
	/**
	 * ajax获取中奖名单
	 */
	public  void  ajaxluckytj(){
		getLscode();
		Map<String, Object> sub_map = new HashMap<String, Object>();  
		String  lucid=Struts2Utils.getParameter("id");
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>(); 
		//whereMap.put("custid",custid);  
		if(StringUtils.isNotEmpty(lucid)){
			whereMap.put("hdid",Long.parseLong(lucid));
		}
		sortMap.put("insDate",-1);
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject>list=baseDao.getList(PubConstants.WHD_REWARDRECORD, whereMap,sortMap);
		if(list.size()>0){
			for (DBObject dbObject : list) {
				if(dbObject.get("fromUserid")!=null){
					dbObject.put("nickname", wwzService.getWxUsertype(dbObject.get("fromUserid").toString(),"nickname"));
					dbObject.put("headimgurl", wwzService.getWxUsertype(dbObject.get("fromUserid").toString(),"headimgurl"));
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
				RewardRecord  rr=(RewardRecord) UniObject.DBObjectToObject(list.get(0), RewardRecord.class);
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
				RewardRecord card=(RewardRecord) UniObject.DBObjectToObject(db, RewardRecord.class);
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
	public  String shakejs(String custid,String fromUserid,RewardRecord re,String remark,String act_name,String wishing) throws Exception{
		 
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
		
		String result =CommonUtil.httpsRequestSSL("https://api.mch.weixin.qq.com/mmpaymkttransfers/sendredpack","POST", requestXML,wxconfig.getPartner(),"D:/certs/"+wxconfig.getPartner()+"_"+wxconfig.getPartner()+"/apiclient_cert.p12");
		 
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
	  
}
