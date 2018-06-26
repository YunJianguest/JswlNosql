<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<!--弹出页面色值图标选择-->
<div class="fullscreen bg-hei-8 display-none" style="height: 100%;z-index: 9999999" id="color_tanchu">
    <div style="padding-top:5%">
        <div class="div-group-15 maring-a position-r"style="    width: 100%;max-width: 400px;min-width: 320px;margin: 0px auto;right: 0px;">

            <div class=" bg-bai border-radius3 overflow-auto"style="height: 500px;">
                
                <div class="row pl-20 pt-10 pb-10 overflow-hidden pt-10 width-10" id="ajax_color">
                    
                     
                </div>
            </div>

            <a href="javascript:color_hide()">
                <div class="position-a" style="right:13px;top:10px;">
                    <div class="img-wh20 border-radius50 bg-hui-tx txt-c line-height20">
                        <font size="2">
                            <i class="fa fa-remove zi-green line-height20"></i>
                        </font>
                    </div>
                </div>
            </a>


        </div>

    </div>


</div>
<script> 
function color_hide(){
 $("#color_tanchu").hide(); 
}
function color_show(){
 $("#color_tanchu").show();
}
function set_color(v,g){
 $("#"+v).val(g);
 color_hide();
}
function  init_color(fg){
  var submitData = { 
		};
		$.post('${ctx}/pub/color!ajaxweb.action', submitData, function(json) {
			  if (json.state == 0) {
			  var  html='';
			  var  list=json.list;
			   for (var i = 0; i < list.length; i++) {
			     html+='<div class="pb-15 col-sm-3" onclick="set_color(\''+fg+'\',\''+list[i].value+'\')">'
			          +'<img src="${filehttp}/'+list[i].picurl+'"class="border-radius3 width-10 bg-hei-8">'
			          +'<div class="txt-c zi-hei-tq sl size10">'+list[i].value
			          +'</div></div>'; 
			   }
			   $("#ajax_color").html(html);
			  }

		}, "json")
		color_show();
}
</script>
 