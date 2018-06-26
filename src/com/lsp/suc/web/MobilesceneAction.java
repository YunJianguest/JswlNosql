package com.lsp.suc.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import com.lsp.pub.dao.BaseDao;
import com.lsp.pub.db.MongoSequence;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.SpringSecurityUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.UniObject;
import com.lsp.pub.web.GeneralAction;
import com.lsp.suc.entity.MobileScene;
import com.lsp.suc.entity.SceneInfo;
import com.lsp.suc.entity.SpiritInfo;
import com.lsp.suc.entity.Tourism;
import com.lsp.website.entity.AnimationInfo;
import com.lsp.website.entity.StyleInfo;
import com.lsp.website.service.WebsiteService;
import com.mongodb.DBObject;

/**
 * 移动场景管理
 * 
 * @author lsp
 * 
 */
@Namespace("/suc")
@Results({ @Result(name = MobilesceneAction.RELOAD, location = "mobilescene.action", type = "redirect") })
public class MobilesceneAction extends GeneralAction<MobileScene> {

	private static final long serialVersionUID = -6784469775589971579L;
	@Autowired
	private BaseDao baseDao;
	private MongoSequence mongoSequence;

	@Autowired
	public void setMongoSequence(MongoSequence mongoSequence) {
		this.mongoSequence = mongoSequence;
	}

	@Autowired
	private WebsiteService webService;

	private MobileScene entity = new MobileScene();
	private Long _id;

	public void set_id(Long _id) {
		this._id = _id;
	}

	@Override
	public String execute() throws Exception {
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		HashMap<String, Object> backMap = new HashMap<String, Object>();
		toUser = SpringSecurityUtils.getCurrentUser().getToUser();
		sortMap.put("sort", -1);
		whereMap.put("toUser", toUser);

		String title = Struts2Utils.getParameter("title");
		if (StringUtils.isNotEmpty(title)) {
			Pattern pattern = Pattern.compile("^.*" + title + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern);
			Struts2Utils.getRequest().setAttribute("title", title);
		}
		backMap.put("context", 0);
		backMap.put("summary", 0);

		if (StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))) {
			fypage = Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}

		List<DBObject> list = baseDao.getList(PubConstants.SUC_MOBLILESCENE,
				whereMap, fypage, 10, sortMap, backMap);
		fycount = baseDao.getCount(PubConstants.SUC_MOBLILESCENE, whereMap);
		Struts2Utils.getRequest().setAttribute("mobilesceneList", list);
		Struts2Utils.getRequest().setAttribute("toUser", toUser);
		return MobilesceneAction.SUCCESS;

	}

	@Override
	public String input() throws Exception {
		// TODO Auto-generated method stub
		Struts2Utils.getRequest().setAttribute("tab", 0);
		String msid = Struts2Utils.getParameter("msid");
		String toUser = SpringSecurityUtils.getCurrentUser().getToUser();
		Struts2Utils.getRequest().setAttribute("toUser", toUser);
		if (StringUtils.isNotEmpty(msid)) {
			Struts2Utils.getRequest().setAttribute(
					"entity",
					baseDao.getMessage(PubConstants.SUC_MOBLILESCENE,
							Long.parseLong(msid)));
		}
		Struts2Utils.getRequest().setAttribute("msid", msid);
		Struts2Utils.getRequest().setAttribute("scid",
				Struts2Utils.getParameter("scid"));
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		HashMap<String, Object> sortMap = new HashMap<String, Object>();

		whereMap.put("toUser", toUser);
		if (StringUtils.isNotEmpty(msid)) {

			whereMap.put("msid", Long.parseLong(msid));
		}
		sortMap.put("sort", 1);
		List<DBObject> scenelist = baseDao.getList(PubConstants.SUC_SCENE,
				whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("scenelist", scenelist);
		Struts2Utils.getRequest().setAttribute("styleid", msid);
		return "add";
	}

	@Override
	public String update() throws Exception {
		// TODO Auto-generated method stub
		if (_id != null) {
			DBObject db = baseDao
					.getMessage(PubConstants.SUC_MOBLILESCENE, _id);
			Struts2Utils.getRequest().setAttribute("entity", db);
		}
		return "add";
	}

	/**
	 * 根据ID查询对应层集合
	 * 
	 * @return
	 */
	public String getSceneById() {
		String id = Struts2Utils.getParameter("id");
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		sortMap.put("sort", -1);
		whereMap.put("msid", Long.parseLong(id));
		List<DBObject> list = baseDao.getList(PubConstants.SUC_SCENE, whereMap,
				sortMap);
		Struts2Utils.getRequest().setAttribute("sceneList", list);
		return null;

	}

	/**
	 * 根据ID查询对应精灵集合
	 * 
	 * @return
	 */
	public String getSpiritById() {
		String id = Struts2Utils.getParameter("id");
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		sortMap.put("sort", -1);
		whereMap.put("scid", Long.parseLong(id));
		List<DBObject> list = baseDao.getList(PubConstants.SUC_SPIRIT,
				whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("spiritList", list);
		return null;

	}

	/**
	 * 查询图层集合
	 */
	public void getScene() {
		String id = Struts2Utils.getParameter("id");
		String toUser = Struts2Utils.getParameter("toUser"); 
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		sortMap.put("sort", 1);
		whereMap.put("msid", Long.parseLong(id));
		whereMap.put("toUser", toUser);
		List<DBObject> list = baseDao.getList(PubConstants.SUC_SCENE, whereMap,
				sortMap);
		if (list.size() > 0) {
			sub_map.put("list", list);
			sub_map.put("state", 0);
		} else {
			sub_map.put("state", 1);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1),
				new String[0]);

	}

	/**
	 * 查询精灵集合
	 */
	public void getSpirits() {
		String id = Struts2Utils.getParameter("id");
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		Map<String, Object> sub_map = new HashMap<String, Object>();
		sortMap.put("sort", 1);
		whereMap.put("scid", Long.parseLong(id));
		List<DBObject> list = baseDao.getList(PubConstants.SUC_SPIRIT,
				whereMap, sortMap);
		if (list.size() > 0) {
			sub_map.put("list", list);
			sub_map.put("state", 0);
		} else {
			sub_map.put("state", 1);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1),
				new String[0]);

	}

	/**
	 * ajax删除精灵
	 */
	public void deleteSpirit() {
		try {
			String id = Struts2Utils.getParameter("id");
			String scid = Struts2Utils.getParameter("scid");
			String toUser = Struts2Utils.getParameter("toUser");
			HashMap<String, Object> whereMap = new HashMap<String, Object>();
			HashMap<String, Object> sortMap = new HashMap<String, Object>();
			Map<String, Object> sub_map = new HashMap<String, Object>();
			if (StringUtils.isNotEmpty(id)) {
				baseDao.delete(PubConstants.SUC_SPIRIT, Long.parseLong(id));
				baseDao.delete(PubConstants.STYLE_INFO, toUser + "-scene-"
						+ scid + "-" + id);
				baseDao.delete(PubConstants.ANIMATION_INFO, toUser + "-scene-"
						+ scid + "-" + id);
				sub_map.put("delete", 0);
			}
			sortMap.put("sort", 1);
			whereMap.put("scid", Long.parseLong(scid));
			List<DBObject> list = baseDao.getList(PubConstants.SUC_SPIRIT,
					whereMap, sortMap);
			if (list.size() > 0) {
				sub_map.put("list", list);
				sub_map.put("state", 0);
			} else {
				sub_map.put("state", 1);
			}

			String json = JSONArray.fromObject(sub_map).toString();
			Struts2Utils.renderJson(json.substring(1, json.length() - 1),
					new String[0]);
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 保存层
	 * 
	 * @return
	 */
	public String saveScene() {
		try {
			String id = Struts2Utils.getParameter("id");
			String msid = Struts2Utils.getParameter("msid");
			Struts2Utils.getRequest().setAttribute("msid", msid);
			Struts2Utils.getRequest().setAttribute("tab",
					Struts2Utils.getParameter("tab"));
			String title = Struts2Utils.getParameter("title");
			String summary = Struts2Utils.getParameter("summary");
			String picurl = Struts2Utils.getParameter("picurl");
			String sort = Struts2Utils.getParameter("sort");
			String toUser = SpringSecurityUtils.getCurrentUser().getToUser();
			Struts2Utils.getRequest().setAttribute("toUser", toUser);
			SceneInfo sceneInfo = new SceneInfo();
			if (!StringUtils.isNotEmpty(id)) {
				sceneInfo.set_id(mongoSequence.currval(PubConstants.SUC_SCENE));
			} else {
				sceneInfo.set_id(Long.parseLong(id));
			}
			sceneInfo.setPicurl(picurl);
			sceneInfo.setMsid(Long.parseLong(msid));
			sceneInfo.setSort(Integer.parseInt(sort));
			sceneInfo.setTitle(title);
			sceneInfo.setSummary(summary);
			sceneInfo.setToUser(toUser);
			baseDao.insert(PubConstants.SUC_SCENE, sceneInfo);
			HashMap<String, Object> whereMap = new HashMap<String, Object>();
			HashMap<String, Object> sortMap = new HashMap<String, Object>();
			whereMap.put("toUser", toUser);
			sortMap.put("sort", 1);
			whereMap.put("msid", Long.parseLong(msid));
			List<DBObject> scenelist = baseDao.getList(PubConstants.SUC_SCENE,
					whereMap, sortMap);
			Struts2Utils.getRequest().setAttribute("scenelist", scenelist);
			Struts2Utils.getRequest().setAttribute(
					"entity",
					baseDao.getMessage(PubConstants.SUC_MOBLILESCENE,
							Long.parseLong(msid)));
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "add";

	}

	/**
	 * 保存精灵
	 * 
	 * @return
	 */
	public String saveSpirit() {
		try {
			String id = Struts2Utils.getParameter("id");
			String scid = Struts2Utils.getParameter("scid");
			Struts2Utils.getRequest().setAttribute("scid", scid);
			Struts2Utils.getRequest().setAttribute("tab",
					Struts2Utils.getParameter("tab"));
			String title = Struts2Utils.getParameter("title");
			String summary = Struts2Utils.getParameter("summary");
			String picurl = Struts2Utils.getParameter("picurl");
			String sort = Struts2Utils.getParameter("sort");
			SpiritInfo spiritInfo = new SpiritInfo();
			if (!StringUtils.isNotBlank(id)) {
				spiritInfo.set_id(mongoSequence
						.currval(PubConstants.SUC_SPIRIT));
			}
			spiritInfo.set_id(Long.parseLong(id));
			spiritInfo.setPicurl(picurl);
			spiritInfo.setScid(Long.parseLong(id));
			spiritInfo.setSort(Integer.parseInt(sort));
			spiritInfo.setSummary(summary);
			spiritInfo.setTitle(title);
			baseDao.insert(PubConstants.SUC_SPIRIT, spiritInfo);
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}

	/**
	 * 根据ID修改层
	 * 
	 * @return
	 */
	public void updateSceneById() {
		String id = Struts2Utils.getParameter("id");
		try {
			if (StringUtils.isNotEmpty(id)) {
				DBObject db = baseDao.getMessage(PubConstants.SUC_SCENE,
						Long.parseLong(id));
				String json = JSONObject.fromObject(db).toString();
				Struts2Utils.renderJson(json, new String[0]);

			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	/**
	 * 根据ID修改精灵
	 * 
	 * 
	 */
	public void updateSpirit() {
		String id = Struts2Utils.getParameter("id");
		DBObject db = baseDao.getMessage(PubConstants.SUC_SPIRIT,
				Long.parseLong(id));
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}

	/**
	 * ajax更新或添加精灵
	 */
	public void updSpirit() {
		try {
			String id = Struts2Utils.getParameter("id");
			String toUser = Struts2Utils.getParameter("toUser");
			String title = Struts2Utils.getParameter("title");
			String picurl = Struts2Utils.getParameter("picurl");
			String url = Struts2Utils.getParameter("url");
			String summary = Struts2Utils.getParameter("summary");
			String sort = Struts2Utils.getParameter("sort");
			String scid = Struts2Utils.getParameter("scid");
			String type=Struts2Utils.getParameter("type");
			SpiritInfo obj = null;
			if (StringUtils.isNotEmpty(id)) {
				DBObject db = baseDao.getMessage(PubConstants.SUC_SPIRIT,
						Long.parseLong(id));
				if (db == null) {
					obj = new SpiritInfo();

					obj.set_id(mongoSequence.currval(PubConstants.SUC_SPIRIT));
				} else {
					obj = (SpiritInfo) UniObject.DBObjectToObject(db,
							SpiritInfo.class);
				}
			} else {
				obj = new SpiritInfo();
				obj.set_id(mongoSequence.currval(PubConstants.SUC_SPIRIT));
			}
			obj.setPicurl(picurl);
			obj.setScid(Long.parseLong(scid));
			obj.setSort(Integer.parseInt(sort));
			obj.setSummary(summary);
			obj.setUrl(url);
			obj.setTitle(title);
			obj.setToUser(toUser);
			obj.setType(type);
			baseDao.insert(PubConstants.SUC_SPIRIT, obj);

			StyleInfo style = new StyleInfo();
			style.set_id(toUser + "-scene-" + scid + "-" + obj.get_id());
			style.setHeight("50");
			style.setWidth("50");
			style.setMarginleft("0");
			style.setMargintop("0");
			style.setRadius("0");
			baseDao.insert(PubConstants.STYLE_INFO, style);

			HashMap<String, Object> whereMap = new HashMap<String, Object>();
			HashMap<String, Object> sortMap = new HashMap<String, Object>();
			Map<String, Object> sub_map = new HashMap<String, Object>();
			whereMap.put("toUser", toUser);
			whereMap.put("scid", Long.parseLong(scid));
			sortMap.put("sort", 1);
			List<DBObject> list = baseDao.getList(PubConstants.SUC_SPIRIT,
					whereMap, sortMap);
			if (list.size() > 0) {
				sub_map.put("list", list);
				sub_map.put("state", 0);
			} else {
				sub_map.put("state", 1);
			}
			String json = JSONArray.fromObject(sub_map).toString();
			Struts2Utils.renderJson(json.substring(1, json.length() - 1),
					new String[0]);
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		try {
			if (_id == null) {
				_id = mongoSequence.currval(PubConstants.SUC_MOBLILESCENE);
			}
			entity.set_id(_id);
			entity.setToUser(SpringSecurityUtils.getCurrentUser().getToUser());
			entity.setCreatedate(new Date());
			baseDao.insert(PubConstants.SUC_MOBLILESCENE, entity);
			Struts2Utils.getRequest().setAttribute("msid", _id);
			Struts2Utils.getRequest().setAttribute("entity", entity);
			Struts2Utils.getRequest().setAttribute("tab",
					Struts2Utils.getParameter("tab"));

			HashMap<String, Object> whereMap = new HashMap<String, Object>();
			HashMap<String, Object> sortMap = new HashMap<String, Object>();
			String toUser = SpringSecurityUtils.getCurrentUser().getToUser();
			whereMap.put("toUser", toUser);
			whereMap.put("msid", _id);
			sortMap.put("sort", 1);
			Struts2Utils.getRequest().setAttribute("toUser", toUser);
			Struts2Utils.getRequest().setAttribute("msid", _id);
			List<DBObject> scenelist = baseDao.getList(PubConstants.SUC_SCENE,
					whereMap, sortMap);
			Struts2Utils.getRequest().setAttribute("scenelist", scenelist);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "add";
	}

	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		try {
			if (_id != null) {
				//加载场景
				DBObject  db=baseDao.getMessage(PubConstants.SUC_MOBLILESCENE,_id);
				 
				//加载图层
				HashMap<String, Object> whereMap = new HashMap<String, Object>();
				HashMap<String, Object> sortMap = new HashMap<String, Object>();
				whereMap.put("toUser",db.get("toUser").toString());
				 
				whereMap.put("msid",_id); 
				sortMap.put("sort", 1);
				List<DBObject> scenelist = baseDao.getList(PubConstants.SUC_SCENE,
						whereMap, sortMap);
				for (DBObject dbObject : scenelist) {
					 SceneInfo scene = (SceneInfo) UniObject.DBObjectToObject(dbObject,
							 SceneInfo.class);
					 //加载精灵
					 HashMap<String, Object> whereSpiritMap = new HashMap<String, Object>();
					 HashMap<String, Object> sortSpiritMap = new HashMap<String, Object>();
					 whereSpiritMap.put("scid",Long.parseLong(scene.get("_id").toString()));
					 sortSpiritMap.put("sort", 1);
					 List<DBObject>spritlist=baseDao.getList(PubConstants.SUC_SPIRIT, whereSpiritMap, sortSpiritMap);
					 for (DBObject dbObject2 : spritlist) {
						 SpiritInfo spirit = (SpiritInfo) UniObject.DBObjectToObject(dbObject2,
								 SpiritInfo.class);
						 //删除样式
						 baseDao.delete(PubConstants.STYLE_INFO, db.get("toUser").toString()+"-scene-" 
						 + scene.get_id().toString()+"-"+spirit.get_id().toString());
						 //删除动画
						 baseDao.delete(PubConstants.ANIMATION_INFO, db.get("toUser").toString()+"-scene-" 
						 + scene.get_id().toString()+"-"+spirit.get_id().toString());
						  
					}
					//删除精灵
					 baseDao.delete(PubConstants.SUC_SPIRIT, whereSpiritMap);
				}
				//删除图层
				 baseDao.delete(PubConstants.SUC_SCENE, whereMap);
				
			}
            //删除场景
			baseDao.delete(PubConstants.SUC_MOBLILESCENE, _id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return RELOAD;
	}

	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		if (_id != null) {
			DBObject db = baseDao
					.getMessage(PubConstants.SUC_MOBLILESCENE, _id);
			entity = (MobileScene) UniObject.DBObjectToObject(db,
					MobileScene.class);
		} else {
			entity = new MobileScene();
		}

	}

	@Override
	public MobileScene getModel() {
		// TODO Auto-generated method stub
		return entity;
	}

	public String web() {
		String toUser = Struts2Utils.getParameter("toUser");
		Struts2Utils.getRequest().setAttribute("toUser", toUser);
		String msid = Struts2Utils.getParameter("msid");
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		List<String> animalist = new ArrayList<String>();

		try {
			if (StringUtils.isNotEmpty(msid)) {
				DBObject db = baseDao.getMessage(PubConstants.SUC_MOBLILESCENE,
						Long.parseLong(msid));
				Struts2Utils.getRequest().setAttribute("entity", db);

				DBObject mp3 = baseDao.getMessage(PubConstants.STYLE_INFO,
						toUser + "-mp3-" + db.get("_id").toString());
				Struts2Utils.getRequest().setAttribute("mp3", mp3);

				whereMap.put("msid", Long.parseLong(msid));
				whereMap.put("toUser", toUser);
				sortMap.put("sort", 1);
				List<DBObject> scenelist = baseDao.getList(
						PubConstants.SUC_SCENE, whereMap, sortMap);
				Struts2Utils.getRequest().setAttribute("scenelist", scenelist);
				whereMap.clear();
				for (DBObject dbObject : scenelist) {
					whereMap.put("toUser", toUser);
					whereMap.put("scid",
							Long.parseLong(dbObject.get("_id").toString()));
					List<DBObject> spritlist = baseDao.getList(
							PubConstants.SUC_SPIRIT, whereMap, sortMap);
					System.out.println("///////////////***************");
					 System.out.println(spritlist);
					for (DBObject dbObject2 : spritlist) {
						DBObject spiritStyle = baseDao.getMessage(
								PubConstants.STYLE_INFO, toUser + "-scene-"
										+ dbObject.get("_id").toString() + "-"
										+ dbObject2.get("_id").toString());
						dbObject2.put("style", spiritStyle);

						DBObject spiritAnima = baseDao.getMessage(
								PubConstants.ANIMATION_INFO, toUser + "-scene-"
										+ dbObject.get("_id").toString() + "-"
										+ dbObject2.get("_id").toString());
						dbObject2.put("anima", spiritAnima);
						System.out.println(spiritAnima);
						System.out.println("+++++++++++++++++++++++");
						if (spiritAnima != null) {
							animalist.add(spiritAnima.get("_id").toString());
						}

						System.out.println(toUser + "-scene-"
								+ dbObject.get("_id").toString() + "-"
								+ dbObject2.get("_id").toString());
						System.out.println(spiritStyle);
					}
					dbObject.put("spritlist", spritlist);
				}
			}

			Struts2Utils.getRequest().setAttribute("animalist", animalist);
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "web";

	}

	public void updateMp3() {
		String id = Struts2Utils.getParameter("id");
		String toUser = Struts2Utils.getParameter("toUser");
		String ml = Struts2Utils.getParameter("ml");
		String mt = Struts2Utils.getParameter("mt");
		String h = Struts2Utils.getParameter("h");
		String w = Struts2Utils.getParameter("w");
		DBObject db = baseDao.getMessage(PubConstants.STYLE_INFO, toUser
				+ "-mp3-" + id);
		StyleInfo obj;
		if (db == null) {
			obj = new StyleInfo();
			obj.set_id(toUser + "-mp3-" + id);

		} else {

		}
		obj = (StyleInfo) UniObject.DBObjectToObject(db, StyleInfo.class);
		obj.setMarginleft(ml);
		obj.setMargintop(mt);
		obj.setWidth(w);
		obj.setHeight(h);
		baseDao.insert(PubConstants.STYLE_INFO, obj);
		String json = JSONObject.fromObject(obj).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}

	public void updStyle() {

		String id = Struts2Utils.getParameter("id");
		DBObject db = baseDao.getMessage(PubConstants.STYLE_INFO, id);
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}

	public void updateStyle() {
		String id = Struts2Utils.getParameter("id");
		String toUser = Struts2Utils.getParameter("toUser");
		String type = Struts2Utils.getParameter("type");
		String ml = Struts2Utils.getParameter("ml");
		String mt = Struts2Utils.getParameter("mt");
		String h = Struts2Utils.getParameter("h");
		String w = Struts2Utils.getParameter("w");
		String radius = Struts2Utils.getParameter("radius");
		String color = Struts2Utils.getParameter("color");
		 
		DBObject db = baseDao.getMessage(PubConstants.STYLE_INFO, toUser + "-"
				+ type + "-" + id);
		StyleInfo obj;
		if (db == null) {
			obj = new StyleInfo();
			obj.set_id(toUser + "-" + type + "-" + id);

		} else {
			obj = (StyleInfo) UniObject.DBObjectToObject(db, StyleInfo.class);
		}

		obj.setMarginleft(ml);
		obj.setMargintop(mt);
		obj.setWidth(w);
		obj.setHeight(h);
		obj.setRadius(radius);
		obj.setColor(color);
		baseDao.insert(PubConstants.STYLE_INFO, obj);
		System.out.println("------------------------");
		System.out.println(obj.get_id());
		String json = JSONObject.fromObject(obj).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}

	public void updAnima() {
		String id = Struts2Utils.getParameter("id");
		DBObject db = baseDao.getMessage(PubConstants.ANIMATION_INFO, id);
		System.out.println(db);
		System.out.println("*********************");
		String json = JSONObject.fromObject(db).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}

	public void updateAnima() {
		String id = Struts2Utils.getParameter("id");
		String toUser = Struts2Utils.getParameter("toUser");
		String type = Struts2Utils.getParameter("type");
		String value = Struts2Utils.getParameter("value");
		String time = Struts2Utils.getParameter("time");
		String iterate = Struts2Utils.getParameter("iterate");
		String duration = Struts2Utils.getParameter("duration");
		String keep = Struts2Utils.getParameter("keep");

		DBObject db = baseDao.getMessage(PubConstants.ANIMATION_INFO, toUser
				+ "-" + type + "-" + id);
		AnimationInfo obj;
		if (db == null) {
			obj = new AnimationInfo();
			obj.set_id(toUser + "-" + type + "-" + id);

		} else {
			obj = (AnimationInfo) UniObject.DBObjectToObject(db,
					AnimationInfo.class);
		}
		if (StringUtils.isNotEmpty(time)) {
			obj.setDuration(time);
		} else {
			obj.setDuration("1");
		}
		if (StringUtils.isNotEmpty(iterate)) {
			if (Integer.parseInt(iterate) > 0) {
				obj.setIterate(iterate);
			} else {
				obj.setIterate("infinite");
			}

		} else {
			obj.setIterate("infinite");
		}

		obj.setValue(value);
		obj.setDuration(duration);
		obj.setKeep(keep);
		baseDao.insert(PubConstants.ANIMATION_INFO, obj);
		String json = JSONObject.fromObject(obj).toString();
		Struts2Utils.renderJson(json, new String[0]);
	}
	/**
	 * ajax删除图层
	 */
	public void  delScene(){
		String id=Struts2Utils.getParameter("id");
		String msid=Struts2Utils.getParameter("msid");
		toUser=SpringSecurityUtils.getCurrentUser().getToUser();
		if(StringUtils.isNotEmpty(id)){
			//加载图层
			DBObject db=baseDao.getMessage(PubConstants.SUC_SCENE, Long.parseLong(id));
			 
			//加载精灵
			HashMap<String, Object> whereSpiritMap = new HashMap<String, Object>();
			HashMap<String, Object> sortSpiritMap = new HashMap<String, Object>();
			whereSpiritMap.put("scid",Long.parseLong(db.get("_id").toString()));
			sortSpiritMap.put("sort", 1); 
			List<DBObject>spritlist=baseDao.getList(PubConstants.SUC_SPIRIT, whereSpiritMap, sortSpiritMap);
			for (DBObject dbObject : spritlist) {
				 SpiritInfo spirit = (SpiritInfo) UniObject.DBObjectToObject(dbObject,
						 SpiritInfo.class);
				 //删除样式
				 baseDao.delete(PubConstants.STYLE_INFO, db.get("toUser").toString()+"-scene-" 
				 + id+"-"+spirit.get_id().toString()); 
				 //删除样式
				 baseDao.delete(PubConstants.ANIMATION_INFO, db.get("toUser").toString()+"-scene-" 
				 + id+"-"+spirit.get_id().toString());
				 //删除精灵
				 baseDao.delete(PubConstants.SUC_SPIRIT, Long.parseLong(spirit.get_id().toString()));
			}
			//删除图层
			baseDao.delete(PubConstants.SUC_SCENE, Long.parseLong(id));
		}
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		whereMap.put("msid", Long.parseLong(msid));
		whereMap.put("toUser", toUser);
		sortMap.put("sort", 1);
		List<DBObject>list=baseDao.getList(PubConstants.SUC_SCENE, whereMap, sortMap); 
		Map<String, Object> sub_map = new HashMap<String, Object>();
	 
		if (list.size() > 0) {
			sub_map.put("list", list);
			sub_map.put("state", 0);
		} else {
			sub_map.put("state", 1);
		}
		String json = JSONArray.fromObject(sub_map).toString();
		Struts2Utils.renderJson(json.substring(1, json.length() - 1),
				new String[0]);
		
	}

	/**
	 * 获取系统全部场景模板
	 */
	public String getAll() {
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		HashMap<String, Object> backMap = new HashMap<String, Object>();
		sortMap.put("sort", -1);

		String title = Struts2Utils.getParameter("title");
		if (StringUtils.isNotEmpty(title)) {
			Pattern pattern = Pattern.compile("^.*" + title + ".*$",
					Pattern.CASE_INSENSITIVE);
			whereMap.put("title", pattern);
			Struts2Utils.getRequest().setAttribute("title", title);
		}
		backMap.put("_id", 1);
		backMap.put("title", 1);
		backMap.put("sort", 1);
		backMap.put("picurl", 1);
		backMap.put("toUser", 1);

		if (StringUtils.isNotEmpty(Struts2Utils.getParameter("fypage"))) {
			fypage = Integer.parseInt(Struts2Utils.getParameter("fypage"));
		}

		List<DBObject> list = baseDao.getList(PubConstants.SUC_MOBLILESCENE,
				whereMap, sortMap, backMap);
		Struts2Utils.getRequest().setAttribute("mobilesceneList", list);
		return "all";

	}

	/**
	 * 克隆场景
	 * @return
	 */
	public String copyScene() {
		String msid = Struts2Utils.getParameter("msid");
		String toUser=SpringSecurityUtils.getCurrentUser().getToUser();
		DBObject db = baseDao.getMessage(PubConstants.SUC_MOBLILESCENE,
				Long.parseLong(msid));
	    MobileScene  newenity=new MobileScene();
	    MobileScene obj = (MobileScene) UniObject.DBObjectToObject(db,
				MobileScene.class); 
	    newenity.set_id(mongoSequence.currval(PubConstants.SUC_MOBLILESCENE));
	    newenity.setContext(obj.getContext());
	    newenity.setCreatedate(new Date());
	    newenity.setFoot(obj.getFoot());
	    newenity.setLogo(obj.getLogo());
	    newenity.setMp3(obj.getMp3());
	    newenity.setPicurl(obj.getPicurl());
	    newenity.setSummary(obj.getSummary());
	    newenity.setTitle(obj.getTitle()+"—副本");
	    newenity.setSort(obj.getSort());
	    newenity.setYdl(0);
	    newenity.setToUser(toUser); 
	    baseDao.insert(PubConstants.SUC_MOBLILESCENE, newenity);
		// TODO Auto-generated method stub
	 
		//加载层
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		whereMap.put("toUser",obj.getToUser());
		 
		whereMap.put("msid",obj.get_id()); 
		sortMap.put("sort", 1);
		List<DBObject> scenelist = baseDao.getList(PubConstants.SUC_SCENE,
				whereMap, sortMap);
		for (DBObject dbObject : scenelist) {
			 SceneInfo scene = (SceneInfo) UniObject.DBObjectToObject(dbObject,
					 SceneInfo.class);
			 SceneInfo newSceneInfo=new SceneInfo();
			 newSceneInfo.set_id(mongoSequence.currval(PubConstants.SUC_SCENE));
			 newSceneInfo.setToUser(toUser);
			 newSceneInfo.setMsid(Long.parseLong(newenity.get_id().toString()));
			 newSceneInfo.setBg(scene.getBg());
			 newSceneInfo.setPicurl(scene.getPicurl());
			 newSceneInfo.setSort(scene.getSort());
			 newSceneInfo.setTitle(scene.getTitle());
			 newSceneInfo.setUrl(scene.getUrl());
			 baseDao.insert(PubConstants.SUC_SCENE, newSceneInfo);
			 //加载精灵
			 HashMap<String, Object> whereSpiritMap = new HashMap<String, Object>();
			 HashMap<String, Object> sortSpiritMap = new HashMap<String, Object>();
			 whereSpiritMap.put("scid",Long.parseLong(scene.get("_id").toString()));
			 sortSpiritMap.put("sort", 1); 
			 List<DBObject>spritlist=baseDao.getList(PubConstants.SUC_SPIRIT, whereSpiritMap, sortSpiritMap);
			
			 for (DBObject dbObject2 : spritlist) {
				 SpiritInfo spirit = (SpiritInfo) UniObject.DBObjectToObject(dbObject2,
						 SpiritInfo.class);
				 SpiritInfo newspirit=new SpiritInfo();
				 newspirit.set_id(mongoSequence.currval(PubConstants.SUC_SPIRIT));
				 newspirit.setToUser(toUser);
				 newspirit.setScid(Long.parseLong(newSceneInfo.get_id().toString()));
				 newspirit.setSort(spirit.getSort());
				 newspirit.setSummary(spirit.getSummary());
				 newspirit.setTitle(spirit.getTitle());
				 newspirit.setPicurl(spirit.getPicurl());
				 newspirit.setUrl(spirit.getUrl()); 
				 baseDao.insert(PubConstants.SUC_SPIRIT, newspirit);
				 
				 //加载样式
				 DBObject styledb = baseDao.getMessage(PubConstants.STYLE_INFO, db.get("toUser").toString()+"-scene-" 
				 + scene.get_id().toString()+"-"+spirit.get_id().toString()); 
				 StyleInfo style=(StyleInfo) UniObject.DBObjectToObject(styledb, StyleInfo.class);
				 StyleInfo newstyle=new StyleInfo();
				 newstyle.set_id(toUser+"-scene-"+newSceneInfo.get_id().toString()+"-"+newspirit.get_id().toString()); 
				 newstyle.setBackgroundcolor(style.getBackgroundcolor());
				 newstyle.setAnimation(style.getAnimation());
				 newstyle.setColor(style.getColor());
				 newstyle.setHeight(style.getHeight());
				 newstyle.setLocation(style.getLocation());
				 newstyle.setMargin(style.getMargin());
				 newstyle.setMarginleft(style.getMarginleft());
				 newstyle.setMargintop(style.getMargintop());
				 newstyle.setMb(style.getMb());
				 newstyle.setPadding(style.getPadding());
				 newstyle.setRadius(style.getRadius());
				 newstyle.setSort(style.getSort());
				 newstyle.setWidth(style.getWidth());
				 baseDao.insert(PubConstants.STYLE_INFO, newstyle);
				 
				 //加载动画
				 DBObject animadb = baseDao.getMessage(PubConstants.ANIMATION_INFO, db.get("toUser").toString()+"-scene-" 
						 + scene.get_id().toString()+"-"+spirit.get_id().toString());
				 AnimationInfo  anima=(AnimationInfo) UniObject.DBObjectToObject(animadb, AnimationInfo.class);
				 AnimationInfo  newanima=new AnimationInfo();
				 newanima.set_id(toUser+"-scene-"+newSceneInfo.get_id().toString()+"-"+newspirit.get_id().toString());
				 newanima.setDuration(anima.getDuration());
				 newanima.setIterate(anima.getIterate());
				 newanima.setKeep(anima.getKeep());
				 newanima.setToUser(toUser);
				 newanima.setType(anima.getType());
				 newanima.setValue(anima.getValue());
				 baseDao.insert(PubConstants.ANIMATION_INFO, newanima);
				  
				
			}
			 
		 	
		} 
		whereMap.clear();
		sortMap.clear();
		whereMap.put("toUser", toUser);
		 
		whereMap.put("msid",newenity.get_id()); 
		sortMap.put("sort", 1);
		List<DBObject> newscenelist = baseDao.getList(PubConstants.SUC_SCENE,
				whereMap, sortMap);
		Struts2Utils.getRequest().setAttribute("toUser", toUser);
		Struts2Utils.getRequest().setAttribute("entity", newenity);
		Struts2Utils.getRequest().setAttribute("scenelist", newscenelist);
		Struts2Utils.getRequest().setAttribute("msid", newenity.get_id().toString());
		Struts2Utils.getRequest().setAttribute("styleid", newenity.get_id().toString());
		Struts2Utils.getRequest().setAttribute("tab",0);


		return "add";

	}

}
