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
        var issend = true;
        var fypage =0;
        var xszf = "";
        function ajaxjz() {//加载 
            if (!issend) {
                return;
            }
            var submitData = {
                sel: $('#sel').val().replace('请输入名称或关键字', ''),
                type:'${type}'
            };
            issend = false;
            $.post('${ctx}/suc/graphiclm!ajaxweb.action?custid=${custid}&lscode=${lscode}&fypage=' + fypage, submitData,
                    function (json) {
                        var xszf =  $('#ajaxdiv').html();  
                        if (json.state == '0') {
                            var v = json.list;
                            for (var i = 0; i < v.length; i++) { 
                                xszf += '<div class="col-12 btn-bai pt-7 pb-5 hang60 line-bottom-92 overflow-hidden" style="line-height:20px;" onclick="tzurl(' + v[i]._id + ',' + fypage +')">';
                                if (v[i].picurl != null) {
                                    xszf += '<div class="pull-left pl-15"><div class=" maring-a clear img-wh45 img-bj  zi-bai txt-c" style="background-image:url(${filehttp}/' + v[i].picurl + ');"></div></div>';
                                } else {
                                    xszf += '<div class="pull-left pl-15"><div class=" maring-a clear img-wh40  zi-hui txt-c border-radius50"><i class="fa fa-leaf fa-2dx line-height40"></i> </div></div>';
                                }
                                xszf += '<div class="pull-left pt-5 pl-15 col-10"><div class="zi-hei size14 sl width-10">' + v[i].title + '</div>'
                                + '<div class="zi-hui size12 sl"><font size="0.8">' +  v[i].summary + '</font></div></div>'
                                + '</div>';

                            }
                            fypage++;
                        } else {
                        }
                        issend = true; 
                        $('#ajaxdiv').html(xszf);
                        
                    }, "json")
        } 
        function tzurl(id, fy) {
            //window.history.pushState(new Date().getTime(), "${title}", "${ctx}/suc/graphiclm!web.action?type=${type}"+ "&custid=${custid}&lscode=${lscode}" + "&fypage=" + fy);
            window.location.href = "${ctx}/suc/graphiclm!detail.action?id=" + id + "&custid=${custid}&lscode=${lscode}";
        }
        function search(){
          fypage = 0;
          $('#ajaxdiv').html('');
          ajaxjz();
        }
    </script>
</head>
<body>
<main class="cmp640">

    <div class="pt-10 pb-10 pr-10 overflow-hidden pl-3 cmp640 bg-bai position-f width-10"style="z-index: 99;left: 0px;">
      
        <div class=" pl-3 col-12">
            <div class=" overflow-hidden border-radius5">
                <div class="col-10 bg-hui-tx hang30">
                    <input class=" width-10 txt-c line-height30 zi-hui" style="background-color: transparent"
                           type="text"
                           name=""
                           id="sel"
                           value="请输入名称或关键字" onfocus="if(value=='请输入名称或关键字'){value=''}"
                           onblur="if (value ==''){value='请输入名称或关键字'}">
                </div> 
                <div class="col-2 txt-c bg-hui-tx hang30" onclick="search()">
                        <i class="fa fa-search line-height30 zi-hui"></i>
                </div>
                 
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
    <div class="zi-hui line-bottom-98 " id="ajaxdiv">
    </div>
    <%@include file="/webcom/foot.jsp" %>
    <%@include file="/webcom/return-top.jsp" %>
</main> 
<script type="text/javascript">
    ajaxjz();
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
            imgUrl: '${filehttp}${share.fxpicurl}', // 分享图标
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