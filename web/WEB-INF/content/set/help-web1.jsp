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
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet">
    <link href="${ctx}/app/css/style_0.css" rel="stylesheet"> 
    <script src="${ctx}/mvccol/js/fomatdate.js"></script>
      <style>
        .bg-bai-8 {
            background-color: rgba(225, 225, 225, 0.9);
        }
        .line-bottom-c3c3c6 {
            border-bottom: 1px solid #c3c3c6;
        }
    </style>
    <script>
        var issend = true;
        var fypage = 0;
        var type='${type}';
         function ajaxjzc(v,tag) {
           if(v!=0){
           type=v;
           }  
            var submitData = {
                lx: 1,
                type:type,
            }; 
            if(!tag){
            fypage=0;
            } 
            $.post('${ctx}/set/help!ajaxweb.action?custid=${custid}&lscode=${lscode}&fypage=' + fypage, submitData, function (json) {
                var xszf='';
                if(tag){
                xszf=$('#ajaxdiv').html();  
                }  
                if (json.state == 0) {
                    var v = json.list;
                    for (var i = 0; i < v.length; i++) {
                        xszf +='<a href="${ctx}/set/help!detail.action?id='+v[i]._id+'"><div class="div-group-10 overflow-hidden line-bottom">'
                             +'<div class="col-1">'
                             +'<div class="img-wh20 zi-bai border-radius50 bj-hong1 txt-c line-height20 maring-a">1</div></div>'
                             +'<div class="col-10 pl-10 sl zi-6 line-height20">'+v[i].title+'</div>'
                             +'<div class="col-1">'
                             +'<div class="img-wh20 zi-hui txt-r maring-a"><i class="fa fa-chevron-right line-height20"></i></div></div></div></a>';
                    }
                    fypage++;
                } else {
                }
                issend = true;
                if(xszf==''){
              xszf += '<div class="div-group-10 overflow-hidden txt-c">' 
                             +'<div class="col-12 pl-10 sl zi-6 line-height20">暂时没有帮助，请查阅其他其他帮助或者联系管理员！</div></div>';
                }
                $('#ajaxdiv').html(xszf); 
            }, "json");
        }
        function cancel(){
         $('#types').hide();
        }
        function  showtype(){
        $('#types').show();
        }
         function ajaxjz() {
            var submitData = {
                lx: 1, 
            };  
            $.post('${ctx}/set/help!ajaxweb.action?custid=${custid}&lscode=${lscode}&fypage=' + fypage, submitData, function (json) {
                var xszf=$('#ajaxdiv').html();  
                if (json.state == 0) {
                    var v = json.list; 
                    for (var i = 0; i < v.length; i++) {
                        xszf +='<div class="bg-hui-92 zi-bai hang40 line-height40 cmp640 line-bottom">'
                             +'<div class="pull-left zi-hei weight500 pl-15"><font size="2">';
                             if(v[i].type==-1){
                             xszf+='其他帮助</font></div></div>';
                             }
                             if(v[i].type==1){
                             xszf+='系统帮助</font></div></div>';
                             }
                             if(v[i].type==2){
                             xszf+='任务攻略</font></div></div>';
                             }
                             if(v[i].type==3){
                             xszf+='商城帮助</font></div></div>';
                             } 
                             if(v[i].type==4){
                             xszf+='积分帮助</font></div></div>';
                             } 
                             var list=v[i].list;  
                             for ( var j = 0; j <list.length; j++) { 
								xszf+='<a href="javascript:showcontent('+list[j]._id+')">'
								+'<div class="div-group-10 clear overflow-hidden line-bottom">'
								+'<div class="col-1">'
								+'<div class="img-wh20 zi-bai border-radius50 bj-hong1 txt-c line-height20 maring-a">'+list[j].sort+'</div>'
								+'</div>'
								+'<div class="col-10 pl-10 sl zi-6 line-height20">'
								+list[j].title+'</div>'
								+'<div class="col-1">'
								+' <div class="img-wh20 zi-hui txt-r maring-a"><i class="fa fa-chevron-right line-height20"></i></div></div></div></a>'
								+'<div class="div-group-10 pt-15 pb-15 line-bottom display-none" id="'+list[j]._id+'_content">'
								+'<font size="2"> <div class="zi-6 line-height20">'+list[j].content+'</div></font>'
								+'</div>';
							 }
                    }
                    fypage++;
                } else {
                }
                 if(xszf==''){
              xszf += '<div class="div-group-10 overflow-hidden txt-c">' 
                             +'<div class="col-12 pl-10 sl zi-6 line-height20">暂时没有帮助，请查阅其他其他帮助或者联系管理员！</div></div>';
                }
                issend = true; 
                $('#ajaxdiv').html(xszf); 
            }, "json");
        }
        function showcontent(id){
          if($("#"+id+"_content").is(":hidden")){
            $("#"+id+"_content").show();  
          }else{
            $("#"+id+"_content").hide();   
         } 
        }
    </script>
</head>
<body class="bg-bai">
<main class="cmp640">  
<div class="clear" id="ajaxdiv"></div>
</main> 
 <%@ include file="/webcom/limit.jsp" %>
</body>
<script type="text/javascript"> 
ajaxjz();
$(window).scroll(function () {
        var offsetY = $(window).scrollTop();
        var section1 = $("#section1").height();
        if (section1 - offsetY < 600) { 
            ajaxjz(); 
        }
 });
</script>
</html>
