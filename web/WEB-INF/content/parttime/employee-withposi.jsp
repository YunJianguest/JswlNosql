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
    </style>
</head>
<body class="cmp640">
<main>
    <div class=" pull-right zi-lan-tq div-group-10">
        提现明细
    </div>
    <div class="clear img-wh110 txt-c maring-a border-radius50"
         style="background-color:#fbdf66;color: #f9ca01;border: solid 7px #f9ca01;">
        <i class="fa fa-diamond fa-4x" style="line-height: 96px;"></i>
    </div>
    <font size="3">
        <div class="txt-c pt-10">我的佣金</div>
        <div class="pt-10 weight500 txt-c" style="color:#f9ca01">￥1555</div>
    </font>


    <div class="width-9 maring-a">
        <div class="txt-c pt-15 zi-hui-wx">提现微信账号：忧郁的乌龟</div>
        <div class="pt-15 txt-c">提现金额￥
            <input class=" size14 zi-hui weight500 txt-c line-bottom"style="width:70px;" type="text" name=""
                   value="100" onfocus="if(value=='100'){value=''}"
                   onblur="if (value ==''){value='100'}">
        </div>
    </div>

    <div class="pt-20">
        <div class="hang50 weight500 txt-c size16 width-9 maring-a border-radius5 line-height50 zi-bai btn-26bd93">
            提现
        </div>
    </div>

    <div class="txt-c hang40 zi-hui-wx line-height40">
        <font size="1">
            1小时之内到账无手续费
        </font>
    </div>

</main>
<%@include file="/webcom/mission-foot.jsp"%>
</body>
</html>