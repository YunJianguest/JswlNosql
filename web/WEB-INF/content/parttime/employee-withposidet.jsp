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
    <title>体现记录</title>
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet">
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <style>
        .zi-26bd93 {
            color: #26bd93;
        }

        .zi-jin {
            color: #e3c06a
        }
    </style>
</head>
<body>
<main class="lock cmp640">

    <div class="txt-c div-group-5 pt-10">

        <div class="line-left1 line-top line-bottom line-right border-radius5">
            <div class="line-bottom zi-6 overflow-hidden txt-c hang50 line-height50 weight500"
                 style="border-radius:5px 5px 0px 0px ;">
                <div class="col-4"><font size="2">提现/充值</font></div>
                <div class="col-5"><font size="2">操作时间</font></div>
                <div class="col-3"><font size="2">金额</font></div>
            </div>
            <!--循环列表开始-->
            <div class="line-bottom zi-6 overflow-hidden txt-c">
                <div class="col-4 pt-15 pb-10 sl">
                    <div class="width-9 maring-a clear sl"><font size="2">提现</font></div>
                </div>
                <div class="col-5 pt-15 pb-10"><font size="2">2015-01-02 13:58</font></div>
                <div class="col-3 pt-15 pb-10 zi-26bd93"><font size="2">-100</font></div>
            </div>
            <div class="line-bottom zi-6 overflow-hidden txt-c">
                <div class="col-4 pt-15 pb-10 sl">
                    <div class="width-9 maring-a clear sl"><font size="2">到账</font></div>
                </div>
                <div class="col-5 pt-15 pb-10"><font size="2">2015-01-02 13:58</font></div>
                <div class="col-3 pt-15 pb-10 zi-jin"><font size="2">+100</font></div>
            </div>
            <!--下面代码不要删除或者循环-->
            <a href="#">
                <div class="zi-hui zi-26bd93 overflow-hidden txt-c"
                     style="border-radius:5px 5px 0px 0px ;">
                    <div class="col-15 pt-15 pb-10"><font size="2">以上是您的提现明细</font></div>
                </div>
            </a>
        </div>
    </div>


</main>
<%@include file="/webcom/mission-foot.jsp"%>
</body>
</html>