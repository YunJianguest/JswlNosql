package com.lsp.pub.upload;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.apache.cxf.wsdl.http.UrlEncoded;
/**
 * http工具
 * @author lsp 
 *   
 */
public class HttpURLConnectionUtils  {

   public static HttpURLConnection CONN;
   public static void GetHttpURLConnection(String uri)throws Exception{
	    URL url = new URL(uri);  
     
        HttpURLConnection conn = (HttpURLConnection)url.openConnection();  
        // 发送POST请求必须设置如下两行  

        conn.setDoOutput(true);  
        conn.setUseCaches(false);  
        conn.setRequestMethod("POST");  
        conn.setRequestProperty("Content-Type","text/html");  
        conn.setRequestProperty("Cache-Control","no-cache");  
        conn.setRequestProperty("Charsert", "utf-8"); 
        conn.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)");
        CONN=conn;
        CONN.connect();  
 	    CONN.setConnectTimeout(3000); 
     
   }
   public static String SendFiles(String str,HttpURLConnection conn) throws Exception{
	   
       OutputStream out =conn.getOutputStream();  
       out.write(URLEncoder.encode(str, "utf-8").getBytes());
       out.flush();  
       out.close();
        
       BufferedReader br =new BufferedReader(new InputStreamReader(conn.getInputStream())); 
       String path= br.readLine();
       br.close(); 
       conn.disconnect();
	 return path;  
   }
 
}
