package com.lsp.pub.util;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLConnection;
/**
 * 工具
 * @author lsp 
 *   
 */
public class DownloadImage {  

  /** 
   * @param args 
   * @throws Exception  
   */  
  public static void main(String[] args) throws Exception {  
      // TODO Auto-generated method stub  
      
  	download("http://wx.qlogo.cn/mmopen/ibt7cjYc0xYqL8DHzv2mxuHekGQPaujxRbpCyibO6U5ZEcePlPgnJADb6gwv4aHAjicTupQWLLFn1JGCSrM1cBt1kpI5U8Xh2m6", "c:\\image\\52bi1.jpg");  
  	System.err.println("sssss");
  }  
    
  public static void download(String urlString,String savePath)  {  
      // 构造URL  
      try{
  	URL url = new URL(urlString);  
      // 打开连接  
      URLConnection con = url.openConnection();  
      //设置请求超时为5s  
      con.setConnectTimeout(5*1000);  
      // 输入流  
      InputStream is = con.getInputStream();  
    
      // 1K的数据缓冲  
      byte[] bs = new byte[1024];  
      // 读取到的数据长度  
      int len;  
     
     OutputStream os = new FileOutputStream(savePath);  
      // 开始读取  
      while ((len = is.read(bs)) != -1) {  
        os.write(bs, 0, len);  
      }  
      // 完毕，关闭所有链接  
      os.close();  
      is.close();  
      } catch (Exception e) {

  	}  
  } 
  
}  