<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<div class="fullscreen cmp640 bg-hei-5 lock display-none" id="jfbz">
    <div class="overflow-hidden width-10">
        <a href="javascript:jfbz_hide()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a> 
        <div class=" cmp640 position-f position-r" style="top:15%;left:0px;z-index: 99;">

            <div class="position-a hang60 width-10" style="top:-35px;z-index: 100;">
                <div class="img-wh70 border-radius50 maring-a">
                    <img src="${filehttp}/${user.headimgurl}" width="100%" class=" border-radius50">
                </div>
            </div>

            <div class="maring-a position-r border-radius5 div-group-15 pt-45 bg-bai" style="width:280px;">
                <a href="javascript:jfbz_hide()">
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
                        <div class="weight500 line-height25">&nbsp&nbsp&nbsp尊敬的：<i class="zi-green">${user.nickname}</i>，由于您的积分不足无法兑换该商品;您可通过完成平台任务等...获得积分，详情请看<i class="zi-green">积分攻略</i></div>
                    </font>
                </div>

                <div class="width-10 pt-15">
                    <div class="button_group1" onclick="window.location.href='${ctx}/suc/task!web.action?custid=${custid}&agid=${agid}&lscode=${lscode}'">
                        <div class="width-8 maring-a border-radius3 btn-green zi-bai txt-c hang30 line-height30">
                            完成任务
                        </div>
                    </div>
                    <div class="button_group1" onclick="window.location.href='${ctx}/suc/integral!blacklist.action?custid=${custid}&agid=${agid}&lscode=${lscode}'">
                        <div class="width-8 maring-a border-radius3 btn-green zi-bai txt-c hang30 line-height30">
                            积分充值
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<script>
function  jfbz_hide(){
 $("#jfbz").hide();
}
function  jfbz_show(){
 $("#jfbz").show();
}
 
</script>
