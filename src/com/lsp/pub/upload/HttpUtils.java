package com.lsp.pub.upload;
/**
 * http工具
 * @author lsp 
 *   
 */
public class HttpUtils
{
  public static boolean isEmpty(String value)
  {
    return (value == null) || ("".equals(value));
  }

  public static long toLong(String value, long def)
  {
    if (isEmpty(value)) {
      return def;
    }
    try
    {
      return Long.valueOf(value).longValue();
    } catch (NumberFormatException e) {
      e.printStackTrace();
    }return def;
  }

  public static int toInt(String value, int def)
  {
    if (isEmpty(value))
      return def;
    try
    {
      return Integer.valueOf(value).intValue();
    } catch (NumberFormatException e) {
      e.printStackTrace();
    }return def;
  }
}