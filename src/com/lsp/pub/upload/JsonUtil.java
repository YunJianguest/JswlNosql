package com.lsp.pub.upload;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List; 

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
  
import com.lsp.pub.util.EncodeUtils;
import com.lsp.pub.util.SysConfig;
import com.mongodb.DBObject;
 
/**
 * json工具
 * @author lsp 
 *   
 */
public class JsonUtil {
	public  static  JSONObject  JSONOBJ;
	public  static  JSONObject  JSONOBJECT;
	public  static  JSONArray   JSONARRAY;
	public  static JSONArray Add(Object[] key,Object[] value){
		JSONOBJECT=new JSONObject();
		JSONARRAY=new JSONArray();
		for (int i = 0; i < value.length; i++) {
			JSONOBJECT.put(key[i], value[i]);
		}
		
		JSONARRAY.add(JSONOBJECT); 
		return JSONARRAY;
	}
	public static  JSONObject  GetOjb(Object key,Object  value){
		JSONOBJ=new JSONObject();
		JSONOBJ.put(key, value);
		return JSONOBJ;
	}  
	@SuppressWarnings("unchecked")
	public static String  GetJson(List<Object> lsobj){
		HashMap<String,Object> map=new HashMap<String, Object>();
		
		JSONArray   jsonarray=new JSONArray();
		for (int i = 0; i <lsobj.size() ; i++) {
			map=(HashMap<String, Object>) lsobj.get(i);
			String  FileName=(String)map.get("FileName");
			String  ContentType=(String) map.get("ContentType");
			byte[] file=(byte[]) map.get("file");
			String file64=EncodeUtils.base64Encode(file);
			JSONObject  jsonobj=new JSONObject();
			jsonobj.put("FileName", FileName);
			jsonobj.put("ContentType", ContentType);
			jsonobj.put("file", file64);
			jsonarray.add(jsonobj);
			
			  
		}
		
		return jsonarray.toString();
		
	}
	public  static List<HashMap<String,Object>> GetList(String json){
		 
		JSONArray   jsonarray=JSONArray.fromObject(json);
		 
		List<HashMap<String,Object>>list=new ArrayList<HashMap<String,Object>>();
		
		
		for (int i = 0; i < jsonarray.size(); i++) { 
			JSONObject  jsonobj=new JSONObject();
			jsonobj=jsonarray.getJSONObject(i);
			HashMap<String,Object> map=new HashMap<String, Object>();
			map.put("FileName", jsonobj.get("FileName").toString());
			map.put("ContentType", jsonobj.get("ContentType").toString());
			map.put("file",EncodeUtils.base64Decode(jsonobj.get("file").toString()));
			 
			list.add(map); 
		}
		
		return list;
		
		
	}
	  public static byte[] readBytes(InputStream in) throws IOException {  
	        byte[] temp = new byte[in.available()];  
	        byte[] result = new byte[0];  
	        int size = 0;  
	        while ((size = in.read(temp)) != -1) {  
	            byte[] readBytes = new byte[size];  
	            System.arraycopy(temp, 0, readBytes, 0, size);  
	            result = mergeArray(result,readBytes);  
	        }  
	        return result;  
	    }
	public static byte[] mergeArray(byte[]... a) {  
	        // 合并完之后数组的总长度  
	        int index = 0;  
	        int sum = 0;  
	        for (int i = 0; i < a.length; i++) {  
	            sum = sum + a[i].length;  
	        }  
	        byte[] result = new byte[sum];  
	        for (int i = 0; i < a.length; i++) {  
	            int lengthOne = a[i].length;  
	            if(lengthOne==0){  
	                continue;  
	            }  
	            // 拷贝数组  
	            System.arraycopy(a[i], 0, result, index, lengthOne);  
	            index = index + lengthOne;  
	        }  
	        return result;  
	    } 
	public static String UploadFile(){
		String result;
		try {
			if(JsonUtil.JSONARRAY.size()>0){
				HttpURLConnectionUtils.GetHttpURLConnection(SysConfig.getProperty("imgurl"));
				result = HttpURLConnectionUtils.SendFiles(JsonUtil.JSONARRAY.toString(),HttpURLConnectionUtils.CONN);
				JsonUtil.JSONARRAY.clear();
				return result;
			}
		 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	      
	}
	/**
	 *格式化日期为"：yyyy-MM-dd" 
	 * @param lsdb
	 * @return
	 */
	public  static  JSONArray GetJsonArray(List<DBObject> lsdb,String date){
		JSONArray json=new JSONArray();
		for (int i = 0; i < lsdb.size(); i++) {
			
			JSONObject obj=JSONObject.fromObject(lsdb.get(i));
			JSONObject o=(JSONObject) obj.get(date);
			
			String date1=(Integer.parseInt(o.get("year").toString())+1900)+"-"+o.get("month").toString()+"-"+o.get("date").toString()+" "+o.getString("hours")+":"+o.getString("minutes"); 
			obj.remove(date);
			obj.put(date,date1);  
		  
			json.add(JSONObject.fromObject(obj));
			
		}
		 
		return json;
		
	}
	
	public  static  JSONArray GetJsonArray(List<DBObject> lsdb){
		JSONArray json=new JSONArray();
		for (int i = 0; i < lsdb.size(); i++) {
			
			JSONObject obj=JSONObject.fromObject(lsdb.get(i));
			  
			json.add(JSONObject.fromObject(obj));
			
		}
		return json;
		
	}
	/**
	 *格式化日期为"：yyyy-MM-dd HH:mm" 
	 * @param lsdb
	 * @return
	 */
	public  static  JSONArray GetJsonArrayFormatDate(List<DBObject> lsdb,Object[] date){
		JSONArray json;
		try {
			json = new JSONArray();
			for (int i = 0; i < lsdb.size(); i++) {
				
				JSONObject obj=JSONObject.fromObject(lsdb.get(i));
				for (int j = 0; j < date.length; j++) {
					JSONObject o=(JSONObject) obj.get(date[i]);
					String date1=(Integer.parseInt(o.get("year").toString())+1900)+"-"+o.get("month").toString()+"-"+o.get("date").toString()+" "+o.getString("hours")+":"+o.getString("minutes"); 
					obj.remove(obj);
					obj.put(obj,date1);
				}
				
			  
				json.add(JSONObject.fromObject(obj));
				
			}
			return json;
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
		
	}
	/**
	 *格式化日期为"：yyyy-MM-dd HH:mm" 
	 * @param lsdb
	 * @return
	 */
	public  static  JSONObject GetJsonObjFormatDate(DBObject db,Object[] date){
		
		 try {
			JSONObject  obj=JSONObject.fromObject(db);
			 for (int i = 0; i < date.length; i++) {
					JSONObject o=(JSONObject) obj.get(date[i]);
					String date1=(Integer.parseInt(o.get("year").toString())+1900)+"-"+o.get("month").toString()+"-"+o.get("date").toString()+" "+o.getString("hours")+":"+o.getString("minutes"); 
					obj.remove(obj);
					obj.put(obj,date1);
				}
			 return obj;
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
		
		return null;
		
		
	}
	/**
	 *JOSNOBJ 追加内容 
	 * @return
	 */
	public   static JSONObject  jsonObjAdd(JSONObject obj,DBObject obj1){
		
		try {
			JSONObject json;
			json = new JSONObject();
			json.putAll(obj);
			json.putAll(JSONObject.fromObject(obj1));
			return json;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
		
	}
	/**
	 *JOSNOBJ 追加内容 
	 * @return
	 */
	public   static JSONObject  jsonObjAdd(JSONObject obj,JSONObject obj1){
		
		try {
			JSONObject json;
			json = new JSONObject();
			json.putAll(obj);
			json.putAll(obj1);
			return json;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
		
	}

}
