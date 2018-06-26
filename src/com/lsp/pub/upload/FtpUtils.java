package com.lsp.pub.upload;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
 
import java.io.IOException;
 
import java.net.SocketException;
 
import org.apache.commons.net.ftp.FTPClient;
 
import org.apache.commons.net.ftp.FTPReply;

import com.lsp.pub.util.SysConfig;
 
 
/**
 * FTP工具
 * @author lsp 
 *   
 */
public class FtpUtils {
 
	public static FTPClient FTP;
	public static String WORKDIR;
	public static FTPClient getInstance() {
		 if(FTP==null){
			 FTP=FtpUtils.getFtpClient(SysConfig.getProperty("ftp"), SysConfig.getProperty("ftpname"), SysConfig.getProperty("ftppwd"),Integer.parseInt(SysConfig.getProperty("ftpport"))); 
		 }
		 
		  return FTP;
		 
	} 
	public static FTPClient getFtpClient(String serverIP,String userName,String password,int port) {
        int reply;
            FTPClient ftpClient = new FTPClient();
            try {
				ftpClient.connect(serverIP, port);
			
            reply = ftpClient.getReplyCode();
           
           if(!FTPReply.isPositiveCompletion(reply)){
               ftpClient.disconnect(); 
               return null;
           }
           ftpClient.login(userName, password);
           ftpClient.setDataTimeout(2000);
           ftpClient.enterLocalPassiveMode();
           ftpClient.setFileType(FTPClient.BINARY_FILE_TYPE);
           FTP=ftpClient;
            } catch (SocketException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
         return ftpClient;
   }
	/**
     * 上传文件到文件服务器中
     * @param file  需上传的文件
     * @param ftpClient  
     * @param workDirectory   FTP服务器的相对目录
     * @return
     * @throws IOException
     */
    public static String uploadFileToFTP(File file,FTPClient ftpClient,String workDirectory) throws IOException{
        
        ftpClient.setControlEncoding("UTF-8");
        ftpClient.makeDirectory(workDirectory);
        ftpClient.changeWorkingDirectory(workDirectory);
        BufferedInputStream  fiStream =new BufferedInputStream(new FileInputStream(file));
        boolean  flag = ftpClient.storeFile(new String((file.getName()).getBytes("UTF-8"),"iso-8859-1"),fiStream);
        fiStream.close();
        if(flag){
            return "OK";
        }else{
            return "";
        }
    }
    /**
     * 上传文件到文件服务器中
     * @param file  需上传的文件
     * @param ftpClient  
     * @param workDirectory   FTP服务器的相对目录
     * @return
     * @throws IOException
     */
    public static String uploadImageToFTP(FileInputStream localObject,FTPClient ftpClient,String name) throws IOException{
    	
        ftpClient.setControlEncoding("UTF-8");
        //ftpClient.makeDirectory("/img");
        //ftpClient.changeWorkingDirectory("/img");
        BufferedInputStream  fiStream =new BufferedInputStream(localObject);
        boolean  flag = ftpClient.storeFile(name,fiStream);
        fiStream.close();
        if(flag){
            return "OK";
        }else{
            return "";
        }
    }
    public static void closeFtp(FTPClient ftpClient){
        if(ftpClient!=null && ftpClient.isConnected()){
            try {
                boolean isLogOut = ftpClient.logout();
                if(isLogOut){
                    System.out.println("成功关闭ftp连接");
                }
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
                System.out.println("关闭FTP服务器异常");
            }finally{
                try {
                    ftpClient.disconnect();
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                    System.out.println("关闭服务器连接异常");
                }
            }
            
        }
    }
 
    /**
     * 
     * @param srcFname
     * @param fpath
     * @param ftpClient
     * @return
     * 
     * 删除文件时同样要把 String路径转换为"iso-8859-1"格式的路径
     */
    
    public static boolean removeFile(String srcFname,String fpath,FTPClient ftpClient){  
        boolean flag = false;  
        if( ftpClient!=null ){  
            try {
            	ftpClient.setControlEncoding("UTF-8"); 
            	ftpClient.changeWorkingDirectory(fpath);
                flag = ftpClient.deleteFile(new String(srcFname.getBytes("UTF-8"),"iso-8859-1"));  
                if(flag==true){
            	   System.out.println("删除成功！");
               }else{
            	   System.out.println("删除失败！");
               }
            } catch (IOException e) {  
                e.printStackTrace();  
                  
            }  
        }  
        return flag;  
    }  
}
