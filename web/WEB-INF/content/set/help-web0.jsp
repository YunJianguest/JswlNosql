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
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet">
    <link href="${ctx}/app/css/style_0.css" rel="stylesheet"> 
    <script src="${ctx}/mvccol/js/fomatdate.js"></script>
      <style>
        .yqbtn {
            background-color: #ffffff;
            color: #ef8200;
        }
        .yqbtn:hover {
            background-color: #ef8200;
            color: #ffffff;
        }
        .yqbtn1 {
            background-color: #ffffff;
            color: limegreen;
        }
        .yqbtn1:hover {
            background-color: limegreen;
            color: #ffffff;
        }
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
         function ajaxjz(v,tag) {
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
    </script>
</head>
<body class="bg-bai">
<main class="cmp640"> 
 <div class="bg-hui-92 zi-bai hang40 cmp640 line-bottom"> 
            <div class="pull-left zi-hei weight500 line-height40 pl-15"><font size="2">平台攻略</font>
            </div> 
            <div class="pull-right zi-green weight500 line-height40 pr-15" onclick="showtype()"><font size="2">选择类别</font></div>
</div>
<div class="clear" id="ajaxdiv"></div>
</main> 
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="types">
    <div class="overflow-hidden width-10">
        <a href="javascript:shezhixiaoshi2()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>
        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5">
                        <a href="javascript:ajaxjz('-1',false),cancel()">
                            <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                                其他帮助
                            </div>
                        </a>  
                        <a href="javascript:ajaxjz('1',false),cancel()">
                            <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                                系统帮助
                            </div>
                        </a> 
                        <a href="javascript:ajaxjz('2',false),cancel()">
                            <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                                任务帮助
                            </div>
                        </a> 
                        <a href="javascript:ajaxjz('3',false),cancel()">
                            <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                                商城帮助
                            </div>
                        </a>   
                        <a href="javascript:ajaxjz('4',false),cancel()">
                            <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                                商城帮助
                            </div>
                        </a>   
            </div>
            <a href="javascript:cancel()">
                <div class="pt-10">
                    <div class="border-radius5 maring-a width-9_5 zi-bai txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                        取消
                    </div>
                </div>
            </a>
        </div>
    </div>
</div>
<%@ include file="/webcom/limit.jsp" %>
</body>
<script type="text/javascript">  
ajaxjz(0,false);
$(window).scroll(function () {
        var offsetY = $(window).scrollTop();
        var section1 = $("#section1").height();
        if (section1 - offsetY < 600) { 
            ajaxjz(0,true); 
        }
 });
</script>
</html>
