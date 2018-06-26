package com.lsp.pub.util;
/**
 * 工具
 * @author lsp 
 *   
 */
public class FpathUtil
{
  public static String PATH;
  public static String FNAME;

  public static void getNameAndPath(String fpath)
  {
    if (fpath.lastIndexOf("/") > 0) {
      PATH = fpath.substring(fpath.indexOf("/"), fpath.lastIndexOf("/"));
      FNAME = fpath.substring(fpath.lastIndexOf("/") + 1);
    }
  }
}