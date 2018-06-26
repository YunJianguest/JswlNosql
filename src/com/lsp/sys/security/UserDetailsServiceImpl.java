package com.lsp.sys.security;

import com.alibaba.fastjson.JSON;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.entity.FuncInfo;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.entity.RoleInfo;
import com.lsp.user.dao.CustInfoDao;
import com.lsp.user.entity.UserInfo;
import com.mongodb.DBObject;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.security.GrantedAuthority;
import org.springframework.security.GrantedAuthorityImpl;
import org.springframework.security.userdetails.UserDetails;
import org.springframework.security.userdetails.UserDetailsService;
import org.springframework.security.userdetails.UsernameNotFoundException;
import org.springframework.transaction.annotation.Transactional;
/***
 * 资源管理
 * @author lsp
 *
 */
@Transactional(readOnly=true)
public class UserDetailsServiceImpl
  implements UserDetailsService
{

  @Autowired
  private BaseDao baseDao;

  @Autowired
  private CustInfoDao custInfoDao;

  public UserDetails loadUserByUsername(String username)
    throws UsernameNotFoundException, DataAccessException
  {
    UserInfo user = this.custInfoDao.getByLoginName(username);

    if (user == null) {
      throw new UsernameNotFoundException("用户名" + username + "不存在");
    }

    GrantedAuthority[] grantedAuths = obtainGrantedAuthorities(user);

    boolean accountNonExpired = true;
    boolean credentialsNonExpired = true;
    boolean accountNonLocked = true;

    CustomerUser userdetail = new CustomerUser(user.get_id().toString(), 
      user.getAccount(), user.getPassword(), true, accountNonExpired, credentialsNonExpired, 
      accountNonLocked, grantedAuths);
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
    userdetail.setArea(user.getArea());
    userdetail.setProvince(user.getProvince());
    userdetail.setCity(user.getCity());

    if (userdetail.getComid()!=null) {
      HashMap<String, Object> sortMap =new HashMap<String, Object>();
	  HashMap<String, Object> whereMap =new HashMap<String, Object>();
      whereMap.put("toUser", userdetail.getToUser());
      whereMap.put("comid", userdetail.getComid());
      sortMap.put("sort", Integer.valueOf(1));
      List<DBObject> mpfunc=custInfoDao.getMpList(whereMap, sortMap);
	  userdetail.setMpfunc(mpfunc);
    }

    return userdetail;
  }

  private GrantedAuthority[] obtainGrantedAuthorities(UserInfo user)
  {
	Set<GrantedAuthority> authSet = new HashSet<GrantedAuthority>();
    List<FuncInfo> authorityList=new ArrayList<FuncInfo>();
    List<Long> roleid;
    if (user.get_id().toString().equals("js")) {
      List <DBObject> funcinfo = this.baseDao.getList(PubConstants.FUNC_INFO, null, null);

      for (int i = 0; i < funcinfo.size(); i++) {
        FuncInfo func = new FuncInfo();

        func = (FuncInfo)JSON.parseObject(((DBObject)funcinfo.get(i)).toString(), FuncInfo.class);
        func.set_id(((DBObject)funcinfo.get(i)).get("_id"));
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
}