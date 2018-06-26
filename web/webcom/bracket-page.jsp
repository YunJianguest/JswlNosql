<%@ page contentType="text/html;charset=UTF-8"%>
<div  class="dataTables_info">显示10条  共 ${fycount } 条</div>
                <div class="dataTables_paginate  ">
                    <ul class="pagination pagination-split">
                        <li class="disabled" id="first"><a href="javascript:page_submit(0);">首页</a></li>
                        <c:if test="${fypage!=0}">
                        <li class="btn-success"><a href="javascript:page_submit(${fypage-1 });">上一页</a></li>
                        </c:if>
                        <li ><input class="form-control xiao" type="text"  id="fypage" name="fypage"  value="${fypage+1}" style="  width: 55px;height: 35px;"></li>
                        <li class=" btn-success "><a href="javascript:page_submit(-2);">跳转</a></li>
                        <li><a href="javascript:page_submit(${fypage+1 });">下一页</a></li>
                      
                    </ul>
 </div>
<script>
 if($("#fypage").val()==1){
     $("#first").addClass("disabled");
  }else{
     $("#first").removeClass("disabled");
  }
</script>