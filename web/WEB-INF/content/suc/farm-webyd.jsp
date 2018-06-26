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
    <title>${entity.obj.title}</title>
    <!-- Resource style -->
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <script src="${ctx}/app/js/iosOverlay.js"></script>
    <script src="${ctx}/app/js/spin.min.js"></script>
    <link href="${ctx}/app/css/iosOverlay.css" rel="stylesheet"/>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="${ctx}/app/css/font-awesome-ie7.min.css" rel="stylesheet"/>  
    <script src="${ctx}/app/js/jquery.countdown.min.js"></script>
    <script src="${ctx}/mvccol/js/fomatdate3.js"></script>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script> 
       <script>
    
  var issend = true;
  var fypage =0;
  var xszf = "";  
function  ajaxprops(){
   if (!issend) {
         return;
       } 
   var submitData = {
       
   };
    issend = false;
            $.post('${ctx}/suc/farm!ajaxpropsweb.action?custid=${custid}&lscode=${lscode}&fypage=' + fypage, submitData,
                    function (json) {
                        var  xszf = $('#ajaxdiv').html();
                        if (json.state == '0') {
                            var v = json.list;
                            for (var i = 0; i < v.length; i++) {
                                
                                xszf +='<div class="hang90 overflow-hidden width-10 line-bottom-92 position-r" onclick="play(${entity._id},'+v[i]._id+')">'
                                     +'<div class="pull-left img-wh70 position-a" style="top: 10px;left: 10px;">'
                                     +'<img src="${filehttp}/'+v[i].picurl+'" class="width-10">'
                                     +'</div>'
                                     +'<div class="pt-5 pr-10 width-10" style="padding-left: 90px;">'
                                     +'<div class=" hang80" style="display: table-cell;line-height: 20px; vertical-align: middle;">'
                                     +'<font size="2"><div>'
                                     +'<div class="col-6 zi-green sl">'+v[i].title+'</div>'
                                     +'</div>'
                                     +'<font size="1">'
                                     +'<div class="clear" style="display: block;">'+v[i].summary+'</div>'
                                     +'</font></font></div></div></div>'; 
                            
                          }
                            fypage++;
                        } else {
                        }
                        issend = true; 
                        $('#ajaxdiv').html(xszf);
                        if($('#ajaxdiv').html()==''){
                         $('#ajaxdiv').html('暂无道具');
                        }
                        
                    }, "json")
      }
      
 function  ajaxyddetail(){
   if (!issend) {
         return;
       } 
     var submitData = {
         id:'${entity._id}',
         wid:'${entity.obj._id}'
     };
       issend = false;
            $.post('${ctx}/suc/farm!ajaxdetailweb.action?custid=${custid}&lscode=${lscode}', submitData,
                    function (json) {
                        var  xszf = $('#ajaxdetail').html(); 
                        if (json.state == '0') {
                            var v = json.list;
                            for (var i = 0; i < v.length; i++) {
                                
                                xszf +='<div class="position-r pb-10 pt-10 line-bottom">'
                                     +'<div class="overflow-hidden zi-hei" style="padding-left:50px;">'
                                     +'<div class="size12 weight500 pr-5">'+v[i].nickname+'</div>'
                                     +'<div class="pt-3 size12 line-height20 clear">'
                                     +'<i><i class="fa fa-star pr-5 zi-cheng"></i>帮助成长值：<i class="zi-green">'+v[i].growth+'</i></i>'
                                     +'</div></div>'
                                     +'<div class="position-a img-wh40" style="top:10px;">'
                                     +'<div class="img-wh40 img-bj maring-a border-radius50" style="background-image: url(${filehttp}/'+v[i].headimgurl+')"></div>'
                                     +'</div>';
                                     if(typeof(v[i].ydvalue)!="undefined"){
                                     xszf+='<div  class="position-a zi-bai border-radius3 btn-green hang30 line-height30 txt-c zz" onclick="window.location.href=\'${ctx}/suc/farm!webyd.action?custid=${custid}&lscode=${lscode}&id='+v[i].ydvalue+'\'">'
                                     +'<font size="1">帮TA种植</font>'
                                     +'</div></div>';
                                     }else{
                                     xszf+='<div class="position-a zi-bai border-radius3 btn-cheng hang30 line-height30 txt-c zz" onclick="gotofarm(\''+v[i].fromUserid+'\')">'
                                     +'<font size="1">查看动态</font>'
                                     +'</div></div>';
                                     }
                                     
                            
                          }
                            fypage++;
                        } else {
                        }
                        issend = true; 
                        $('#ajaxdetail').html(xszf);
                        if($('#ajaxdetail').html()==''){
                         $('#ajaxdetail').html('<div class="hang70 txt-c zi-hui-tq" style="line-height: 70px;">暂时还没有好友帮忙</div>');
                        }
                        
                    }, "json")
      }
        function textCounter(field, countfield, maxlimit) {
            // 函数，3个参数，表单名字，表单域积分素名，限制字符；
            if (field.value.length > maxlimit)
            //如果积分素区字符数大于最大字符数，按照最大字符数截断；
                field.value = field.value.substring(0, maxlimit);
            else
            //在记数区文本框内显示剩余的字符数；
                countfield.value = maxlimit - field.value.length;
        }
        function phb_xiaoshi() {
            $('#phb_tanchu').hide();
        }
        function phb_xianshi() {
            $('#phb_tanchu').show();
        }

        function wfsm_xiaoshi() {
            $('#wfsm_tanchu').hide();
        }
        function wfsm_xianshi() {
            $('#wfsm_tanchu').show();
        }

        function zz_xiaoshi() {
            $('#zz_tanchu').hide();
        }
        function zz_xianshi() {
            $('#zz_tanchu').show();
            $('#ajaxdiv').html('');
            fypage=0;
            ajaxprops();
        }
    function play(id,pid){
       var submitData = {
          id : id,
          pid:pid
     };
     $.post('${ctx}/suc/farm!ajaxplay.action?custid=${custid}&lscode=${lscode}', submitData, function(json) {
                
                if (json.state == 0) {
        				WeixinJSBridge.invoke('getBrandWCPayRequest',{
        			  		 "appId" : json.appId,"timeStamp" : json.timeStamp, "nonceStr" : json.nonceStr, "package" : json.packageValue,"signType" : json.signType, "paySign" : json.paySign 
        			   			},function(res){  
        			   				if(res.err_msg == "get_brand_wcpay_request:ok"){ 
        			   					 window.location.href="${ctx}/suc/farm!webyd.action?custid=${custid}&lscode=${lscode}&id="+id;
        			   				}else{
        			   				}
        						}); 
        				return;
        			}else if(json.state == 7) {
        				iosOverlay({ 
        			        text:'支付未开通', 
	                        duration: 2e3,  
	                        icon: "${ctx}/img/cross.png" 
	                     }); 
        			}else if(json.state == 3){
        			    //经验已满
        			    iosOverlay({ 
        			        text:'已经成熟', 
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
        			     
        			}else if(json.state == 1){
        			    //未开始
        			    iosOverlay({ 
        			        text:'活动未开始', 
	                        duration: 2e3,  
	                        icon: "${ctx}/img/cross.png" 
	                     });
        			     
        			}else if(json.state == 2){
        			    //已结束
        			    iosOverlay({ 
        			        text:'活动已结束', 
	                        duration: 2e3,  
	                        icon: "${ctx}/img/cross.png" 
	                     });
        			     
        			}else if(json.state == 5){
        			   //次数已完
        			   iosOverlay({ 
        			        text:'道具次数已完', 
	                        duration: 2e3,  
	                        icon: "${ctx}/img/cross.png" 
	                     });
        			    
        			}else if(json.state == 8){
        			   //道具使用成功
        			  window.location.href="${ctx}/suc/farm!webyd.action?custid=${custid}&lscode=${lscode}&id="+id;
        			}
    
     }, "json"); 
    }
    function gotofarm(id){
       if(id==''){
       id='${entity.fromUserid}';
        }
         var submitData = {
          id : id
      };
     $.post('${ctx}/suc/farm!ajaxcreatefarmid.action?custid=${custid}&lscode=${lscode}', submitData, function(json) {
       if(json.state==0){
          window.location.href="${ctx}/suc/farm!myindex.action?custid=${custid}&lscode=${lscode}&id="+json.value;
       }else{
         
       }
    
     }, "json"); 
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
        			   					 alert("投放成功！");
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
        function harvest(){
           var submitData = {
        	   id:'${entity._id}'  
        	}; 
        	 $.post('${ctx}/suc/farm!getcard.action?custid=${custid}&lscode=${lscode}', submitData, function(json) {
             if(json.state==0){ 
                  window.location.href="${ctx}/suc/farm!cardweb.action?lscode=${lscode}&custid=${custid}";
               }else if(json.state==1){
                iosOverlay({ 
        			        text:'还未成熟', 
	                        duration: 2e3,  
	                        icon: "${ctx}/img/cross.png" 
	                     });
               }else if(json.state==2){
                iosOverlay({ 
        			        text:'不能重复领取', 
	                        duration: 2e3,  
	                        icon: "${ctx}/img/cross.png" 
	                     });
	            window.setTimeout(function() {
	             window.location.href="${ctx}/suc/farm!cardweb.action?lscode=${lscode}&custid=${custid}";
	            }, 3e3);
               }   
           }, "json"); 
        }
    </script>

    <style>
        .zz {
            top: 15px;
            right: 0px;
            width: 65px;
        }

        .line-height33 {
            line-height: 33px;;
        }

        .zi-zong {
            color: #9b7446;
        }

        .btn-yn {
            width: 90%;
        }

        .btn-yn:hover {
            width: 85%;
        }

        .btn-lan1 {
            background-color: #11a4e1;
        }

        .btn-lan1:hover {
            background-color: #0e8fc5;
        }
    </style>
</head>
<body class="lock" style="background-color: #fac403;">
<main class="cmp640">
    <div class="width-10 position-r">
        <img class="width-10" src="${ctx}/img/farm/3.png">

        <!--角色头像和现在的状态-->
        <div class="position-a" style="top:10px;left:10px;">
            <div class="position-r">
                <div class="overflow-hidden zi-hei" style="padding-left:50px;">
                    <div class="size12 weight500 pr-5">${entity.nickname}</div>
                    <div class="pt-3 size12 line-height20 clear">
                        <i><i class="fa fa-star pr-5 zi-cheng"></i>成长值：${entity.growth}/${entity.obj.growth}</i>
                        <i class="pl-15"><i class="fa fa-trophy pr-5 zi-cheng"></i>${rankno}</i>
                    </div>
                </div>
                <div class="position-a img-wh40" style="top:0px;">
                    <div class="img-wh40 img-bj maring-a border-radius50"
                         style="background-image: url(${filehttp}/${entity.headimgurl})"></div>
                </div>
            </div>
        </div>
        <!--成长的树-->
        <div class="position-a width-3" style="bottom:20%;left:35%;">
            <div class="width-10 maring-a">
                <img src="" class="width-10" id="tree">
            </div>
        </div>
        <!--圆形按钮--> 
        <c:if test="${entity.bl>=100}"> 
          <c:if test="${empty isadmin}">
              <div class="position-a width-3" style="bottom:-15%;left:35%;">
                <div class="btn-yn maring-a">
                  <img src="${ctx}/img/farm/button/yjcs.png" class="width-10">
                </div>
              </div> 
          </c:if>
          <c:if test="${isadmin=='ok'}">
              <div class="position-a width-3" onclick="harvest()" style="bottom:-15%;left:35%;">
               <div class="btn-yn maring-a">
                <img src="${ctx}/img/farm/button/zqgs.png" class="width-10">
               </div>
              </div>
          </c:if> 
        </c:if>
         <c:if test="${entity.bl<100}"> 
          <c:if test="${empty isadmin}">
              <div class="position-a width-3" onclick="zz_xianshi()" style="bottom:-15%;left:35%;">
                <div class="btn-yn maring-a">
                  <img src="${ctx}/img/farm/button/btpy.png" class="width-10">
                </div>
              </div> 
          </c:if>
          <c:if test="${isadmin=='ok'}">
              <div class="position-a width-3" onclick="zz_xianshi()"" style="bottom:-15%;left:35%;">
               <div class="btn-yn maring-a">
                <img src="${ctx}/img/farm/button/zjpy.png" class="width-10">
               </div>
              </div>
          </c:if> 
        </c:if>
        
    </div>

    <div class="hang20">
       
    </div>
 
    <div class="clear pt-30">
        <font size="2">
            <div class="col-3 hang30 size14 txt-r line-height30 zi-bai">
                <div class="col-7 txt-r sl">-----</div>
                <div class="col-5 size14 txt-c">剩余</div>
            </div>
            <div class="col-6 zi-hui-tq" id="count">
                <div class="col-4">
                    <div class="width-8 maring-a hang30 txt-c bg-bai border-radius3 line-height33"id="count_days">000时
                    </div>
                </div>
                <div class="col-4">
                    <div class="width-8 maring-a hang30 txt-c bg-bai border-radius3 line-height33"id="count_hours">00</div>
                </div>
                <div class="col-4">
                    <div class="width-8 maring-a hang30 txt-c bg-bai border-radius3 line-height33"id="count_minutes">00</div>
                </div>
            </div>
            <div class="col-3 hang30 size14 txt-l line-height30 zi-bai">
                <div class="col-5 size14 txt-c">结束</div>
                <div class="col-7 txt-l sl">-----</div>
            </div>
        </font>
    </div>
    <c:if test="${not empty isadmin}">
    <div class="clear width-9 pb-30 maring-a"> 
         <div class="pt-25 clear" onclick="window.location.href='${ctx}/suc/farm!playinstructions.action?lscode=${lscode}&custid=${custid}&id=${entity.obj._id}'">
            <div class="hang40 maring-a txt-c line-height40 border-radius3 zi-bai btn-lan1 mt-50">
               活动规则
            </div>
         </div>
    </div> 
    </c:if> 
    <c:if test="${empty isadmin}">
    <div class="clear width-9 pb-30 maring-a">
       
         <div class="pt-25 clear" onclick="gotofarm('')">
            <div class="hang40 maring-a txt-c line-height40 border-radius3 zi-bai btn-lan1 mt-50">
                他的动态
            </div>
         </div>
         <div class="pt-25 clear" onclick="moneypay('${entity.obj._id}')">
            <div class="hang40 maring-a txt-c line-height40 border-radius3 zi-bai btn-cheng mt-50">
               我要参与
            </div>
         </div>
         <div class="pt-25 clear" onclick="window.location.href='${ctx}/suc/farm!playinstructions.action?lscode=${lscode}&custid=${custid}&id=${entity.obj._id}'">
            <div class="hang40 maring-a txt-c line-height40 border-radius3 zi-bai btn-lan1 mt-50">
               活动规则
            </div>
         </div>
    </div> 
    </c:if>

    <div class="width-9_5 maring-a position-r pl-10 pr-10 pt-10 pb-10 bg-bai border-radius5">
       
        <div class="pb-10">
            <div class="width-8 size10 zi-bai maring-a clear hang25 line-height25 txt-c bg-cheng"
                 style="border-radius:50px;">
                帮TA种植的人
            </div>
        </div>
        <div id="ajaxdetail"></div>
      

    </div>
    <div class="hang10"></div>
</main>
 
<!--种植弹出-->
<div class="fullscreen cmp640 lock pb-10 bg-hei-5 display-none" id="zz_tanchu">
    <div class="width-9 bg-bai border-radius5 maring-a overflow-hidden position-r"
         style="margin-top:25%">

        <div class="pt-10 pb-10 line-bottom-92 position-r">
            <div class="width-9 zi-hui-tq weight500 maring-a hang25 line-height25 txt-c"
                 style="border-radius:50px;">
                <font size="3">
                    培育类型
                </font>
            </div>
            <div onclick="zz_xiaoshi()" class="position-a txt-c img-wh30" style="top:12px;right:5px;">
                <i class="fa fa-remove zi-hui-tq fa-1dx"></i>
            </div>
        </div>
        <div class="pl-5 pr-5" id="ajaxdiv">
            
        </div>
    </div>
</div>
<!--结束-->
<script>

</script> 
<script> 
	$(function(){ 
		 $('#count').countdown(Date.prototype.format('${entity.obj.enddate}'), function(event) {
		   $('#count_days').html(event.offset.totalDays+"天");
		   $('#count_hours').html(event.offset.hours+"时");
		   $('#count_minutes').html(event.offset.minutes+"分");
		});
	}) 
  ajaxyddetail();
  init();
  function  init(){
   var  num='${entity.bl}';
   var type='${entity.obj.type}';   
   if('${entity.state}'!=2){
      if(num>=0&&num<20){ 
      $('#tree').attr("src","${ctx}/img/farm/"+type+"/s0.png");
      }else if(num>=20&&num<40){
      $('#tree').attr("src","${ctx}/img/farm/"+type+"/s1.png");
      }else if(num>=40&&num<=60){
      $('#tree').attr("src","${ctx}/img/farm/"+type+"/s2.png");
      }else if(num>=60&&num<=80){
      $('#tree').attr("src","${ctx}/img/farm/"+type+"/s3.png");
      }else if(num>=80&&num<=100){
      $('#tree').attr("src","${ctx}/img/farm/"+type+"/s4.png");
      }else if(num>100){
      $('#tree').attr("src","${ctx}/img/farm/"+type+"/s4.png");
     }
   }else{
    $('#tree').attr("src","${ctx}/img/farm/"+type+"/s5.png");
   }
  
  }
 
</script>
<div class="hang50"></div>
<%@ include file="/webcom/farm-foot.jsp" %>
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