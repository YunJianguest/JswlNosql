<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
<%@ include file="/webcom/limit.jsp" %>
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
    <title>店铺列表</title>
    <!-- Resource style -->
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/> 
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script> 
    <script type="text/javascript">
        var issend = true;
        var fypage = 0; 
        function ajaxjz() {//加载
            if (!issend) {
                return;
            }
            var submitData = { 
            };
            issend = false;
            $.post('${ctx}/shop/shop!ajaxshopmb.action?custid=${custid}&agid=${agid}&fypage=' + fypage, submitData,
                    function (json) {
                        var xszf = $('#ajaxdiv').html(); 
                        if (json.state == 0) {
                            var v = json.list;
                            for (var i = 0; i < v.length; i++) {
                                    xszf+='<li class="pt-15 col-6">'
                                        +'<div class="div3 width-9_5 maring-a txt-c zi-hui-wx line-lu border-radius3 hang25" onclick="detatil('+v[i]._id+')">'
                                        +v[i].name+'</div></li>'; 
                                 }
                           fypage++;
                           $('#ajaxdiv').html(xszf); 
                        } else {
                        } 
                        issend = true;
                    }, "json")
        }
        function  detatil(id){
         window.location.href='${ctx}/shop/shop!storepay.action?custid=${custid}&agid=${agid}&lscode=${lscode}&id='+id;
        }
 
    </script>
    
    <style>
        .yListr3 .zhiding .div3 {
            border: 1px solid #45c01a;
            position: relative;
            color: #45c01a;
        }

        .yListr2 .zhiding a .div2 {
            color: #45c01a;
        }

        .hang25 {
            height: 30px;
            line-height: 28px;
        }
    </style>
</head>
<body class="cmp640">
<main>
 

    <!--第一个-->
    <div>
        <div class="clear div-group-5  maring-a" id="ajaxdiv">

            <div class="overflow-hidden weight500 yListr3">
 
              
            </div>
        </div>
    


    </div>
 

</main>
<script type="text/javascript">
ajaxjz() 
</script> 
</body>
</html>