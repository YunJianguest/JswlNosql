<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
 <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
                    <div class="navbar-header"><a class="navbar-minimalize minimalize-styl-2 btn btn-primary " href="#"><i class="fa fa-bars"></i> </a>
                       
                    </div>
                    <ul class="nav navbar-top-links navbar-right"> 
                     <c:if test="${not empty obj}">
                        <li class="dropdown">
                            <a class="dropdown-toggle count-info" data-toggle="dropdown" href="#">
                                <i class="fa fa-bell"></i> <span class="label label-primary">0</span>
                            </a>
                           
                            <ul class="dropdown-menu dropdown-alerts">
                                    <li> 
                                      <a href="#">
                                        <div>
                                            <i class="fa fa-envelope fa-fw"></i> 暂无消息
                                            <span class="pull-right text-muted small">1分钟前</span>
                                        </div>
                                      </a>
                                     </li>
                               
                             </ul>
                           
                        </li>
                        </c:if>
                    </ul>          
 </nav>