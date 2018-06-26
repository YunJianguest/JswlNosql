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
    <link href="${ctx}/app/css/style_0.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"> 
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
    $.post('${ctx}/suc/task!ajaxweb.action?custid=${custid}&lscode=${lscode}&fypage='+fypage, submitData,
       	function(json) { 
    		var xszf=$('#ajaxdiv').html();
    		 
	    	if(json.state=='0'){
	    		var v = json.list; 
	    		
	    		 for(var i=0;i<v.length;i++){  
	    		    xszf+='<a href="#">'
	    		    +'<div class="line-bottom  zi-6 overflow-hidden txt-c" style="border-radius:5px 5px 0px 0px ;">'
	    		    +'<div class="col-4 pt-15 pb-10 sl">'
	    		    +'<div class="width-9 maring-a clear sl"><font size="2">'+v[i].title+'</font></div></div>';
	    		    if(v[i].expreward>0&&v[i].jfreward>0){
	    		    xszf+='<div class="col-4 pt-15 pb-10"><font size="2">经验'+v[i].expreward+'/积分'+v[i].jfreward+'</font></div>';
	    		    }else if(v[i].expreward>0&&v[i].jfreward<=0){
	    		    xszf+='<div class="col-4 pt-15 pb-10"><font size="2">经验'+v[i].expreward+'</font></div>';
	    		    }else if(v[i].expreward<=0&&v[i].jfreward>0){
	    		    xszf+='<div class="col-2 pt-15 pb-10"><font size="2">积分'+v[i].jfreward+'</font></div>';
	    		    
	    		    }
	    		     
	    		    xszf+='<div class="col-2 pt-15 pb-10"><font size="2">'+v[i].cou+'/'+v[i].count+'</font></div>';
	    		    if(v[i].state==0){
	    		    xszf+='<div class="col-2 pt-15 pb-10"><font size="2">是</font></div>';
	    		    }else {
	    		    xszf+='<div class="col-2 pt-15 pb-10"><font size="2">否</font></div>';
	    		    } 
	    		    xszf+='</div></a>';
	    	 
	    		   
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
<body>
<main class="lock cmp640"> 
    <div class="top_foot bg-hui-92 zi-bai hang40 line-height40 cmp640 line-bottom">
        <a href="#">
            <div class="pull-left zi-hei weight500 pl-15"><font size="2">今日任务<i class="zi-cheng">${entity.jf}</i></font>
            </div>
        </a>
        <a href="#">
            <div class="pull-right zi-green weight500 pr-15"onclick="window.location.href='${ctx}/set/help!web.action?custid=${custid}&lscode=${lscode}'"><font size="2">帮助中心</font></div>
        </a>
    </div>
    <div class="txt-c zi-cheng  div-group-5 pt-50">
        <div class="line-left1 line-top line-bottom line-right border-radius5">
            <!--<a href="#">-->
            <!--<div class="line-bottom  zi-6 overflow-hidden txt-c"-->
            <!--style="border-radius:5px 5px 0px 0px ;">-->
            <!--<div class="col-12 pt-15 pb-10 weight500"><font size="2">积分获得/消费明细</font></div>-->
            <!--</div>-->
            <!--</a>-->
            <div class="line-bottom  zi-6 overflow-hidden txt-c weight500" style="border-radius:5px 5px 0px 0px ;">
                    <div class="col-4 pt-15 pb-10"><font size="2">任务名称</font></div>
                    <div class="col-4 pt-15 pb-10"><font size="2">奖励</font></div>
                    <div class="col-2 pt-15 pb-10"><font size="2">次数</font></div>
                    <div class="col-2 pt-15 pb-10"><font size="2">完成</font></div>
            </div>
            <!--循环列表开始-->
            <div class="" id="ajaxdiv">
            </div>
            <!--下面代码不要删除或者循环-->
            <a href="#">
                <div class="zi-hui zi-green overflow-hidden txt-c"
                     style="border-radius:5px 5px 0px 0px ;">
                    <div class="col-15 pt-15 pb-10"><font size="2">完成任务可获得大量经验和丰富的积分</font></div>
                </div>
            </a>
        </div>
    </div>
</main>
<script>
ajaxjz();
</script>
</body>
<c:if test="${not empty com.ewmurl}">
 <c:if test="${com.ewmxs==0}">
  <%@ include file="/webcom/focus-page.jsp" %>
 </c:if>
</c:if>
</html>