<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<script type="text/javascript">
  var useragent = navigator.userAgent;
   if (useragent.match(/MicroMessenger/i) != 'MicroMessenger') { 
        // 以下代码是用javascript强行关闭当前页面
       var opened = window.open('about:blank', '_self');
       opened.opener = null;
       opened.close(); 
       
    }
</script> 