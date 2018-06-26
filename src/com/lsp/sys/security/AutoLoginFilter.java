package com.lsp.sys.security;

import com.lsp.pub.util.SpringSecurityUtils;
import java.io.IOException;
import javax.servlet.FilterChain; 
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.security.userdetails.UserDetails;
import org.springframework.security.userdetails.UserDetailsService;
import org.springframework.web.filter.GenericFilterBean;
/***
 * 资源管理
 * @author lsp
 *
 */
public class AutoLoginFilter extends GenericFilterBean
{
  private UserDetailsService userDetailsService;
  protected Logger logger = LoggerFactory.getLogger(getClass());
  private boolean enabled = false;
  private String defaultUserName;

  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
    throws IOException, ServletException
  {
    if ((this.enabled) && (SpringSecurityUtils.getCurrentUser() == null) && (!"".equals(this.defaultUserName)) && (this.defaultUserName != null)) {
      UserDetails userDetails = this.userDetailsService.loadUserByUsername(this.defaultUserName);
      if (userDetails == null) {
        request.getRequestDispatcher("/login!error.action").forward(request, response);
        return;
      }
      SpringSecurityUtils.saveUserDetailsToContext(userDetails, (HttpServletRequest)request);
    }
    chain.doFilter(request, response);
  }

  @Autowired
  public void setUserDetailsService(UserDetailsService userDetailsService) {
    this.userDetailsService = userDetailsService;
  }

  public void setEnabled(boolean enabled) {
    this.enabled = enabled;
  }

  @Required
  public void setDefaultUserName(String defaultUserName) {
    this.defaultUserName = defaultUserName;
  }
}