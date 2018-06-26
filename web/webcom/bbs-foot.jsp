<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!--底部三个按钮-->
<div class=" button_foot bg-bai zi-hui shadow-wai cmp640" style="z-index: 1;">

    <div class=" button_group1">
        <a href="${ctx}/suc/bbs!index.action?custid=${custid}&agid=${agid}&lscode=${lscode}">
            <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5">
                <font size="4">
                    <div class="fa fa-home"></div>
                </font>

                <div class=" pt-3">
                    <font size="1">
                        论坛首页
                    </font>
                </div>
            </div>
        </a>
    </div>
    <div class=" button_group1">
        <a href="${ctx}/suc/bbs!personalhome.action?custid=${custid}&agid=${agid}&lscode=${lscode}">
            <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5">
                <font size="4">
                    <div class="fa fa-clone"></div>
                </font>

                <div class=" pt-3">
                    <font size="1">
                        我的帖子
                    </font>
                </div>
            </div>
        </a>
    </div>
    <div class=" button_group1">
        <a href="javascript:ft()">
            <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5">
                <font size="4">
                    <div class="fa fa-paint-brush"></div>
                </font>

                <div class=" pt-3">
                    <font size="1">
                        发帖
                    </font>
                </div>
            </div>
        </a>
    </div>
    <div class=" button_group1">
        <a href="${ctx}/user/fromuser!UserDetail.action?lscode=${lscode}&custid=${custid}&agid=${agid}">
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