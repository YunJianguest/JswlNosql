<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script type="text/javascript" src="${ctx }/app/js/bbsSwipe.js"></script>
   <c:if test="${not empty slide}">
        <div id="banner_box" class="box_swipe overflow-hidden position-r" style="width:100%">
            <ul>
                <c:forEach items="${slide}" var="bean">
                    <li style="display: block;">
                        <a href="${bean.url}">
                            <img src="${filehttp}/${bean.picurl}" alt="1" style="width:100%;"/>
                        </a>
                    </li>
                </c:forEach>
            </ul>
  
        </div>

        <script>
            $(function () {
                new Swipe(document.getElementById('banner_box'), {
                    speed: 500,
                    auto: 3000,
                    callback: function () {
                        var lis = $(this.element).next("ol").children();
                        lis.removeClass("on").eq(this.index).addClass("on");
                    }
                });
            });
        </script>
    </c:if>

    <div class="overflow-hidden pb-25 bj-lan position-r">
        <div class="position-a " style="bottom: 0px; left: 0px;">
             <img src="${ctx}/mvccol/img/ns-kuang.png" width="100%">
        </div>

        <div class="pt-25 pb-25 ">
               <div class="width-5 weight500 zi-bai maring-a border-radius5  btn-hong2 div-group-10 txt-c" onclick="window.location.href='${ctx}/suc/votelm!moveadd.action?custid=${custid}&agid=${agid}&lscode=${lscode}&_id=${entity._id}'">
                    <font size="3">我也报名</font>
                </div> 

            <div class="width-10 maring-a pt-25 zi-huang">
                <div class="col-4 txt-c line-right-huang">
                    <font size="3">
                        <p>已报名</p>

                        <p>${entity.bmcount}</p>
                    </font>
                </div>
                <div class="col-4 txt-c line-right-huang">
                    <font size="3">
                        <p>投票人次</p>

                        <p>${entity.tpcount}</p>
                    </font>
                </div>
                <div class="col-4 txt-c">
                    <font size="3">
                        <p>访问量</p>

                        <p>${entity.llcount}</p>
                    </font>
                </div>
            </div>
        </div>
    </div>