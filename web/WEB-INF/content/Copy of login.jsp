<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta property="qc:admins" content="5641314377603321663757" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="keywords" content="邑联科技 ,邑联科技,网站建设,网页制作,电商推广,网上商城,一键建站,HTML5,APP开发"/>
    <meta name="description" content="邑联科技 。邑联科技 负责人电话：18191806954，邑联科技 热诚欢迎各界朋友来访洽谈业务!"/>
    <meta name="applicable-device" content="pc"/>
    <title>邑联科技 </title>
    <!-- Resource style -->
    <link rel="shortcut icon" href="${ctx}/gw/img/bz.png" />
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet">
    <link href="${ctx}/app/css/font-awesome-ie7.min.css" rel="stylesheet">
    <style>

        .hang66 {
            height: 66px;;
        }

        .width1180 {
            width: 1180px;;
        }

        .width100px {
            width: 100px;
            height: 35px;
        line-height: 35px;
        }

        .shadow-wai1 {
            -webkit-box-shadow: 0 0 5px rgba(140, 140, 140, .5);
            -moz-box-shadow: 0 0 5px rgba(140, 140, 140, .5);
            box-shadow: 0 0 5px rgba(140, 140, 140, .5);
        }


        .btn-d {
            background-color: #26a9e1;
        }

        .btn-d:hover {
            border: solid 2px #26a9e1;
            background-color: #ffffff;
            color: #26a9e1;
            line-height: 31px;
        }

        .btn-t {
            border: solid 2px #26a9e1;
            color: #26a9e1;
        }

        .btn-t:hover {
            background-color: #26a9e1;
            color: #ffffff;
        }



        .btn-tb {
            border: solid 1px #ccc;
            color: #666666;
        }

        .btn-tb:hover {
            border: solid 1px #26a9e1;
            background-color: #26a9e1;
            color: #ffffff;
        }
    </style>
</head>
<body>
<form method="post" id="loginform" name="loginForm"   action="j_spring_security_check">
<!--top-->
<div class="shadow-wai1 position-f width-10 bg-bai" style="top: 0px; left: 0px;z-index: 9;">
    <div class="width1180 maring-a hang66">
<a href="http://www.pskjyf.com/">
        <div class="pull-left pt-7">
            <div class="img-bj" style="width: 120px;height: 50px;background-image:url(/gw/img/240x100.png);">
            </div>
        </div>
        <div class="pull-left " style="width:930px;padding-top: 13px;">

            <div class="txt-c zi-6 line-height40 ziti border-radius3 weight500 pull-right">
                <font size="4">
                    <i style="color: #38a0f4">联系我们：</i>18191806954
                </font>
            </div>

            <div class="txt-c zi-6 line-height40 ziti border-radius3 weight500 pull-left">
                <font size="4">
                    邑联科技
                </font>
            </div>

        </div>
</a>

        <div class="pull-right" style="padding-top:15px;">
            <div class="pr-10 pull-left">
                <a href="#">
                    <div class="txt-c border-radius3 weight500 zi-bai btn-d width100px">
                        <font class="size3">
                            后台登录
                        </font>
                    </div>
                </a>
            </div>
            <div class="pr-10 pull-left display-none">
                <a href="#">
                    <div class="txt-c border-radius3 weight500 zi-bai width100px btn-t" style="line-height: 31px;">
                        <font class="size3">
                            免费试用
                        </font>
                    </div>
                </a>
            </div>
        </div>

    </div>
</div>


<div class="maring-a overflow-hidden clear" style="width: 300px;margin-top:180px;">

    <div class="line-lu overflow-hidden border-radius3">
        <font size="2"> 
                <input class="width-10 pl-15 pr-15 zi-hui-tq" style="line-height:42px;height:42px;" type="text"
                      placeholder="平台账号" id="j_username" name="j_username" value="${sessionScope['SPRING_SECURITY_LAST_USERNAME']}"
                      tabindex='1'>
           
        </font>
    </div>

    <div class="line-lu overflow-hidden border-radius3 mt-35">
        <font size="2"> 
                <label>
                    <input class="width-10 pl-15 pr-15 zi-hui-tq" style="line-height:42px;height:42px;" type="password"
                           id="j_password" name="j_password" class="txt_input"
                           placeholder="登录密码"
                           tabindex='2' >
                </label> 
        </font>
    </div>
 
        <div class="txt-c mt-35 border-radius3 weight500 zi-bai btn-d" style="line-height:42px;height:42px;"  onclick='login()'>
            <font class="size3">
                确认登录
            </font>
        </div> 

    <!--第三方登录-->
    <div class="txt-c weight100 display-none" style="margin-top: 80px;"><font size="2">第三方登录</font></div>

    <div class="mt-35 display-none">
        <font size="5">

            <div class="col-4">
                <a href="#" target="_top">
                    <div class="img-wh50 maring-a border-radius50 btn-tb txt-c">
                        <i class="fa fa-qq" style="line-height: 45px;"></i>
                    </div>
                </a>
            </div>

            <div class="col-4">
                <a href="#">
                    <div class="img-wh50 maring-a border-radius50 btn-tb txt-c">
                        <i class="fa fa-weixin" style="line-height: 45px;"></i>
                    </div>
                </a>
            </div>

            <div class="col-4">
                <a href="#">
                    <div class="img-wh50 maring-a border-radius50 btn-tb txt-c">
                        <i class="fa fa-weibo" style="line-height: 45px;"></i>
                    </div>
                </a>
            </div>

        </font>
    </div>

</div>


<!--备案号-->
<div class="txt-c shadow-wai1 bg-hui-tx position-f hang40 zi-hui-tq weight100 width-10" style="bottom:0px;"><font size="2">© 2016 pskjyf.com
    版权所有陕ICP备16006817号-1</font></div>
</form>
<script>
function login(){
  document.getElementById('loginform').submit();
}
function loginqq(){
    var submitData = {  
	                };  
   $.post('${ctx}/login.do', submitData,
        	 
        	 function(json){
        	   alert(json);
        	  
        	 },"json");
      
}
function keydown(e)   
 { var currKey=0,e=e||event;  
   if(e.keyCode==13){
     if($("#j_username").val()==''||$("#j_password").val()==''){
     return;
     }
   document.getElementById('loginform').submit();  
   }
 }  
document.onkeydown=keydown;
</script>
</body>
</html> 
