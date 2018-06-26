<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webcom/taglibs.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%--弹出层新--%>
<div class="fullscreen bg-hei-8 display-none" id="insfx" style="height: 100%;">
    <div style="padding-top:2%">
        <div class="pl-10 pr-10 maring-a cmp500"
             style="width: 100%;max-width: 500px;min-width: 320px;margin: 0px auto;right: 0px;">
            <div class=" bg-bai border-radius3 overflow-hidden">
                <div class="overflow-hidden line-height40 bg-bai line-bottom">
                    <div class="hang50 pull-left zi-hui-tq">
                        <i class="weight500 size14 pl-10 line-height50">分享信息填写</i>
                    </div>
                    <a href="javascript:ps_hide('insfx')">
                        <div class="hang40 pull-right zi-hui-tq">
                            <i class="weight500 size14 pl-10 pr-10 fa-1dx fa fa-remove" style="line-height: 50px;"></i>
                        </div>
                    </a>
                </div> 
                   <input type="hidden" id="fxtype"/>
                    <div class="pt-15 pl-15 pr-15 overflow-auto" style="height:490px;">

                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">分享名称:</label>
                                <input type="text" id="fxtitle" name="fxtitle"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">分享链接：</label>
                                <input type="text" id="fxurl" name="fxurl"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="mb-20">
                                <label class="control-label">分享简介: </label>
                                <input type="text" id="fxsummary" name="fxsummary"
                                       class="form-control" placeholder="请输入"/>
                            </div>
                        </div>
                        <div class="col-sm-6"> 
                                <label class="control-label">分享模板:</label>
                                <select id="fxmb" name="fxmb" class="select2"
                                        data-placeholder="请选择">
                                    <option value="0">默认模板</option>
                                    <option value="1">模板1</option>
                                    <option value="2">模板2</option>
                                    <option value="3">模板3</option>
                                </select>  
                        </div>
                         <div class="col-sm-12">
                                <label class="control-label">分享图片：</label>
                                <div>
                                    <div class="col-sm-9 form-group-20" style="padding:   0px;">
                                        <input type="text" id="fxpicurl" name="fxpicurl" class=" form-control"/>
                                    </div>
                                    <div class="col-sm-3 form-group-20" style="padding: 0px;position: relative;" onclick="pz('fxpicurl','200','200')">
                                        <div class="btn btn-primary"
                                                style="width: 100%;line-height: 20px;height:40px;">
                                            上传
                                        </div>
                                        
                                    </div>
                                </div>
                       </div>
                    </div>
                    <div class="div-group-10 line-top" style="padding-left: 40px; padding-right: 40px;">
                        <button class="btn btn-primary width-10 maring-a clear weight500 hang40" onclick="savefx()">提 交
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
 
 
<script>
    function updfx(type) {
        $('#fxtype').val(type);
        var submitData = {
            fxtype: type
        };
        $.post('${ctx}/weixin/sharefx!upd.action', submitData, function (json) {
            $('#fxtitle').val(json.fxtitle);
            $('#fxsummary').val(json.fxsummary);
            $('#oldurl').val(json.oldurl);
            $('#fxurl').val(json.fxurl);
            $('#fxpicurl').val(json.fximg);
            $('#fxmb').val(json.fxmb);
        }, "json") 
        ps_show('insfx');
    }
    function savefx() {
        var submitData = {
            fxtype: $('#fxtype').val(),
            fxtitle: $('#fxtitle').val(),
            fxsummary: $('#fxsummary').val(),
            fxurl: $('#fxurl').val(),
            fximg: $('#fxpicurl').val(),
            fxmb: $('#fxmb').val()
        };
        $.post('${ctx}/weixin/sharefx!ajaxsave.action', submitData, function (json) {
            window.location.href = window.location.href;
        }, "json")
    }
</script>