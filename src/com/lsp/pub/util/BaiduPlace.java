package com.lsp.pub.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Iterator;
 

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
/**
 * 工具
 * @author lsp 
 *   
 */
public class BaiduPlace {
	/**
	 * 根据位置获取附近的信息
	 * 
	 * @param keyword
	 *            关键字
	 * @param Latitude
	 *            纬度
	 * @param Longitude
	 *            经度
	 * @param radius
	 *            查找范围
	 * @return
	 */
	public static JSONArray getPlacelist(String keyword, Double Latitude,
			Double Longitude, int radius, int page) {
		String url = "http://api.map.baidu.com/place/v2/search?ak="
				+ SysConfig.getProperty("baidu_ak") + "&output=json&query="
				+ keyword + "&location=" + Latitude + "," + Longitude
				+ "&radius=" + radius + "&page_size=10&page_num=" + page
				+ "&scope=1";
		String strXml = NetworkUtil.getXmlStrFromUrl(url);
		JSONObject jsonobj = JSONObject.fromObject(strXml);
		int status = jsonobj.getInt("status");
		String message = jsonobj.getString("message");
		String total = jsonobj.getString("total");
		
		JSONArray arraylist = null;
		if (status == 0 && message.equals("ok")) {
			JSONArray array = jsonobj.getJSONArray("results");
			arraylist = new JSONArray();
			for (int i = 0; i < array.size(); i++) {
				JSONObject json = new JSONObject();
				Iterator<?> objkey = array.getJSONObject(i).keys();
				while (objkey.hasNext()) {
					String key = (String) objkey.next().toString();
					String value = array.getJSONObject(i).getString(key);
					if (key.equals("location")) {
						JSONObject temp = JSONObject.fromObject(value);
						double lat = temp.getDouble("lat");
						double lng = temp.getDouble("lng");
						json.put("lat", lat);
						json.put("lng", lng);
					} else {
						json.put(key, value);
					}
				}
				arraylist.add(json);
			}
		}
		return arraylist;
	}
	/**
	 * 根据位置获取附近的信息
	 * 
	 * @param keyword
	 *            关键字
	 * @param Latitude
	 *            纬度
	 * @param Longitude
	 *            经度
	 * @param radius
	 *            查找范围
	 * @return
	 */
	public static JSONArray getCitylist(String keyword,String region,int page) {
		String url = "http://api.map.baidu.com/place/v2/search?ak="
				+ SysConfig.getProperty("baidu_ak") + "&output=json&query="
				+ keyword + "&page_size=20&page_num=" + page
				+ "&scope=1&region="+region;
		String strXml = NetworkUtil.getXmlStrFromUrl(url); 
		JSONObject jsonobj = JSONObject.fromObject(strXml);
		int status = jsonobj.getInt("status");
		String message = jsonobj.getString("message");
		String total = jsonobj.getString("total");
		
		JSONArray arraylist = null;
		if (status == 0 && message.equals("ok")) {
			JSONArray array = jsonobj.getJSONArray("results");
			arraylist = new JSONArray();
			for (int i = 0; i < array.size(); i++) {
				JSONObject json = new JSONObject();
				Iterator<?> objkey = array.getJSONObject(i).keys();
				while (objkey.hasNext()) {
					String key = (String) objkey.next().toString();
					String value = array.getJSONObject(i).getString(key);
					if (key.equals("location")) {
						JSONObject temp = JSONObject.fromObject(value);
						double lat = temp.getDouble("lat");
						double lng = temp.getDouble("lng");
						json.put("lat", lat);
						json.put("lng", lng);
					} else {
						json.put(key, value);
					}
				}
				arraylist.add(json);
			}
		}
		return arraylist;
	}

	/**
	 * 根据uid获取位置详情
	 * 
	 * @param uid
	 * @return
	 */
	public static JSONObject getPlaceDetail(String uid) {
		String url = "http://api.map.baidu.com/place/v2/detail?uid=" + uid
				+ "&ak=" + SysConfig.getProperty("baidu_ak")
				+ "&output=json&scope=2";
		String strXml = NetworkUtil.getXmlStrFromUrl(url);

		JSONObject jsonobj = JSONObject.fromObject(strXml);
		int status = jsonobj.getInt("status");
		String message = jsonobj.getString("message");
		JSONObject newobject = new JSONObject();
		if (status == 0 && message.equals("ok")) {
			JSONObject object = jsonobj.getJSONObject("result");
			Iterator<?> objkey = object.keys();
			while (objkey.hasNext()) {
				String key = (String) objkey.next().toString();
				String value = object.getString(key);
				if (key.equals("location")) {
					JSONObject temp = JSONObject.fromObject(value);
					double lat = temp.getDouble("lat");
					double lng = temp.getDouble("lng");
					newobject.put("lat", lat);
					newobject.put("lng", lng);
				} else if (key.equals("detail_info")) {

				} else {
					newobject.put(key, value);
				}
			}
		}
		return newobject;
	}

	/**
	 * 根据ip返回当前城市       IP定位的结果精度较差，主要应用获取省份或者城市的位置信息
	 * 
	 * @return
	 */
	public static String getCity() {
		String url = "http://api.map.baidu.com/location/ip?ak="
				+ SysConfig.getProperty("baidu_ak") + "&coor=bd09ll";
		String strXml = NetworkUtil.getXmlStrFromUrl(url);
		JSONObject jsonobj = JSONObject.fromObject(strXml);
		String city = jsonobj.getJSONObject("content")
				.getJSONObject("address_detail").getString("city");
		return city;
	}
	/**
	 * 根据经纬度返回当前位置信息
	 * 
	 * @return 区-街道
	 */
	public static String getLocation(String lng,String lon) {
		String url = "http://api.map.baidu.com/geocoder/v2/?ak="
				+ SysConfig.getProperty("baidu_ak") + "&location=" + lng + "," + lon + "&output=json&pois=0";
		String strXml = NetworkUtil.getXmlStrFromUrl(url);
		JSONObject jsonobj = JSONObject.fromObject(strXml);
		String street = jsonobj.getJSONObject("result").getJSONObject("addressComponent").getString("street");
		String district = jsonobj.getJSONObject("result").getJSONObject("addressComponent").getString("district");
		return district + "-" + street;
	}
	/**
	 * @param urlAll
	 *            :请求接口
	 * @param httpArg
	 *            :参数
	 * @return 返回结果
	 */
	public static int txtLike( String t1,String t2) {
	    BufferedReader reader = null;
	    int ppd = 0;
	    StringBuffer sbf = new StringBuffer();
	    String httpUrl = "http://apis.baidu.com/showapi_open_bus/txt_like/txt_like";
	    t1=t1.replaceAll(" ", "");
	    t2=t2.replaceAll(" ", "");
	   
	    try {
	    	 httpUrl = httpUrl + "?" + "t1="+URLEncoder.encode(t1.trim(), "UTF-8")+"&t2="+URLEncoder.encode(t2.trim(), "UTF-8");
	 	    System.out.println(httpUrl);
	        URL url = new URL(httpUrl);
	        HttpURLConnection connection = (HttpURLConnection) url
	                .openConnection();
	        connection.setRequestMethod("GET");
	        connection.setRequestProperty("Content-Type", "text/xml; charset=UTF-8");
	        // 填入apikey到HTTP header
	        connection.setRequestProperty("apikey",  "a30ee87f172b51f55b46f20a7f2d9479");
	        connection.connect();
	        InputStream is = connection.getInputStream();
	        reader = new BufferedReader(new InputStreamReader(is, "UTF-8"));
	        String strRead = null;
	        while ((strRead = reader.readLine()) != null) {
	            sbf.append(strRead);
	            sbf.append("\r\n");
	        }
	        reader.close();
	        JSONObject jsonobj = JSONObject.fromObject(sbf.toString());
	       System.err.println(jsonobj);
	        if(jsonobj.getInt("showapi_res_code")==0){
	        	JSONObject json=jsonobj.getJSONObject("showapi_res_body");
	        	if(json.get("like")!=null){
	        		ppd=Integer.parseInt(BaseDecimal.round(BaseDecimal.multiplication(json.getString("like"),"100"),0));
	        	}
	        	
	        	
	        }else{
	        	
	        }
	
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return ppd;
	}
	/**
	 * 获取限行城市
	 * 
	 */
	public static String limitCity(String appkey) {
		BufferedReader reader = null;
	    String result = null;
	    StringBuffer sbf = new StringBuffer();
	    String httpUrl =  "http://apis.baidu.com/netpopo/vehiclelimit/city?apikey=" + appkey;

	    try {
	        URL url = new URL(httpUrl);
	        HttpURLConnection connection = (HttpURLConnection) url
	                .openConnection();
	        connection.setRequestMethod("GET");
	        // 填入apikey到HTTP header
	        connection.setRequestProperty("apikey",  appkey);
	        connection.connect();
	        InputStream is = connection.getInputStream();
	        reader = new BufferedReader(new InputStreamReader(is, "UTF-8"));
	        String strRead = null;
	        while ((strRead = reader.readLine()) != null) {
	            sbf.append(strRead);
	            sbf.append("\r\n");
	        }
	        reader.close();
	        result = sbf.toString();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return result;
	}
	/**
	 * 获取限行
	 * 
	 */
	public static String limitCar(String appkey,String city,String date) {
		BufferedReader reader = null;
	    String result = null;
	    StringBuffer sbf = new StringBuffer();
	    String httpUrl =  "http://apis.baidu.com/netpopo/vehiclelimit/query?city=" + city+"&date="+date;

	    try {
	        URL url = new URL(httpUrl);
	        HttpURLConnection connection = (HttpURLConnection) url
	                .openConnection();
	        connection.setRequestMethod("GET");
	        // 填入apikey到HTTP header
	        connection.setRequestProperty("apikey",  appkey);
	        connection.connect();
	        InputStream is = connection.getInputStream();
	        reader = new BufferedReader(new InputStreamReader(is, "UTF-8"));
	        String strRead = null;
	        while ((strRead = reader.readLine()) != null) {
	            sbf.append(strRead);
	            sbf.append("\r\n");
	        }
	        reader.close();
	        result = sbf.toString();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return result;
	}
	 
}
