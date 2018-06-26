package com.lsp.pub.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
/**
 * 工具
 * @author lsp 
 *   
 */
public class SysConfig
{
  private static Properties properties = new Properties();

  static {
    initProperties();
  }

  private static void initProperties()
  {
    Properties props = new Properties();
    try {
      InputStream sysConfig = SysConfig.class.getClassLoader().getResourceAsStream("sys_config.properties");
      props.load(sysConfig);
    }
    catch (IOException e) {
      e.printStackTrace();
    }

    properties = props;
  }

  public static String getProperty(String name)
  {
    String retVal = properties.getProperty(name);
    return retVal;
  }
}