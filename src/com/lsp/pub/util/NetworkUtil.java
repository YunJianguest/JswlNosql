package com.lsp.pub.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
/**
 * 工具
 * @author lsp 
 *   
 */
public class NetworkUtil {
	
	public static String getXmlStrFromUrl(String strUrl){
		URL url = null;
        HttpURLConnection httpConn = null;
        int code;
		//读取响应内容
		String sCurrentLine = ""; 
		String sTotalString = "";
		try{
			url = new URL(strUrl);
			httpConn = (HttpURLConnection) url.openConnection();
			HttpURLConnection.setFollowRedirects(true);
			httpConn.setDoOutput(true);
			httpConn.setRequestMethod("GET");
			httpConn.setRequestProperty("Content-Type", "text/xml; charset=UTF-8");
			httpConn.connect();
			code = httpConn.getResponseCode();
			System.out.println("code " + code);
			System.out.println(httpConn.getResponseMessage());
			if (code == 200)
			{
				java.io.InputStream is = httpConn.getInputStream();
				BufferedReader reader = new BufferedReader(
						new InputStreamReader(is, "UTF-8"));	//new InputStreamReader(is)--> new InputStreamReader(is, "UTF-8")解决乱码问题
				while ((sCurrentLine = reader.readLine()) != null)
					if (sCurrentLine.length() > 0){
						sTotalString = sTotalString + sCurrentLine + "\n";
					}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return sTotalString;
	}
	
	public static String getEncodeUrlStr(String str){
		String strUrl = "";
		try {
			strUrl = URLEncoder.encode(str, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return strUrl;
	}	
}
