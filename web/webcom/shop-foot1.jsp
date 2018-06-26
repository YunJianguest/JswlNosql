<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<div class=" button_foot bg-bai shadow-wai cmp640">

    <div class=" button_group1">
        <a href="${ctx}/shop/shop!index.action?lx=1&custid=${custid}&agid=${agid}&lscode=${lscode}">
            <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5">
                <font size="4">
                    <div class="fa fa-home"></div>
                </font>

                <div class=" pt-3">
                    <font size="1">
                        商城首页
                    </font>
                </div>
            </div>
        </a>
    </div>

    <div class=" button_group1">
        <a href="${ctx}/shop/shop!shoppingcar.action?custid=${custid}&agid=${agid}&lscode=${lscode}">
            <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5">
                <font size="4">
                    <div class="fa fa-shopping-bag"></div>
                </font>
                <div class=" pt-3">
                    <font size="1">
                       购物车
                    </font>
                </div>
            </div>
        </a>
    </div>

    <div class=" button_group1">
        <a href="${ctx}/shop/shop!orderform.action?custid=${custid}&agid=${agid}&lscode=${lscode}">
            <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5">
                <font size="4">
                    <div class="fa fa-file"></div>
                </font>
                <div class=" pt-3">
                    <font size="1">
                        订单查看
                    </font>
                </div>
            </div>
        </a>
    </div>
   
    <div class=" button_group1" onclick="window.location.href='${ctx}/user/fromuser!UserDetail.action?custid=${custid}&agid=${agid}&lscode=${lscode}'"> 
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
        
    </div>
    
</div>