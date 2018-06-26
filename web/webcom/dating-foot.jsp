<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style>
    .bg-f74c31{
        background-color: #f74c31;
    }
    .zi-dating{
     color: #fa82a5;
    }
</style>
<!--底部按钮-->
<font size="2">
    <div class=" button_foot bg-bai shadow-wai cmp640"> 
        <div class=" button_group1 zi-6" onclick="window.location.href='${ctx}/suc/dating!web.action?custid=${custid}&agid=${agid}&lscode=${lscode}&datingid=${datingid}'">
            <div class="zi-hui-wx txt-c weight500 line-right_bai hang50" id="o1">
                <font size="3">
                    <div class="hang25 line-height30 fa fa-heartbeat"></div>
                </font>
                <font size="2">
                    <div class="hang25 line-height25">
                        缘分
                    </div>
                </font>
            </div>
        </div>
        <div class=" button_group1 zi-6" onclick="window.location.href='${ctx}/suc/dating!message.action?custid=${custid}&agid=${agid}&lscode=${lscode}&datingid=${datingid}'">
            <div class="bottom-bai-hq zi-hui-wx txt-c weight500 line-right_bai hang50" id="o2">
                <font size="3">
                    <div class="hang25 line-height30 fa fa-envelope-open-o position-r" id="uncount">
                     
                      
                    </div>
                </font>
                <font size="2">
                    <div class="hang25 line-height25">
                        消息
                    </div>
                </font>
            </div>
        </div>
        <div class=" button_group1 zi-6" onclick="window.location.href='${ctx}/suc/dating!near.action?custid=${custid}&agid=${agid}&lscode=${lscode}&datingid=${datingid}'">
            <div class="bottom-bai-hq zi-hui-wx txt-c weight500 line-right_bai hang50" id="o3">
                <font size="3">
                    <div class="hang25 line-height30 fa fa-map-marker"></div>
                </font>
                <font size="2">
                    <div class="hang25 line-height25">
                        附近
                    </div>
                </font>
            </div>
        </div>
        <div class=" button_group1 zi-6" onclick="window.location.href='${ctx}/suc/dating!personalcenter.action?custid=${custid}&agid=${agid}&lscode=${lscode}&datingid=${datingid}'">
            <div class="bottom-bai-hq zi-hui-wx txt-c weight500 line-right_bai hang50" id="o4">
                <font size="3">
                    <div class="hang25 line-height30 fa fa-user"></div>
                </font>
                <font size="2">
                    <div class="hang25 line-height25">
                        我的
                    </div>
                </font>
            </div>
        </div>
    </div>
</font>
<script>
var type='${datingtype}';
 $('#o'+type).addClass('zi-dating');
 function findUnfind(){
            var submitData = { 
            };
            $.post('${ctx}/suc/dating!getUnfinds.action?custid=${custid}&lscode=${lscode}', submitData,
                    function (json) { 
                    if(json.value>0){
                    var html="";
                    html+='<div class="position-a bg-f74c31 zi-bai border-radius50 img-wh15 sl" style="top:-3px; right: -10px;line-height: 15px;">'
                        +'<font size="2">'+json.value+'</font>'
                        +'</div>';
                     $("#uncount").html(html);    
                    }
                     
               }, "json");
   }
 findUnfind();
</script>
