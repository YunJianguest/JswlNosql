package com.lsp.pub.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
/**
 * 工具
 * @author lsp 
 *   
 */
public class FileUtil
{
  private String _$2;
  private String _$1 = "/";

  public String readTxt(String paramString)
  {
    return readTxt(paramString, "UTF-8");
  }

  public String readTxt(String paramString1, String paramString2)
  {
    paramString2 = paramString2.trim();
    StringBuffer localStringBuffer = new StringBuffer("");
    String str1 = "";
    FileInputStream localFileInputStream = null;
    InputStreamReader localInputStreamReader = null;
    BufferedReader localBufferedReader = null;
    try
    {
      localFileInputStream = new FileInputStream(paramString1);
      if (paramString2.equals(""))
        localInputStreamReader = new InputStreamReader(localFileInputStream);
      else
        localInputStreamReader = new InputStreamReader(localFileInputStream, paramString2);
      localBufferedReader = new BufferedReader(localInputStreamReader);
      try
      {
        String str2 = "";
        while ((str2 = localBufferedReader.readLine()) != null)
          localStringBuffer.append(str2 + "\n");
      }
      catch (Exception localException)
      {
        localStringBuffer.append(localException.toString());
      }
      str1 = localStringBuffer.toString();
      localFileInputStream.close();
      localInputStreamReader.close();
      localBufferedReader.close();
    }
    catch (IOException localIOException4)
    {
      System.out.println(localIOException4.getMessage() + "///" + paramString1 + "文件路径读取错误");
    }
    finally
    {
      if (localFileInputStream != null)
        try
        {
          localFileInputStream.close();
        }
        catch (IOException localIOException8)
        {
        }
      if (localInputStreamReader != null)
        try
        {
          localInputStreamReader.close();
        }
        catch (IOException localIOException9)
        {
        }
      if (localBufferedReader != null)
        try
        {
          localBufferedReader.close();
        }
        catch (IOException localIOException10)
        {
        }
    }
    return str1;
  }

  public void writeTxt(String paramString1, String paramString2, String paramString3)
  {
    writeTxt(paramString1, paramString2, paramString3, "UTF-8");
  }

  public void writeTxt(String paramString1, String paramString2, String paramString3, String paramString4)
  {
    PrintWriter localPrintWriter = null;
    try
    {
      File localFile = new File(paramString1);
      if (!localFile.exists())
        localFile.mkdirs();
      localFile = new File(paramString1 + this._$1 + paramString2);
      if ((paramString4 != null) && (!"".equals(paramString4)))
        localPrintWriter = new PrintWriter(localFile, paramString4);
      else
        localPrintWriter = new PrintWriter(localFile);
      localPrintWriter.println(paramString3);
      localPrintWriter.close();
    }
    catch (IOException localIOException)
    {
      localIOException.printStackTrace();
    }
    finally
    {
      if (localPrintWriter != null)
        localPrintWriter.close();
    }
  }

  public void copyDir(String paramString1, String paramString2)
    throws Exception
  {
    FileInputStream localFileInputStream = null;
    FileOutputStream localFileOutputStream = null;
    String str1 = paramString1;
    String str2 = paramString2;
    if (!new File(str2).exists())
      new File(str2).mkdirs();
    File[] arrayOfFile = new File(str1).listFiles();
    for (int i = 0; i < arrayOfFile.length; i++)
    {
      Object localObject;
      if (arrayOfFile[i].isFile())
      {
        arrayOfFile[i].toString();
        localFileInputStream = new FileInputStream(arrayOfFile[i]);
        localFileOutputStream = new FileOutputStream(str2 + System.getProperty("file.separator") + arrayOfFile[i].getName().toString());
        localObject = new byte[5120];
        int j;
        while ((j = localFileInputStream.read((byte[])localObject)) != -1)
          localFileOutputStream.write((byte[])localObject, 0, j);
        localFileOutputStream.flush();
        localFileOutputStream.close();
        localFileInputStream.close();
      }
      else if (arrayOfFile[i].isDirectory())
      {
        localObject = str2 + System.getProperty("file.separator") + arrayOfFile[i].getName();
        copyDir(arrayOfFile[i].getPath(), (String)localObject);
      }
    }
    if (localFileInputStream != null)
      localFileInputStream.close();
    if (localFileOutputStream != null)
      localFileOutputStream.close();
  }

  public String createFolder(String paramString)
  {
    String str = paramString;
    try
    {
      File localFile = new File(str);
      str = paramString;
      if (!localFile.exists())
        localFile.mkdirs();
    }
    catch (Exception localException)
    {
      this._$2 = "创建目录操作出错";
    }
    return str;
  }

  public boolean delFile(String paramString)
  {
    boolean bool = false;
    try
    {
      String str = paramString;
      File localFile = new File(str);
      if (localFile.exists())
      {
        localFile.delete();
        bool = true;
      }
      else
      {
        bool = false;
        this._$2 = (paramString + "<br>删除文件操作出错");
      }
    }
    catch (Exception localException)
    {
      this._$2 = localException.toString();
    }
    return bool;
  }

  public void delFolder(String paramString)
  {
    try
    {
      delAllFile(paramString);
      String str = paramString;
      str = str.toString();
      File localFile = new File(str);
      localFile.delete();
    }
    catch (Exception localException)
    {
      this._$2 = "删除文件夹操作出错";
    }
  }

  public boolean delAllFile(String paramString)
  {
    boolean bool = false;
    File localFile1 = new File(paramString);
    if (!localFile1.exists())
      return bool;
    if (!localFile1.isDirectory())
      return bool;
    String[] arrayOfString = localFile1.list();
    File localFile2 = null;
    for (int i = 0; i < arrayOfString.length; i++)
    {
      if (paramString.endsWith(File.separator))
        localFile2 = new File(paramString + arrayOfString[i]);
      else
        localFile2 = new File(paramString + File.separator + arrayOfString[i]);
      if (localFile2.isFile())
        localFile2.delete();
      if (localFile2.isDirectory())
      {
        delAllFile(paramString + "/" + arrayOfString[i]);
        delFolder(paramString + "/" + arrayOfString[i]);
        bool = true;
      }
    }
    return bool;
  }

  public void copyFile(String paramString1, String paramString2)
  {
    FileInputStream localFileInputStream = null;
    FileOutputStream localFileOutputStream = null;
    try
    {
      int i = 0;
      int j = 0;
      File localFile = new File(paramString1);
      if (localFile.exists())
      {
        localFileInputStream = new FileInputStream(paramString1);
        localFileOutputStream = new FileOutputStream(paramString2);
        byte[] arrayOfByte = new byte[1444];
        while ((j = localFileInputStream.read(arrayOfByte)) != -1)
        {
          i += j;
          localFileOutputStream.write(arrayOfByte, 0, j);
        }
        localFileInputStream.close();
        localFileOutputStream.close();
      }
    }
    catch (Exception localException)
    {
      this._$2 = "复制单个文件操作出错";
    }
    finally
    {
      if (localFileInputStream != null)
        try
        {
          localFileInputStream.close();
        }
        catch (IOException localIOException5)
        {
          localIOException5.printStackTrace();
        }
      if (localFileOutputStream != null)
        try
        {
          localFileOutputStream.close();
        }
        catch (IOException localIOException6)
        {
          localIOException6.printStackTrace();
        }
    }
  }

  public void moveFile(String paramString1, String paramString2)
  {
    copyFile(paramString1, paramString2);
    delFile(paramString1);
  }

  public void moveFolder(String paramString1, String paramString2)
    throws Exception
  {
    copyDir(paramString1, paramString2);
    delFolder(paramString1);
  }

  public String getMessage()
  {
    return this._$2;
  }

  public String getFileExt(String paramString)
  {
    if ((paramString != null) && (paramString.length() > 0))
    {
      int i = paramString.lastIndexOf('.');
      if ((i > 0) && (i < paramString.length() - 1))
        return paramString.substring(i + 1);
    }
    return "";
  }
  public void  createDir(String fpath){
	  Date date = new Date();
		//格式化并转换String类型
		String path=fpath+new SimpleDateFormat("yyyy/MM/dd").format(date);
		//创建文件夹
		File f = new File(path);
		if(!f.exists())
		f.mkdirs(); 
  }
}

/* Location:           D:\tool\RBT\WEB-INF\classes\
 * Qualified Name:     com.rbt.common.util.FileUtil
 * JD-Core Version:    0.6.1
 */