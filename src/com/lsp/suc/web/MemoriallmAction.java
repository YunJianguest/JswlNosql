package com.lsp.suc.web;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.regex.Pattern;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

 
 
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoDbUtil;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.PubConstants; 
import com.lsp.pub.entity.WxToken;
import com.lsp.pub.util.BaseDate;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.web.GeneralAction;
import com.lsp.suc.entity.AnswerInfo;
import com.lsp.suc.entity.AnswerRecord;
import com.lsp.suc.entity.AnswerRecordDetail;
import com.lsp.suc.entity.IntegralInfo;
import com.lsp.suc.entity.Integrallm;
import com.lsp.suc.entity.MemorialInfo;
import com.lsp.suc.entity.Memoriallm;
import com.lsp.suc.entity.Comunit; 
import com.mongodb.DBObject;
 
/**
 * 祭奠栏目管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name = MemoriallmAction.RELOAD, location = "memoriallm.action", type = "redirect") })
public class MemoriallmAction extends GeneralAction<Memoriallm> {

	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private MongoSequence mongoSequence;	
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	} 
	private Memoriallm entity=new Memoriallm();
	private Long _id;


	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		HashMap<String, Object> backMap =new HashMap<String, Object>(); 
		String toUser=SpringSecurityUtils.getCurrentUser().getToUser(); 	
		if(SpringSecurityUtils.getCurrentUser().getComid()==null){
			 
			whereMap.put("toUser", toUser);
			
		}else{
			whereMap.put("comid", SpringSecurityUtils.getCurrentUser().getComid());	
		}
		String title=Struts2Utils.getParameter("title");
		if(!StringUtils.isEmpty(title)){
			Pattern pattern = Pattern.compile("^.*" + title + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern);
		}
		sortMap.put("sort", -1);
		fycount=baseDao.getCount(PubConstants.MEMORIAL_LM, whereMap);
		
		if(Struts2Utils.getParameter("fypage")!=null){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		backMap.put("context", 0);
		List<DBObject> list=baseDao.getList(PubConstants.MEMORIAL_LM,whereMap,fypage,10, sortMap,backMap);
		Struts2Utils.getRequest().setAttribute("MemoriallmList", list);
		Struts2Utils.getRequest().setAttribute("toUser", toUser);
		return SUCCESS;
	}
	

	@Override
	public String delete() throws Exception {
		try {
			 
			baseDao.delete(PubConstants.MEMORIAL_LM,_id);
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
		return "add";
	}
	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			//有custId查出来 用户信息
			entity = (Memoriallm)UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.MEMORIAL_LM,_id),Memoriallm.class);
		} else {
			entity = new Memoriallm();
		}
	}
	public void  upd(){ 
		DBObject db=baseDao.getMessage(PubConstants.MEMORIAL_LM, _id); 
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
		
	}
	
	@Override
	public String save() throws Exception {
		//注册业务逻辑
		try {
			if(_id == null){
				_id=mongoSequence.currval(PubConstants.MEMORIAL_LM);	
			}
			entity.set_id(_id);
			entity.setToUser(SpringSecurityUtils.getCurrentUser().getToUser());
			entity.setCreatedate(new Date());
			baseDao.insert(PubConstants.MEMORIAL_LM,entity);
			
			
			addActionMessage("成功添加!");
			
		
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		
		return RELOAD;
	}

	public String web() throws Exception {	
		_id=Long.parseLong(Struts2Utils.getParameter("_id")); 
		
		WxToken token=WeiXinUtil.getSignature(toUser,Struts2Utils.getRequest());
		
	
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		Comunit toentity=GetAllFunc.wxTouser.get(toUser);
		Struts2Utils.getRequest().setAttribute("toUserEntity",toentity);
		DBObject answer=baseDao.getMessage(PubConstants.SUC_ANSWER,_id);
		

		Long sjs=mongoSequence.currval("whd_answersjs");
		Struts2Utils.getRequest().setAttribute("sjs", sjs);
		
			
		AnswerRecord anserrecord=new AnswerRecord();
		anserrecord.set_id(fromUser+"-"+_id+"-"+sjs);
		anserrecord.setInsdate(new Date());
		System.out.println(fromUser+"-"+_id+"-"+sjs);  
		anserrecord.setFromUser(fromUser);
		anserrecord.setWid(_id);
		baseDao.insert(PubConstants.SUC_ANSWERRECORD, anserrecord);
		
		
		Struts2Utils.getRequest().setAttribute("answer", answer);
		DBObject re = baseDao.getMessage(PubConstants.WX_REFLASH,toUser+"_4" );
		Struts2Utils.getRequest().setAttribute("re", re);
		
		
		Struts2Utils.getRequest().setAttribute("token", token);
		Struts2Utils.getRequest().setAttribute("wj", baseDao.getMessage(PubConstants.SET_FOOTSUMMARY, toUser+"-answer"));
		Struts2Utils.getRequest().setAttribute("footSummary", baseDao.getMessage(PubConstants.SET_FOOTSUMMARY, toUser+"-fspy"));
		if(answer.get("dtsj")!=null){
			Struts2Utils.getRequest().setAttribute("enddate", BaseDate.addMinute(new Date() , (Integer)answer.get("dtsj")));
		}
		
		return "web"+answer.get("mb").toString();
	} 
	/**
	 * 祭祀详情
	 * @return
	 * @throws Exception
	 */
	public String detail()throws Exception{
		String toUser=Struts2Utils.getParameter("toUser");
		DBObject  db=baseDao.getMessage(PubConstants.MEMORIAL_INFO, _id);
		Struts2Utils.getRequest().setAttribute("entity", db);
		Struts2Utils.getRequest().setAttribute("toUser", toUser);
		return "detail"+db.get("mb").toString();
	}
	public String jieguo() throws Exception {	
		 
		String wid=Struts2Utils.getParameter("wid");
	  
		DBObject answer=baseDao.getMessage(PubConstants.SUC_ANSWER,_id);
		DBObject answerrecord=baseDao.getMessage(PubConstants.SUC_ANSWERRECORD,wid);
		Date startdate=DateFormat.getFormat(answerrecord.get("startdate").toString());
		Date enddate=DateFormat.getFormat(answerrecord.get("enddate").toString());
		//积分
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		whereMap.put("toUser",Struts2Utils.getParameter("toUser"));
		whereMap.put("key","answer");
		DBObject     jflm=baseDao.getMessage(PubConstants.INTEGRALM, whereMap); 
		IntegralInfo jf=new IntegralInfo();
		jf.set_id(mongoSequence.currval(PubConstants.INTEGRAL_INFO));
		jf.setCreatedate(new Date());
		jf.setFromUser(fromUser);
		jf.setToUser(Struts2Utils.getParameter("toUser"));
		jf.setType("answer");
		jf.setValue(Integer.parseInt(answerrecord.get("fen").toString())*Integer.parseInt(jflm.get("value").toString()));
		baseDao.insert(PubConstants.INTEGRAL_INFO, jf);
		
		long l=(enddate.getTime()-startdate.getTime())/(60000);
		System.out.println(enddate.getTime()-startdate.getTime());
		int fen=Integer.parseInt(answerrecord.get("fen").toString());
		if(fen>=100){
			Struts2Utils.getRequest().setAttribute("result", answer.get("result10").toString());
		}else if(fen>=90){
			Struts2Utils.getRequest().setAttribute("result", answer.get("result9").toString());
		}else if(fen>=80){
			Struts2Utils.getRequest().setAttribute("result", answer.get("result8").toString());
		}else if(fen>=70){
			Struts2Utils.getRequest().setAttribute("result", answer.get("result7").toString());
		}else if(fen>=60){
			Struts2Utils.getRequest().setAttribute("result", answer.get("result6").toString());
		}else {
			Struts2Utils.getRequest().setAttribute("result", answer.get("result0").toString());
		}
		Struts2Utils.getRequest().setAttribute("dtsc", l);

		
		
		Struts2Utils.getRequest().setAttribute("answer", answer);
		
		return "jieguo";
	}
	/**
	 * 答完记录
	 * @return
	 * @throws Exception
	 */
	public void getNext() throws Exception { 
		String sjs=Struts2Utils.getParameter("sjs");
		int score=Integer.parseInt(Struts2Utils.getParameter("score"));
		int cts=Integer.parseInt(Struts2Utils.getParameter("cts"));
		String dtnum=Struts2Utils.getParameter("dtnum");
		String detailid=Struts2Utils.getParameter("detailid");
		
		Map<String, Object> sub_map = new HashMap<String, Object>();
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		String wid=fromUser+"-"+_id+"-"+sjs; 
		DBObject ardb=baseDao.getMessage(PubConstants.SUC_ANSWERRECORD, wid);
		 
		if(ardb==null){
			sub_map.put("state", 1);
		
			String json = JSONArray.fromObject(sub_map).toString();
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
			return;
		}
		whereMap.clear();
		whereMap.put("wid", wid);
		long dtcount=baseDao.getCount(PubConstants.SUC_ANSREDETAIL, whereMap);
		if(score<9000){
			AnswerRecordDetail ans=new AnswerRecordDetail();
			ans.set_id(mongoSequence.currval(PubConstants.SUC_ANSREDETAIL));
			ans.setWid(wid);
			ans.setDaan(dtnum);
			ans.setDetailid(Long.parseLong(detailid));
			ans.setScore(score);
			ans.setSort((int)dtcount+1);
			baseDao.insert(PubConstants.SUC_ANSREDETAIL, ans);
			
			
			AnswerRecord anserrecord = (AnswerRecord)UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.SUC_ANSWERRECORD, wid),AnswerRecord.class);
			anserrecord.set_id(wid);
			String startdate=Struts2Utils.getParameter("startdate"); 
			anserrecord.setStartdate(DateFormat.getFormat(startdate));
			anserrecord.setEnddate(new Date());
			anserrecord.setFromUser(fromUser);
			anserrecord.setFen(anserrecord.getFen()+score);
			baseDao.insert(PubConstants.SUC_ANSWERRECORD, anserrecord); 
		} 
		if(dtcount+1>=cts){
			sub_map.put("state", 2);
			sub_map.put("wid", wid);
			String json = JSONArray.fromObject(sub_map).toString();
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
			return;
		}
		
		whereMap.clear();
		whereMap.put("wid", _id);
		whereMap.put("toUser", toUser);
		sortMap.put("sort", 1);
		fycount=baseDao.getCount(PubConstants.SUC_ANSREDETAIL, whereMap);
		Random rand = new Random();
		int num = rand.nextInt((int)fycount);
		List<DBObject> list=baseDao.getList(PubConstants.SUC_ANSREDETAIL,whereMap,num,1, sortMap);
	
		sub_map.put("state", 0);
		sub_map.put("detail", list.get(0));
		 
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	
	}
	
	public String webrecord() throws Exception {	
		
		DBObject answer=baseDao.getMessage(PubConstants.SUC_ANSWER,_id);
		Struts2Utils.getRequest().setAttribute("entity", answer);
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		
		whereMap.put("wid", _id);
	
		sortMap.put("sort", -1);
		if(StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))){
			fypage=Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}
		List<DBObject> list=baseDao.getList(PubConstants.SUC_ANSWERRECORD,whereMap,fypage,10, sortMap);
		List<DBObject> relist=new ArrayList<DBObject>();
		for(int i=0;i<list.size();i++){
			DBObject re=list.get(i);
//			DBObject userdb = baseDao.getMessage(PubConstants.DATA_WXUSER, re.get("fromUser").toString());
//			if(userdb!=null){
//				if(userdb.get("nickname")!=null){
//					re.put("nickname", userdb.get("nickname").toString());	
//				}else{
//					re.put("nickname", "游客");	
//				}
//				if(userdb.get("headimgurl")!=null){
//					re.put("headimgurl", userdb.get("headimgurl").toString());	
//				}
//			}else{
//				re.put("nickname", "游客");	
//			}
			relist.add(re);
		}
		Struts2Utils.getRequest().setAttribute("recordList", relist);
		
		//WxToken token=WeiXinUtil.getSignature(toUser,Struts2Utils.getRequest());
		
		//Struts2Utils.getRequest().setAttribute("token", token);
		//Struts2Utils.getRequest().setAttribute("list",GetAllFunc.wxFunc.get(toUser));
		return "webrecord";
	}
	/**
	 * 下拉加载更多
	 * 
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@SuppressWarnings("unchecked")
	public String webajax() throws UnsupportedEncodingException {
		HashMap<String, Object> sortMap =new HashMap<String, Object>();
		HashMap<String, Object> whereMap =new HashMap<String, Object>();
		
		whereMap.put("wid", _id);

		sortMap.put("sort", 1);
		List<DBObject> list=baseDao.getList(PubConstants.SUC_ANSREDETAIL,whereMap,0,10, sortMap);
		Struts2Utils.getRequest().setAttribute("placelist", list);
		return "webajax";
	}
	@Override
	public Memoriallm getModel() {
		return entity;
	}
	public void set_id(Long _id) {
		this._id = _id;
	}
	public static void main(String[] args) throws Exception {
		MongoDbUtil mongoDbUtil=new MongoDbUtil();
		DBObject answerrecord=mongoDbUtil.findOneById(PubConstants.SUC_ANSWERRECORD,"oypimjo3Ln36uWtmW6TYWtND0P0o-5-146");
		Date startdate=DateFormat.getFormat(answerrecord.get("startdate").toString());
		Date enddate=DateFormat.getFormat(answerrecord.get("enddate").toString());
		System.err.println(enddate.getTime());
		System.err.println(startdate.getTime());
		long l=enddate.getTime()-startdate.getTime();
		System.err.println(l);
		System.err.println(l/60000);
	    }
	
}


