package com.lsp.android.web; 

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Date;

import net.sf.ezmorph.object.DateMorpher;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.JSONUtils;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;

import org.apache.struts2.convention.annotation.Results;
import org.directwebremoting.ScriptSession;
import org.directwebremoting.WebContextFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

import com.lsp.android.entity.MessageInfo; 
import com.lsp.dwr.service.ChatMessageEvent;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence; 
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.DateUtil;
import com.lsp.pub.util.JsonValueProcessorImplTest;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.web.GeneralAction; 
import com.lsp.website.service.WwzService;

/**
 * 房间管理
 * 
 * @author lsp
 * 
 */
@Namespace("/android")
@Results({ @org.apache.struts2.convention.annotation.Result(name = "reload", location = "chat.action", type = "redirect") })
public class ChatAction extends GeneralAction implements
		ApplicationContextAware {

	private static final long serialVersionUID = -6784469775589971579L;

	private ApplicationContext ctx;
	@Autowired
	private BaseDao basedao;
	private Long _id; 
	private MongoSequence mongoSequence; 
	@Autowired
	private WwzService  wwzservice;

	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}

	public void set_id(Long _id) {
		this._id = _id;
	}

	@Override
	public String execute() throws Exception {
	  
		return SUCCESS;
	}

	@Override
	public String input() throws Exception {
		// TODO Auto-generated method stub
		return "add";
	}

	@Override
	public String update() throws Exception {
		// TODO Auto-generated method stub
		return "add";
	}

	@Override
	public String save() throws Exception {
		 
		return RELOAD;
	}

	@Override
	public String delete() throws Exception {
		 
		return RELOAD;
	}

	@Override
	protected void prepareModel() throws Exception {
		 

	}

	@Override
	public Object getModel() {
		// TODO Auto-generated method stub
		return null;
	} 
	public void onPageLoad(final String custid,final String lscode,String type,String per) {
		// 获取当前的ScriptSession
		ScriptSession scriptSession = WebContextFactory.get()
				.getScriptSession();
		scriptSession.setAttribute("fromUserid", wwzservice.getfromUseridfromcode(lscode));
		scriptSession.setAttribute("custid", custid); 
		scriptSession.setAttribute("type", type); 
		scriptSession.setAttribute("per", per); 
	}

	@Override
	public void setApplicationContext(ApplicationContext ctx)
			throws BeansException {
		// TODO Auto-generated method stub
		this.ctx = ctx;

	}

	public void sendMessage(MessageInfo msg) {

		// 发布事件 
		ctx.publishEvent(new ChatMessageEvent(msg));

	} 
	public String login() {
		return "web";
	}
	public void printMessage(){  
		 try {
			InputStream input =Struts2Utils.getRequest().getInputStream(); 
			BufferedReader br = new BufferedReader(new InputStreamReader(input,"utf-8"));
			String line = null;
			StringBuilder sb = new StringBuilder();
			while ((line = br.readLine()) != null) {
					line = new String(line.getBytes(), "utf-8");
					sb.append(line);
			} 
			if(sb!=null){     
				JSONObject json = JSONObject.fromObject(URLDecoder.decode(sb.toString(),
						"utf-8"));  
					MessageInfo  ms=new MessageInfo();
					ms.set_id(json.getString("_id"));
					ms.setTitle(json.getString("title"));
					Long  i=Long.parseLong(JSONObject.fromObject(json.getString("createdate")).getString("time"));  
					ms.setCreatedate(new Date(i));
					ms.setCustid(json.getString("custid")); 
					ms.setFromUserid(json.getString("fromUserid"));
					ms.setPicurl(json.getString("picurl"));
					ms.setUrl(json.getString("url"));
					ms.setSummary(json.getString("summary"));
					ms.setLx(json.getString("lx"));
					ms.setComname(json.getString("comname"));
					ms.setOrderid(json.getString("orderid"));
					ms.setProcount(json.getString("procount"));
					ms.setProstate(json.getString("prostate"));
					ms.setProtitle(json.getString("protitle"));
					if(StringUtils.isNotEmpty(json.getString("type"))){
						ms.setType(Integer.parseInt(json.getString("type")));
					}
					sendMessage(ms);
			}
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
	}
	
}
