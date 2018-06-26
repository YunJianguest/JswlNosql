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
  <script>
        function erweima_xiaoshi() {
            $('#erweima_tanchu').hide(); 
            window.history.back();
        }
        function erweima_xianshi() {
            $('#erweima_tanchu').show();
        }
    </script>
    <style>
        .zi-26bd93 {
            color: #26bd93;
        }

        .bottom-26bd93 {
            background-color:#26bd93;
        }

        .bottom-26bd93:hover {
            background-color: #21a883;
        }
    </style>
</head>
<body class="lock" style="background-color: #f0f0f0">
<main class="cmp640 pl-5 pr-5">

</main>

<!--点击发私信后提示框-->
<div class="fullscreen cmp640 bg-hei-5 lock" id="erweima_tanchu">
    <div class="overflow-hidden width-10">
        <a href="javascript:erweima_xiaoshi()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>
        <div class=" cmp640 position-f position-r" style="top:30%;left:0px;z-index: 99;">
            <div class="maring-a position-r border-radius3 div-group-10 bg-bai" style="width:290px;">
                <a href="javascript:erweima_xiaoshi()">
                    <div class="position-a" style="right:-10px;top:-10px;z-index: 101;">
                        <div class="img-wh25 border-radius50 bg-hei-5 txt-c">
                            <font size="3">
                                <i class="fa fa-remove zi-bai" style="line-height:27px"></i>
                            </font>
                        </div>
                    </div>
                </a>
                <div class=" width-10 border-radius5 zi-hui-tq overflow-hidden">
                    <font size="2">
                        <div class="weight500">您好:</div>
                        <div class="weight500" style="line-height: 22px;">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp尊敬的：<i
                                class="zi-26bd93">${user.nickname}</i>，只要您分享平台任何页面给您朋友，并且您的朋友成功在平台提现一次您就可获得10元的推荐奖励金，推荐奖励金会存入您的可提现金额里您可以随时进行提现。
                        </div>
                    </font>
                </div>

                <div class="button_group1 width-10 pt-20" onclick="erweima_xiaoshi()">
                    <div class="border-radius3 bottom-26bd93 zi-bai txt-c hang40 line-height40">
                        确认退出
                    </div>
                </div>

            </div>

        </div>
    </div>
</div>

</body>
</html>