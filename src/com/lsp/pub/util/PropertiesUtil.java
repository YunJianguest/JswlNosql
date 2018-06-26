package com.lsp.pub.util;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintStream;
import java.net.URL;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
/**
 * 工具
 * @author lsp 
 *   
 */
public class PropertiesUtil
{
  private Properties _$4 = null;
  private static String _$3;
  private String _$2;
  private String _$1;

  public PropertiesUtil(String paramString)
  {
    this._$1 = paramString;
    this._$2 = (_$1(PropertiesUtil.class) + paramString);
    this._$4 = new Properties();
    try
    {
      BufferedInputStream localBufferedInputStream = new BufferedInputStream(new FileInputStream(this._$2));
      this._$4.load(localBufferedInputStream);
      localBufferedInputStream.close();
    }
    catch (FileNotFoundException localFileNotFoundException)
    {
      localFileNotFoundException.printStackTrace();
    }
    catch (IOException localIOException)
    {
      localIOException.printStackTrace();
    }
  }

  public String readValue(String paramString)
    throws IOException
  {
    return this._$4.getProperty(paramString);
  }

  public void writeData(String paramString1, String paramString2)
  {
    Properties localProperties = new Properties();
    try
    {
      File localFile = new File(this._$2);
      if (!localFile.exists())
        localFile.createNewFile();
      FileInputStream localFileInputStream = new FileInputStream(localFile);
      localProperties.load(localFileInputStream);
      localFileInputStream.close();
      FileOutputStream localFileOutputStream = new FileOutputStream(this._$2);
      localProperties.setProperty(paramString1, paramString2);
      localProperties.store(localFileOutputStream, "Update '" + paramString1 + "' value");
      localFileOutputStream.close();
      FileUtil localFileUtil = new FileUtil();
      String str = localFileUtil.readTxt(this._$2);
      str = str.replace("\\", "");
      localFileUtil.writeTxt(_$1(PropertiesUtil.class), this._$1, str);
    }
    catch (IOException localIOException)
    {
      System.err.println("Visit " + this._$2 + " for updating " + paramString2 + " value error");
    }
  }

  public Map readAllProperties()
    throws FileNotFoundException, IOException
  {
    HashMap localHashMap = new HashMap();
    Enumeration localEnumeration = this._$4.propertyNames();
    while (localEnumeration.hasMoreElements())
    {
      String str1 = (String)localEnumeration.nextElement();
      String str2 = this._$4.getProperty(str1);
      localHashMap.put(str1, str2);
    }
    return localHashMap;
  }

  private static String _$1(Class paramClass)
  {
    String str = null;
    if (System.getProperty("os.name").toLowerCase().indexOf("window") > -1)
      str = paramClass.getResource("/").toString().replace("file:/", "").replace("%20", " ");
    else
      str = paramClass.getResource("/").toString().replace("file:", "").replace("%20", " ");
    return str;
  }

  public static String getRootpath()
  {
    if (_$3 != null)
      return _$3;
    String str = _$1(PropertiesUtil.class).replace("WEB-INF/classes/", "");
    setRootpath(str);
    return str;
  }

  public static String getClassPath()
  {
    return _$1(PropertiesUtil.class);
  }

  public static void setRootpath(String paramString)
  {
    _$3 = paramString;
  }
}

/* Location:           D:\tool\RBT\WEB-INF\classes\
 * Qualified Name:     com.rbt.common.util.PropertiesUtil
 * JD-Core Version:    0.6.1
 */