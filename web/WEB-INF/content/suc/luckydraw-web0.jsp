<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
<%@ include file="/webcom/limit.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport"
          content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>${title}</title>
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/app/css/font-awesome.min.css" rel="stylesheet">
    <link href="${contextPath}/mvccol/yj/activity-style.css" rel="stylesheet" type="text/css"> 
    
    
    <link href="${ctx}/mvccol/SweetAlert2/css/sweetalert2.min.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/animo.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/buttons.css" rel="stylesheet"/>
    <script src="${ctx}/mvccol/js/fomatdate1.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/sweetalert2.min.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/promise.js"></script>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script>
        var issend = true;
        var fypage = 0;
        function ajaxjzyj() {//加载
            if (!issend) {
                return;
            }

            var submitData = {
                "lucid": "${entity._id}"
            };
            issend = false;
            $.post('${ctx}/suc/luckydraw!ajaxrewardhd.action?custid=${custid}&lscode=${lscode}&fypage=' + fypage, submitData,
                    function (json) {
                        var xszf = '';
                        if (json.state == 0) {
                            var v = json.list;
                            for (var i = 0; i < v.length; i++) {
                                if (i == v.length - 1) {
                                    xszf += '<div class="zi-bai overflow-hidden txt-c weight100 hang40">'
                                    + '<div class="col-2 pt-5 pb-5">'
                                    + '<div class="maring-a img-wh30 img-bj border-radius50" style="background-image: url(${filehttp}' + v[i].headimgurl + ');"></div>'
                                    + '</div>'
                                    + '<div class="col-10 sl txt-l zi-bai" style="line-height: 40px;"><font size="1"><i>' + v[i].nickname + '</i> 在' + v[i].insDate + '经过不懈努力获得了' + v[i].jp + '</font></div></div>';
                                } else {
                                    xszf += '<div class="zi-bai overflow-hidden txt-c weight100 hang40 line-bottom">'
                                    + '<div class="col-2 pt-5 pb-5">'
                                    + '<div class="maring-a img-wh30 img-bj border-radius50" style="background-image: url(${filehttp}' + v[i].headimgurl + ');"></div>'
                                    + '</div>'
                                    + '<div class="col-10 sl txt-l zi-bai" style="line-height: 40px;"><font size="1"><i>' + v[i].nickname + '</i> 在' + v[i].insDate + '经过不懈努力获得了' + v[i].jp + '</font></div></div>';
                                }

                            }

                        } else {

                        }
                        issend = true;

                        fypage++;
                        $('#ajaxdiv').html(xszf);
                    }, "json")

        }
    </script>
    <style>
        .bg-4777a5 {
            background: #4777a5;
        }

        .bj-558ec5 {
            background: #558ec5 !important;
        }

        .bg-ff6633 {
            background-color: #ff7648;
        }
         .img-100 img{
        width: 100%;
        }
    </style>
</head> 
<body class="cmp-640" style="background-color: #${entity.bgcolor}">
<div class="main mt-20">
    <%--转盘开始--%>
    <div id="outercont">
        <div id="outer-cont" class="width-8 overflow-hidden">
            <div id="outer" class="width-10"><img src="${contextPath}/mvccol/yj/pic/wheel.png"></div>
            <%--指针--%>
            <div id="inner-cont">
                <div id="inner"><img src="${contextPath}/mvccol/yj/activity-lottery-2.png" class="width-8"></div>
            </div>
            <%--指针结束--%>
        </div>
    </div>
    <%--转盘结束--%>
</div>

<div class="cmp-640">
    <div class=" display-none">
        <div class="pt-20 clear">
            <div class="div-group-5 pl-20 zi-bai pull-left pr-20 bg-4777a5 " style="border-radius: 0px 100px 100px 0px;">
                <font size="2">获奖名单</font>
            </div>
        </div>
        <div class="border-radius5 width-9 maring-a pt-20 clear">
            <div class=" border-radius5 bg-4777a5" id="ajaxdiv">
                <!--循环列表开始-->
            </div>
        </div>
    </div>


    <!--活动介绍-->
    <div class="pt-20 clear">
        <div class="div-group-5 pl-20 zi-bai pull-left pr-20 bg-4777a5 " style="border-radius: 0px 100px 100px 0px;">
            <font size="2">活动简介</font>
        </div>
    </div>
    <div class="width-9_5 maring-a clear pt-20 pb-20">
        <div class=" zi-bai border-radius5 img-100">
            ${entity.context}
        </div>
    </div>

</div>
<div class="clear hang40"></div>
<%@ include file="/webcom/lucky-foot.jsp" %>
<script type="text/javascript">
        var totalDeg = 360 * 3 + 0;
        var steps = [];
        var lostDeg = [350, 280, 220, 156, 100, 40, 310, 306, 336];
        var prizeDeg = [165, 104, 48, 345, 280, 228];
        var prize, sncode;
        var count = 0;
        var now = 0;
        var a = 0.01;
        var outter, inner, timer, running = false;
    $(function () {
        window.requestAnimFrame = (function () {
            return window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame || function (callback) {
                        window.setTimeout(callback, 1000 / 60)
                    }
        })(); 
        function countSteps() {
            var t = Math.sqrt(2 * totalDeg / a);
            var v = a * t;
            for (var i = 0; i < t; i++) {
                steps.push((2 * v * i - a * i * i) / 2)
            }
            steps.push(totalDeg)
        }

        function step() {
            outter.style.webkitTransform = 'rotate(' + steps[now++] + 'deg)';
            outter.style.MozTransform = 'rotate(' + steps[now++] + 'deg)';
            if (now < steps.length) {
                requestAnimFrame(step)
            } else {
                setTimeout(function () {
                    if (prize != null) {
                        $("#sncode").text(sncode);
                        alert("恭喜您中奖了,获得了" + sncode);
                        window.location.href = '${ctx}/suc/luckydraw!reward.action?custid=${custid}&lscode=${lscode}';
                    } else {
                        alert("谢谢您的参与！");
                        window.location.href = '${ctx}/suc/luckydraw!web.action?custid=${custid}&lscode=${lscode}&lucid=${entity._id}'; 
                    }
                }, 200)
            }
        }

        function start(deg) {
            deg = deg || lostDeg[parseInt(lostDeg.length * Math.random())];
            clearInterval(timer);
            totalDeg = 360 * 5 + deg;
            steps = [];
            now = 0;
            countSteps();
            requestAnimFrame(step)
        }

        window.start = start;
        outter = document.getElementById('outer');
        inner = document.getElementById('inner');
        i = 10;
        $("#inner").click(function () {
         if('${entity.jfxh}'>0){
         	 swal({ 
                                       text:'参与活动需要消耗${entity.jfxh}积分，是否继续参与？',
                                       type: 'question',
                                       allowOutsideClick: false,
                                       showCancelButton: true,
                                       confirmButtonColor: '#3085d6',
                                       cancelButtonColor: '#d33',
                                       confirmButtonText: '继续参与',
                                       cancelButtonText: '稍后再说',
                                       confirmButtonClass: 'btn btn-success mr-15',
                                       cancelButtonClass: 'btn btn-danger ml-15',
                                       buttonsStyling: false
                                     }).then(function () {
                                          ajaxyj();
                                       
                                          }, function (dismiss) {
                                           // dismiss can be 'cancel', 'overlay',
                                          // 'close', and 'timer'
                                        if (dismiss === 'cancel') {
                                            
                                             }
                                          });
          }else{
              ajaxyj();
          }	 
       });
    });
     function  ajaxyj(){
   
          $.post("${ctx}/suc/luckydraw!drawbox.action?custid=${custid}&lscode=${lscode}", {
                lucid: '${entity._id}', 
                t: Math.random()
            }, function (data) {  
                if (data.state == 3) { 
                     swal({text:'请先登录'});
                    window.location.href = "${ctx}/user/fromuser!UserDetail.action?custid=${custid}";
                }
                if (data.state == 4) {
                     swal({text:'活动未开始'});
                }
                if(data.state==5){ 
                     swal({text:'活动已结束'});
                }
                if(data.state==9){ 
                 isyj=false;  
                      swal({ 
                               text: "亲，您积分不足，您可以查看其它活动或者赚取积分！",
                               type: 'warning',
                               showCancelButton: true,
                               confirmButtonColor: '#3085d6',
                               cancelButtonColor: '#d33',
                               confirmButtonText: '去赚积分',
                               cancelButtonText: '稍后再说',
                               confirmButtonClass: 'btn btn-success mr-15',
                               cancelButtonClass: 'btn btn-danger ml-15',
                                   buttonsStyling: false
                             }).then(function () {
                                   window.location.href='${ctx}/suc/task!web.action?custid=${custid}&lscode=${lscode}';
                                   
                            }, function (dismiss) {
                           // dismiss can be 'cancel', 'overlay',
                           // 'close', and 'timer'
                             if (dismiss === 'cancel') {
                                  
                                 }
                            });
                 return;
                }
               
                if(data.state==7){
                  swal({text:data.tsy});
                  window.location.href = '${ctx}/suc/luckydraw!reward.action?custid=${custid}&lscode=${lscode}';
                 return;
                }
                if(data.state==2){
                 swal({text:data.tsy}); 
                 return;
                }  
                if (data.state == 6) {
                    //未中奖 
                    start(lostDeg[6]);
                    noty({text:"消耗"+'${entity.jfxh}'+"积分",type:'alert', layout: "top", timeout: 1000,callback: { // 回调函数
                                              afterClose: function() {
                            
                        } // 关闭之后
                    },});       
                    return;
                }
                if (data.state == 0) {
                     noty({text:"消耗"+'${entity.jfxh}'+"积分",type:'alert', layout: "top", timeout: 1000,callback: { // 回调函数
                                              afterClose: function() {
                            
                        } // 关闭之后
                },});     
                    prize = data.no;
                    sncode = data.text;
                    if (data.no == 0) {
                        start(lostDeg[0]);
                    }
                    if (data.no == 1) {
                        start(lostDeg[1]);
                    }
                    if (data.no == 2) {
                        start(lostDeg[2]);
                    }
                    if (data.no == 3) {
                        start(lostDeg[3]);
                    }
                    if (data.no == 4) {
                        start(lostDeg[4]);
                    }
                    if (data.no == 5) { 
                        start(lostDeg[5]);
                    }

                    return;

                }


            }, "json"); 
   }

</script>

<script>
    function  check_task(){
       var submitData = { 
                type:"allshare",
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
<script>
    ajaxjzyj();
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
<c:if test="${not empty com.ewmurl}">
 <c:if test="${com.ewmxs==0}">
  <%@ include file="/webcom/focus-page.jsp" %>
 </c:if>
</c:if>
<%@ include file="/webcom/toast.jsp" %>
<c:if test="${com.zsjf>0}">
  <c:if test="${sczs==1}">
  <%@ include file="/webcom/jfts-page.jsp" %>
  </c:if> 
</c:if>
</body>
</html>