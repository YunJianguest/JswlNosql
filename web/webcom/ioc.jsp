<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<!--弹出页面色值图标选择-->
<div class="fullscreen bg-hei-8 display-none" style="height: 100%;z-index: 9999999" id="ioc_tanchu">
    <div style="padding-top:5%">
        <div class="div-group-15 maring-a position-r"style="    width: 100%;max-width: 400px;min-width: 320px;margin: 0px auto;right: 0px;">

            <div class=" bg-bai border-radius3">
              <div class="pt-5 pb-5 pr-5 pl-5 overflow-hidden bg-hui-qj">
                    <div class="overflow-hidden border-radius5 bg-hui-qj line-lu">
                        <div class="col-10 bg-bai" style="height: 25px;">
                            <input class=" width-10 txt-c zi-hui" style="background-color: transparent;line-height: 23px;"
                                   type="text"
                                   id="sel"  value="搜索" onfocus="if(value=='搜索'){value=''}"
                                   onblur="if (value ==''){value='搜索'}">
                        </div> 
                        <div class="col-2 txt-c bg-bai" style="height: 25px;" onclick="sel_ioc()">
                                <i class="fa fa-search zi-hui" style="line-height: 23px;"></i>
                        </div> 
                    </div>
                </div>
                
                <div class="row pl-20 pt-10 pb-10 overflow-hidden pt-10 width-10  overflow-auto"style="height: 500px;" id="ajax_ioc">
                    
                     
                </div>
            </div>

            <a href="javascript:ioc_hide()">
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
var vg='';
var obj='';
function ioc_hide(){
 $("#ioc_tanchu").hide();
 $("#"+obj).show();
}
function ioc_show(){
 $("#ioc_tanchu").show();
}
function set_ioc(v,g){
 $("#"+v).val(g);
 ioc_hide();
}

function sel_ioc(){
 init_ioc(vg,obj);
}
function  init_ioc(fg,gf){
   vg=fg;
   obj=gf;
   $("#"+obj).hide();
  var submitData = {
        sel:$("#sel").val().replace("搜索","") 
		};
		$.post('${ctx}/pub/ioc!ajaxweb.action', submitData, function(json) {
			  if (json.state == 0) {
			  var  html='';
			  var  list=json.list;
			   for (var i = 0; i < list.length; i++) {
			     html+='<div class="pb-15 col-sm-3" onclick="set_ioc(\''+fg+'\',\''+list[i].value+'\')">'
			          +'<img src="${filehttp}/'+list[i].value+'"class="border-radius3 width-10 bg-hei-8">'
			          +'<div class="txt-c zi-hei-tq sl size10">'+list[i].title
			          +'</div></div>'; 
			   }
			   $("#ajax_ioc").html(html);
			  
			  }

		}, "json")
		ioc_show();
}
</script>
 