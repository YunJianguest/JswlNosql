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
    <link rel="stylesheet" href="${contextPath}/mvccol/qqFace/css/reset.css">
    
    <link href="${ctx}/mvccol/SweetAlert2/css/sweetalert2.min.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/animo.css" rel="stylesheet"/>
    <script src="${ctx}/mvccol/js/fomatdate1.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/sweetalert2.min.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/promise.js"></script>
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
     .img-100 img {
            width: 100%;
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
                    <div class="pull-left pr-5 pt-2">${entity.nikename}</div>
                    <div class="pull-left pr-5">
                     <c:if test="${empty entity.adminstate}">
                        <div class="pl-5 pr-5 weight100 zi-bai btn-lan-tq"
                             style="height:14px; line-height:17px; margin-top:1px;border-radius:2px;">
                            
                              <font size="1">
                                <c:if test="${not empty entity.level}">
                                    <i class="pr-5">LV</i><i>${entity.level}</i>
                                </c:if>
                                <c:if test="${empty entity.level}">
                                    <i class="pr-5">LV</i><i>0</i>
                                </c:if>

                             </font>
                           
                           </div>
                     </c:if>
                     <c:if test="${entity.adminstate==0}">
                        <div class="pl-5 pr-5 weight100 zi-bai btn-lan-tq"
                             style="height:14px; line-height:17px; margin-top:1px;border-radius:2px;">
                            
                              <font size="1">
                                <c:if test="${not empty entity.level}">
                                    <i class="pr-5">LV</i><i>${entity.level}</i>
                                </c:if>
                                <c:if test="${empty entity.level}">
                                    <i class="pr-5">LV</i><i>0</i>
                                </c:if>

                             </font>
                           
                           </div>
                     </c:if>
                    </div>
                    <c:if test="${entity.stick==1}">
                        <div class="pull-left pr-5">
                            <div class="weight100 zi-bai btn-lan-tq"
                                 style="height:14px; line-height:17px; margin-top:1px;border-radius:2px;padding-left: 3px;padding-right: 3px;">
                                <font size="1">
                                    <i class="fa fa-arrow-up" style="line-height:14px;"></i>
                                </font>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${entity.activity==1}">
                        <div class="pull-left pr-5">
                            <div class="pl-5 pr-5 weight100 zi-bai btn-hong"
                                 style="height:14px; line-height:17px; margin-top:1px;border-radius:2px;">
                                <font size="1">
                                    悬赏
                                </font>
                            </div>
                        </div>
                    </c:if>
                </font>
            </div>
            <div class="zi-6 clear">
                <div class="pt-5 pull-left weight500">
                    <font size="2">
                        <i><fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${entity.createdate}'/></i><i
                            class="pl-10 zi-lan-tq">楼<i>主</i></i>
                    </font>
                </div>
                <!--<div class="pull-right pr-5 pt-3"><i class="fa fa-thumbs-up pr-5"></i>12</div>-->
            </div>
        </div>
        <c:if test="${user.isadmin==true}">
            <font size="2">
                <div class="pull-right position-r weight500">
                    <a href="javascript:operation('${entity._id}',true,'')">
                        <i class="fa fa-chevron-down zi-hui-tq div-group-5" style="line-height:40px;"></i>
                    </a>

                </div>
            </font>
        </c:if>

        <div class="position-a img-wh50 pl-5" style="top:10px; left:0px;"
             onclick="window.location.href='${ctx}/suc/bbs!personalhome.action?custid=${custid }&fromUserid=${fromUserid}&toUserid=${entity.fromUserid}'">
            <c:if test="${not empty entity.headimgurl }">
                <div class="img-wh40 img-bj maring-a border-radius3"
                     style="background-image: url(${filehttp}/${entity.headimgurl})"></div>
            </c:if>
            <c:if test="${empty entity.headimgurl }">
                  <c:if test="${entity.adminstate==1}">
                <div class="img-wh40 img-bj maring-a border-radius3"
                     style="background-image: url(${ctx}/img/admin.jpg)"></div>
               </c:if>
               <c:if test="${entity.adminstate==0}">
                <div class="img-wh40 img-bj maring-a border-radius3"
                     style="background-image: url(${ctx}/mvccol/img/user/weizhuce.jpg)"></div>
               </c:if>
               <c:if test="${empty entity.adminstate}">
                <div class="img-wh40 img-bj maring-a border-radius3"
                     style="background-image: url(${ctx}/mvccol/img/user/weizhuce.jpg)"></div>
               </c:if>
            </c:if>
        </div>

    </div>
    <div class="clear pl-5 pr-5 pt-15">
        <div class="size12 weight500 zi-hei-tq width-10 qjhh" style="line-height: 20px;">
            <font size="2" class="context img-100">
                ${entity.content}
            </font>
        </div>
    </div>
    <!--录制的语音放置处-->
    <c:if test="${not empty entity.voice}">
        <div class="clear pl-5 pr-5 pt-10 pb-10">
            <div class="hang30 pl-5 pr-5 border-radius3 width-3 overflow-hidden line-lu">
                <div class="img-wh18 pull-left pt-4">
                    <img src="img/yuyin.gif" width="100%">
                </div>

                <div class="pull-right zi-hui-tq weight500">
                    <div style="line-height: 30px;">
                        <font size="1">
                            10s
                        </font>
                    </div>
                </div>
            </div>
        </div>

    </c:if>
    <!--图片填写处-->
    <c:forEach items="${entity.picurls}" var="bean">
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

    <div class="pl-5 pr-5">
        <!--发表时的地址-->
        <c:if test="${not empty entity.address}">
            <font size="1">
                <div class="zi-hui-tq pt-10 weight500">
                    <i class="">${entity.address}</i>
                </div>
            </font>
        </c:if>

        <div class="pt-25 pb-10 overflow-hidden">
            <a href="javascript:zanshang_show()">
                <div class="width-3 weight500 border-radius3 zi-bai maring-a btn-cheng txt-c"
                     style="height: 35px; line-height: 35px;">
                    <font size="2">
                        <i class="fa fa-cny pr-5"></i>赞赏
                    </font>
                </div>
            </a>

            <font size="2">
                <div class="txt-c pt-10">
                    <c:if test="${not empty exceptional}">
                        <i class="zi-cheng">${exceptional}</i><i>人赞赏</i>
                    </c:if>
                    <c:if test="${empty exceptional}">
                        <i class="zi-cheng">0</i><i>人赞赏</i>
                    </c:if>
                </div>
            </font>

            <div class="width-7 maring-a pt-10">
                <c:if test="${not empty exclist}">
                    <c:forEach items="${exclist}" var="bean">
                        <div class="col-2 pt-10">
                            <div class="img-wh25 overflow-hidden maring-a border-radius50"><img
                                    src="${filehttp}/${bean.headimgurl}"
                                    width="100%"/></div>
                        </div>
                    </c:forEach>
                </c:if>

            </div>

        </div>

    </div>
    <div class="pt-10 clear">
        <div class="pt-8 bg-hui-tx"></div>
    </div>


    <div class=" line-bottom-92">
        <font size="2">
            <div class="overflow-hidden" style="height35px;line-height:37px;">
                <div class="pull-left weight100 zi-hei-tq">
                    <i class="pl-10"> 全部评论</i>
                </div>
                <a href="#">
                    <div class="pull-right zi-hui-tq pr-10"><i class="fa fa-server pr-5"></i><i class="size12">顺序</i>
                    </div>
                </a>
            </div>
        </font>
    </div>

    <c:if test="${not empty answer}">
        <div class="lb">
            <div class="position-r pl-5 pr-5">

                <div class=" overflow-hidden pull-left" style="padding-left: 50px;">
                    <div class="weight500 pt-15 sl pull-left zi-lan-tq">
                        <font size="2">
                            <div class="pull-left pr-5 pt-2">${answer.name}</div>
                            <div class="pull-left pr-5">
                                <div class="pl-5 pr-5 weight100 zi-bai btn-lan-tq"
                                     style="height:14px; line-height:17px; margin-top:1px;border-radius:2px;">
                                    <c:if test="${not empty answer.level}">
                                        <font size="1">
                                            <i class="pr-5">LV</i><i>${answer.level}</i>
                                        </font>
                                    </c:if>
                                    <c:if test="${empty answer.level}">
                                        <font size="1">
                                            <i class="pr-5">LV</i><i>0</i>
                                        </font>
                                    </c:if>

                                </div>
                            </div>

                        </font>
                    </div>
                    <div class="zi-6 clear">
                        <div class="pt-5 pull-left weight500">
                            <font size="2">
                                <i><fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${answer.createdate}'/></i>
                                <c:if test="${not empty answer.sort}">
                                    <i class="pl-10 zi-lan-tq">${answer.sort}<i>楼</i></i>
                                </c:if>
                                <c:if test="${empty answer.sort}">
                                    <i class="pl-10 zi-lan-tq">0<i>楼</i></i>
                                </c:if>

                            </font>
                        </div>
                        <!--<div class="pull-right pr-5 pt-3"><i class="fa fa-thumbs-up pr-5"></i>12</div>-->
                    </div>
                </div>

                <font size="2">

                    <div class="pull-right zi-hui-tq pr-5 weight500"
                         onclick="spraise('${entity._id}','${answer._id}',this,true)">
                        <c:if test="${not empty answer.praise }">
                            <i class=" fa fa-thumbs-o-up div-group-5" style="line-height: 40px;"></i>赞<i
                                class="pl-2">${answer.praise }</i>
                        </c:if>
                        <c:if test="${empty answer.praise }">
                            <i class=" fa fa-thumbs-o-up div-group-5" style="line-height: 40px;"></i>赞<i
                                class="pl-2">0</i>
                        </c:if>

                    </div>

                    <c:if test="${user.isadmin==true}">
                        <div class="pull-right position-r weight500">
                            <a href="javascript:operation('${answer._id}',false,'${answer.fromUserid}')">
                                <i class="fa fa-chevron-down zi-hui-tq div-group-5" style="line-height:40px;"></i>
                            </a>

                        </div>

                    </c:if>

                </font>

                <div class="position-a img-wh50 pl-5" style="top:15px; left:0px;">
                    <c:if test="${not empty answer.headimgurl}">
                        <div class="img-wh40 img-bj maring-a border-radius3"
                             style="background-image: url(${filehttp}/${answer.headimgurl})"></div>
                    </c:if>
                    <c:if test="${empty answer.headimgurl}">
                        <div class="img-wh40 img-bj maring-a border-radius3"
                             style="background-image: url(${ctx}/mvccol/img/user/weizhuce.jpg)"></div>
                    </c:if>
                </div>

            </div>


            <div class="clear div-group-10 line-bottom overflow-hidden">
                <c:if test="${answer.activity==1}">
                    <div class="pull-left pr-5">
                        <div class="pl-5 pr-5 weight100 zi-bai btn-hong"
                             style="height:14px; line-height:17px; margin-top:1px;border-radius:2px;">
                            <font size="1">
                                最佳答案
                            </font>
                        </div>
                    </div>
                </c:if>

                <div class="size12 weight500 zi-hei-tq" style="line-height: 20px;"
                     onclick="submint('${entity._id}','${answer._id}','')">
                    <font size="2" class="context">
                        ${answer.content}
                    </font>
                </div>
                <c:if test="${not empty answer.voice}">
                    <!--录制的语音放置处-->
                    <div class="clear pt-10 pb-5">
                        <div class="hang30 pl-5 pr-5 border-radius3 width-3 overflow-hidden line-lu">
                            <div class="img-wh18 pull-left pt-4">
                                <img src="img/yuyin.gif" width="100%">
                            </div>
                            <div class="img-wh18 pull-left pt-4">
                                <img src="img/yuyinb.gif" width="100%">
                            </div>
                            <div class="pull-right zi-hui-tq weight500">
                                <div style="line-height: 30px;">
                                    <font size="1">
                                        10s
                                    </font>
                                </div>
                            </div>
                        </div>
                    </div>

                </c:if>


                <c:forEach items="${answer.childlist}" var="beans">
                    <font size="2">
                        <div class="zi-hei-tq pt-3">
                            <div class="pt-7" style="line-height:20px;"
                                 onclick="submint('${entity._id}','${bean._id}','${beans._id}')">
                                <i class="pr-5 zi-lan-tq">${beans.name}:</i><i class="pr-5">回复</i><i
                                    class="pr-5 zi-lan-tq">${answer.name }:</i>
                                <font size="2" class="context">
                                    ${beans.content}
                                </font>
                                <font size="1">
                                    <i class="pl-10 zi-hui"><fmt:formatDate pattern='yyyy-MM-dd HH:mm'
                                                                            value='${beans.createdate}'/></i>
                                </font>
                            </div>
                        </div>
                    </font>


                </c:forEach>


            </div>

        </div>


    </c:if>

    <div id="ajaxdiv"></div>
    <div class="width-10 txt-c zi-hui-wx div-group-10 display-none" id="loading">
        <i class="fa fa-spinner fa-1dx fa-spin2"></i>
    </div>
      <%@include file="/webcom/foot.jsp" %>
</main>

<div class="clear hang50"></div>

<!--底部输入框-->
<div class="position-f width-10 pr-5 bg-bai pt-7 pb-5 shadow-wai cmp640 display-none"
     style="z-index: 2;bottom: 0px;left: 0px;" id="inputsub">

    <div class="hang30 col-1 txt-c zi-hui-tq" id="qqface">
        <i class="fa fa-smile-o fa-1dx" style="line-height: 30px;"></i>
    </div>


    <div class="hang30 pt-5 bg-bai col-7 line-lu border-radius5">
        <input id="comcontent" class="width-10 pl-5 pr-5 zi-hui-tq border-radius5" style="line-height:20px;height:22px;"
               type="text"
               name=""
               placeholder="说点什么">
    </div>

    <font class="weight500" size="2">
        <div class=" col-2 overflow-hidden zi-bai" onclick="submintcancel()">
            <div class="hang30 txt-c btn-hong width-9 maring-a border-radius3" style="line-height:32px;">
                取消
            </div>
        </div>


        <div class=" col-2 overflow-hidden zi-bai" onclick="submitcommentchild()">
            <div class="hang30 txt-c btn-green width-9 maring-a border-radius3" style="line-height:32px;">
                发送
            </div>
        </div>

    </font>

    <div class="clear div-group-5 display-none " id="qqbq">
        <div class="zi-bai bg-cheng weight500 hang30">
            <i style="font-size: 20px;">表情放置处</i>
        </div>
    </div>
</div>


<!--底部三个按钮-->
<div class=" button_foot div-group-10 bg-bai zi-hui shadow-wai cmp640" style="z-index: 1;">
    <a href="${ctx}/suc/bbs!index.action?custid=${custid}&lscode=${lscode}">
        <div class="col-3 line-right">
            <div class="zi-hui-wx weight500 maring-a width-50px">
                <i class=" fa fa-home pr-5"></i>首页<i class="pl-2"></i>
            </div>
        </div>
    </a>
    <font size="2">
        <div class="col-3 line-right">
            <div class="zi-hui-wx weight500 txt-c">
                <c:if test="${not empty exceptional }">
                    <i class=" fa fa-cny pr-5"></i>赏<i class="pl-2">${exceptional }</i>
                </c:if>
                <c:if test="${empty exceptional }">
                    <i class=" fa fa-cny pr-5"></i>赏<i class="pl-2">0</i>
                </c:if>
            </div>

        </div>

        <div class="col-3 line-right">

            <div class="zi-hui-wx weight500 txt-c" onclick="submint('${entity._id }','','',false)">
                <c:if test="${not empty entity.commentcount }">
                    <i class=" fa fa-pencil-square-o pr-5"></i>评<i class="pl-2">${entity.commentcount}</i>
                </c:if>
                <c:if test="${empty entity.commentcount }">
                    <i class=" fa fa-pencil-square-o pr-5"></i>评<i class="pl-2">0</i>
                </c:if>

            </div>

        </div>
        <div class="col-3">

            <div class="zi-hui-wx weight500 txt-c" onclick="spraise('${entity._id}','',this)">
                <c:if test="${not empty entity.praise }">
                    <i class=" fa fa-thumbs-o-up pr-5"></i>赞<i class="pl-2">${entity.praise}</i>
                </c:if>
                <c:if test="${empty entity.praise }">
                    <i class=" fa fa-thumbs-o-up pr-5"></i>赞<i class="pl-2">0</i>
                </c:if>

            </div>

        </div>

    </font>


</div>
 
<!--投诉删除管理弹出层-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="tanchushezhi2">
    <div class="position-r overflow-hidden width-10">

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">

            <div class=" border-radius5 overflow-hidden maring-a width-9_5">
                <a href="javascript:settheanswer()" id="setanswer" style="display: none">
                    <div class="zi-bai line-bottom-c3c3c6 txt-c hang35 bg-bai-8 zi-lan-tq">
                        设置为最佳答案
                    </div>
                </a>
                <a href="javascript:delbbs()" id="delbbs" style="display: none">
                    <div class="zi-bai line-bottom-c3c3c6 txt-c hang35 bg-bai-8 zi-lan-tq">
                        删除帖子
                    </div>
                </a>
                <a href="javascript:delbbscomment()" id="delbbsallcoment" style="display: none">
                    <div class="zi-bai line-bottom-c3c3c6 txt-c hang35 bg-bai-8 zi-lan-tq">
                        清空帖子和回复
                    </div>
                </a>
                <a href="javascript:delcomment()" id="delbbscoment" style="display: none">
                    <div class="zi-bai txt-c hang35 bg-bai-8 zi-lan-tq">
                        删除评论
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

<!--打赏金额弹出层2-->
<div class="fullscreen cmp640 bg-hei-8 overflow-auto display-none div-group-5" id="zanshangtc">
    <div class="width-9 maring-a bg-bai border-radius5" style="margin-top: 30%">
        <div class="hang50 line-height50 txt-c line-bottom weight500 zi-hui-tq">
            <font size="2">
                请选择您要打赏的金额
            </font>
        </div>
        <font size="2">
            <div class=" div-group-10 pb-20 overflow-hidden weight500 yListr3 line-bottom">
                <li class="pt-10 col-3 ">
                    <div class="div3 width-9 maring-a txt-c zi-hui-wx line-lu border-radius3 hang25 line-height23 title">
                        1元
                    </div>
                </li>

                <li class="pt-10 col-3">
                    <div class="div3 width-9 maring-a txt-c zi-hui-wx line-lu border-radius3 hang25 line-height23">
                        2元
                    </div>
                </li>

                <li class="pt-10 col-3">
                    <div class="div3 width-9 maring-a txt-c zi-hui-wx line-lu border-radius3 hang25 line-height23">
                        5元
                    </div>
                </li>
                <li class="pt-10 col-3">
                    <div class="div3 width-9 maring-a txt-c zi-hui-wx line-lu border-radius3 hang25 line-height23">
                        10元
                    </div>
                </li>
                <li class="pt-10 col-3">
                    <div class="div3 width-9 maring-a txt-c zi-hui-wx line-lu border-radius3 hang25 line-height23">
                        30元
                    </div>
                </li>
                <li class="pt-10 col-3">
                    <div class="div3 width-9 maring-a txt-c zi-hui-wx line-lu border-radius3 hang25 line-height23">
                        30元
                    </div>
                </li>
                <li class="pt-10 col-3">
                    <div class="div3 width-9 maring-a txt-c zi-hui-wx line-lu border-radius3 hang25 line-height23">
                        50元
                    </div>
                </li>
                <li class="pt-10 col-3">
                    <div class="div3 width-9 maring-a txt-c zi-hui-wx line-lu border-radius3 hang25 line-height23">
                        100元
                    </div>
                </li>
              
            </div>
        </font>

        <div class="overflow-hidden">
            <font size="2">
                <a href="javascript:zanshang_hide()">
                    <div class="txt-c zi-hui-tq col-6 pt-5 pb-5 line-right">
                        取消
                    </div>
                </a>
                <a href="javascript:moneypay()">
                    <div class="txt-c zi-hui-tq col-6 pt-5 pb-5">
                      微信支付
                    </div>
                </a>
            </font>
        </div>
    </div>
</div>

<!-- 返回顶部代码 -->
<div id="gotop" class="gotop">
    <a href="javascript:this.blur();">
        <div class=" maring-a clear img-wh30 bg-hei-8 zi-bai txt-c border-radius50">
            <i class="fa fa-arrow-up pt-3 fa-1dx"></i>
        </div>
    </a>
</div>

<!--点击小图弹出大图代码-->
<script src="${contextPath}/app/js/touchTouch.jquery.js"></script>
<script src="${contextPath}/mvccol/qqFace/js/jquery.qqFace1.js"></script>
<script>
    $(function () {
        reading('${entity._id}');
        $('#thumbs a').touchTouch();
    });


    $(function () {
        $('#qqface').qqFace({
            id: 'facebox',
            assign: 'comcontent',
            path: '${contextPath}/mvccol/qqFace/arclist/'	//表情存放的路径
        });
        $(".sub_btn").click(function () {
            var str = $("#saytext").val();
            $("#show").html(replace_em(str));
        });
    });
    function zanshang_hide(){
      $("#zanshangtc").hide();
    }
    function zanshang_show(){
      $("#zanshangtc").show();
    }
      $(function () {
            $("#zanshangtc li").click(function () { 
                $("#zanshangtc li").find("div").removeClass("title");
                $(this).find("div").addClass("title ");
                money=$.trim($(this).find("div").html().replace("元","").replace(/[\r\n]/g,""));
           
            })
        })
        
     function  check_task(){
       var submitData = { 
                type:"bbsshare",
            };
            $.post('${ctx}/suc/bbs!ajaxCheckTask.action?custid=${custid}&&lscode=${lscode}', submitData,

                    function (json) { 
                        if (json.state == 0) {
                            var text='分享成功!'; 
                            if(json.expreward>0){
                                text+="经验+"+json.expreward+" "
                            }
                            if(json.jfreward>0){
                                text+="积分+"+json.jfreward
                            } 
                            swal({
                                text: text,
                                timer: 2000,
                                type: 'success',
                                showConfirmButton: false
                            }).then(function () {
                                    },
                                    function (dismiss) {
                                        if (dismiss === 'timer') {

                                        }
                                    }
                            );
                        }  
                    }, "json");
     
     }
</script>
<!--点击小图弹出大图代码结束-->


<!--限制textarea框字数代码-->
<script language="JavaScript">

    function textCounter(field, countfield, maxlimit) {
        // 函数，3个参数，表单名字，表单域积分素名，限制字符；
        if (field.value.length > maxlimit)
        //如果积分素区字符数大于最大字符数，按照最大字符数截断；
            field.value = field.value.substring(0, maxlimit);
        else
        //在记数区文本框内显示剩余的字符数；
            countfield.value = maxlimit - field.value.length;
    }

</script>
<script type="text/javascript">
    if("${entity.adminstate}"!=1){
    	$(".context").each(function () {
            $(this).html(replace_em($(this).html()));
        });
    } 
    ajaxjz(false);
    $(window).scroll(function () {

        var offsetY = $(window).scrollTop();

        var section1 = $("#section1").height();
        if (section1 - offsetY < 600) {
            ajaxjz(true);
        }

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
              check_task();

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