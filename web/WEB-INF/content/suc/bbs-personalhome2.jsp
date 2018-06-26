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
    <title>${title}</title>
    <!-- Resource style -->
    <script src="${contextPath}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/app/css/font-awesome.min.css" rel="stylesheet">
    <link href="${contextPath}/app/css/style_0.css" rel="stylesheet"> 
    <!--点击小图现实大图css代码--> 
    <!--结束-->
    <!--滑动导航-->

    <style>
        .fa-spin2 {
            -webkit-animation: fa-spin 1s infinite linear;
            animation: fa-spin 1s infinite linear
        }

        .dhid {
            width: 60px ! important;
            margin-right: 7px ! important;
        }

        .pb-7 {
            padding-bottom: 7px;
        }

        .yListr1 ul em.title {
            border-bottom: 3px solid #d63333;
            position: relative;
            color: #d63333;
        }

        .yListr2 .biankuang .div2 {
            border: 1px solid #45c01a;
            position: relative;
            color: #45c01a;
        }

        .yListr3 .zhiding .div3 {
            border: 1px solid #45c01a;
            position: relative;
            color: #45c01a;
        }

        .btn-lan-tq {
            background-color: #00a5e0;
        }

        .btn-lan-tq:hover, .btn-lan-tq:focus {
            background-color: #0092c7;
        }

        .pinglunkuang {
            line-height: 22px;
            width: 15px;
            height: 20px;
        }

        .width-50px {
            width: 50px;
        }

        .zi-999999 {
            color: #999999;
        }

        .zi-333333 {
            color: #333333;
        }

        .hang35 {
            height: 35px;
            line-height: 35px;
        }

        .bg-bai-8 {
            background-color: rgba(225, 225, 225, 0.9);
        }

        .line-bottom-c3c3c6 {
            border-bottom: 1px solid #c3c3c6;
        }
        .pl-3pr-3{
            padding-left: 3px;padding-right: 2px;
        }

    </style>
    <!--导航结束-->
    <script>
        var subtype = '';
        var issend = true;
        var fypage = 0;
        var bbsid = '';

        function ft() {
            window.location.href = "${ctx}/suc/bbs!webadd.action?custid=${custid}&lscode=${lscode}&type=" + subtype;
        }
        function replace_em(str) {

            str = str.replace(/\[em_([0-9]*)\]/g, '<img src="${contextPath}/mvccol/qqFace/arclist/$1.gif" border="0" />');
            return str;
        }

        function details(id, fromUserid) {
            window.location.href = "${ctx}/suc/bbs!bbsDetails.action?custid=${custid}&lscode=${lscode}&toUserid=" + fromUserid + "&bmtid=" + id;
        }
        function operation(id) {
            bbsid = id;
            $("#tanchushezhi2").show();
        }
        function operationcancel(id) {
            $("#tanchushezhi2").hide();

        }
        function delbbs() {
            var submitData = {
                id: bbsid
            };
            $.post('${ctx}/suc/bbs!ajaxdelbbs.action?custid=${custid}&lscode=${lscode}', submitData,

                    function (json) {
                        if (json.state == 0) {
                            window.location.href = '${ctx}/suc/bbs!personalhome.action?custid=${custid}&lscode=${lscode}&toUserid=${fromUserid}';
                        } else {

                        }

                    }, "json");
        }
        function delbbscomment() {
            var submitData = {
                id: bbsid
            };
            $.post('${ctx}/suc/bbs!ajaxdelallcoment.action?custid=${custid}&lscode=${lscode}', submitData,

                    function (json) {
                        if (json.state == 0) {
                            window.location.reload();
                        } else {

                        }

                    }, "json");
        }

    </script>
    <script>


        function ajaxjz(fag, fy) {
            $("#loading").show();
            var submitData = {
                type: subtype
            };
            issend = false;
            $.post('${ctx}/suc/bbs!ajaxIndex.action?custid=${custid}&lscode=${lscode}&fypage=' + fy, submitData, function (json) {
                var xszf;
                if (fag) {
                    xszf = $('#ajaxdiv').html();
                } else {
                    xszf = '';
                }
                if (json.state == 0) {
                    var v = json.list;
                    for (var i = 0; i < v.length; i++) {
                         xszf += '<div class="position-r pt-5 pl-5 pr-5">'
                        + '<div class=" overflow-hidden pull-left" style="padding-left: 50px;">'
                        + '<div class="weight500 pt-10 sl pull-left zi-lan-tq">'
                        + '<font size="2"><div class="pull-left pr-5 pt-2">' + v[i].nikename + '</div>'
                        + '<div class="pull-left pr-5 pt-2">'
                        + '<div class="pl-5 pr-5 weight100 zi-bai btn-lan-tq" style="height:14px; line-height:17px; margin-top:1px;border-radius:2px;">';
                        if (v[i].level != null) {
                            xszf += '<font size="1"><i class="pr-5">LV</i><i>' + v[i].level + '</i></font></div></div>';
                        } else {
                            xszf += '<font size="1"><i class="pr-5">LV</i><i>0</i></font></div></div>';
                        }
                        if(v[i].activity ==1){
                        xszf += '<div class="pull-left pr-5 pt-2">'
                             +'<div class="pl-5 pr-5 weight100 zi-bai btn-hong" style="height:14px; line-height:17px; margin-top:1px;border-radius:2px;">'
                             +'<font size="1">悬赏</i></font></div></div>';
                        }
                         if(v[i].stick==1){
                         xszf+='<div class="pull-left pr-5 pt-2">'
                             +'<div class="pl-3pr-3 weight100 zi-bai btn-lan-tq" style="height:14px; line-height:17px; margin-top:1px;border-radius:2px;">'
                             +'<font size="1"><i class="fa fa-arrow-up" style="line-height:14px;"></i></font></div></div>';
                        }

                        
                        xszf+='</font></div>'
                        + '<div class="zi-6 clear"><div class="pt-9 pull-left weight500">'
                        + '<font size="2"><i>' + v[i].createdate + '</i>';
//                        if (v[i].reading == null) {
//                            xszf += '<i class="pl-10">浏览<i>0</i></i>';
//                        } else {
//                            xszf += '<i class="pl-10">浏览<i>' + v[i].reading + '</i></i>';
//                        }
                        xszf += '</font></div></div></div>'
                        + ''
                        + '<div class="position-a img-wh50 pl-5" style="top:15px; left:0px;">';
                        var content = replace_em(v[i].content);

                        if (v[i].headimgurl != null) {
                            xszf += '<div class="img-wh40 img-bj maring-a border-radius3" style="background-image: url(${filehttp}/' + v[i].headimgurl + ')"></div>'

                        } else {
                            xszf += '<div class="img-wh40 img-bj maring-a border-radius3" style="background-image: url(${ctx}/mvccol/img/user/weizhuce.jpg)"></div>'
                        }
                        xszf += '</div><div class="clear pt-15" onclick="details(' + v[i]._id + ',\'' + v[i].fromUserid + '\')">';
                       
                        xszf += '<div class="weight500 width-10 qjhh zi-6 hang-sl-4" style="line-height:20px;">'
                        + '<font size="2">' + content + '</font></div></div>';

                        if (v[i].voice != null) {
                            xszf += '<div class="clear pt-15 zi-hui-tq"><div class="hang30 pl-5 pr-5 border-radius3 width-3 overflow-hidden line-lu">'
                            + '<div class="img-wh18 pull-left pt-4"><img src="${ctx}/mvccol/img/bbs2/yuyin.gif" width="100%"></div>'
                            + '<div class="pull-right weight500"> <div style="line-height: 30px;"><font size="1"> 10s </font></div></div></div></div>';

                        }
                        xszf += '</div><div class="div-group-5 pb-15"><div id="thumbs" class="overflow-hidden">';
                        var picurl = v[i].picurls;
                        if (picurl!=null) {
                            for (var j = 0; j <3; j++) {
                                if (picurl[j]!=''&&typeof(picurl[j])!="undefined") {
                                   if(j==2&picurl.length>3){
                                     xszf += '<i class="col-6 pt-2"><a href="javascript:details(' + v[i]._id + ',\'' + v[i].fromUserid + '\')" class="pull-left position-r" style="background-image:url(${filehttp}' + picurl[j] + ')"><div class="position-a"style="right: 0px; top:0px;"><div class="bg-hei-8 txt-c zi-bai overflow-hidden pr-5 pl-5" style=" height:20px;line-height:20px;"><font size="1"><i class="pr-5">'+(picurl.length-1)+'</i>张</font></div></div></a></i>';
                                   
                                   }else{
                                     xszf += '<i class="col-6 pt-2"><a href="javascript:details(' + v[i]._id + ',\'' + v[i].fromUserid + '\')" class="pull-left position-r" style="background-image:url(${filehttp}' + picurl[j] + ')"></a></i>';
                                   
                                   }
                                  
                                }

                            }
                        }
                        xszf += '</div></div><div class="pl-5 pr-5">';
                        if (v[i].address != null) {
                            xszf += '<font size="1"><div class="zi-lan-tq pt-10 pb-10 weight500">'
                            + '<i class="">' + v[i].address + '</i></div></font>';
                        }

                        xszf += '<div class=" bg-bai zi-hui cmp640"><font size="2">'
                        + '<div class="col-3 line-right">';
                        if (v[i].exceptional != null) {
                            xszf += '<div class="zi-hui-wx weight500 txt-c"><i class=" fa fa-cny pr-5"></i>赏<i class="pl-2">' + v[i].exceptional + '</i></div>';
                        } else {
                            xszf += '<div class="zi-hui-wx weight500 txt-c"><i class=" fa fa-cny pr-5"></i>赏<i class="pl-2">0</i></div>';
                        }
                        xszf += '</div><div class="col-3 line-right">';
                        if (v[i].reading !== null) {
                            xszf += '<div class="zi-hui-wx weight500 maring-a width-50px"><i class=" fa fa-eye pr-5"></i>览<i class="pl-2">' + v[i].reading + '</i></div>';
                        } else {
                            xszf += '<div class="zi-hui-wx weight500 maring-a width-50px"><i class=" fa fa-eye pr-5"></i>览<i class="pl-2">0</i></div>';

                        }
                        xszf += '</div><div class="col-3 line-right" onclick="submint('+v[i]._id+',\''+v[i].fromUserid+'\')">';
                        if (v[i].commentcount != null) {
                            xszf += '<div class="zi-hui-wx weight500 maring-a width-50px"><i class=" fa fa-pencil-square-o pr-5"></i>评<i class="pl-2">' + v[i].commentcount + '</i></div>';
                        } else {
                            xszf += '<div class="zi-hui-wx weight500 maring-a width-50px"><i class=" fa fa-pencil-square-o pr-5"></i>评<i class="pl-2">0</i></div>';

                        }
                        xszf += '</div><div class="col-3">';
                        if (v[i].praise != null) {
                            xszf += '<div class="zi-hui-wx weight500 maring-a width-50px"  onclick="spraise('+v[i]._id+',this)"><i class=" fa fa-thumbs-o-up pr-5"></i>赞<i class="pl-2">' + v[i].praise + '</i></div>';
                        } else {
                            xszf += '<div class="zi-hui-wx weight500 maring-a width-50px"  onclick="spraise('+v[i]._id+',this)"><i class=" fa fa-thumbs-o-up pr-5"></i>赞<i class="pl-2">0</i></div>';

                        }
                        xszf += '</div></font></div></div>'
                        + '<div class="pt-10 clear"><div class="pt-8 bg-hui-tx"></div></div>';


                    }
                    fypage++;
                } else {
                }
                issend = true;
                $('#ajaxdiv').html(xszf);
                $("#loading").hide();
            }, "json");

        }


    </script>
</head>
<body class="bg-bai">
<main class="cmp640">

    <div class="position-r overflow-hidden clear" style="height:150px;">
        <img src="${ctx}/mvccol/img/bbs2/xingkong.jpg" width="100%">

        <div class="position-a width-10 cmp640 bg-hei-5"
             style="height:150px;top: 0px;">
        </div>
        <div class="position-a width-10 cmp640" style="top:30px;left: 0px;">
            <div class="position-r">
                <div class="pl-15 position-a position-r">
                    <div class=" pt-3 img-wh90  border-radius5"
                         style="background-color:  rgba(255, 255, 255, 0.7)">
                        <c:if test="${empty user.headimgurl}">
                            <div class="img-wh80 border-radius5 maring-a img-bj"
                                 style="background-image: url(${ctx}/mvccol/img/user/weizhuce.jpg);width: 84px;height: 84px;"></div>
                        </c:if>
                        <c:if test="${not empty user.headimgurl}">
                            <div class="img-wh80 border-radius5 maring-a img-bj"
                                 style="background-image: url(${filehttp}/${user.headimgurl});width: 84px;height: 84px;"></div>
                        </c:if>

                    </div>

                    <div class="position-a display-none" style="bottom: 0px;left:15px;">
                        <div class="bg-cheng " style="width:80px; height: 15px;"></div>
                    </div>

                </div>

                <div class="zi-bai pt-3" style="padding-left:115px;height:90px;">

                    <div class="weight500">
                        <font size="4">
                            <div class="width-5 maring-a clear sl pull-left">${user.nickname}</div>
                        </font>
                    </div>

                    <div class="pt-5 weight100 clear">
                        <font size="2"><i class="pr-10">帖子${user.bbscount}</i></font>
                    </div>

                    <div class="pt-5">
                        <div class="pull-left img-wh25 display-none">
                            <c:if test="${empty user.levelimgurl}">
                                <img src="${ctx}/mvccol/img/level/weizhuce.png" width="100%">
                            </c:if>
                            <c:if test="${not empty entity.levelimgurl}">
                                <img src="${ctx}/${user.levelimgurl}" width="100%">
                            </c:if>

                        </div>
                        <div class="pull-left pt-5">
                            <font size="1">
                                <div class="pl-5 pr-5 weight100 border-radius3"
                                     style="height:18px; line-height:20px;background-color: #f8a963;">
                                    <i>LV</i><i>${user.level}</i>
                                </div>
                            </font>
                        </div>

                        <div class="pull-left pl-5 pt-5 display-none">
                            <font size="1">
                                <div class="pl-5 pr-5 weight100 border-radius3"
                                     style="height:18px; line-height:20px;background-color: #f88546;">
                                    <i>点赞狂人</i>
                                </div>
                            </font>
                        </div>

                    </div>
                    <div class="clear pt-7">
                        <div class="border-radius5 overflow-hidden bg-hei-8" style="width:100px;height: 4px;">
                            <div class="bg-green border-radius5" style="width:${user.expbl}px;height:4px;"></div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <div class="position-a display-none" style="right:15px;top:60px;">
            <a href="#">
                <div class="hang30 border-radius3 pl-10 pr-10 btn-lan-tq zi-bai weight500">
                    <font size="2">
                        <i class="fa fa-edit pr-5" style="line-height: 32px;"></i><i>修改</i>
                    </font>
                </div>
            </a>
        </div>

    </div>


    <div id="ajaxdiv"></div>
    <div class="width-10 txt-c zi-hui-wx div-group-10 display-none" id="loading">
        <i class="fa fa-spinner fa-1dx fa-spin2"></i>
    </div>

  <%@include file="/webcom/foot.jsp" %>
</main>

<div class="clear hang50"></div>

<%@ include file="/webcom/bbs-foot.jsp" %>


<!--投诉删除管理弹出层-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="tanchushezhi2">
    <div class="position-r overflow-hidden width-10">

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">

            <div class=" border-radius5 overflow-hidden maring-a width-9_5">

                <a href="javascript:delbbs()">
                    <div class="zi-bai line-bottom-c3c3c6 txt-c hang35 bg-bai-8 zi-lan-tq">
                        删除帖子
                    </div>
                </a>
                <a href="javascript:delbbscomment()">
                    <div class="zi-bai line-bottom-c3c3c6 txt-c hang35 bg-bai-8 zi-lan-tq">
                        清空帖子和回复
                    </div>
                </a>


            </div>

            <a href="javascript:operationcancel()">
                <div class="pt-10">
                    <div class="border-radius5 maring-a width-9_5 zi-bai txt-c hang35 bg-bai-8 zi-lan-tq">
                        取消
                    </div>
                </div>
            </a>

        </div>

    </div>
</div>
<!--结束-->
<!-- 返回顶部代码 -->
<div id="gotop" class="gotop">
    <a href="javascript:this.blur();">
        <div class=" maring-a clear img-wh30 bg-hei-8 zi-bai txt-c border-radius50">
            <i class="fa fa-arrow-up pt-3 fa-1dx"></i>
        </div>
    </a>
</div>

<!--点击小图弹出大图代码-->
<script src="${ctx}/app/js/touchTouch.jquery.js"></script>
<script>
    $(function () {
        $('#thumbs a').touchTouch();
    });
</script>
<!--点击小图弹出大图代码结束-->

<!--滑动导航结束-->
<script>
    subtype = '3';
    $(function () {
        ajaxjz(false, 0);
    });
</script>
<script type="text/javascript">
    $(window).scroll(function () {

        var offsetY = $(window).scrollTop();

        var section1 = $("#section1").height();
        if (section1 - offsetY < 600) {
            ajaxjz(true, fypage);
        }

    });

</script>
<%@ include file="/webcom/toast.jsp" %>
<c:if test="${com.zsjf>0}">
  <c:if test="${sczs==1}">
  <%@ include file="/webcom/jfts-page.jsp" %>
  </c:if> 
</c:if>
</body>
</html>