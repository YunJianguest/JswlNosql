package com.lsp.pub.util;
 
import com.aliyun.oss.OSSClient;
/**
 * 工具
 * @author lsp 
 *   
 */
public class OSSClientInstance {
	public static OSSClient instance;
	 public static OSSClient getInstance(){
	  if(instance == null){
	   instance = new OSSClient(SysConfig.getProperty("endpoint"), SysConfig.getProperty("accessKeyId"), SysConfig.getProperty("accessKeySecret"));
	  }
	  return instance; 
	 }
}