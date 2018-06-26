<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<font size="2">
    <div class=" button_foot bg-bai zi-hui shadow-wai cmp640">
        <div class=" button_group1 zi-6" onclick="window.location.href='${ctx}/suc/memorial!myindex.action?custid=${custid}&agid=${agid}&lscode=${lscode}'"> 
                <div class="bottom-bai zi-hui-wx txt-c weight500 pt-5 pb-5">
                    <div class="hang30 line-height30">
                        我的
                    </div>
                </div> 
        </div>
        <div class=" button_group1 zi-6" onclick="window.location.href='${ctx}/suc/memorial!web.action?custid=${custid}&agid=${agid}&lscode=${lscode}'"> 
                <div class="bottom-bai zi-hui-wx txt-c weight500 pt-5 pb-5">
                    <div class="hang30 line-height30">
                        推荐的馆
                    </div>
                </div> 
        </div>
    </div>
</font>