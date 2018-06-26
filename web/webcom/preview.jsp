<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<link href="${ctx}/app/css/YLui.css" rel="stylesheet" type="text/css"/>
<link href="${contextPath}/app/css/font-awesome.min.css" rel="stylesheet"> 
<script>
    function erweima_xiaoshi() {
        $('#erweima_tanchu').hide();
    }
    function erweima_xianshi() {
        $('#erweima_tanchu').show();
    }
</script>
<div class="fullscreen bg-hei-8 display-none" id="erweima_tanchu">
    <div style="padding-top:5%">
        <div class="div-group-15 maring-a bg-bai border-radius3 position-r"
             style="width:280px;height: 550px;">
            <div class="div-group-10">
                <div class="bg-hei-5 maring-a"id="code" style="width: 200px;height: 200px;"></div>
            </div>
            <div class="txt-c weight500 zi-hui-wx size12">扫描二维码手机预览</div>
            <div class="txt-c div-group-10 weight500 zi-hui-wx size12">普通URL</div>
            <div class="pt-15">
                <input class="width-10 size14 zi-bai hang40 border-radius3 pl-5 pr-5 weight100 bg-hei-8" type="text"id="ylurl">
            </div>
            <div class="txt-c div-group-10 weight500 zi-hui-wx size12">加密URL</div>
            <div class="pt-15">
                <input class="width-10 size14 zi-bai hang40 border-radius3 pl-5 pr-5 weight100 bg-hei-8" type="text"id="wxurl">
            </div>
            <div class="txt-c div-group-10 weight500 zi-hui-wx size12">如需链接可直接复制上面的链接</div>
            <a href="javascript:erweima_xiaoshi()">
                <div class="position-a" style="right:-7px;top:-7px;">
                    <div class="img-wh20 border-radius50 bg-hui-tx txt-c"style="line-height:20px">
                        <font size="2">
                            <i class="fa fa-remove zi-green"></i>
                        </font>
                    </div>
                </div>
            </a>
        </div>
    </div>
</div>
<script type="text/javascript" src="${ctx}/app/js/jquery.qrcode.js"></script>
<script type="text/javascript" src="${ctx}/app/js/qrcode.js"></script> 
<script type="text/javascript">
    function qrcode(str) { 
         $('#code').html('');
         $('#code').qrcode({ 
		  width : "200",
          height : "200",
          text	: str, 
	     });	
        $("#ylurl").val(str); 
        getwxurl(str);   
        erweima_xianshi();
    }
    function getwxurl(url){ 
       var submitData = {
         url : url
      };
     $.post('${ctx}/weixin/wxtoken!getwxurl.action', submitData, function(json) {
       if(json.state==0){  
          $("#wxurl").val(json.value);
          return json.value;
       }else{
          alert("获取URL异常");
       }
    
     }, "json"); 
    }
</script>