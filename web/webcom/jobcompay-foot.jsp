<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<div class=" button_foot bg-bai zi-hui shadow-wai cmp640" style="z-index: 1;">
    <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5 button_group1" onclick="window.location.href='${ctxurl}/suc/jobcompay!web.action?custid=${custid}&agid=${agid}&lscode=${lscode}'">
        <font size="4">
            <div class="fa fa-home"></div>
        </font>

        <div class=" pt-3" >
            <font size="1">
                首页
            </font>
        </div>
    </div>
    <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5 button_group1" onclick="window.location.href='${ctxurl}/suc/jobcompay!index.action?custid=${custid}&agid=${agid}&lscode=${lscode}&isadmin=true'">
        <font size="4">
            <div class="fa fa-clone"></div>
        </font>

        <div class=" pt-3">
            <font size="1">
                我的发布
            </font>
        </div>
    </div>
    <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5 button_group1" onclick="fb()">
        <font size="4">
            <div class="fa fa-paint-brush"></div>
        </font>

        <div class="pt-3">
            <font size="1">
                发布信息
            </font>
        </div>
    </div>
    <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-5 button_group1" onclick="window.location.href='${ctx}/user/fromuser!UserDetail.action?custid=${custid}&agid=${agid}&lscode=${lscode}'">
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
<!--黄页分类-->
<div class="fullscreen cmp640 bg-hei-5 display-none lock" id="fb_type">
    <div class="overflow-hidden width-10">
        <a href="javascript:shezhixiaoshi2()">
            <div class="width-10 overflow-hidden" style="height:1000px;"></div>
        </a>

        <div class="overflow-hidden cmp640 position-f weight500 width-10"
             style="bottom:10px;left: 0px;z-index: 10000;">
            <div class=" border-radius5 overflow-hidden maring-a width-9_5">  
                        <a href="${ctx}/suc/jobcompay!seekersadd.action?custid=${custid}&agid=${agid}&lscode=${lscode}">
                            <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                                 求职信息
                            </div>
                        </a> 
                        <a href="${ctx}/suc/jobcompay!webadd.action?custid=${custid}&agid=${agid}&lscode=${lscode}">
                            <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                                 招聘信息
                            </div>
                        </a>
                       <a href="${ctx}/suc/jobcompay!caradd.action?custid=${custid}&agid=${agid}&lscode=${lscode}">
                            <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                                 二手车辆
                            </div>
                        </a>
                        <a href="${ctx}/suc/jobcompay!supplyadd.action?custid=${custid}&agid=${agid}&lscode=${lscode}">
                            <div class="zi-bai line-bottom-c3c3c6 txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                                房屋租赁
                            </div>
                        </a>
            </div>
            <a href="javascript:qxfb()">
                <div class="pt-10">
                    <div class="border-radius5 maring-a width-9_5 zi-bai txt-c hang40 line-height40 bg-bai-8 zi-lan-tq">
                        取消
                    </div>
                </div>
            </a>
        </div>
    </div>
</div> 
<style>
   .bg-bai-8 {
            background-color: rgba(225, 225, 225, 0.9);
        }
         .line-bottom-c3c3c6 {
            border-bottom: 1px solid #c3c3c6;
        }
</style>
<script>
 function fb(){
    $('#fb_type').show();
  }
 function qxfb(){
    $('#fb_type').hide();
  }
</script>