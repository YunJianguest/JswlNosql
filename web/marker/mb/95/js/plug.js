/**
 * Created with JetBrains WebStorm.
 * User: Administrator
 * Date: 13-8-17
 * Time: 下午6:09
 * To change this template use File | Settings | File Templates.
 */
$(function(){
    //path
    $(".plug-menu").click(function(){
        var span = $(this).find("span");
        if(span.attr("class") == "open"){
            span.removeClass("open");
            span.addClass("close");
            $(".plug-btn").removeClass("open");
            $(".plug-btn").addClass("close");
        }else{
            span.removeClass("close");
            span.addClass("open");
            $(".plug-btn").removeClass("close");
            $(".plug-btn").addClass("open");
        }
    });
    $(".plug-menu").on('touchmove',function(event){event.preventDefault();});
});