<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/webcom/meta.jsp"%>
<%@include file="/webcom/bracket.jsp"%>
<script src="${contextPath}/UserInterface/My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>

<script type="text/javascript">

   
</script>

</head>

<body>

	<section>

		<%@include file="/webcom/header-bracket.jsp"%>

		<div class="mainpanel">
			<%@include file="/webcom/header-headerbar.jsp"%>
			<form id="custinfoForm" name="custinfoForm" method="post"
				action="${contextPath}/web/folder!getFolders.action?">
				<div class="contentpanel">

					<ul class="filemanager-options">
					    <a href="javascript:history.go(-1);"><li
							class="fa  fa-long-arrow-left" ></li>
						</a>
						 
			        
					</ul>


					<div class="row">
						<div class="col-sm-9">

							<div class="row filemanager">
								<c:forEach items="${mobilesceneList }" var="bean">

									<div class="col-xs-6 col-sm-4 col-md-3">
										<div class="thmb">
										   
										   
										   <div class="btn-group fm-group">
												<button type="button"
													class="btn btn-default dropdown-toggle fm-toggle"
													data-toggle="dropdown">
													<span class="caret"></span>
												</button>
												<ul class="dropdown-menu fm-menu" role="menu">
													<li><a href="${contextPath}/suc/mobilescene!web.action?toUser=${bean.toUser}&msid=${bean._id}&fromUser=oypimjo3Ln36uWtmW6TYWtND0P0o" target="_blank"><i
															class="fa fa-share"></i>预览</a></li>
													
													<li><a href="${contextPath}/suc/mobilescene!copyScene.action?msid=${bean._id}"><i
															class="fa fa-download"></i>克隆</a></li>
													 
												</ul>
											</div>

											 
											<!-- btn-group -->
											<a href="javascript:getchild(${bean._id})">
												<div class="thmb-prev">
													<img src="${osshttp}/${bean.picurl}"
														class="img-responsive" alt="" />
												</div> </a>
											<h5 class="fm-title">
												<a href="">${bean.title}</a>
											</h5>
											<small class="text-muted"> ${bean.createdate}</small>
										</div>
										<!-- thmb -->
									</div>

									<!-- col-xs-6 -->

								</c:forEach>
 
							</div>
							<!-- row -->
						</div>
						<!-- col-sm-9 -->
					 
						
					
						
						<!-- col-sm-3 -->
					</div>
				</div>
		</div>

		</form>
		</div>
		<!-- mainpanel -->
	</section>
	 
	<script>
		function check() {
			$('.zxx_text_overflow').each(function() {
				var maxwidth = 6;

				if ($(this).text().length > maxwidth) {
					$(this).text($(this).text().substring(0, maxwidth));
					$(this).html($(this).html() + '...');
				}
			});
		}

		jQuery(document).ready(function() {

			"use strict";

			jQuery('.thmb').hover(function() {
				var t = jQuery(this);
				t.find('.ckbox').show();
				t.find('.fm-group').show();
			}, function() {
				var t = jQuery(this);
				if (!t.closest('.thmb').hasClass('checked')) {
					t.find('.ckbox').hide();
					t.find('.fm-group').hide();
				}
			});

			function enable_itemopt(enable) {
				if (enable) {
					jQuery('.itemopt').removeClass('disabled');
				} else {

					// check all thumbs if no remaining checks
					// before we can disabled the options
					var ch = false;
					jQuery('.thmb').each(function() {
						if (jQuery(this).hasClass('checked'))
							ch = true;
					});

					if (!ch)
						jQuery('.itemopt').addClass('disabled');
				}
			}

			check();

		});
	</script>


</body>
</html>
