<%@ page contentType="text/html;charset=UTF-8" %>

<!--底部按钮-->
<div class=" button_foot bg-bai zi-hui shadow-wai cmp640" style="z-index: 1;">

    <div class=" button_group1">
        <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5"
             onclick="window.location.href='${ctx}/suc/house!web.action?custid=${custid}&agid=${agid}&lscode=${lscode}'">
            <font size="4">
                <div class="fa fa-home"></div>
            </font>

            <div class=" pt-3">
                <font size="1">
                    黄页首页
                </font>
            </div>
        </div>
    </div>

    <div class=" button_group1">
        <a href="${ctx}/suc/house!personalhome.action?custid=${custid}&agid=${agid}&lscode=${lscode}">
            <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5">
                <font size="4">
                    <div class="fa fa-thumb-tack"></div>
                </font>
                <div class=" pt-3">
                    <font size="1">
                        我的黄页
                    </font>
                </div>
            </div>
        </a>
    </div>
    <div class=" button_group1">
        <a href="${ctx}/suc/house!webadd.action?custid=${custid}&agid=${agid}&lscode=${lscode}">
            <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5">
                <font size="4">
                    <div class="fa fa-cloud-upload"></div>
                </font>
                <div class=" pt-3">
                    <font size="1">
                        上传黄页
                    </font>
                </div>
            </div>
        </a>
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



<!--结束-->
