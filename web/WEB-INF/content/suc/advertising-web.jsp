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
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
   <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet">
    <link href="${ctx}/app/css/style_0.css" rel="stylesheet"> 
    <style>
        .dhid {
            width: 60px ! important;
            margin-right: 7px ! important;
        }
        .pb-7 {
            padding-bottom: 7px;
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
    </style>
     <script>
    var issend=true;
    var fypage=0;
    var xszf="";
	var type="";
  function ajaxjz(){//加载 
    if(!issend){
    	return;
    }
   	var submitData = {
    };
    issend=false; 
    $.post('${ctx}/suc/advertising!ajaxweb.action?custid=${custid}&lscode=${lscode}&fypage='+fypage, submitData,
       	function(json) { 
    		var xszf=$('#ajaxdiv').html();
	    	if(json.state=='0'){
	    		var v = json.list;  
	    		 for(var i=0;i<v.length;i++){  
	    	 	    xszf+='<div class="col-12 div-group-5 pb-15">'
	    	 	        +'<div class=" border-radius3 overflow-hidden line-left1 line-right line-top line-bottom">'
	    	 	        +'<img src="${filehttp}/'+v[i].picurl+'" width="100%">'
	    	 	        +'<div class="div-group-5 pb-10 overflow-hidden">'
	    	 	        +'<div class="pt-5"><div class="pull-left">'+v[i].createdate+'开始</div>';
	    	 	        if(v[i].enddate!=null){
	    	 	        xszf+='<div class="pull-right">'+v[i].enddate+'终止</div></div>';
	    	 	        } 
	    	 	        xszf+='<div class="pt-10 clear">'
	    	 	        +'<div class="pull-left">总计花费<i class="zi-green">'+v[i].price+'元</i></div>';
	    	 	        if(v[i].state==1){
	    	 	        xszf+='<div class="pull-right">已停止</div></div>';
	    	 	        } 
	    	 	        if(v[i].state==2){
	    	 	        xszf+='<div class="pull-right">待审核</div></div>';
	    	 	        } 
	    	 	        if(v[i].state==3){
	    	 	        xszf+='<div class="pull-right">投放中</div></div>';
	    	 	        }
	    	 	        xszf+='<div class="pt-10 clear">'
	    	 	        +'<div class="pull-left">此条广告投放时间<i class="zi-green">'+v[i].time+'</i>时</div>'
	    	 	        +'<a href="${ctx}/suc/advertising!webadd.action?custid=${custid}&lscode=${lscode}&id='+v[i]._id+'"><div class="pull-right zi-hong pl-10">修改</div></a>'
	    	 	        +'</div></div></div></div></div>';
	    	    }
	    		fypage++;
	    	}else{
	    	} 
	    	issend=true;
			$('#ajaxdiv').html(xszf);
	},"json")
}
    </script>
</head>
<body class="bg-bai">
<main class="cmp640">
   <c:if test="${count>0}"> 
    <a href="${ctx}/suc/advertising!webadd.action?custid=${custid}&lscode=${lscode}">
        <div class="pt-20 pb-20 weight500 overflow-hidden clear">
            <font size="2">
                <div class="txt-c zi-hui-wx">
                    您已投放<i class="zi-green">${count}</i>条广告<i class="zi-green pl-5">继续投放广告</i>
                </div>
            </font>
        </div>
    </a>
    </c:if>
    <font  size="2" class="weight500 zi-hui-wx" id="ajaxdiv">
    </font>
    <c:if test="${count==0}">
     <div class="pt-20 weight500 overflow-hidden clear">
        <font size="2">
            <div class="txt-c zi-hui-wx">
                您还没有投放任何广告<a href="${ctx}/suc/advertising!webadd.action?custid=${custid}&lscode=${lscode}"><i class="zi-green pl-5">去投放广告</i></a>
            </div>
        </font>
    </div>
    </c:if>
</main>
<script>
ajaxjz();
</script>
</body>
</html>
