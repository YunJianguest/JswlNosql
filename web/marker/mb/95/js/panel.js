/**
 * Created with JetBrains WebStorm.
 * User: Administrator
 * Date: 13-8-17
 * Time: 上午11:21
 * To change this template use File | Settings | File Templates.
 */

function panel_innit(ui_header, ui_content, ui_footer){
    var panel_id = '';

    $('.ui_panel_btn').each(function(){
        var this_href = $(this).attr('href');
        if(this_href && this_href != 'undefined' && this_href.indexOf('#') != '-1'){
            panel_id = this_href;
        }
    });

    $('.ui_panel_btn').each(function(){
        var this_href = $(this).attr('href');
        if(this_href && this_href != 'undefined' && this_href.indexOf('#') != '-1' && this_href == panel_id){
            $(this).on('click', function(event){
                event.preventDefault();
                if($(panel_id).hasClass('is_show')){
                    panel_hide($(panel_id),ui_header,ui_content,ui_footer);
                }else{
                    $(window).scrollTop(0);
                    panel_show($(panel_id),ui_header,ui_content,ui_footer);
                }
            });

            //阻止事件冒泡
            $(this).on('touchstart', function(event){
                event.stopPropagation();
            });
        }
    });
    //面板隐藏
    function panel_hide(panel, header, content, footer){
        $(panel).removeClass('is_show').removeClass('ui_panel_right').addClass('ui_panel_right_hide');
        header.addClass('ui_panel_menu_btn_left_hide').removeClass('ui_panel_menu_btn_left');
        content.addClass('ui_panel_left_hide').removeClass('ui_panel_left');
        footer.addClass('ui_panel_left_hide').removeClass('ui_panel_left');
    }

    //面板显示
    function panel_show(panel, header, content, footer){
        $(panel).removeClass('ui_panel_right_hide').show(0, function(){
            $(this).addClass('ui_panel_right').addClass('is_show');
        })
        header.removeClass('ui_panel_menu_btn_left_hide').addClass('ui_panel_menu_btn_left');
        content.removeClass('ui_panel_left_hide').addClass('relative').addClass('ui_panel_left');
        footer.removeClass('ui_panel_left_hide').addClass('ui_panel_left');
    }

    $(panel_id).on('touchstart', function(event){
        event.stopPropagation();
    })

    $('body.ui_body_panel').on('touchstart', function(){
        panel_hide($(panel_id),ui_header,ui_content,ui_footer);
    })
}