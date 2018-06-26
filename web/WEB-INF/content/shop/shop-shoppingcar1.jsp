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
    <script src="${ctx }/app/js/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="${ctx }/app/js/jquery.Spinner.js"></script>
    <link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx }/app/css/font-awesome.min.css" rel="stylesheet">
    <link href="${ctx }/app/css/font-awesome-ie7.min.css" rel="stylesheet">
    <link href="${ctx }/app/css/style_0.css" rel="stylesheet"> 
    
    <script type="text/javascript">
        $(function () {
            $(".yListr ul li em").click(function () {
                $(this).addClass("yListrclickem ").siblings().removeClass("yListrclickem");
            })
        })


        $(function () {
            $("#a").Spinner({value: 1, min: 1, len: 3, max: 99});
            $("#b").Spinner({value: 1, min: 1, len: 3, max: 99});
        });


        /*或者不用jquery*/
        /*商品数量框输入*/
        function keyup() {
            var quantity = document.getElementById("quantity").value;
            if (isNaN(quantity) || parseInt(quantity) != quantity || parseInt(quantity) < 1) {
                quantity = 1;
                return;
            } 
            if (quantity>99) {
                document.getElementById("quantity").value = quantity.substring(0, quantity.length - 1);
                alert("商品数量不能大于99");
            }
        }

        var zj=0;
        
        /*商品数量+1*/
        function numAdd(id) {
            var quantity =$('#'+id+'_lb').find('input').val();
            var num_add = parseInt(quantity) + 1;
            var price =Number($('#'+id+'_lb').find('.price').html());
            if (quantity == "") {
                num_add = 1;
            }
            if (num_add >99) {
                $('#'+id+'_lb').find('input').val(num_add - 1);
                alert("商品数量不能大于99");
            } else {
               $('#'+id+'_lb').find('input').val(num_add);
                var Num = price * num_add;
                if($('#'+id+'_lb').find('.fa-check').css("display")!="none"){ 
                zj+=price; 
                }
                document.getElementById("totalPrice").innerHTML =zj.toFixed(2);
            }
        }
        /*商品数量-1*/
        function numDec(id) {
            var quantity =$('#'+id+'_lb').find('input').val();
            var price =Number($('#'+id+'_lb').find('.price').html());
            var num_dec = parseInt(quantity) - 1;
            if (num_dec >= 0) {
                $('#'+id+'_lb').find('input').val(num_dec);
                var Num = price * num_dec;
                if($('#'+id+'_lb').find('.fa-check').css("display")!="none"){ 
                zj-=price; 
                } 
                document.getElementById("totalPrice").innerHTML =zj.toFixed(2);
            }
        }
        function show() {
            document.getElementById("totalPrice").innerHTML = 100 * 3;
        }
        function jfdh(){ 
         var oldjf=$('#jf').html();  
         var jf=$('#jfdh').val(); 
         if(jf!=""){
           var jz=zj;
           if(jf/100<=jz){
           jz=jz-jf/100;
           $('#totalPrice').html(jz.toFixed(2)); 
            }else{
            alert("超出兑换额度！");
           }
         }else{
         }
        
        }
        function pay(){ 
           var  id='';
           var  count='';
           $(".fa-check").each(function(index,data){ 
             if($(this).css("display")!="none"){
               id=id+","+$(this).attr("id");
               count=count+","+$("#"+$(this).attr("id")+"lb").find("input").val();
             }
           }); 
           var submitData = {
                   pid:id,
                   count:count,
                   money:$('#totalPrice').html(),
                   jfdh:$('#jfdh').val()
                   
	            };  
        jQuery.post('${ctx}/shop/shop!shoppay.action?toUser=${toUser}', submitData,
        	  function(json){
        	  if(json.state==0){  
        	   alert("支付成功！");
        	  window.location.href='${ctx}/shop/shop!orderfrom.action?toUser=${toUser}';
        	  }else{
        	   alert("支付失败！");
        	  }
        	 },"json");
        
        
        
        }
        
        function check(v,id){
        if($(v).find('i').css('display')=="none"){
         $(v).find('i').show();
          var quantity =$('#'+id+'_lb').find('input').val();
          var price =Number($('#'+id+'_lb').find('.price').html());
          zj+=quantity*price;
         document.getElementById("totalPrice").innerHTML =zj.toFixed(2);
        }else{
         $(v).find('i').hide();
         var quantity =$('#'+id+'_lb').find('input').val();
         var price =Number($('#'+id+'_lb').find('.price').html());
         zj-=quantity*price;
         document.getElementById("totalPrice").innerHTML =zj.toFixed(2);
        }
         
        }
        
    </script>
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
      sel:$('#sel').val()
    }; 
   
    issend=false; 
    $.post('${ctx}/shop/shop!ajaxshopcarweb.action?toUser=${toUser}&fypage='+fypage, submitData,
       	function(json) { 
    		var xszf=$('#ajaxdiv').html(); 
	    	if(json.state=='0'){
	    		var v = json.list; 
	    		
	    		 for(var i=0;i<v.length;i++){ 
	    		  xszf+='<div id="'+v[i]._id+'_lb" class="line-bottom div-group-10 overflow-hidden position-r" style="height:90px;">'
	    		  +'<div class=" position-a"><div class="img-bj bk border-radius3" style="background-image: url(${filehttp}/'+v[i].product.logo+');"></div>'
	    		  +'<div class="position-a width-10 pt-20" style="top:3px; left: 0px;"><div class="img-wh25 bg-bai maring-a txt-c border-radius50" onclick="check(this,'+v[i]._id+')" style="border: solid #45c01a 3px;">'
	    		  +'<i class="fa fa-check zi-green display-none" id="'+v[i]._id+'"  style="line-height:19px;"></i>'
	    		  +'</div></div></div><div style="padding-left:100px;"><div class="zi-6 weight500">'
	    		  +'<font size="2"> <div class="col-10 sl zi-hei">'+v[i].product.ptitle+'</div><a href="#">'
	    		  +'<div class="pull-right col-1 txt-c"><i class="fa fa-trash-o zi-hong"></i>'
	    		  +'</div></a></font></div><div class="width-6 pull-left weight500">'
	    		  +'<font size="2"><div class="clear sl hang30" style="line-height:35px;">'
	    		  +'<span class="zi-hui hd">原价:'+v[i].product.oldprice.toFixed(2)+'元</span></div>'
	    		  +'<div class="sl hang30" style="line-height:30px;"><span class="zi-cheng "><span class="price">'
	    		  +v[i].product.price.toFixed(2)+'</span>元<i class="pl-5 zi-6">邮费:0元</i></span></div></font></div><div class="width-4 pull-left">'
	    		  +'<font size="2"><div class="border-radius3 pull-right overflow-hidden clear mt-25">'
	    		  +'<a href="#"><div class="pull-left txt-c btn-hui zi-hui img-wh30" onclick="numDec('+v[i]._id+')">'
	    		  +'<i class="fa fa-minus fa-1x line-height33"></i></div></a>'
	    		  +'<div class="pull-left overflow-hidden img-wh30">'
	    		  +'<input class="size12 txt-c zi-hui gray_input  weight500 width-10 button-kong"'
	    		  +'id="quantity" name=""  type="text" value="1" readonly="readonly"/>'
	    		  +'</div><a href="#"><div class="pull-left txt-c btn-hui zi-hui img-wh30" onclick="numAdd('+v[i]._id+')">'
	    		  +'<i class="fa fa-plus fa-1x line-height33"></i></div></a></div></font></div></div></div>';  	
	    		   	
				}
	    		fypage++;
				 
	    		
	    	}else{
	    		
	    	}
	    	
	    	issend=true;
			$('#ajaxdiv').html(xszf);
			 
	},"json")
	
}
    
    </script>
    <style>
        .line-height33 {
            line-height: 33px;
        }
    </style>
</head>
<body>
 
<main class="clear cmp640 lock">

    <a href="#">
        <font size="2">
            <div class="div-group-10 overflow-hidden zi-6 weight100 col-11">
                <div class="">
                    <div class="pull-left">收货人:<i>刘刚</i></div>
                    <div class="pull-right">15989564587</div>
                </div>
                <div class="clear pt-5">
                    <div class="pull-left sl width-10">收货地址:<i>陕西省西安市未央区凤城二路与未央路十字向东五百米海景国际2棟7楼101室</i></div>
                </div>
            </div>
            <div class="col-1 div-group-5 txt-c zi-hui hang40 overflow-hidden">
                <i class="fa fa-chevron-right fa-1dx" style="line-height:50px;"></i>
            </div>
            <div class="hang10 bg-hui clear"></div>
        </font>
    </a>

    <div id="ajaxdiv"></div>
     
    <div class="hang100 clear"style="height: 150px;"></div>


    <input type="hidden" value="<fmt:formatNumber value='${entity.price}'  pattern="0.0#"/>" id="price"/><!--单价-->
    <input type="hidden" value="${jf}" id="jf"/>

</main>

<div class=" button_foot shadow-wai overflow-hidden bg-bai cmp640">

    <div class="hang40 weight500 zi-hui-tq line-height40 pl-5 pr-5">
        <font size="1">
            <div class="pull-left">
                    现有积分:<i class="zi-hong">${jf}</i><i class="pl-5">请输入要兑换的积分:</i>
            </div>

            <div class="col-3 pt-5 pl-5  overflow-hidden">
                <div class="line-lu border-radius3 div-group-5">
                    <input id="jfdh" class="width-10 txt-c pt-2 size14 zi-hui weight500"
                           type="text"
                           value="0" onfocus="this.style.color='black';"
                           onblur="this.style.color='#aaa';" onkeyup="jfdh()">
                </div>
            </div>
        </font>
    </div>

    <div class="div-group-5 hang50 overflow-hidden line-top">
        <div class="col-8 zi-hong weight500 pl-15" style="line-height:42px;">
            <font size="2">
                总计:<i id="totalPrice" class="fa fa-cny pl-5 weight500">0</i>元
            </font>
        </div>
        <div class="col-4 zi-bai size14 weight500 txt-c pull-right">
            <a href="javascript:pay()">
                <div class=" hang40 ">
                    <div class="hang40 line-height40  btn-lu border-radius3">确认付款</div>
                </div>
            </a>
        </div>
    </div>
</div>

</body>
<script>
ajaxjz();
$(function(){
 if($('#jf').val()<=0){
   $('#jfdh').attr('readonly','readonly');
 }


});
 
</script>
</html>