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
    <!-- Resource style -->
    <script src="${ctx }/app/js/jquery-1.8.3.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx }/app/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="${ctx }/app/css/font-awesome-ie7.min.css" rel="stylesheet"/>
    <link href="${ctx }/app/css/style_0.css" rel="stylesheet"/> 
    <!-- Resource style -->
    <script type="text/javascript" src="${ctx }/app/js/swipe.js"></script>
    <script type="text/javascript">
     
    </script>
    <style> 

        .web-site {
            margin-left: 125px;
        }

        .button-kong {
            width: 30px;
            height: 30px;
            line-height: 26px;
            border-top: solid 2px #eee;
            border-bottom: solid 2px #eee;
        }

        .line-height33 {
            line-height: 33px;
        }
          .bk {
            height: 70px;
            width: 70px;
        }
        .border-bottom-d9d9d9{
            border-bottom: solid 1px #d9d9d9;
            
        }
        .zi-353535{
            color: #353535;
        }
        .zi-bbbbbb{
            color: #bbbbbb;
        }
        .zi-9a9a9a{
            color: #9a9a9a;
        }
        .zi-d8d8d8{
            color: #d8d8d8;
        }
        .hang-sl-2{
            overflow: hidden;text-overflow:ellipsis;display: -webkit-box;-webkit-line-clamp:4;-webkit-box-orient:vertical;
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
    $.post('${ctx}/shop/shop!ajaxorders.action?custid=${custid}&agid=${agid}&lscode=${lscode}&fypage='+fypage, submitData,
       	function(json) { 
    		var xszf=$('#ajaxdiv').html();  
    		
	    	if(json.state=='0'){
	    		var v = json.list;  
	    		 for(var i=0;i<v.length;i++){  
	    		  xszf+='<div class="pl-10 pr-10 pt-10 overflow-hidden">'
	    		      +'<div class="bg-bai border-radius5">'
	    		      +'<div class="hang30 line-bottom-98 zi-hui-tq weight500 overflow-hidden line-height30 pl-5 pr-5 zi-353535">'
	    		      +'<font size="1"><div class="col-9 sl">订单编号:<i class="pl-5">'+v[i]._id+'</i></div>'
	    		      +'<div class="col-3 txt-r sl zi-cheng" onclick="del('+v[i]._id+')"><i class="fa fa-trash-o zi-hong line-height40"></i></div>'
	    		      +'</font></div>';
	    		      if(v[i].list!=null){
	    		       var list=v[i].list; 
	    		       for(var j=0;j<list.length;j++){
	    		            xszf+='<div class="clear div-group-10 position-r hang90 border-radius5">'
	    		         +'<div class=" position-a"><div class="img-bj bk border-radius3" style="background-image:url(${filehttp}/'+list[j].pro.logo+');"></div>'
	    		         +'</div>'
	    		         +'<div style="padding-left:80px;">'
	    		         +'<font size="2">'
	    		         +'<div class="zi-6 weight500 sl">'+list[j].pro.ptitle+'</div>'
	    		         +'</font>'
	    		         +'<div class=" pull-left weight500 width-10">'
	    		         +'<font size="1">';
	    		         if(v[i].kdcom!=null){
	    		           xszf+='<div class="clear sl hang30 weight100" style="line-height:35px;" onclick="getkd('+v[i].kdno+')">'
	    		               +'<span class="zi-hui">'+v[i].kdcom+'<i class="zi-lan pl-5">'+v[i].kdno+'</i><span class="zi-lan-tq pl-10">点击查看</span></span>'
	    		               +'</div>';
	    		               
	    		         }else{
	    		           xszf+='<div class="clear sl hang30 weight100" style="line-height:35px;" onclick="getkd('+v[i].kdno+')">'
	    		               +'<span class="zi-hui"><span class="zi-lan-tq">暂无物流信息</span></span>'
	    		               +'</div>';
	    		         }
	    		         xszf+='<div class=" hang30 width-10 line-height30 zi-6">'  
	    		         +'<div class="col-9">共'+list[j].count+'件商品<i class="pl-10 zi-hong">￥'+v[i].zfmoney.toFixed(2)+'元</i></div>';
	    		         if(v[i].state==1){
	    		          xszf+='<div class="col-3 txt-r zi-bbbbbb">已下单</div>';
	    		         }else if(v[i].state==2){
	    		          xszf+='<div class="col-3 txt-r zi-bbbbbb">待发货</div>';
	    		         }else if(v[i].state==3){
	    		          xszf+='<div class="col-3 txt-r zi-bbbbbb">已发货</div>'; 
	    		         }else if(v[i].state==5){
	    		          xszf+='<div class="col-3 txt-r zi-bbbbbb">已退款</div>';
	    		         } 
	    		         xszf+='</div></font></div></div></div>';
	    		       }
	    		     
	    		      }
	    		     xszf+='</div></div>';
	    	 
				}
				
			 
	    		fypage++;
            }else{
               // xszf='<font size="2"><div class="div-group-10 width-10 txt-c zi-hui-tq weight500 pt-40">您暂时还没有任何订单，<a href="${ctx}/shop/shop!index.action?lx=1&custid=${custid}&agid=${agid}&fromUserid=${fromUserid}"><i class="zi-green">去转转</a></div></font>';
            }
            issend=true;
			$('#ajaxdiv').html(xszf);
			 
	},"json")
	
}
function del(id) {
	  
    var submitData = {
    	 id:id
    };

    $.post('${ctx}/shop/shop!ajaxdelorder.action?custid=${custid}&agid=${agid}&lscode=${lscode}', submitData,
    	function (json) {
    	
        	if(json.state==0){ 	
        	 alert("删除成功！");
        	 window.location.reload();
        	}
        },"json");
  
} 
  function  getkd(id){
   window.location.href='http://m.kuaidi100.cn/result.html#com=auto&no='+id;
  }
</script>
</head>
<body>
 
<main class="clear cmp640 lock bg-hui-92">

    <div id="ajaxdiv"></div>
    <c:if test="${ordercount==0}">
    <font size="2"><div class="div-group-10 width-10 txt-c zi-hui-tq weight500 pt-40">您暂时还没有任何订单，<a href="${ctx}/shop/shop!index.action?lx=1&custid=${custid}&agid=${agid}&lscode=${lscode}"><i class="zi-green">去转转</a></div></font>
    </c:if>
    <div class="hang50"></div>

</main>

<!--底部三个按钮-->
 <%@ include file="/webcom/shop-foot1.jsp"%> 
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