package com.lsp.sys.security;

import java.util.LinkedHashMap;
/***
 * 资源管理
 * @author lsp
 *
 */
public abstract interface ResourceDetailsService
{
  public abstract LinkedHashMap<String, String> getRequestMap()
    throws Exception;
}