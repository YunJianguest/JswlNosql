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
    <title>小象兼职</title>
    <!-- Resource style -->
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet">
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="${ctx}/app/js/iosOverlay.js"></script>
    <script src="${ctx}/app/js/spin.min.js"></script>
    <link href="${ctx}/app/css/iosOverlay.css" rel="stylesheet"/>
    <style>
        .btn-26bd93 {
            background-color: #26bd93;
        }

        .btn-26bd93:hover {
            background-color: #21a883;
        }
    </style>
     <script>
        var loading;
        function  loading(){
        var opts = {
		lines: 13, // The number of lines to draw
		length: 8, // The length of each line
		width: 4, // The line thickness
		radius: 13, // The radius of the inner circle
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
		text: "Loading", 
		spinner: spinner
	   });
     } 
     
   function wxtx() { 
            if(true){ 
              iosOverlay({ 
        			        text:'提现维护中', 
	                        duration: 2e3,  
	                        icon: "${ctx}/img/cross.png" 
	                       }); 
	                       return; 
            }
            var price=parseFloat($('#price').val());
            var pprice='${entity.price}'; 
            if(pprice<price){
              iosOverlay({ 
        			        text:'余额不足', 
	                        duration: 2e3,  
	                        icon: "${ctx}/img/cross.png" 
	                       }); 
	                       return;
            }
            if(isNaN(price)||price>200||price<1){
                 iosOverlay({ 
        			        text:'输入金额有误', 
	                        duration: 2e3,  
	                        icon: "${ctx}/img/cross.png" 
	                       }); 
	                       return;
            } 
            var submitData = {
                remark:"感谢您使用本平台，本次提现完成！",
                act_name:"兼职提现",
                wishing:"感谢您使用本平台，本次提现完成！",
                price:price,
            }; 
            loading();
            $.post('${ctx}/parttime/mission!wxtx.action?custid=${custid}&lscode=${lscode}', submitData,
                    function (json) { 
                     loading.hide(); 
                        if (json.state==0) { 
                            iosOverlay({ 
        			        text:'提现成功，请尽快领取！', 
	                        duration: 2e3,  
	                        icon: "${ctx}/img/check.png" 
	                     }); 
                        }else if(json.state==1){
                            iosOverlay({ 
        			        text:'提现失败，没有开通支付！', 
	                        duration: 2e3,  
	                        icon: "${ctx}/img/cross.png" 
	                       }); 
                        }else if(json.state==3){
                           iosOverlay({ 
        			        text:'提现失败，登录异常！', 
	                        duration: 2e3,  
	                        icon: "${ctx}/img/cross.png" 
	                       }); 
                        }else if(json.state==2){
                           iosOverlay({ 
        			        text:'提现失败，余额不足！', 
	                        duration: 2e3,  
	                        icon: "${ctx}/img/cross.png" 
	                       }); 
                        }else if(json.state==4){
                            iosOverlay({ 
        			        text:'提现失败，金额有误！', 
	                        duration: 2e3,  
	                        icon: "${ctx}/img/cross.png" 
	                       }); 
                        }
                    }, "json")
        }
    </script>
</head>
<body class="cmp640">
<main>
    <div class=" pull-right zi-lan-tq div-group-10"  onclick="window.location.href='${ctx}/parttime/mission!withposidet.action?custid=${custid}&lscode=${lscode}'">
        提现明细
    </div>
    <div class="clear img-wh110 txt-c maring-a border-radius50"
         style="background-color:#fbdf66;color: #f9ca01;border: solid 7px #f9ca01;">
        <i class="fa fa-diamond fa-4x" style="line-height: 96px;"></i>
    </div>
    <font size="3">
        <div class="txt-c pt-10">我的佣金</div>
        <div class="pt-10 weight500 txt-c" style="color:#f9ca01">￥${data}</div>
    </font>


    <div class="width-9 maring-a">
        <div class="txt-c pt-15 zi-hui-wx">提现微信账号：${user.nickname}</div>
        <div class="pt-15 txt-c">提现金额￥
            <input class=" size14 zi-hui weight500 txt-c line-bottom"style="width:70px;" type="text" name=""
                   value="0">
        </div>
    </div>

    <div class="pt-20" onclick="wxtx()">
        <div class="hang50 weight500 txt-c size16 width-9 maring-a border-radius5 line-height50 zi-bai btn-26bd93">
            提现
        </div>
    </div>

    <div class="txt-c hang40 zi-hui-wx line-height40">
        <font size="1">
            每次提现金额为1-200元，1小时之内到账无手续费
        </font>
    </div>

</main>
<%@include file="/webcom/mission-foot.jsp"%>
</body>
</html>