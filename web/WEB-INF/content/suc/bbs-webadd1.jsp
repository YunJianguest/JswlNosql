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
    <script src="${contextPath}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/app/css/font-awesome.min.css" rel="stylesheet">
    <link href="${contextPath}/app/css/style_0.css" rel="stylesheet"> 
    <link rel="stylesheet" href="${contextPath}/mvccol/qqFace/css/reset.css">
    <%@ include file="/webcom/toast.jsp" %>
    <!--点击小图现实大图css代码--> 
    <!--结束-->
    <!--滑动导航-->
     
    <style>
      .comment{width:680px; margin:20px auto; position:relative; background:#fff; padding:20px 50px 50px; border:1px solid #DDD; border-radius:5px;}
    .comment h3{height:28px; line-height:28px}
    .com_form{width:100%; position:relative}
    .input{width:99%; height:60px; border:1px solid #ccc}
    .com_form p{height:28px; line-height:28px; position:relative; margin-top:10px;}
    span.emotion{width:42px; height:20px; background:url(http://www.16code.com/cache/demos/user-say/img/icon.gif) no-repeat 2px 2px; padding-left:20px; cursor:pointer}
    span.emotion:hover{background-position:2px -28px}
    .qqFace{margin-top:4px;background:#fff;padding:2px;border:1px #dfe6f6 solid;}
    .qqFace table td{padding:0px;}
    .qqFace table td img{cursor:pointer;border:1px #fff solid;}
    .qqFace table td img:hover{border:1px #0066cc solid;}
    #show{width:770px; margin:20px auto; background:#fff; padding:5px; border:1px solid #DDD; vertical-align:top;}
        .dhid {
            width: 60px ! important;
            margin-right: 7px ! important;
        }

        .pb-7 {
            padding-bottom: 7px;
        }

        .yListr1 ul em.title {
            border-bottom: 3px solid #d63333;
            position: relative;
            color: #d63333;
        }

        .yListr2 .biankuang .div2 {
            border: 1px solid #45c01a;
            position: relative;
            color: #45c01a;
        }

        .yListr3 .zhiding .div3 {
            border: 1px solid #45c01a;
            position: relative;
            color: #45c01a;
        }

        .btn-lan-tq {
            background-color: #00a5e0;
        }

        .btn-lan-tq:hover, .btn-lan-tq:focus {
            background-color: #0092c7;
        }

        .pinglunkuang {
            line-height: 22px;
            width: 15px;
            height: 20px;
        }

        .width-50px {
            width: 50px;
        }

        .file {
            position: absolute;
            z-index: 100;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            opacity: 0;
            background-color: bisque;
        }

        .fa-spin1 {
            -webkit-animation: fa-spin 1s infinite linear;
            animation: fa-spin 1s infinite linear
        }

        .sss {
            background-color: #fff;
            color: #d63333
        }

        .hang25 {
            height: 25px;
            line-height: 25px;
        }

        .pr-7 {
            padding-right: 7px;
        }
        .img-wh15{
        width: 15px;
        height:15px;
        
        }

    </style>
    <!--导航结束-->
    <script>
       function replace_em(str){
	  
	    str = str.replace(/\[em_([0-9]*)\]/g,'<img src="${contextPath}/mvccol/qqFace/arclist/$1.gif" border="0" />');
	    return str;
	    }
        $(function () {
            $(".yListr1 ul em").click(function () {
                $(this).addClass("title ").siblings().removeClass("title");
            })
        })

        $(function () {
            $(".yListr2 li").click(function () {
                $(this).addClass("biankuang").siblings().removeClass("biankuang");
            })
        })

         
      
       function yuyin(){
        if($("#tanchu-yuyin").is(":hidden")){
          $("#tanchu-yuyin").show();  
         }else{
           $("#tanchu-yuyin").hide();   
        }
        $("#tanchu-tp").hide();
        $("#qqbq").hide();
        $("#tanchu-zhiding").hide();
        $("#tanchu-xuanshang").hide(); 
       }
       function tp(){
        if($("#tanchu-tp").is(":hidden")){
          $("#tanchu-tp").show();  
         }else{
           $("#tanchu-tp").hide();   
        } 
        $("#tanchu-yuyin").hide();
        $("#qqbq").hide();
        $("#tanchu-zhiding").hide();
        $("#tanchu-xuanshang").hide(); 
       }
       function xuanshuang(){
        if($("#tanchu-xuanshang").is(":hidden")){
          $("#tanchu-xuanshang").show();  
         }else{
           $("#tanchu-xuanshang").hide();   
        }
        $("#tanchu-tp").hide();
        $("#qqbq").hide();
        $("#tanchu-zhiding").hide();
        $("#tanchu-yuyin").hide(); 
       }
       function zhiding(){
        if($("#tanchu-zhiding").is(":hidden")){
          $("#tanchu-zhiding").show();  
         }else{
           $("#tanchu-zhiding").hide();   
        }
        $("#tanchu-tp").hide();
        $("#qqbq").hide();
        $("#tanchu-yuyin").hide();
        $("#tanchu-xuanshang").hide(); 
       }
       function ft(){ 
          $("#tanchu-ft").show();   
       }
       function xuanshangcancel(){
         $("#tanchu-xuanshang").hide();
       }
     
    </script> 
<script>
var subtype='';
var bbsstick=0;
var areward=0;
var jf='${user.jf}';
var dj=100;
var time=0;

$(function () {
   $(".yListr3 li").click(function () {
        $(this).addClass("zhiding").siblings().removeClass("zhiding"); 
        
        if($(this).attr("jf")==100){
         dj=100;
        }
         if($(this).attr("jf")==2000){
         dj=2000;
        }
         if($(this).attr("jf")==50000){
         dj=50000;
        }
        jfdh();
    
      })
 })
function  bbstypesub(type){
subtype=type;
}
 function  areward(id){  
		 var submitData = {
    	        bmtid:id,
    	        price:areward,
	            }; 
		$.post('${ctx}/suc/areward!ajaxAdd.action?custid=${custid}&lscode=${lscode}', submitData,
        	 
        	 function(json){
        	  if(json.state==0){
        	   alert("悬赏成功！"); 
        	  }else{
        	   alert("置顶失败！");
        	  }
        	 },"json");
	 
    }
    function  bbsstick(id){
       var xs=parseInt($('#bbsstickprice').val());
       if(dj==100){
       time=xs;
       }else if(dj==2000){
       time=xs*24;
       }else if(dj==50000){
       time=xs*24*30;
       } 
      var submitData = {
    	        bmtid:id,
    	        price:bbsstick,
    	        time:time, 
	            }; 
		$.post('${ctx}/suc/bbsstick!ajaxAdd.action?custid=${custid}&lscode=${lscode}', submitData,
        	 
        	 function(json){
        	  if(json.state==0){
        	   alert("置顶成功！"); 
        	  }else{
        	   alert("置顶失败！");
        	  }
        	 },"json");
    }
 function formsubmit(){  
		var content = $("#qqfaceshow").val().replace(/[\r\n]/g,"");
		if(content=='请输入1-300个字'||content.length<1){
		 alert('请输入1-300个字');
		 return;
		  }
		  if(subtype==''){
		   alert('请选择发表类型');
		   return;
		   }
		var picurl=''; 
		if(bbsstick!=0){
		  var xs=parseInt($('#bbsstickprice').val());
          if(dj==100){
           time=xs;
          }else if(dj==2000){
          time=xs*24;
          }else if(dj==50000){
          time=xs*24*30;
          } 
		}
	    
		 
		$(".pic-list .col-3").each(function(index,el){
		 if (typeof($(el).attr("name"))!= "undefined") { 
          picurl+=','+$(el).attr("name");            
                     } 
		 
		});  
		var submitData = {
    	        content:content,
    	        picurl:picurl,
    	        type:subtype,
    	        areward:areward,
    	        bbsstick:bbsstick,
    	        time:time
	            }; 
		$.post('${ctx}/suc/bbs!ajaxAdd.action?custid=${custid}&lscode=${lscode}', submitData,
        	 
        	 function(json){ 
        	  if(json.state==0){
        	  
        	    var text='发表成功!'; 
                   if(json.expreward>0){
                        text+="经验+"+json.expreward+" "
                     }
                   if(json.jfreward>0){
                        text+="积分+"+json.jfreward
                    } 
                   noty({text: text,type:'information', layout: "top", timeout: 1000,callback: { // 回调函数
                       afterClose: function() {
                        window.location.href='${ctx}/suc/bbs!index.action?custid=${custid}&lscode=${lscode}&type='+subtype;
                       } // 关闭之后
                   },});
        	   
        	  }else{
        	    noty({text: "发表失败！",type:'error', layout: "top", timeout: 2000});
        	  }
        	 },"json");
	 
    }
   function xuanshangok(){
       if($('#xuanshangvalue').val()=='请输入悬赏积分'){
       alert('请输入悬赏积分');
       return;
       }
       var xs=parseInt($('#xuanshangvalue').val());
        if(isNaN(xs)){
        alert('请输入正确的积分数'); 
        return;
       }
       if(xs>'${user.jf}'){
        alert('您的积分不足'); 
        return;
       } 
       if(xs<100){
        alert('悬赏的最小金额为100'); 
        return;
       } 
       areward=xs; 
      $("#tanchu-xuanshang").hide();
     }
   
    function jfdh(){
     if($('#bbsstickprice').val()!=""){
      var xs=parseInt($('#bbsstickprice').val());
      if(isNaN(xs)){
      alert('请输入正确的数量'); 
        return;
      } 
      $("#sticktime").html(xs); 
      $("#stickxy").html(xs*dj);
      if(dj==100){
      $("#sticktimes").html("时");
       }
       if(dj==2000){
        $("#sticktimes").html("天");
       }
       if(dj==50000){
        $("#sticktimes").html("月");
        }
      
      if(xs*dj>jf){ 
      alert('您的需要的积分已经超出额度');
      return;
     }
     bbsstick=xs*dj;
     }
    
      
    }
    
    
</script>
</head>
<body class="bg-bai">


<!--发帖输入框弹出层-->
<div class=" cmp640 bg-bai overflow-auto">

    <div class="pt-10 pl-10 bg-bai">
        <form action="">
                <textarea id="qqfaceshow"  placeholder="请输入10-300个字"  ;this.style.color='black';
                          rows="5" name="message" class="size14 weight500"
                          style="height:150px;" onKeyDown="textCounter(message,remLen,300);"
                          onKeyUp="textCounter(message,remLen,300);"></textarea>
            <input name="remLen" type="text" value="300字" size="5" readonly="readonly"
                   class="zi-hui size12 pl-2 pb-10 pull-right">
        </form>
    </div>

    <!--位置与发送-->
    <div class=" clear overflow-hidden">
        <div class="clear pl-15 pt-6 weight500 col-8 ">
            <a href="#">
                <div class="line-lu display-none zi-hui-tq pull-left hang20 pl-10 pr-10"
                     style="line-height: 20px;border-radius: 30px;">
                    <font size="1">
                        <i class="fa fa-map-marker pr-5" style="line-height: 20px;"></i>
                        <i>点击发送位置</i>
                    </font>
                </div>
            </a>
        </div>

        <a href="javascript:formsubmit();">
            <div class=" weight500 col-4">
                <div class="btn-green zi-bai txt-c size12 border-radius3 maring-a"
                     style="width: 70px; height:28px; line-height:29px;">
                    发表
                </div>
            </div>
        </a>
    </div>

    <font size="1">
        <div class="pl-10 pt-5 pb-10 overflow-hidden weight500 yListr2">
        <c:if test="${not empty bbstype}">
           <c:forEach items="${bbstype}" var="bean">
             <li class="pr-7 pt-7 pull-left">
                <div class="div2 zi-hui-wx line-lu border-radius3 pl-5 pr-5 hang25" id="${bean.type}" onclick="bbstypesub('${bean.type}')">
                   ${bean.title}
                </div>
             </li>  
           </c:forEach> 
        </c:if>
       
           
        </div>
    </font>

    <!--四个按钮-->
    <div class="clear div-group-10 pt-7 pb-5 overflow-hidden bg-hui-tx">
        <font size="2">

            <div class=" button_group1" id="qqface">
                 
                    <div class="zi-hui-wx txt-c weight500">
                        <i class="fa fa-smile-o pr-5"></i>
                        <i>表情</i>
                    </div>
                 
            </div>
            <div class=" button_group1">
                <a href="javascript:tp()">
                    <div class="zi-hui-wx txt-c weight500">
                        <i class="fa fa-photo pr-5"></i>
                        <i>图片</i>
                    </div>
                </a>
            </div>
            <div class=" button_group1 display-none">
                <a href="javascript:yuyin()">
                    <div class="zi-hui-wx txt-c weight500">
                        <i class="fa fa-microphone pr-5"></i>
                        <i>语音</i>
                    </div>
                </a>
            </div>

            <div class=" button_group1">
                <a href="javascript:xuanshuang()">
                    <div class="zi-hui-wx txt-c weight500">
                        <i class="fa fa-cny pr-5"></i>
                        <i>悬赏</i>
                    </div>
                </a>
            </div>
            <div class=" button_group1">
                <a href="javascript:zhiding()">
                    <div class="zi-hui-wx txt-c weight500">
                        <i class="fa fa-check-square-o pr-5"></i>
                        <i>置顶</i>
                    </div>
                </a>
            </div>
        </font>
    </div>
    <!--四个按钮结束-->


    <!--图片显示处-->
    <div class=" overflow-hidden  display-none clear" id="tanchu-tp">
        <!--<div class="hang5 bg-hui-tx clear"></div>-->
        <div class="div-group-10 overflow-hidden pic-list" style="padding-top: 0px;">
 
            <div class="col-3 pt-10 display-none" id="jdt" >
                <div class="img-wh70 maring-a">
                    <div class="position-r">
                        <div class=" img-wh70 img-bj border-radius5 overflow-hidden"
                             style="background-image:url(img/smq-no1.jpg);">
                            <div class="img-wh70 bg-hui zi-hui  txt-c">
                                <i class="fa fa-spinner fa-1dx fa-spin1" style="line-height:70px;"></i>
                            </div>
                        </div>
                        <!--删除图片-->
                        <div class="position-a" style="top:-7px; right:-7px;">
                            <a href="#">
                                <div class="img-wh20 txt-c zi-bai border-radius50 bg-cheng">
                                    <font size="2">
                                        <i class="fa fa-remove" style="line-height:22px;"></i>
                                    </font>
                                </div>
                            </a>
                        </div>
                        <!--删除图片结束-->
                    </div>
                </div>
            </div>
           
            <!--添加图片-->
            <div class="col-3 pt-10">
                <div class="img-wh70 maring-a">
                    <div class="position-r">
                        <div class=" img-wh70 img-bj div-group-15 border-radius5 line-lu">
                            <img src="${contextPath}/mvccol/img/addimg.png" class="width-10">
                        </div>
                        <input type="file" accept="image/*" class="file cameraInput" name="cameraInput">
                    </div>
                </div>
            </div>
          

        </div>
    </div>
    <!--图片显示处结束-->

    <!--表情显示处-->
    <div class=" overflow-hidden  display-none clear" id="qqbq">
        <div class="div-group-10 pt-5 overflow-hidden clear">
            <div>表情放置处</div>
        </div>
    </div>
    <!--表情显示处结束-->

    <!--语音弹出层-->
    <div class=" overflow-auto display-none" id="tanchu-yuyin">

        <!--录制的语音放置处-->
        <div class="clear pt-15 pl-15 position-r width-3 display-none">
            <div class="hang30 pl-5 pr-5 border-radius3 overflow-hidden line-lu">
                <div class="img-wh18 pull-left pt-4">
                    <img src="${ctx}/mvccol/img/bbs2/yuyin.gif" width="100%">
                </div>
                <div class="img-wh18 pull-left pt-4">
                    <img src="${ctx}/mvccol/img/bbs2/yuyinb.gif" width="100%">
                </div>
                <div class="pull-right zi-hui-tq weight500">
                    <div style="line-height: 30px;">
                        <font size="1">
                            10s
                        </font>
                    </div>
                </div>
            </div>

            <!--删除语音-->
            <div class="position-a" style="top:10px; right:-7px;">
                <a href="#">
                    <div class="img-wh15 txt-c zi-bai border-radius50 bg-cheng">
                        <font size="1">
                            <i class="fa fa-remove" style="line-height:15px;"></i>
                        </font>
                    </div>
                </a>
            </div>
            <!--删除语音结束-->

        </div>

        <div class="pt-15 position-r">
            <div class="img-wh80 maring-a"><img src="${ctx}/mvccol/img/bbs2/luyinx.png" class="width-10"></div>

            <div class="position-a display-none width-10" id="tanchu-ly" style="top:15px; left: 0px;">
                <div class="img-wh80 maring-a">
                    <img src="${ctx}/mvccol/img/bbs2/luyinx.gif" class="width-10">
                </div>
            </div>
        </div>

        <div class="pt-20">
            <a href="javascript:ly()">
                <div class="img-wh50 maring-a pt-5 bg-hei-8 border-radius50">
                    <div class="img-wh40 sss maring-a txt-c border-radius50">
                        <i class="fa fa-circle fa-1dx line-height40" style="line-height:42px;"></i>
                    </div>
                </div>
            </a>

            <div class="pt-10 width-10 txt-c">
                <font size="2">
                    <i class="zi-hui-tq txt-c weight500">点击录音再次点击完成录音</i>
                </font>
            </div>
        </div>
    </div>

    <!--悬赏弹出层-->
    <div class="fullscreen cmp640 bg-hei-8 overflow-auto display-none div-group-5" id="tanchu-xuanshang">
        <div class="width-6 maring-a bg-bai border-radius5" style="margin-top: 30%">
            <div class="hang50 div-group-10 line-bottom">
                <font size="2">
                    <input id="xuanshangvalue" class="width-10 zi-hui-tq weight500 txt-c" style="line-height:31px;height:28px;" type="text"
                           name=""
                           value="请输入悬赏积分"
                           onfocus="if(this.value=='请输入悬赏积分'){this.value=''};this.style.color='black';"
                           onblur="if(this.value==''||this.value=='请输入悬赏积分'){this.value='请输入悬赏积分';this.style.color='#aaa';}">
                </font>
            </div>
            <div class="overflow-hidden">
                <font size="2">
                    <a href="javascript:xuanshangcancel()">
                        <div class="txt-c zi-hui-tq col-6 pt-5 pb-5 line-right">
                            取消
                        </div>
                    </a>
                    <a href="javascript:xuanshangok()">
                        <div class="txt-c zi-hui-tq col-6 pt-5 pb-5">
                            确认
                        </div>
                    </a>
                </font>
            </div>
        </div>
    </div>

    <!--置顶弹出层-->
    <div class=" overflow-auto display-none" id="tanchu-zhiding">

        <!--支付之前的编辑页面-->
        <font size="1" class="">
             

            <div class="clear div-group-5 pt-15">
                <div class="pt-7 col-2">
                    <div class="txt-c zi-hui-wx  border-radius3 hang25 weight500">
                        <font size="2"> 方式：</font>
                    </div>
                </div>

                <div class="col-10  overflow-hidden weight500 yListr3">

                    <li class="pr-7 pt-7 col-4 zhiding" jf="100">
                        <div class="div3 txt-c zi-hui-wx line-lu border-radius3 hang25">
                            100积分/小时
                        </div>
                    </li>

                    <li class="pr-7 pt-7 col-4" jf="2000">
                        <div class="div3 txt-c zi-hui-wx line-lu border-radius3 hang25">
                           2千积分/天
                        </div>
                    </li>

                    <li class="pr-7 pt-7 col-4" jf="50000">
                        <div class="div3 txt-c zi-hui-wx line-lu border-radius3 hang25">
                                                                                五万积分/月
                        </div>
                    </li>

                </div>
            </div>

            <div class="clear div-group-5 pt-10">
                <div class="pt-7 col-2">
                    <div class="txt-c zi-hui-wx  border-radius3 hang25 weight500">
                        <font size="2">数量：</font>
                    </div>
                </div>

                <div class="col-5  overflow-hidden weight500 yListr3">
                    <li class="pr-7 pt-7">
                        <div class="div3 txt-c zi-hui-wx line-lu border-radius3 pt-5 overflow-hidden hang25">
                            <input class="width-10 txt-c zi-hui-wx " id="bbsstickprice" style="height: 15px; line-height:17px" type="text"
                                   name=""
                                   value="所需的时间数量"
                                   onfocus="if(this.value=='所需的时间数量'){this.value=''};this.style.color='#45c01a';"
                                   onblur="if(this.value==''||this.value=='所需的时间数量'){this.value='所需的时间数量';this.style.color='#aaa';}" onkeyup="jfdh()">
                        </div>
                    </li>
                </div>
            </div>


            <div class="clear txt-c zi-hui-wx pt-15">
                如您积分不足可去发帖点赞等赚取积分<a href="#" class="zi-green">查看(积分攻略)</a>
            </div>

            <div class="pt-5 weight500 overflow-hidden">
                <font size="2">
                    <div class="txt-c zi-hui-wx">
                        您置顶<i id="sticktime">0</i><i id="sticktimes">时</i>需<i class="zi-green" id="stickxy">0</i>积分，现有<i id="jf">${user.jf}</i>积分。
                    </div>
                </font>
            </div>
 
        </font>

       


    </div>


</div>

<div class="clear hang50"></div>

<%@ include file="/webcom/bbs-foot.jsp" %>

<!--浮动广告条-->
<c:if test="${ not empty floatadv}">
<div class="position-f cmp640" id="tanchuguanggaof" style="top: 0px;left: 0px;z-index: 1000;">
    <div class="bg-hei-8 position-r div-group-5 overflow-hidden">
        <a href="#">
            <div class="img-wh30 border-radius3 pull-left overflow-hidden">
                <img src="img/cmp_logo.png" class="width-10">
            </div>
            <div class="hang30 pl-10 pull-left" style="line-height: 32px;">
                <font size="2">
                    <i class="zi-bai">联系我们为您提供更多的服务！</i>
                </font>
            </div>
            <a href="#">
                <div class="pull-left pl-15 pt-5">
                    <div class="zi-bai maring-a pl-10 pr-10 hang20 txt-c btn-green border-radius3 weight500 zi-bai"
                         style="line-height: 22px;">
                        <font size="1">
                            立即查看
                        </font>
                    </div>
                </div>
            </a>
        </a>

        <a href="javascript:xiaoshiguanggaof()">
            <div class="position-a pt-10 pr-5" style="right:0px;top:0px;">
                <div class="img-wh20 border-radius50 bg-bai txt-c">
                    <font size="2">
                        <i class="fa fa-remove zi-green" style="line-height:22px"></i>
                    </font>
                </div>
            </div>
        </a>

    </div>
</div>

</c:if>


 
<!--点击小图弹出大图代码结束-->


<!--限制textarea框字数代码-->
<script language="JavaScript">

    function textCounter(field, countfield, maxlimit) {
        // 函数，3个参数，表单名字，表单域积分素名，限制字符；
        if (field.value.length > maxlimit)
        //如果积分素区字符数大于最大字符数，按照最大字符数截断；
            field.value = field.value.substring(0, maxlimit);
        else
        //在记数区文本框内显示剩余的字符数；
            countfield.value = maxlimit - field.value.length;
    }

</script>

 
  
<script src="${contextPath}/mvccol/lrz/exif.js"></script>
<script src="${contextPath}/mvccol/lrz/lrz.js"></script>
<script src="${contextPath}/mvccol/lrz/mobileFix.mini.js"></script> 
<script src="${contextPath}/mvccol/lrz/index.js"></script>
<script src="${contextPath}/mvccol/qqFace/js/jquery.qqFace.js"></script>
<script type="text/javascript">
subtype='${type}'; 
$('#'+subtype).parent().addClass("biankuang");

$(function(){
	$('#qqface').qqFace({
		id : 'facebox', 
		assign:'qqfaceshow', 
		path:'${contextPath}/mvccol/qqFace/arclist/'	//表情存放的路径
	});
	$(".sub_btn").click(function(){
		var str = $("#saytext").val();
		$("#show").html(replace_em(str));
	});
});
//查看结果

</script>
</body>
</html>