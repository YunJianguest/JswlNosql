<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<div class="fullscreen cmp640 bg-hei-5 lock" id="friedtx">
    <div class="overflow-hidden width-10">
        <a href="javascript:friedtx_hide()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a> 
        <div class=" cmp640 position-f position-r" style="top:15%;left:0px;z-index: 99;">

            <div class="position-a hang60 width-10" style="top:-35px;z-index: 100;">
                <div class="img-wh70 border-radius50 maring-a">
                    <img src="${filehttp}/${user.headimgurl}" width="100%" class=" border-radius50">
                </div>
            </div>

            <div class="maring-a position-r border-radius5 div-group-15 pt-45 bg-bai" style="width:280px;">
                <a href="javascript:friedtx_hide()">
                    <div class="position-a" style="right:-7px;top:-7px;z-index: 101;">
                        <div class="img-wh20 border-radius50 bg-hui-tx txt-c">
                            <font size="2">
                                <i class="fa fa-remove zi-green" style="line-height:22px"></i>
                            </font>
                        </div>
                    </div>
                </a>

                <div class=" width-10 border-radius5 zi-hui-tq overflow-hidden">
                    <font size="2">
                        <div class="weight500">您好:</div>
                        <div class="weight500 line-height25">&nbsp&nbsp&nbsp尊敬的：<i class="zi-green">${user.nickname}</i><i class="zi-green">您有${friedcount}个好友申请</i></div>
                    </font>
                </div>

                <div class="width-10 pt-15">
                    <div class="button_group1" onclick="window.location.href='${ctx}/user/friends!web.action?custid=${custid}&agid=${agid}&lscode=${lscode}&state=1'">
                        <div class="width-8 maring-a border-radius3 btn-green zi-bai txt-c hang30 line-height30">
                          立即处理
                        </div>
                    </div>
                    <div class="button_group1" onclick="friedtx_hide()">
                        <div class="width-8 maring-a border-radius3 btn-green zi-bai txt-c hang30 line-height30">
                           稍后查看
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<script>
function  friedtx_hide(){
 $("#friedtx").hide();
}
function  friedtx_show(){
 $("#friedtx").show();
}
 
</script>
