  package com.lsp.pub.web;
 
import com.lsp.pub.upload.FtpUtils;
import com.lsp.pub.upload.HttpUtils;
import com.lsp.pub.upload.ResumableInfo; 
import com.lsp.pub.upload.ResumableInfoStorage;
import com.lsp.pub.util.DateFormat;
import com.lsp.pub.util.FileUtil;
import com.lsp.pub.util.SysConfig;
import java.io.File;
import java.io.IOException;
import java.io.InputStream; 
import java.io.RandomAccessFile;
import java.util.Date; 
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 * 文件上传
 * @author lsp 
 *   
 */
public class UploadServlet extends HttpServlet
{
  private static final long serialVersionUID = 1L;
  public static final String UPLOAD_DIR = SysConfig.getProperty("fpath");
  public static String folder;
  public static String url;
  public static String path;

  protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
	 
    int resumableChunkNumber = getResumableChunkNumber(request);

    ResumableInfo info = getResumableInfo(request);

    RandomAccessFile raf = new RandomAccessFile(info.resumableFilePath, "rw");

    raf.seek((resumableChunkNumber - 1) * info.resumableChunkSize);

    InputStream is = request.getInputStream();
    long readed = 0L;
    long content_length = request.getContentLength();
    byte[] bytes = new byte[102400];
    while (readed < content_length) {
      int r = is.read(bytes);
      if (r < 0) {
        break;
      }
      raf.write(bytes, 0, r);
      readed += r;
    }
    raf.close();

    info.uploadedChunks.add(new ResumableInfo.ResumableChunkNumber(resumableChunkNumber));
    if (info.checkIfUploadFinished()) {
      ResumableInfoStorage.getInstance().remove(info);

      response.getWriter().print(path + "," + url);
    } else {
      response.getWriter().print("Upload...");
    }
  }

  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    int resumableChunkNumber = getResumableChunkNumber(request);

    ResumableInfo info = getResumableInfo(request);

    if (info.uploadedChunks.contains(new ResumableInfo.ResumableChunkNumber(resumableChunkNumber)))
      response.getWriter().print("Uploaded.");
    else
      response.setStatus(404);
  }

  private int getResumableChunkNumber(HttpServletRequest request)
  {
    return HttpUtils.toInt(request.getParameter("resumableChunkNumber"), -1);
  }

  private ResumableInfo getResumableInfo(HttpServletRequest request) throws ServletException {
    String base_dir = UPLOAD_DIR;

    int resumableChunkSize = HttpUtils.toInt(request.getParameter("resumableChunkSize"), -1);
    long resumableTotalSize = HttpUtils.toLong(request.getParameter("resumableTotalSize"), -1L);
    String resumableIdentifier = request.getParameter("resumableIdentifier");
    String resumableFilename = request.getParameter("resumableFilename");
    String resumableRelativePath = request.getParameter("resumableRelativePath");

    if ((resumableFilename.substring(resumableFilename.indexOf(".")).equals(".jpg")) || (resumableFilename.substring(resumableFilename.indexOf(".")).equals(".jpeg")) || (resumableFilename.substring(resumableFilename.indexOf(".")).equals(".png")))
    {
      folder = "img/";
      FtpUtils.WORKDIR = "/img";
    } else if (resumableFilename.substring(resumableFilename.indexOf(".")).equals(".mp3"))
    {
      folder = "/music/";
      FtpUtils.WORKDIR = "/music";
    } else if (resumableFilename.substring(resumableFilename.indexOf(".")).equals(".mp4"))
    {
      folder = "video/";
      FtpUtils.WORKDIR = "/video";
    } else if ((resumableFilename.substring(resumableFilename.indexOf(".")).equals(".jar")) || (resumableFilename.substring(resumableFilename.indexOf(".")).equals(".zip")))
    {
      folder = "jar/";
      FtpUtils.WORKDIR = "/jar";
    }else if((resumableFilename.substring(resumableFilename.indexOf(".")).equals(".txt")) || (resumableFilename.substring(resumableFilename.indexOf(".")).equals(".doc"))|| (resumableFilename.substring(resumableFilename.indexOf(".")).equals(".ppt"))|| (resumableFilename.substring(resumableFilename.indexOf(".")).equals(".xls"))|| (resumableFilename.substring(resumableFilename.indexOf(".")).equals(".pdf"))|| (resumableFilename.substring(resumableFilename.indexOf(".")).equals(".docx"))|| (resumableFilename.substring(resumableFilename.indexOf(".")).equals(".xlsx"))){
      folder = "docf/";
      FtpUtils.WORKDIR = "/docf";	
    }else {
      return null;
    }
    resumableFilename=DateFormat.getDateXml(new Date())+"-"+resumableFilename;
    resumableFilename=resumableFilename.trim().replace(" ", ""); 
    //Here we add a ".temp" to every upload file to indicate NON-FINISHED���ջ����ļ�
    //�����ļ� String resumableFilePath        = new File(base_dir, resumableFilename).getAbsolutePath() + ".temp";
    String resumableFilePath        = new File(base_dir,resumableFilename).getAbsolutePath();
    
    ResumableInfoStorage storage = ResumableInfoStorage.getInstance();

    ResumableInfo info = storage.get(resumableChunkSize, resumableTotalSize,
            resumableIdentifier, resumableFilename, resumableRelativePath, resumableFilePath);
    if (!info.vaild())         {
        storage.remove(info);
        throw new ServletException("Invalid request params.");
    }
    return info;
  }
}