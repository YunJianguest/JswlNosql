package com.lsp.user.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.GrantedAuthority;
import org.springframework.security.GrantedAuthorityImpl;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.FuncInfo;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.entity.RoleInfo;
import com.lsp.pub.util.PasswordUtil;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.sys.security.CustomerUser;
import com.lsp.user.entity.UserInfo;
import com.mongodb.DBObject;
/***
 * 资源管理
 * @author lsp
 *
 */
@Component
@Transactional(readOnly=true)
public class LoginService {
	@Autowired
	private BaseDao baseDao;
	@Autowired
	private MongoSequence mongoSequence;
	/**
	 * 初始化平台
	 * @param user
	 * @return
	 */
	private GrantedAuthority[] obtainGrantedAuthorities(UserInfo user)
	  {
		Set<GrantedAuthority> authSet = new HashSet<GrantedAuthority>();
	    List<FuncInfo> authorityList=new ArrayList<FuncInfo>();
	    List<Long> roleid;
	    if (user.getRoleid()==null) {
	    	//未绑定平台账号（初始化默认权限）
	      List <Long> funcinfo =new ArrayList<Long>();
	      funcinfo.add(3L);
	      funcinfo.add(4L);

	      for (int i = 0; i < funcinfo.size(); i++) {
	        FuncInfo func = new FuncInfo(); 
	        func.set_id(funcinfo.get(i));
	        authorityList.add(func);
	      }
	    }
	    else {
	      RoleInfo role = (RoleInfo)this.baseDao.getMessage(PubConstants.ROLE_INFO, user.getRoleid(), RoleInfo.class);

	      if (role != null) {
	        roleid = role.getFuncList();
	        for (int i = 0; i < roleid.size(); i++) {
	          FuncInfo func = new FuncInfo();
	          DBObject f = this.baseDao.getMessage(PubConstants.FUNC_INFO, (Long)roleid.get(i));
	          if (f != null) {
	            func = (FuncInfo)JSON.parseObject(f.toString(), FuncInfo.class);
	            func.set_id(f.get("_id"));
	            authorityList.add(func);
	          }

	        }

	      }

	    }

	    for (FuncInfo linkInfo : authorityList) {
	      authSet.add(new GrantedAuthorityImpl(linkInfo.getAuthName()));
	    }

	    authSet.add(new GrantedAuthorityImpl("ROLE_0"));

	    return (GrantedAuthority[])authSet.toArray(new GrantedAuthority[authSet.size()]);
	  }
	/**
	 * 验证用户
	 * @param qqfromUser
	 * @return
	 */
	private  UserInfo  getUser(String qqfromUser){
		UserInfo  obj=null;
		HashMap<String, Object>whereMap=new HashMap<String, Object>();
		whereMap.put("qqfromUser", qqfromUser);
		DBObject  db=baseDao.getMessage(PubConstants.USER_INFO, whereMap);
		DBObject  user=baseDao.getMessage(PubConstants.DATA_WXUSER, whereMap);
		if(db!=null){
			 obj=(UserInfo) UniObject.DBObjectToObject(db, UserInfo.class);
			 if(obj.getAccount()==null){
				 obj.setAccount(obj.get_id().toString());
				 obj.setPassword(PasswordUtil.genRandomNum(11));
				 obj.setNickname(user.get("nickname").toString()); 
			 }
		 }else{
			 //新建账户
			 obj=new UserInfo();
			 String  id=UUID.randomUUID().toString();
			 obj.set_id(id);
			 obj.setAccount(id);
			 obj.setPassword(PasswordUtil.genRandomNum(11));
			 obj.setQqfromUser(qqfromUser);
			 obj.setCreatedate(new Date());
			 obj.setNickname(user.get("nickname").toString());
			 baseDao.insert(PubConstants.USER_INFO, obj);
			  
		 }
		 
		return obj;
	}

	/**
	 * 返回Spring用户
	 * 
	 * @param qqfromUser
	 * @return
	 */
	public CustomerUser getUserDeatil(String qqfromUser) {
		CustomerUser userdetail = null;
		UserInfo user = getUser(qqfromUser);
		boolean accountNonExpired = true;
		boolean credentialsNonExpired = true;
		boolean accountNonLocked = true;
		GrantedAuthority[] grantedAuths = obtainGrantedAuthorities(user);
		userdetail = new CustomerUser(user.get_id().toString(),
				user.getAccount(), user.getPassword(), true, accountNonExpired,
				credentialsNonExpired, accountNonLocked, grantedAuths);
		userdetail.setLoginname(user.getAccount());
		userdetail.setCustname(user.getNickname());
		userdetail.setEmail(user.getEmail());
		userdetail.setId(user.get_id().toString());
		userdetail.setAppId(user.getAppid());
		userdetail.setAppSecret(user.getAppsecret());
		userdetail.setToUser(user.getToUser());
		userdetail.setOrgid(user.getOrgid());
		userdetail.setRoleid(user.getRoleid());
		userdetail.setOrgname(user.getOrgname());
		userdetail.setSchool(user.getSchool());
		userdetail.setGrade(user.getGrade());
		userdetail.setClasses(user.getClasses());
		userdetail.setWwzqx(user.getRemark());
		userdetail.setComid(user.getComid());
		userdetail.setType(user.getType());
		userdetail.setCss(user.getCss());
		userdetail.setCustid(user.getCustid());
		return userdetail;

	}

}
