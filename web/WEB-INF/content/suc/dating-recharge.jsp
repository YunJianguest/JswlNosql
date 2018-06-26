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
    <title>购买充值</title>
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="${ctx}/app/css/font-awesome-ie7.min.css" rel="stylesheet"/>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="${ctx}/app/js/iosOverlay.js"></script>
    <script src="${ctx}/app/js/spin.min.js"></script>
    <link href="${ctx}/app/css/iosOverlay.css" rel="stylesheet"/>
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
     
     
       $(function () {
            $(".gold").click(function () { 
                $('.gold').find('.txt-c').removeClass("line-fa82a5");
                $(this).find('.txt-c').addClass("line-fa82a5");
                
            })
            $(".member").click(function () { 
                $('.member').find('.txt-c').removeClass("line-fa82a5");
                $(this).find('.txt-c').addClass("line-fa82a5");
                
            })
        })
    
        function no1() {
            if ($("#no1-tanchu").is(":hidden")) {
                $("#no1-tanchu").show();
            } else {
                $("#no1-tanchu").show();
            }
            $("#no2-tanchu").hide();
            $("#no1dingyue-tanchu").hide();
            $("#no1guanli-tanchu").hide();
            $('#tab1').addClass('line-bottom-fa82a5');
            $('#tab1').removeClass('line-bottom-f0f2f2');
            $('#tab2').removeClass('line-bottom-fa82a5');
            
        }
        function no2() {
            if ($("#no2-tanchu").is(":hidden")) {
                $("#no2-tanchu").show();
            } else {
                $("#no2-tanchu").show();
            }
            $("#no1-tanchu").hide();
            $('#tab2').addClass('line-bottom-fa82a5');
            $('#tab2').removeClass('line-bottom-f0f2f2');
            $('#tab1').removeClass('line-bottom-fa82a5');
        }
        function  pay(fag){
           var price=0;
           var remark='';
           var type=0;
           var time;
           if(fag==1){
               $(".gold").each(function(){ 
                if($(this).find(".txt-c").hasClass('line-fa82a5')){
                  price=$(this).find(".txt-c").attr('price');
                }
              });
              
              remark="金币购买";
           }else if(fag==2){
               $(".member").each(function(){ 
                if($(this).find(".txt-c").hasClass('line-fa82a5')){
                  price=$(this).find(".txt-c").attr('price');
                  time=$(this).find(".txt-c").attr('time');
                }
              });
               remark="会员充值";
               type=1;
           }
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
    <style>
        .zi-fa82a5 {
            color: #fd6c8e
        }

        .bottom-fa82a5 {
            background-color: #fd6c8e;
        }

        .bottom-fa82a5:hover, .bottom-fa82a5:focus {
            background-color: #fa5c8e;
        }

        .bg-f7f7f7 {
            background-color: #f7f7f7
        }

        .line-bottom-fa82a5 {
            border-bottom: 3px solid #fa82a5;
            color: #fa82a5;
        }
        .line-fa82a5 {
            border: 1px solid #fa82a5;
        }
        .hang120 {
            height: 120px;
            overflow: auto;
        }

        .line-bottom-f0f2f2 {
            border-bottom: 3px solid #f0f2f2;
            color: #727171;
        }
    </style>
</head>
<body class="lock">
<!--标题放置处-->
<div class="hang40 line-height40 pl-10 pr-10 zi-bai line-bottom cmp640" style="background-color: #fd6c8e">
    <div class="col-3 zi-bai"onclick="self.location=document.referrer;">
        <i class="fa fa-chevron-left pr-5"></i>返回
    </div>
    <div class="col-6">
        <div class="width-9 sl maring-a txt-c">购买充值</div>
    </div>
</div>
<main class="cmp640">
    <font size="2">

        <div class="hang40 line-height40 zi-6">
            <div class="col-6 txt-c line-bottom-fa82a5" id="tab1" onclick="no1()">
                购买缘币
            </div>
            <div class="col-6 txt-c line-bottom-f0f2f2" id="tab2" onclick="no2()">
                充值VIP
            </div>
        </div>

        <div id="no1-tanchu">
            <div class="hang40 line-height40 pl-10 clear bg-f7f7f7 zi-hui-tq weight500">
                已购买缘币用户：<i class="zi-cheng">69568</i>人
            </div>

            <div class="zi-hui-wx hang50 line-height50 txt-c">充值缘币可与MM无限制聊天</div>

            <div class="pl-10 pr-10">
                <div class="col-6  gold ">
                    <div class="width-9_5 txt-c line-lu div-group-5"  price="0.05">
                        <div class="hang30 line-height30 weight500 zi-hei-tq"><font size="3">50缘币</font></div>
                        <div class="hang30 line-height30 weight500 zi-fa82a5"><font size="3">￥2元</font></div>
                        <div class="hang30 line-height30 weight500 zi-fa82a5"><font size="2">购买消息</font></div>
                    </div>
                </div>
                <div class="col-6 gold">
                    <div class="width-9_5 pull-right  txt-c line-lu div-group-5 "  price="0.1">
                        <div class="hang30 line-height30 weight500 zi-hei-tq"><font size="3">260缘币</font></div>
                        <div class="hang30 line-height30 weight500 zi-fa82a5"><font size="3">￥10元</font></div>
                        <div class="hang30 line-height30 weight500 zi-fa82a5"><font size="2">赠送40缘币</font></div>
                    </div>
                </div>
            </div>

            <div class="width-10 clear pt-20 pb-20" onclick="pay(1)">
                <!--没有打招呼时是红色打过招呼之后就是 bg-hei-5-->
                <div class="clear weight500 border-radius3 hang40 txt-c line-height40 zi-bai bottom-fa82a5 width-9_5 maring-a">
                    立即支付
                </div>
            </div>
       <div class="hang40 line-height40 pl-10 bg-f7f7f7 zi-hui-tq">
               缘币特权
            </div>

           <div class="div-group-10 zi-hui-wx">
                <div class="hang25 line-height25 sl"><i class="zi-fa82a5 pr-5 weight500">1.</i>和美女聊天时会消耗缘币，1缘币/条。</div>
          <div class="hang25 line-height25 sl"><i class="zi-fa82a5 pr-5 weight500">2.</i>充值VIP会员后可无限畅聊。</div>
          </div>
            <div class="hang40 line-height40 pl-10 bg-f7f7f7 zi-hui-tq mb-10 display-none">
                购买缘币用户
            </div>

            <div class="div-group-10 zi-hui-wx hang120 display-none">
                <div class="hang25 line-height25 sl"><i class="zi-fa82a5">[用户昵称]</i>8分钟前成功购买10000元缘币，<i
                        class="zi-fa82a5">赠送5000缘币</i></div>
                <div class="hang25 line-height25 sl"><i class="zi-fa82a5">[用户昵称]</i>8分钟前成功购买5000元缘币</div>
                <div class="hang25 line-height25 sl"><i class="zi-fa82a5">[用户昵称]</i>8分钟前成功购买5000元缘币</div>
                <div class="hang25 line-height25 sl"><i class="zi-fa82a5">[用户昵称]</i>8分钟前成功购买5000元缘币</div>
                <div class="hang25 line-height25 sl"><i class="zi-fa82a5">[用户昵称]</i>8分钟前成功购买5000元缘币</div>
                <div class="hang25 line-height25 sl"><i class="zi-fa82a5">[用户昵称]</i>8分钟前成功购买5000元缘币</div>
                <div class="hang25 line-height25 sl"><i class="zi-fa82a5">[用户昵称]</i>8分钟前成功购买5000元缘币</div>
            </div>
        </div>

        <div id="no2-tanchu" class="display-none">
            <div class="hang40 line-height40 pl-10 clear bg-f7f7f7 zi-hui-tq weight500">
                已开通VIP用户：<i class="zi-cheng">55888</i>人
            </div>

            <div class="zi-hui-wx hang50 line-height50 txt-c">开通VIP与MM聊天人数无限制</div>

            <div class="pl-10 pr-10">
                <div class="col-6 member">
                    <div class="width-9_5 txt-c line-lu div-group-5" price="0.05" time="30">
                        <div class="hang30 line-height30 weight500 zi-hei-tq"><font size="3">30天</font></div>
                        <div class="hang30 line-height30 weight500 zi-fa82a5"><font size="3">￥50元</font></div>
                        <div class="hang30 line-height30 zi-hui-wx"><font size="1">(1.6元/天)</font></div>
                    </div>
                </div>
                <div class="col-6 member">
                    <div class="width-9_5 pull-right txt-c line-lu div-group-5" price="0.1" time="90">
                        <div class="hang30 line-height30 weight500 zi-hei-tq"><font size="3">90天</font></div>
                        <div class="hang30 line-height30 weight500 zi-fa82a5"><font size="3">￥100元</font></div>
                        <div class="hang30 line-height30 zi-fa82a5"><font size="1"><i
                                class="zi-hui-wx">(1元/天)</i></font>赠10天VIP
                        </div>
                    </div>
                </div>
            </div>

            <div class="width-10 clear pt-20 pb-20" onclick="pay(2)">
                <div class="clear weight500 border-radius3 hang40 txt-c line-height40 zi-bai bottom-fa82a5 width-9_5 maring-a">
                    立即支付
                </div>
            </div>
            <div class="hang40 line-height40 pl-10 bg-f7f7f7 zi-hui-tq">
                VIP特权
            </div>

            <div class="div-group-10 zi-hui-wx">
                <div class="hang25 line-height25 sl"><i class="zi-fa82a5 pr-5 weight500">1.</i>可与所有用户聊天，人数无限制。</div>
                <div class="hang25 line-height25 sl"><i class="zi-fa82a5 pr-5 weight500">2.</i>查看Ta相册。</div>
                <div class="hang25 line-height25 sl"><i class="zi-fa82a5 pr-5 weight500">3.</i>查看Ta公开的联系方式。</div>
                <div class="hang25 line-height25 sl"><i class="zi-fa82a5 pr-5 weight500">4.</i>与Ta聊天不再需要缘币。</div>
            </div>
            <div class="hang40 line-height40 pl-10 bg-f7f7f7 zi-hui-tq mb-10 display-none">
                已充值VIP用户
            </div>

            <div class=" zi-hui-wx hang100 overflow-auto pl-10 pr-10 display-none">
                <div class="hang25 line-height25 sl"><i class="zi-fa82a5">[用户昵称]</i>8分钟前成功购买90天VIP，<i
                        class="zi-fa82a5">赠送10天VIP</i></div>
                <div class="hang25 line-height25 sl"><i class="zi-fa82a5">[用户昵称]</i>8分钟前成功充值30天VIP</div>
                <div class="hang25 line-height25 sl"><i class="zi-fa82a5">[用户昵称]</i>8分钟前成功充值30天VIP</div>
                <div class="hang25 line-height25 sl"><i class="zi-fa82a5">[用户昵称]</i>8分钟前成功充值30天VIP</div>
                <div class="hang25 line-height25 sl"><i class="zi-fa82a5">[用户昵称]</i>8分钟前成功充值30天VIP</div>
                <div class="hang25 line-height25 sl"><i class="zi-fa82a5">[用户昵称]</i>8分钟前成功充值30天VIP</div>
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
</body>
</html>