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
    <title>我的</title>
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet">
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <style>

        .hang45 {
            height: 45px;
            line-height: 45px;
        }

        .bg-jin {
            background-color: #e3c06a;
        }

        .pl-90 {
            padding-left: 90px;
        }

        .p-top-left-10 {
            top: 10px;
            left: 10px;
        }

        .hang45 {
            height: 45px;
            line-height: 47px;
        }

        .zi-26bd93 {
            color: #26bd93;
        }

        .bg-26bd93{
            background-color: #26bd93;
        }

        .bottom-26bd93 {
            background-color: white;
        }

        .bottom-26bd93:hover {
            color: #21a883;
        }
    </style>
</head>
<body class="lock">
<main class="cmp640">

    <div class="hang90 overflow-hidden bg-bai width-10 position-r clear">
        <div class="pull-left bg-hui-tx txt-c img-wh70 position-a p-top-left-10 position-r"> 
            <c:if test="${empty user.headimgurl}">
            <img src="${ctx}/mvccol/img/user/weizhuce.jpg" class="width-10 border-radius3"/>
            </c:if>
            <c:if test="${not empty user.headimgurl}">
            <img src="${filehttp}/${user.headimgurl}" class="width-10 border-radius3"/>
            </c:if>
            
        </div>
        <div class="pt-10 pr-10 width-10 pl-90 weight500">
            <div class="hang25 line-height25 zi-hei-tq">
                <div class="col-9 sl">${user.nickname}，ID:${user.no}</div>
            </div>
            <div class="hang20 line-height20 zi-hui-wx">
                <div class="col-9 sl">陕西省 渭南市</div>
            </div>
            <font size="1">
                <div class="hang25 pt-3 line-height25 zi-hui-wx ">
                    <div class="hang20 border-radius3 line-height20 zi-bai bg-hei-5 pl-5 pr-5 pull-left"><i
                            class="fa fa-mobile-phone line-height20 pr-5"></i>手机认证
                    </div>
                    <div class="hang20 border-radius3 line-height20 zi-bai bg-jin bg-hei-5 pl-5 pr-5 pull-left"><i
                            class="fa fa-mobile-phone line-height20 pr-5"></i>手机认证
                    </div>
                </div>
            </font>
        </div>
    </div>

    <div class="hang10 clear bg-hui-92"></div>
    <div class="hang45 lin bg-bai line-bottom-92 zi-hei pr-10 clear weight500 overflow-hidden size14" onclick="window.location.href='${ctx}/parttime/mission!withposi.action?custid=${custid}&lscode=${lscode}'">
        <div class="pull-left div-group-10">
            <div class=" bg-cheng img-wh25 txt-c zi-bai overflow-hidden" style="background-color: #e3c06a">
                <i class="fa fa-gg line-height25"></i>
            </div>
        </div>
        <div class="pull-left hang45">
            我的佣金
        </div>
        <div class="pull-right zi-hui hang45">
            <i class="pr-5 zi-hui">0</i><i class="fa fa-chevron-right hang45"></i>
        </div>
    </div>
    <div class="hang45 bg-bai line-bottom-92 zi-hei pr-10 clear weight500 overflow-hidden size14" onclick="window.location.href='${ctx}/parttime/mission!withposidet.action?custid=${custid}&lscode=${lscode}'">
        <div class="pull-left div-group-10">
            <div class="bj-cheng img-wh25 txt-c zi-bai overflow-hidden">
                <i class="fa fa-calculator line-height25"></i>
            </div>
        </div>
        <div class="pull-left">
            提现记录
        </div>
        <div class="pull-right zi-hui">
            <i class="fa fa-chevron-right hang45"></i>
        </div>
    </div>
    <div class="hang45 bg-bai line-bottom-92 zi-hei pr-10 clear weight500 overflow-hidden size14" onclick="window.location.href='${ctx}/parttime/mission!telcertifica.action?custid=${custid}&lscode=${lscode}'">
        <div class="pull-left div-group-10">
            <div class="img-wh25 txt-c zi-bai overflow-hidden"style="background-color: #e3c06a">
                <i class="fa fa-mobile line-height25"></i>
            </div>
        </div>
        <div class="pull-left">
            手机认证
        </div>
        <div class="pull-right zi-hui ">
            <i class="pr-5 size12">未认证(无法进行工资提现)</i><i class="fa fa-chevron-right hang45"></i>
        </div>
    </div>
    <div class="hang10 clear bg-hui-92"></div>
    <div class="hang45 bg-bai line-bottom-92 zi-hei pr-10 clear weight500 overflow-hidden size14" onclick="window.location.href='${ctx}/parttime/mission!minedata.action?custid=${custid}&lscode=${lscode}'">
        <div class="pull-left div-group-10">
            <div class="bj-lan2 img-wh25 txt-c zi-bai overflow-hidden">
                <i class="fa fa-drivers-license-o line-height25"></i>
            </div>
        </div>
        <div class="pull-left">
            个人资料
        </div>
        <div class="pull-right zi-hui">
            <i class="pr-5 zi-hui size10">未完成</i><i class="fa fa-chevron-right hang45"></i>
        </div>
    </div>
    <c:if test="${entity.type==1}">
    <div class="hang10 clear bg-hui-92"></div>
    <div class="hang45 bg-bai line-bottom-92 zi-hei pr-10 clear weight500 overflow-hidden size14" onclick="window.location.href='${ctx}/parttime/mission!ajaxadd.action?custid=${custid}&lscode=${lscode}'">
        <div class="pull-left div-group-10">
            <div class="bj-lan2 img-wh25 txt-c zi-bai overflow-hidden">
                <i class="fa fa-drivers-license-o line-height25"></i>
            </div>
        </div>
        <div class="pull-left">
            职位发布
        </div>
         
    </div>
    </c:if> 
    <div class="hang10 clear bg-hui-92"></div>
    <div class="hang45 bg-bai line-bottom-92 zi-hei pr-10 clear weight500 overflow-hidden size14" onclick="share_xianshi()">
        <div class="pull-left div-group-10">
            <div class=" bj-lan1 img-wh25 txt-c zi-bai overflow-hidden">
                <i class="fa fa-group line-height25"></i>
            </div>
        </div>
        <div class="pull-left">
            邀请好友
        </div>
        <div class="pull-right zi-hui">
            <i class="pr-5 zi-hui size12">邀请好友可以赚佣金</i><i class="fa fa-chevron-right hang45"></i>
        </div>
    </div>

    <div class="hang10 clear bg-hui-92"></div>
    <div class="hang45 bg-bai line-bottom-92 zi-hei pr-10 clear weight500 overflow-hidden size14">
        <div class="pull-left div-group-10">
            <div class="bj-hong1 img-wh25 txt-c zi-bai overflow-hidden">
                <i class="fa fa-info-circle line-height25"></i>
            </div>
        </div>
        <div class="pull-left size14">
            关于《平台名称》
        </div>
        <div class="pull-right zi-hui">
            <i class="fa fa-chevron-right hang45"></i>
        </div>
    </div>
    <div class="hang45 bg-bai line-bottom-92 zi-hei pr-10 clear weight500 overflow-hidden size14">
        <div class="pull-left div-group-10">
            <div class=" bj-cheng img-wh25 txt-c zi-bai overflow-hidden">
                <i class="fa fa-question-circle-o line-height25"></i>
            </div>
        </div>
        <div class="pull-left">
            常见问题
        </div>
        <div class="pull-right zi-hui">
            <i class="fa fa-chevron-right hang45"></i>
        </div>
    </div>


</main>
<%@include file="/webcom/mission-foot.jsp"%>
<%@include file="/webcom/mission-share.jsp"%>
</body>
</html>