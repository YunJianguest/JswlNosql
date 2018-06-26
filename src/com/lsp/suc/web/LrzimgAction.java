package com.lsp.suc.web;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.EncodeUtils;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 图片上传类
 * @author lsp
 *
 */
@Namespace("/suc")
@Results( { @Result(name ="reload", location = "lrzimg.action", type = "redirect") })
public class LrzimgAction extends ActionSupport {
      
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public  void  imginput(){
		 Map<String, Object>obj=new HashMap<String, Object>();
		 
			try {
				int  imgSize=Integer.parseInt(Struts2Utils.getParameter("imgSize"));
				String  imgName=Struts2Utils.getParameter("imgName");
				String  imgBase64=Struts2Utils.getParameter("imgBase64");
				imgBase64=imgBase64.substring(imgBase64.indexOf(",")+1); 
				byte[]files=EncodeUtils.decodeBuffer(imgBase64);
				 
					File file=new File(SysConfig.getProperty("imgpath"));
					if(!file.exists()){
						file.mkdir();  
					}
					String path=DateFormat.getDateXml(new Date())+"-"+imgName;
					String savepath=SysConfig.getProperty("imgpath")+"/"+path; 
					File  createFile=new File(savepath); 
					OutputStream  fileWrite=new FileOutputStream(createFile);  
					fileWrite.write(files); 
				    
				    fileWrite.flush();
				    fileWrite.close();
				   
				    obj.put("path", path);
				    obj.put("ret", true);
				    obj.put("state", 0);
				 
					
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				 obj.put("ret", false);
				 obj.put("state", 1);
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				 obj.put("ret", false);
				 obj.put("state", 1);
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				 obj.put("ret", false);
				 obj.put("state", 1);
				e.printStackTrace();
			}
			
		 
		
	    String json = JSONObject.fromObject(obj).toString();
		Struts2Utils.renderJson(json, new String[0]); 	   
		
		
	}
	
}
