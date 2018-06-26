package com.lsp.pub.util; 
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject; 
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map; 
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
/**
 * 工具
 * @author lsp 
 *   
 */
public class UniObject {
	/*
	 * @SuppressWarnings({ "rawtypes", "unchecked" }) public static List<Param>
	 * jsonToMap(String json){ Map<String, Class> classMap = new HashMap<String,
	 * Class>(); classMap.put("params", Param.class); JSONArray
	 * ss=JSONArray.fromObject(json); List cc=JSONArray.toList(ss, Param.class);
	 * return cc; }
	 */
	public static Object mapToObject(@SuppressWarnings("rawtypes") Class cls,
			Map<String, Object> map) throws Exception {
		Object o = cls.newInstance();
		Field[] fileds = o.getClass().getDeclaredFields();
		for (Field field : fileds) {
			Object value = getValue(field, map);
			if (value != null) {
				String str = field.getName();
				Method method = cls.getMethod(
						"set"
								+ str.replaceFirst(str.substring(0, 1), str
										.substring(0, 1).toUpperCase()),
						new Class[] { field.getType() });
				method.invoke(o, value);
			}

		}
		return o;

	}

	public static Map<String, Object> DBObjectToMap(DBObject db) {
		Map<String, Object> map = new HashMap<String, Object>();
		for (String key : db.keySet()) {
			if (db.get(key) instanceof Date) {
				map.put(key, DateFormat.getDate(((Date) db.get(key))));
			} else {
				map.put(key, db.get(key));
			}
		}
		return map;
	}

	public static Object DBObjectToObject(DBObject db,@SuppressWarnings("rawtypes") Class cls) {
		
		Object o = null;
		try {
			
			JSONObject  json = JSONObject.fromObject(db);
			o=JSONObject.toBean(json,cls);  
			
			
		} catch (Exception e) {
			
		} 
		if(o==null){
			 o= DBObjectToObject1(db,cls);
		}
		return o;	
	}
	public static Object DBObjectToObject1(DBObject db,@SuppressWarnings("rawtypes") Class cls) {
		Object o = null;
		try {
		
			 o = cls.newInstance();
		Field[] fileds=o.getClass().getDeclaredFields();
		for (Field field : fileds) {
			Object value=db.get(field.getName());
			if(value!=null){
				String str=field.getName();
				Method method = cls.getMethod("set"+str.replaceFirst(str.substring(0, 1), str.substring(0, 1).toUpperCase()), new Class[] {field.getType()});
				method.invoke(o,value );
			}
			
	
			
			}
		
		} catch (Exception e) {
			
		}
		return o;
	}

	public static HashMap<String, String> DBObjectToMapString(DBObject db) {
		HashMap<String, String> map = new HashMap<String, String>();
		for (String key : db.keySet()) {
			if (db.get(key) instanceof Date) {
				map.put(key, DateFormat.getDate(((Date) db.get(key)))
						.toString());
			} else {
				map.put(key, db.get(key).toString());
			}
		}
		return map;
	}

	private static Object getValue(Field field, Map<String, Object> map)
			throws ParseException {
		for (String key : map.keySet()) {
			if (key.equals(field.getName())) {
				if (map.get(key) != null
						&& StringUtils.isNotEmpty(map.get(key).toString())) {
					if (field.getType().equals(Integer.class)) {
						return (Integer) (map.get(key));
					} else if (field.getType().equals(Double.class)) {
						return (Double) (map.get(key));
					} else if (field.getType().equals(Long.class)) {
						return (Long) (map.get(key));
					} else if (field.getType().equals(Date.class)) {
						return DateFormat.StringToDate(map.get(key).toString());
					} else {
						return map.get(key);
					}

				}
			}
		}
		return null;
	}
	  /** 
	   * 把实体bean对象转换成DBObject 
	   * @param bean 
	   * @return 
	   * @throws IllegalArgumentException 
	   * @throws IllegalAccessException 
	   */  
	  public static <T> DBObject bean2DBObject(T bean) throws IllegalArgumentException,  
	      IllegalAccessException {  
	    if (bean == null) {  
	      return null;  
	    }  
	    DBObject dbObject = new BasicDBObject();  
	    // 获取对象对应类中的所有属性域  
	    Field[] fields = bean.getClass().getDeclaredFields();  
	    for (Field field : fields) {  
	      // 获取属性名  
	      String varName = field.getName();  
	      // 修改访问控制权限  
	      boolean accessFlag = field.isAccessible();  
	      if (!accessFlag) {  
	        field.setAccessible(true);  
	      }  
	      Object param = field.get(bean);  
	      if (param == null) {  
	        continue;  
	      } else if (param instanceof Integer) {//判断变量的类型  
	        int value = ((Integer) param).intValue();  
	        dbObject.put(varName, value);  
	      } else if (param instanceof String) {  
	        String value = (String) param;  
	        dbObject.put(varName, value);  
	      } else if (param instanceof Double) {  
	        double value = ((Double) param).doubleValue();  
	        dbObject.put(varName, value);  
	      } else if (param instanceof Float) {  
	        float value = ((Float) param).floatValue();  
	        dbObject.put(varName, value);  
	      } else if (param instanceof Long) {  
	        long value = ((Long) param).longValue();  
	        dbObject.put(varName, value);  
	      } else if (param instanceof Boolean) {  
	        boolean value = ((Boolean) param).booleanValue();  
	        dbObject.put(varName, value);  
	      } else if (param instanceof Date) {  
	        Date value = (Date) param;  
	        dbObject.put(varName, value);  
	      }  
	      // 恢复访问控制权限  
	      field.setAccessible(accessFlag);  
	    }  
	    return dbObject;  
	  }  
 
}
