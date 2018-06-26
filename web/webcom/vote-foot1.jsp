<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!--底部三个按钮-->
<div class=" button_foot bg-bai zi-hui shadow-wai cmp640" style="z-index: 1;">

    <div class=" button_group1"> 
            <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5" onclick="window.location.href='${ctx}/suc/votelm!index.action?custid=${custid}&agid=${agid}&lscode=${lscode}&_id=${entity._id}'">
                <font size="4">
                    <div class="fa fa-home"></div>
                </font>

                <div class=" pt-3">
                    <font size="1">
                        助力首页
                    </font>
                </div>
            </div> 
    </div>
    <div class=" button_group1"> 
            <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5" onclick="window.location.href='${ctx}/suc/bbs!index.action?custid=${custid}&agid=${agid}&lscode=${lscode}&toUserid=${lscode}'">
                <font size="4">
                    <div class="fa fa-comments"></div>
                </font>

                <div class=" pt-3">
                    <font size="1">
                        本地论坛
                    </font>
                </div>
            </div> 
    </div>
    <div class=" button_group1"> 
            <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5" onclick="window.location.href='${ctx}/suc/votelm!personalhome.action?custid=${custid}&agid=${agid}&lscode=${lscode}&toUserid=${lscode}&_id=${entity._id}'">
                <font size="4">
                    <div class="fa fa-trophy"></div>
                </font>

                <div class=" pt-3">
                    <font size="1">
                        参与的助力
                    </font>
                </div>
            </div> 
    </div>

    <div class=" button_group1"> 
            <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5" onclick="window.location.href='${ctx}/user/fromuser!UserDetail.action?lscode=${lscode}&custid=${custid}&agid=${agid}'">
                <font size="4">
                    <div class="fa fa-user"></div>
                </font>

                <div class=" pt-3">
                    <font size="1">
                        个人中心
                    </font>
                </div>
            </div> 
    </div>

</div>