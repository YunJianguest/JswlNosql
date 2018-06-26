<%@ page contentType="text/html;charset=UTF-8"%>
<div class=" button_foot bg-bai zi-hui shadow-wai cmp640" style="z-index: 1;">
    <div class=" button_group1">
            <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5" 
            onclick="window.location.href='${ctx}/suc/totalactivity!web.action?custid=${custid}&agid=${agid}&lscode=${lscode}'">
                <font size="4">
                    <div class="fa fa-home"></div>
                </font>
                <div class=" pt-3">
                    <font size="1">
                        微活动首页
                    </font>
                </div>
            </div>
    </div>
    <div class=" button_group1">
            <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5"
            onclick="window.location.href='${ctx}/suc/luckydraw!reward.action?custid=${custid}&agid=${agid}&lscode=${lscode}'">
                <font size="4">
                    <div class="fa fa-money"></div>
                </font>
                <div class=" pt-3">
                    <font size="1">
                        我的卡卷
                    </font>
                </div>
            </div>
    </div>
    <div class=" button_group1">
        <a href="${ctx}/user/fromuser!UserDetail.action?custid=${custid}&agid=${agid}&lscode=${lscode}">
            <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5">
                <font size="4">
                    <div class="fa fa-user"></div>
                </font>
                <div class=" pt-3">
                    <font size="1">
                        个人中心
                    </font>
                </div>
            </div>
        </a>
    </div>
</div>

