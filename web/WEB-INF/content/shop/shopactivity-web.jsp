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
    <script src="${ctx }/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx }/app/css/font-awesome.min.css" rel="stylesheet">
    <link href="${ctx }/app/css/font-awesome-ie7.min.css" rel="stylesheet">
    <link href="${ctx }/app/css/style_0.css" rel="stylesheet"> 
    
    <link href="${ctx}/mvccol/SweetAlert2/css/sweetalert2.min.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/animo.css" rel="stylesheet"/>
    <link href="${ctx}/mvccol/SweetAlert2/css/buttons.css" rel="stylesheet"/>
    <script src="${ctx}/mvccol/js/fomatdate1.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/sweetalert2.min.js"></script>
    <script src="${ctx}/mvccol/SweetAlert2/js/promise.js"></script>
    <script type="text/javascript" src="${ctx }/app/js/swipe.js"></script>
    <script type="text/javascript"></script>
    <style>
     .bk {
            height: 70px;
            width: 90px;
        }
    </style>
    <script>
    var issend=true;
    var fypage=0;
    var xszf="";
	var type="";
function ajaxjz(){
    if(!issend){
    	return;
    }
   	var submitData = {  
    };
    issend=false; 
    $.post('${ctx}/shop/shopactivity!ajaxkj.action?custid=${custid}&agid=${agid}&lscode=${lscode}&fypage='+fypage, submitData,
       	function(json) { 
    		var xszf=$('#ajaxdiv').html();
	    	if(json.state=='0'){
	    	  var  list=json.list;
	    	  for(var i=0;i<list.length;i++){
	    	      xszf+='<div class="line-bottom-92 clear div-group-10 overflow-hidden position-r" style="height:90px;">'
	    	          +'<a href="${ctx}/shop/shop!bargaindetail.action?custid=${custid}&agid=${agid}&lscode=${lscode}&id='+list[i]._id+'"><div class=" position-a">'
	    	          +' <div class="img-bj bk border-radius3" style="background-image: url(${filehttp}/'+list[i].pro.logo+');"></div></div></a>'
	    	          +'<div style="padding-left:100px;"><div class="zi-6 weight500">'
	    	          +'<font size="2"><div class="col-11 hang20 line-height20 sl zi-hei">'+list[i].pro.ptitle+'</div>'
	    	          +'<a href="javascript:del(\''+list[i]._id+'\')"> <div class="pull-right col-1 hang20 txt-c"> <i class="fa fa-trash-o zi-hong line-height20"></i> </div></a></font></div>'
	    	          +'<div class=" pull-left weight500 width-10 pt-30">'
	    	          +'<font size="2">'
	    	          +'<div class=" zi-cheng hang20 line-height20 width-10">'+list[i].pro.summary
	    	          +'</div></font></div></div></div>';
	    	  }
	    	  fypage++;
            }else{
            }
            issend=true;
			$('#ajaxdiv').html(xszf);
			 
	},"json")
}
function del(id) {  
    var submitData = {
    	 id:id
    };
    $.post('${ctx}/shop/shopactivity!ajaxdelkj.action?custid=${custid}&agid=${agid}&lscode=${lscode}', submitData,
    	function (json) {
        	if(json.state==0){ 	
        	 alert("删除成功！");
        	 window.location.reload();
        	}
        },"json");
}
    </script>
</head>
<body>
<main class="clear cmp640 lock">
    <div id="ajaxdiv"></div>  
 <%@include file="/webcom/foot.jsp" %>
</main> 
<div class="hang50 clear"></div>
<%@ include file="/webcom/shop-foot.jsp"%>
</body> 
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
</html>