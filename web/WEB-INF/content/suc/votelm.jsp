<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/webcom/meta.jsp" %>
    <%@include file="/webcom/bracket.jsp" %>
    <%@include file="/webcom/jquery.validate_js.jsp" %>
    <script src="${contextPath}/UserInterface/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctx}/media/js/DT_bootstrap.js"></script>
    <script type="text/javascript" src="${ctx}/mvccol/js/jquery.form.js"></script>
    <script src="${ctx}/mvccol/js/fomatdate2.js"></script>
    <script type="text/javascript">
        function del(id) {
            if (confirm('确实要删除吗?')) {
                location.href = "${contextPath}/suc/votelm!delete.action?fypage=${fypage}&_id="
                + id;
            }
        }
        function add() {
            window.location.href = '${contextPath}/suc/votelm!input.action?fypage=${fypage}';
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
            window.open("${contextPath}/weixin/share.action?method=" + encodeURIComponent(url));
        }
        function pz(id, w, h) {
            $("#clipArea").photoClip({
                width: w,
                height: h,
                file: "#file",
                view: "#view",
                ok: "#clipBtn",
                outputType: "jpg",
                loadStart: function () {
                    console.log("照片读取中");
                },
                loadComplete: function () {
                    console.log("照片读取完成");
                },
                clipFinish: function (dataURL) {
                    upimage(dataURL, id);
                    $('#clipArea').html('');
                }
            });
            $('#jqpic').show();
        }
        function upimage(baseurl, id) {
            var submitData = {
                baseurl: baseurl
            };
            $.post('${ctx}/web/webajax!upimage.action?toUser=${toUser}', submitData,
                    function (json) {
                        if (json.state == 0) {
                            $("#" + id).val(json.path);
                            $('#jqpic').hide();
                        }
                    }, "json")
        }
        function gb() {
            $('#tubiao').hide();
            $('#jqpic').hide();
            $('#clipArea').html('');
        }
        function upd(id) {
            var submitData = {
                _id: id
            };
            $.post('${ctx}/suc/votelm!upd.action', submitData, function (json) {
                $('#_id').val(json._id);
                $('#title').val(json.title);
                $('#content').val(json.content);
                $('#picurl').val(json.picurl);
                $('#bgcurl').val(json.bgcurl);
                $('#bmenddate').val(Date.prototype.format(json.bmenddate));
                $('#enddate').val(Date.prototype.format(json.enddate));
                $('#startdate').val(Date.prototype.format(json.startdate));
                $('#startclues').val(json.startclues);
                $('#endclues').val(json.endclues);
                $('#frequency').val(json.frequency);
                $('#mb').val(json.mb);
                $('#jxsz').val(json.jxsz);
            }, "json")
            $('#insadd').modal({
                show: true
            });
        }
    </script>
    <style type="text/css">
        textarea {
            resize: none;
            width: 200px;
            height: 200px;
        }
    </style>
</head>
<body>
<section>
    <%@include file="/webcom/header-bracket.jsp" %>
    <div class="mainpanel">
        <%@include file="/webcom/header-headerbar.jsp" %>
        <form id="custinfoForm" name="custinfoForm" method="post" action="${contextPath}/suc/votelm.action">
            <div class="pageheader">
                <h2><i class="fa fa-user"></i> 微网站 <span>投票区</span></h2>
                <div class="breadcrumb-wrapper1">
                    <div class="input-group ">
                        <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                            菜单 <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu pull-right" role="menu">
                            <li><a href="javascript:add();"><i class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;新增活动</a>
                            </li>
                            <li><a href="javascript:updfx('activity_share')"><i class="fa fa-pencil"></i>&nbsp;&nbsp;&nbsp;&nbsp;分享信息填写</a>
                            </li>
                            <li><a href="${ctx}/suc/slide.action?type=activity"><i class="fa fa-photo"></i>&nbsp;&nbsp;添加总活动幻灯片</a>
                            </li> 
                            <li><a href="javascript:qrcode('${ctxurl}/suc/totalactivity!web.action?custid=${custid}&type=2')"><i class="fa fa-eye"></i>&nbsp;&nbsp;&nbsp;查看预览</a></li>        
                        </ul>

                    </div>
                </div>
            </div>
            <div class="panelss ">
                <div class="panel-body fu10">
                    <div class="row-pad-5">

                        <div class="form-group col-sm-1d">
                            <input type="text" name="name" value="${name }" placeholder="名称" class="form-control"/>
                        </div>
                        <a href="javascript:page_submit(-1);" class="btn btn-primary">搜&nbsp;&nbsp;索</a>

                    </div>
                </div>
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <table class="table table-striped table-primary table-action mb30">
                                <thead>
                                <tr>
                                    <th class="th5 table-action">序号</th>
                                    <th class="th12 table-action">图片</th>
                                    <th class="th8 table-action">标题</th>
                                    <th class="th8 table-action">模板</th>
                                    <th class="th5 table-action">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${votelmList}" var="bean">
                                    <tr>
                                        <td>${bean.sort}</td>
                                        <td><img src="${filehttp}${bean.picurl}" style="height:25px;"></td>
                                        <td>${bean.title}</td>
                                        <c:if test="${bean.mb==0}">
                                            <td>模板一</td>
                                        </c:if>
                                        <c:if test="${bean.mb==1}">
                                            <td>模板二</td>
                                        </c:if>
                                        <c:if test="${bean.mb==3}">
                                            <td>模板三</td>
                                        </c:if>
                                        <c:if test="${bean.mb==2}">
                                            <td>票数排序</td>
                                        </c:if>
                                        <td class="table-action">
                                            <div class="btn-group1">
                                                <a data-toggle="dropdown" class="dropdown-toggle">
                                                    <i class="fa fa-cog"></i>
                                                </a>
                                                <ul role="menu" class="dropdown-menu pull-right">
                                                    <li>
                                                        <a href="${contextPath}/suc/votelm!update.action?fypage=${fypage}&_id=${bean._id}">
                                                            <i class="fa fa-pencil"></i>&nbsp;&nbsp;&nbsp;&nbsp;活动修改</a>
                                                    </li>
                                                    <li><a href="javascript:del(${bean._id});"><i
                                                            class="fa fa-trash-o "></i>&nbsp;&nbsp;&nbsp;&nbsp;删除</a>
                                                    </li>
                                                    <li><a href="${contextPath}/suc/vote.action?voteid=${bean._id}"><i
                                                            class="fa fa-child"></i>&nbsp;&nbsp;&nbsp;&nbsp;参赛人员管理</a>
                                                    </li>
                                                    <li><a href="${ctx}/suc/slide.action?type=votelm-${bean._id}"><i
                                                            class="fa fa-plus"></i>&nbsp;&nbsp;&nbsp;&nbsp;添加幻灯片</a></li>
                                                    <li><a href="javascript:qrcode('${ctxurl}/suc/votelm!index.action?custid=${custid}&_id=${bean._id}')"><i
                                                         class="fa fa-eye"></i>&nbsp;&nbsp;&nbsp;查看预览</a></li>
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </table>
                            <%@include file="/webcom/bracket-page.jsp" %>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</section>
<div id="insadd" class="modal fade bs-example-modal-static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     data-backdrop="static" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close"
                        type="button">&times;</button>
                <h4 class="modal-title">
                    <i class="fa fa-pencil"></i>活动基础配置修改
                </h4>
            </div>
            <div class="modal-body">
                <form id="inscxForm" action="${ctx }/suc/votelm!save.action?fypage=${fypage}"
                      class="form-horizontal" method="post">
                    <input type="hidden" id="_id" name="_id"/>

                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">活动名称: <span class="asterisk">*</span></label>
                                <div class="col-sm-3">

                                    <input type="text" id="title" name="title" class="form-control" placeholder="请输入"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">分享图片填写: <span class="asterisk">*</span></label>

                                <div class="col-sm-2">
                                    <input type="text" id="picurl" name="picurl" class="form-control"
                                           placeholder="请输入"/>
                                </div>
                                <div class="col-sm-2">
                                    <div class="button btn-primary " onclick="pz('picurl','200','200')">
                                        <div class="an-normal "><i class="fa fa-scissors  pr-10"></i>压缩传</div>
                                    </div>
                                </div>
                                <label class="col-sm-3 control-label">报名截止日期<span class="asterisk">*</span></label>

                                <div class="col-sm-2">
                                    <input type="text" name="bmenddate" id="bmenddate" readonly="readonly"
                                           required="required" placeholder="点击输入日期"
                                           value="<fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${bmenddate}'/>"
                                           onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})"
                                           class="form-control" style="width: 130px;"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">开始日期<span class="asterisk">*</span></label>

                                <div class="col-sm-2">
                                    <input type="text" name="startdate" id="startdate" readonly="readonly"
                                           required="required" placeholder="点击输入日期"
                                           value="<fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${startdate}'/>"
                                           onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})"
                                           class="form-control" style="width: 130px;"/>
                                </div>
                                <div class="col-sm-2">
                                    <input type="text" id="startclues" class="form-control" placeholder="请输入开始语"
                                           style="width: 130px;" value="<s:property value='startclues'/>"
                                           name="startclues"/>
                                </div>
                                <label class="col-sm-1 control-label">截止日期 <span class="asterisk">*</span></label>

                                <div class="col-sm-2">
                                    <input type="text" name="enddate" id="enddate" readonly="readonly"
                                           required="required" placeholder="点击输入日期"
                                           value="<fmt:formatDate pattern='yyyy-MM-dd HH:mm' value='${enddate}'/>"
                                           onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})"
                                           class="form-control" style="width: 130px;"/>
                                </div>
                                <div class="col-sm-2">
                                    <input type="text" id="endclues" class="form-control" placeholder="请输入结束语"
                                           style="width: 130px;" value="<s:property value='endclues'/>"
                                           name="endclues"/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">活动宣传图: <span class="asterisk">*</span></label>

                            <div class="col-sm-6">
                                <input type="text" id="bgcurl" name="bgcurl" class="form-control" placeholder="请输入"/>
                            </div>
                            <div class="col-sm-2">
                                <div class="button btn-primary " onclick="pz('bgcurl','450','200')">
                                    <div class="an-normal "><i class="fa fa-scissors  pr-10"></i>压缩传</div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">模板:<span class="asterisk">*</span></label>
                            <div class="col-sm-2">
                                <select class="form-control form-control" id="mb" name="mb">
                                    <option value="0">默认模板</option>
                                </select>
                            </div>
                            <label class="col-sm-1 control-label">频率 <span class="asterisk">*</span></label>
                            <div class="col-sm-2">
                                <s:select cssClass="form-control" name="frequency"
                                          list="#{'0':'仅一次','1':'每日一次','2':'每日二次','3':'每日三次','4':'不限次数'}" listKey="key"
                                          listValue="value"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">活动与奖项设置说明: </label>
                            <div class="col-sm-9">
                                <textarea name="content" id="content" class="form-control" rows="5"
                                          placeholder="请输入"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">序号: </label>
                            <div class="col-sm-9">
                                <input type="text" id="sort" name="sort" value="0" class="form-control"
                                       placeholder="请输入"/>
                            </div>
                        </div>
                    </div>
                    <div class="panel-footer">
                        <div class="row">
                            <div class="col-sm-9 control-label" onclick="savefx()">
                                <button class="col-sm-12 btn btn-primary dropdown-toggle">提&nbsp;&nbsp;交</button>
                            </div>
                        </div>
                    </div>
            </div>
            </form>
        </div>
    </div>
</div>
</div>
<%@ include file="/webcom/share.jsp" %>
<%@include file="/webcom/cut-img.jsp" %>
<%@ include file="/webcom/preview.jsp"%>
</body>
</html>
