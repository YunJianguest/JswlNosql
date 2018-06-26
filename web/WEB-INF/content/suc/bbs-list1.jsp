<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ include file="/webcom/limit.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<c:if test="${not empty list}">
<c:forEach items="${list}" var="bean">
<div class="hang10 bg-hui-qj"></div>
    <!--一个信息-->
    <div class="position-r">

        <div class=" overflow-hidden" style="padding-left: 50px;">
            <div class="weight500 pl-5 pt-5 sl pull-left">
                <font size="2">
                 ${bean.nikename}
                </font>
            </div>
            <div class="fa fa-angle-right zi-hui pt-5 pl-5 pull-left"></div>
            <div class="size12 pl-5 sl width-3 pt-5 pull-left zi-hui"></div>
            <div class="zi-6 pl-5 clear">
                <div class="pt-5 pull-left weight500">
                    <font size="1">
                        <i>${bean.createdate}</i><i class="pl-10 zi-lan-tq">${bean.humor}</i>
                    </font>
                </div>
                <!--<div class="pull-right pr-5 pt-3"><i class="fa fa-thumbs-up pr-5"></i>12</div>-->
            </div>
        </div>
        <div class="position-a img-wh50" style="top:0px; left:0px;">
             <c:choose>
                  <c:when test="${fn:contains(bean.headimgurl, 'http')}">
                  <div class="img-wh40 img-bj border-radius50 maring-a" style="background-image: url(${bean.headimgurl})"></div>
                  
                  </c:when>
 
                   <c:otherwise>  
                    <div class="img-wh40 img-bj border-radius50 maring-a" style="background-image: url(${contextPath}/${bean.headimgurl})"></div>
              
                   </c:otherwise>

                </c:choose>
           
        </div>
    </div>
    <a href="${ctx}/suc/bbs!bbsDetails.action?bmtid=${bean._id}" onclick="reading('${bean._id}',this)">
    <div class="clear pl-5 pr-5 pt-15">
        <div class="size12 weight500 zi-hei-tq width-10 qjhh" style="line-height: 20px;">
            <font size="2" class="qqfaces">${bean.content}</font>
        </div>
    </div>
    </a>
    <!--图片
    <c:if test="${not empty bean.picurls}">
     <div class="pb-5 pt-5">
        <div id="thumbs" class="overflow-hidden ">
          <c:forEach items="${bean.picurls}" var="beans">  
                   <c:if test="${not empty beans}"> 
                     <i class="col-6 pt-2">
                     <a href="${filehttp}/${beans}" class="pull-left" style="background-image:url(${filehttp}/${beans})"></a>
                     </i> 
                  </c:if>
         
           </c:forEach>
          
        </div>
    </div>
    填写处-->
    
     <!--图片填写处-->
     <c:if test="${not empty bean.picurls}">
      <div class="pt-10 overflow-hidden"> 
        <div class="my-gallery">
            
             <c:forEach items="${bean.picurls}" var="beans"> 
              <c:if test="${not empty beans}">
               <figure> 
                 <a href="${filehttp}/${beans}" tppabs="${filehttp}/${beans}" data-size="800x1142">
                    <div class="width-10 hang150 img-bj"style="background-image:url(${filehttp}/${beans})">
                    <img tppabs="${filehttp}/${beans}"/>
                    </div>
                 </a> 
            </figure>
            </c:if>
           </c:forEach>
         
        </div>
     </div>
    </c:if>
    <!--图片放置处结束-->
    
 </c:if>
   


        <!--浏览点赞-->
        <div class="pl-5 pr-5 clear clear weight500">
            <div class="pt-10 pb-10 overflow-hidden">
                <font size="3">
                    <a href="#">
                    <c:if test="${empty bean.reading}">
                    <div class="pull-left pt-3 zi-6 weight500"><font size="2">浏览0次</font>
                     </div>
                    </c:if>
                    <c:if test="${not empty bean.reading}">
                     <div class="pull-left pt-3 zi-6 weight500"><font size="2">浏览${bean.reading}次</font>
                     </div>
                    </c:if>
                       
                    </a>
                    <a href="javascrpit:void(0)" onclick="lt_hf('${bean._id}')">
                        <div class="pull-right bg-bai ml-25 zi-hui-tq ml-15">
                            <div class="img-wh18">
                                <img src="${ctx}/mvccol/img/huifu.png" width="100%">
                            </div>
                        </div>
                    </a>
                    <a href="javascrpit:void(0)" onclick="praise('${bean._id}',this)">
                        <div class="pull-right bg-bai zi-hui-tq ml-15">
                            <div class="img-wh18">
                                <img src="${ctx}/mvccol/img/zan.png" width="100%">
                            </div>
                        </div>
                    </a>
                </font>
            </div>

            <div class="pt-10 line-top-92 clear">
                <a href="#">
                <c:if test="${empty bean.praise}">
                 <div class=" zi-lan-tq weight100">
                        <font size="2"><i class="fa fa-thumbs-up pr-5"></i>0人觉得很赞</font>
                 </div>
                
                </c:if>
                <c:if test="${not empty bean.praise}">
                 <div class=" zi-lan-tq weight100">
                        <font size="2"><i class="fa fa-thumbs-up pr-5"></i>${bean.praise}人觉得很赞</font>
                 </div>
                
                </c:if>
                   
                </a>
            </div>
        </div>
    
        <c:forEach items="${bean.commentlist}" var="pl">
         <c:if test="${not empty pl.content}">
         <div class="pl-5 pr-5">
            <div class="pt-5">
                <a href="javascript:lt_hfchild('${pl._id}','${bean._id}')">
               
                    <div class="zi-hei-tq weight500 pt-5">
                    
                     <font size="2"><i class="zi-lan-tq pr-5">${pl.name}:</i>${pl.content}</font>
                       
                    </div>
                  
                </a>
                <c:forEach items="${pl.commentchildlist}" var="pls">
                 <c:if test="${not empty pls.content}">
                 <a href="javascript:lt_hfchilds('${pls._id}','${pl.id}','${bean._id}')"> 
                   
                    <div class="zi-hei-tq weight500 pt-5">
                    <font size="2"><i class="zi-lan-tq pr-5">${pls.name}:</i>回复<i
                                class="zi-lan-tq pr-5">${pl.name}:</i>${pls.content}</font>
                   
                    </div>
                  
                </a>
                  </c:if> 
                </c:forEach>
               
            </div>

        </div>
        </c:if>
         </c:forEach>
         <div class="clear mt-20 mb-15 overflow-hidden line-lu border-radius3 overflow-hidden">
                <font size="2">
                    <a href="javascript:lt_hf('${bean._id}')">
                        <input class="col-10 pl-5 pr-5 zi-hui-tq weight500" style="line-height:35px;height:35px;"
                               type="text"
                               name=""
                               value="评论" onfocus="if(this.value=='评论'){this.value=''};this.style.color='black';"
                               onblur="if(this.value==''||this.value=='评论'){this.value='评论';this.style.color='#aaa';}">
                <span class="col-2 txt-c weight500 zi-6">
                <i style="line-height:35px;" class="">发送</i>
                    </span>
                    </a>
                </font>
        </div>
   </c:forEach>
    
</c:if>
<script>
 $('.qqfaces').each(function(){ 
        $(this).html(replace_em($(this).html()));
       }); 
 
   initPhotoSwipeFromDOM('.my-gallery');   
</script>
