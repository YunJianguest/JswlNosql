<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!--底部按钮-->
<font size="2">
    <div class=" button_foot bg-bai zi-hui shadow-wai cmp640">
        <div class=" button_group1 zi-6"> 
                <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-3" onclick="window.location.href='${ctx}/suc/farm!index.action?lscode=${lscode}&custid=${custid}&agid=${agid}'">
                    <font size="3">
                        <div class=" fa fa-home"></div>
                    </font>
                    <div class="pt-4">
                        首页
                    </div>
                </div>
        </div>
        <div class="button_group1 zi-6" onclick="rank_show()">
            <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-3">
                <font size="3">
                    <div class=" fa fa-trophy"></div>
                </font>
                <div class="pt-4">
                    排行榜
                </div>
            </div>
        </div>
        <div class=" button_group1 zi-6"  onclick="window.location.href='${ctx}/suc/farm!cardweb.action?lscode=${lscode}&custid=${custid}&agid=${agid}'">
            <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-3">
                <font size="3">
                    <div class=" fa fa-shopping-basket"></div>
                </font>
                <div class="pt-4">
                 成熟果实
                </div>
            </div>
        </div> 
        <div class=" button_group1 zi-6"  onclick="window.location.href='${ctx}/suc/farm!myindex.action?lscode=${lscode}&custid=${custid}&agid=${agid}'">
            <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-3">
                <font size="3">
                    <div class=" fa fa-rocket"></div>
                </font>
                <div class="pt-4">
                    我的动态
                </div>
            </div>
        </div> 
        <div class=" button_group1 zi-6"> 
                <div class="bottom-bai zi-hui-wx txt-c weight500 line-right_bai pt-5 pb-3" onclick="window.location.href='${ctx}/user/fromuser!UserDetail.action?lscode=${lscode}&custid=${custid}&agid=${agid}'">
                    <font size="3">
                        <div class="fa fa-user"></div>
                    </font>
                    <div class="pt-4">
                        个人中心
                    </div>
                </div>
             
        </div>
    </div>
</font>
<style>
 .yListr3 .zhiding .div3 {
            color: orange;
        }

</style>
<script>
        $(function () {
            $(".yListr3 li").click(function () {
                $(this).addClass("zhiding").siblings().removeClass("zhiding");
                if($(this).attr("id")==1){
                 ajaxrank(1);
                }else if($(this).attr("id")==2){
                 ajaxrank(2);
                }
            })
        })
</script>

<!--排行榜弹出-->
<div class="fullscreen cmp640 lock display-none pb-10 bg-hei-5" id="rank_tanchu">
    <div class="width-9 pl-10 pr-10 border-radius5 maring-a position-r"
         style="height:450px; margin-top: 10%;background-color:#ef9437;">
        <div class="img-wh25 bg-hei-8 txt-c border-radius50 pull-right position-a" style="right:-10px;top:-10px;"
             onclick="rank_hide()"><i class="fa fa-close line-height25 zi-bai"></i></div>

        <div class="size10 zi-bai weight500 maring-a pt-5 pb-10" style="width: 200px;">
            <img src="${ctx}/img/farm/mcph.png" class="width-10">
        </div>
       <div class="border-radius5 overflow-hidden">
         <font size="2">
                <c:if test="${not empty entity.obj._id}">
                  <div class="hang40 bg-bai pt-5 line-bottom clear yListr3">

                    <li class=" button_group1 hang30 line-right zhiding" id="1">
                        <div class="div3 zi-hui-wx txt-c weight500">
                            <i>魅力值总榜</i>
                        </div>
                    </li>
                    <li class=" button_group1 hang30" id="2">
                        <div class=" div3 zi-hui-wx txt-c weight500">
                            <i>该作物成长值榜</i>
                        </div>
                    </li>

                   </div>
                </c:if>
                <c:if test="${empty entity.obj._id}">
                <div class="hang40 bg-bai pt-5 line-bottom clear yListr3">
                 <li class=" button_group1 hang30 line-right zhiding" id="1">
                        <div class="div3 zi-hui-wx txt-c weight500">
                            <i>魅力值总榜</i>
                        </div>
                 </li>
                 </div>
                </c:if>
                
          </font>  
        <div class="pl-10 pr-10 overflow-auto pb-5" style="height:310px;background-color:#fbf4d8;" id="rankdiv">
              
        </div>
       </div>
       
        <div class="hang30 line-height30 txt-c zi-bai size12">
            <i class="pr-5">----------------</i>仅显示前五十名<i class="pl-5">----------------</i>
        </div>
    </div>
</div>
<script type="text/javascript">
  function rank_show(){
    ajaxrank(1);   
    $('#rank_tanchu').show();
    
  }
  function rank_hide(){
   $('#rank_tanchu').hide();
  } 
  function ajaxrank(fag){
     var type='';
     if(fag==1){
      type='farm';
     }else if(fag==2){
      type='farm-${entity.obj._id}';
     }
     var submitData = { 
         type:type
       };  
        $.post('${ctx}/suc/farm!ajaxrank.action?custid=${custid}&agid=${agid}&lscode=${lscode}', submitData,
                    function (json) {
                        var xszf = ''; 
                        if (json.state == '0') {
                            var v = json.list;
                            for (var i = 0; i < v.length; i++) {
                                 
                                xszf += '<div class="pb-10 pt-5 line-bottom overflow-hidden">'
                                     +'<div class="pt-5 col-4">'
                                     +'<div class="width-10 weight500 txt-c hang40 line-height40 zi-zong">'
                                     +'<font size="2">NO.'+v[i].rank+'</font>'
                                     +'</div></div>'
                                     +'<div class="col-8 position-r pt-5">'
                                     +'<div class="overflow-hidden zi-hei hang40" style="padding-left:50px;">'
                                     +'<font size="2">'
                                     +'<div class="weight500 pr-5 hang20 zi-zong line-height20">'+v[i].rankname+'</div>'
                                     +'<div class="hang20 zi-zong line-height20 clear">';
                                     if(fag==1){
                                     xszf+='<i>魅力值：<i class="zi-green">'+v[i].value+'</i></i>';
                                     }else if(fag==2){
                                     xszf+='<i>成长值：<i class="zi-green">'+v[i].value+'</i></i>';
                                     }
                                     
                                     xszf+='</div></font></div>'
                                     +'<div class="position-a img-wh40" style="top:5px;">'
                                     +'<div class="img-wh40 img-bj maring-a border-radius50" style="background-image: url(${filehttp}/'+v[i].picurl+')"></div>'
                                     +'</div></div></div>';
             
                            } 
                        } else {
                        } 
                        $('#rankdiv').html(xszf); 
                    }, "json");
  }
</script>
<!--结束-->
