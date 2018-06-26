<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<div class="position-f cmp640" id="dl_tc" style="bottom:40px;left: 0px;z-index: 1000;">
    <div class="bg-hei-8 position-r div-group-5 overflow-hidden"> 
            <div class="img-wh30 border-radius3 pull-left overflow-hidden">
                <img src="${filehttp}/${com.logo}" class="width-10">
            </div>
            <div class="hang30 pl-10 pull-left" style="line-height: 32px;">
                <font size="2">
                <c:if test="${empty com.summary}">
                <i class="zi-bai">成为代理享受超多返利！</i>
                </c:if>
                <c:if test="${not empty com.summary}">
                <i class="zi-bai">成为代理享受超多返利！</i>
                </c:if>
                    
                </font>
            </div> 
            <div class="pull-left pl-15 pt-5" onclick="window.location.href='${ctx}/shop/shop!agent.action?custid=${custid}&lscode=${lscode}&id=${entity._id}&agid=${agid}'">
                  <div class="zi-bai maring-a pl-10 pr-10 hang20 txt-c btn-green border-radius3 weight500 zi-bai"
                         style="line-height: 22px;">
                        <font size="1">
                            点击查看
                        </font>
                  </div>
            </div>  
            <div class="position-a pt-10 pr-5" style="right:0px;top:0px;" onclick="hide_dl()">
                <div class="img-wh20 border-radius50 bg-bai txt-c">
                    <font size="2">
                        <i class="fa fa-remove zi-green" style="line-height:22px"></i>
                    </font>
                </div>
            </div>
        
    </div> 
</div>
 
<script>
        function hide_dl() {
            $('#dl_tc').hide();
        }
        function show_dl() {
            $('#dl_tc').show();
        }
       
</script>
