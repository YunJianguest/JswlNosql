<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>500页面</title>
<script type="text/javascript">
var browser={
    versions:function(){
           var u = navigator.userAgent, app = navigator.appVersion;
           return {//移动终端浏览器版本信息
                trident: u.indexOf('Trident') > -1, //IE内核
                presto: u.indexOf('Presto') > -1, //opera内核
                webKit: u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
                gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1, //火狐内核
                mobile: !!u.match(/AppleWebKit.*Mobile.*/)||!!u.match(/AppleWebKit/), //是否为移动终端
                ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
                android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或者uc浏览器
                iPhone: u.indexOf('iPhone') > -1 || u.indexOf('Mac') > -1, //是否为iPhone或者QQHD浏览器
                iPad: u.indexOf('iPad') > -1, //是否iPad
                webApp: u.indexOf('Safari') == -1,//是否web应该程序，没有头部与底部
                weixin:u.indexOf('MicroMessenger')>-1,//是否是微信浏览器
                qq:u.match(/\sQQ/i) == " qq" //是否QQ
            };
         }(),
         language:(navigator.browserLanguage || navigator.language).toLowerCase()
} 
 
function load(){
if(browser.versions.mobile||browser.versions.ios||browser.versions.android){
  var url =window.location.href; 
  url=url.substring(url.indexOf("custid=")+7,url.indexOf("&")); 
  //window.location.href="${ctx}/login.action";  
 // window.location.href="${ctx}/user/fromuser!UserDetail.action?custid="+url;
 }else{
  window.location.href="${ctx}/login.action";
 }  
} 
window.onload=load;
</script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx }/app/css/font-awesome.min.css" rel="stylesheet"> 
    <style>
        .fa-7x {
            font-size: 7em
        }
    </style>
</head>
<body>
<main class="cmp640">
    <div class="clear txt-c zi-hui size14">
        <div class=""style="padding-top: 30%;">
            <i class="fa fa-exclamation-triangle fa-7x"></i>
        </div>
        <div class="pt-50">
            <font size="9">500</font>
        </div>
    </div>
</main>
</body>
</html>