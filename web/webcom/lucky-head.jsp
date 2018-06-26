<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
   <!--早期导航不能动-->
        <div class=" hang30 pt-3 width-10 weight500 bg-hei-8 position-a cmp640"
             style="bottom:0px; left:0px;">

            <a href="#">
                <div class="col-4 txt-c line-right hang25 overflow-hidden" style="line-height:25px;">
                    <font size="2">
                        <div class="width-9_5 maring-a zi-hui-da clear sl" style="line-height:25px;">
                            摇奖活动
                        </div>
                    </font>
                </div>
            </a>
            <a href="#">
                <div class="col-4 txt-c line-right hang25 overflow-hidden" style="line-height:25px;">
                    <font size="2">
                        <div class="width-9_5 maring-a zi-hui-da clear sl" style="line-height:25px;">
                            投票活动
                        </div>
                    </font>
                </div>
            </a>
            <a href="#">
                <div class="col-4 txt-c hang25 overflow-hidden" style="line-height:25px;">
                    <font size="2">
                        <div class="width-9_5 maring-a zi-hui-da clear sl" style="line-height:25px;">
                            刮刮乐活动
                        </div>
                    </font>
                </div>
            </a>
        </div>
        <!--早期导航不能动结束-->

    </div>

  <c:if test="${not empty user.isadmin}">
     <div class="pl-5 pr-5 pt-10 clear">
        <a href="${ctx}/suc/luckydraw!webadd.action?custid=${custid}&agid=${agid}&lscode=${lscode}">
            <div class="btn-lu txt-c div-group-10 weight500 zi-bai border-radius5">
                <font size="2">
                    活动发起
                </font>
            </div>
        </a>
    </div>
    </c:if>