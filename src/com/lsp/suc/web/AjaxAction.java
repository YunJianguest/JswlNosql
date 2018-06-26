package com.lsp.suc.web; 
import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONArray;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
 
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;  
import com.lsp.pub.entity.GetAllFunc;
import com.lsp.pub.entity.WxToken;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.WeiXinUtil;
import com.lsp.pub.web.GeneralAction; 
import com.lsp.website.service.WwzService; 
 
/***
 * 资源管理
 * @author lsp
 *
 */
@Namespace("/suc")
@Results({ @org.apache.struts2.convention.annotation.Result(name = "reload", location = "ajax.action", type = "redirect") })
public class AjaxAction extends GeneralAction {
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

	@Override
	public Object getModel() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String input() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String update() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		
	}
	 
		/**
		 * ajax获取微信分享url
		 * @throws Exception 
		 * @throws NumberFormatException 
		 */
		public void share() throws NumberFormatException, Exception {
			String url=Struts2Utils.getParameter("url");  
			Map<String, Object> sub_map = new HashMap<String, Object>();
			WxToken token=GetAllFunc.wxtoken.get(custid); 
			 if(token.getSqlx()>0){
				 token=GetAllFunc.wxtoken.get(wwzService.getparentcustid(custid)); 
			 } 
			 
			token=WeiXinUtil.getAjaxSignature(token,url);
		    token.put("url",wwzService.getshareurl(custid, url));
		    sub_map.put("token",token);
			String json = JSONArray.fromObject(sub_map).toString();
			Struts2Utils.renderJson(json.substring(1, json.length() - 1), new String[0]);
			

		}
	 
	 
}
