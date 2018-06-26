<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%> 
<%@ include file="/webcom/limit.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
    <title>欢迎来到${entity.name}</title>
    <!-- Resource style -->
    <script src="${ctx }/app/js/jquery-1.8.3.js"></script>
    <script src="${ctx}/app/js/iosOverlay.js"></script>
    <script src="${ctx}/app/js/spin.min.js"></script>
    <link href="${ctx}/app/css/iosOverlay.css" rel="stylesheet"/>
    <script type="text/javascript" src="${ctx }/app/js/jquery.Spinner.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx }/app/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="${ctx }/app/css/font-awesome-ie7.min.css" rel="stylesheet"/>  
    <link href="${ctx}/mvccol/SweetAlert2/css/sweetalert2.min.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/animo.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/buttons.css" rel="stylesheet"/>
    <script src="${ctx}/mvccol/js/fomatdate1.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/sweetalert2.min.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/promise.js"></script>
    
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
  
         function moneypay(price){  
        	var submitData = { 
        		price:price,
        		comid:'${entity._id}',
        		remark:"商城购物"
        			
        	}; 
        	loading();
        	$.post('${ctx}/shop/shop!storewxpay.action?custid=${custid}&agid=${agid}&lscode=${lscode}', submitData,
        		function(json) { 
        		     loading.hide();
        		 	if (json.state == 0) { 
        				WeixinJSBridge.invoke('getBrandWCPayRequest',{
        			  		 "appId" : json.appId,"timeStamp" : json.timeStamp, "nonceStr" : json.nonceStr, "package" : json.packageValue,"signType" : json.signType, "paySign" : json.paySign 
        			   			},function(res){  
        			   				if(res.err_msg == "get_brand_wcpay_request:ok"){  
        			   					 var text='支付成功！'; 
        			   					 if(json.jffh>0){
        			   					   text="支付成功！恭喜您获得:"+json.jffh+"积分,您可以去积分商城兑换自己喜欢礼品！";
        			   					   
        			   					    swal({ 
                                       text:text,
                                       type: 'success',
                                       allowOutsideClick: false,
                                       showCancelButton: true,
                                       confirmButtonColor: '#3085d6',
                                       cancelButtonColor: '#d33',
                                       confirmButtonText: '积分商城',
                                       cancelButtonText: '个人中心',
                                       confirmButtonClass: 'btn btn-success mr-15',
                                       cancelButtonClass: 'btn btn-danger ml-15',
                                       buttonsStyling: false
                                     }).then(function () {
                                          loadjfsc();
                                   
                                          }, function (dismiss) {
                                           // dismiss can be 'cancel', 'overlay',
                                          // 'close', and 'timer'
                                        if (dismiss === 'cancel') {
                                               window.location.href='${ctx}/user/fromuser!UserDetail.action?custid=${custid}&agid=${agid}&lscode=${lscode}';
                                             }
                                          });
        			   					 }else{
        			   					   iosOverlay({ 
        			                        text:text, 
	                                        duration: 2e3,  
	                                        icon: "${ctx}/img/check.png" 
	                                        });
	                                         window.setTimeout(function() {
	                                           window.location.href="${ctx}/user/fromuser!UserDetail.action?custid=${custid}&agid=${agid}&lscode=${lscode}";
	                                       }, 3e3); 
        			   					 }
        			   			 		 
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
    function   loadjfsc(){ 
         var submitData = { 
	            };  
       $.post('${ctx}/shop/shop!checkJfsc.action?custid=${custid}&agid=${agid}&lscode=${lscode}', submitData,
        	 function(json){ 
        	  if(json.state==0){  
        	     window.location.href='${ctx}/shop/shop!index.action?custid=${custid}&agid=${agid}&lscode={lscode}&comid='+json.value;
        	  }else{
        	       noty({text: "尊敬的用户！暂时没有找到已经开通的积分商城！！",type:'information', layout: "top", timeout: 1000,callback: { // 回调函数
                                              afterClose: function() { 
                                              } // 关闭之后
                                            },});
        	  }
        	 },"json");
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
    </style>
</head>
<body>
 
<main class="clear cmp640 lock">
   
</main>
<script >
$(function(){
swal({
  title: '请输入支付金额',
  input: 'text',
  showCancelButton: false,
  confirmButtonText: '立即支付',
  cancelButtonText: '稍后再说', 
  allowOutsideClick: false,
  preConfirm: function (text) {
    return new Promise(function (resolve, reject) {
      
        if(isNaN(text)||text==''){
             iosOverlay({ 
        		text:'请输入数字', 
	            duration: 2e3, 
	            icon: "${ctx}/img/cross.png"  
	           }); 
	   
       }else{
        moneypay(text); 
       }
     })
   },
  }).then(function (text) {
      
   
})
}); 
</script> 
</body>
</html>