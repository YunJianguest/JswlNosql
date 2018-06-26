package com.lsp.pub.web;


import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Date;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results;

 
import com.lsp.pub.util.EncodeUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.opensymphony.xwork2.ActionSupport;
/**
 * 文件上传
 * @author lsp 
 *   
 */
@Namespace("/pub")
@Results({ @org.apache.struts2.convention.annotation.Result(name = "reload", location = "uploadserver.action", type = "redirect") })
public class UploadserverAction extends ActionSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = -6784469775589971579L;

	@Override
	public String execute() throws Exception {

		 
	    InputStream input = Struts2Utils.getRequest().getInputStream();
	    BufferedReader br = new BufferedReader(new InputStreamReader(input,"utf-8"));
	    String line = null;
		StringBuilder sb = new StringBuilder();
		while ((line = br.readLine()) != null) {
			line = new String(line.getBytes(), "utf-8");
			sb.append(line);
		}
		  
		JSONArray   jsonarray=JSONArray.fromObject(URLDecoder.decode(sb.toString(),
				"utf-8"));
	    
	    if(jsonarray.size()>0){
	    	 
	    	  
	    	String savepaths="";
	    	 for (int i = 0; i < jsonarray.size(); i++) {
	    	 
	    		JSONObject obj = jsonarray.getJSONObject(i);
	 			String FileName=obj.get("FileName").toString();
	 			 
	 			String ContentType=obj.get("ContentType").toString();
	 			byte[]files=EncodeUtils.base64Decode(obj.get("file").toString());
	 			 
	 		 
	 			File file=new File(SysConfig.getProperty("filepath"));
	 			if(!file.exists()){
	 				file.mkdir();  
	 			}
	 			String savepath=SysConfig.getProperty("filepath")+FileName; 
	 			File  createFile=new File(savepath);
	 			
	 			FileOutputStream  fileWrite=new FileOutputStream(createFile);
	 		    fileWrite.write(files);
	 		    fileWrite.flush();
	 		    fileWrite.close();
	 		    savepaths=savepaths+savepath+",";
	 		}    
          Struts2Utils.getResponse().getWriter().print(URLEncoder.encode(savepaths, "utf-8"));
	    }
	   
		return null;
	}

}
