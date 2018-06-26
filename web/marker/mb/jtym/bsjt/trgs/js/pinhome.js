//加载快捷按钮列表
var quicklink_url = '/quicklink/';

$(document).on('pagecreate', function (e) {
    var $target = $(e.target);
    var $header = $(':jqmData(role=\'header\')', $target), $home = $(':jqmData(icon=\'home\')', $header);
    //4.首页按钮路径修正
    $home.attr('href', $('body').jqmData('homeurl'));

    if (window.wb_qkdata) {
        quickpanelinit();
    } else {
        $(document).bind('quicklinkload', function () {
            quickpanelinit();
        });
    }

    //初始化快捷面板
    function quickpanelinit() {
        var $homebutton = $home.jqmData('icon', 'home');
        if ($homebutton.length > 0) {
            var $panel_quicklink = createQuickLinkPanel();
            if ($panel_quicklink) {
                $panel_quicklink.appendTo($target).panel({
                    'display': 'push',
                    'position': 'right',
                    'theme': 'a'
                });
                $homebutton.buttonMarkup({ 'icon': 'bars' }).click(function () {
                    $panel_quicklink.panel('open');
                    return false;
                });
            }
        }
    }

    function createQuickLinkPanel() {
        var qkdata = window.wb_qkdata;
        if (qkdata && $.isArray(qkdata)) {
            var html = '<ul><li><a data-rel="external" data-ajax="false" href="' + window.wb_homeurl + '">首页</a></li>';
            $.each(qkdata, function (index, item) {
                html += '<li><a data-rel="external" data-ajax="false" 1data-ajax="' + (item['ajax'] == 1 ? 'true' : 'false') + '" href="' + item['href'] + '">' + item['title'] + '</a></li>';
            });
            html += '</ul>';
            var $list = $(html).appendTo($target).listview({
                'inset': false,
                'theme': 'a'
            });
            return $('<div></div>').append($list);
        }
        else {
            return undefined;
        }
    }

});

$(function () {
    //获取基本配置参数
    var $body = $('body');
    window.wb_homeurl = $body.jqmData('homeurl');
    window.wb_userid = $body.jqmData('userid');
    window.wb_wxuid = $body.jqmData('wxuid');

    if (window.wb_userid) {
        $.getJSON(quicklink_url, {
            'userid': window.wb_userid,
            'wxuid': window.wb_wxuid
        }, function (data) {
            window.wb_qkdata = data;
            $(document).trigger('quicklinkload');
        }).error(function (e, a) {

        });
    }



});

