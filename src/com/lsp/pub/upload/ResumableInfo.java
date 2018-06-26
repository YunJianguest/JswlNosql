package com.lsp.pub.upload;


import com.lsp.pub.util.SysConfig;
import com.lsp.pub.web.UploadServlet;

import java.io.File;
import java.io.IOException; 
import java.net.SocketException;
import java.util.HashSet;
/**
 * 资源管理
 * @author lsp 
 *   
 */
public class ResumableInfo
{
  public int resumableChunkSize;
  public long resumableTotalSize;
  public String resumableIdentifier;
  public String resumableFilename;
  public String resumableRelativePath;
  public HashSet<ResumableChunkNumber> uploadedChunks = new HashSet<ResumableChunkNumber>();
  public String resumableFilePath;

  public boolean vaild()
  {
    if ((this.resumableChunkSize < 0) || (this.resumableTotalSize < 0L) || 
      (HttpUtils.isEmpty(this.resumableIdentifier)) || 
      (HttpUtils.isEmpty(this.resumableFilename)) || 
      (HttpUtils.isEmpty(this.resumableRelativePath))) {
      return false;
    }
    return true;
  }

  public boolean checkIfUploadFinished()
  {
    int count = (int)Math.ceil(this.resumableTotalSize / this.resumableChunkSize);
    for (int i = 1; i < count + 1; i++) {
      if (!this.uploadedChunks.contains(new ResumableChunkNumber(i))) {
        return false;
      }

    }

    File file = new File(this.resumableFilePath);
    UploadServlet.path = FtpUtils.WORKDIR + "/" + resumableFilename;

    UploadServlet.url =UploadServlet.folder + resumableFilename;
     
    try
    {
      
      FtpUtils.uploadFileToFTP(file, FtpUtils.getFtpClient(SysConfig.getProperty("ftp"), SysConfig.getProperty("ftpname"), SysConfig.getProperty("ftppwd"), Integer.parseInt(SysConfig.getProperty("ftpport"))), FtpUtils.WORKDIR);
      FtpUtils.closeFtp(FtpUtils.FTP);
      file.delete();
      return true;
    }
    catch (NumberFormatException e) {
      e.printStackTrace();
    }
    catch (SocketException e) {
      e.printStackTrace();
    }
    catch (IOException e) {
      e.printStackTrace();
    }
    return false;
  }

  public static class ResumableChunkNumber
  {
    public int number;

    public ResumableChunkNumber(int number)
    {
      this.number = number;
    }

    public boolean equals(Object obj)
    {
      return 
        ((ResumableChunkNumber)obj).number == this.number;
    }

    public int hashCode()
    {
      return this.number;
    }
  }
}