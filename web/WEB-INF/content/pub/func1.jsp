<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webcom/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/webcom/meta.jsp"%>
<%@include file="/webcom/bracket.jsp"%> 
 
<style>
        .text-c {
            text-align: center !important;
        }

        .width-60px {
            width: 60px !important;
            margin: 0px !important;
        }

        .position-r {
            position: relative !important;
        }

        .color-333 {
            color: #333;
        }
    </style>
<script type="text/javascript">
function del(id) {
	if (confirm('确实要删除吗?')) {

		location.href = "${contextPath}/pub/func!delete.action?_id=" + id;

	}
}
function delchild(id){
     if (confirm('确实要删除吗?')) {

		location.href = "${contextPath}/pub/func!deletchildfunc.action?_id=" + id;

	}
}
function getchild(id){
      
	   location.href = "${contextPath}/pub/func.action?parentid="+id;

}

function add() {
	$('#_id').val('');
	$('#name').val(''); 
	$('#logo').val('');
	$('#url').val(''); 
	$('#sort').val(0);
	$('#inszc').modal({
		show : true
	});
}
function upd(id, name, logo, url, parentid, sort) {
	$('#_id').val(id);
	$('#name').val(name);

	$('#logo').val(logo);
	$('#url').val(url);
	$('#parentid').val(parentid);
	$('#sort').val(sort);

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
            <div class="wrapper wrapper-content animated fadeInRight">

    <div class="ibox float-e-margins">
        <div class="ibox-content">
            <div class="row">

                <div class="no-padding">
                    <div class="col-sm-1 no-padding">
                        <div class="input-group">
                            <input type="text" value="关键字" placeholder="关键字" class="form-control">
                        </div>
                    </div>
                    <div class="col-sm-1" style="padding-left: 10px!important;padding-right: 0px!important;">
                        <div class="input-group">
                            <input type="text" value="关键字" placeholder="关键字" class="form-control">
                        </div>
                    </div>
                    <div class="col-sm-2" style="padding-left: 10px!important;padding-right: 0px!important;">
                        <div class="form-group" id="data_1">
                            <div class="input-group date">
                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                <input type="text" class="form-control" value="2014-11-11">
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-2" style="padding-left: 10px!important;padding-right: 0px!important;">
                        <div class="form-group">
                            <div class="input-group" style="width: 100%;">
                                <select data-placeholder="选择省份..." class="chosen-select" style="width:100%;"
                                        tabindex="2">
                                    <option value="">请选择省份</option>
                                    <option value="110000" hassubinfo="true">北京</option>
                                    
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-1" style="padding-left: 10px!important;padding-right: 0px!important;">
                        <div class="btn btn-primary" type="submit">搜索</div>
                    </div>

                    <div class="btn btn-primary position-r pull-right" style="margin:0px 0px 0px 10px;">
                        <a class="dropdown-toggle1 btn-primary" data-toggle="dropdown" style="width: 100%">
                             菜单<i class="fa fa-reorder" style="padding-left:10px;"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-user color-333">
                            <li><a href="#">选项1</a>
                            </li>
                            <li><a href="#">选项2</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <table data-toggle="table" data-height="460">
                    <thead>
                    <tr>
                        <th data-field="state" data-checkbox="true"></th>
                        <th data-field="id">名称</th>
                        <th data-field="name">价格</th>
                        <th data-field="price">列1</th>
                        <th data-field="column2">列2</th>
                        <th class="text-c width-60px">
                            设置
                        </th>

                    </tr>
                    </thead>
                    <tbody>
                    <tr data-index="0">
                        <td data-field="state" data-checkbox="true"></td>
                        <td>ID</td>
                        <td>名称</td>
                        <td>价格1</td>
                        <td>价格2</td>
                        <td class="text-c width-60px height-41 position-r">
                            <a class="dropdown-toggle1" data-toggle="dropdown">
                                <i class="fa fa-cog color-333"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="#">选项1</a>
                                </li>
                                <li><a href="#">选项2</a>
                                </li>
                            </ul>
                        </td>
                    </tr>
                    <tr data-index="1">
                        <td data-field="state" data-checkbox="true"></td>
                        <td>ID</td>
                        <td>名称</td>
                        <td>价格1</td>
                        <td>价格2</td>
                        <td class="text-c width-60px height-41 position-r">
                            <a class="dropdown-toggle1" data-toggle="dropdown">
                                <i class="fa fa-cog color-333"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="#">选项1</a>
                                </li>
                                <li><a href="#">选项2</a>
                                </li>
                            </ul>
                        </td>
                    </tr>
                    <tr data-index="1">
                        <td data-field="state" data-checkbox="true"></td>
                        <td>rr</td>
                        <td>名称1</td>
                        <td>价格11</td>
                        <td>价格12</td>
                        <td class="text-c width-60px height-41 position-r">
                            <a class="dropdown-toggle1" data-toggle="dropdown">
                                <i class="fa fa-cog color-333"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="#">选项1</a>
                                </li>
                                <li><a href="#">选项2</a>
                                </li>
                            </ul>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
            
            </div>
       </div>

   </div> 
</body>
</html>