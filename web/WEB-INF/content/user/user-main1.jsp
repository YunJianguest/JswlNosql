<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/webcom/meta.jsp"%>
<%@include file="/webcom/bracket.jsp"%> 
<script src="${ctx }/bracket/js/flot/jquery.flot.min.js"></script>
<script src="${ctx }/bracket/js/flot/jquery.flot.resize.min.js"></script>
<script src="${ctx }/bracket/js/flot/jquery.flot.symbol.min.js"></script>
<script src="${ctx }/bracket/js/flot/jquery.flot.crosshair.min.js"></script>
<script src="${ctx }/bracket/js/flot/jquery.flot.categories.min.js"></script>
<script src="${ctx }/bracket/js/flot/jquery.flot.pie.min.js"></script>
<script src="${ctx }/bracket/js/morris.min.js"></script>
<script src="${ctx }/bracket/js/raphael-2.1.0.min.js"></script>
<link href="${ctx }/bracket/css/morris.css" rel="stylesheet">

<script type="text/javascript">
function getusercount() {
	var submitData = {
			
	};
	$.post('${ctx}/user/user!getusercount.action', submitData, function(json) {
		$('#usercount').html(json.count);
		$('#userzcount').html(json.zcount);
		$('#userycount').html(json.ycount);
	}, "json")
	

}
function gethousecount() {
	var submitData = {
			
	};
	$.post('${ctx}/user/user!gethousecount.action', submitData, function(json) {
		$('#housecount').html(json.count);
		$('#housezcount').html(json.zcount);
		$('#houseycount').html(json.ycount);
		$('#housereading').html(json.reading);
	}, "json")
	

}
function getshopcount() {
	var submitData = {
			
	};
	$.post('${ctx}/user/user!getshopcount.action', submitData, function(json) {
		$('#shopcount').html(json.count);
		$('#shopzcount').html(json.zcount);
		$('#shopycount').html(json.ycount);
		$('#shopreading').html(json.reading);
	}, "json")
	

}
function getbbscount() {
	var submitData = {
			
	};
	$.post('${ctx}/user/user!getbbscount.action', submitData, function(json) {
		$('#bbscount').html(json.count);
		$('#bbszcount').html(json.zcount);
		$('#bbsycount').html(json.ycount);
		$('#bbsreading').html(json.reading);
	}, "json")
	

}
 
</script>
</head> 
<body class="fixed-sidebar full-height-layout gray-bg" style="overflow:hidden">
  <div id="wrapper">
    <%@include file="/webcom/header-bracket.jsp"%>
       <!--右侧部分开始-->
        <div id="page-wrapper" class="gray-bg dashbard-1">
            <div class="row border-bottom">
             <%@include file="/webcom/header-tab.jsp"%>   
            </div>

            <!--内容添加处-->
            <div class="col-sm-12 " style="height:561px;overflow: auto;"> 
                  <div class="row"> 
                    <div class="col-sm-6 col-md-3">
                       <div class="panel panel-success panel-stat">
                          <div class="panel-heading"> 
                              <div class="stat">
                                <div class="row">
                	
                                    <div class="col-xs-4">
                                       <img src="${ctx }/bracket/images/is-user.png" alt="" />
                                    </div>
                                     <div class="col-xs-8">
                                     <small class="stat-label">用户总数</small>
                                     <span id="usercount"></span>
                                     </div>
                               </div><!-- row -->

                <div class="mb15"></div>

                <div class="row">
                  <div class="col-xs-6">
                    <small class="stat-label">昨日增加</small>
                    <h4 >+<span id="userzcount"></span>人</h4>
                  </div>

                  <div class="col-xs-6">
                    <small class="stat-label">近30日增加</small>
                    <h4 >+<span id="userycount"></span>人</h4>
                  </div>
                </div><!-- row -->
              </div><!-- stat -->

            </div><!-- panel-heading -->
          </div><!-- panel -->
        </div><!-- col-sm-6 -->
        <script type="text/javascript">
		getusercount();
		</script> 
        <div class="col-sm-6 col-md-3">
          <div class="panel panel-primary panel-stat">
            <div class="panel-heading">

              <div class="stat">
                <div class="row">
                  <div class="col-xs-4">
                    <img src="${ctx }/bracket/images/is-city.png" alt="" />
                  </div>
                  <div class="col-xs-4">
                    <small class="stat-label">黄页数</small>
                    <span id="housecount">?</span>
                   
                  </div>
                  <div class="col-xs-4">
                   <small class="stat-label">总流量</small>
                   <span id="housereading">?</span>
                  </div>
                </div><!-- row -->

                <div class="mb15"></div>

                  <div class="row">
                      <div class="col-xs-6">
                          <small class="stat-label">昨日增加</small>
                          <h4>+<span id="housezcount"></span>个</h4>
                      </div>

                      <div class="col-xs-6">
                          <small class="stat-label">近30日增加</small>
                          <h4>+<span id="houseycount"></span>个</h4>
                      </div>
                     
                  </div>

              </div><!-- stat -->

            </div><!-- panel-heading -->
          </div><!-- panel -->
        </div><!-- col-sm-6 -->
        <script type="text/javascript">
		gethousecount();
		</script> 
        <div class="col-sm-6 col-md-3">
          <div class="panel panel-dark panel-stat">
            <div class="panel-heading">

              <div class="stat">
                <div class="row">
                  <div class="col-xs-4">
                    <img src="${ctx }/bracket/images/is-money.png" alt="" />
                  </div>
                  <div class="col-xs-4">
                    <small class="stat-label">订单数</small>
                    <span id="shopcount">?</span>
                  </div>
                  <div class="col-xs-4">
                   <small class="stat-label">总流量</small>
                   <span id="shopreading">?</span>
                  </div>
                </div><!-- row -->

                <div class="mb15"></div>

                <div class="row">
                  <div class="col-xs-6">
                    <small class="stat-label">昨日订单</small>
                    <h4>￥<span id="shopzcount"></span>单</h4>
                  </div>

                  <div class="col-xs-6">
                    <small class="stat-label">近30日订单</small>
                    <h4>￥<span id="shopycount"></span>单</h4>
                  </div>
                   
                </div><!-- row -->

              </div><!-- stat -->

            </div><!-- panel-heading -->
          </div><!-- panel -->
        </div><!-- col-sm-6 -->
        <script type="text/javascript">
			getshopcount();

		</script>
		 
          <div class="col-sm-6 col-md-3">
              <div class="panel panel-red panel-stat">
                  <div class="panel-heading">
                      <div class="stat">
                          <div class="row">
                              <div class="col-xs-4">
                                  <img src="${ctx }/bracket/images/is-men.png" alt="" />
                              </div>
                              <div class="col-xs-4">
                                  <small class="stat-label">帖子数</small>
                                  <span id="bbscount">?</span>
                              </div>
                               <div class="col-xs-4">
                               <small class="stat-label">总流量</small>
                               <span id="bbsreading">?</span>
                                </div>
                          </div><!-- row -->
                          <div class="mb15"></div>
                          <div class="row">
                              <div class="col-xs-6">
                                  <small class="stat-label">昨日增加</small>
                                  <h4>+<span id="bbszcount"></span></h4>
                              </div>
                              <div class="col-xs-6">
                                  <small class="stat-label">近30日增加</small>
                                  <h4>+<span id="bbsycount"></span></h4>
                              </div>
                          </div>

                      </div><!-- stat -->

                  </div><!-- panel-heading -->
              </div><!-- panel -->
          </div><!-- col-sm-6 -->
          <script type="text/javascript">
			getbbscount();

			</script>
         <security:authorize ifAllGranted="ROLE_100105">
          <div class="col-sm-6 col-md-3">
              <div class="panel panel-success panel-stat">
                  <div class="panel-heading">

                      <div class="stat">
                          <div class="row">
                              <div class="col-xs-4">
                                  <img src="${ctx }/bracket/images/is-men.png" alt="" />
                              </div>
                              <div class="col-xs-8">
                                  <small class="stat-label">挪车总数</small>
                                  <h1 id="telcount">?</h1>
                              </div>
                          </div><!-- row -->

                          <div class="mb15"></div>

                          <div class="row">
                              <div class="col-xs-6">
                                  <small class="stat-label">昨日增加</small>
                                  <h4>+<span id="zrtel"></span></h4>
                              </div>

                              <div class="col-xs-6">
                                  <small class="stat-label">近30日增加</small>
                                  <h4>+<span id="bytel"></span></h4>
                              </div>
                          </div>

                      </div><!-- stat -->

                  </div><!-- panel-heading -->
              </div><!-- panel -->
          </div><!-- col-sm-6 -->
          <script type="text/javascript">

          gettelcount();
			</script>
          </security:authorize>
          <security:authorize ifAllGranted="ROLE_100106">
          <div class="col-sm-6 col-md-3">
              <div class="panel panel-red panel-stat">
                  <div class="panel-heading">

                      <div class="stat">
                          <div class="row">
                              <div class="col-xs-4">
                                  <img src="${ctx }/bracket/images/is-men.png" alt="" />
                              </div>
                              <div class="col-xs-8">
                                  <small class="stat-label">活跃用户总数</small>
                                  <h1 id="hyyhcount">?</h1>
                              </div>
                          </div><!-- row -->

                          <div class="mb15"></div>

                          <div class="row">
                              <div class="col-xs-6">
                                  <small class="stat-label">昨日活跃</small>
                                  <h4>+<span id="zrhyyh"></span></h4>
                              </div>

                              <div class="col-xs-6">
                                  <small class="stat-label">近30日活跃</small>
                                  <h4>+<span id="byhyyh"></span></h4>
                              </div>
                          </div>

                      </div><!-- stat -->

                  </div><!-- panel-heading -->
              </div><!-- panel -->
          </div><!-- col-sm-6 -->
          <script type="text/javascript">
          gethyyhcount();

		</script>
        </security:authorize>
        <security:authorize ifAllGranted="ROLE_100112">
        <div class="col-sm-6 col-md-3">
          <div class="panel panel-dark panel-stat">
            <div class="panel-heading">

              <div class="stat">
                <div class="row">
                  <div class="col-xs-4">
                    <img src="${ctx }/bracket/images/is-money.png" alt="" />
                  </div>
                  <div class="col-xs-8">
                    <small class="stat-label">发货总量</small>
                    <h1 id="fhcount">?</h1>
                  </div>
                </div><!-- row -->

                <div class="mb15"></div>

                <div class="row">
                  <div class="col-xs-6">
                    <small class="stat-label">昨日发货</small>
                    <h4>￥<span id="zrfh"></span>单</h4>
                  </div>

                  <div class="col-xs-6">
                    <small class="stat-label">近30日发货</small>
                    <h4>￥<span id="byfh"></span>单</h4>
                  </div>
                </div><!-- row -->

              </div><!-- stat -->

            </div><!-- panel-heading -->
          </div><!-- panel -->
        </div><!-- col-sm-6 -->
        <script type="text/javascript">
			getfhcount();

		</script>
		</security:authorize>
		<security:authorize ifAllGranted="ROLE_100113">
        <div class="col-sm-6 col-md-3">
          <div class="panel panel-dark panel-stat">
            <div class="panel-heading">

              <div class="stat">
                <div class="row">
                  <div class="col-xs-4">
                    <img src="${ctx }/bracket/images/is-money.png" alt="" />
                  </div>
                  <div class="col-xs-8">
                    <small class="stat-label">收入总数</small>
                    <h1 id="srcount">?</h1>
                  </div>
                </div><!-- row -->

                <div class="mb15"></div>

                <div class="row">
                  <div class="col-xs-6">
                    <small class="stat-label">昨日收入</small>
                    <h4>￥<span id="zrsr"></span>元</h4>
                  </div>

                  <div class="col-xs-6">
                    <small class="stat-label">近30日收入</small>
                    <h4>￥<span id="bysr"></span>元</h4>
                  </div>
                </div><!-- row -->

              </div><!-- stat -->

            </div><!-- panel-heading -->
          </div><!-- panel -->
        </div><!-- col-sm-6 -->
        <script type="text/javascript">
			getsrcount();

		</script>
		</security:authorize>
      </div><!-- row -->
      <security:authorize ifAllGranted="ROLE_100107">
      <div class="row">
              <div class="col-md-12 mb30">
                <h5 class="subtitle mb5">H5服务浏览量</h5>
                
                <div id="company-ydl" style="width: 100%; height: 300px"></div>
              </div><!-- col-md-6 -->
              
      </div><!-- row -->
      <script type="text/javascript">
      getcompanyyds();
	</script>
      </security:authorize>
      
      <div class="row">
      	<security:authorize ifAllGranted="ROLE_100108">
              <div class="col-md-6 mb30">
                <h5 class="subtitle mb5">主菜单浏览量</h5>
                
                <div id="wxmenu-ydl" style="width: 100%; height: 300px"></div>
              </div><!-- col-md-6 -->
       		<script type="text/javascript">
				getwxmenuyds();
	  		</script>
      	</security:authorize>
      	<security:authorize ifAllGranted="ROLE_100109">
      
              <div class="col-md-6 mb30">
                <h5 class="subtitle mb5">城市用户比对</h5>
                
                <div id="wxcity-yhs" style="width: 100%; height: 300px"></div>
              </div><!-- col-md-6 -->
              
      
      	<script type="text/javascript">
			getCityNum();
	  	</script>
      </security:authorize>
      <security:authorize ifAllGranted="ROLE_100114">
      		<div class="col-md-6 mb30">
                <h5 class="subtitle mb5">H5统计</h5>
                
                <div class="table-responsive">
                <table class="table table-striped  mb30" >
                    <thead>
                      <tr>
                      	
                        
						<th class="th12">名称</th>
					
						<th class="th8">浏览量</th>
						<th class="th8">激活量</th>
				
						<th class="th16">收入</th>
						
			
                      </tr>
                    </thead>
                    <tbody id="h5tj">
                      
                      
                    </tbody>
                 </table>
                 </div>
                 <script type="text/javascript">
      				getComh5();
	  			</script>   
            </div><!-- col-md-6 -->
        
         
      </div><!-- row -->
             <div class="row">
              <div class="col-md-12 mb30">
                <h5 class="subtitle mb5">${bean.name }统计</h5>
                
                <div id="wxshoptj-${bean._id }" style="width: 100%; height: 300px"></div>
              </div><!-- col-md-6 -->
              
      </div><!-- row -->
      <script type="text/javascript">
      		getShoptj('${bean._id}');
	  </script>
	   </security:authorize>
      <c:forEach items="${shopmbList}" var="bean">
      <div class="row">
              <div class="col-md-12 mb30">
                <h5 class="subtitle mb5">${bean.name }统计</h5>
                
                <div id="wxshoptj-${bean._id }" style="width: 100%; height: 300px"></div>
              </div><!-- col-md-6 -->
              
      </div><!-- row -->
      <script type="text/javascript">
      		getShoptj('${bean._id}');
	  </script>
	  </c:forEach> 
       
	
     </div>

   </div>
        
  </div> 
</body>
</html>