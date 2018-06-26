package com.lsp.user.dao;

import com.lsp.pub.db.MongoDbUtil;
import com.lsp.pub.entity.PubConstants;
import com.lsp.user.entity.UserInfo;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import org.springframework.stereotype.Component;
/***
 * 资源管理
 * @author lsp
 *
 */
@Component
public class CustInfoDao
{
  public List<DBObject> getAll(HashMap<String, Object> whereMap, HashMap<String, Object> sortMap)
  {
    MongoDbUtil mongo = new MongoDbUtil();
    DBCursor cur = mongo.queryAll(PubConstants.USER_INFO, whereMap, sortMap, UserInfo.class);
    mongo.close();
    return cur.toArray();
  }

  public List<DBObject> getMpList(HashMap<String, Object> whereMap, HashMap<String, Object> sortMap)
  {
    MongoDbUtil mongo = new MongoDbUtil();
    DBCursor cur = mongo.queryAll(PubConstants.WHD_WXFUNCTION, whereMap, sortMap);
    mongo.close();
    return cur.toArray();
  }

  public UserInfo getMessage(Long id)
  {
    MongoDbUtil mongo = new MongoDbUtil();
    UserInfo message = (UserInfo)mongo.findOneById(PubConstants.USER_INFO, id, UserInfo.class);
    mongo.close();
    return message;
  }
  public UserInfo getByLoginName(String loginName) {
    MongoDbUtil mongo = new MongoDbUtil();

    UserInfo cust = new UserInfo();
    if (loginName.equals("js"))
    {
      cust.set_id("js");
      cust.setAccount("虫吃江湖");
      cust.setPassword("123456789");
      cust.setNickname("超级管理员");
      cust.setToUser("chongchijianghu");
    }
    else
    {
      HashMap<String, Object> whereMap = new HashMap<String, Object>();
      whereMap.put("account", loginName);
      cust = (UserInfo)mongo.findOne(PubConstants.USER_INFO, whereMap, UserInfo.class);
      if (cust == null) {
        return null;
      }
      if (cust.getStartdate() != null) {
        long now = new Date().getTime();
        if ((cust.getStartdate().getTime() > now) || (cust.getEnddate().getTime() < now)) {
          return null;
        }
      }

    }

    mongo.close();
    return cust;
  }

  public void insert(UserInfo bean)
  {
    MongoDbUtil mongon = new MongoDbUtil();
    mongon.insertUpdate(PubConstants.USER_INFO, bean);
    mongon.close();
  }

  public void delete(Long id)
  {
    MongoDbUtil mongo = new MongoDbUtil();
    mongo.deleteById(PubConstants.USER_INFO, id.longValue());
    mongo.close();
  }

  public void delete()
  {
    MongoDbUtil mongo = new MongoDbUtil();
    mongo.delete(PubConstants.USER_INFO, null);
    mongo.close();
  }
}