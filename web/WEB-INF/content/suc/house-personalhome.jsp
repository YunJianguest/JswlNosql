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
            }
            if (v != '') {
                fypage = 0;
            }
            var submitData = {
                sel: $('#sel').val().replace('请输入名称或关键字', '')
            };
            issend = false;
            $.post('${ctx}/suc/house!ajaxpersonalhome.action?custid=${custid}&lscode=${lscode}&type=' + v + '&fypage=' + fypage, submitData,
                    function (json) {
                        var xszf = '';
                        if (tag) {
                            xszf = $('#ajaxdiv').html();
                        }
                        if (json.state == '0') {
                            var v = json.list;
                            for (var i = 0; i < v.length; i++) {
                                var tels = v[i].tel;
                                if (tels.indexOf(",") > 0) {
                                    tels = tels.substring(0, tels.indexOf(","));
                                }
                                xszf += '<div class="col-12 btn-bai pt-7 pb-5 hang60 line-bottom-92 overflow-hidden" style="line-height:20px;">'
                                + '<a href="javascript:tzurl(' + v[i]._id + ',' + fypage + ',\'' + type + '\')"><div class="pull-left pl-15"><div class=" maring-a clear img-wh45 img-bj  zi-bai txt-c border-radius50 " style="background-image:url(${filehttp}/' + v[i].logo + ');"></div>'
                                + '</div><div class="pull-left pt-5 pl-15"><div class="zi-hei size14 ">' + v[i].name + '</div>'
                                + '<div class="zi-hui size12 sl"><font size="0.8">' + tels + '</font></div></div></a>'
                                + '<a href="tel:' + tels + '"><div class="pull-right pr-20 pt-3"><div class=" maring-a clear img-wh40 txt-c border-radius50"><i class="fa fa-phone pt-7 fa-2x" style="color: limegreen"></i>'
                                + '</div></div></a></div>';
                            }
                            fypage++;
                        } else {
                        }
                        issend = true;
                        if (sel) {
                            $('#ajaxsearch').html(xszf);
                        } else {
                            $('#ajaxdiv').html(xszf);
                        }
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
        function searchshow() {
            $('#search').show();
        }
        function searchhide() {
            $('#search').hide();
        }
    </script>
</head>
<body>
<main class="cmp640">
    <div class="div-group-10 overflow-hidden cmp640 bg-bai position-f width-10"
         style="z-index: 99;left: 0px;">
        <div class=" overflow-hidden border-radius5">
            <div class="col-10 bg-hui-tx hang30" onclick="searchshow()">
                <input class=" width-10 txt-c line-height30 zi-hui" style="background-color: transparent"
                       type="text"
                       name=""
                       value="搜索" onfocus="if(value=='搜索'){value=''}"
                       onblur="if (value ==''){value='搜索'}">
            </div>
            <a href="#">
                <div class="col-2 txt-c bg-hui-tx hang30">
                    <i class="fa fa-search line-height30 zi-hui"></i>
                </div>
            </a>
        </div>
    </div>
    <div class="hang40 clear"></div>
    <div class="page--index export display-none">
        <div class="hero-gallery js-flickity" data-js-module="hero-gallery">
            <div class="hero-gallery__cell hero-gallery__cell" style="overflow: hidden">
                <div class="width-10">
                    <div class="overflow-hidden border-radius5">
                        <c:forEach items="${type}" var="bean" begin="0" end="7">
                            <c:if test="${empty bean.url}">
                                <a href="javascript:ajaxjz('${bean.coding}',false,false)">
                                    <div class="col-3 div-group-5 mt-10">
                                        <div class=" maring-a clear img-wh40 btn-cheng zi-bai txt-c border-radius50">
                                            <i class="fa ${bean.icon} mt-5 fa-2x"></i>
                                        </div>
                                        <div class="txt-c size14 zi-hei mt-5 width-10">${bean.title}</div>
                                    </div>
                                </a>
                            </c:if>
                            <c:if test="${not empty bean.url}">
                                <a href="${bean.url}">
                                    <div class="col-3 div-group-5 mt-10">
                                        <div class=" maring-a clear img-wh40 btn-cheng zi-bai txt-c border-radius50">
                                            <i class="fa ${bean.icon} mt-5 fa-2x"></i>
                                        </div>
                                        <div class="txt-c size14 zi-hei mt-5 width-10">${bean.title}</div>
                                    </div>
                                </a>
                            </c:if>
                        </c:forEach>

                    </div>
                </div>
            </div>
            <c:if test="${fn:length(type)>8}">
                <div class="hero-gallery__cell hero-gallery__cell" style="overflow: hidden">
                    <div class="width-10">
                        <div class="overflow-hidden border-radius5">
                            <c:forEach items="${type}" var="bean" begin="8" end="15">
                                <c:if test="${empty bean.url}">
                                    <a href="javascript:ajaxjz('${bean.coding}',false,false)">
                                        <div class="col-3 div-group-5 mt-10">
                                            <div class=" maring-a clear img-wh40 btn-cheng zi-bai txt-c border-radius50">
                                                <i class="fa ${bean.icon} mt-5 fa-2x"></i>
                                            </div>
                                            <div class="txt-c size14 zi-hei mt-5 width-10">${bean.title}</div>
                                        </div>
                                    </a>
                                </c:if>
                                <c:if test="${not empty bean.url}">
                                    <a href="${bean.url}">
                                        <div class="col-3 div-group-5 mt-10">
                                            <div class=" maring-a clear img-wh40 btn-cheng zi-bai txt-c border-radius50">
                                                <i class="fa ${bean.icon} mt-5 fa-2x"></i>
                                            </div>
                                            <div class="txt-c size14 zi-hei mt-5 width-10">${bean.title}</div>
                                        </div>
                                    </a>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
 <div class="pt-10">
     <div class="clear pl-15 bg-hui-tx size12" style="height: 25px; line-height: 25px;">
             我的黄页内容
     </div>
 </div>
    <div class="zi-hui line-bottom-98 " id="ajaxdiv">
    </div>
    <%@include file="/webcom/foot.jsp" %>
    <div class="hang40"></div>
    <%@ include file="/webcom/house-foot.jsp" %>
</main>
<script type="text/javascript">
    ajaxjz('', false, false);
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
            title: '${menu.name}', // 分享标题
            desc: '${menu.summary}', // 分享描述
            link: '${token.url}', // 分享链接
            imgUrl: '${osshttp}${menu.picurl}', // 分享图标
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