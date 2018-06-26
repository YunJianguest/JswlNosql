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
    <title>${title}</title>
    <!-- Resource style -->
    <script src="${contextPath}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/app/css/font-awesome.min.css" rel="stylesheet">
    <link href="${contextPath}/app/css/style_0.css" rel="stylesheet"> 
    <link rel="stylesheet" href="${contextPath}/mvccol/qqFace/css/reset.css">
    <%@ include file="/webcom/toast.jsp" %>
    <!--点击小图现实大图css代码-->
     
    <!--结束-->
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="${contextPath}/mvccol/js/fomatdate.js"></script>
    <style>
        .fa-spin2 {
            -webkit-animation: fa-spin 1s infinite linear;
            animation: fa-spin 1s infinite linear
        }

        .comment {
            width: 680px;
            margin: 20px auto;
            position: relative;
            background: #fff;
            padding: 20px 50px 50px;
            border: 1px solid #DDD;
            border-radius: 5px;
        }

        .comment h3 {
            height: 28px;
            line-height: 28px
        }

        .com_form {
            width: 100%;
            position: relative
        }

        .input {
            width: 99%;
            height: 60px;
            border: 1px solid #ccc
        }

        .com_form p {
            height: 28px;
            line-height: 28px;
            position: relative;
            margin-top: 10px;
        }

        span.emotion {
            width: 42px;
            height: 20px;
            background: url(http://www.16code.com/cache/demos/user-say/img/icon.gif) no-repeat 2px 2px;
            padding-left: 20px;
            cursor: pointer
        }

        span.emotion:hover {
            background-position: 2px -28px
        }

        .qqFace {
            margin-top: 4px;
            background: #fff;
            padding: 2px;
            border: 1px #dfe6f6 solid;
        }

        .qqFace table td {
            padding: 0px;
        }

        .qqFace table td img {
            cursor: pointer;
            border: 1px #fff solid;
        }

        .qqFace table td img:hover {
            border: 1px #0066cc solid;
        }

        #show {
            width: 770px;
            margin: 20px auto;
            background: #fff;
            padding: 5px;
            border: 1px solid #DDD;
            vertical-align: top;
        }

        .title {
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


    </style>
    <script>
        var id = "";
        var comid = "";
        var hfid = "";
        var toUserid = "";
        var comentid = "";
        $(function () {
            $(".yListr1 ul em").click(function () {
                $(this).addClass("title ").siblings().removeClass("title");
            })
        })

        $(function () {
            $(".yListr ul em").click(function () {
                $(this).addClass("yListrclickem ").siblings().removeClass("yListrclickem");
            })
        })

        function xiaoshi() {
            $('#tanchu').hide();
        }
        function xianshi() {
            $('#tanchu').show();
        }


        function shezhixiaoshi() {
            $('#tanchushezhi').hide();
        }
        function shezhixianshi() {
            $('#tanchushezhi').show();
        }


        function shezhixiaoshi2() {
            $('#tanchushezhi2').hide();
        }
        function shezhixianshi2() {
            $('#tanchushezhi2').show();
        }


        var isplay = false;
        function yuyin() {
            if (!isplay) {
                $("#tanchu-yuyin").show();
                isplay = true;
            } else {
                $("#tanchu-yuyin").hide();
                isplay = false;
            }
        }


        var isplay = false;
        function bft() {
            if (!isplay) {
                $("#tanchu-t").show();
                isplay = true;
            } else {
                $("#tanchu-t").hide();
                isplay = false;
            }
        }

        var isplay = false;
        function bfb() {
            if (!isplay) {
                $("#tanchu-b").show();
                isplay = true;
            } else {
                $("#tanchu-b").hide();
                isplay = false;
            }
        }


        var isplay = false;
        function ly() {
            if (!isplay) {
                $("#tanchu-ly").show();
                isplay = true;
            } else {
                $("#tanchu-ly").hide();
                isplay = false;
            }
        }


        //   赞赏输入的数值
        function xiaoshizanshang() {
            $('#zanshangtanchu').hide();
        }
        function xianshizanshang() {
            var lscode = '${lscode}';
            if (lscode == '') {
                alert('请先登录');
                return;
            }
            $('#zanshangtanchu').show();
        }
        function replace_em(str) {
            str = str.replace(/\</g, '&lt;');
            str = str.replace(/\>/g, '&gt;');
            str = str.replace(/\n/g, '');
            str = str.replace(/\[em_([0-9]*)\]/g, '<img src="${contextPath}/mvccol/qqFace/arclist/$1.gif" border="0" />');
            return str;
        }
        function operation(id, bl, Userid) {
            $("#tanchushezhi2").show();
            if (bl) {
                $("#delbbsallcoment").show();
                $("#delbbs").show();
            } else {
                comentid = id;
                toUserid = Userid;
                $("#setanswer").show();
                $("#delbbscoment").show();
            }
        }
        function operationcancel(id) {
            $("#tanchushezhi2").hide();
            $("#delbbsallcoment").hide();
            $("#delbbs").hide();
            $("#setanswer").hide();
            $("#delbbscoment").hide();
        }
        function submitcommentchild() {
            if ($("#comcontent").val() == "说点什么" || $("#comcontent").val().length < 1) {
                alert("评论内容不能为空");
                return;
            }
            var submitData = {
                bmtid: id,
                parentid: comid,
                hfid: hfid,
                content: $("#comcontent").val(),
            };
            $.post('${ctx}/suc/bbs!ajaxAddcomment.action?custid=${custid}&&lscode=${lscode}', submitData,

                    function (json) {
                        if (json.state == 0) { 
                        
                           var text='评论成功!'; 
                            if(json.expreward>0){
                                text+="经验+"+json.expreward+" "
                            }
                            if(json.jfreward>0){
                                text+="积分+"+json.jfreward
                            } 
                            noty({text: text,type:'information', layout: "top", timeout: 1000,callback: { // 回调函数
                            afterClose: function() {
                               window.location.href='${ctx}/suc/bbs!bbsDetails.action?custid=${custid}&lscode=${lscode}&bmtid=${entity._id}';
                            } // 关闭之后
                          },}); 
                           
                        } else {
                            alert("发表失败！");
                        }
                    }, "json");

        }
        function submint(bmtid, mid, hid) {
            id = bmtid;
            comid = mid;
            hfid = hid;
            $("#inputsub").show();
            $("#comcontent").focus().val($("#comcontent").val());
        }
        function submintcancel() {
            $("#inputsub").hide();
        }
        function spraise(id, comid, thi, fag) {
            var bmt = id;
            if (comid != '') {
                bmt = id + "-" + comid;
            }
            var submitData = {
                bmtid: bmt,

            };
            $.post('${ctx}/suc/bbs!bbspraiseAdd.action?custid=${custid}&lscode=${lscode}', submitData,

                    function (json) {
                        if (json.state == 0) {
                            var html = '';
                            if (fag) {
                                html = '<i class=" fa fa-thumbs-o-up div-group-5" style="line-height: 40px;"></i>赞<i class="pl-2">' + (json.value) + '</i>';
                            } else {
                                html = '<i class=" fa fa-thumbs-o-up pr-5"></i>赞<i class="pl-2">' + (json.value) + '</i>';

                            }
                            $(thi).html(html);
                        } else if (json.state == 3) {
                            alert("请先登录！");
                        } else if (json.state == 2) {
                            noty({text: "已经赞过！",type:'alert', layout: "top", timeout: 1000});
                        } else {
                            alert("点赞失败！");
                        }

                    }, "json");

        }
        function reading(id) {

            var submitData = {
                bmtid: id,
            };
            $.post('${ctx}/suc/bbs!bbsReading.action?custid=${custid}&lscode=${lscode}', submitData,

                    function (json) {
                        if (json.state == 0) {
                        } else {

                        }

                    }, "json");


        }
        function exceptional() {
            var price = parseInt($('#exceptionalprice').val());
            if (isNaN(price)) {
                alert('请输入正确的积分数');
                return;
            }
            if ('${user.jf}' < price) {
                alert('您的积分不够');
                return;
            }
            var submitData = {
                type: 'bbs-${entity._id}',
                price: price
            };
            $.post('${ctx}/suc/exceptional!ajaxAdd.action?custid=${custid}&lscode=${lscode}&toUserid=${entity.fromUserid}', submitData,

                    function (json) {
                        if (json.state == 0) {
                            $('#zanshangtanchu').hide();
                            alert("打赏成功！");
                            window.location.href=window.location.href = '${ctx}/suc/bbs!bbsDetails.action?custid=${custid}&lscode=${lscode}&toUserid=${fromUserid}&bmtid=${entity._id}';
                        } else {

                        }

                    }, "json");

        }
        function settheanswer() {
            var submitData = {
                bmtid: '${entity._id}',
                answerid: comentid,
                toUserid: toUserid
            };
            $.post('${ctx}/suc/areward!ajaxreward.action?custid=${custid}&lscode=${lscode}', submitData,

                    function (json) {
                        if (json.state == 0) {
                            window.location.href=window.location.href = '${ctx}/suc/bbs!bbsDetails.action?custid=${custid}&lscode=${lscode}&toUserid=${fromUserid}&bmtid=${entity._id}';
                        } else if (json.state == 2) {
                            alert("已经设置过答案");
                        }

                    }, "json");
        }
        function delcomment() {
            var submitData = {
                id: comentid
            };
            $.post('${ctx}/suc/bbs!ajaxdelcomment.action?custid=${custid}&lscode=${lscode}', submitData,

                    function (json) {
                        if (json.state == 0) {
                            window.location.href=window.location.href = '${ctx}/suc/bbs!bbsDetails.action?custid=${custid}&lscode=${lscode}&toUserid=${fromUserid}&bmtid=${entity._id}';
                        } else {

                        }

                    }, "json");
        }
        function delbbs() {
            var submitData = {
                id: '${entity._id}'
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
                id: '${entity._id}'
            };
            $.post('${ctx}/suc/bbs!ajaxdelallcoment.action?custid=${custid}&lscode=${lscode}', submitData,

                    function (json) {
                        if (json.state == 0) {
                             window.location.href=window.location.href = '${ctx}/suc/bbs!bbsDetails.action?custid=${custid}&lscode=${lscode}&toUserid=${fromUserid}&bmtid=${entity._id}';
                        } else {

                        }

                    }, "json");
        }

        var issend = true;
        var fypage = 0;
        function ajaxjz(fag) {
            $("#loading").show();
            var submitData = {
                bmtid: '${entity._id}'
            };
            issend = false;
            $.post('${ctx}/suc/bbs!ajaxcomment.action?custid=${custid}&lscode=${lscode}&fypage=' + fypage, submitData, function (json) {
                var xszf = '';
                if (fag) {
                    xszf = $('#ajaxdiv').html();
                }

                if (json.state == 0) {
                    var v = json.list;
                    for (var i = 0; i < v.length; i++) {
                        xszf += '<div class="lb"><div class="position-r pl-5 pr-5">'
                        + '<div class=" overflow-hidden pull-left" style="padding-left: 50px;">'
                        + '<div class="weight500 pt-15 sl pull-left zi-lan-tq">'
                        + '<font size="2"><div class="pull-left pr-5 pt-2">' + v[i].name + '</div>'
                        + '<div class="pull-left pr-5">'
                        + '<div class="pl-5 pr-5 weight100 zi-bai btn-lan-tq" style="height:14px; line-height:17px; margin-top:1px;border-radius:2px;">';
                        if (v[i].level != null) {
                            xszf += '<font size="1"><i class="pr-5">LV</i><i>' + v[i].level + '</i></font>';
                        } else {
                            xszf += '<font size="1"><i class="pr-5">LV</i><i>0</i></font>';
                        }
                        xszf += '</div></div></font></div>'
                        + '<div class="zi-6 clear"><div class="pt-5 pull-left weight500">'
                        + '<font size="2"><i>' + Date.prototype.format(v[i].createdate) + '</i>';
                        if (v[i].sort != null) {
                            xszf += '<i class="pl-10 zi-lan-tq">' + v[i].sort + '<i>楼</i></i>';
                        } else {
                            xszf += '<i class="pl-10 zi-lan-tq">0<i>楼</i></i>';
                        }
                        xszf += '</font></div></div></div>'
                        + '<font size="2"><div class="pull-right zi-hui-tq pr-5 weight500" onclick="spraise(${entity._id},' + v[i]._id + ',this,true)">';
                        if (v[i].praise != null) {
                            xszf += '<i class=" fa fa-thumbs-o-up div-group-5" style="line-height: 40px;"></i>赞<i class="pl-2">' + v[i].praise + '</i></div>';
                        } else {
                            xszf += '<i class=" fa fa-thumbs-o-up div-group-5" style="line-height: 40px;"></i>赞<i class="pl-2">0</i></div>';
                        }
                        var bool = '${user.isadmin}';
                        if (bool) {
                            xszf += '<div class="pull-right position-r weight500">'
                            + '<a href="javascript:operation(' + v[i]._id + ',false,\'' + v[i].fromUserid + '\')">'
                            + '<i class="fa fa-chevron-down zi-hui-tq div-group-5" style="line-height:40px;"></i></a>'
                            + '</div>';

                        }
                        xszf += '</font><div class="position-a img-wh50 pl-5" style="top:15px; left:0px;">';
                        if (v[i].headimgurl != null) {
                            xszf += '<div class="img-wh40 img-bj maring-a border-radius3" style="background-image: url(${filehttp}/' + v[i].headimgurl + ')"></div>';
                        } else {
                            xszf += '<div class="img-wh40 img-bj maring-a border-radius3" style="background-image: url(${ctx}/mvccol/img/user/weizhuce.jpg)"></div>';

                        }
                        xszf += '</div></div><div class="clear div-group-10 line-bottom overflow-hidden">'
                        + '<div class="size12 weight500 zi-hei-tq" style="line-height: 20px;" onclick="submint(${entity._id},' + v[i]._id + ',null)">';
                        var content = replace_em(v[i].content);
                        xszf += '<font size="2" class="context">' + content + '</font></div>';
                        var childlist = v[i].commentchildlist;

                        for (var j = 0; j < childlist.length; j++) {
                            xszf += '<font size="2"><div class="zi-hei-tq pt-3">'
                            + '<div class="pt-7" style="line-height:20px;" onclick="submint(${entity._id},' + v[i]._id + ',' + childlist[j]._id + ')">'
                            + '<i class="pr-5 zi-lan-tq">' + childlist[j].name + ':</i><i class="pr-5">回复</i><i class="pr-5 zi-lan-tq">' + v[i].name + ':</i>';
                            var childcontent = replace_em(childlist[j].content);
                            xszf += '<font size="2" class="context">' + childcontent + '</font>'
                            + '<font size="1"><i class="pl-10 zi-hui">' + Date.prototype.format(childlist[j].createdate) + '</i></font>'
                            +'</div></div></font>';
                        }
                        xszf += '</div></div></div>';

                    }
                    fypage++;
                } else {
                }
                issend = true;
                $('#ajaxdiv').html(xszf);
                $("#loading").hide();
            }, "json");


        }
           var money=1; 
           function moneypay() { 
            var remark = '论坛打赏';
            var submitData = {
                lx: 0,
                no: '0',
                name: '',
                type: 'bbs-${entity._id}',
                total:money,
                num: 1,
                price: money,
                remark: remark,
                toUserid:'${entity.fromUserid}'
            }; 
            zanshang_hide();
                $.post('${ctx}/suc/bbs!wxpay.action?custid=${custid}&lscode=${lscode}', submitData,
                        function (json) {
                            if (json.state == 0) {
                                WeixinJSBridge.invoke('getBrandWCPayRequest', {
                                    "appId": json.appId,
                                    "timeStamp": json.timeStamp,
                                    "nonceStr": json.nonceStr,
                                    "package": json.packageValue,
                                    "signType": json.signType,
                                    "paySign": json.paySign
                                }, function (res) {
                                    if (res.err_msg == "get_brand_wcpay_request:ok") {
                                        
                                        noty({text: "打赏成功！",type:'information', layout: "top", timeout: 1000,callback: { // 回调函数
                                              afterClose: function() {
                                       window.location.href = "${ctx}/suc/bbs!bbsDetails.action?custid=${custid}&lscode=${lscode}&bmtid=${entity._id}";
                                              } // 关闭之后
                                            },});
                                        
                                    } else {

                                        //alert(res.err_code+res.err_desc+res.err_msg);
 
                                    }
                                });
                                return;
                            } else if (json.state == 1) {
                                alert("该账号没有开通支付");
                                issend = true;
                            } else if (json.state == 3) {
                                alert("没有登录");
                            }
                        },
                        "json")
           
        }

    </script>

</head>
<body class="bg-bai">
<main class="cmp640" id="section1">

    <div class="position-r pl-5 pr-5">

        <div class=" overflow-hidden pull-left" style="padding-left: 50px;">
            <div class="weight500 pt-10 sl pull-left zi-lan-tq">
                <font size="2">
                    <div class="pull-left pr-5 pt-2"><c:if test="${state==0}">来自${entity.nickname}的邮件</c:if>
                    <c:if test="${state==1}">发给${entity.nickname}的邮件</c:if></div>
                    
                </font>
            </div>
         
        </div>
         
        <div class="position-a img-wh50 pl-5" style="top:10px; left:0px;"
             onclick="window.location.href='${ctx}/suc/bbs!personalhome.action?custid=${custid }&fromUserid=${fromUserid}&toUserid=${entity.fromUserid}'">
            <c:if test="${not empty entity.headimgurl }">
                <div class="img-wh40 img-bj maring-a border-radius3"
                     style="background-image: url(${filehttp}/${entity.headimgurl})"></div>
            </c:if>
            <c:if test="${empty entity.headimgurl }">
                <div class="img-wh40 img-bj maring-a border-radius3"
                     style="background-image: url(${ctx}/mvccol/img/user/weizhuce.jpg)"></div>
            </c:if>
        </div>

    </div>
    <div class="clear pl-5 pr-5 pt-30">
        <div class="size12 weight500 zi-hei-tq width-10 qjhh" style="line-height: 20px;">
            <font size="2" class="context">
                ${entity.content}
            </font>
        </div>
    </div>
   
    <!--图片填写处-->
    <c:forEach items="${fn:split(entity.picurl,',')}" var="bean">
        <c:choose>
            <c:when test="${bean==''}">
            </c:when>
            <c:otherwise>
                <div class="div-group-5">
                    <img src="${filehttp}/${bean}" width="100%">
                </div>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    
    <div class="pt-10 clear">
        <div class="pt-8 bg-hui-tx"></div>
    </div>
 
    
 <%@include file="/webcom/foot.jsp" %>
</main>
 
<!-- 返回顶部代码 -->
<div id="gotop" class="gotop">
    <a href="javascript:this.blur();">
        <div class=" maring-a clear img-wh30 bg-hei-8 zi-bai txt-c border-radius50">
            <i class="fa fa-arrow-up pt-3 fa-1dx"></i>
        </div>
    </a>
</div>

 
<!--点击小图弹出大图代码结束-->
 
<script type="text/javascript">

    $(".context").each(function () {
        $(this).html(replace_em($(this).html()));
    });
    
    wx.config({
        debug: false,
        appId: '${token.appid}',
        timestamp: '${token.timestamp}',
        nonceStr: '${token.noncestr}',
        signature: '${token.signature}',
        jsApiList: ['checkJsApi',
            'onMenuShareTimeline',
            'onMenuShareAppMessage',
            'onMenuShareQQ',
            'onMenuShareWeibo',
            'hideMenuItems',
            'showMenuItems'
        ]
    });
    wx.ready(function () {
        var share = {
            title: '${share.fxtitle}', // 分享标题
            desc: '${share.fxsummary}', // 分享描述
            link: '${share.fxurl}', // 分享链接
            imgUrl: '${filehttp}${share.fximg}', // 分享图标
            success: function () { 

            },
            cancel: function () {

            }
        };
        wx.onMenuShareAppMessage(share);
        wx.onMenuShareTimeline(share);
        wx.onMenuShareAppMessage(share);
        wx.onMenuShareQQ(share);
        wx.onMenuShareWeibo(share);
    });  
</script>
<c:if test="${com.zsjf>0}">
  <c:if test="${sczs==1}">
  <%@ include file="/webcom/jfts-page.jsp" %>
  </c:if> 
</c:if>
</body>
</html>