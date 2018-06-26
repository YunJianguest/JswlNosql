<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
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
    <title></title>
    <!-- Resource style -->
    <script src="${contextPath}/app/js/jquery-1.8.3.js"></script>
    <link href="${contextPath}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/app/css/font-awesome.min.css" rel="stylesheet">
    <script>
        $(function () {
            $(".yListr2 li").click(function () {
                $(this).addClass("zi-hong").siblings().removeClass("zi-hong");
            })
        })
    </script>
    <style>
        .line-left-green {
            border-left: 3px solid #45c01a;
        }
        .line-height37{
            line-height: 37px;
        }
    </style>
</head>
<body>
<main class="cmp640">
    <%--<div class="hang40 pt-5 line-bottom weight100 yListr2 zi-hui-tq">--%>
        <%--<li class="button_group1 hang30 line-height30 txt-c line-right weight500">--%>
            <%--职位详情--%>
        <%--</li>--%>
        <%--<li class="button_group1 hang30 line-height30 txt-c weight500"--%>
            <%--onclick="window.location.href='${ctx}/suc/jobcompay!webDetail.action?custid=${custid }&lscode=${lscode}&_id=${entity.com._id}'">--%>
            <%--公司简介--%>
        <%--</li>--%>
    <%--</div>--%>
    <div class="div-group-10">
        <font size="4">
            <div class="line-height25 zi-hei pt-5">
                ${entity.title}
            </div>
        </font>

        <div class="pt-15 pb-5 zi-hui overflow-hidden">
            <font size="2">
                <div class="txt-l col-7">
                    发布时间：<i><fmt:formatDate pattern='yyyy-MM-dd HH:mm:ss' value='${entity.createdate}'/></i>
                </div>
                <div class="txt-r col-5">
                    <c:if test="${not empty entity.sort}">
                        <i>关注度:${entity.sort}</i>
                    </c:if>
                    <c:if test="${empty entity.sort}">
                        <i>关注度:0</i>
                    </c:if>
                </div>
            </font>
        </div>
    </div>
    <div class="hang7 overflow-hidden bg-hui clear"></div>

    <div class="div-group-10">
        <font size="4">
            <div class="line-height25 zi-hong pt-10">
                薪资待遇：${entity.salary}
            </div>
        </font>

        <div class="pt-15 pb-5 line-height37 zi-hui overflow-hidden">
            <font size="3">
                <div><i class="zi-hei">公司名称：</i>${entity.com.title}</div>
                <div><i class="zi-hei">工作地点：</i>${entity.workaddress}</div>
                <div><i class="zi-hei">招聘人数：</i>招聘${entity.pcount}人</div>
                <div><i class="zi-hei">招聘条件：</i>${entity.record}<i class="pl-5 pr-5">|</i>经验${entity.experience}</div>
            </font>
        </div>
    </div>
    <div class="hang7 overflow-hidden bg-hui clear"></div>
    <div class="div-group-10">
        <div class="zi-hei overflow-hidden">
            <font size="3">
                <div class="hang40 line-height40">联系人：${entity.com.linkman}</div>
                <div class="hang40">
                    <div class="pull-left line-height40">联系电话：${entity.com.tel}</div>
                    <div class="pull-right pt-2" onclick="window.location.href='tel:${entity.com.tel}'">
                        <div class="clear img-wh35 line-height37 btn-green txt-c border-radius50">
                            <i class="fa fa-phone zi-bai line-height37"></i>
                        </div>
                    </div>
                </div>
            </font>
        </div>
    </div>
    <div class="hang7 overflow-hidden bg-hui clear"></div>

    <font size="2">
        <div class="div-group-5 pt-10 pb-10 line-bottom">
            <div class="line-left-green"><i class="pl-10">职位描述</i></div>
        </div>
        <div class="div-group-10">
            ${entity.summary}
        </div>

    </font>

</main>
<div class="clear hang50"></div>
<%@ include file="/webcom/jobcompay-foot.jsp" %>
</body>
</html>