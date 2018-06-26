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
    <title></title>
    <!-- Resource style -->
    <script src="${contextPath}/app/js/jquery-1.8.3.js"></script>
    <link href="${contextPath}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/app/css/font-awesome.min.css" rel="stylesheet">
    <script type="text/javascript" src="${contextPath}/app/js/jquery.Spinner.js"></script>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="${contextPath}/mvccol/js/fomatdate2.js"></script>

    <style>
        .bk {
            width: 90px;
            height: 65px;
        }

        .line-height32 {
            line-height: 32px;
        }
    </style>
    <script>
        var fypage =${fypage};
        var id = 0;
        function ajaxsuuply(tag, type) {//加载
            var submitData = {
                type: type,
                isadmin: '${isadmin}'
            };
            $.post('${ctx}/suc/jobcompay!ajaxsupplyweb.action?custid=${custid}&lscode=${lscode}&fypage=' + fypage, submitData,
                    function (json) {
                        var list = '';
                        if (tag) {
                            list = $('#ajaxdiv').html();
                        }
                        if (json.state == '0') {
                            var js = json.list;
                            for (var i = 0; i < js.length; i++) {
                                list += '<div class="line-bottom div-group-5 pt-10 pl-10 pr-10 overflow-hidden position-r" onclick="detail(\'' + js[i]._id + '\',3)">'
                                + '<div class="zi-6 weight500 hang25 line-height25">'
                                + '<font size="2">'
                                + '<div class="sl"><i class="zi-hong pr-5">';
                                if (js[i].type == 1) {
                                    list += "二手交易";
                                }
                                if (js[i].type == 2) {
                                    list += "房屋租赁";
                                }
                                list += '</i>' + js[i].title + '</div>'
                                + '</font></div>'
                                + '<font size="2">'
                                + '<div class="clear sl weight100 hang25 line-height25">'
                                + '<span class="zi-hui">' + js[i].summary + '</span></div>'
                                + '<div class="sl weight100 hang25 line-height25">'
                                + '<div class="pull-left">价钱：<span class="zi-green weight500">' + js[i].price + '</span>'
                                + '</div>'
                                + '<div class="pull-right">' + Date.prototype.format(js[i].createdate) + '</div>'
                                + '</div></font></div>';

                            }
                            fypage++;
                        } else {
                            if (list.indexOf('暂无信息，请查看其它内容！') > 0) {

                            } else {
                                list += '<div class="clear txt-c zi-hui size14"><div class="pt-10">'
                                + '<i class="fa fa-tags fa-6x"></i></div><div class="pt-20 pb-20">'
                                + '暂无信息，请查看其它内容！ </div></div>';
                            }
                        }
                        $('#ajaxdiv').html(list);

                    }, "json");
        }
        function ajaxseekers(tag) {//加载
            var submitData = {
                isadmin: '${isadmin}'
            };
            $.post('${ctx}/suc/jobcompay!ajaxseekersweb.action?custid=${custid}&lscode=${lscode}&fypage=' + fypage, submitData,
                    function (json) {
                        var list = '';
                        if (tag) {
                            list = $('#ajaxdiv').html();
                        }
                        if (json.state == '0') {
                            var js = json.list;
                            for (var i = 0; i < js.length; i++) {
                                list += '<div class="line-bottom div-group-5 pt-10 pl-10 pr-10 overflow-hidden position-r" onclick="detail(\'' + js[i]._id + '\',2)">'
                                + '<div class="zi-6 weight500 hang25 line-height25">'
                                + '<font size="2">'
                                + '<div class="sl"><i class="zi-hong pr-5">[求职]</i>' + js[i].name + '</div>'
                                + '</font></div>'
                                + '<font size="2">'
                                + '<div class="clear sl weight100 hang25 line-height25">'
                                + '<span class="zi-hui"><i>工作经验：</i>' + js[i].experience + '</span></div>'
                                + '<div class="sl weight100 hang25 line-height25">'
                                + '<div class="pull-left">渴望薪资：<span class="zi-green weight500">' + js[i].salary + '</span>'
                                + '</div>'
                                + '<div class="pull-right">' + Date.prototype.format(js[i].createdate) + '</div>'
                                + '</div></font></div>';
                            }
                            fypage++;
                        } else {
                            if (list.indexOf('暂无信息，请查看其它内容！') > 0) {

                            } else {
                                list += '<div class="clear txt-c zi-hui size14"><div class="pt-10">'
                                + '<i class="fa fa-tags fa-6x"></i></div><div class="pt-20 pb-20">'
                                + '暂无信息，请查看其它内容！ </div></div>';
                            }

                        }
                        $('#ajaxdiv').html(list);

                    }, "json");
        }
        function ajaxemploy(tag) {//加载
            var submitData = {
                isadmin: '${isadmin}'
            };
            $.post('${ctx}/suc/jobcompay!ajaxemployweb.action?custid=${custid}&lscode=${lscode}&fypage=' + fypage, submitData,
                    function (json) {
                        var list = '';
                        if (tag) {
                            list = $('#ajaxdiv').html();
                        }
                        if (json.state == '0') {
                            var js = json.list;
                            for (var i = 0; i < js.length; i++) {
                                list += '<div class="line-bottom div-group-5 pt-10 pl-10 pr-10 overflow-hidden position-r" onclick="detail(\'' + js[i]._id + '\',1)">'
                                + '<div class="zi-6 weight500 hang25 line-height25">'
                                + '<font size="2">'
                                + '<div class="sl"><i class="zi-hong pr-5">[招聘]</i>' + js[i].title + '</div>'
                                + '</font></div>'
                                + '<font size="2">'
                                + '<div class="clear sl weight100 hang25 line-height25">'
                                + '<span class="zi-hui"><i>工作经验：</i>' + js[i].experience + '</span></div>'
                                + '<div class="sl weight100 hang25 line-height25">'
                                + '<div class="pull-left">薪资：<span class="zi-green weight500">' + js[i].salary + '</span>'
                                + '</div>'
                                + '<div class="pull-right">' + Date.prototype.format(js[i].createdate) + '</div>'
                                + '</div></font></div>';
                            }
                            fypage++;
                        } else {
                            if (list.indexOf('暂无信息，请查看其它内容！') > 0) {

                            } else {
                                list += '<div class="clear txt-c zi-hui size14"><div class="pt-10">'
                                + '<i class="fa fa-tags fa-6x"></i></div><div class="pt-20 pb-20">'
                                + '暂无信息，请查看其它内容！ </div></div>';
                            }
                        }
                        $('#ajaxdiv').html(list);

                    }, "json");
        }
    </script>
    <script type="text/javascript">
        $(function () {
            $(".yListr2 li").click(function () {
                $(this).addClass("zi-hong").siblings().removeClass("zi-hong");
                $(".yListr2 i").removeClass("fa-caret-up");
                if ($(this).hasClass('zi-hong')) {
                    $(this).find('i').addClass("fa-caret-up");
                    id = $(this).attr("id");
                    if (id == 1) {
                        fypage = 0;
                        ajaxemploy(false);
                    }
                    if (id == 2) {
                        fypage = 0;
                        ajaxseekers(false);
                    }
                    if (id == 3) {
                        fypage = 0;
                        ajaxsuuply(false, 1);
                    }
                    if (id == 4) {
                        fypage = 0;
                        ajaxsuuply(false, 2);
                    }
                }
            })
        })
        function detail(id, type) {
            if (type == 1) {
                window.location.href = "${ctx}/suc/jobcompay!employDetail.action?custid=${custid}&lscode=${lscode}&_id=" + id;
            }
            if (type == 2) {
                window.location.href = "${ctx}/suc/jobcompay!seekersDetail.action?custid=${custid}&lscode=${lscode}&_id=" + id;
            }
            if (type == 3) {
                window.location.href = "${ctx}/suc/jobcompay!supplyDetail.action?custid=${custid}&lscode=${lscode}&_id=" + id;
            }
        }
    </script>
</head>
<body>
<main class="clear cmp640 lock">
    <font size="2">
        <div class="position-f cmp640 position-r" style="left: 0px; z-index:3;">
            <div class="hang40 bg-bai pt-5 line-bottom-92 weight100 yListr2 zi-hui-tq">
                <li class="button_group1 hang30 line-height32 txt-c line-right weight500"id="1">
                    招聘<i class="pl-5 fa fa-1x fa-caret-down"></i>
                </li>
                <li class="button_group1 hang30 line-height32 txt-c line-right weight500"id="2">
                    求职<i class="pl-5 fa fa-1x fa-caret-down"></i>
                </li>
                <li class="button_group1 hang30 line-height32 txt-c line-right weight500"id="3">
                    二手交易<i class="pl-5 fa fa-1x fa-caret-down"></i>
                </li>
                <li class="button_group1 hang30 line-height32 txt-c weight500"id="4">
                    房屋租赁<i class="pl-5 fa fa-1x fa-caret-down"></i>
                </li>
            </div>

        </div>
    </font>
    <div class="hang40 clear"></div>
    <div id="ajaxdiv"></div>

</main>
<div class="clear hang50"></div>
<%@ include file="/webcom/jobcompay-foot.jsp" %>
<script type="text/javascript">

if('${type}'>0){
    id='${type}'; 
    if (id==1) {                
        ajaxemploy(false);
        
     }
    if (id == 2) {
        
        ajaxseekers(false);
    }
    if (id == 3) {
                       
        ajaxsuuply(false, 1);
    }
    if (id == 4) {
        
        ajaxsuuply(false, 2);
    }
   
}else{
ajaxemploy(false);
} 
 $(".yListr2 li").each(function(){
        if($(this).attr("id")==id){
        $(this).addClass("zi-hong");
        $(this).find('i').addClass("fa-caret-up");
        }
        });  
 
    $(window).scroll(function () {
        var offsetY = $(window).scrollTop();
        var section1 = $("#section1").height();
        if (section1 - offsetY < 700) {
            if (id == 1 || id == 0) {
                ajaxemploy(true);
            }
            if (id == 2) {
                ajaxseekers(true);
            }
            if (id == 3) {
                ajaxsuuply(true, 1);
            }
            if (id == 4) {
                ajaxsuuply(true, 2);
            }
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