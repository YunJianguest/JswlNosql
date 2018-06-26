package com.lsp.pub.web;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Results;

import com.lsp.pub.upload.HttpURLConnectionUtils;
import com.lsp.pub.upload.JsonUtil;
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
@Results({ @org.apache.struts2.convention.annotation.Result(name = "reload", location = "upload.action", type = "redirect") })
public class UploadAction extends ActionSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = -6784469775589971579L;
	private List<File> image; // 上传的文件
	private List<String> imageFileName; // 文件名称
	private List<String> imageContentType; // 文件类型
	private String savePath;

	@Override
	public String execute() throws Exception { 
		// 取得需要上传的文件数组
		List<File> files = getImage();
		
		
		if (files != null && files.size() > 0) {
		
			for (int i = 0; i < files.size(); i++) {
				
				FileInputStream fis = new FileInputStream(files.get(i));
				byte[] buffer = new byte[fis.available()]; 
				fis.read(buffer); 
				fis.close();
			  
				JsonUtil.Add(new String[]{"file","FileName","ContentType"},new Object[]{ EncodeUtils.base64Encode(buffer),imageFileName.get(i),imageContentType.get(i)});
				 
			}
			
			HttpURLConnectionUtils.GetHttpURLConnection(SysConfig.getProperty("imgurl"));
			savePath=HttpURLConnectionUtils.SendFiles(JsonUtil.JSONARRAY.toString(),HttpURLConnectionUtils.CONN);
		 
			Struts2Utils.getResponse().getWriter().print(savePath);
			 
		}
		
		//
		return SUCCESS;
	}

	public List<File> getImage() {
		return image;
	}

	public void setImage(List<File> image) {
		this.image = image;
	}

	public List<String> getImageFileName() {
		return imageFileName;
	}

	public void setImageFileName(List<String> imageFileName) {
		this.imageFileName = imageFileName;
	}

	public List<String> getImageContentType() {
		return imageContentType;
	}

	public void setImageContentType(List<String> imageContentType) {
		this.imageContentType = imageContentType;
	}
   
}
