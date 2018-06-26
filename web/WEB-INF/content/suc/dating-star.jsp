<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
<%@ include file="/webcom/limit.jsp" %>
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
    <title>缘分</title>
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="${ctx}/app/css/font-awesome-ie7.min.css" rel="stylesheet"/>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="${ctx}/app/js/iosOverlay.js"></script>
    <script src="${ctx}/app/js/spin.min.js"></script>
    <link href="${ctx}/app/css/iosOverlay.css" rel="stylesheet"/>
    <script src="${contextPath}/mvccol/lrz/index4.js"></script>
    <script src="${contextPath}/mvccol/lrz/exif.js"></script>
    <script src="${contextPath}/mvccol/lrz/lrz.js"></script>
    <script src="${contextPath}/mvccol/lrz/mobileFix.mini.js"></script> 
    <style> 
          .pl-90 {
            padding-left: 90px;
        }
        .p-top-left-10 {
            top: 10px;
            left: 10px;
        }
        .border-radius50px {
            border-radius: 50px;
        }
        .line-height70 {
            line-height: 70px;
        }
        .bg-fa82a5 {
            background-color: #fa82a5;
        }
        .zi-fa82a5 {
            color: #fa82a5;
        }
    </style>

    <script>
     
         var loading;
         function  load(txt){
        var opts = {
		lines: 13, // The number of lines to draw
		length: 6, // The length of each line
		width: 3, // The line thickness
		radius: 8, // The radius of the inner circle
		corners: 1, // Corner roundness (0..1)
		rotate: 0, // The rotation offset
		color: '#FFF', // #rgb or #rrggbb
		speed: 1, // Rounds per second
		trail: 60, // Afterglow percentage
		shadow: false, // Whether to render a shadow
		hwaccel: false, // Whether to use hardware acceleration
		className: 'spinner', // The CSS class to assign to the spinner
		zIndex: 2e9, // The z-index (defaults to 2000000000)
		top: 'auto', // Top position relative to parent in px
		left: 'auto' // Left position relative to parent in px
	}; 
	   var target = document.createElement("div");
	   document.body.appendChild(target);
	   var spinner = new Spinner(opts).spin(target);
	  loading=iosOverlay({
		text: txt, 
		spinner: spinner
	   });
     }
    
        var issend = true; 
        function ajaxjz() {//加载 
            if (!issend) {
                return;
            }
             
            var submitData = { 
            };
            issend = false; 
            load('加载中');  
            $.post('${ctx}/suc/dating!getStarState.action?custid=${custid}&lscode=${lscode}', submitData,
                    function (json) { 
                        loading.hide();
                        if (json.state == '0') {
                            var v = json.list;
                            for (var i = 0; i < v.length; i++) {
                                 if(v[i].content=='身份认证'){
                                   
                                 }else if(v[i].content=='手机认证'){
                                    $('#star2').find('.bg-fa82a5').addClass('bg-hui-tx').removeClass('bg-fa82a5');
                                    $('#star2').find('.pull-left').addClass('bg-fa82a5').removeClass('bg-hui-tx');
                                    $('#star2').find('.bg-hui-tx').html('已完成');
                                    $('#star2').find('.bg-hui-tx').removeAttr('onclick');
                                 }else if(v[i].content=='上传本人四张照片'){ 
                                    $('#star3').find('.bg-fa82a5').addClass('bg-hui-tx').removeClass('bg-fa82a5');
                                    $('#star3').find('.pull-left').removeClass('bg-hui-tx').addClass('bg-fa82a5');
                                    $('#star3').find('.bg-hui-tx').html('已完成');
                                    $('#star3').find('.bg-hui-tx').removeAttr('onclick');
                                 }else if(v[i].content=='资料完成度达到90%'){  
                                    $('#star4').find('.bg-fa82a5').addClass('bg-hui-tx').removeClass('bg-fa82a5');
                                    $('#star4').find('.pull-left').addClass('bg-fa82a5').removeClass('bg-hui-tx');
                                    $('#star4').find('.bg-hui-tx').html('已完成');
                                    $('#star4').find('.bg-hui-tx').removeAttr('onclick');
                                 }else if(v[i].content=='快乐分享'){   
                                    $('#star5').find('.pull-left').addClass('bg-fa82a5').removeClass('bg-hui-tx');
                                 }else if(v[i].content=='邀请好友'){ 
                                    if(v[i].count>=5){
                                     $('#star6').find('.pull-left').addClass('bg-fa82a5').removeClass('bg-hui-tx');
                                    }
                                    $('#count').html('已邀请'+v[i].count+'人')
                                   
                                 } 
                            } 
                        } else {
                        } 
                        issend = true;  
                        
                    }, "json")
        } 
    
    </script>
</head>
<body class="lock">
<main class="cmp640">
    <div class="hang40 line-height40 pl-10 pr-10 zi-bai cmp640 position-f"
         style="left:0px;top: 0px;z-index: 10; background-color: #fd6c8e">
        <div class="col-3 zi-bai" onclick="self.location=document.referrer;">
            <i class="fa fa-chevron-left pr-5"></i>返回
        </div>
        <div class="col-6">
            <div class="width-9 sl maring-a txt-c">魅力等级</div>
        </div>
        <div class="col-3 pull-right pt-5 zi-hui-wx">
            <font size="1">
                <div class="hang30 line-height30 pl-10 pr-10 txt-c pull-right zi-bai border-radius3 fa fa-home"
                     style="background-color: #fd87a8" onclick="window.location.href='${ctx}/suc/dating!web.action?custid=${custid}&lscode=${lscode}&datingid=${datingid}'"><i class="pl-5">首页</i>
                </div>
            </font>
        </div>
    </div>
    <div class="hang40"></div>

    <img src="${ctx}/img/dating/yuanlai1.jpg" class="width-10">
  
    <div class="hang90 overflow-hidden bg-bai width-10 position-r line-bottom-92 display-none" id="star2">
        <div class="pull-left bg-hui-tx txt-c img-wh70 position-a p-top-left-10 position-r border-radius50">
            <i class="fa fa-mobile fa-4x zi-bai line-height70"></i>
        </div>
        <div class="pt-15 pr-10 width-10 pl-90" >
            <div class="col-8 hang20 line-height20 zi-hei-tq">
                <div class="sl weight500 size14">手机认证</div>
                <div class="hang20 line-height20 zi-hui-wx size12 weight500 sl">
                    安全保障 来信即知
                </div>
                <div class="hang20 line-height20 zi-6 size12 weight500 sl">
                    可获得：<i class="zi-fa82a5">6小时</i>
                </div>
            </div>
            <div class="col-4 sl pt-15">
                <div class="hang30 line-height30 width-9 size12 txt-c pull-right bg-fa82a5 zi-bai border-radius50px weight500">
                    去认证
                </div>
            </div>
        </div>
    </div>

    <div class="hang90 overflow-hidden bg-bai width-10 position-r line-bottom-92" id="star3">
        <div class="pull-left bg-hui-tx txt-c img-wh70 position-a p-top-left-10 position-r border-radius50">
            <i class="fa fa-photo fa-2dx zi-bai line-height70"></i>
        </div>
        <div class="pt-15 pr-10 width-10 pl-90" >
            <div class="col-8 hang20 line-height20 zi-hei-tq">
                <div class="sl weight500 size14">上传本人四张照片</div>
                <div class="hang20 line-height20 zi-hui-wx size12 weight500 sl">
                    显示自我 获得青睐
                </div>
                <div class="hang20 line-height20 zi-6 size12 weight500 sl">
                    可获得：<i class="zi-fa82a5">6小时</i>
                </div>
            </div>
            <div class="col-4 sl pt-15" onclick="window.location.href='${ctx}/suc/dating!photo.action?custid=${custid}&lscode=${lscode}&datingid=${datingid}'">
                <div class="hang30 line-height30 width-9 size12 txt-c pull-right bg-fa82a5 zi-bai border-radius50px weight500">
                    去上传
                </div>
            </div>
        </div>
    </div>

    <div class="hang90 overflow-hidden bg-bai width-10 position-r line-bottom-92" id="star4">
        <div class="pull-left bg-hui-tx txt-c img-wh70 position-a p-top-left-10 position-r border-radius50">
            <i class="fa fa-pencil-square-o fa-2dx zi-bai line-height70"></i>
        </div>
        <div class="pt-15 pr-10 width-10 pl-90" >
            <div class="col-8 hang20 line-height20 zi-hei-tq">
                <div class="sl weight500 size14">资料完成度达到90%</div>
                <div class="hang20 line-height20 zi-hui-wx size12 weight500 sl">
                    诚信资料 缘分不断
                </div>
                <div class="hang20 line-height20 zi-6 size12 weight500 sl">
                    可获得：<i class="zi-fa82a5">6小时</i>
                </div>
            </div>
            <div class="col-4 sl pt-15" onclick="window.location.href='${ctx}/suc/dating!webadd.action?custid=${custid}&lscode=${lscode}&datingid=${datingid}'">
                <div class="hang30 line-height30 width-9 size12 txt-c pull-right bg-fa82a5 zi-bai border-radius50px weight500">
                    去填写
                </div>
            </div>
        </div>
    </div>

    <div class="hang90 overflow-hidden bg-bai width-10 position-r line-bottom-92" id="star5">
        <div class="pull-left bg-hui-tx txt-c img-wh70 position-a p-top-left-10 position-r border-radius50">
            <i class="fa fa-paper-plane-o fa-2dx zi-bai line-height70"></i>
        </div>
        <div class="pt-15 pr-10 width-10 pl-90" >
            <div class="col-8 hang20 line-height20 zi-hei-tq">
                <div class="sl weight500 size14">快乐分享<i size="1" class="zi-hui">（分享朋友圈）</i></div>
                <div class="hang20 line-height20 zi-hui-wx size12 weight500 sl">
                    分享既是得到 每三天一次
                </div>
                <div class="hang20 line-height20 zi-6 size12 weight500 sl">
                    可获得：<i class="zi-fa82a5">6小时</i>
                </div>
            </div>
            <div class="col-4 sl pt-15" onclick="show_tc('您只要分享平台任何页面到朋友圈就可完成此任务，此任务每三天一次')">
                <div class="hang30 line-height30 width-9 size12 txt-c pull-right bg-fa82a5 zi-bai border-radius50px weight500">
                    查看详情
                </div>
            </div>
        </div>
    </div>

    <div class="hang90 overflow-hidden bg-bai width-10 position-r line-bottom-92" id="star6">
        <div class="pull-left bg-hui-tx txt-c img-wh70 position-a p-top-left-10 position-r border-radius50">
            <i class="fa fa-handshake-o fa-2dx zi-bai line-height70"></i>
        </div>
        <div class="pt-15 pr-10 width-10 pl-90" >
            <div class="col-8 hang20 line-height20 zi-hei-tq">
                <div class="sl weight500 size14">邀请好友</div>
                <div class="hang20 line-height20 zi-hui-wx size12 weight500 sl">
                    好事大家知 免费得会员
                </div>
                <div class="hang20 line-height20 zi-6 size12 weight500 sl">
                   <i id="count"></i>
                </div>
            </div>
            <div class="col-4 sl pt-15" onclick="show_tc('奖励分三个阶段：①累计邀请到5人奖励6小时； ②累计邀请到10人奖励7小时；③累计邀请到15人奖励10小时；总计奖励：23小时')">
                <div class="hang30 line-height30 width-9 size12 txt-c pull-right bg-fa82a5 zi-bai border-radius50px weight500">
                    查看详情
                </div>
            </div>
        </div>
    </div>

    <font size="1">
        <div class="pt-20 pb-20 weight500 txt-c zi-hui-wx">完成魅力任务所获得奖励可累积使用</div>
    </font>
</main>

<div class="fullscreen cmp640 bg-hei-5 lock display-none" id="tc_pf">
    <div class="overflow-hidden width-10">
        <a href="javascript:hide_tc()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class=" cmp640 position-f position-r" style="top:35%;left:0px;z-index: 99;">
            <div class="maring-a position-r border-radius3 div-group-10 pb-15 bg-bai" style="width:290px;">
                <a href="javascript:hide_tc()">
                    <div class="position-a" style="right:-10px;top:-10px;z-index: 101;">
                        <div class="img-wh25 border-radius50 bg-hei-5 txt-c">
                            <font size="3">
                                <i class="fa fa-remove zi-bai" style="line-height:27px"></i>
                            </font>
                        </div>
                    </div>
                </a>
                <div class=" width-10 border-radius3 zi-hui-tq overflow-hidden">
                    <font size="2">
                        <div class="weight500">您好:</div>
                        <div class="weight500" style="line-height: 22px;">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp尊敬的：<i
                                class="zi-fa82a5">${nickname}</i><i id="txt"></i>
                        </div>
                    </font>
                </div>
            </div>
        </div>
    </div>
</div>


</body>
<script>

function hide_tc(){
  $('#tc_pf').hide();
}
function show_tc(v){
  $('#txt').html(v);
  $('#tc_pf').show();
}
 function  check_task(){
       var submitData = {  
            };
            $.post('${ctx}/suc/dating!ajaxReward.action?custid=${custid}&lscode=${lscode}', submitData, 
                    function (json) { 
                        if (json.state == 0) {
                        
                        }  
                    }, "json"); 
     }
</script>
<script type="text/javascript">
    ajaxjz(); 
    
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
</html>