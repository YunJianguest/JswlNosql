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
    <!-- Resource style -->
    <script src="${ctx }/app/js/jquery-1.8.3.js"></script>
    <script src="${ctx}/app/js/iosOverlay.js"></script>
    <script src="${ctx}/app/js/spin.min.js"></script>
    <link href="${ctx}/app/css/iosOverlay.css" rel="stylesheet"/>
    <script type="text/javascript" src="${ctx }/app/js/jquery.Spinner.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx }/app/css/font-awesome.min.css" rel="stylesheet">
    <link href="${ctx }/app/css/font-awesome-ie7.min.css" rel="stylesheet">
    <link href="${ctx }/app/css/style_0.css" rel="stylesheet"> 
    <%@ include file="/webcom/toast.jsp" %>
    
    <script type="text/javascript">
         var total=0;
         var remoney=0;
         var jfdh=0;
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
  
         function moneypay(){
         if('${address.tel}'==""){
            alert("请先设置收货地址");
            return ;
           }
           if('${entity.jfdh}'>0&&'${entity.kdprice}'==0){
             jfpay();
             return;
           }
           if('${count}'==0){
            alert("数量不能为空请重新选择购买");
            return ;
           }
            var address='${address.province}'+"-"+'${address.city}'+"-"+'${address.county}'+" "+'${address.address}';
        	var submitData = { 
        			lx:0,
        			no:'0',
        			name:'${address.name}',
        			tel:'${address.tel}',
        			address:address, 
        			total:total, 
                	remoney:'${entity.price}',
                	recordid:'${entity._id}', 
        			price:total,
        			remark:'${entity.ptitle}',
        			comid:'${entity.comid}',
        			kjid:$("#kdpric").val(),
        			num:'${count}',
        			logo:'${entity.logo}',
        			title:'${entity.title}',
        			spec:'${spec}',
        			jffh:'${entity.jffh}',
        			jfdh:jfdh,
        			
        	}; 
        	loading();
        	$.post('${ctx}/shop/shop!wxpay.action?custid=${custid}&agid=${agid}&lscode=${lscode}', submitData,
        		function(json) { 
        		     loading.hide();
        		 	if (json.state == 0) { 
        				WeixinJSBridge.invoke('getBrandWCPayRequest',{
        			  		 "appId" : json.appId,"timeStamp" : json.timeStamp, "nonceStr" : json.nonceStr, "package" : json.packageValue,"signType" : json.signType, "paySign" : json.paySign 
        			   			},function(res){  
        			   				if(res.err_msg == "get_brand_wcpay_request:ok"){  
        			   					 var text='购买成功！';
        			   					 if(!jQuery.isEmptyObject(json.jffh)){
        			   					   text="购买成功！获得积分"+json.jffh
        			   					 }
        			   					 noty({text: text,type:'alert', layout: "top", timeout: 1000,callback: { // 回调函数
                                              afterClose: function() {
                                        window.location.href="${ctx}/shop/shop!orderform.action?custid=${custid}&agid=${agid}&lscode=${lscode}";
                                              } // 关闭之后
                                            },});
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
        function  jfpay(){
         var address='${address.province}'+"-"+'${address.city}'+"-"+'${address.county}'+" "+'${address.address}';
        	var submitData = { 
        			lx:0,
        			no:'0',
        			name:'${address.name}',
        			tel:'${address.tel}',
        			address:address, 
        			total:total, 
                	remoney:'${entity.price}',
                	recordid:'${entity._id}', 
        			price:total,
        			remark:'${entity.ptitle}',
        			comid:'${entity.comid}', 
        			num:'${count}',
        			logo:'${entity.logo}',
        			title:'${entity.title}',
        			spec:'${spec}',
        			jffh:'${entity.jffh}',
        			jfdh:jfdh,
        			
        	}; 
        	$.post('${ctx}/shop/shop!jfpay.action?custid=${custid}&agid=${agid}&lscode=${lscode}', submitData,
        		function(json) { 
        			if (json.state == 0) {
        				  noty({text: "兑换成功！",type:'alert', layout: "top", timeout: 1000,callback: { // 回调函数
                                              afterClose: function() {
                                        window.location.href="${ctx}/shop/shop!orderform.action?custid=${custid}&agid=${agid}&lscode=${lscode}";
                                              } // 关闭之后
                                            },});
        			}else{
        			  noty({text: "兑换异常！",type:'alert', layout: "top", timeout: 1000,callback: { // 回调函数
                                              afterClose: function() {
                                       // window.location.href="${ctx}/shop/shop!orderform.action?custid=${custid}&agid=${agid}&lscode=${lscode}";
                                              } // 关闭之后
                                            },});
        			}
        		},
        		"json")
        
        
        }
   
    </script>
    <style>
        .bk {
            height: 70px;
            width: 90px;
        }

        .button-kong {
            width: 30px;
            height: 30px;
            line-height: 26px;
            border-top: solid 2px #eee;
            border-bottom: solid 2px #eee;
        }

        .line-height33 {
            line-height: 33px;
        }
         .hang2-bj {
            height: 2px;
            background-image: url(${ctx}/img/scdz-xz.png);
        }
    </style>
</head>
<body>
 
<main class="clear cmp640 lock">
    <c:if test="${not empty address}">
     <a href="${ctx}/shop/shop!useraddress.action?lscode=${lscode}&custid=${custid}&agid=${agid}&addressis=ok&backurl=/shop/shop!orderconfirmation.action?pid=${entity._id}&count=${count}&price=${price}&spec=${spec}">
        
        <font size="2">
            <div class="div-group-10 overflow-hidden zi-6 weight100 col-11">
                <div class="">
                    <div class="pull-left">收货人:<i>${address.name}</i></div>
                    <div class="pull-right">${address.tel}</div>
                </div>
                <div class="clear pt-5">
                    <div class="pull-left txt-l sl width-10">收货地址:<i>${address.address}</i></div>
                </div>
            </div>
            <div class="col-1 div-group-5 txt-c zi-hui hang40 overflow-hidden">
                <i class="fa fa-chevron-right fa-1dx" style="line-height:50px;"></i>
            </div>
            <div class="hang10  clear"></div>
        </font>
         <div class="hang2-bj"></div>
        <div class="hang10 bg-hui clear"></div>
     </a>
    
    </c:if>
    <c:if test="${empty address}">
    <a href="${ctx}/shop/shop!useraddresssave.action?lscode=${lscode}&custid=${custid}&agid=${agid}&addressis=err&backurl=/shop/shop!orderconfirmation.action?pid=${entity._id}&count=${count}&price=${price}&spec=${spec}">
     <div class="hang60 div-group-10">
        <div class="hang40 line-height40">
            <div class="img-wh40 pull-left txt-c line-height40 bj-lan3 zi-bai border-radius5"><i
                    class="fa fa-plus fa-1dx line-height40"></i></div>
            <div class="zi-hui pl-15 pull-left">新增收货地址</div>
            <div class="zi-hui pull-right"><i class="fa fa-1dx fa-angle-right line-height40"></i></div>
     </div>
    </div>
    <div class="hang2-bj"></div>
    <div class="hang10 bg-hui clear"></div>
    </a>
    </c:if>
    <div class="clear"></div>

    <div class="line-bottom div-group-10 overflow-hidden position-r" style="height:90px;">
        <div class=" position-a">
            <div class="img-bj bk border-radius3" style="background-image: url(${filehttp}/${entity.logo});"></div>
        </div>
        <div style="padding-left:100px;">
            <div class="zi-6 weight500 pt-2">
                <font size="2">
                    <div class="col-10 sl zi-hei">${entity.ptitle}</div>
                </font>
            </div>
            <div class="pull-left weight500">
                <font size="2">
                    <div class="clear sl hang30" style="line-height:35px;">
                        <span class="zi-hui">规格：${spec}</span>
                    </div>
                    <div class="sl hang30" style="line-height:30px;">
                      <c:if test="${empty entity.jfdh||entity.jfdh==0}">
                       <c:if test="${empty price}">
                       <span class="zi-cheng">￥<fmt:formatNumber value='${entity.price}'  pattern="0.0#"/>元
                       </c:if>
                       <c:if test="${not empty price}">
                       <span class="zi-cheng">￥<fmt:formatNumber value='${price}'  pattern="0.0#"/>元
                       </c:if>
                       
                      </c:if>
                      <c:if test="${entity.jfdh>0}">
                      <span class="zi-cheng">积分<fmt:formatNumber value='${entity.jfdh}'  pattern="0.0#"/>
                      </c:if>
                       <i class="pl-10 zi-6">数量:${count}件</i></span>
                    </div>
                </font>
            </div>
        </div>
    </div>
     
    <div class="hang40 clear"></div>

    <c:if test="${empty entity.jfdh}">
      <input type="hidden" value="<fmt:formatNumber value='${entity.price}'  pattern="0.0#"/>" id="price"/><!--单价-->
    </c:if>
    <c:if test="${entity.jfdh>0}">
      <input type="hidden" value="<fmt:formatNumber value='${entity.jfdh}'  pattern="0.0#"/>" id="price"/><!--单价-->
    </c:if>
   
    <input type="hidden" value="<fmt:formatNumber value='${entity.kdprice}'  pattern="0.0#"/>" id="kdprice"/><!--单价-->
   
</main>

<div class=" button_foot shadow-wai overflow-hidden bg-bai cmp640">
 
    <div class="div-group-5 hang50 overflow-hidden line-top">
        <div class="col-8 zi-hong weight500 pl-15" style="line-height:42px;">
            <font size="2">
            <c:if test="${empty price}">
              总计:<i id="totalPrice" class="fa fa-cny pl-5 weight500"><fmt:formatNumber value='${entity.price}'  pattern="0.0#"/></i>元
            </c:if>
            <c:if test="${not empty price }">
             总计:<i id="totalPrice" class="fa fa-cny pl-5 weight500"><fmt:formatNumber value='${price}'  pattern="0.0#"/></i>元       
            </c:if>
              
            </font>
        </div>
        <div class="col-4 zi-bai size14 weight500 txt-c pull-right">
            <a href="javascript:moneypay()">
                <div class=" hang40 ">
                    <div class="hang40 line-height40 btn-lu border-radius3">确认付款</div>
                </div>
            </a>
        </div>
    </div>
</div> 
</body>
<script>
$(function(){ 
if('${entity.jfdh}'==''||'${entity.jfdh}'==0){ 
   var totalPrice='${entity.price}'*'${count}'; 
    if('${price}'>0){
     totalPrice=parseFloat('${price}')*'${count}';
    }
   remoney=totalPrice.toFixed(2); 
    if('${byprice}'==''||'${byprice}'<=0||totalPrice<'${byprice}'){ 
     var kd='${entity.kdprice}'; 
      if(kd!=''&&kd>0){ 
       totalPrice=parseFloat(totalPrice)+parseFloat(kd);  
       $("#totalPrice").html(totalPrice.toFixed(2)+'元  <i>快递:￥'+parseFloat(kd).toFixed(2)+'</i>');
      }else{
      $("#totalPrice").html(totalPrice.toFixed(2));
     } 
    }else{ 
   $("#totalPrice").html(totalPrice.toFixed(2));
  }
   total=totalPrice.toFixed(2);
  }else{
   var totalPrice='${entity.jfdh}'*'${count}';
   jfdh=totalPrice.toFixed(2);
   total='${entity.kdprice}'; 
 $("#totalPrice").parent().html('<i id="totalPrice" class="fa fa-cny pl-5 weight500">'+totalPrice.toFixed(2)+'</i>积分 快递'+parseFloat('${entity.kdprice}').toFixed(2)+'元');
}

});
</script>
</html>