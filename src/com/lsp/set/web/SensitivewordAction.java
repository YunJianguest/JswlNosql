package com.lsp.set.web;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import net.sf.json.JSONArray;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction;
import com.lsp.set.entity.SensitiveWord;
import com.mongodb.DBObject;
import com.mongodb.util.JSON;
/**
 * 资源管理
 * 
 * @author lsp
 * 
 */
@Namespace("/set")
@Results({ @Result(name = SensitivewordAction.RELOAD, location = "sensitiveword.action", type = "redirect") })
public class SensitivewordAction extends GeneralAction<SensitiveWord>{
	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private MongoSequence mongoSequence;
	private SensitiveWord entity = new SensitiveWord();;
	private Long _id;
	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}

	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		sortMap.put("sort", -1);
		
		List<DBObject> list = baseDao.getList(PubConstants.SET_SENSITIVEWORD,whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("wordList", list);
		
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		try {
			
			baseDao.delete(PubConstants.SET_SENSITIVEWORD, _id);
			addActionMessage("删除成功!");

		
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,删除失败!");
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
	public void upd() throws Exception {
		DBObject db = baseDao.getMessage(PubConstants.SET_SENSITIVEWORD, _id);
		
		String json = JSONArray.fromObject(db).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
	}


	@Override
	protected void prepareModel() throws Exception {
		if (_id != null) {
			// 有custId查出来 用户信息
			entity = (SensitiveWord)UniObject.DBObjectToObject(baseDao.getMessage(PubConstants.SET_SENSITIVEWORD,_id),SensitiveWord.class);
			
		} else {
			entity = new SensitiveWord();
		}
	}

	@Override
	public String save() throws Exception {
		// 注册业务逻辑
		try {
			if(_id==null){
				_id=mongoSequence.currval(PubConstants.SET_SENSITIVEWORD);
			} 
			entity.set_id(_id);
			baseDao.insert(PubConstants.SET_SENSITIVEWORD, entity); 
			addActionMessage("成功添加!");
		} catch (Exception e) {
			e.printStackTrace();
			addActionMessage("抱歉,添加过程中出现异常!");
		}
		return RELOAD;
	}
	public void fabu() throws Exception {
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		Set<String> wordSet=new HashSet<String>();
		List<DBObject> list = baseDao.getList(PubConstants.SET_SENSITIVEWORD,whereMap, null);
		for(DBObject db:list){
			if(db.get("word")!=null){
				String[] aa=db.get("word").toString().split(",");
				for(String a:aa){
					wordSet.add(a);
				}
			}
		}
		
		GetAllFunc.wordSet=wordSet;
	
	}

	
	@Override
	public SensitiveWord getModel() {
		return entity;
	}

	public void set_id(Long _id) {
		this._id = _id;
	}
	 
}
