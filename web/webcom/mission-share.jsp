<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script>
        function share_xiaoshi() {
            $('#share_tanchu').hide();  
        }
        function share_xianshi() {
            $('#share_tanchu').show();
        }
</script>
   
    <!--点击发私信后提示框-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="share_tanchu">
    <div class="overflow-hidden width-10">
        <a href="javascript:erweima_xiaoshi()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>
        <div class=" cmp640 position-f position-r" style="top:30%;left:0px;z-index: 99;">
            <div class="maring-a position-r border-radius3 div-group-10 bg-bai" style="width:290px;">
                <a href="javascript:share_xiaoshi()">
                    <div class="position-a" style="right:-10px;top:-10px;z-index: 101;">
                        <div class="img-wh25 border-radius50 bg-hei-5 txt-c">
                            <font size="3">
                                <i class="fa fa-remove zi-bai" style="line-height:27px"></i>
                            </font>
                        </div>
                    </div>
                </a>
                <div class=" width-10 border-radius5 zi-hui-tq overflow-hidden">
                    <font size="2">
                        <div class="weight500">您好:</div>
                        <div class="weight500" style="line-height: 22px;">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp尊敬的：<i
                                class="zi-26bd93">${user.nickname}</i>，只要您分享平台任何页面给您朋友，并且您的朋友成功在平台提现一次您就可获得10元的推荐奖励金，推荐奖励金会存入您的可提现金额里您可以随时进行提现。
                        </div>
                    </font>
                </div>
 

            </div>

        </div>
    </div>
</div>