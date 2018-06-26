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
    <title>${entity.title}</title>
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <style>
        /*行数限制文本超出隐藏*/
        .hang-sl-2 {
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }
        .zi-jin {
            color: #e3c06a;
        }
        .fa-spin1 {
            -webkit-animation: fa-spin 1s infinite linear;
            animation: fa-spin 1s infinite linear
        }
        .btn-jin {
            background-color: #e3c06a;
        }

        .btn-jin:hover {
            background-color: #e3b647;
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
    	 var picurl='';
    	 var submitData = { 
     	        id:'${id}', 
     	        content:$("#content").val().replace('请简单描述您的文书服务需求（300字以内）',''),
     	        picurl:picurl
 	            };  
     $.post('${ctx}/suc/lawyer!ajaxcommentadd.action?custid=${custid}&lscode=${lscode}', submitData,
         	 function(json){
         	  if(json.state==0){ 
         	  window.location.href='${ctx}/suc/lawyer!detail.action?custid=${custid}&lscode=${lscode}&id=${id}';
         	  }else{
         	   alert("发表失败！");
         	  }
         	 },"json");
    }
    </script>
</head>
<body>

<main class="cmp640">

    <div class="hang90 overflow-hidden width-10 line-bottom-92 position-r">
        <div class="pull-left img-wh60 position-a" style="top: 15px;left: 10px;">
            <c:if test="${not empty entity.picurl}">
              <img src="${filehttp}/${entity.picurl}" class="width-10 border-radius50"/>
            </c:if>
            <c:if test="${empty entity.picurl}">
              <img src="${ctx}/img/unfind.jpg" class="width-10 border-radius50"/>
            </c:if>
        </div>
        <div class="pt-5 pr-10 width-10" style="padding-left: 80px;">
            <div class="mt-10">
                <div class="zi-hei-tq sl weight500 zi-6">${entity.title}</div>
            </div>
            <div class=" hang40" style="display: table-cell;line-height: 20px; vertical-align: middle;">
                <div class="clear zi-hui hang-sl-2">
                    ${entity.summary}
                </div>
            </div>
        </div>
    </div>
    <div class="hang7 bg-hui-92"></div>
    <div class="div-group-10 overflow-hidden line-bottom-92 clear">
        <div class="hang20 line-height20 weight500 zi-6">服务内容
            <div class="pull-right size10 zi-hui-tq">文书审核/修改<i class="fa fa-chevron-right pl-5"></i></div>
        </div>
    </div>
    <div class="div-group-10 overflow-hidden line-bottom-92 clear">
        <div class="hang20 line-height20 weight500 zi-6">期望交付日期
            <div class="pull-right size10 zi-hui-tq">2017-04-23<i class="fa fa-chevron-right pl-5"></i></div>
        </div>
    </div>
    <div class="hang7 bg-hui-92"></div>
    <div class="line-bottom-92 overflow-hidden"> 
                <textarea id="content" onfocus="if(this.value=='请简单描述您的文书服务需求（300字以内）'){this.value=''};this.style.color='#aaa';"
                          onblur="if(this.value==''||this.value=='请简单描述您的文书服务需求（300字以内）'){this.value='请简单描述您的文书服务需求（300字以内）';this.style.color='#aaa';}"
                          rows="5" name="message" class="size12 weight500"
                          style="height:90px;" onKeyDown="textCounter(message,remLen,300);"
                          onKeyUp="textCounter(message,remLen,300);">请简单描述您的文书服务需求（300字以内）</textarea>
            <input name="remLen" type="text" value="300字" size="5" readonly="readonly"
                   class="zi-hui size12 pl-2 pb-10 pull-right"/> 
    </div>

    <div class="hang30 line-height30 zi-hui-tq bg-hui-92 pl-10 size12">如有需要请上传相关资料</div>
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
 
  <%@ include file="/webcom/foot.jsp" %>
</main>
<div class="hang40"></div>
<div class="position-f width-10 hang40"style="bottom: 2px;left: 0px;" id="submint">
    <div class="clear border-radius3 hang40 txt-c line-height40 zi-bai btn-jin width-9_5 maring-a">
        确认提交
    </div>
</div>
<script src="${contextPath}/mvccol/lrz/exif.js"></script>
<script src="${contextPath}/mvccol/lrz/lrz.js"></script>
<script src="${contextPath}/mvccol/lrz/mobileFix.mini.js"></script> 
<script src="${contextPath}/mvccol/lrz/index.js"></script>
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

</body>
</html>