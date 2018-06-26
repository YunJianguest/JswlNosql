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

   var type='video';
   var tag='${type}';
   $(function(){
   if(tag=='video'){ 
     $("#video_a").attr("class","active");
   }else if(tag=='music'){
     $('#music_a').addClass('active');
   }else{
     $('#all_a').addClass('active');
   }
   });
   
	function del(id) {
		if (confirm('确实要删除吗?')) {

			location.href = "${contextPath}/web/folder!delete.action?_id=" + id;

		}
	}

	function add() {
		$('#_id1').val('');
		$('#title1').val('');
		$('#sort1').val(0); 

		$('#inszcc').modal({
			show : true
		});
	}
	function addfile() {
		$('#_id').val('');
		$('#title').val('');
		$('#sort').val(0);

		$('#inszc').modal({
			show : true
		});
	}
	function upd(id, account, password, nickname) {
		$('#_id').val(id);
		$('#account').val(account);

		$('#password').val(password);
		$('#nickname').val(nickname);

		$('#inszc').modal({
			show : true
		});

	}
	function page_submit(num) {

		if (num == -1) {
			$("#fypage").val(0);
		} else if (num == -2) {
			$("#fypage").val($("#fypage").val() - 1);
		} else {
			$("#fypage").val(num);
		}

		$("#custinfoForm").submit();
	}
	function share(url) {
		location.href = "${contextPath}/pub/share.action?type=${type}&url="
				+ url;
	}
	function getchild(id) {
		location.href = "${contextPath}/web/folder!getFolders.action?folderid=" + id+"&parentid="+id+"&type=${type}";

	}

	function changeType(value) {
        type=value;
		$('#inscxForm').attr("action", "${ctx}/web/" + value + "!savedetail.action");

	}
	function savefiles(){
	   var submitData = {
		id : $('#fid').val(),
		title : $('#ftitle').val(),
		folderid : $('#ffolderid').val(),
		url : $('#fileupload').val(),
		path : $('#upresult').val(),
		sort:$('#fsort').val(),
		toUser:'${toUser}' 
		
	};
	$.post('${ctx}/web/'+type +'!savedetail.action', submitData, function(json) {
		if(json.state==0){
		 alert("上传成功！");
		 location.reload();
		} else{
		 alert("上传失败！")
		}
	 
	}, "json");
	
	}
	 
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
						 
			            <c:choose>
						<c:when test="${folderid==0}">
						
						</c:when>
						<c:otherwise>
						<li class="filter-type">显示: <a id="all_a" href="${ctx }/web/folder!getFolders.action?folderid=${folderid}&parentid=${parentid}">全部</a>
							<a id="music_a" href="${ctx }/web/folder!getFolders.action?folderid=${folderid}&parentid=${parentid}&type=music">音频</a> <a id="video_a" href="${ctx }/web/folder!getFolders.action?folderid=${folderid}&parentid=${parentid}&type=video">视频</a>
							<a id="files_a" href="${ctx }/web/folder!getFolders.action?folderid=${folderid}&parentid=${parentid}&type=video">文件</a>
					     
					    </li>
					    </c:otherwise>
					    </c:choose>
					</ul>


					<div class="row">
						<div class="col-sm-9">

							<div class="row filemanager">
								<c:forEach items="${foldersList }" var="bean">

									<div class="col-xs-6 col-sm-4 col-md-3">
										<div class="thmb">

											 
											<!-- btn-group -->
											<a href="javascript:getchild(${bean._id})">
												<div class="thmb-prev">
													<img src="${contextPath}/bracket/images/folder.png"
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

								<c:forEach items="${videoList}" var="bean">

									<div class="col-xs-6 col-sm-4 col-md-3">
										<div class="thmb">

											<div class="btn-group fm-group">
												<button type="button"
													class="btn btn-default dropdown-toggle fm-toggle"
													data-toggle="dropdown">
													<span class="caret"></span>
												</button>
												<ul class="dropdown-menu fm-menu" role="menu">
													<li><a href="javascript:share('${bean.url}');"><i
															class="fa fa-share"></i>分享</a></li>
													 
													<li><a href="${bean.url}" target="_blank"><i
															class="fa fa-download"></i> 下载</a></li>
													 
												</ul>
											</div>
											<!-- btn-group -->
											<div class="thmb-prev"> 
												<img src="${contextPath}/bracket/images/video.png"
													class="img-responsive" alt="" />
											</div>
											<h5 class="fm-title">

												<span class="zxx_text_overflow">${bean.title}</span>
											</h5>
											<small class="text-muted"><fmt:formatDate
													pattern='yyyy-MM-dd HH:mm:ss' value='${bean.createdate}' />
											</small>
										</div>
										<!-- thmb -->
									</div>

									<!-- col-xs-6 -->
								</c:forEach>
								
									<c:forEach items="${musicList}" var="bean">

									<div class="col-xs-6 col-sm-4 col-md-3">
										<div class="thmb">
										    <c:if test="${not empty bean.url}">

											<div class="btn-group fm-group">
												<button type="button"
													class="btn btn-default dropdown-toggle fm-toggle"
													data-toggle="dropdown">
													<span class="caret"></span>
												</button>
												<ul class="dropdown-menu fm-menu" role="menu">
													<li><a href="javascript:share('${bean.url}');"><i
															class="fa fa-share"></i>分享</a></li>
													
													<li><a href="${bean.url}" target="_blank"><i
															class="fa fa-download"></i> 下载</a></li>
													 
												</ul>
											</div>
											</c:if>
											<!-- btn-group -->
											<div class="thmb-prev">
												<img src="${contextPath}/bracket/images/music.png"
													class="img-responsive" alt="" />
											</div>
											<h5 class="fm-title">

												<span class="zxx_text_overflow">${bean.title}</span>
											</h5>
											<small class="text-muted"><fmt:formatDate
													pattern='yyyy-MM-dd HH:mm:ss' value='${bean.createdate}' />
											</small>
										</div>
										<!-- thmb -->
									</div>

									<!-- col-xs-6 -->
								</c:forEach>
								 <c:if test="${userType==2}">
								  <c:forEach items="${filesList}" var="bean"> 
									<div class="col-xs-6 col-sm-4 col-md-3">
										<div class="thmb">
										    <c:if test="${not empty bean.url}">

											<div class="btn-group fm-group">
												<button type="button"
													class="btn btn-default dropdown-toggle fm-toggle"
													data-toggle="dropdown">
													<span class="caret"></span>
												</button>
												<ul class="dropdown-menu fm-menu" role="menu">
													 
													<li><a href="${bean.url}" target="_blank"><i
															class="fa fa-download"></i> 下载</a></li>
													 
												</ul>
											</div>
											</c:if>
											<!-- btn-group -->
											<div class="thmb-prev">
											  <c:choose>
											  <c:when test="${bean.type==mp3}">
											  <img src="${contextPath}/bracket/images/music.png"
													class="img-responsive" alt="" />
											  
											  </c:when>
											  <c:when test="${bean.type==mp4}">
											  <img src="${contextPath}/bracket/images/video.png"
													class="img-responsive" alt="" />
											  
											  </c:when>
											   
											  <c:otherwise>
											   <img src="${contextPath}/bracket/images/zip.png"
													class="img-responsive" alt="" />
											  </c:otherwise>
											  </c:choose>
											 
											</div>
											<h5 class="fm-title">

												<span class="zxx_text_overflow">${bean.title}</span>
											</h5>
											<small class="text-muted"><fmt:formatDate
													pattern='yyyy-MM-dd HH:mm:ss' value='${bean.createdate}' />
											</small>
										</div>
										<!-- thmb -->
									</div>

									<!-- col-xs-6 -->
								</c:forEach>
								
								  
								  </c:if>
									
								



							</div>
							<!-- row -->
						</div>
						<!-- col-sm-9 -->
						
						<div class="col-sm-3">
							<div class="fm-sidebar">
							 <c:choose>
						     <c:when test="${folderid==0}">
						
						     </c:when>
						     <c:otherwise>

								<span class="btn btn-primary btn-block" onclick="addfile()">上传文件</span>

								<div class="mb30"></div>

								<h5 class="subtitle">
									文件夹<a href="javascript:add();" class="pull-right">+ 新增文件夹</a>
								</h5>
							 </c:otherwise>
						     </c:choose>
						 
								<ul class="folder-list">
									<c:forEach items="${foldersList }" var="bean">
										<li><a href="javascript:getchild('${bean._id }')"><i
												class="fa fa-folder-o"></i>${bean.title }</a></li>
									</c:forEach>

								</ul>

								<div class="mb30"></div>

							</div>
						</div>
						
					
						
						<!-- col-sm-3 -->
					</div>
				</div>
		</div>

		</form>
		</div>
		<!-- mainpanel -->
	</section>
	<div id="inszc" class="modal fade bs-example-modal-static"
		tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		data-backdrop="static" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button">&times;</button>
					<h4 class="modal-title">
						<i class="fa fa-leaf"></i> 添加内容
					</h4>
				</div>
				<div class="modal-body">
					<form id="inscxForm" 
						class="form-horizontal" method="post">
						<input type="hidden" id="_id" name="_id" /> <input type="hidden"
							id="upresult" name="path" />
						<input type="hidden" id="ffolderid"name="folderid" value="${folderid}"/>


						<div class="panel panel-default">
							<div class="panel-body">
								<div class="form-group">
									<label class="col-sm-2 control-label">名称: <span
										class="asterisk">*</span> </label>
									<div class="col-sm-5">

										<input type="text" id="ftitle" name="title"
											class="form-control" placeholder="请输入" />
									</div>

								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">文件类型: <span
										class="asterisk">*</span> </label>
									<div class="col-sm-5">
										<select class="form-control " data-placeholder="请选择"
											onchange="changeType(this.value)">

											<c:forEach items="${dictionaryList}" var="bean">
												<option value="${bean.value}">${bean.name}</option>
											</c:forEach>
										</select>
									</div>

								</div>

								 

								<div class="form-group">
									<label class="col-sm-2 control-label">文件地址 <span
										class="asterisk">*</span> </label>
									<div class="col-sm-5">

										<input type="text" id="fileupload" name="url"
											class="form-control" placeholder="请输入" />

									</div>

								</div>

								<div class="form-group">
									<label class="col-sm-2 control-label">序号: <span
										class="asterisk">*</span> </label>
									<div class="col-sm-5">

										<input type="text" id="fsort" name="sort" class="form-control"
											placeholder="请输入" />
									</div>

								</div>

								<%@include file="/webcom/upload.jsp"%>

							</div>
							<!-- panel-body -->

							

						</div>
						<!-- panel -->

					</form>

                            <div class="panel-footer">
								<div class="row">
									<div class="col-sm-9 col-sm-offset-3">
										<button class="btn btn-success btn-block" onclick="savefiles()">提&nbsp;&nbsp;交</button>
									</div>
								</div>
							</div>
				</div>
				<!-- row -->
			</div>
		</div>
	</div>

	<div id="inszcc" class="modal fade bs-example-modal-static"
		tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		data-backdrop="static" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close"
						type="button">&times;</button>
					<h4 class="modal-title">
						<i class="fa fa-leaf"></i> 添加内容
					</h4>
				</div>
				<div class="modal-body">
					<form id="inscxForm1" action="${ctx }/web/folder!savedetail.action"
						class="form-horizontal" method="post">
						<input type="hidden" id="_id" name="_id" />
						<input type="hidden" id="parentid" name="parentid" value="${parentid}" />
						<input type="hidden" id="type" name="type" value="${type }" />
						<input type="hidden" id="folderid"name="folderid" value="${folderid}"/>

						<div class="panel panel-default">
							<div class="panel-body">
								<div class="form-group">
									<label class="col-sm-2 control-label">名称: <span
										class="asterisk">*</span> </label>
									<div class="col-sm-5">

										<input type="text" id="title1" name="title"
											class="form-control" placeholder="请输入" />
									</div>

								</div>

							 
								<div class="form-group">
									<label class="col-sm-2 control-label">序号: <span
										class="asterisk">*</span> </label>
									<div class="col-sm-5">

										<input type="text" id="sort1" name="sort" class="form-control"
											placeholder="请输入" />
									</div>

								</div>

							</div>
							<!-- panel-body -->

							<div class="panel-footer">
								<div class="row">
									<div class="col-sm-9 col-sm-offset-3">
										<button class="btn btn-success btn-block">提&nbsp;&nbsp;交</button>
									</div>
								</div>
							</div>

						</div>
						<!-- panel -->

					</form>


				</div>
				<!-- row -->
			</div>
		</div>
	</div>


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
