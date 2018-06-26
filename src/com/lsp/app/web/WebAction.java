package com.lsp.app.web;

import com.lsp.app.entity.WebInfo;
import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.entity.PubConstants; 
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.web.GeneralAction;
import com.lsp.suc.entity.Share;
import com.mongodb.DBObject;

import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
/**
 * 资源管理
 * @author lsp 
 *   
 */
@Namespace("/app")
@Results({@org.apache.struts2.convention.annotation.Result(name="reload", location="web.action", type="redirect")})
public class WebAction extends GeneralAction<WebInfo>
{

  @Autowired
  private BaseDao basedao;
  private Share entity = new Share();
  private static final long serialVersionUID = -6784469775589971579L;

  public String execute()
    throws Exception
  {
    HashMap<String, Object> sortMap = new HashMap<String, Object>();
    HashMap<String, Object> whereMap = new HashMap<String, Object>();
    sortMap.put("sort", Integer.valueOf(-1));
    List<DBObject> list = this.basedao.getList(PubConstants.VIDEO_INFO, 
      whereMap, 0, 20, sortMap);
    Struts2Utils.getRequest().setAttribute("videolist", list);

    List<DBObject> adverlist = this.basedao.getList(PubConstants.ADVERT_INFO, 
      whereMap, sortMap);
    Struts2Utils.getRequest().setAttribute("adverList", adverlist);

    return "video";
  }

  public String input()
    throws Exception
  {
    return null;
  }

  public String update()
    throws Exception
  {
    return null;
  }

  public String save()
    throws Exception
  {
    return null;
  }

  public String delete()
    throws Exception
  {
    return null;
  }

  protected void prepareModel()
    throws Exception
  {
  }

@Override
public WebInfo getModel() {
	// TODO Auto-generated method stub
	return null;
}
}