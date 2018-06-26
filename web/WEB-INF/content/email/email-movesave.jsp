<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
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
 
    </style>
    <!--导航结束-->
<script>
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
</script>   
<script> 
 function formsubmit(){  
	   var content = $("#qqfaceshow").val().replace(/[\r\n]/g,"");
		if(content=='请输入1-300个字'||content.length<1){
		 alert('请输入1-300个字');
		 return;
		  }
		var picurl='';  
		$(".pic-list .col-3").each(function(index,el){
		 if (typeof($(el).attr("name"))!= "undefined") { 
          picurl+=','+$(el).attr("name");            
                     } 
		 
		});  
		var submitData = {
    	        content:content,
    	        picurl:picurl,
    	        toUserid:$("#toUserid").val(), 
	            }; 
		$.post('${ctx}/email/email!ajaxsave.action?custid=${custid}&lscode=${lscode}', submitData,
        	 
        	 function(json){ 
        	  if(json.state==0){
        	  
        	    var text='发表成功!';  
                   noty({text: text,type:'information', layout: "top", timeout: 1000,callback: { // 回调函数
                       afterClose: function() {
                        window.location.href='${ctx}/email/email!web.action?custid=${custid}&lscode=${lscode}';
                       } // 关闭之后
                   },});
        	   
        	  }else{
        	    noty({text: "发表失败！",type:'error', layout: "top", timeout: 2000});
        	  }
        	 },"json");
	 
    }
   
    
    
</script>
</head>
<body class="bg-bai">


<!--发帖输入框弹出层-->
<div class=" cmp640 bg-bai overflow-auto">
    <input name="toUserid" type="hidden" id="toUserid" value="${toUserid}"/>
    <div class="pt-10 pl-10 bg-bai">
        <form action="">
                <textarea id="qqfaceshow"  placeholder="请输入10-300个字"  ;this.style.color='black';
                          rows="5" name="message" class="size14 weight500"
                          style="height:150px;" onKeyDown="textCounter(message,remLen,300);"
                          onKeyUp="textCounter(message,remLen,300);"></textarea>
            <input name="remLen" type="text" value="300字" size="5" readonly="readonly"
                   class="zi-hui size12 pl-2 pb-10 pull-right"/>
        </form>
    </div>

    <!--位置与发送-->
    <div class=" clear overflow-hidden"> 
        <a href="javascript:formsubmit();">
            <div class=" weight500 col-4 mb-15 pull-right">
                <div class="btn-green zi-bai txt-c size12 border-radius3 maring-a"
                     style="width: 70px; height:28px; line-height:29px;">
                    发表
                </div>
            </div>
        </a>
    </div> 
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
                             >
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
  
</div>
 
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