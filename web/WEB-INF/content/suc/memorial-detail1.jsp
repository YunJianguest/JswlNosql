<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
<%@ include file="/webcom/limit.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="pragma" content="no-cache"/>
    <meta http-equiv="cache-control" content="no-cache"/>
    <meta http-equiv="expires" content="0"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title></title>
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/sweetalert2.min.css" rel="stylesheet"/>
    <script src="${ctx}/mvccol/js/fomatdate1.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/sweetalert2.min.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/promise.js"></script>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <style>
        .line-height32 {
            line-height: 32px;
        }

        .line-bottom-red {
            border-bottom: 3px solid red;
        }

        .zi-3a {
            color: #aaa;
        }

        .div-group-2 {
            padding: 2px;
        }
    </style>
    <script>
        var fypage = 0;
        var state = 1;
        var isappend=true;
        $(function () {
            $(".yListr2 li").click(function () {
                $(this).addClass("line-bottom-red").siblings().removeClass("line-bottom-red");
                state = $(this).attr('id');
                if (state == 1) {
                    fypage = 0;
                    ajaxcom(false);
                    $('#con1').show();
                    $('#con2').hide();
                    $('#con3').hide();
                }
                if (state == 2) {
                    $('#con1').hide();
                    $('#con2').show();
                    $('#con3').hide();
                }
                if (state == 3) {
                    fypage = 0;
                    ajaxeulogy(false);
                    $('#con1').hide();
                    $('#con2').hide();
                    $('#con3').show();
                }
            })
        })
        function ajaxcom(t) {
            if(!isappend){
              return;
            }
            var submitData = {
                id: '${entity._id}'
            };
            isappend=false;
            $.post('${ctx}/suc/memorial!ajaxcommentweb.action?custid=${custid}&lscode=${lscode}&fypage=' + fypage, submitData, function (json) {
                var xszf = '';
                if (t) {
                    xszf = $('#ajaxdiv').html();
                }
                if (json.state == 0) {
                    var v = json.list;
                    for (var i = 0; i < v.length; i++) {
                        xszf += '<div class="position-r pl-5 pr-5"><div class=" overflow-hidden pull-left" style="padding-left:53px;">'
                        + '<div class="weight500 pt-10 sl pull-left zi-hei">'
                        + '<font size="2"><div class="pull-left pr-5">' + v[i].nickname + '</div></font></div>'
                        + '<div class="zi-hui-tq clear"><div class="pt-5 pull-left weight500"><font size="1">'
                        + '<i>' + Date.prototype.format(v[i].createdate) + '</i></font></div></div></div>'
                        + '<font size="2"><div class="pull-right zi-hui-tq pr-5 weight500" onclick="praise(' + v[i]._id + ',this)">';
                        if (v[i].ispraise == true) {
                            xszf += '<i class=" fa fa-thumbs-up div-group-5" style="line-height:30px;"></i><i class="pl-2">' + v[i].sort + '</i>';
                        } else {
                            xszf += '<i class=" fa fa-thumbs-o-up div-group-5" style="line-height:30px;"></i><i class="pl-2">' + v[i].sort + '</i>';
                        }
                        xszf += '</div></font>'
                        + '<div class="position-a img-wh40" style="top:10px; left:10px;">'
                        + '<div class="img-wh40 img-bj maring-a border-radius50" style="background-image: url(${filehttp}/' + v[i].headimgurl + ')"></div>'
                        + '</div></div>'
                        + '<div class="clear div-group-10 pt-10 line-bottom-92 overflow-hidden">'
                        + '<div class="zi-hei" style="line-height: 20px; padding-left: 50px;">';
                        if(v[i].content==null){
                        xszf+= '<font size="2">为您祈福！</font>';
                        }else{
                        xszf+= '<font size="2">' + v[i].content + '</font>';
                        }
                        
                        if (v[i].lscount != null) {
                            xszf += '<div class="pt-10 clear"><font size="1"> 您为故人敬献上<i>' + v[i].lscount + '</i>个贡品:</font></div>';
                        }
                        var lsc = v[i].lstribute;
                        if (lsc != null) {
                            for (var j = 0; j < lsc.length; j++) {
                                xszf += '<div class="col-2 pt-10">'
                                + '<div class="maring-a width-8">';
                                if(lsc[j].logo==null||lsc[j].logo==""){
                                xszf+=' <img src="${filehttp}/' + lsc[j].picurl + '" class="width-10"></div></div>';
                                }else{
                                xszf+=' <img src="${filehttp}/' + lsc[j].logo + '" class="width-10"></div></div>';
                                }
                                
                            }
                        }
                        xszf += '</div></div>';

                    }
                    fypage++;
                    
                } else {
                }
                isappend=true;
                $('#ajaxdiv').html(xszf);
            }, "json");

        }
        function ajaxeulogy(t) {
            if(!isappend){
              return;
            }
            var submitData = {
                id: '${entity._id}'
            };
            isappend=false;
            $.post('${ctx}/suc/memorial!ajaxeulogyweb.action?custid=${custid}&lscode=${lscode}&fypage=' + fypage, submitData, function (json) {
                var xszf = '';
                if (t) {
                    xszf = $('#ajaxeulogy').html();
                }
                if (json.state == 0) {

                    var v = json.list;
                    for (var i = 0; i < v.length; i++) {
                        xszf += '<font size="2">'
                        + '<div class="line-bottom-92 pt-10 pb-5 overflow-hidden" onclick="eulogydetail(' + v[i]._id + ')">'
                        + '<div class="sl weight500 zi-6 col-10">' + v[i].title + '</div>'
                        + '<div class="txt-r zi-hui-tq col-2">'
                        + '<font size="1"></font></div>'
                        + '<font size="1"><div class="pt-5 clear zi-hui-tq">'
                        + '<div class="pull-left">' + Date.prototype.format(v[i].createdate) + '</div>'
                        + '<div class="pull-right">阅读:' + v[i].sort + '</div>'
                        + '</div></font></div></font>';

                    }
                    fypage++;
                   
                } else {
                }
                isappend=true;
                $('#ajaxeulogy').html(xszf);

            }, "json");

        }
        function changedead(v) {
            var id = $(v).attr('id');
            if (id == "dead_name1") {
                $('#dead_name1').hide();
                $('#dead1').hide();
                $('#dead_name2').show();
                $('#dead2').show();
            } else {
                $('#dead_name1').show();
                $('#dead1').show();
                $('#dead_name2').hide();
                $('#dead2').hide();
            }
        }
        function focusupd(v) {
            var submitData = {
                id: '${entity._id}'
            };
            $.post('${ctx}/suc/memorial!ajaxfocusupd.action?custid=${custid}&lscode=${lscode}', submitData, function (json) {

                if (json.state == 0) {
                    //关注成功 
                    swal({ 
                     text: '关注成功！',
                     timer: 2000,
                     type:'success',
                     showConfirmButton: false
                     }).then(function () {}, 
                      function (dismiss) {
                    if (dismiss === 'timer') {
                       var html = '<font size="2"><div class="line-height30"><i class="fa fa-check line-height30 pr-10"></i>已关注</div></font>';
                       $(v).html(html);
                    }
                   }
                  );
                   
                } else {
                    //取消关注
                    
                    swal({ 
                     text: '取消关注！',
                     timer: 2000,
                     type:'warning',
                     showConfirmButton: false
                     }).then(function () {}, 
                      function (dismiss) {
                    if (dismiss === 'timer') {
                       var html = '<font size="2"><div class="line-height30"><i class="fa fa-plus line-height30 pr-10"></i>加关注</div></font>';
                       $(v).html(html);
                    }
                   }
                  );
                   
                }
            }, "json");

        }
        function eulogydetail(id) {
            reading(id);
            window.location.href = '${ctx}/suc/memorial!eulogydetail.action?custid=${custid}&lscode=${lscode}&id=' + id;
        }
        function praise(id, v) {
            var submitData = {
                id: id
            };
            $.post('${ctx}/suc/memorial!praisecom.action?custid=${custid}&lscode=${lscode}', submitData, function (json) {

                if (json.state == 0) {
                    //赞成功 
                      $(v).find('.pl-2').html(json.value);
                      $(v).find('.fa').removeClass('fa-thumbs-o-up');
                      $(v).find('.fa').addClass('fa-thumbs-up');  
                } else {
                    //取消赞
                    $(v).find('.pl-2').html(json.value);
                    $(v).find('.fa').removeClass('fa-thumbs-up');
                    $(v).find('.fa').addClass('fa-thumbs-o-up');
                }
            }, "json");
        }
        function reading(id) {
            var submitData = {
                id: id
            };
            $.post('${ctx}/suc/memorial!readingeulogy.action?custid=${custid}&lscode=${lscode}', submitData, function (json) {

                if (json.state == 0) {

                } else {

                }
            }, "json");
        }
    </script>
</head>
<body>
<main class="cmp640 lock">
    <c:if test="${fn:length(lsdead)==1}">
        <div class="position-r">
            <img src="${filehttp}/${entity.picurl}" class="width-10">
            <div class="position-a zi-bai txt-c" style="top: 10%;left:7%;width:18px;line-height: 20px;">
            <div class="weight500">英雄</div>
            <div class="pt-5 weight500"><c:forEach items="${lsdead}" var="bean" begin="0" end="0">${bean.name}</c:forEach></div>
            </div>
            <c:if test="${isadmin==true}">
            <div class="position-a zi-lan-tq pl-5 pr-5 border-radius3 hang20 btn-bai" style="right: 10px;top: 10px;line-height:22px;"
                 onclick="window.location.href='${ctx}/suc/memorial!deadupd.action?custid=${custid}&lscode=${lscode}&_id=${entity._id}'">
                <font size="2">
                    设置
                </font>
            </div>
            </c:if>
        </div>
    </c:if>
     
    <div class="hang40 line-height40 pl-10 pr-10 bg-hei-8 zi-bai clear">
        <div class="pull-left">亲情值：<i>${entity.familyValues}</i></div>
        <div class="pull-right">馆主：<i>${entity.title}</i></div>
    </div>

    <div class="div-group-10 pl-5 pr-5 overflow-hidden">

        <div class="hang30 border-radius3 bg-hui-tx zi-hong pl-10 pr-5 col-3" style="padding-top: 1px;">
            <font size="1">
                <div style="line-height: 15px;">已关注:<i>${entity.focuscount}</i></div>
                <div style="line-height: 15px;" class="">亲友数:<i>${entity.relativescount}</i></div>
            </font>
        </div>

        <div class="col-8 pull-right">

            <c:if test="${empty isadmin}">
                <div class="hang30 border-radius3 zi-bai pl-5 pr-5 col-5 txt-c" style="background-color: #ef5350;"
                     onclick="focusupd(this)">
                    <c:if test="${empty isfoc}">
                        <font size="2">
                            <div class="line-height30"><i class="fa fa-plus line-height30 pr-10"></i>加关注</div>
                        </font>
                    </c:if>
                    <c:if test="${isfoc==true}">
                        <font size="2">
                            <div class="line-height30"><i class="fa fa-check line-height30 pr-10"></i>已关注</div>
                        </font>
                    </c:if>

                </div>
                <div class="hang30 border-radius3 zi-hei-tq pl-5 pr-5 bg-hui-tx col-5 pull-right txt-c"
                     onclick="window.location.href='${ctx}/suc/memorial!circleweb.action?custid=${custid}&lscode=${lscode}&id=${entity._id}'">
                    <font size="2">
                        <div class="line-height30"><i class="fa fa-group line-height30 pr-10"></i>亲友圈</div>
                    </font>
                </div>
            </c:if>
            <c:if test="${isadmin==true}">
                <div class="hang30 border-radius3 zi-hei-tq pl-5 pr-5 bg-hui-tx col-5 pull-right txt-c"
                     onclick="window.location.href='${ctx}/suc/memorial!circleweb.action?custid=${custid}&lscode=${lscode}&id=${entity._id}'">
                    <font size="2">
                        <div class="line-height30"><i class="fa fa-group line-height30 pr-10"></i>管理亲友</div>
                    </font>
                </div>
            </c:if>

        </div>
    </div>

    <font size="2">
        <div class="clear position-r" style=" z-index:3;">
            <div class="hang40 pt-5 bg-hui-92 weight100 yListr2 zi-hei">
                <li class="button_group1 hang30 line-height32 txt-c line-bottom-red" id="1">
                    首页
                </li>
                <li class="button_group1 hang30 line-height32 txt-c" id="2">
                    简介
                </li>
                <li class="button_group1 hang30 line-height32 txt-c" id="3">
                    悼文
                </li>
            </div>
        </div>
    </font>

    <div id="con1">
        <div class=" line-bottom-92">
            <font size="2">
                <div class="overflow-hidden" style="height:35px;line-height:37px;">
                    <div class="pull-left weight100 zi-hui-tq">
                        <i class="pl-10">亲人悼词</i>
                    </div>
                </div>
            </font>
        </div>

        <div id="ajaxdiv"></div>
    </div>

    <div id="con2" class="display-none">
        <font size="2">
            <div class="position-r">
                <c:if test="${isadmin==true}">
                    <div class="position-a zi-lan-tq" style="right: 10px;top: 15px;"
                         onclick="window.location.href='${ctx}/suc/memorial!deadupd.action?custid=${custid}&lscode=${lscode}&_id=${entity._id}'">
                        <!--双人馆时候点击修改弹出选择框 单人馆直接显示修改页面-->
                        修改
                    </div>
                </c:if>
                
            </div>
            <c:forEach items="${lsdead}" var="bean" begin="0" end="0">
                <div class="clear div-group-10" id="dead1">  
                    <div class="line-bottom div-group-10 line-height30">
                        <div class="">姓名:<i class="pl-10">${bean.name}</i></div>
                        <div class="">籍贯:<i class="pl-10">${bean.nativePlace}</i></div>
                        <div class="">职业:<i class="pl-10">${bean.professional}</i></div>
                        <div class="">生辰:<i class="pl-10">${bean.birthdate}</i></div>
                        <div class="">忌日:<i class="pl-10">${bean.burialdate}</i></div>
                        <div class="">出生地:<i class="pl-10">${bean.birthAddress}</i></div>
                        <div class="">安葬地:<i class="pl-10">${bean.burialAddress}</i></div>
                    </div>

                    <div class="div-group-10 zi-6">
                        <div class="txt-c weight500 pt-10">
                            <font size="2">
                                生平事迹
                            </font>
                        </div>
                        <div class="line-height25 pt-10">
                            ${bean.summary}
                        </div>
                    </div>
                </div>
            </c:forEach>

         

        </font>
    </div>


    <div id="con3" class="display-none">
        <div class=" line-bottom-92">
            <font size="2">
                <div class="overflow-hidden" style="height:35px;line-height:37px;">
                    <div class="pull-left weight100 zi-hui-tq">
                        <i class="pl-10">亲人悼文</i>
                    </div>
                    <div class="pull-right weight100 zi-lan-tq"
                         onclick="window.location.href='${ctx}/suc/memorial!eulogyadd.action?custid=${custid}&lscode=${lscode}&_id=${entity._id}'">
                        <i class="pr-10">写悼文</i>
                    </div>
                </div>
            </font>
        </div>

        <div class="pl-10 pr-10 pt-10" id="ajaxeulogy">


        </div>
    </div>

    <div class="hang60 clear "></div>
</main>
<div class="position-f img-wh50" style="bottom: 10px;right: 10px;z-index: 15;"
     onclick="window.location.href='${ctx}/suc/memorial!commentadd.action?custid=${custid}&lscode=${lscode}&id=${entity._id}'">
    <div class="img-wh50 txt-c line-height50 weight500 zi-bai border-radius50 shadow-wai"
         style="background-color: #ef5350;">
        <font size="2">
            缅怀
        </font>
    </div>
</div>

<script>
    ajaxcom(false);
    $(window).scroll(function () {
        var offsetY = $(window).scrollTop();
        var section1 = $("#section1").height();
        if (section1 - offsetY < 600) {
            if (state == 1) {
                ajaxcom(true);
            } else if (state == 3) {
                ajaxeulogy(true);
            }
            ;

        }
        ;
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
</body>
</html>