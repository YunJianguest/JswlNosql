package com.lsp.pub.util;

import com.lsp.sys.security.CustomerUser;
import javax.servlet.http.HttpServletRequest;
import org.springframework.security.Authentication;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.security.providers.preauth.PreAuthenticatedAuthenticationToken;
import org.springframework.security.ui.WebAuthenticationDetails;
import org.springframework.security.userdetails.UserDetails;
/**
 * 工具
 * @author lsp 
 *   
 */
public class SpringSecurityUtils
{
  public static String getCurrentUserName()
  {
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    if (auth == null) {
      return "";
    }
    return auth.getName();
  }

  public static CustomerUser getCurrentUser()
  {
    Object principal = null;
    try {
      principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
       
      if ((principal == null) || ("roleAnonymous".equals(principal)))
        return null;
    }
    catch (Exception e) {
      return null;
    }
    return (CustomerUser)principal;
  }

  public static void saveUserDetailsToContext(UserDetails userDetails, HttpServletRequest request)
  {
    PreAuthenticatedAuthenticationToken authentication = new PreAuthenticatedAuthenticationToken(userDetails, 
      userDetails.getPassword(), userDetails.getAuthorities()); 
    authentication.setDetails(new WebAuthenticationDetails(request));

    SecurityContextHolder.getContext().setAuthentication(authentication);
  }
}