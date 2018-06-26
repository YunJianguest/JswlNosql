<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<div class="position-f cmp640" id="tanchuguanggaof" style="top: 0px;left: 0px;z-index: 1000;">
    <div class="bg-hei-8 position-r div-group-5 overflow-hidden"> 
            <div class="img-wh30 border-radius3 pull-left overflow-hidden">
                <img src="${filehttp}/${com.logo}" class="width-10">
            </div>
            <div class="hang30 pl-10 pull-left" style="line-height: 32px;">
                <font size="2">
                <c:if test="${empty com.summary}">
                <i class="zi-bai">联系我们为您提供更多的服务！</i>
                </c:if>
                <c:if test="${not empty com.summary}">
                <i class="zi-bai">${com.summary}</i>
                </c:if>
                    
                </font>
            </div> 
            <div class="pull-left pl-15 pt-5" onclick="erweima_xianshi()">
                  <div class="zi-bai maring-a pl-10 pr-10 hang20 txt-c btn-green border-radius3 weight500 zi-bai"
                         style="line-height: 22px;">
                        <font size="1">
                            点击查看
                        </font>
                  </div>
            </div>  
            <div class="position-a pt-10 pr-5" style="right:0px;top:0px;" onclick="xiaoshiguanggaof()">
                <div class="img-wh20 border-radius50 bg-bai txt-c">
                    <font size="2">
                        <i class="fa fa-remove zi-green" style="line-height:22px"></i>
                    </font>
                </div>
            </div>
        
    </div> 
</div>
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="erweima_tanchu">
    <div class="overflow-hidden width-10">
        <a href="javascript:erweima_xiaoshi()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>
        <div class=" cmp640 position-f" style="top:30%;left:0px;z-index: 100000;">
            <div class="maring-a position-r"style="width:200px;height:200px;">
                <img src="${filehttp}/${com.ewmurl}" class="width-10 border-radius5">
                <a href="javascript:erweima_xiaoshi()">
                    <div class="position-a" style="right:-7px;top:-7px;">
                        <div class="img-wh20 border-radius50 bg-hui txt-c">
                            <font size="2">
                                <i class="fa fa-remove zi-green" style="line-height:22px"></i>
                            </font>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </div>
</div>
<script>
        function xiaoshiguanggaof() {
            $('#tanchuguanggaof').hide();
        }
        function xianshiguanggaof() {
            $('#tanchuguanggaof').show();
        }
        function erweima_xiaoshi() {
            $('#erweima_tanchu').hide();
        }
        function erweima_xianshi() {
            $('#erweima_tanchu').show();
        }
</script>
