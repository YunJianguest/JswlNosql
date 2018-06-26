<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
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
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet">
    <link href="${ctx}/app/css/font-awesome-ie7.min.css" rel="stylesheet">
    <link href="${ctx}/app/css/style_0.css" rel="stylesheet"> 
    <link href="${ctx}/mvccol/css/css3_dh.css" rel="stylesheet" type="text/css">
    <!-- Resource style -->
    <link href="${ctx}/app/css/time.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${ctx}/app/js/date.js"></script>
    <script type="text/javascript" src="${ctx}/app/js/iscroll.js"></script>
    <script src="${ctx}/app/js/main.js"></script>
    <script type="text/javascript" src="${ctx}/app/js/swipe.js"></script>
    <script src="${ctx}/mvccol/js/mtlb.js"></script>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script type="text/javascript" src="${ctx }/app/js/bbsSwipe.js"></script>

    <style>
        .yqbtn {
            background-color: #ffffff;
            color: #ef8200;
        }

        .yqbtn:hover {
            background-color: #ef8200;
            color: #ffffff;
        }

        .yqbtn1 {
            background-color: #ffffff;
            color: limegreen;
        }

        .yqbtn1:hover {
            background-color: limegreen;
            color: #ffffff;
        }

        .bg-bai-8 {
            background-color: rgba(225, 225, 225, 0.9);
        }

        .line-bottom-c3c3c6 {
            border-bottom: 1px solid #c3c3c6;
        }
    </style>
    <!--Return to the top-->
    <script>
        $(document).ready(function () {

            var _objscroll = {
                win: $(window),
                doc: $(document),
                gotopdiv: $('#gotop')
            };
            _objscroll.win.scroll(function () {
                if (_objscroll.win.scrollTop() > _objscroll.win.height()) {
                    _objscroll.gotopdiv.show();
                } else {
                    _objscroll.gotopdiv.hide();
                }
            });

            _objscroll.gotopdiv.click(function () {
                _objscroll.win.scrollTop(0);
                return false;
            });
        });
        function search() {
            location.href = "${contextPath}/mvccol/search!web.action?type=company&toUser=${toUser}";
        }
        var issend = true;
        var fypage =${fypage};
        var xszf = "";
        var type = "";
        function ajaxjz(v, tag, sel) {//加载 
            if (!issend) {
                return;
            }
            if (sel) {
                fypage = 0;
                $("#zxdh").html("搜索结果");
            }
            if (v != '') {
                fypage = 0;
            }
            var submitData = {
                sel: $('#sel').val().replace('请输入名称或关键字', '')
            };
            issend = false;
            $.post('${ctx}/suc/house!ajaxweb.action?custid=${custid}&lscode=${lscode}&type=' + v + '&fypage=' + fypage, submitData,
                    function (json) {
                        var xszf = '';
                        if (tag) {
                            xszf = $('#ajaxdiv').html();
                        }
                        if (json.state == '0') {
                            var v = json.list;
                            for (var i = 0; i < v.length; i++) {
                                var tels = v[i].tel;
                                if (tels != null && tels.indexOf(",") > 0) {
                                    tels = tels.substring(0, tels.indexOf(","));
                                }
                                if (tels == null) {
                                    tels = "暂无";
                                }
                                xszf += '<div class="col-12 btn-bai pt-7 pb-5 hang60 line-bottom-92 overflow-hidden" style="line-height:20px;">'
                                + '<a href="javascript:tzurl(' + v[i]._id + ',' + fypage + ',\'' + v[i].toUser + '\',\'' + type + '\')">';
                                if (v[i].logo != null) {
                                    xszf += '<div class="pull-left pl-15"><div class=" maring-a clear img-wh45 img-bj  zi-bai txt-c border-radius50 " style="background-image:url(${filehttp}/' + v[i].logo + ');"></div></div>';
                                } else {
                                    xszf += '<div class="pull-left pl-15"><div class=" maring-a clear img-wh40  zi-hui txt-c border-radius50"><i class="fa fa-leaf fa-2dx line-height40"></i> </div></div>';
                                }
                                xszf += '<div class="pull-left pt-5 pl-15 col-8"><div class="zi-hei size14 sl width-10">' + v[i].name + '</div>'
                                + '<div class="zi-hui size12 sl"><font size="0.8">' + tels + '</font></div></div></a>'
                                + '<a href="tel:' + tels + '"><div class="pull-right pr-20 pt-3"><div class=" maring-a clear img-wh40 txt-c border-radius50"><i class="fa fa-phone pt-7 fa-2x" style="color: limegreen"></i>'
                                + '</div></div></a></div>';

                            }
                            fypage++;
                        } else {
                        }
                        issend = true; 
                        $('#ajaxdiv').html(xszf);
                        
                    }, "json")
        }
        function ajaxzr() {//加载

            var submitData = {};
            $.post('${ctx}/suc/house!ajaxzrweb.action?custid=${custid}&lscode=${lscode}', submitData,
                    function (json) {
                        var xszf = '';
                        if (json.state == '0') {
                            var v = json.list;
                            for (var i = 0; i < v.length; i++) {
                                var tels = v[i].tel;
                                if (tels != null && tels.indexOf(",") > 0) {
                                    tels = tels.substring(0, tels.indexOf(","));
                                }
                                if (tels == null) {
                                    tels = "暂无";
                                }
                                xszf += '<div class="col-12 btn-bai pt-7 pb-5 hang60 line-bottom-92 overflow-hidden" style="line-height:20px;">'
                                + '<a href="javascript:tzurl(' + v[i]._id + ',' + fypage + ',\'' + v[i].toUser + '\',\'' + type + '\')">';
                                if (v[i].logo != null) {
                                    xszf += '<div class="pull-left pl-15"><div class=" maring-a clear img-wh45 img-bj  zi-bai txt-c border-radius50 " style="background-image:url(${filehttp}/' + v[i].logo + ');"></div></div>';
                                } else {
                                    xszf += '<div class="pull-left pl-15"><div class=" maring-a clear img-wh40  zi-hui txt-c border-radius50"><i class="fa fa-leaf fa-2dx line-height40"></i> </div></div>';
                                }
                                xszf += '<div class="pull-left pt-5 pl-15 col-8"><div class="zi-hei size14 sl width-10">' + v[i].name + '</div>'
                                + '<div class="zi-hui size12 sl"><font size="0.8">' + tels + '</font></div></div></a>'
                                + '<a href="tel:' + tels + '"><div class="pull-right pr-20 pt-3"><div class=" maring-a clear img-wh40 txt-c border-radius50"><i class="fa fa-phone pt-7 fa-2x" style="color: limegreen"></i>'
                                + '</div></div></a></div>';

                            }

                        } else {
                        }

                        $('#ajaxdivzr').html(xszf);

                    }, "json")
        }
        function getcom(v) {
            type = v;
            fypage = 0;
            ajaxjz(v, false);
        }
        function tzurl(id, fy, type) {
            window.history.pushState(new Date().getTime(), "${title}", "${ctx}/suc/house!web.action?type=" + type + "&custid=${custid}&lscode=${lscode}" + "&fypage=" + fy);
            window.location.href = "${ctx}/suc/house!webDetail.action?_id=" + id + "&custid=${custid}&lscode=${lscode}";
        }
    </script>
</head>
<body>
<main class="cmp640">

    <div class="pt-10 pb-10 pr-10 overflow-hidden pl-3 cmp640 bg-bai position-f width-10"style="z-index: 99;left: 0px;">
        <a href="javascript:shezhixianshi2()">
            <div class=" overflow-hidden border-radius5 col-1">
                <div class="txt-c zi-hui hang30">
                    <i class="fa fa-reorder fa-1dx line-height30"></i>
                </div>
            </div>
        </a>

        <div class=" pl-3 col-11">
            <div class=" overflow-hidden border-radius5">
                <div class="col-10 bg-hui-tx hang30">
                    <input class=" width-10 txt-c line-height30 zi-hui" style="background-color: transparent"
                           type="text"
                           name=""
                           id="sel"
                           value="请输入名称或关键字" onfocus="if(value=='请输入名称或关键字'){value=''}"
                           onblur="if (value ==''){value='请输入名称或关键字'}">
                </div>
                <a href="javascript:ajaxjz('',false,true);">
                    <div class="col-2 txt-c bg-hui-tx hang30">
                        <i class="fa fa-search line-height30 zi-hui"></i>
                    </div>
                </a>
            </div>
        </div>
    </div>
    <div class="hang50 clear"></div>

    <c:if test="${not empty slide}">
        <div id="banner_box" class="box_swipe overflow-hidden position-r" style="width:100%">
            <ul>
                <c:forEach items="${slide}" var="bean">
                    <li>
                        <a href="${bean.url}">
                            <img src="${filehttp}/${bean.picurl}" alt="1" style="width:100%;"/>
                        </a>
                    </li>
                </c:forEach>
            </ul>

        </div>

        <script>
            $(function () {
                new Swipe(document.getElementById('banner_box'), {
                    speed: 500,
                    auto: 3000,
                    callback: function () {
                        var lis = $(this.element).next("ol").children();
                        lis.removeClass("on").eq(this.index).addClass("on");
                    }
                });
            });
        </script>
    </c:if>

    <div class="pl-15 clear div-group-10 pt-5 pb-5 size14 bg-hui-tx">
        <!--<i class="fa fa-fire pr-5"></i>-->
            <span class="size12">
            热门电话
            </span>
    </div>
    <div class="zi-hui line-bottom-98 " id="ajaxdivzr">
    </div>
    <div class="pl-15 clear div-group-10 pt-5 pb-5 size14 bg-hui-tx">
        <!--<i class="fa fa-fire pr-5"></i>-->
            <span class="size12" id="zxdh">
           最新电话
            </span>
    </div>
    <div class="zi-hui line-bottom-98 " id="ajaxdiv">
    </div>
    <%@include file="/webcom/foot.jsp" %>
    <%@include file="/webcom/return-top.jsp" %>
</main>

<div class="clear hang50"></div>
<%@ include file="/webcom/house-foot.jsp" %>
<!--黄页分类-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="tanchushezhi2">
    <div class="overflow-hidden width-10">
        <a href="javascript:shezhixiaoshi2()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5">
                <c:forEach items="${type}" var="bean">
                    <c:if test="${empty bean.url}">
                        <a href="javascript:ajaxjz('${bean.coding}',false,false),shezhixiaoshi2('${bean.title}')">
                            <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                                ${bean.title}
                            </div>
                        </a>
                    </c:if>
                    <c:if test="${not empty bean.url}">
                        <a href="${bean.url}">
                            <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                                ${bean.title}
                            </div>
                        </a>
                    </c:if>
                </c:forEach>
            </div>
            <a href="javascript:shezhixiaoshi2()">
                <div class="pt-10">
                    <div class="border-radius5 maring-a width-9_5 zi-bai txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                        取消
                    </div>
                </div>
            </a>
        </div>
    </div>
</div> 
<script> 
    function shezhixiaoshi2(v) {
        $("#zxdh").html(v);
        $('#tanchushezhi2').hide();
    }
    function shezhixianshi2() {
        $('#tanchushezhi2').show();
    }
</script>
<script type="text/javascript">
    ajaxjz('', false, false);
    ajaxzr();
    $(window).scroll(function () {
        var offsetY = $(window).scrollTop();
        var section1 = $("#section1").height();
        if (section1 - offsetY < 700) {
            ajaxjz(type, true, false);
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