<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ include file="/webcom/limit.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/style_0.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"> 
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <style>
        .hang25 {
            height: 25px;
            line-height: 25px;
        }
        .pr-7 {
            padding-right: 7px;
        }

        .yListr3 .zhiding .div3 {
            border: 1px solid #45c01a;
            position: relative;
            color: #45c01a;
        }
    </style>
    <script>
     $(function () {
            $(".yListr3 li").click(function () {
                $(this).addClass("zhiding").siblings().removeClass("zhiding");
                settime('');
            })
        })
        var iprice=0;
        var fag='';
        var type='';
        function setprice(v,thi){
          iprice=v;
          fag=$(thi).html();
        }
       function upd(){
       var url=$('#url').val();
       if(url=="http://"){
       url=='';
       }
       var submitData = {
                id:'${entity._id}',
    	        picurl:$('#picurl').val(),
    	        url:url, 
	            }; 
      $.post('${ctx}/suc/advertising!ajaxadd.action?custid=${custid}&lscode=${lscode}', submitData,
        	 function(json){
        	  if(json.state==0){ 
        	  window.location.href='${ctx}/suc/advertising!weblist.action?custid=${custid}&lscode=${lscode}';
        	  }else{
        	   alert("添加失败！");
        	  }
        	 },"json");
    }
    function settime(){ 
    var xs=parseInt($('#itime').val());
      if(xs>0){ 
      if(fag.indexOf('时')>0){
       $('#time').val(xs); 
       $('#xstime').html(xs+"时");
       
       }else if(fag.indexOf('天')>0){
        $('#time').val(xs*24); 
        $('#xstime').html(xs+"天");
       }else if(fag.indexOf('月')>0){
        $('#time').val(xs*24*30); 
        $('#xstime').html(xs+"月");
       }
       $('#price').val(xs*iprice); 
       $('#xsprice').html($('#price').val());
       }
    }
     function moneypay(){ 
            if($('#xstime').html().length<=0||$('#itime').val().replace('所需的时间数量','')==''){
             alert('请选择广告类型或输入时间'); 
             return;
            }
             var url=$('#url').val();
            if(url=="http://"){
             url=='';
            }
            if($('#picurl').val().length==0){
             alert('请上传广告'); 
             return;
            } 
    	    var remark="广告投放";
        	var submitData = { 
        		  picurl:$('#picurl').val(),
    	          url:url,
    	          price:$('#price').val(),
    	          time:$('#time').val(),
    	          type:'bbs_adv',
    	          remark:remark, 
        	};  
        	$.post('${ctx}/suc/advertising!wxpay.action?custid=${custid}&lscode=${lscode}', submitData,
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
        				alert("该账号没有开通支付");
        				issend=true;
        			}else if(json.state == 3){
        			  alert("没有登录");
        			}
        		},
        		"json")
        }
        function settype(v,thi){
        type=v;
        $('#tanchushezhi2').hide();
        $('#type').html($(thi).html());
        }
        function showtype(){
         $('#tanchushezhi2').show();
        }
    </script>
</head>
<body class="bg-bai">
<main class="cmp640">
    <input id="picurl" type="hidden" value="${entity.picurl}"/>
    <input id="time" type="hidden"value="${entity.time}"/>
    <input id="price" type="hidden"value="${entity.price}"/>
    <div class="width-10 clear position-r" id="tanchuguanggao">
        <div class="bg-hui"></div>
        <c:if test="${not empty entity.picurl}">
        <a href="#">
            <img src="${filehttp}/${entity.picurl}" width="100%">
        </a>
        </c:if>
        <c:if test="${empty entity.picurl}">
        <a href="#">
            <img src="${ctx}/mvccol/img/adver/guanggaoyulan.jpg" width="100%">
        </a>
        </c:if>
        <a href="javascript:xiaoshiguanggao()"class="display-none">
            <div class="position-a zi-green pl-10 pb-10" style="top:8px; right:3px;">
                <div class="img-wh18 txt-c border-radius50 bg-bai">
                    <font size="2">
                        <i class="fa fa-remove weight500" style="line-height:20px;"></i>
                    </font>
                </div>
            </div>
        </a>
    </div>
  <div class="pt-20">
      <div class="pt-7 col-3">
          <div class="txt-c zi-hui-wx hang25 weight500">
              <font size="2"> 广告图片：</font>
          </div>
      </div>
      <div class="pull-left">
          <div class="img-wh30 overflow-hidden">
              <div class="position-r">
                  <div class=" img-wh30 img-bj div-group-5 border-radius5 line-lu" onclick="javascript:pz('picurl','600','70',false,'tanchuguanggao')">
                      <img src="${contextPath}/mvccol/img/addimg.png" class="width-10">
                  </div>
                 
              </div>
          </div>
      </div>
      <div class="col-7 pl-5 pt-8">
          <div class="zi-hui-wx hang25">
              <font size="2">点击上传（图片尺寸为600x70px）</font>
          </div>
      </div>
  </div>
    <div class="clear pt-15">
        <div class="pt-7 col-3">
            <div class="txt-c zi-hui-wx hang25 weight500">
                <font size="2">广告连接：</font>
            </div>
        </div>
        <div class="col-9  overflow-hidden weight500 yListr3">
            <li class="pr-7 pt-7">
                <div class="div3 txt-c zi-hui-wx pl-5 pr-5 line-lu border-radius3 pt-5 overflow-hidden hang25">
                    <input id="url" class="width-10 zi-hui-wx " style="height: 15px; line-height:15px" type="text"
                           name=""
                           value="${adv.url}"
                           placeholder="请输入链接">
                </div>
            </li>
        </div>
    </div>
    <c:if test="${empty entity}">
    <div class=" overflow-auto clear">
        <font size="1" class="">
            <div class="clear pt-15">
                <div class="pt-7 col-3">
                    <div class="txt-c zi-hui-wx hang25 weight500">
                        <font size="2"> 广告价格：</font>
                    </div>
                </div>
                <c:if test="${not empty price}">
                  <div class="col-9 overflow-hidden weight500 yListr3">
                   <c:forEach items="${price}" var="bean">
                      <li class="pr-7 pt-7 col-4">
                        <div class="div3 txt-c zi-hui-wx line-lu border-radius3 hang25" onclick="setprice('${bean.price}',this)">
                            ${bean.title}
                        </div>
                    </li>
                   </c:forEach>
                </div>
                </c:if>
            </div>
            <div class="clear pt-15">
                <div class="pt-7 col-3">
                    <div class="txt-c zi-hui-wx hang25 weight500">
                        <font size="2">投放时长：</font>
                    </div>
                </div>
                <div class="col-5  overflow-hidden weight500 yListr3">
                    <li class="pr-7 pt-7">
                        <div class="div3 txt-c zi-hui-wx line-lu border-radius3 overflow-hidden hang25">
                            <input id="itime" class="width-10 txt-c zi-hui-wx " style="height: 25px; line-height:23px" type="text"
                                   name=""
                                   value="所需的时间数量" oninput="settime('time')"
                                   onfocus="if(this.value=='所需的时间数量'){this.value=''};this.style.color='#45c01a';"
                                   onblur="if(this.value==''||this.value=='所需的时间数量'){this.value='所需的时间数量';this.style.color='#aaa';}">
                        </div>
                    </li>
                </div>
            </div>
            <div class="pt-25 weight500 overflow-hidden clear">
                <font size="2">
                    <div class="txt-c zi-hui-wx">
                        您此条广告投放时间为<i id="xstime"></i><i></i>需<i class="zi-green" id="xsprice">0</i>元。
                    </div>
                </font>
            </div>
            <div class="pt-20 clear" onclick="moneypay()">
                <div class="clear width-5 maring-a txt-c zi-bai btn-green weight500 border-radius3 hang30"
                     style="line-height: 32px;">
                    <font size="2">
                        确认支付
                    </font>
                </div>
            </div>
        </font>
    </div>
    </c:if>
    <c:if test="${not empty entity}">
     <div class="pt-30 clear" onclick="upd()">
                <div class="clear width-5 maring-a txt-c zi-bai btn-green weight500 border-radius3 hang30"
                     style="line-height: 32px;">
                    <font size="2">
                        确认保存
                    </font>
          </div>
    </div>
    </c:if>
    <div class="pt-50">
        <div class="div-group-5 pt-7 pl-20 zi-bai pull-left pr-20 bg-green " style="border-radius: 0px 100px 100px 0px;">
            <font size="2">重要提示</font>
        </div>
    </div>
    <div class="zi-hui-tq div-group-5 pt-10 clear weight500" style="line-height:22px;">
        <font size="2">
            <div>1：请勿发布违反国家法律，国家网络安全内容，（如：色情，暴力，木马...等内容）</div>
            <div class="pt-5">2：请勿发布虚假广告内容，遵守《广告法》，如：xxx全球销量排名第一，等违反《广告法》</div>
            <div class="pt-5">一经发现，广告将被关闭！费用不予退款！！！</div>
        </font>
    </div>
</main>
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="tanchushezhi2">
    <div class="overflow-hidden width-10">
        <a href="javascript:shezhixiaoshi2()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>
        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5">
             <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-bai" onclick="settype('bbs_adv',this)">
                                   论坛
             </div>
            </div>
            <a href="javascript:shezhixiaoshi2()">
                <div class="pt-10">
                    <div class="border-radius5 maring-a width-9_5 zi-bai txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                        取消
                    </div>
                </div>
            </a>
        </div>
    </div>
</div>
<%@include file="/webcom/cut-image.jsp"%>
<script language="JavaScript"> 
wx.config({
    debug: false,
    appId: '${token.appid}', 
    timestamp: '${token.timestamp}', 
    nonceStr: '${token.noncestr}', 
    signature: '${token.signature}',
    jsApiList: [ 'checkJsApi',
            'onMenuShareTimeline',
            'onMenuShareAppMessage',
            'onMenuShareQQ',
            'onMenuShareWeibo',
            'hideMenuItems',
            'showMenuItems',
            'hideAllNonBaseMenuItem',
            'showAllNonBaseMenuItem',
            'translateVoice',
            'startRecord',
            'stopRecord',
            'onRecordEnd',
            'playVoice',
            'pauseVoice',
            'stopVoice',
            'uploadVoice',
            'downloadVoice',
            'chooseImage',
            'previewImage',
            'uploadImage',
            'downloadImage',
            'getNetworkType',
            'openLocation',
            'getLocation',
            'hideOptionMenu',
            'showOptionMenu',
            'closeWindow',
            'scanQRCode',
            'chooseWXPay',
            'openProductSpecificView',
            'addCard',
            'chooseCard',
            'openCard'
                 ] 
});
wx.ready(function(){
	var share={
		    title: '${title}', // 分享标题
		    desc: '${entity.summary}', // 分享描述
		    link: '${token.url}', // 分享链接
		    imgUrl: '${osshttp}${entity.logo}', // 分享图标
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