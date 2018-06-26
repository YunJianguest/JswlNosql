<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %> 
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
    <title>消息</title>
     <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="${ctx}/app/css/font-awesome-ie7.min.css" rel="stylesheet"/>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="${ctx}/app/js/iosOverlay.js"></script>
    <script src="${ctx}/app/js/spin.min.js"></script>
    <link href="${ctx}/app/css/iosOverlay.css" rel="stylesheet"/>
    <style>
        .pl-60{
            padding-left: 60px;
        }
        .p-top-left-10{
            top:10px;
            left: 10px;
        }
         .border-radius50px {
            border-radius: 50px;
            line-height: 22px;
        }
        .bg-f74c31{
            background-color: #f74c31;
        }
        .hang15{
            height: 15px;
            line-height: 17px;
        }
        .zi-808080{
            color: #808080;
        }
             .img-w40-h50 {
            width: 40px;
            height: 50px;
            overflow: hidden;
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
        var fypage =0;
        var xszf = ""; 
        function ajaxjz() {//加载 
            if (!issend) {
                return;
            } 
            issend = false;
            load("加载中");
            $.post('${ctx}/suc/dating!ajaxMsg.action?custid=${custid}&lscode=${lscode}&fypage='+fypage, null,
                    function (json) {
                    loading.hide();
                        var xszf = $('#ajaxdiv').html();   
                        if (json.state == '0') {
                            var v = json.list;
                            for (var i = 0; i < v.length; i++) {
                                xszf+='<div class="hang70 overflow-hidden bg-bai width-10 position-r line-bottom-92" onclick="chat('+v[i]._id+')">'
                                     +'<div class="pull-left img-w40-h50 img-bj position-a p-top-left-10"style="background-image:url(${filehttp}/'+v[i].headimgurl+')">'
                                     +'</div>'
                                     +'<div class="pt-10 pr-10 width-10 pl-60">'
                                     +'<div class="hang25 line-height25 weight500 zi-hei-tq">'
                                     +'<div class="col-9 sl size14">'+v[i].nickname+'</div>'
                                     +'<div class="col-3 txt-r size12 sl zi-hui-wx weight500">'+v[i].endupdate+'</div>'
                                     +'</div>'
                                     +'<font size="2">'
                                     +'<div class="hang25 line-height25 zi-hui-wx">'
                                     +'<div class="col-10 sl weight500">'+v[i].endmsg+'</div>';
                                     if(v[i].uncount>0){
                                     xszf+='<div class="col-2 sl pt-5">'
                                         +'<div class="hang15 txt-c pl-5 pr-5 pull-right bg-f74c31 zi-bai border-radius50px weight500"><font size="1">'+v[i].uncount+'</font></div>'
                                         +'</div>';
                                     } 
                                     xszf+='</div></font></div></div>';  
                                     +'<div class="col-10 sl weight500">'+v[i].endmsg+'</div>'
                                     +'<div class="col-2 sl pt-5">'
                                     +'<div class="hang15 txt-c pl-5 pr-5 pull-right bg-f74c31 zi-bai border-radius50px"><font size="1">12</font></div>'
                                     +'</div></div></font></div></div>';  
                       
                          }
                            fypage++;
                        } else {
                        }
                        issend = true; 
                        $('#ajaxdiv').html(xszf);
                        
                    }, "json")
        }
        function  chat(id){
          window.location.href="${ctx}/suc/dating!chatDetail.action?custid=${custid}&lscode=${lscode}&datingid=${datingid}&rid="+id;
        }
    </script>
</head>
<body class="lock">
<main class="cmp640" id="ajaxdiv">
 
</main>
<div class="clear hang50"></div>
<%@ include file="/webcom/dating-foot.jsp" %>
<script>
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
</body>
<script type="text/javascript"> 
    ajaxjz();
      $(window).scroll(function () {
        var offsetY = $(window).scrollTop();
        var section1 = $("main").height();
        if (section1 - offsetY < 700) {
            ajaxjz();
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
</html>