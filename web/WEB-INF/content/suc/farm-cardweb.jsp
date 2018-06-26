<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ include file="/webcom/limit.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport"
          content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black"/>
    <meta name="format-detection" content="telephone=no"/>
    <title>微农场果实</title>
    <script src="${contextPath}/app/js/jquery-1.8.3.js"></script>
    <script src="${ctx}/app/js/iosOverlay.js"></script>
    <script src="${ctx}/app/js/spin.min.js"></script>
    <link href="${ctx}/app/css/iosOverlay.css" rel="stylesheet"/>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/app/css/font-awesome.min.css" rel="stylesheet"/> 
    <script src="${contextPath}/mvccol/js/fomatdate2.js"></script> 
    <link href="${ctx}/mvccol/SweetAlert2/css/sweetalert2.min.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/animo.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/buttons.css" rel="stylesheet"/> 
    <script src="${ctx}/mvccol/SweetAlert2/js/sweetalert2.min.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/promise.js"></script>
    <link href="${ctx}/mvccol/SweetAlert2/css/buttons.css" rel="stylesheet"/>
    <style>
        .hang70 {
            height: 70px;;
        }
        .kq-hong {
            background: #dc493b;
        }
        .div-group-3 {
            padding: 3px;
        }
        .line-bai {
            border: solid 1px #ffffff;
        }
        .line-bai-right{
            border-right: dotted 2px #ffffff;
        }
        .right-top {
            right:-10px; top:-15px;
        }
        .right-bottom {
            right:-10px; bottom:-14px;
        }
        .bg-hei-7 {
            background-color: rgba(30, 30, 30, 0.7);
        } 
        .border-top-dashed-1-ccc{
            border-top:dashed 1px #ccc;
        }
        .top--5-right--5{
            top: -5px;right: -5px;
        }

        .top--5-left--5{
            top: -5px;left: -5px;
        }
        
    </style>
    <script>
        var issend=true;
        var fypage=0;
        var loading;
        function  ajaxjz(){
            var submitData = {
            };
            issend=false;
            $.post('${ctx}/suc/farm!ajaxcard.action?custid=${custid}&lscode=${lscode}&fypage='+ fypage, submitData,function(json){
                var xszf=$('#ajaxdiv').html(); 
                if(json.state==0){
                    var v = json.list;
                    for(var i=0;i<v.length;i++){
                          xszf+='<div class="col-6 pt-10">'
                              +'<div class="width-9_5 maring-a bg-bai border-radius3 overflow-hidden">'
                              +'<div class="div-group-10">'
                              +'<div class="weight500 div-group-10 zi-hei txt-c sl">'
                              +'<font size="2">'+v[i].title+'</font></div>'
                              +'<div class="pt-10 zi-hui-wx size12">果实成熟时间</div>'
                              +'<div class="pt-10 pb-10 size12">'+Date.prototype.format(v[i].createdate)+'</div>'
                              +'<div class="pt-10 zi-hui-wx size12 border-top-dashed-1-ccc">到期时间</div>'
                              +'<div class="pt-10 size12">'+Date.prototype.format(v[i].enddjdate)+'</div>'
                              +'<div class="pt-20 pb-10">';
                              if(v[i].state==0){
                                xszf+='<div class="width-6 btn-lan maring-a border-radius3 line-height30 hang30 txt-c zi-bai" onclick="exchange('+v[i]._id+',this,0)">立即领取</div></div></div>';
                              }else if(v[i].state==1){
                                xszf+='<div class=" width-6 bj-lan1 maring-a border-radius3 line-height30 hang30 txt-c zi-bai">已领取</div></div></div>';
                              
                              }else if(v[i].state==2){
                                xszf+='<div class="width-6 btn-hui maring-a border-radius3 line-height30 hang30 txt-c zi-hui-wx">已过期</div></div></div>';
                              }else if(v[i].state==3){
                                xszf+='<div class=" width-6 bj-lan1 maring-a border-radius3 line-height30 hang30 txt-c zi-bai" onclick="exchange('+v[i]._id+',this,3)">已发货</div></div></div>';
                              }else if(v[i].state==4){
                                xszf+='<div class=" width-6 bg-hei-5 maring-a border-radius3 line-height30 hang30 txt-c zi-bai">已签收</div></div></div>';
                              }else{
                                xszf+='<div class=" width-6 bj-hui maring-a border-radius3 line-height30 hang30 txt-c zi-bai">已过期</div></div></div>';
                              }
                             
                              xszf+='<div class="position-r border-top-dashed-1-ccc">'
                              +'<div class="position-a top--5-left--5">'
                              +'<div class="img-wh10 border-radius50 bj-lan1"></div>'
                              +'</div>'
                              +'<div class="position-a top--5-right--5">'
                              +'<div class="img-wh10 border-radius50 bj-lan1"></div>'
                              +'</div></div>'
                              +'<div class="div-group-10 pt-15 pb-15">'
                              +'<div class="size12">序列号<i class="pl-5 zi-hei-tq">'+v[i].djm+'</i></div>';
                              if(v[i].courierName!=null&&v[i].courierNo!=null){
                               xszf+='<div class="pt-10 size12 ">'+v[i].courierName+'<i class="pl-5 zi-lan-tq">'+v[i].courierNo+'</i></div>';
                              }else{
                              xszf+='<div class="pt-10 size12 ">请耐心等待发货<i class="pl-5 zi-lan-tq"></i></div>';
                              } 
                              xszf+='</div></div></div>';
                            
                    }
                    fypage++;
                }else{
                }
                issend=true;
                $('#ajaxdiv').html(xszf);
                if($('#ajaxdiv').html()==''){
                    var html = '<div class="clear txt-c zi-hui size14"><div class="pt-10">'
                                + '<i class="fa fa-tags fa-6x"></i></div><div class="pt-20 pb-20">'
                                + '暂无卡卷信息，请前去参与活动！ </div></div>';
                  
                  $('#ajaxdiv').html(html);
                }
            },"json");
        } 
        function exchange(id,v,type){
          var txt='';
          var txtb=''; 
          if(type==0){
             txt="确认兑奖";
             txtb="立即兑奖"; 
          }else if(type==3){
             txtb="立即签收";
             txt="确认收货"; 
          }
        
          swal({ 
                 text:txt,
                 type: 'warning',
                 showCancelButton: true,
                 confirmButtonColor: '#3085d6',
                 cancelButtonColor: '#d33',
                 confirmButtonText:txtb,
                 cancelButtonText: '稍后再说',
                 confirmButtonClass: 'btn btn-success mr-15',
                 cancelButtonClass: 'btn btn-danger ml-15',
                 buttonsStyling: false
                 }).then(function () {
                                 if(type==0){
                                 confirmAddress(id,v,type); 
                                 }else{
                                 loading();
                                 ajaxchange(id,v,type);
                                 }
                                 
                                   
                            }, function (dismiss) {
                           // dismiss can be 'cancel', 'overlay',
                           // 'close', and 'timer'
                             if (dismiss === 'cancel') {
                                  
                                 }
                            });
        
        }
        function ajaxchange(id,v,type){
        
             var submitData = {
             id:id,
             type:type
            };
            $.post("${ctx}/suc/farm!ajaxchangecard.action?custid=${custid}&lscode=${lscode}",submitData,function(json){
              if(json.state==0){
                if(type==0){
                   iosOverlay({ 
        			        text:'成功兑奖', 
	                        duration: 2e3,  
	                        icon: "${ctx}/img/check.png" 
	                     }); 
	              window.setTimeout(function() {
	                $(v).addClass('bj-lan1');
	                $(v).removeClass('btn-lan');
	                $(v).html('已领取');
	              }, 2e3);
	             
                }else if(type==3){
                 loading.hide(); 
                 iosOverlay({ 
        			        text:'成功签收', 
	                        duration: 2e3,  
	                        icon: "${ctx}/img/check.png" 
	                     }); 
	             window.setTimeout(function() {
	                $(v).addClass('bg-hei-5');
	                $(v).removeClass('bj-lan1');
	                $(v).html('已签收');
	            }, 2e3); 
                }
                 
              } 
            },"json");
        }
        function  confirmAddress(id,v,type){
          var  html='';   
          if('${address}'!=null){
               html+='<div class="div-group-10 overflow-hidden zi-6 weight100 col-11">'
                    +'<div>'
                    +'<div class="pull-left">收货人:<i>${address.name}</i></div>'
                    +'<div class="pull-right">${address.tel}</div>'
                    +'</div>'
                    +'<div class="clear pt-5">'
                    +'<div class="pull-left sl width-10">收货地址:<i>${address.address}</i></div>'
                    +'</div></div>';
             
          }else{
               html="暂无地址";
          }
            swal({ 
                 text:html, 
                 showCancelButton: true,
                 confirmButtonColor: '#3085d6',
                 cancelButtonColor: '#d33',
                 confirmButtonText:'修改地址',
                 cancelButtonText: '确认地址',
                 confirmButtonClass: 'btn btn-success mr-15',
                 cancelButtonClass: 'btn btn-danger ml-15',
                 buttonsStyling: false
                 }).then(function () {
                               window.location.href="${ctx}/shop/shop!useraddress.action?lscode=${lscode}&custid=${custid}&addressis=err&backurl=/suc/farm!cardweb.action?";   
                                   
                            }, function (dismiss) {
                           // dismiss can be 'cancel', 'overlay',
                           // 'close', and 'timer'
                             if (dismiss === 'cancel') {
                                if(html!="暂无地址"&&html!=""){ 
                                 ajaxchange(id,v,type);
                                }else{
                                 iosOverlay({ 
        			              text:'请填写地址', 
	                              duration: 2e3,  
	                              icon: "${ctx}/img/cross.png" 
	                              }); 
                                }   
                              }
                            });
        
        }
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
    </script>
</head>
<body class="cmp640 lock bj-lan1">
<main>
    <div id="ajaxdiv"></div>
</main>
<%@include file="/webcom/return-top.jsp" %>
<div class="clear hang50"></div> 
<script>  
    ajaxjz(); 
    $(window).scroll(function () {
        var offsetY = $(window).scrollTop();
        var section1 = $("#section1").height();
        if(section1-offsetY<600){
            ajaxjz();
        }
    });
</script>
</body>
</html>