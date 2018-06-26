package com.lsp.dwr;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.geom.AffineTransform;
import java.awt.image.AffineTransformOp;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;

import net.sf.json.JSONObject;

 
import com.lsp.pub.db.MongoDbUtil;
import com.lsp.pub.entity.BaseSelect;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.SpringSecurityUtils;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import com.mongodb.QueryOperators;
 
/**
 * 资源管理
 * @author lsp 
 *   
 */
public class DwrAjaxServer {

	/**
	 * 微活动二级下拉
	 * 
	 * @param brand
	 * @return
	 */
	public Object[] getWhdService(String table) {
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		sortMap.put("sort", -1);
		whereMap.put("toUser", SpringSecurityUtils.getCurrentUser().getToUser());
		MongoDbUtil baseDao = new MongoDbUtil();
		List<BaseSelect> re = new ArrayList<BaseSelect>();
		List<DBObject> list = baseDao.queryAll("whd_" + table, whereMap, 0, 100,
				sortMap).toArray();
		for (int i = 0; i < list.size(); i++) {
			BaseSelect aa = new BaseSelect();
			aa.setKey(list.get(i).get("_id").toString());
			aa.setValue(list.get(i).get("title").toString());
			re.add(aa);
		}
		baseDao.close();
		return getJsonsFormObjs(re);
	}
	/**
	 * 商家微活动二级下拉
	 * 
	 * @param brand
	 * @return
	 */
	public Object[] getShopWhdService(String table) {
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		
		whereMap.put("comid", SpringSecurityUtils.getCurrentUser().getComid());
		
		MongoDbUtil baseDao = new MongoDbUtil();
		List<BaseSelect> re = new ArrayList<BaseSelect>();
		if(table.equals("wxnewscommondetail")){
			List<DBObject> list = baseDao.queryAll("wxNewsInfo", whereMap,null).toArray();
			for (int i = 0; i < list.size(); i++) {
				BaseSelect aa = new BaseSelect();
				aa.setKey(list.get(i).get("_id").toString());
				aa.setValue(list.get(i).get("newtitle").toString());
				re.add(aa);
			}
		}else if(table.equals("huodongdetail")){
			
			 
		}else{
			List<DBObject> list = baseDao.queryAll("whd_" + table, whereMap,null).toArray();
			for (int i = 0; i < list.size(); i++) {
				BaseSelect aa = new BaseSelect();
				aa.setKey(list.get(i).get("_id").toString());
				aa.setValue(list.get(i).get("title").toString());
				re.add(aa);
			}
		}
		baseDao.close();
		return getJsonsFormObjs(re);
	}

	public Object[] getShoptypeService(String type) {
		MongoDbUtil baseDao = new MongoDbUtil();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		whereMap.put("toUser", SpringSecurityUtils.getCurrentUser().getToUser());
		whereMap.put("type", type);
		List<BaseSelect> re = new ArrayList<BaseSelect>();
		
		DBObject db=baseDao.findOne(PubConstants.SHOP_SHOPTYPE, whereMap);
		if(db!=null){
			HashMap<String, Object> whereMap1 =new HashMap<String, Object>();
			whereMap1.put("parentid", (Long)db.get("_id"));
			List<DBObject> list=baseDao.queryAll(PubConstants.SHOP_SHOPTYPE, whereMap1).toArray();
			for(int i=0;i<list.size();i++){
				BaseSelect aa = new BaseSelect();
				aa.setKey(list.get(i).get("type").toString());
				aa.setValue(list.get(i).get("name").toString());
				re.add(aa);
			}
		}
		
		baseDao.close();
		return getJsonsFormObjs(re);
	}
	public Object[] getAreatypeService(String type) {
		MongoDbUtil baseDao = new MongoDbUtil();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		whereMap.put("toUser", SpringSecurityUtils.getCurrentUser().getToUser());

		List<BaseSelect> re = new ArrayList<BaseSelect>();
		if(StringUtils.isNotBlank(type)){
		
			whereMap.put("parentid", Long.parseLong(type));
			List<DBObject> list=baseDao.queryAll(PubConstants.SHOP_AREATYPE, whereMap).toArray();
			for(int i=0;i<list.size();i++){
				BaseSelect aa = new BaseSelect();
				aa.setKey(list.get(i).get("_id").toString());
				aa.setValue(list.get(i).get("name").toString());
				re.add(aa);
			
		}
		}
		baseDao.close();
		return getJsonsFormObjs(re);
	}
	public Object[] getCompanyService(String type) {
		MongoDbUtil baseDao = new MongoDbUtil();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		whereMap.put("toUser", SpringSecurityUtils.getCurrentUser().getToUser());
		whereMap.put("type", type);
		List<BaseSelect> re = new ArrayList<BaseSelect>();
		
		List<DBObject> bmtList =baseDao.queryAll(PubConstants.COMPANY_INFO, whereMap).toArray();
	
			for(int i=0;i<bmtList.size();i++){
				BaseSelect aa = new BaseSelect();
				aa.setKey(bmtList.get(i).get("_id").toString());
				aa.setValue(bmtList.get(i).get("name").toString());
				re.add(aa);
			}
		
		
		baseDao.close();
		return getJsonsFormObjs(re);
	}

	/**
	 * 微活动二级下拉
	 * 
	 * @param brand
	 * @return
	 */
	public Object[] getCreatmenuService(String menu) {
		HashMap<String, Object> whereMap = new HashMap<String, Object>();

		whereMap.put("toUser", SpringSecurityUtils.getCurrentUser().getToUser());

		MongoDbUtil baseDao = new MongoDbUtil();
		List<BaseSelect> re = new ArrayList<BaseSelect>();
		if (menu.equals("creathk")) {
			BaseSelect aa = new BaseSelect();
			aa.setKey("1");
			aa.setValue("贺卡");
			re.add(aa);
			return getJsonsFormObjs(re);
		} else if (menu.equals("creatnews")) {
			whereMap.put("type", "wxnewscommon");
		} else if (menu.equals("creatbmt")) {
			whereMap.put("type", "wxbmt");
		}
	 
		baseDao.close();
		return getJsonsFormObjs(re);
	}

	/**
	 * 微活动二级下拉
	 * 
	 * @param brand
	 * @return
	 */
	public String checkService(String table, String fieldName,
			String fieldValue, Long ruleValue) {
		HashMap<String, Object> whereMap = new HashMap<String, Object>();

		whereMap.put("toUser", SpringSecurityUtils.getCurrentUser().getToUser());
		whereMap.put(fieldName, fieldValue);
		whereMap.put("_id", new BasicDBObject("$ne", ruleValue));
		MongoDbUtil baseDao = new MongoDbUtil();

		Long count = baseDao.getCount(table, whereMap);
		if (count > 0) {
			return "yes";
		}
		baseDao.close();
		return "no";
	}
	/**
	 * 微活动二级下拉
	 * 
	 * @param brand
	 * @return
	 */
	public String checkQjService(String table, String fieldName,
			String fieldValue, Long ruleValue) {
		HashMap<String, Object> whereMap = new HashMap<String, Object>();

		whereMap.put(fieldName, fieldValue);
		whereMap.put("_id", new BasicDBObject("$ne", ruleValue));
		MongoDbUtil baseDao = new MongoDbUtil();

		Long count = baseDao.getCount(table, whereMap);
		if (count > 0) {
			return "yes";
		}
		baseDao.close();
		return "no";
	}
	/**
	 * 微活动二级下拉
	 * 
	 * @param brand
	 * @return
	 */
	public String checkQjService(String table, String fieldName,
			String fieldValue, String ruleValue) {
		HashMap<String, Object> whereMap = new HashMap<String, Object>();

		whereMap.put(fieldName, fieldValue);
		whereMap.put("_id", new BasicDBObject("$ne", ruleValue));
		MongoDbUtil baseDao = new MongoDbUtil();

		Long count = baseDao.getCount(table, whereMap);
		if (count > 0) {
			return "yes";
		}
		baseDao.close();
		return "no";
	}

	/**
	 * 由对象数据生成jso对象数组
	 * */
	public Object[] getJsonsFormObjs(Object[] objs) {
		List<JSONObject> list = new ArrayList<JSONObject>();
		for (Object object : objs) {
			list.add(JSONObject.fromObject(object));
		}
		return list.toArray();
	}

	/**
	 * 由对象数据生成jso对象数组
	 * */
	public Object[] getJsonsFormObjs(List<BaseSelect> objs) {
		List<JSONObject> list = new ArrayList<JSONObject>();
		for (Object object : objs) {
			list.add(JSONObject.fromObject(object));
		}
		return list.toArray();
	}

	/**
	 * @param uploadImage
	 *            圖片文件流
	 * @param uploadFile
	 *            需要用简单的文本文件，如：.txt文件，不然上传会出乱码
	 * @param color
	 * @return
	 */
	public BufferedImage uploadFiles(BufferedImage uploadImage,
			String uploadFile, String color) {
		uploadImage = scaleToSize(uploadImage);
		// uploadImage =grafitiTextOnImage(uploadImage, uploadFile, color);
		return uploadImage;
	}

	/**
	 * 文件上传时使用InputStream类进行接收，在DWR官方例中是使用String类接收简单内容
	 * 
	 * @param
	 * @return
	 */
	public String uploadFile(InputStream uploadFile, String filename)
			throws Exception {
		WebContext webContext = WebContextFactory.get();
		String realtivepath = "/upload/";
		String saveurl = webContext.getHttpServletRequest().getSession()
				.getServletContext().getRealPath("/upload");
		File file = new File(saveurl + "/" + filename);
		if (!file.exists()) {
			file.mkdirs();
		}
		int available = uploadFile.available();
		byte[] b = new byte[available];
		FileOutputStream foutput = new FileOutputStream(file);
		uploadFile.read(b);
		foutput.write(b);
		foutput.flush();
		foutput.close();
		uploadFile.close();
		return realtivepath + filename;
	}

	private BufferedImage scaleToSize(BufferedImage uploadImage) {
		AffineTransform atx = new AffineTransform();
		atx.scale(200d / uploadImage.getWidth(), 200d / uploadImage.getHeight());
		AffineTransformOp atfOp = new AffineTransformOp(atx,
				AffineTransformOp.TYPE_BILINEAR);
		uploadImage = atfOp.filter(uploadImage, null);
		return uploadImage;
	}

	private BufferedImage grafitiTextOnImage(BufferedImage uploadImage,
			String uploadFile, String color) {
		if (uploadFile.length() < 200) {
			uploadFile += uploadFile + " ";
		}
		Graphics2D g2d = uploadImage.createGraphics();
		for (int row = 0; row < 10; row++) {
			String output = "";
			if (uploadFile.length() > (row + 1) * 20) {
				output += uploadFile.substring(row * 20, (row + 1) * 20);
			} else {
				output = uploadFile.substring(row * 20);
			}
			g2d.setFont(new Font("SansSerif", Font.BOLD, 16));
			g2d.setColor(Color.blue);
			g2d.drawString(output, 5, (row + 1) * 20);
		}
		return uploadImage;
	}
	
	/**
	 * 品牌二级
	 * @param type
	 * @return
	 */
	public Object[] dictProService(int cj,String key) {
		MongoDbUtil baseDao = new MongoDbUtil();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		HashMap<String, Object> sortMap = new HashMap<String, Object>();
		whereMap.put("cj", cj);
		whereMap.put("parentkey", key);
		sortMap.put("sort", 1);
		
		List<DBObject> cxlist=baseDao.queryAll(PubConstants.SET_PRODICT, whereMap).toArray();

		return cxlist.toArray();
	}
	 
	/**
	 * 城市选择
	 * @param type
	 * @return
	 */
	public Object[] proDictService(String key,int cj) {
		MongoDbUtil baseDao = new MongoDbUtil();
		HashMap<String, Object> whereMap = new HashMap<String, Object>();
		HashMap<String, Object> sortMap = new HashMap<String, Object>();

		whereMap.put("parentkey", key);
		whereMap.put("cj", cj);
		sortMap.put("sort", 1);
		
		List<DBObject> cxlist=baseDao.queryAll(PubConstants.SET_PRODICT, whereMap,sortMap).toArray();
			
	
		return cxlist.toArray();
	}
}
