<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport"
          content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>${title}</title>
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/app/css/font-awesome.min.css" rel="stylesheet">
    <link href="${contextPath}/mvccol/yj/activity-style.css" rel="stylesheet" type="text/css"> 
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    
</head> 
<body class="cmp-640">
 
</body>
<script> 
 var state='${state}';
 if(state==''||state==null){
   alert("您还未中奖，请继续努力！");
   window.location.href = '${ctx}/suc/luckydraw!reward.action?custid=${custid}&lscode=${lscode}';
 }else if(state==0){
  alert("兑奖成功！恭喜您中了"+'${jp}');
   window.location.href = '${ctx}/suc/luckydraw!reward.action?custid=${custid}&lscode=${lscode}';
 }else if(state==4){
  alert("您已经兑过奖品了，不能重复兑奖！恭喜您中了"+'${jp}');
   window.location.href = '${ctx}/suc/luckydraw!reward.action?custid=${custid}&lscode=${lscode}';
 }else if(state==3){
  alert("您的奖品已过期！恭喜您中了"+'${jp}');
   window.location.href = '${ctx}/suc/luckydraw!reward.action?custid=${custid}&lscode=${lscode}';
 }else if(state==1){
  alert("您还未中奖，请继续努力！");
   window.location.href = '${ctx}/suc/luckydraw!reward.action?custid=${custid}&lscode=${lscode}';
 }
</script>
</html>