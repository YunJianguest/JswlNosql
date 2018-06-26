package com.lsp.weixin.util;


import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
 
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.lsp.pub.db.MongoDbUtil;
import com.lsp.pub.entity.HttpClient;
import com.lsp.pub.entity.PubConstants;
import com.lsp.pub.util.DateFormat;
import com.lsp.weixin.entity.OilInfo;
import com.mongodb.DBObject;
/***
 * 资源管理
 * @author lsp
 *
 */

public class OtherUtil {
	private static String edj_url = "http://open.api.edaijia.cn/customer/coupon/binding";
	private static String axc_url = "http://www.xiiche.com/api/user/import";

	/**
	 * e代驾优惠劵接口
	 * 
	 * @param toUser
	 * @param appid
	 * @param secret
	 * @return
	 * @throws Exception
	 */
	public static String edj_yhj(String tel, String num) {

		StringBuffer url = new StringBuffer("appkey=61000098");

		url.append("&bonusNumber=").append(num);
		url.append("&from=").append("01050044");
		url.append("&password=").append("");
		url.append("&phone=").append(tel);
		url.append("&timestamp=").append(DateFormat.getDatenoss(new Date()));
		url.append("&ver=3.2");

		String sig = md5(url.toString().replaceAll("=", "").replaceAll("&", "")
				+ "3bdbb170-dba2-4eb4-ad4a-601b71564ade");
		url.append("&sig=").append(sig);

		String ret1 = HttpClient.http(edj_url, url.toString());
		return ret1;
	}
	/**
	 * e代驾获取周边空闲司机
	 * 
	 * @param toUser
	 * @param appid
	 * @param secret
	 * @return
	 * @throws Exception
	 */
	public static String edj_zbsj(String tel,String lon,String lat) {

		StringBuffer url = new StringBuffer("appkey=61000098");
		url.append("&from=").append("");
		url.append("&gpsType=baidu");
		url.append("&latitude=").append(lat);
		url.append("&longitude=").append(lon);
		url.append("&timestamp=").append(DateFormat.getDatenoss(new Date()));
		url.append("&udid=").append(tel);
		url.append("&ver=3.2").append("");
		
		String sig = md5(url.toString().replaceAll("=", "").replaceAll("&", "")
				+ "3bdbb170-dba2-4eb4-ad4a-601b71564ade");
		url.append("&sig=").append(sig);

		String ret1 = HttpClient.http("http://open.api.edaijia.cn/driver/idle/list", url.toString());
		return ret1;
	}
	/**
	 * e代驾获取周边空闲司机
	 * 
	 * @param toUser
	 * @param appid
	 * @param secret
	 * @return
	 * @throws Exception
	 */
	public static String edj_zbsjurl(String tel,String lon,String lat) {

		StringBuffer url = new StringBuffer("appkey=61000098");
		url.append("&from=").append("");
		url.append("&gpsType=baidu");
		url.append("&latitude=").append(lat);
		url.append("&longitude=").append(lon);
		url.append("&timestamp=").append(DateFormat.getDatenoss(new Date()));
		url.append("&udid=").append(tel);
		url.append("&ver=3.2").append("");
		
		String sig = md5(url.toString().replaceAll("=", "").replaceAll("&", "")
				+ "3bdbb170-dba2-4eb4-ad4a-601b71564ade");
		url.append("&sig=").append(sig);

		String ret1 = "http://open.api.edaijia.cn/driver/idle/list?"+url.toString();
		return ret1;
	}

	/**
	 * 获取Token
	 * 
	 * @param toUser
	 * @param appid
	 * @param secret
	 * @return
	 * @throws Exception
	 */
	public static String axc_yhj(String tel, String yhj) {

		StringBuffer url = new StringBuffer("mobile=").append(tel);

		url.append("&rcode=").append(yhj);
		url.append("&channel=chemingpian");
		url.append("&sign=").append(md5(tel + yhj + "gp8NdL1rsL"));

		String ret1 = HttpClient.http(axc_url, url.toString());
		return ret1;
	}

	private static String getMD5Str(String str) {
		MessageDigest messageDigest = null;

		try {
			messageDigest = MessageDigest.getInstance("MD5");

			messageDigest.reset();

			messageDigest.update(str.getBytes("UTF-8"));
		} catch (NoSuchAlgorithmException e) {
			System.out.println("NoSuchAlgorithmException caught!");
			System.exit(-1);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		byte[] byteArray = messageDigest.digest();

		StringBuffer md5StrBuff = new StringBuffer();

		for (int i = 0; i < byteArray.length; i++) {
			if (Integer.toHexString(0xFF & byteArray[i]).length() == 1)
				md5StrBuff.append("0").append(
						Integer.toHexString(0xFF & byteArray[i]));
			else
				md5StrBuff.append(Integer.toHexString(0xFF & byteArray[i]));
		}

		return md5StrBuff.toString();
	}

	/**
	 * 计算加密的sig值
	 *
	 * @param params
	 * @param keySecret
	 * @return
	 */
	public static String generateSign(Map<String, String> params,
			String keySecret) {
		// 1.所有参数按名称排序
		List<Map.Entry<String, String>> paramsList = sort(params);
		// 2.由“参数”+“值”合并为字符串
		String queryStr = createQueryStr(paramsList);
		// 3.与appkey对应的secret一起md5;
		String sig = md5(queryStr + keySecret);
		return sig;

	}

	/**
	 * 字符串升序
	 *
	 * @param params
	 * @return
	 */
	private static List<Map.Entry<String, String>> sort(
			Map<String, String> params) {

		List<Map.Entry<String, String>> paramsList = new ArrayList<Map.Entry<String, String>>(
				params.entrySet());

		Collections.sort(paramsList,
				new Comparator<Map.Entry<String, String>>() {
					public int compare(Map.Entry<String, String> o1,
							Map.Entry<String, String> o2) {
						return (o1.getKey()).toString().compareTo(o2.getKey());
					}
				});

		return paramsList;
	}

	/**
	 * 拼接生成的传 例如:ac=info&cityId=3,合并为acinfocityId3
	 *
	 * @param params
	 * @return
	 */
	private static String createQueryStr(List<Map.Entry<String, String>> params) {

		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < params.size(); i++) {
			String key = params.get(i).getKey();
			String value = params.get(i).getValue();
			// 以下key不参与计算sig值
			if (!key.equals("gpsstring") && !key.equals("callback")
					&& !key.equals("_") && !key.equals("sig")) {
				sb.append(key);
				sb.append(value);
			}
		}
		return sb.toString();
	}

	/**
	 * md5加密
	 *
	 * @param plainText
	 *            明文
	 * @return 32位密文
	 */
	public static String md5(String plainText) {
		String retMd5 = new String();
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(plainText.getBytes());
			byte b[] = md.digest();

			int i;

			StringBuffer buf = new StringBuffer("");
			for (int offset = 0; offset < b.length; offset++) {
				i = b[offset];
				if (i < 0)
					i += 256;
				if (i < 16)
					buf.append("0");
				buf.append(Integer.toHexString(i));
			}
			retMd5 = buf.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return retMd5;
	}

	/**
	 * 获取油价
	 * 
	 * @param toUser
	 * @param appid
	 * @param secret
	 * @return
	 * @throws Exception
	 */
	public static OilInfo getOil(String privice) {

		StringBuffer url = new StringBuffer(
				"http://api.46644.com/oil/?act=query&province=")
				.append(privice).append(
						"&appkey=ff248dbf56a534e3157332a410b6618e");
		OilInfo oil = new OilInfo();
		String ret1 = HttpClient.sendGet(url.toString());
		JSONObject obj = (JSONObject) JSON.parse(ret1);
		if (obj != null) {
			if (obj.get("province") != null) {

				oil.set_id(obj.getString("province"));
				oil.setInsdate(new Date().getTime());
				oil.setProvince(obj.getString("province"));
				oil.setOil0(obj.getString("oil0"));
				oil.setOil90(obj.getString("oil90"));
				oil.setOil93(obj.getString("oil93"));
				oil.setOil97(obj.getString("oil97"));
				MongoDbUtil mongoDbUtil = new MongoDbUtil();
				mongoDbUtil.insertUpdate(PubConstants.SET_OIL, oil);
			}
		}
		return oil;
	}

	// public static void main(String[] args) throws
	// UnsupportedEncodingException {
	//
	// String timestamp = "2014-09-22+07%3A33"; //如果是经过encode的代码,就先decode一下
	// timestamp = URLDecoder.decode(timestamp, "UTF-8");
	//
	// // String timestamp = "2014-09-22 07:33"; //标准格式,不需要decode
	// String appkey = "";
	// String secret = "";
	//

	// System.out.println(sig);
	//
	//
	// }
	public static String jqr(String toUser, String info,String fromUser) {
		// String APIKEY =GetAllFunc.wxTouser.get(toUser).getZhlx();
		 
		StringBuffer sb = new StringBuffer();
		
		try {
			String INFO = URLEncoder.encode(info, "utf-8");
			String getURL = "http://www.tuling123.com/openapi/api?key="
					+ toUser + "&info=" + INFO+"&userid="+fromUser;
			
			URL getUrl = new URL(getURL);

			HttpURLConnection connection = (HttpURLConnection) getUrl
					.openConnection();
			connection.connect();

			// 取得输入流，并使用Reader读取
			BufferedReader reader = new BufferedReader(new InputStreamReader(
					connection.getInputStream(), "utf-8"));
			
			String line = "";
			while ((line = reader.readLine()) != null) {
				sb.append(line);
			}
			reader.close();
			connection.disconnect();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		JSONObject obj = (JSONObject) JSON.parse(sb.toString());
		return obj.getString("text");
	}

	public static void main(String[] args) {
		//String re=OtherUtil.jqr("50f934d298d6527bd06535bdf0ff2880", "笑话","gggg");
		OtherUtil.edj_zbsj("13991284269","116.478534","40.018756");//得到JSON字符串
		// String jsonResult =
		// OtherUtil.edj_yhj("13991284269","4156283882");//得到JSON字符串
		// System.err.print(jsonResult);
		// String jsonResult1 =
		// OtherUtil.axc_yhj("13991284269","11195829291275");//得到JSON字符串
		// System.err.print(jsonResult1);
	}
}
