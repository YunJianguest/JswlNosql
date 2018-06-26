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
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"> 
    
    <link href="${ctx}/mvccol/SweetAlert2/css/sweetalert2.min.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/animo.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/buttons.css" rel="stylesheet"/>
    <script src="${ctx}/mvccol/js/fomatdate1.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/sweetalert2.min.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/promise.js"></script>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <%@ include file="/webcom/toast.jsp" %>
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
    <script>
        var issend = true;
        var fypage = 0;
        var  zj=false;
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
                                    + '<div class="col-10 sl txt-l" style="line-height: 40px;"><font size="1"><i>' + v[i].nickname + '</i> 在' + v[i].insDate + '经过不懈努力获得了' + v[i].jp + '</font></div></div>';
                                } else {
                                    xszf += '<div class="zi-bai overflow-hidden txt-c weight100 hang40 line-bottom">'
                                    + '<div class="col-2 pt-5 pb-5">'
                                    + '<div class="maring-a img-wh30 img-bj border-radius50" style="background-image: url(${filehttp}' + v[i].headimgurl + ');"></div>'
                                    + '</div>'
                                    + '<div class="col-10 sl txt-l" style="line-height: 40px;"><font size="1"><i>' + v[i].nickname + '</i> 在' + v[i].insDate + '经过不懈努力获得了' + v[i].jp + '</font></div></div>';
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
</head>
<body class="cmp640" style="background-color: #${entity.bgcolor}">
<main>

    <div class="pt-20 clear">
        <div class="width-9_5 maring-a pt-20 pb-20 bg-ff6633 overflow-hidden" style="border-radius:10px;">
            <div class="maring-a" style="width:300px;height:156px;">
                <div id="gua1" style="width:300px;">
                    <img id="gua1_img" src="${ctx}/mvccol/Scratch/img/gua_image.png" style="position: absolute;"/>
                    <canvas id="front" style="position:absolute;"/>
                </div>
            </div>
        </div>
    </div>

    <div class=" display-none">
        <div class="pt-20">
            <div class="div-group-5 pl-20 zi-bai pull-left pr-20 bg-4777a5 "
                 style="border-radius: 0px 100px 100px 0px;">
                <font size="2">参与人名单</font>
            </div>
        </div>
        <div class="border-radius5 width-9 maring-a pt-20 clear">
            <div class=" border-radius5 bg-4777a5" id="ajaxdiv">
            </div>
        </div>
    </div>
    <!--活动介绍-->
    <div class="pt-20">
        <div class="div-group-5 pl-20 zi-bai pull-left pr-20 bg-4777a5 " style="border-radius: 0px 100px 100px 0px;">
            <font size="2">活动简介</font>
        </div>
    </div>
    <div class="clear pt-20 pb-20">
        <div class="width-9 maring-a border-radius5 zi-bai overflow-hidden img-100">
            ${entity.context}
        </div>
    </div>
    <%--结束--%>

</main>
<script type="text/javascript">
    var re = 2;
    var imgSrc = '${ctx}/mvccol/Scratch/img/no.jpg';
    var iszj = false; 
    var isyj=false;
    var iscs=true;
    var iswc=true;
    function draw(){
       var submitData = {
       lucid: '${entity._id}',
       };
       $.post('${ctx}/suc/luckydraw!drawbox.action?custid=${custid}&lscode=${lscode}', submitData, function(json) {   
               isyj=true; 
           if (json.state == 4) {
                     noty({text: "活动未开始",type:'alert', layout: "top", timeout: 1000,callback: { // 回调函数
                                              afterClose: function() {
                               
                        } // 关闭之后
                     },});
                    isyj=false; 
                     return;
              }
           if(json.state==5){ 
                     noty({text: "活动已结束",type:'alert', layout: "top", timeout: 1000,callback: { // 回调函数
                                              afterClose: function() {
                               
                        } // 关闭之后
                     },});
                    isyj=false; 
                     return;
                }
           if(json.state==7){ 
                 isyj=false; 
                  noty({text: json.tsy,type:'alert', layout: "top", timeout: 1000,callback: { // 回调函数
                                              afterClose: function() {
                                window.location.href = '${ctx}/suc/luckydraw!reward.action?custid=${custid}&lscode=${lscode}';
                        } // 关闭之后
                     },});
                 
                 return;
                }
            if(json.state==9){ 
                 isyj=false;  
                  noty({text: "积分不够，请查看其它活动！",type:'alert', layout: "top", timeout: 1000,callback: { // 回调函数
                                              afterClose: function() {
                                window.location.href = '${ctx}/suc/totalactivity!web.action?custid=${custid}&lscode=${lscode}';
                        } // 关闭之后
                     },});
                 return;
                }
           if(json.state==2){ 
                 isyj=false; 
                  noty({text:json.tsy,type:'alert', layout: "top", timeout: 1000,callback: { // 回调函数
                                              afterClose: function() {
                            
                        } // 关闭之后
                     },});
                 return;
                }
          noty({text:"消耗"+'${entity.jfxh}'+"积分",type:'alert', layout: "top", timeout: 1000,callback: { // 回调函数
                                              afterClose: function() {
                            
                        } // 关闭之后
                },});    
          if(json.no!=''&&!isNaN(parseInt(json.no))&&json.state==0){
           var num=parseInt(json.no)+1;
           var url='${ctx}/mvccol/Scratch/img/' + num + '.jpg';
           $("#front").css("background-image","url("+url+")");
           iszj=true;
         }
        
       }, "json")
    
    }

    function showdiv() {
        document.getElementById("bg1").style.display = "block";
    }

    function hidediv() {
        document.getElementById("bg1").style.display = 'none';
    }

    $(function () {
        var width = $("#show_img").width();
        var height = $("#show_img").height();
        var winheight = $(window).height();
        var winwidth = $(window).width();
        $("#show_btn").css({"width": 176 * 0.5 + "px", "height": 76 * 0.5 + "px"});
            var body_width = $(window).width();
            var body_height = $(window).height();
            $("#gua1_img").width(300).height(160);
            var height = 141;
            var width = 285;
            var bg2_width = $("#bg2_img").width();
            var bg2_height = $("#bg2_img").height(); 
            $("#nImg").width(300).height(101);

            $("#di").css({"margin-top": "50px"});
            $("#di_img").width(414 * 0.7).height(24 * 0.7);

            var gua1_img_width = $("#gua1_img").width();
            $("#front").css({"margin-top": 9.3 + "px", "margin-left": 7.5 + "px"});
            $("#bg").width("100%").height($(window).height() - 1);
            bodys(height, width);
        

    })

    function bodys(height, width) {
        var img = new Image();
        var canvas = document.querySelector('canvas');
        canvas.style.position = 'absolute';
        img.addEventListener('load', function (e) {
            var ctx;
            var w = width, h = height;
            var offsetX = canvas.offsetLeft, offsetY = canvas.offsetTop;
            var mousedown = false;

            function layer(ctx) {
                ctx.fillStyle = 'gray';
                ctx.fillRect(0, 0, w, h);

            }

            function eventDown(e) { 
                if(iswc){ 
                draw();
                }
                e.preventDefault(); 
                iswc=false;
                mousedown = true;
                
            }

            function eventUp(e) {
                e.preventDefault(); 
                iswc=false;
                mousedown = false;
                var datas = ctx.getImageData(0, 0, w, h);
                var num = 0;
                for (var i = 0; i < datas.data.length; i++) {
                    if (datas.data[i] == 0) {
                        num++;
                    }
                    ;
                }
                ;
                if (num >= datas.data.length * 0.6) {
                    // 达到面积要求时执行的内容
                    ctx.fillRect(0, 0, w, h);
                    if(iszj){
                           window.location.href = '${ctx}/suc/luckydraw!reward.action?custid=${custid}&lscode=${lscode}';
                      }else{
                           window.location.href = '${ctx}/suc/luckydraw!web.action?custid=${custid}&lscode=${lscode}&lucid=${entity._id}';
                      }
                       
                }
                ;


            }

            function eventMove(e) {
             e.preventDefault();
             iswc=false;
               if(isyj){
               if (mousedown) {
                    if (e.changedTouches) {
                        e = e.changedTouches[e.changedTouches.length - 1];
                    }
                    var x = (e.clientX + document.body.scrollLeft || e.pageX) - offsetX || 0,
                            y = (e.clientY + document.body.scrollTop || e.pageY) - offsetY || 0;
                    with (ctx) {
                        beginPath()
                        arc(x, y, 15, 0, Math.PI * 2);
                        fill();


                    }
                }
                }
            }
            canvas.width = w;
            canvas.height = h;

            canvas.style.backgroundImage = 'url(' + img.src + ')';
            ctx = canvas.getContext('2d');
            ctx.fillStyle = 'b9b9b9';
            ctx.fillRect(0, 0, w, h);

            layer(ctx);
            ctx.globalCompositeOperation = 'destination-out';
            canvas.addEventListener('touchstart', eventDown);
            canvas.addEventListener('touchend', eventUp);
            canvas.addEventListener('touchmove', eventMove);
            canvas.addEventListener('mousedown', eventDown);
            canvas.addEventListener('mouseup', eventUp);
            canvas.addEventListener('mousemove', eventMove);
        });

        img.src = imgSrc;
        (document.body.style);
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
<script type="text/javascript">
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
<div class="clear hang50"></div>
<%@ include file="/webcom/lucky-foot.jsp" %>
<%@ include file="/webcom/toast.jsp" %>
<c:if test="${com.zsjf>0}">
  <c:if test="${sczs==1}">
  <%@ include file="/webcom/jfts-page.jsp" %>
  </c:if> 
</c:if>
</body>
</html>