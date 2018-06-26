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
    <link href="${contextPath}/app/css/font-awesome-ie7.min.css" rel="stylesheet">
    <link href="${contextPath}/app/css/style_0.css" rel="stylesheet"> 
    <style>
      .pr-2 {
            padding-right: 2px;
        }

        .hang25 {
            height: 25px;
            line-height: 25px;
        }

        .zi-hong2 {
            color: #ff6565;
        }

        .btn-hong2 {
            background: #ff6565;
        }

        .btn-hong2:hover {
            background-color: #de4d52;
        }

        .btn-hong2:active {
            background-color: #de4d52;
        }

        .bg-huang {
            background: #f3bc48;
        }

        .bg-hong3 {
            background: #ff6565;
        }

        .btn-huang {
            background: #f3bc48;
        }

        .btn-huang:hover {
            background-color: #eba920;
        }

        .btn-huang:active {
            background-color: #eba920;
        }

        .bj-huang {
            background: #fce559 !important;
        }

        .bj-lan {
            background: #563677;
        }

        .zi-zong {
            color: #630601;
        }

        .bg-zong {
            background-color: #630601;
        }

        .zi-huang {
            color: #fce559;
        }

        .line-right-huang {
            border-right: 1px solid #fce559;
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
    </style>
    <script>
    function submint(){
    var content = $("#content").val();
	var title=$('#title').val();
	var tel=$('#tel').val();
	var bgcurl='';
	var picurl='';
	if(title.replace("请输入姓名或者标题","")==""){ 
	 alert("请输入标题");
	 $('#title').focus();
	 
	  return;
	} 
	 if(!(/^1[3|4|5|7|8]\d{9}$/.test(tel))){ 
        alert("手机号码有误，请重填");  
        return false; 
    } 
	 if(content.replace("请输入描述","")==""){ 
	 alert("请输入描述");
	 $('#content').focus();
	  return;
	 }
	 	
	$(".pic-list .col-3").each(function(index,el){
		 if (typeof($(el).attr("name"))!= "undefined") { 
          bgcurl+=','+$(el).attr("name");            
                     }
          if(index==1){
          picurl=$(el).attr("name");
          }
		 
	 });
	 if(picurl==""){
	  alert("请上传图片");
	  return;
	 }   
	 	var submitData = {
    	        context:content,
    	        bgurl:bgcurl,
    	        picurl:picurl,
    	        vtid:'${entity._id}',
    	        title:title,
    	        tel:tel
    	        
	            }; 
		$.post('${ctx}/suc/votelm!ajaxadd.action?custid=${custid}&lscode=${lscode}', submitData,
        	 
        	 function(json){ 
        	  if(json.state==0){
        	   alert("报名成功！"); 
        	   location.href = "${contextPath}/suc/votelm!index.action?custid=${custid}&lscode=${lscode}&_id=${entity._id}";
        	  }else if(json.state==3){
        	   alert("请先登录！");
        	    location.href = "${ctx}/user/fromuser!UserDetail.action?custid=${custid}";
        	  }else{
        	   alert("报名失败！");
        	  }
        	 },"json");
	 
    

    }
   
    </script>
</head>
<body class="bj-huang lock">
 
<main class="cmp640">
 
  <%@ include file="/webcom/vote-head.jsp" %>   
 
 <div class="width-10 txt-c pt-10 weight500 zi-zong">
        <font size="5">
            报名处
        </font>
 </div>

    <div class="pl-10 pr-10">
        <font size="2">
            <div class="pt-20 overflow-hidden">
                <a href="#">
                    <div class="col-3 weight500 hang35 zi-bai txt-l zi-zong" style="line-height:35px;">
                        <font size="3">
                           名称:
                        </font>
                    </div>
                </a>

                <div class="col-9 pt-5 bg-bai " style="border-radius: 50px;height: 35px;">
                    <input class="width-10 pl-10 zi-hui hang25 weight500"
                           style="line-height:27px;background-color: transparent;"
                           type="text"
                           id="title"
                           value="请输入姓名或者标题" onfocus="if(value=='请输入姓名或者标题'){value=''}"
                           onblur="if (value ==''){value='请输入姓名或者标题'}">
                </div>
            </div>
            <div class="pt-20 overflow-hidden">
                <a href="#">
                    <div class="col-3 hang40 zi-bai txt-l zi-zong weight500" style="line-height:40px;">
                        <font size="3">
                            联系电话:
                        </font>
                    </div>
                </a>

                <div class="col-9 pt-5 bg-bai " style="border-radius: 50px;height: 35px;">
                    <input class="width-10 pl-10 zi-hui hang25 weight500"
                           style="line-height:27px;background-color: transparent;"
                           type="text"
                           id="tel"
                           value="请输入电话" onfocus="if(value=='请输入电话'){value=''}"
                           onblur="if (value ==''){value='请输入电话'}">
                </div>
            </div>
            <div class="pt-10 overflow-hidden">
                <a href="#">
                    <div class="col-3 hang35 zi-bai txt-l zi-zong weight500" style="line-height:35px;">
                        <font size="3">
                            上传图片<br>1-5张:
                        </font>
                    </div>
                </a>

                <div class="col-9 pic-list" >
 
                    <!--添加图片按钮-->
                    <a href="#">
                        <div class="col-3 pt-10">
                            <div class="img-wh55 maring-a">
                                <div class="position-r">
                                    <div class="zi-zong img-wh55 border-radius3 txt-c"
                                         style="border: dashed 4px #630601;">
                                        <i class="fa fa-plus fa-2x" style="line-height:50px;"></i>
                                    </div>
                                    <input type="file" accept="image/*" class="file cameraInput" name="cameraInput">
                                </div>
                            </div>
                        </div>
                    </a>
                    <!--添加图片结束-->


                </div>
            </div>
            <div class="pt-20 maring-a overflow-hidden">
                <a href="#">
                    <div class="col-3 weight500 hang35 zi-bai txt-l zi-zong" style="line-height:35px;">
                        <font size="3">
                            描述:
                        </font>
                    </div>
                </a>

                <form>
                <textarea id="content" onfocus="if(value=='请输入描述'){value=''}"
                          onblur="if (value ==''){value='请输入描述'}" rows="5" class="size12 weight500 zi-hui  col-9"
                          style="height:80px;border-radius:10px;">请输入描述</textarea>
                </form>
            </div>
        </font>
 
        <div class="zi-hong2 pt-20 weight500" style="line-height: 22px;">
            <font size="3">
                <p>${entity.content}</p>
            </font>
        </div>

        <div class="pt-30 pb-20">
            <a href="javascript:submint()">
                <div class="weight500 zi-bai maring-a border-radius5  btn-hong2 div-group-10 txt-c">
                    <font size="3">确认报名</font>
                </div>
            </a>
        </div>
    </div> 
   <%@include file="/webcom/foot.jsp" %>
</main>
<div class="clear hang50"></div>
<%@ include file="/webcom/vote-foot.jsp" %>
<script src="${contextPath}/mvccol/lrz/exif.js"></script>
<script src="${contextPath}/mvccol/lrz/lrz.js"></script>
<script src="${contextPath}/mvccol/lrz/mobileFix.mini.js"></script> 
<script src="${contextPath}/mvccol/lrz/index1.js"></script>
</body>
<%@ include file="/webcom/toast.jsp" %>
<c:if test="${com.zsjf>0}">
  <c:if test="${sczs==1}">
  <%@ include file="/webcom/jfts-page.jsp" %>
  </c:if> 
</c:if>
</html>