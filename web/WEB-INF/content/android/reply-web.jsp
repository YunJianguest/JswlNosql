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
    <style>
        .border-bottom-d9d9d9{
            border-bottom: solid 1px #d9d9d9;
        }
    </style>
    <script>
        var issend_msg=true;
        var issend_linkman=true;
        var issend_orders=true;
        var fypage_msg=0;
        var fypage_linkman=0;
        var fypage_orders=0;
        var xszf = ""; 
        function ajaxmsg() {//加载消息
            if (!issend_msg) {
                return;
            } 
            issend = false;
            $.post('${ctx}/android/reply!ajaxweb.action?custid=${custid}&lscode=${lscode}&fypage='+fypage_msg, null,
                    function (json) { 
                        var xszf = $('#ajaxdiv').html();   
                        if (json.state == '0') {
                            var v = json.list;
                            for (var i = 0; i < v.length; i++) {
                              xszf+='<div class="hang70 overflow-hidden bg-bai width-10 position-r border-bottom-d9d9d9" onclick="window.location.href=\'${ctx}/android/reply!detail.action?custid=${custid}&lscode=${lscode}&id='+v[i]._id+'&ids='+v[i].ids+'&pid='+v[i].pid+'\'">'
                                  +'<div class="pull-left img-wh50 position-a" style="top: 10px;left: 10px;">'
                                  +'<img src="${filehttp}/'+v[i].headimgurl+'" class="width-10 border-radius3">';
                                  if(v[i].uncount>0){
                                  xszf+='<div class="position-a bg-hong zi-bai border-radius50 img-wh15 txt-c sl"style="top:-3px; right: -5px;line-height: 15px;">'
                                      +'<font size="1">'+v[i].uncount+'</font></div>';
                                  }   
                                  xszf+='</div>'
                                  +'<div class="pt-10 pr-10 width-10" style="padding-left:70px;">'
                                  +'<font size="2">'
                                  +'<div class="hang25 line-height25 zi-hei-tq">'
                                  +'<div class="col-9 sl">和'+v[i].nickname+'的聊天</div>'
                                  +'<font size="1">';
                                  if(v[i].endupdate!=null){
                                  xszf+='<div class="col-3 txt-r sl zi-bbbbbb">'+v[i].endupdate+'</div>';
                                  }
                                  
                                  xszf+='</font></div></font>'
                                  +'<font size="2">'
                                  +'<div class="hang25 line-height25 zi-hui-wx">';
                                  if(v[i].endmsg!=null){
                                  xszf+='<div class="col-11 sl">'+v[i].endmsg+'</div>';
                                  } 
                                  xszf+='</div></font></div></div>';
               
                           }
                            fypage_msg++;
                        } else {
                        }
                        issend_msg = true; 
                        $('#ajaxdiv').html(xszf);
                        
                    }, "json")
        }
        
         function ajaxlinkman() {//加载联系人 
            if (!issend) {
                return;
            } 
            issend = false;
            $.post('${ctx}/android/permissions!ajaxweb.action?custid=${custid}&lscode=${lscode}', null,
                    function (json) {
                        var xszf = $('#ajaxdiv').html();   
                        if (json.state == '0') {
                            var v = json.list;
                            for (var i = 0; i < v.length; i++) {
                              xszf+='<div class="hang60 overflow-hidden bg-bai width-10 position-r border-bottom-d9d9d9">'
                                  +'<div class="pull-left img-wh40 position-a" style="top: 10px;left: 10px;">'
                                  +'<img src="img/touxiang.jpg" class="width-10 border-radius3">'
                                  +'</div>'
                                  +'<div class="pt-10 pr-10 width-10" style="padding-left:60px;">'
                                  +'<font size="2">'
                                  +'<div class="hang40 line-height40 zi-hei-tq sl weight500">对方微信名</div>'
                                  +'</font></div></div>';
                  
                           }
                            fypage++;
                        } else {
                        }
                        issend = true; 
                        $('#ajaxdiv').html(xszf);
                        
                    }, "json")
        }
        
         function ajaxorders() {//加载订单
            if (!issend) {
                return;
            } 
            issend = false;
            $.post('${ctx}/android/permissions!ajaxweb.action?custid=${custid}&lscode=${lscode}', null,
                    function (json) {
                        var xszf = $('#ajaxdiv').html();   
                        if (json.state == '0') {
                            var v = json.list;
                            for (var i = 0; i < v.length; i++) {
                            xszf+='<div class="pt-10 overflow-hidden bg-bai">'
                                +'<div class="hang30 line-bottom-98 zi-hui-tq weight500 overflow-hidden line-height30 pl-5 pr-5 zi-353535">'
                                +'<font size="1">'
                                +'<div class="col-9 sl">店铺/档口名称:<i class="pl-5">手拉手话费专营店</i></div>'
                                +'<div class="col-3 txt-r sl zi-cheng">交易状态</div>'
                                +'</font></div>'
                                +'<div class="clear div-group-10 position-r hang90 border-radius5">'
                                +'<div class=" position-a">'
                                +'<div class="img-bj img-wh70 border-radius3" style="background-image: url(img/a1.png);"></div>'
                                +'</div>'
                                +'<div style="padding-left:80px;">'
                                +'<font size="2">'
                                +'<div class="zi-6 weight500 sl">商品名称或者简介商品名称或者简介商品名称或者简介商品名称或者简介</div>'
                                +'</font>'
                                +'<div class=" pull-left weight500 width-10">'
                                +'<font size="1">'
                                +'<div class="clear sl hang30 weight100" style="line-height:35px;">'
                                +'<span class="zi-hui">订单编号:1256584564584</span>'
                                +'</div>'
                                +'<div class=" hang30 width-10 line-height30 zi-6">'
                                +'<div class="col-9">共2件商品<i class="pl-10 zi-hong">￥100</i></div>'
                                +'<div class="col-3 txt-r zi-bbbbbb">10月25日</div>'
                                +'</div></font></div></div></div></div>';
                  
                           }
                            fypage++;
                        } else {
                        }
                        issend = true; 
                        $('#ajaxdiv').html(xszf);
                        
                    }, "json")
        }
         
    </script>
</head>
<body class="bg-hui">
<main id="ajaxdiv">
     
    
</main>
<!--底部按钮-->
<font size="2">
    <div class=" button_foot bg-bai zi-hui shadow-wai cmp640">
        <div class=" button_group1 zi-6">
            <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-3">
                <font size="3">
                    <div class=" fa fa-user"></div>
                </font>
                <div class="pt-4">
                    消息
                </div>
            </div>
        </div>
        <div class=" button_group1 zi-6">
            <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-3">
                <font size="3">
                    <div class=" fa fa-shopping-cart"></div>
                </font>
                <div class="pt-4">
                    联系人
                </div>
            </div>
        </div>
        <div class=" button_group1 zi-6">
            <a href="#">
                <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-3">
                    <font size="3">
                        <div class="fa fa-user"></div>
                    </font>
                    <div class="pt-4">
                        订单详情
                    </div>
                </div>
            </a>
        </div>
    </div>
</font>
</body>
<script>
ajaxmsg();
</script>
</html>