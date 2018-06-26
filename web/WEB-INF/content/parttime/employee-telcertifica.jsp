<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
<%@ include file="/webcom/limit.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>小象兼职</title>
    <!-- Resource style -->
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet">
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <style>
        .btn-26bd93 {
            background-color: #26bd93;
        }

        .btn-26bd93:hover {
            background-color: #21a883;
        }
        .bg-dfdfdf{
            background-color: #dfdfdf;
        }
    </style>
</head>
<body class="lock">
<main class="cmp640">
    <div class="pt-20 pl-10 pr-10 overflow-hidden">
        <div class="col-8 pr-5">
            <div class="bg-dfdfdf pl-5 pr-5 border-radius3 hang40 pt-2">
                <input class="zi-hui txt-l weight500 width-10"
                       style="background-color: transparent;height:35px;line-height:35px;"
                       type="text"
                       name=""
                       value="请填写你的电话号码"
                       onfocus="if(this.value=='请填写你的电话号码'){this.value=''};this.style.color='#aaa';"
                       onblur="if(this.value==''||this.value=='请填写你的电话号码'){this.value='请填写你的电话号码';this.style.color='#aaa';}">
            </div>
        </div>
        <div class="col-4 pull-right">
            <div class="hang40 line-height40 txt-c zi-bai btn-26bd93 border-radius3">获取验证码</div>
        </div>
    </div>

    <div class="pt-20 pl-10 pr-10 overflow-hidden">
        <div class=" pl-5 pr-5 border-radius3 hang40 pt-2 bg-dfdfdf">
            <input class="zi-hui txt-l weight500 width-10" style="background-color: transparent;height:35px;line-height:35px;"
                   type="text"
                   name=""
                   value="请输入你短信中的验证码"
                   onfocus="if(this.value=='请输入你短信中的验证码'){this.value=''};this.style.color='#aaa';"
                   onblur="if(this.value==''||this.value=='请输入你短信中的验证码'){this.value='请输入你短信中的验证码';this.style.color='#aaa';}">
        </div>
    </div>


    <!--没有输入验证码的div-->
    <div class="hang50 line-height50 txt-c ml-10 mr-10 size16 mt-20 weight500 zi-hui bg-dfdfdf border-radius3 display-none">确认验证</div>
    <!--输入验证码后的div-->
    <div class="hang50 line-height50 txt-c ml-10 mr-10 size16 mt-20 weight500 zi-bai btn-26bd93 border-radius3">确认验证</div>


    <div class="pt-40 pl-10 pr-10 txt-c size12 weight500 zi-hui-wx">
        完成手机认证，才可进行提现否则工资无法到账...
    </div>
</main>
</body>
</html>