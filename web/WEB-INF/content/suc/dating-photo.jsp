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
         .p-l-r-1 {
            padding: 5px 2px 5px 2px;
        }
         .file {
            position: absolute;
            z-index: 100;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            opacity: 0;
            background-color: bisque;
        }

          #clipArea {
              margin-top: 120px;
              margin-left: auto;
              margin-right: auto;
              /*width: 300px;*/
              height: 300px;
          }

         #file,
         #clipBtn {
             width: 100%;
             height: 100%;
         }

         #view {
             width: 80px;
             height: 80px;
         }

         .beijing-tm {
             filter: alpha(opacity=0);
             -moz-opacity: 0;
             -khtml-opacity: 0;
             opacity: 0;
         }
         
    </style>

    <script>
    
         var total=0;
         var remoney=0;
         var jfdh=0;
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
        var fypage =${fypage};
        var xszf = ""; 
        function ajaxjz() {//加载 
            if (!issend) {
                return;
            }
             
            var submitData = { 
            };
            issend = false;  
            load('加载中');  
            $.post('${ctx}/suc/dating!ajaxPhoto.action?custid=${custid}&lscode=${lscode}&fypage=' + fypage, submitData,
                    function (json) {
                        loading.hide();
                        var xszf=$('#ajaxdiv').html(); 
                        if (json.state == '0') {
                            var v = json.list;
                            for (var i = 0; i < v.length; i++) {
                              xszf+='<div class="col-3 p-l-r-1">'
                                   +'<div class="img-wh70 maring-a img-bj border-radius3"style="background-image: url(${filehttp}/'+v[i].picurl+')"></div>'
                                   +'</div>';
                            }
                            fypage++;
                        } else {
                        } 
                        issend = true; 
                        $('#ajaxdiv').html(xszf);
                        
                    }, "json")
        } 
       function upload(){ 
          var submitData = {
    	        picurl:$('.cameraInput').attr('path')
	            }; 
		$.post('${ctx}/suc/dating!savePhoto.action?custid=${custid}&lscode=${lscode}', submitData, 
        	 function(json){
        	  loading.hide(); 
        	  if(json.state==0){ 
        	    alert("上传成功，请等待审核！");
        	     var html='';
        	         html+='<div class="col-3 p-l-r-1 position-r"><div class=" width-10">'
        	             +'<div class="img-wh70 maring-a"><img class="width-10 border-radius3" src="${ctx}/img/dating/addimg.jpg"/>'
        	             +'<input type="file" accept="image/*" class="file cameraInput" name="cameraInput" onchange="uploadImg(this)"/>';
        	             +'</div></div></div>';
                 $('#ajaxdiv').html(html);
        	     fypage=0;
        	     ajaxjz();
        	  }else{ 
        	  }
        	 },"json"); 
       } 
    </script>
</head>
<body class="lock" style="background-color: #f0f0f0">
 
<main class="cmp640"> 
    <font size="2"> 
        <div class="p-l-r-1 bg-bai overflow-hidden pt-10" id="ajaxdiv">
            <div class="col-3 p-l-r-1 position-r">
                <div class="img-wh70 maring-a"><img class="width-10 border-radius3" src="${ctx}/img/dating/addimg.jpg"/></div>
                <input class="position-a beijing-tm cameraInput" style="top: 0px;left: 0px;" type="file"name="cameraInput"accept="image/*" id="file" onchange="uploadImg(this)" path=''>
            </div>
        </div>
    </font>
</main>
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
        var section1 = $("#section1").height();
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