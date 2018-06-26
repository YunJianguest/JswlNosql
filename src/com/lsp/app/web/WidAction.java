package com.lsp.app.web;

import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.web.TotalAction;
import org.springframework.beans.factory.annotation.Autowired;
/**
 * 资源管理
 * @author lsp 
 *   
 */
public class WidAction extends TotalAction
{
  private static final long serialVersionUID = -7868703949557549292L;

  @Autowired
  private BaseDao baseDao;
  private MongoSequence mongoSequence;

  @Autowired
  public void setMongoSequence(MongoSequence mongoSequence)
  {
    this.mongoSequence = mongoSequence;
  }

  public void getemail()
  {
  }

  public void emailDetail()
  {
  }
}