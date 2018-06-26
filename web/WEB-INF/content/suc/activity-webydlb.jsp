<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ include file="/webcom/limit.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
    <title>${title}</title>
    <script src="${ctx}/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/app/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="${ctx}/app/css/font-awesome-ie7.min.css" rel="stylesheet"/>
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
    $.post('${ctx}/suc/activity!ajaxydweb.action?custid=${custid}&lscode=${lscode}&fypage='+fypage, submitData,
       	function(json) { 
    		var xszf=$('#ajaxdiv').html();
	    	if(json.state=='0'){
	    	  var  list=json.list;
	    	  for(var i=0;i<list.length;i++){
	    	      xszf+='<div class="line-bottom-92 clear div-group-10 overflow-hidden position-r" style="height:90px;">'
	    	          +'<a href="${ctx}/suc/activity!webyd.action?custid=${custid}&lscode=${lscode}&id='+list[i]._id+'"><div class=" position-a">'
	    	          +' <div class="img-bj bk border-radius3" style="background-image: url(${filehttp}/'+list[i].obj.picurl+');"></div></div></a>'
	    	          +'<div style="padding-left:100px;"><div class="zi-6 weight500">'
	    	          +'<font size="2"><div class="col-11 hang20 line-height20 sl zi-hei">'+list[i].obj.title+'</div>'
	    	          +'<a href="javascript:del(\''+list[i]._id+'\')"> <div class="pull-right col-1 hang20 txt-c"> <i class="fa fa-trash-o zi-hong line-height20"></i> </div></a></font></div>'
	    	          +'<div class=" pull-left weight500 width-10 pt-30">'
	    	          +'<font size="2">';
	    	          if(list[i].obj.summary!=null&&list[i].obj.summary!=''){
	    	          xszf+='<div class=" zi-cheng hang20 line-height20 width-10">'+list[i].obj.summary;
	    	          }else{
	    	          xszf+='<div class=" zi-cheng hang20 line-height20 width-10">暂无';
	    	          }
	    	          xszf+='</div></font></div></div></div>';
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
    $.post('${ctx}/suc/activity!ajaxdelkj.action?custid=${custid}&lscode=${lscode}', submitData,
    	function (json) {
        	if(json.state==0){ 	
        	 alert("删除成功！");
        	 window.location.href='${ctx}/suc/activity!webydlb.action?custid=${custid}&lscode=${lscode}'; 
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
<!--底部button-->
    <div class=" button_foot cmp640 shadow-wai weight500" style="bottom:0px;">
        <div class="button_group1">
            <a href="${ctx}/suc/totalactivity!web.action?custid=${custid}&lscode=${lscode}">
                <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5">
                    <font size="4">
                        <div class="fa fa-home"></div>
                    </font>

                    <div class=" pt-3">
                        <font size="1">
                            活动首页
                        </font>
                    </div>
                </div>
            </a>
        </div> 
        <div class=" button_group1">
            <a href="${ctx}/suc/activity!webydlb.action?custid=${custid}&lscode=${lscode}">
                <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5">
                    <font size="4">
                        <div class="fa fa-gift"></div>
                    </font>

                    <div class=" pt-3">
                        <font size="1">
                            参与的活动
                        </font>
                    </div>
                </div>
            </a>
        </div>
        <div class=" button_group1">
            <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5"
            onclick="window.location.href='${ctx}/suc/luckydraw!reward.action?custid=${custid}&lscode=${lscode}'">
                <font size="4">
                    <div class="fa fa-money"></div>
                </font>
                <div class=" pt-3">
                    <font size="1">
                        我的卡卷
                    </font>
                </div>
            </div>
        </div>
        <div class=" button_group1">
            <a href="${ctx}/user/fromuser!UserDetail.action?custid=${custid}&lscode=${lscode}">
                <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5">
                    <font size="4">
                        <div class="fa fa-user"></div>
                    </font>

                    <div class=" pt-3">
                        <font size="1">
                            个人中心
                        </font>
                    </div>
                </div>
            </a>
        </div>
    </div>
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