package com.lsp.pub.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;


import com.aliyun.oss.ClientException;
import com.aliyun.oss.OSSClient;
import com.aliyun.oss.OSSException;
import com.aliyun.oss.model.ObjectMetadata;
import com.lsp.pub.entity.RoteInfo;
import com.lsp.pub.upload.FtpUtils;
import com.lsp.pub.upload.JsonUtil;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.EncodeUtils;
import com.lsp.pub.util.FileUtil;
import com.lsp.pub.util.ImageMarkUtil;
import com.lsp.pub.util.ImageZipUtil;
import com.lsp.pub.util.PropertiesUtil;
import com.lsp.pub.util.Struts2Utils;
import com.lsp.pub.util.SysConfig;
/**
 * 文件上传
 * @author lsp 
 *   
 */
@Namespace("/")
@Results({ @Result(name = UpfileAction.RELOAD, location = "upfile.action", type = "redirect") })
public class UpfileAction extends GeneralAction<RoteInfo> {
	/**
	 * 
	 */
	private static final long serialVersionUID = 4073398456035614636L;
	private static final String _$39 = "cfg_imgtype";
	private static final String _$38 = "cfg_attachtype";
	private static final String _$37 = "cfg_mediatype";
	private static final String _$36 = "cfg_ddimg_width";
	private static final String _$35 = "cfg_imagemark";
	private static final String _$34 = "cfg_imagemarktype";
	private static final String _$33 = "cfg_imagemarkdegree";
	private static final String _$32 = "cfg_imagemarkalpha";
	private static final String _$31 = "cfg_imagemarkwidth";
	private static final String _$30 = "cfg_imagemarkheight";
	private static final String _$29 = "cfg_imagemaricon";
	private static final String _$28 = "cfg_imagemarktext";
	private static final String _$27 = "cfg_imageforntsize";
	private static final String _$26 = "cfg_imagemarkbold";
	private static final String _$25 = "text/html; charset=UTF-8";
	 
	public int IMG_WIDTH = 100;
	public File uploadifyfile;
	private final String _$23 = "uploads";
	private static final String _$22 = "images";
	public String IMAGE_TYPE = "";
	private static final int _$21 = 3;
	private static final String _$20 = "video";
	public String FLASH_TYPE = "";
	private static final int _$19 = 50;
	private static final String _$18 = "file";
	public String FILE_TYPE = "";
	private static final int _$17 = 10;
	private String _$16 = "";
	public String temp_file_type = "";
	public int temp_file_size = 0;
	public String uploadifyfileFileName;

	public String executeUpFlash() throws Exception {
		this.FLASH_TYPE = SysConfig.getProperty("cfg_mediatype");

		setTemp_file_path("video");
		setTemp_file_size(50);
		setTemp_file_type(this.FLASH_TYPE);

		String str1 = getImageSavePath();
		String str2 = new FileUtil().getFileExt(this.uploadifyfileFileName);
		String str3 = createFileNameByDate(str2);
		String str4 = "";
		if (this.temp_file_type.indexOf(str2) == -1) {
			str4 = this.temp_file_type + " is allowed";
		} else {
			FileInputStream localObject1 = new FileInputStream(
					this.uploadifyfile);
			FileOutputStream localObject2 = new FileOutputStream(new File(str1
					+ File.separator + str3));
			try {
				byte[] arrayOfByte = new byte[10240];
				while (((InputStream) localObject1).read(arrayOfByte) > 0)
					((OutputStream) localObject2).write(arrayOfByte);
			} catch (Exception localException) {
				localException.printStackTrace();
				str4 = "upload fail";
			} finally {
				if (localObject1 != null)
					((InputStream) localObject1).close();
				if (localObject2 != null)
					((OutputStream) localObject2).close();
			}
		}
		Object localObject1 = "/uploads/" + this._$16 + "/" + getYearMonthDay()
				+ "/" + str3;
		if (!str4.equals(""))
			localObject1 = "";
		Object localObject2 = Struts2Utils.getResponse();
		PrintWriter localPrintWriter = ((HttpServletResponse) localObject2)
				.getWriter();
		((HttpServletResponse) localObject2).getWriter().print(
				(String) localObject1);
		return "none";
	}

	public String executeUpFile() throws Exception {
		this.FILE_TYPE = SysConfig.getProperty("cfg_attachtype");
		if (this._$16.equals("")) {
			setTemp_file_path("file");
			setTemp_file_size(10);
			setTemp_file_type(this.FILE_TYPE);
		}
		String str1 = getImageSavePath();
		String str2 = new FileUtil().getFileExt(this.uploadifyfileFileName);
		String str3 = createFileNameByDate(str2);
		String str4 = "";
		if (this.temp_file_type.indexOf(str2) == -1) {
			str4 = this.temp_file_type + " is allowed";
		} else {
			FileInputStream localObject1 = new FileInputStream(
					this.uploadifyfile);
			FileOutputStream localObject2 = new FileOutputStream(new File(str1
					+ File.separator + str3));
			try {
				byte[] arrayOfByte = new byte[1048576];
				while (((InputStream) localObject1).read(arrayOfByte) > 0)
					((OutputStream) localObject2).write(arrayOfByte);
			} catch (Exception localException) {
				localException.printStackTrace();
				str4 = "upload fail";
			} finally {
				if (localObject1 != null)
					((InputStream) localObject1).close();
				if (localObject2 != null)
					((OutputStream) localObject2).close();
			}
		}
		Object localObject1 = "/uploads/" + this._$16 + "/" + getYearMonthDay()
				+ "/" + str3;
		if (!str4.equals(""))
			localObject1 = "";
		Object localObject2 = Struts2Utils.getResponse();
		PrintWriter localPrintWriter = ((HttpServletResponse) localObject2)
				.getWriter();
		((HttpServletResponse) localObject2).getWriter().print(
				(String) localObject1);
		return "none";
	}

	public String executeUpimages() throws Exception {
		this.IMG_WIDTH = Integer.parseInt(SysConfig
				.getProperty("cfg_ddimg_width"));
		this.IMAGE_TYPE = SysConfig.getProperty("cfg_imgtype");
		if (this._$16.equals("")) {
			setTemp_file_path("images");
			setTemp_file_size(3);
			setTemp_file_type(this.IMAGE_TYPE);
		}
		String str1 = getImageSavePath();
		String str2 = new FileUtil().getFileExt(this.uploadifyfileFileName);

		String str3 = createFileNameByDate(str2);
		String str4 = "";
		if (this.temp_file_type.indexOf(str2) == -1) {
			str4 = this.temp_file_type + " is allowed";
		} else {
			FileInputStream localObject1 = new FileInputStream(
					this.uploadifyfile);
			FileOutputStream localObject2 = new FileOutputStream(new File(str1
					+ File.separator + str3));
			try {

				byte[] arrayOfByte = new byte[10240];
				while (((InputStream) localObject1).read(arrayOfByte) > 0)
					((OutputStream) localObject2).write(arrayOfByte);
			} catch (Exception localException) {
				localException.printStackTrace();
				str4 = "upload fail";
			} finally {
				if (localObject1 != null)
					((InputStream) localObject1).close();
				if (localObject2 != null)
					((OutputStream) localObject2).close();
			}
		}
		Object localObject1 = "/uploads/" + this._$16 + "/" + getYearMonthDay()
				+ "/" + str3;
		if (!str4.equals(""))
			localObject1 = "";
		Object localObject2 = Struts2Utils.getResponse();
		PrintWriter localPrintWriter = ((HttpServletResponse) localObject2)
				.getWriter();
		((HttpServletResponse) localObject2).getWriter().print(
				(String) localObject1);
		imageMarkProcess(str1 + File.separator + str3);
		zipimagesproces(str1 + File.separator + str3);
		return "none";
	}

	public String upImage(){
		try {
		if(SysConfig.getProperty("isossup").endsWith("1")){
			
	        
		}else if(SysConfig.getProperty("isossup").endsWith("2")){
			String str2 = new FileUtil().getFileExt(this.uploadifyfileFileName);

			String str3 = createFileNameByDate(str2);
			String reurl  = "images-"  + getYearMonthDay()+ "-" + str3;
			FileInputStream localObject1 = new FileInputStream(this.uploadifyfile);
			FTPClient ftp=FtpUtils.getFtpClient(SysConfig.getProperty("ftp"), SysConfig.getProperty("ftpname"), SysConfig.getProperty("ftppwd"),Integer.parseInt(SysConfig.getProperty("ftpport")));
			FtpUtils.uploadImageToFTP(localObject1, ftp, reurl);
			FtpUtils.closeFtp(ftp);
			Object localObject2 = Struts2Utils.getResponse();
			
			((HttpServletResponse) localObject2).getWriter().print(reurl);
		}else if(SysConfig.getProperty("isossup").endsWith("3")){
			//跨域
			//添加文件到缓存 
			FileInputStream localObject1 = new FileInputStream(this.uploadifyfile);
			String  fpath=DateFormat.getDateXml(new Date())+(1+(int)(Math.random()*100))+"."+new FileUtil().getFileExt(this.uploadifyfileFileName);//文件名称 
			JsonUtil.Add(new String[]{"file","FileName","ContentType"},new Object[]{EncodeUtils.base64Encode(JsonUtil.readBytes(localObject1)),fpath,"img"});
		 	//返回保存的路径
			String url=JsonUtil.UploadFile();
			if(url==null){
				Struts2Utils.getResponse().getWriter().print("上传错误");
			}else{
				Struts2Utils.getResponse().getWriter().print(fpath);
			}
			
		}else{
		this.IMG_WIDTH = Integer.parseInt(SysConfig
				.getProperty("cfg_ddimg_width"));
		this.IMAGE_TYPE = SysConfig.getProperty("cfg_imgtype");

		setTemp_file_path("images");
		setTemp_file_size(3);
		setTemp_file_type(this.IMAGE_TYPE);

		String str1 = getImageSavePath();
		String str2 = new FileUtil().getFileExt(this.uploadifyfileFileName);

		String str3 = createFileNameByDate(str2);
		String str4 = "";
		if (this.temp_file_type.indexOf(str2) == -1) {
			str4 = this.temp_file_type + " is allowed";
		} else {
			FileInputStream localObject1 = new FileInputStream(
					this.uploadifyfile);
			FileOutputStream localObject2 = new FileOutputStream(new File(str1
					+ File.separator + str3));
			try {

				byte[] arrayOfByte = new byte[10240];
				while (((InputStream) localObject1).read(arrayOfByte) > 0)
					((OutputStream) localObject2).write(arrayOfByte);
			} catch (Exception localException) {
				localException.printStackTrace();
				str4 = "upload fail";
			} finally {
				if (localObject1 != null)
					((InputStream) localObject1).close();
				if (localObject2 != null)
					((OutputStream) localObject2).close();
			}
		}
		Object localObject1 = "/uploads/" + this._$16 + "/" + getYearMonthDay()
				+ "/" + str3;
		if (!str4.equals(""))
			localObject1 = "";
		Object localObject2 = Struts2Utils.getResponse();
		PrintWriter localPrintWriter = ((HttpServletResponse) localObject2)
				.getWriter();
		((HttpServletResponse) localObject2).getWriter().print(
				(String) localObject1);
		}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "none";
	}
	 // 上传文件
    private static void uploadFile(OSSClient client, String bucketName, String key, String filename)
            throws OSSException, ClientException, FileNotFoundException {
        File file = new File(filename);

        ObjectMetadata objectMeta = new ObjectMetadata();
        objectMeta.setContentLength(file.length());
        // 可以在metadata中标记文件类型
        objectMeta.setContentType("image/jpeg");

        InputStream input = new FileInputStream(file);
        client.putObject(bucketName, key, input, objectMeta);
    }
	public String upVideo() throws Exception {
		this.FLASH_TYPE = SysConfig.getProperty("cfg_mediatype");

		setTemp_file_path("video");
		setTemp_file_size(50);
		setTemp_file_type(this.FLASH_TYPE);

		String str1 = getImageSavePath();
		String str2 = new FileUtil().getFileExt(this.uploadifyfileFileName);
		String str3 = createFileNameByDate(str2);
		String str4 = "";
		if (this.temp_file_type.indexOf(str2) == -1) {
			str4 = this.temp_file_type + " is allowed";
		} else {
			FileInputStream localObject1 = new FileInputStream(
					this.uploadifyfile);
			FileOutputStream localObject2 = new FileOutputStream(new File(str1
					+ File.separator + str3));
			try {
				byte[] arrayOfByte = new byte[1024];
				while (((InputStream) localObject1).read(arrayOfByte) > 0)
					((OutputStream) localObject2).write(arrayOfByte);
			} catch (Exception localException) {
				localException.printStackTrace();
				str4 = "upload fail";
			} finally {
				if (localObject1 != null)
					((InputStream) localObject1).close();
				if (localObject2 != null)
					((OutputStream) localObject2).close();
			}
		}
		Object localObject1 = "/uploads/" + this._$16 + "/" + getYearMonthDay()
				+ "/" + str3;
		if (!str4.equals(""))
			localObject1 = "";
		Object localObject2 = Struts2Utils.getResponse();
		PrintWriter localPrintWriter = ((HttpServletResponse) localObject2)
				.getWriter();
		((HttpServletResponse) localObject2).getWriter().print(
				(String) localObject1);
		return "none";
	}

	public void zipimagesproces(String paramString) {
		ImageZipUtil localImageZipUtil = new ImageZipUtil();
		Integer localInteger = Integer.valueOf(0);
		if ((SysConfig.getProperty("cfg_ddimg_width") != null)
				&& (!SysConfig.getProperty("cfg_ddimg_width").equals(""))
				&& (!SysConfig.getProperty("cfg_ddimg_width").equals("0"))) {
			localInteger = Integer.valueOf(Integer.parseInt(SysConfig
					.getProperty("cfg_ddimg_width")));
			localImageZipUtil.imageZipProce(paramString,
					localInteger.intValue(), localInteger.intValue(), 1.0F);
		}
	}

	public void imageMarkProcess(String paramString) {
		ImageMarkUtil localImageMarkUtil = new ImageMarkUtil();
		String str1 = "";
		String str2 = "";
		Integer localInteger1 = Integer.valueOf(0);
		Integer localInteger2 = Integer.valueOf(0);
		Integer localInteger3 = Integer.valueOf(0);
		Integer localInteger4 = Integer.valueOf(0);
		if (!SysConfig.getProperty("cfg_imagemark").equals("1")) {
			str1 = SysConfig.getProperty("cfg_imagemaricon");
			localInteger1 = Integer.valueOf(Integer.parseInt(SysConfig
					.getProperty("cfg_imagemarkdegree")));
			localInteger2 = Integer.valueOf(Integer.parseInt(SysConfig
					.getProperty("cfg_imagemarkwidth")));
			localInteger3 = Integer.valueOf(Integer.parseInt(SysConfig
					.getProperty("cfg_imagemarkheight")));
			Float localFloat = Float.valueOf(Float.parseFloat(SysConfig
					.getProperty("cfg_imagemarkalpha")));
			localInteger4 = Integer.valueOf(Integer.parseInt(SysConfig
					.getProperty("cfg_imageforntsize")));
			str2 = SysConfig.getProperty("cfg_imagemarktext");
			if (SysConfig.getProperty("cfg_imagemarktype").equals("0"))
				localImageMarkUtil.markImageByIcon(str1, paramString,
						paramString, localInteger1, localFloat.floatValue(),
						localInteger2, localInteger3);
			else if (SysConfig.getProperty("cfg_imagemarktype").equals("1"))
				localImageMarkUtil.markByText(str2, paramString, paramString,
						localInteger1, localFloat.floatValue(), localInteger2,
						localInteger3, localInteger4);
		}
	}

	public void imageMarkProcess(String type, String paramString) {
		ImageMarkUtil localImageMarkUtil = new ImageMarkUtil();
		String str1 = "";
		String str2 = "";
		Integer localInteger1 = Integer.valueOf(0);
		Integer localInteger2 = Integer.valueOf(0);
		Integer localInteger3 = Integer.valueOf(0);
		Integer localInteger4 = Integer.valueOf(0);
		if (!SysConfig.getProperty("cfg_imagemark").equals("1")) {
			str1 = SysConfig.getProperty("cfg_imagemaricon");
			localInteger1 = Integer.valueOf(Integer.parseInt(SysConfig
					.getProperty("cfg_imagemarkdegree")));
			localInteger2 = Integer.valueOf(Integer.parseInt(SysConfig
					.getProperty("cfg_imagemarkwidth")));
			localInteger3 = Integer.valueOf(Integer.parseInt(SysConfig
					.getProperty("cfg_imagemarkheight")));
			Float localFloat = Float.valueOf(Float.parseFloat(SysConfig
					.getProperty("cfg_imagemarkalpha")));
			localInteger4 = Integer.valueOf(Integer.parseInt(SysConfig
					.getProperty("cfg_imageforntsize")));
			str2 = SysConfig.getProperty("cfg_imagemarktext");
			if (SysConfig.getProperty("cfg_imagemarktype").equals("0"))
				localImageMarkUtil.markImageByIcon(str1, paramString,
						paramString, localInteger1, localFloat.floatValue(),
						localInteger2, localInteger3);
			else if (SysConfig.getProperty("cfg_imagemarktype").equals("1"))
				localImageMarkUtil.markByText(type, str2, paramString,
						paramString, localInteger1, localFloat.floatValue(),
						localInteger2, localInteger3, localInteger4);
		}
	}

	public String execute() throws ServletException, IOException {
		if (this._$16.equals("")) {
			setTemp_file_path("images");
			setTemp_file_size(3);
			setTemp_file_type(this.IMAGE_TYPE);
		}
		HttpServletRequest localHttpServletRequest = Struts2Utils.getRequest();
		HttpServletResponse localHttpServletResponse = Struts2Utils
				.getResponse();
		String str1 = getImageSavePath();
		System.out.print("路径为：======:" + str1);
		File localFile1 = new File(str1);
		if (!localFile1.exists())
			localFile1.mkdirs();
		DiskFileItemFactory localDiskFileItemFactory = new DiskFileItemFactory();
		ServletFileUpload localServletFileUpload = new ServletFileUpload(
				localDiskFileItemFactory);
		localServletFileUpload.setHeaderEncoding("UTF-8");
		List localList = null;
		try {
			localList = localServletFileUpload
					.parseRequest(localHttpServletRequest);
			System.out.print("文件个数为：======:" + localList.size());
		} catch (FileUploadException localFileUploadException) {
			return null;
		}
		Iterator localIterator = localList.iterator();
		String str2 = "";
		String str3 = "";
		while (localIterator.hasNext()) {
			FileItem localFileItem = (FileItem) localIterator.next();
			if (!localFileItem.isFormField()) {
				str2 = localFileItem.getName();
				long l = localFileItem.getSize();
				String str4 = localFileItem.getContentType();
				System.out.println(l + "字节" + " " + str4);
				if ((str2 != null) && (!str2.trim().equals(""))) {
					if (str2.lastIndexOf(".") >= 0)
						str3 = str2.substring(str2.lastIndexOf("."));
					File localFile2 = null;
					do {
						Date localObject = new Date();
						SimpleDateFormat localSimpleDateFormat = new SimpleDateFormat(
								"HHmmssSSS");
						str2 = localSimpleDateFormat.format((Date) localObject);
						localFile2 = new File(str1 + str2 + str3);
					} while (localFile2.exists());
					Object localObject = new File(str1 + str2 + str3);
					try {
						localFileItem.write((File) localObject);
					} catch (Exception localException) {
						localException.printStackTrace();
					}
				}
			}
		}
		localHttpServletResponse.getWriter().print(str2 + str3);
		return "none";
	}

	public String createFileNameByDate(String paramString) {
		Date localDate = new Date();
		SimpleDateFormat localSimpleDateFormat = new SimpleDateFormat(
				"HHmmssSSS");
		String str = localSimpleDateFormat.format(localDate) + "."
				+ paramString;
		return str;
	}

	public String getImageSavePath() {
		String str1 = PropertiesUtil.getRootpath() + "uploads" + File.separator
				+ this._$16;
		String str2 = getYearMonthDay();
		str1 = str1 + File.separator + str2;
		File localFile = new File(str1);
		if (!localFile.exists())
			localFile.mkdirs();
		return str1;
	}

	public String getYearMonthDay() {
		Date localDate = new Date();
		SimpleDateFormat localSimpleDateFormat = new SimpleDateFormat(
				"yyyyMMdd");
		return localSimpleDateFormat.format(localDate);
	}

	public File getUploadifyfile() {
		return this.uploadifyfile;
	}

	public void setUploadifyfile(File paramFile) {
		this.uploadifyfile = paramFile;
	}

	public String getUPLOADS_PATH() {
		return "uploads";
	}

	public String getIMAGES_PATH() {
		return "images";
	}

	public String getTemp_file_path() {
		return this._$16;
	}

	public void setTemp_file_path(String paramString) {
		this._$16 = paramString;
	}

	public String getTemp_file_type() {
		return this.temp_file_type;
	}

	public void setTemp_file_type(String paramString) {
		this.temp_file_type = paramString;
	}

	public int getTemp_file_size() {
		return this.temp_file_size;
	}

	public void setTemp_file_size(int paramInt) {
		this.temp_file_size = paramInt;
	}

	public String getIMAGE_TYPE() {
		return this.IMAGE_TYPE;
	}

	public int getIMAGE_SIZE() {
		return 3;
	}

	public String getUploadifyfileFileName() {
		return this.uploadifyfileFileName;
	}

	public void setUploadifyfileFileName(String paramString) {
		this.uploadifyfileFileName = paramString;
	}

	@Override
	public RoteInfo getModel() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String input() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String update() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub

	}
}

/*
 * Location: D:\tool\RBT\WEB-INF\classes\ Qualified Name:
 * com.rbt.action.UpFileAction JD-Core Version: 0.6.1
 */