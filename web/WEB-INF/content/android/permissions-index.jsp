<%@ page contentType="text/html;charset=UTF-8" %>
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
    <title></title>
    <!-- Resource style -->
    <script src="${ctx }/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/> 
    
     <!--标准mui.css-->
    <link rel="stylesheet" href="${ctx}/mvccol/mui-css/mui.min.css"/>
    <!--App自定义的css-->
    <link rel="stylesheet" type="text/css" href="${ctx}/mvccol/mui-css/app.css"/>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script type="text/javascript" src="${ctx}/mvccol/js/chat.js"></script>  
    <script type="text/javascript" src="${ctx}/dwr/engine.js"></script>  
    <script type="text/javascript" src="${ctx}/dwr/util.js"></script>  
    <script type="text/javascript" src="${ctx}/dwr/interface/ChatService.js"></script>
    <script type="text/javascript" src="${ctx}/mvccol/js/dwr_error.js"></script>
    <script src="${contextPath}/mvccol/js/fomatdate2.js"></script> 
        
    <style>

        .hang45 {
            height: 45px;
        }

        .pt-13 {
            padding-top: 13px;
        }

        .line-height42 {
            line-height: 49px;
        }

        .line-height22 {
            line-height: 23px;
        }

        .border-radius2 {
            border-radius: 2px;
        }

        .btn-lan-tq {
            background-color: #00a5e0;
        }

        .btn-lan-tq:hover, .btn-lan-tq:focus {
            background-color: #0092c7;
        }
        
        .img-w16 {
            width: 16px;
        }

        .img-h16 {
            height: 16px;
            line-height: 19px;
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
        var issend = true;
        var fypage =0;
        var xszf = ""; 
        function ajaxjz() {//加载 
            if (!issend) {
                return;
            } 
            issend = false;
            $.post('${ctx}/android/permissions!ajaxweb.action?custid=${custid}&lscode=${lscode}', null,
                    function (json) {
                        var xszf = $('#ajaxdiv').html();   
                        if (json.state == '0') {
                            var v = json.value;
                            for (var i = 0; i < v.length; i++) {
                            
                           }
                            fypage++;
                        } else {
                        }
                        issend = true; 
                        $('#ajaxdiv').html(xszf);
                        
                    }, "json")
        }
         function setpermiss(id) {
            var submitData = {
                id: id
            };
            $.post('${ctx}/android/permissions!setpermiss.action?custid=${custid}&lscode=${lscode}', submitData,
                    function (json) {
                       if(json.state==0){ 
                       }
                    }, "json");  
        }
         function cancelpermiss(id) {
            var submitData = {
                id: id
            };
            $.post('${ctx}/android/permissions!cancelpermiss.action?custid=${custid}&lscode=${lscode}', submitData,
                    function (json) {
                        if(json.state==0){ 
                       }
                    }, "json");  
        }
        function ajaxreadingmsg(id) {
            var submitData = {
                id: id
            };
            $.post('${ctx}/android/permissions!ajaxreadingmsg.action?custid=${custid}&lscode=${lscode}', submitData,
                    function (json) {
                       if(json.state==0){ 
                       }
                    }, "json");  
        }
        function ajaxmsg() {
            var submitData = {
                
            };
            $.post('${ctx}/android/permissions!ajaxmsg.action?custid=${custid}&lscode=${lscode}', submitData,
                    function (json) {
                       if(json.state==0){ 
                       }
                    }, "json");  
         }  
    </script>
    
  
         <script type="text/javascript">  
        function send() {  
            var time = new Date();  
            var content = dwr.util.getValue("content");  
            var name = dwr.util.getValue("userName");  
            var info = encodeURI(encodeURI(name + " 说:\n" + content));  
            var msg = {  
                "msg" : info,  
                "insdate" : time  
            };  
            dwr.util.setValue("content", "");  
            if (!!content) {  
               
                ChatService.sendMessage(msg);  
               
      
            } else {  
                alert("发送的内容不能为空！");  
            }  
        }  
        function showMessage(data) {  
            var message = decodeURI(decodeURI(data.title));  
            // var text = dwr.util.getValue("info"); 
            var html=$('#ajaxdiv').html();
                html+='<div class="hang20"></div>'
                    +'<div class="mui-card" style="padding: 10px" id="'+data._id+'">'
                    +'<div>'+message+'</div>'
                    +'<div style="font-size: 10px" class="zi-hui-wx">'+data.createdate+'</div>'
                    +'<div>'+data.summary+'</div>';
                     if(data.lx=="shop-pay"){
                    html+='<a href="javascript:detail(\''+data.orderid+'\')"><div>点击查看订单</div></a></div>';
                    }else{
                    html+='</div>';
                    }
                   
                   
             $('#ajaxdiv').html(html);
             $('#ajaxdiv').show();
             $('#title').hide();
             $('#setdiv').hide();
             $('#ajaxdiv').show();
             $('body').addClass('bg-hui');
             $('.mui-title').html('通知管理'); 
             $(".button_foot .button_group1").find('.bottom-bai').removeClass("zi-green");
             $('#foot1').addClass('zi-green');
             $('#ajaxdiv').scrollTop = $('#ajaxdiv').scrollHeight;
             
             ajaxreadingmsg(data._id); 
             window.login.notice(message,data.summary,data.picurl);
        }  
    </script>  
    <script type="text/javascript">  
        window.onload = Init();
        function Init() {  
         dwr.engine.setActiveReverseAjax(true);
         //设置在页面关闭时，通知服务端销毁会话
         dwr.engine.setNotifyServerOnPageUnload(true)
          var custid ='${custid}';
          var lscode ='${lscode}';
          var type ='${type}';
          var lx='${per}';  
          ChatService.onPageLoad(custid,lscode,type,lx);
             
        } 
    </script>   
</head>
<body class="cmp640" onload="dwr.engine.setActiveReverseAjax(true);">
<header class="bottom-bai hang40 mui-bar-nav"> 
			<h1 class="mui-title">提醒管理</h1>
</header> 
<main>
    <div class="position-r overflow-hidden clear" style="height:150px;" id="title">
        <img src="${ctx}/mvccol/img/bbs2/xingkong.jpg" width="100%"/>

        <div class="position-a width-10 cmp640 bg-hei-5"
             style="height:150px;top: 0px;">
        </div>
        <div class="position-a width-10 cmp640" style="top:30px;left: 0px;">
            <div class="position-r">
                <div class="pl-15 position-a position-r">
                    <div class=" pt-3 img-wh90  border-radius5"
                         style="background-color:  rgba(255, 255, 255, 0.7)">
                        <c:if test="${empty entity.headimgurl}">
                            <div class="img-wh80 border-radius5 maring-a img-bj"
                                 style="background-image: url(${ctx}/mvccol/img/user/weizhuce.jpg);width: 84px;height: 84px;"></div>
                        </c:if>
                        <c:if test="${not empty entity.headimgurl}">
                            <div class="img-wh80 border-radius5 maring-a img-bj"
                                 style="background-image: url(${filehttp}/${entity.headimgurl});width: 84px;height: 84px;"></div>
                        </c:if>

                    </div>

                    <div class="position-a display-none" style="bottom: 0px;left:15px;">
                        <div class="bg-cheng " style="width:80px; height: 15px;"></div>
                    </div>

                </div>

                <div class="zi-bai pt-3" style="padding-left:115px;height:90px;">

                    <div class="weight500">
                        <font size="4">
                            <div class="width-5 maring-a clear sl pull-left">${entity.nickname}</div>
                        </font>
                    </div>
 
                    
                </div>

            </div>
        </div>
        <div class="position-a display-none" style="right:15px;top:60px;">
            <a href="#">
                <div class="hang30 border-radius3 pl-10 pr-10 btn-lan-tq zi-bai weight500">
                    <font size="2">
                        <i class="fa fa-edit pr-5" style="line-height: 32px;"></i><i>修改</i>
                    </font>
                </div>
            </a>
        </div>

    </div> 
    <div id="ajaxdiv" class="display-none">
     
    </div>
   
    <div class="mui-content" id="setdiv">
			<div class="mui-card">
				<ul class="mui-table-view">
				     <c:forEach items="${plist}" var="bean">
				      <li class="mui-table-view-cell" style="padding: 11px 15px" id="${bean._id}">
						${bean.title}
						<c:if test="${bean.istx==true}">
						 <div class="mui-switch mui-active">
							<div class="mui-switch-handle"></div>
						 </div>
						</c:if>
						<c:if test="${bean.istx!=true}">
						 <div class="mui-switch">
							<div class="mui-switch-handle"></div>
						 </div>
						</c:if>
						
					    </li>
				     </c:forEach> 
				</ul>
			</div>
	</div>
	<div id="ddajax" class="display-none" style="margin-top: 10px;margin-bottom: 20px"></div>
</main> 
<div class="hang50"></div>
<!--底部三个按钮-->
<div class=" button_foot bg-bai zi-hui-wx shadow-wai cmp640" style="z-index: 1;">
 
    <div class=" button_group1 "> 
            <div class="bottom-bai  txt-c weight500 line-right_bai pt-5 pb-5" id="foot1">
                <font size="4">
                    <div class="fa fa-paint-brush"></div>
                </font>

                <div class=" pt-3 title">
                    <font size="1">
                       通知管理
                    </font>
                </div>
            </div> 
    </div>
     <div class=" button_group1 "> 
            <div class="bottom-bai  txt-c weight500 line-right_bai pt-5 pb-5">
                <font size="4">
                    <div class="fa fa-navicon"></div>
                </font>

                <div class=" pt-3 title">
                    <font size="1">
                       订单查询
                    </font>
                </div>
            </div> 
    </div>
     <div class=" button_group1 "> 
            <div class="bottom-bai  txt-c weight500 line-right_bai pt-5 pb-5">
                <font size="4">
                    <div class="fa fa-navicon"></div>
                </font>

                <div class=" pt-3 title">
                    <font size="1">
                       销售统计
                    </font>
                </div>
            </div> 
    </div>
    <div class=" button_group1">
            <div class="bottom-bai zi-green txt-c weight500 line-right_bai pt-5 pb-5">
                <font size="4">
                    <div class="fa fa-user"></div>
                </font>

                <div class=" pt-3 title">
                    <font size="1">
                    提醒设置
                    </font>
                </div>
            </div>
    </div>

</div>
<%@ include file="/webcom/toast.jsp" %>
<c:if test="${com.zsjf>0}">
  <c:if test="${sczs==1}">
  <%@ include file="/webcom/jfts-page.jsp" %>
  </c:if> 
</c:if>
<script>
$(function () {
            $(".button_foot .button_group1").click(function () {
               $(".button_foot .button_group1").find('.bottom-bai').removeClass("zi-green");
               $(this).find('.bottom-bai').addClass("zi-green"); 
               $('.mui-title').html($(this).find('.bottom-bai').find('.title').find('font').html());
               if($.trim($('.mui-title').html())=="通知管理"){
                $('#title').hide();
                $('#setdiv').hide();
                $('#ddajax').hide();
                $('#ajaxdiv').show();
                $('body').addClass('bg-hui');
               }else if($.trim($('.mui-title').html())=="提醒设置"){
                $('#title').show();
                $('#setdiv').show();
                $('#ajaxdiv').hide();
                $('#ddajax').hide();
                $('body').removeClass('bg-hui');
               }else if($.trim($('.mui-title').html())=="订单查询"){
                $('#title').hide();
                $('#setdiv').hide();
                fypage=0;
                $('#ddajax').html('');
                cid='';
                ajaxdd('');
                $('#ddajax').show();
                
                $('#ajaxdiv').hide();
                $('body').addClass('bg-hui');
               }else if($.trim($('.mui-title').html())=="销售统计"){
                $('#title').hide();
                $('#setdiv').hide();
                fypage=0;
                $('#ddajax').html('');
                ajaxmb();
                $('#ddajax').show();
                scol=false
                $('#ajaxdiv').hide();
                $('body').addClass('bg-hui');
               } 
            })
        }) 
</script>
<script src="${ctx}/mvccol/mui-js/mui.min.js"></script>
<script>
     mui.init({
			swipeBack:true //启用右滑关闭功能
		});
		//圆角列表开关处理
		mui('.mui-table-view-cell').each(function(v) { //循环所有toggle 
				this.addEventListener('toggle', function(event) {
					//event.detail.isActive 可直接获取当前状态
					if(event.detail.isActive){
					   setpermiss(this.getAttribute('id'));
					}else{
					   cancelpermiss(this.getAttribute('id'));
					}
				});
			});
setTimeout("ajaxmsg()",1000);
</script>

<div class="fullscreen cmp640 bg-hei-5 lock display-none" id="detail">
    <div class="overflow-hidden width-10">
        <a href="javascript:detail_hide()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a> 
        <div class=" cmp640 position-f position-r" style="top:15%;left:0px;z-index: 99;">
  
            <div class="maring-a position-r border-radius5 div-group-12  bg-bai" style="width:280px;">
                <a href="javascript:detail_hide()">
                    <div class="position-a" style="right:-7px;top:-7px;z-index: 101;">
                        <div class="img-wh20 border-radius50 bg-hui-tx txt-c">
                            <font size="2">
                                <i class="fa fa-remove zi-green" style="line-height:22px"></i>
                            </font>
                        </div>
                    </div>
                </a>
                <div id="detail_txt" ></div>
 
               

            </div>
        </div>
    </div>
</div>
<script>
var fypage=0;
var issend = true;
var cid='';
var scol=false;
function  ajaxdd(id){
     scol=true;
     if (!issend) {
                return;
            }
            var submitData = {
              id:id  
            };
            issend = false;
            $.post('${ctx}/shop/shop!ajaxpayweb.action?custid=${custid}&fypage=' + fypage, submitData,
                    function (json) { 
                        if (json.state == 0) {
                            var v = json.list;
                            var  xszf=$('#ddajax').html();
                            for (var i = 0; i < v.length; i++) {
                               xszf+='<div class="col-12"> <div class="width-9_5 maring-a bg-bai border-radius3 overflow-hidden">'
                          +'<div class="div-group-10">'
                          +'<div class="weight500 div-group-10 zi-hei txt-c sl">'
                          +' <font size="2">'+v[i].comname+'</font></div>'
                          +' <div class="pt-10 zi-hui-wx size12">支付金额</div>'
                          +'<div class="pt-10 pb-10 size12">'+v[i].price.toFixed(2)+'</div>' 
                          +' <div class="pt-10 zi-hui-wx size12">交易时间</div>'
                          +'<div class="pt-10 pb-10 size12">'+Date.prototype.format(v[i].createdate)+'</div>'  
                          +'</div></div>'
                          +'<div class="hang30"></div>';
                            }
                            fypage++;
                            
                        } else {
                        }
                        issend = true; 
                        $('#ddajax').html(xszf);
                    }, "json")
}
function  findOne(id){
  $('#ddajax').html('');
  cid=id;
  fypage=0;
  ajaxdd(cid);
};
function  ajaxmb(){
     if (!issend) {
                return;
            }
            var submitData = {  
            };
            issend = false;
            $.post('${ctx}/shop/shop!ajaxshopmb.action?custid=${custid}&fypage=' + fypage, submitData,
                    function (json) { 
                        if (json.state == 0) {
                            var v = json.list;
                            var  xszf='';
                            for (var i = 0; i < v.length; i++) {
                               xszf+='<div class="col-12"> <div class="width-9_5 maring-a bg-bai border-radius3 overflow-hidden">'
                          +'<div class="div-group-10">'
                          +'<div class="weight500 div-group-10 zi-hei txt-c sl">'
                          +' <font size="2">'+v[i].name+'</font></div>'
                          +' <div class="pt-10 zi-hui-wx size12">总销售额</div>';
                          if(typeof(v[i].sales)== "undefined"){
                          xszf+='<div class="pt-10 pb-10 size12">0元</div>';
                          }else{
                          xszf+='<div class="pt-10 pb-10 size12">'+v[i].sales+'元</div>';
                          }
                           
                          xszf+=' <div class="pt-10 zi-hui-wx size12">昨日销售额</div>';
                          if(typeof(v[i].daysales)== "undefined"){
                            xszf+='<div class="pt-10 pb-10 size12">0元</div>';
                          }else{
                            xszf+='<div class="pt-10 pb-10 size12">'+v[i].daysales+'元</div>';
                          } 
                          
                            
                          xszf+=' <div class="pt-10 zi-hui-wx size12">今日销售额</div>';
                          if(typeof(v[i].yprice)== "undefined"){
                            xszf+='<div class="pt-10 pb-10 size12">0元</div>';
                          }else{
                            xszf+='<div class="pt-10 pb-10 size12">'+v[i].yprice+'元</div>';
                          } 
                          xszf+='<a href="javascript:findOne(\''+v[i]._id+'\')"><div class="pt-10 zi-hui-wx size12">点击查看销售明细</div></a>'  
                          +'</div></div>'
                          +'<div class="hang30"></div>';
                            }
                            fypage++;
                            
                        } else {
                        }
                        issend = true;
                        xszf+='<div class="hang50"></div>';
                        $('#ddajax').html(xszf);
                    }, "json")
}
function detail_show(){
  $('#detail').show();
}
function detail_hide(){
  $('#detail').hide();
}
 function  detail(id){
   var submitData = {
          id:id      
            };
    $.post('${ctx}/shop/shop!ajaxpaydetail.action?custid=${custid}&lscode=${lscode}', submitData,
                    function (json) { 
                        var html="";
                        html+='<div class="col-12"> <div class="width-9_5 maring-a bg-bai border-radius3 overflow-hidden">'
                          +'<div class="div-group-10">'
                          +'<div class="weight500 div-group-10 zi-hei txt-c sl">'
                          +' <font size="2">'+json.value.comname+'</font></div>'
                          +' <div class="pt-10 zi-hui-wx size12">支付金额</div>'
                          +'<div class="pt-10 pb-10 size12">'+json.value.price.toFixed(2)+'</div>' 
                          +' <div class="pt-10 zi-hui-wx size12">交易时间</div>'
                          +'<div class="pt-10 pb-10 size12">'+Date.prototype.format(json.value.createdate)+'</div>' 
                          +'</div>'
                          +'</div></div>';
                          
                        $('#detail_txt').html(html);
                        detail_show();
      }, "json");  
 }
 
  $(window).scroll(function () {
        var offsetY = $(window).scrollTop();
        var section1 = $("#section1").height();
        if (section1 - offsetY < 600) {
          if(!$('#ddajax').is(":hidden")&&scol==true){
           ajaxdd(cid);
          }
           
        }
    });
</script>
</body>
</html>