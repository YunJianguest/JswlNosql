<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/limit.jsp" %>
<%@ include file="/webcom/taglibs.jsp" %> 
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
    <title>和${nickname}的聊天</title>
    <!-- Resource style -->
    <script src="${ctx }/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/> 
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script> 
    
    <script src="${ctx}/app/js/iosOverlay.js"></script>
    <script src="${ctx}/app/js/spin.min.js"></script>
    <link href="${ctx}/app/css/iosOverlay.css" rel="stylesheet"/>
    <style>
       ::-webkit-scrollbar {
		  width: 1px;
	    } /* 这是针对缺省样式 (必须的) */
        .zi-fa82a5 {
            color: #fd6c8e
        }

        .bg-fa82a5 {
            background-color: #fd6c8e;
        }

        .bottom-fa82a5 {
            background-color: #fd6c8e;
        }

        .bottom-fa82a5:hover, .bottom-fa82a5:focus {
            background-color: #e36280;
        }
        .lt-left{
            left:-10px; top:10px;  width: 0;height: 0;border-top: 15px solid  #ffffff;border-left: 15px solid transparent;
        }
        .lt-right{
            right:-10px; top:10px;  width: 0;height: 0;border-top: 15px solid  #fa82a5;border-right: 15px solid transparent;
        }
        .right-1{
            right: 1px;
        }
         .zi-fa82a5 {
            color: #fd6c8e
        }
        .line-fa82a5 {
            border: 1px solid #fa82a5;
        }
         .p-top-left-10 {
            top: 10px;
            left: 10px;
        }
         .pl-70 {
            padding-left: 70px;
        }
    </style>
    <%@ include file="/webcom/toast.jsp" %>
    <script type="text/javascript"> 
        (function($){
            $.fn.autoTextarea = function(options) {
                var defaults={
                    maxHeight:null,
                    minHeight:$(this).height()
                };
                var opts = $.extend({},defaults,options);
                return $(this).each(function() {
                    $(this).bind("paste cut keydown keyup focus blur",function(){
                        var height,style=this.style;
                        this.style.height = opts.minHeight + 'px';
                        if (this.scrollHeight > opts.minHeight) {
                            if (opts.maxHeight && this.scrollHeight > opts.maxHeight) {
                                height = opts.maxHeight;
                                style.overflowY = 'scroll';
                            } else {
                                height = this.scrollHeight;
                                style.overflowY = 'hidden';
                            }
                            style.height = height + 'px';
                        }
                    });
                });
            };
        })(jQuery);
    </script>
    <script>
     function  getChat(id) {//加载 
             
            var submitData = { 
              id:id
            }; 
            $.post('${ctx}/suc/dating!GetChatDetail.action?custid=${custid}&lscode=${lscode}&fypage=' + fypage, submitData,
                    function (json) { 
                        if (json.state == '0') {
                            var html='';
                            var obj=json.value;
                            html+='<div class="hang70 overflow-hidden bg-bai width-10 position-r"style="border-bottom: 1px dashed #f0f0f0;">'
                                +'<div class="pull-left img-wh50 overflow-hidden position-a p-top-left-10">'
                                +'<img src="${filehttp}/'+obj.headimgurl+'" class="width-10 border-radius3">'
                                +'</div>'
                                +'<div class="pt-10 pr-10 width-10 pl-70">'
                                +'<font size="2">'
                                +'<div class="hang25 line-height25 zi-6 weight500">'
                                +'<div class="col-9 sl">'+obj.age+'岁，'+obj.province+' '+obj.city+'</div>'
                                +'</div></font>'
                                +'<font size="2">'
                                +'<div class="hang25 line-height25 zi-hui-wx sl weight500">';
                                if(obj.height>0){
                                html+=obj.height+'cm，';
                                }
                                if(obj.income==0){
                                 html+='月收入：2000-3000';
                                }                                                      
                                html+='</div></font></div></div>';
                               $('#info').html(html);
                            
                        } else {
                        } 
                        
                    }, "json")
        }
    
    </script>
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
        var fypage = 0;
        var xszf = "";
        var rid = '${rid}';
        var winheight = window.innerHeight;
        var useragent = navigator.userAgent;
        function ajaxjz() {//加载 
            if (!issend) {
                return;
            }
            issend = false;
            $.post('${ctx}/android/reply!ajaxdetail.action?custid=${custid}&lscode=${lscode}', {id: rid},
                    function (json) {
                        var xszf = $('#ajaxdiv').html();
                        if (json.state == '0') {
                            var v = json.list;
                            for (var i = v.length - 1; i >= 0; i--) {
                                if (v[i].location == "right") {
                                    xszf += '<div class="col-10 pt-15 clear">'
                                    + '<div class="col-2">'
                                    + '<div class="pr-10">'
                                    + '<div class=" maring-a clear img-wh35 img-bj  zi-bai txt-c border-radius3" style="background-image:url(${filehttp}/' + v[i].picurl + ');"></div>'
                                    + '</div></div>'
                                    + '<div class="col-10 position-r">'
                                    + '<div class="position-a lt-left""></div>'
                                    + '<div class="div-group-10 bg-bai zi-hui-wx border-radius5 position-r pull-left">'
                                    + '<div>' + v[i].content + '</div>'
                                    + '</div></div></div>';
                                } else {
                                    xszf += '<div class="col-10 pt-15 pull-right clear">'
                                    + '<div class="col-10 position-r right-1">'
                                    + '<div class="position-a lt-right""></div>'
                                    + '<div class="div-group-10 bg-fa82a5 border-radius5 position-r pull-right zi-bai">'
                                    + '<div>' + v[i].content + '</div>'
                                    + '</div></div>'
                                    + '<div class="col-2"><div class="pl-10">'
                                    + '<div class=" maring-a clear img-wh35 img-bj  zi-bai txt-c border-radius3" style="background-image:url(${filehttp}/' + v[i].picurl + ');">'
                                    + '</div></div></div></div>';
                                }
                            }
                            fypage++;
                        } else {
                        }
                        issend = true;
                        $('#ajaxdiv').html(xszf);
                        scrollmsg();

                    }, "json")
        }

        function createReply() {
            var ids = '${no}';
            ids += ',' + '${id}';

            var submitData = {
                ids: ids,
                pid: '${pid}'
            };
            $.post('${ctx}/android/reply!ajaxreplyadd.action?custid=${custid}&lscode=${lscode}', submitData,
                    function (json) {
                        if (json.state == 0) {
                            rid = json.value; 
                            Init();
                        }
                    }, "json");
        }
        function sendmsg() {
            var time = new Date();
            var content = $('#msg').val();
            var fromid = '${no}';
            var msg = {
                "content": $('#msg').val(),
                "fromUserid": fromid,
                "fromNickname":'${fromNickname}',
                "picurl":'${headimgurl}',
                "toUserid": '${id}' + ",",
                "rid": rid,
                "custid": '${custid}'
            };
            if (content.length > 0) {
            	socket.send(JSON.stringify(msg));
               //MsgService.sendMessage(msg);
                var html = $('#ajaxdiv').html();
                html += '<div class="col-10 pt-15 pull-right clear">'
                + '<div class="col-10 position-r right-1">'
                + '<div class="position-a lt-right"></div>'
                + '<div class="div-group-10 bg-fa82a5 border-radius5 position-r pull-right zi-bai">'
                + '<div>' + content + '</div>'
                + '</div></div>'
                + '<div class="col-2"><div class="pl-10">'
                + '<div class=" maring-a clear img-wh35 img-bj  zi-bai txt-c" style="background-image:url(${filehttp}/${headimgurl});">'
                + '</div></div></div></div>';
                $('#ajaxdiv').html(html);
                $('#msg').val('');
                scrollmsg(); 
                if (useragent.match(/iPhone/i) == "iPhone") {
                } else {
                    $("input").focus();
                }

            } else {
                alert("发送的内容不能为空！");
            }
        }
        function showMessage(data) {
            var message = decodeURI(decodeURI(data.title));
            // var text = dwr.util.getValue("info");
            var xszf = $('#ajaxdiv').html();
            xszf += '<div class="col-10 pt-15 clear">'
            + '<div class="col-2">'
            + '<div class="pr-10">'
            + '<div class=" maring-a clear img-wh35 img-bj  zi-bai txt-c" style="background-image:url(${filehttp}/' + data.picurl + ');"></div>'
            + '</div></div>'
            + '<div class="col-10 position-r">'
            + '<div class="position-a lt-left"></div>'
            + '<div class="div-group-10 bg-bai zi-hui-wx border-radius5 position-r pull-left">'
            + '<div>' + data.content + '</div>'
            + '</div></div></div>';
            $('#ajaxdiv').html(xszf);
            scrollmsg();
        }
        function Init() {
            if (rid != '') {
                getChat('${id}');
                ajaxjz();
                delunfind(rid);
                $('#btsend').attr('onClick', 'checkMsg()');
                //dwr.engine.setActiveReverseAjax(true);
                //dwr.engine.setNotifyServerOnPageUnload(true)
                var custid = '${custid}';
                var lscode = '${lscode}';
               // MsgService.onPageLoad(custid, lscode, rid);
            }
        }
        function scrollmsg() {
            document.getElementById("ajaxdiv").scrollTop = document.getElementById("ajaxdiv").scrollHeight + window.innerHeight;
        }
        function onscll() {
            if (useragent.match(/iPhone/i) == "iPhone") {

            } else {
                $('#ajaxdiv').css('height', (winheight / 2 - 47-20-70) + 'px');
            }
            scrollmsg();
        }
        function changescll() {
            $('#ajaxdiv').css('height', (winheight - 47-10-70) + 'px');
            scrollmsg();
        }
        window.onresize = function () {
            if ($("input").is(":focus") && window.innerHeight == winheight) {
                changescll();
                $("input").blur();
            }
        }
         function delunfind(id){
            var submitData = {
                rid:id, 
            };
            $.post('${ctx}/android/reply!delunfind.action?custid=${custid}&lscode=${lscode}', submitData,
                    function (json) {  
                     if(json.state==0){ 
                         
                       } 
                    }, "json");
        }
        function checkMsg(){
          var content = $('#msg').val();
          if(content.length<= 0){
            alert('内容不能为空');
            return;
          } 
            var submitData = { 
            };
            $.post('${ctx}/suc/dating!deductMsg.action?custid=${custid}&lscode=${lscode}', submitData,
                    function (json) {  
                     if(json.state==0){
                        sendmsg();   
                       }else if(json.state==1){ 
                         sendmsg();
                         alert("您今天的免费消息已经用完！");
                       }else if(json.state==2){ 
                         sendmsg(); 
                       }else if(json.state==3){ 
                    	   sendmsg(); 
                         //$('#pay_tc').show();
                       } 
                    }, "json");
        }
        function  pay_hide(){
         $('#pay_tc').hide();
        }
         $(function () {
            $(".gold").click(function () { 
                $('.gold').find('.txt-c').removeClass("line-fa82a5");
                $(this).find('.txt-c').addClass("line-fa82a5");
                
            })
           
        })
        function  pay(){
           var price=0;
           var remark='';
           var type=0;
           var time; 
           $(".gold").each(function(){ 
              if($(this).find(".txt-c").hasClass('line-fa82a5')){
                  price=$(this).find(".txt-c").attr('price');
                  if(price==0.03){
                   time=$(this).find(".txt-c").attr('time');
                   type==1;
                   remark="会员充值";
                  }else{
                   time=0;
                   type==0;
                   remark="金币购买";
                  }
                  
              }
           }); 
           if(price==0){
            alert("请选择支付套餐");
            return;
           }  
           var submitData = { 
        		price:price,
        		remark:remark,
        		type:type,
        		time:time	 
        			
        	}; 
        	load('加载中');
        	$.post('${ctx}/suc/dating!wxpayGold.action?custid=${custid}&lscode=${lscode}', submitData,
        		function(json) { 
        		     loading.hide();
        		 	if (json.state == 0) { 
        				WeixinJSBridge.invoke('getBrandWCPayRequest',{
        			  		 "appId" : json.appId,"timeStamp" : json.timeStamp, "nonceStr" : json.nonceStr, "package" : json.packageValue,"signType" : json.signType, "paySign" : json.paySign 
        			   			},function(res){  
        			   				if(res.err_msg == "get_brand_wcpay_request:ok"){  
        			   				   alert('支付成功！');
        			   				}else{
        			   				
        			   					//alert(res.err_code+res.err_desc+res.err_msg);
        			   					 
        			   				}
        						}); 
        				return;
        			}else if(json.state == 1) {
        				alert("该账号没有开通支付"); 
        			}else if(json.state == 3){
        			  alert("没有登录");
        			}else if(json.state==10){
        			  alert("购买次数已完");
        			}
        		},
        		"json")
        }
    </script>
</head>
<body class="bg-hui">
<main class="cmp640">
    <div id="info" style="top: 0;z-index: 5;position: fixed;width: 100%;max-width: 640px;min-width: 320px;margin: 0px auto"></div>
    <div style="height: 70px"></div>
    <div id="ajaxdiv"class="pl-10 pr-10"  style="overflow: auto;">
    </div>
    <!--bottom-->
    <div class="hang60">
    </div>
    
     <div class="position-f shadow-wai zi-hui cmp640" style="border-radius: 0px 0px 10px 10px;bottom:0px; left: 0px;">

        <div class=" div-group-5 zi-hui overflow-hidden bg-bai">
            <div class="zi-hui txt-c weight100 pt-3">
                <div class="col-10 pr-5 zi-hong size14 weight500 ">
                    <textarea  class=" width-10 div-group-5 line-lu border-radius3 zi-hui"
                              style="background-color: transparent;line-height:20px;height:35px;" type="text" id="msg"
                              onfocus="onscll()" onblur="changescll()" ></textarea>
                </div>
                <div class="col-12 position-r">
                    <font size="2">
                        <div class="bottom-fa82a5 zi-bai border-radius3 position-a col-2"style="bottom:0px;right:0px; line-height:35px" id="btsend">发送</div>
                    </font>
                </div>
            </div>
        </div>

    </div>
     

</main>

<!--点击发私信后提示框-->
<div class="fullscreen cmp640 bg-hei-5 lock display-none" id="pay_tc">
    <div class="overflow-hidden width-10">
        <a href="javascript:pay_hide()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>
        <div class=" cmp640 position-f position-r" style="top:30%;left:0px;z-index: 99;">
            <div class="maring-a position-r border-radius3 div-group-10 bg-bai" style="width:290px;">
                <a href="javascript:pay_hide()">
                    <div class="position-a" style="right:-10px;top:-10px;z-index: 101;">
                        <div class="img-wh25 border-radius50 bg-hei-5 txt-c">
                            <font size="3">
                                <i class="fa fa-remove zi-bai" style="line-height:27px"></i>
                            </font>
                        </div>
                    </div>
                </a>
                <div class=" width-10 border-radius5 zi-hui-tq overflow-hidden">
                    <font size="2"> 
                        <div class="weight500" style="line-height: 22px;">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp尊敬的的用户，您的免费消息已经用完，您可以进行付费发送或者充值VIP（vip特权：发送消息免费）
                              
                        </div>
                    </font>
                </div>
                <div class="pt-15">
                    <div class="col-6 gold">
                        <div class="width-9_5 txt-c line-fa82a5 line-lu div-group-5" price="0.05">
                            <div class="hang20 line-height20 weight500 zi-hei-tq"><font size="2">3000缘币</font></div>
                            <div class="hang20 line-height20 weight500 zi-fa82a5"><font size="2">￥30元</font></div>
                            <div class="hang20 line-height20 zi-hui-wx"><font size="1">1.0缘币/条</font></div>
                        </div>
                    </div>
                    <div class="col-6 gold">
                        <div class="width-9_5 pull-right txt-c line-lu div-group-5 " price="0.03" time="90">
                            <div class="hang20 line-height20 weight500 zi-hei-tq"><font size="2">90天</font></div>
                            <div class="hang20 line-height20 weight500 zi-fa82a5"><font size="2">￥100元</font></div>
                            <div class="hang20 line-height20 zi-fa82a5"><font size="1"><i
                                    class="zi-hui-wx">(1元/天)</i></font>赠10天VIP
                            </div>
                        </div>
                    </div>
                </div>
                <div class="button_group1 width-10 pt-20">
                    <div class="border-radius3 btn-green zi-bai txt-c hang40 line-height40" onclick="pay()">
                        微信安全支付
                    </div>
                </div>

            </div>

        </div>
    </div>
</div>

</body>
<script type="text/javascript">

        $("textarea").autoTextarea({
            maxHeight:60,
            minHeight:35
        });
</script>
<script src="${ctx}/app/js/alert_show.js"></script>
<script >

var socket = new WebSocket("ws://www.pskjyf.com/websocket");  
socket.onopen = function() { 
		     $.post('${ctx}/user/remind!getUserid.action?custid=${custid}&lscode=${lscode}', null, function(json) {
		       if(json.state==0){ 
		    		var msg = {
		    				"init" : "init",
		    				"uid" : json.value,
		    				"custid" : "${custid}",
		    				"rid":rid
		    			};
		    		socket.send(JSON.stringify(msg)); 
		       }else{ 
		       } 
		     }, "json"); 
	
};

socket.onclose = function(evt) { 
}
socket.onerror = function(evt) { 
} 
document.onkeydown = function(event){
	var e = event || window.event || arguments.callee.caller.arguments[0];
	if(e && e.keyCode == 13){ // enter 键
		emit();
	}
};
function encodeScript(data) {
	if(null == data || "" == data) {
		return "";
	}
	return data.replace("<", "&lt;").replace(">", "&gt;");
}
socket.onmessage = function(evt) {
	 var data = JSON.parse(evt.data);
	 if(data.custid=="${custid}"&&data.rid==rid){
		 var message = decodeURI(decodeURI(data.title));
	     // var text = dwr.util.getValue("info");
	     var xszf = $('#ajaxdiv').html();
	     xszf += '<div class="col-10 pt-15 clear">'
	     + '<div class="col-2">'
	     + '<div class="pr-10">'
	     + '<div class=" maring-a clear img-wh35 img-bj  zi-bai txt-c" style="background-image:url(${filehttp}/' + data.picurl + ');"></div>'
	     + '</div></div>'
	     + '<div class="col-10 position-r">'
	     + '<div class="position-a lt-left"></div>'
	     + '<div class="div-group-10 bg-bai zi-hui-wx border-radius5 position-r pull-left">'
	     + '<div>' + data.content + '</div>'
	     + '</div></div></div>';
	     $('#ajaxdiv').html(xszf);
	     scrollmsg();
	 }
	
};  
</script>


<script>

    if ('${rid}' == '') {
        createReply();
    } else {
        Init();

    }
    $('#ajaxdiv').css('height', (window.innerHeight - 47-10-70) + 'px');
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