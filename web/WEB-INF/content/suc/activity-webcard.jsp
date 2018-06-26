<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ include file="/webcom/limit.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport"
          content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>${title}</title>
    <script src="${contextPath}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/app/css/font-awesome.min.css" rel="stylesheet">
    <link href="${contextPath}/app/css/style_0.css" rel="stylesheet"> 
    <script src="${contextPath}/mvccol/js/fomatdate2.js"></script>
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
    </style>
    <script>
        var issend=true;
        var fypage=0;
        function  ajaxjz(){
            var submitData = {
            };
            issend=false;
            $.post('${ctx}/suc/luckydraw!ajaxreward.action?custid=${custid}&lscode=${lscode}&fypage='+ fypage, submitData,function(json){
                var xszf=$('#ajaxdiv').html();
                if(json.state==0){
                    var v = json.list;
                    for(var i=0;i<v.length;i++){
                        if(v[i].state==0){
                            xszf+='<div class="div-group-5 mt-10 col-12" onclick="detail('+v[i].hdid+')">'
                            +'<div class="border-radius5 overflow-hidden kq-hong div-group-3">'
                            +'<div class="hang90 border-radius5 line-bai">'
                            +'<div class="col-9 position-r line-bai-right">'
                            +'<div class="pl-5 pr-5 txt-c weight500 hang90 pt-5">'
                            +'<div class="width-10 weight900 sl zi-bai hang20 line-height20">'
                            +'<font size="3 ">'+v[i].hdtitle+'</font></div>'
                            +'<div class="pt-3 zi-bai hang20 line-height20"><font size="1"><i class="pr-5">'+v[i].jp+'</i>'+Date.prototype.format(v[i].djenddate)+'日前有效</font></div>'
                            +'<div class="pt-3 zi-bai hang20 line-height20"><font size="1"><i class="pr-5"></i><i class="pr-5">中奖日期:</i>'+Date.prototype.format(v[i].insDate)+'</font></div>'
                            +'<div class="pt-3 zi-bai hang20 line-height20"><font size="1"><i class="pr-5"></i><i class="pr-5">序列号:</i>'+v[i].yhj+'</font></div></div>'
                            +'<div class="position-a right-top"><div class="img-wh18 bg-bai border-radius50"></div></div>'
                            +'<div class="position-a right-bottom"><div class="img-wh18 bg-bai border-radius50"></div></div></div>'
                            +'<div class="col-3 weight500 txt-c zi-bai hang70">'
                            +'<font size="4"><div class="pt-12 weight500 zi-bai">还&nbsp;未</div><div class="pt-7 weight500 zi-bai">领&nbsp;取</div></font>'
                            +'</div></div></div></div>';
                        }else if(v[i].state==1){
                            xszf+='<div class="div-group-5 mt-10 col-12">'
                            +'<div class="border-radius5 overflow-hidden kq-hong div-group-3">'
                            +'<div class="hang90 border-radius5 line-bai">'
                            +'<div class="col-9 position-r line-bai-right">'
                            +'<div class="pl-5 pr-5 txt-c weight500 hang90 pt-5">'
                            +'<div class="width-10 weight900 sl zi-bai hang20 line-height20">'
                            +'<font size="3 ">'+v[i].hdtitle+'</font></div>'
                            +'<div class="pt-3 zi-bai hang20 line-height20"><font size="1"><i class="pr-5">'+v[i].jp+'</i>'+Date.prototype.format(v[i].djenddate)+'日前有效</font></div>'
                            +'<div class="pt-3 zi-bai hang20 line-height20"><font size="1"><i class="pr-5"></i><i class="pr-5">中奖日期:</i>'+Date.prototype.format(v[i].insDate)+'</font></div>'
                            +'<div class="pt-3 zi-bai hang20 line-height20"><font size="1"><i class="pr-5"></i><i class="pr-5">序列号:</i>'+v[i].yhj+'</font></div></div>'
                            +'<div class="position-a right-top"><div class="img-wh18 bg-bai border-radius50"></div></div>'
                            +'<div class="position-a right-bottom"><div class="img-wh18 bg-bai border-radius50"></div></div></div>'
                            +'<div class="col-3 weight500 txt-c zi-bai hang70">'
                            +'<font size="4"><div class="pt-12 weight500 zi-bai">已&nbsp;经</div><div class="pt-7 weight500 zi-bai">领&nbsp;取</div></font>'
                            +'</div></div></div></div>';
                        }else{
                            xszf+='<div class="div-group-5 mt-10 col-12">'
                            +'<div class="border-radius5 overflow-hidden bg-hei-7 div-group-3">'
                            +'<div class="hang90 border-radius5 line-bai">'
                            +'<div class="col-9 position-r line-bai-right">'
                            +'<div class="pl-5 pr-5 txt-c weight500 hang90 pt-5">'
                            +'<div class="width-10 weight900 sl zi-bai hang20 line-height20">'
                            +'<font size="3 ">'+v[i].hdtitle+'</font></div>'
                            +'<div class="pt-3 zi-bai hang20 line-height20"><font size="1"><i class="pr-5">'+v[i].jp+'</i>'+Date.prototype.format(v[i].djenddate)+'日前有效</font></div>'
                            +'<div class="pt-3 zi-bai hang20 line-height20"><font size="1"><i class="pr-5"></i><i class="pr-5">中奖日期:</i>'+Date.prototype.format(v[i].insDate)+'</font></div>'
                            +'<div class="pt-3 zi-bai hang20 line-height20"><font size="1"><i class="pr-5"></i><i class="pr-5">序列号:</i>'+v[i].yhj+'</font></div></div>'
                            +'<div class="position-a right-top"><div class="img-wh18 bg-bai border-radius50"></div></div>'
                            +'<div class="position-a right-bottom"><div class="img-wh18 bg-bai border-radius50"></div></div></div>'
                            +'<div class="col-3 weight500 txt-c zi-bai hang70">'
                            +'<font size="4"><div class="pt-12 weight500 zi-bai">已&nbsp;经</div><div class="pt-7 weight500 zi-bai">过&nbsp;期</div></font>'
                            +'</div></div></div></div>';
                        }
                    }
                    fypage++;
                }else{
                }
                issend=true;
                $('#ajaxdiv').html(xszf);
            },"json");
        }
        function detail(id){
        window.location.href='${ctx}/suc/luckydraw!web.action?custid=${custid}&lscode=${lscode}&lucid='+id;
        }
    </script>
</head>
<body class="cmp640 lock">
<main>
    <div id="ajaxdiv"></div>
</main>
<%@include file="/webcom/return-top.jsp" %>
<div class="clear hang50"></div>
<%@ include file="/webcom/lucky-foot.jsp" %>
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