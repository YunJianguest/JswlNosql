package com.lsp.suc.web;

import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import net.sf.jasperreports.crosstabs.fill.JRPercentageCalculatorFactory.LongPercentageCalculator;
import net.sf.json.JSONArray;

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
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.ExportExcel;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.web.GeneralAction;
import com.lsp.suc.entity.Ranking;
import com.lsp.suc.entity.Tourism;
import com.lsp.suc.entity.VoteInfo;
import com.lsp.suc.entity.Votelm;
import com.lsp.suc.entity.WhdCount;
import com.lsp.website.service.WebsiteService;
import com.lsp.website.service.WwzService;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;

/**
 * 投票内容管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name =VoteAction.RELOAD, location = "vote.action",params={"voteid",  "%{voteid}","fypage", "%{fypage}"},type = "redirect") })
public class VoteAction extends GeneralAction<VoteInfo> {

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
	
	private VoteInfo entity=new VoteInfo();
	private Long _id; 
	public void set_id(Long _id) {
		this._id = _id;
	}
	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		HashMap<String, Object> backMap =new HashMap<String, Object>();
		String voteid=Struts2Utils.getParameter("voteid"); 
		if(StringUtils.isNotEmpty(voteid)){
			whereMap.put("voteid", Long.parseLong(voteid));
		
		} 
		custid=SpringSecurityUtils.getCurrentUser().getId();
		sortMap.put("sort", -1); 
		whereMap.put("custid", custid);
		String title=Struts2Utils.getParameter("title");
		if(StringUtils.isNotEmpty(title)){
			Pattern pattern = Pattern.compile("^.*" + title + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern);
			Struts2Utils.getRequest().setAttribute("title",  title);
		}
		backMap.put("content", 0); 
		
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}  
		List<DBObject> list=baseDao.getList(PubConstants.SUC_VOTE,whereMap,fypage,10,sortMap,backMap);
		 for (DBObject dbObject : list) {
			    if(dbObject.get("fromUserid")!=null){
			    	dbObject.put("nickname", wwzService.getUserName(dbObject.get("fromUserid").toString()));
			    }else{
			    	dbObject.put("nickname", wwzService.getCustName(dbObject.get("custid").toString()));
			    }
				
			}
		fycount=baseDao.getCount(PubConstants.SUC_VOTE,whereMap);
		Struts2Utils.getRequest().setAttribute("voteList", list);
		Struts2Utils.getRequest().setAttribute("custid", custid);
		
		return SUCCESS;
	}
	@Override
	public VoteInfo getModel() {
		// TODO Auto-generated method stub
		return entity;
	}

	@Override
	public String input() throws Exception {
		// TODO Auto-generated method stub 
		 
		return "add";
	}

	@Override
	public String update() throws Exception {
		// TODO Auto-generated method stub
	    Struts2Utils.getRequest().setAttribute("entity",baseDao.getMessage(PubConstants.SUC_VOTE, _id));
		return "add";
	}

	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		if(_id==null){
			_id=mongoSequence.currval(PubConstants.SUC_VOTE);
		}
		String  voteid=Struts2Utils.getParameter("voteid");  
		entity.set_id(_id);
		entity.setCustid(SpringSecurityUtils.getCurrentUser().getId());
		entity.setVoteid(Long.parseLong(voteid));
		entity.setCreatedate(new Date());
		baseDao.insert(PubConstants.SUC_VOTE, entity);
		Ranking rank=new Ranking();
		rank.set_id("vote-"+voteid+"-"+_id);  
		rank.setType("vote-"+voteid);
		rank.setValue(0); 
		rank.setRankno(_id);
		rank.setRankname(entity.getTitle());
		baseDao.insert(PubConstants.SUC_RANKING, rank);
		return RELOAD;
	}

	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		try {
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			whereMap.put("custid", SpringSecurityUtils.getCurrentUser().getId());
			whereMap.put("_id",_id);
		    baseDao.delete(PubConstants.SUC_VOTE, whereMap);   
			addActionMessage("删除成功");
		 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			addActionMessage("删除失败");
		}
		return RELOAD;
	}
	public String deleteAll(){
		try {
			HashMap<String, Object>whereMap=new HashMap<String, Object>();
			whereMap.put("custid", SpringSecurityUtils.getCurrentUser().getId());
			whereMap.put("voteid",Long.parseLong(Struts2Utils.getParameter("voteid")));
		    baseDao.delete(PubConstants.SUC_VOTE, whereMap);   
			addActionMessage("删除成功");
		 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			addActionMessage("删除失败");
		}
		return RELOAD;
	}

	@Override
	protected void prepareModel() throws Exception {
		try {
			if(_id!=null){
				DBObject db=baseDao.getMessage(PubConstants.SUC_VOTE, _id);
				entity= (VoteInfo) UniObject.DBObjectToObject(db, VoteInfo.class);
			}else{
				entity=new VoteInfo();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * ajax投票
	 */
	public void   vtp(){
	  String  tid=Struts2Utils.getParameter("tid"); 
	  Map<String, Object>sub_Map=new HashMap<String, Object>();
	  getLscode();
	  DBObject  user=wwzService.getWxUser(fromUserid);
	  try {
		if(!user.get("_id").equals("notlogin")){
			  if(StringUtils.isNotEmpty(tid)){
				  DBObject  db=baseDao.getMessage(PubConstants.SUC_VOTE, Long.parseLong(tid));
				  VoteInfo  vt=(VoteInfo) UniObject.DBObjectToObject(db, VoteInfo.class); 
				  if(vt!=null){
					  //检查用户是否已经投票
				   HashMap<String, Object> wcMap = new HashMap<String, Object>();
				   wcMap.put("fromUserid", fromUserid);
				   wcMap.put("lx",4);
				   wcMap.put("wid",vt.getVoteid());
				    //每日时间验证
				   BasicDBObject dateCondition = new BasicDBObject();
					
				   dateCondition.append("$gte",com.lsp.pub.util.DateUtil.getTimesmorning());
				   dateCondition.append("$lt",com.lsp.pub.util.DateUtil.getTimesnight()); 
				   wcMap.put("createdate", dateCondition);
				   Long  wz=baseDao.getCount(PubConstants.WHD_WHDCOUNT,wcMap); 
				   DBObject  vtlm=baseDao.getMessage(PubConstants.SUC_VOTELM, vt.getVoteid()); 
				   if(wz<Integer.parseInt(vtlm.get("frequency").toString())){
					        vt.set_id(Long.parseLong(tid));
					        vt.setCount(vt.getCount()+1);
						    baseDao.insert(PubConstants.SUC_VOTE, vt);
							//记录用户参与足迹
							WhdCount wc = new WhdCount();
							wc.set_id(mongoSequence.currval(PubConstants.WHD_WHDCOUNT));
							wc.setFromUserid(fromUserid);
							wc.setInsdate(DateFormat.getSampleDate(new Date()));
							wc.setWid(vt.getVoteid());
							wc.setTpid(Long.parseLong(tid));
							wc.setLx(4);
							wc.setCreatedate(new Date());
							baseDao.insert(PubConstants.WHD_WHDCOUNT, wc);
							
							
							//记录到榜单
							Ranking  rank=null;
							DBObject  dbrank=baseDao.getMessage(PubConstants.SUC_RANKING, "vote-"+vt.getVoteid()+"-"+tid);
							if(dbrank==null){ 
								rank=new Ranking();
								rank.set_id("vote-"+vt.getVoteid()+"-"+tid);  
								rank.setType("vote-"+vt.getVoteid());
								rank.setValue(vt.getCount()); 
								rank.setRankno(Long.parseLong(tid));
								rank.setRankname(vt.getTitle());
								baseDao.insert(PubConstants.SUC_RANKING, rank);
							}else{
								rank=(Ranking) UniObject.DBObjectToObject(dbrank, Ranking.class);
								rank.setValue(vt.getCount());
								baseDao.insert(PubConstants.SUC_RANKING, rank);
							}
							 
						    sub_Map.put("state", 0);
						    sub_Map.put("value",vt.getCount());
				   }else{
					   //今日票数已完
					   sub_Map.put("state", 2); 
				   }
					  
					
				  }
				  
			  }
		  }else{
			  
			  sub_Map.put("state", 3);  
		  }
	} catch (NumberFormatException e) {
		// TODO Auto-generated catch block
		sub_Map.put("state", 1);
		e.printStackTrace();
	}
	
	  String json = JSONArray.fromObject(sub_Map).toString();
	  Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);	
	  	
		
		
	}
	/**
	 * 查询投票人员
	 * @return
	 */
	public  String   getcount(){
		String voteid=Struts2Utils.getParameter("voteid"); 
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		whereMap.put("tpid", Long.parseLong(voteid));
		whereMap.put("lx",4);
		sortMap.put("createdate", -1);
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		} 
		List<DBObject> list=baseDao.getList(PubConstants.WHD_WHDCOUNT, whereMap,fypage,10,sortMap);
		for (DBObject dbObject : list) {
			DBObject  user=wwzService.getWxUser(dbObject.get("fromUserid").toString());
			dbObject.put("headimgurl", user.get("headimgurl"));
			dbObject.put("nickname",user.get("nickname"));
		}
		fycount=baseDao.getCount(PubConstants.WHD_WHDCOUNT, whereMap);
		Struts2Utils.getRequest().setAttribute("list",list); 
		return "count"; 
	}

	/**
	 * 投票详情
	 * 
	 * @return
	 */
	public String detail() {
		getLscode();
		Struts2Utils.getRequest().setAttribute("custid", custid);
		WxToken token=GetAllFunc.wxtoken.get(custid);
		
		 if(token.getSqlx()>0){
			 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
		 }
		 Struts2Utils.getRequest().setAttribute("token",WeiXinUtil.getSignature(token,Struts2Utils.getRequest()));
		token=WeiXinUtil.getSignature(token,Struts2Utils.getRequest()); 
		String  url=SysConfig.getProperty("ip")+"/suc/vote!detail.action?custid="+custid+"&_id="+_id;  
		if(StringUtils.isEmpty(fromUserid)){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_base&state=c1c2j3h4#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}else if(fromUserid.equals("register")){ 
			String inspection="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+token.getAppid()+"&redirect_uri="+URLEncoder.encode(url)+"&response_type=code&scope=snsapi_userinfo&state=register#wechat_redirect";
			Struts2Utils.getRequest().setAttribute("inspection",inspection);  
			return "refresh";
		}  
		DBObject db = baseDao.getMessage(PubConstants.SUC_VOTE, _id);
		DBObject rank=baseDao.getMessage(PubConstants.SUC_RANKING, "vote-"+db.get("voteid")+"-"+_id);
		db.put("rank",rank);
		Struts2Utils.getRequest().setAttribute("vote", db); 
		Struts2Utils.getRequest().setAttribute("custid", custid); 
		DBObject db1=baseDao.getMessage(PubConstants.SUC_VOTELM, Long.parseLong(db.get("voteid").toString()));
		Struts2Utils.getRequest().setAttribute("entity", db1);
		DBObject share =new BasicDBObject();
		share.put("fxtitle", db.get("title"));
		if(db1.get("mb").toString().equals("1")){
			share.put("fxtitle","助力果农，动动您的手指，或许他家的苹果就能找到卖家！");
		}
		share.put("fximg", wwzService.getWxUser(fromUserid).get("headimgurl")); 
		share.put("fxurl",url);
		share.put("fxsummary", db.get("context"));
		Struts2Utils.getRequest().setAttribute("share", share);
		if(db1.get("mb")!=null){ 	 
			return "detail"+db1.get("mb"); 
		} 
		return "detail";
	}
	public void  voteexp() throws Exception {
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		HashMap<String, Object>sortMap=new HashMap<String, Object>();
		whereMap.put("voteid",Long.parseLong(Struts2Utils.getParameter("voteid")));
		sortMap.put("createdate",-1);
		List<DBObject>list=baseDao.getList(PubConstants.SUC_VOTE, whereMap, sortMap);
		String[] header = { "标题", "票数"};
		String[] body = { "title", "count" };
		String newtime = "vote" + ".xls";

		HSSFWorkbook wb = ExportExcel
				.exportByMongo(list, header, body, newtime);
		Struts2Utils.getResponse().setHeader("Content-disposition",
				"attachment;filename=" + URLEncoder.encode(newtime, "utf-8"));
		OutputStream ouputStream = Struts2Utils.getResponse().getOutputStream();
		wb.write(ouputStream);
		ouputStream.flush();
		ouputStream.close();
		
	} 
	

}
