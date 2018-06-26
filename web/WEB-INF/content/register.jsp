<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- saved from url=(0022)http://www.pskjyf.com/ -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="keywords" content="邑联科技,同城建设,微信开发,电商推广,网上商城,一键建站,HTML5,APP开发">
    <meta name="description" content="邑联科技。邑联科技 负责人电话：18191806954，邑联科技 热诚欢迎各界朋友来访洽谈业务!">
    <meta name="applicable-device" content="pc">
    <title>注册</title>
    <link type="text/css" rel="stylesheet" href="pc_gw/pc-wj/reset.css">
    <link type="text/css" rel="stylesheet" href="pc_gw/pc-wj/style.css"> 
    <script src="pc_gw/pc-wj/jquery-1.8.3.min.js"></script>
    <script src="pc_gw/pc-wj/common.js"></script>
    <script src="pc_gw/pc-wj/jquery.slider.js"></script>
    <script src="pc_gw/pc-wj/jquery-runbanner.js"></script>
    <script src="pc_gw/pc-wj/turn4.1.min.js"></script>
</head>
<body style="background:#fff;">﻿
<div class="wrap_header">
    <div class="header">
        <div class="navigation">
            <div class="logo"><a href="#"><img src="pc_gw/pc-wj/logo.png"
                                               alt="" border="0"></a></div>
            <ul>
                <li><a href="http://www.pskjyf.com/">首页</a></li>
                <!--<li><a href="#">功能</a></li>-->
                <li><a href="pc_gw/index-help.html">帮助</a></li>
                <li><a href="pc_gw/index-dl.html">代理</a></li>
                <li><a href="pc_gw/index-tc.html">套餐</a></li>
                <li><a href="pc_gw/index-about.html">关于</a></li>
            </ul>
            <div class="login"><a href="http://www.pskjyf.com/login.action">登录</a><a
                    href="http://www.pskjyf.com/register.action">注册</a></div>
        </div>
    </div>
</div>
<div class="banner_reg">
    <div class="banner_reg_main" style="background:url(pc_gw/images/bg_banner_main.jpg)"></div>
</div>
<div class="bg_reg_main"> 
        <div class="reg_main">
            <div class="title"><i>1</i>

                <h2>账号信息</h2></div>
            <table width="100%" border="0">
                <tbody>
                <tr>
                    <th>用户名</th>
                    <td><input  id="username" type="text" placeholder="请输入用户名" class="focus"/></td>
                </tr>
                <tr>
                    <th>密码</th>
                    <td><input  id="password" type="password" placeholder="请输入密码"/></td>
                </tr>
                <tr>
                    <th>确认密码</th>
                    <td><input  id="repassword" type="password" placeholder="请确认密码"/></td>
                </tr>
                </tbody>
            </table>
            <div class="title"><i>2</i>

                <h2>公司信息</h2></div>
            <table width="100%" border="0">
                <tbody>
                <tr>
                    <th>邮箱</th>
                    <td><input id="email" type="text" placeholder="请输入邮箱，非常重要，找回密码时用"/></td>
                </tr>
                <tr>
                    <th>QQ</th>
                    <td><input id="qq" type="text" placeholder="请填写qq"/></td>
                </tr>
                <tr>
                    <th>电话</th>
                    <td><input id="tel" type="text" placeholder="请输入电话"/></td>
                </tr>
                </tbody>
            </table>
            <input type="submit" value="立即注册" class="btn_reg" onclick="register()"/></div>
         
</div>

<!---底部 begin--->
<div style="display:none"><img src="pc_gw/pc-wj/hezuo.jpg"/></div>
<div class="joinLine">全国招商热线：15719252550</div>
<div class="footer">
    <div class="footer_con">
        <div class="logo"><a href="#" style="background:url(pc_gw/images/logo2.png) no-repeat">国内最大的免费微信第三方平台</a>
        </div>
        <div class="link"><p><a href="#">返回首页</a> |
            <a href="#">申请体验</a> |
            <a href="#">配置接口</a> |
            <a href="#"> 加盟代理</a> |
            <a href="#">套餐资费</a> |
            <a href="#">关于我们</a></p>

            <p> 客服专线：15719252550 QQ：1076631795 邮箱：pskjyfct@sina.com</p>

            <p> 工作时间：周一至周日, 上午9:00-12:00, 下午14:00-18:00
            </p>

            <p>地址：陕西省西安市未央区第五国际c座</p></div>
        <div class="code"><img src="pc_gw/pc-wj/ewm2.jpg" width="124" height="124"></div>
    </div>
</div>
<div class="copyright"> Copyright © 2016 pskjyf.com 版权所有陕ICP备16006817号-1</div>
 
<!---底部 begin--->
<div class="consult" id="consult"></div>
<!--右侧悬浮 end-->
<div class="erwei" title="微信扫一扫"><span class="hudongzhushou">微信扫一扫,体验新功能</span></div>
<!---底部 end--->
<script>
 function  register(){
         var account=$('#username').val();
         var tel=$('#tel').val();
         if(account==''){
          alert("请输入用户名！");
          return;
         }
         if (!(/^1[3|4|5|7|8]\d{9}$/.test(tel))) {
          alert("手机号码有误，请重填");
          return;
         }
         if(CheckMail($('#email').val())&&Checkmima($('#password').val())&&Checkmima($('#repassword').val())){
          if($('#password').val()!=$('#repassword').val()){
             alert("两次输入密码不正确，请重填");
             return;
          }  
          if('${id}'==null){
            alert("请稍后再试！");
            return;
          }
           var submitData = {
    	        password:$('#password').val(),
    	        tel:tel,
    	        account:account,
    	        email:$('#email').val(),
    	        cid:'${id}',
    	        qq:$('#qq').val()
	            };  
          $.post('${ctx}/user/user!ajaxwebsave.action?custid=${custid}', submitData, 
        	    function(json){ 
        	    if(json.state==0){ 
        	      alert("注册成功，请前往邮箱激活账号！");
        	      window.location.href='${ctx}/login.action';
        	     }else if(json.state==2){
        	      alert("用户名已存在");
        	     }else if(json.state==1){
        	      alert("非法操作！");
        	     }
        	  
        	   },"json"); 
         
         };
       
     
    }
function CheckMail(mail) { 
 var filter  =/^(?:\w+\.?)*\w+@(?:\w+\.)*\w+$/;
 if (filter.test(mail)) return true;
 else {
 alert('您的电子邮件格式不正确');
 return false;}
}
function Checkmima(password){
var pa=/[0-9|A-Z|a-z]{6,16}/;
if(pa.test(password)){
return true;
}else{
 alert('您输入的密码不规范，请输入，6-16位的字母或数字');
return false;
}
}
</script>
</body>
</html>