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
    <title>微农场</title>
    <!-- Resource style -->
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <script src="${ctx}/app/js/iosOverlay.js"></script>
    <script src="${ctx}/app/js/spin.min.js"></script>
    <link href="${ctx}/app/css/iosOverlay.css" rel="stylesheet"/>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/> 
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="${ctx}/app/css/font-awesome-ie7.min.css" rel="stylesheet"/> 
    <script type="text/javascript" src="${ctx}/app/js/iscroll.js"></script>
    <script src="${ctx}/app/js/main.js"></script>
    <script type="text/javascript" src="${ctx}/app/js/swipe.js"></script>
    <script src="${ctx}/mvccol/js/mtlb.js"></script>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script type="text/javascript" src="${ctx }/app/js/bbsSwipe.js"></script>
 
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
        function ajaxget() {//加载  
            if (!issend) {
                return;
            } 
            var submitData = {
                sel: $('#sel').val().replace('请输入名称或关键字', '')
            };
            issend = false;
            $.post('${ctx}/suc/farm!ajaxweb.action?custid=${custid}&lscode=${lscode}&fypage=' + fypage, submitData,
                    function (json) {
                        var  xszf = $('#ajaxdiv').html();
                        if (json.state == '0') {
                            var v = json.list;
                            for (var i = 0; i < v.length; i++) {
                                
                                xszf += '<div class="overflow-hidden pt-10 pb-10">'
                                     +'<div class="width-10 pl-10 pr-10 overflow-hidden zi-6">'
                                     +'<div class="position-r">'
                                     +'<img src="${filehttp}/'+v[i].picurl+'" class="width-10"></div>'
                                     +'<div class="clear pl-10 pr-10 pt-10">'
                                     +'<div class="col-8">'
                                     +'<div class="maring-a txt-c hang40 line-height40 width-7" style=" border-radius: 100px; border: solid 1px orange;color:orange;" onclick="moneypay('+v[i]._id+')">'
                                     +' 参加活动</div></div>'
                                     +'<div class="col-4" onclick="window.location.href=\'${ctx}/suc/farm!playinstructions.action?lscode=${lscode}&custid=${custid}&id='+v[i]._id+'\'"><div class="txt-c hang40 line-height40"style="color:orange;">'
                                     +'活动规则<i class="pl-10">》》</i>'
                                     +'</div></div></div></div></div>'
                                     +'<div class="hang10 bg-hui"></div>'; 
                         }
                            fypage++;
                        } else {
                        }
                        issend = true; 
                        $('#ajaxdiv').html(xszf);
                        
                    }, "json")
        }
        
        function getcom() {
            $('#ajaxdiv').html(''); 
            fypage = 0;
            ajaxget();
        }
         function moneypay(id){   
        	var submitData = {
        	   id:id  
        	};  
        	$.post('${ctx}/suc/farm!ajaxydpay.action?custid=${custid}&lscode=${lscode}', submitData,
        		function(json) {  
        			if (json.state == 0) {
        				WeixinJSBridge.invoke('getBrandWCPayRequest',{
        			  		 "appId" : json.appId,"timeStamp" : json.timeStamp, "nonceStr" : json.nonceStr, "package" : json.packageValue,"signType" : json.signType, "paySign" : json.paySign 
        			   			},function(res){  
        			   				if(res.err_msg == "get_brand_wcpay_request:ok"){ 
        			   					 
        			   					 window.location.href="${ctx}/suc/advertising!weblist.action?custid=${custid}&lscode=${lscode}";
        			   				}else{
        			   				}
        						}); 
        				return;
        			}else if(json.state == 1) { 
        				 iosOverlay({ 
        				    text:'支付未开通',
	                        duration: 2e3,  
	                        icon: "${ctx}/img/cross.png" 
	                     });
        				issend=true;
        			}else if(json.state == 3){
        			     iosOverlay({ 
	                        duration: 2e3,  
	                        icon: "${ctx}/img/cross.png" 
	                     });
        			}else if(json.state == 4){
        			    //库存已完
        			     iosOverlay({
        			        text:'库存已完', 
	                        duration: 2e3,  
	                        icon: "${ctx}/img/cross.png" 
	                     });
        			
        			}else if(json.state == 5){
        			   //重复预订
        			   window.location.href='${ctx}/suc/farm!webyd.action?custid=${custid}&lscode=${lscode}&id='+json.value;
        			
        			}else if(json.state == 6){
        			   //预订成功
        			   window.location.href='${ctx}/suc/farm!webyd.action?custid=${custid}&lscode=${lscode}&id='+json.value;
        			}
        		},
        		"json");
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
                           onblur="if (value ==''){value='请输入名称或关键字'}"/>
                </div> 
                <div class="col-2 txt-c bg-hui-tx hang30" onclick="getcom()">
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
 
    <div id="ajaxdiv">
    </div> 
    <%@include file="/webcom/return-top.jsp" %>
</main> 
<div class="clear hang50"></div>
<%@ include file="/webcom/farm-foot.jsp" %>
 
<script type="text/javascript"> 
 
    ajaxget();
    $(window).scroll(function () {
        var offsetY = $(window).scrollTop();
        var section1 = $("#section1").height();
        if (section1 - offsetY < 700) {
            //ajaxget();
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