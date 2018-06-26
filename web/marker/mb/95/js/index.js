/**
 * Created with JetBrains WebStorm.
 * User: Administrator
 * Date: 13-8-17
 * Time: 下午5:59
 * To change this template use File | Settings | File Templates.
 */
//幻灯自动播放
$(function(){
    myScroll = new iScroll('wrapper', {
        snap: true,
        momentum: false,
        hScrollbar: false,
        onScrollEnd: function () {
            document.querySelector('#indicator > li.active').className = '';
            document.querySelector('#indicator > li:nth-child(' + (this.currPageX + 1) + ')').className = 'active';
        }
    });
    setInterval(function(){
        myScroll.scrollToPage('next', 0,400, count);
    },3500 );
});

var count = $('#thelist img').length;
var body_width = $('body').width();
for(i=0;i<count;i++){
    $('#thelist img:eq(' + i + ')').css({'width' : body_width + 'px'});
}
$('#scroller').css({'width': (body_width * count) + 'px'});

$(function(){
    var menu_item = $('#main_menu .row div');

    menu_item.each(function(){
    	var _self = $(this)[0];
    	var menu_item_width = _self.style.width;
        $(this).height(menu_item_width);
    });
})


window.onresize = function(){
    var new_body_width = $('body').width();
    for(i=0;i<count;i++){
        $('#thelist img:eq(' + i + ')').css({'width' : new_body_width + 'px'});
    }
    $('#scroller').css({'width': (new_body_width * count) + 'px'});

    var menu_item = $('#main_menu .row div');

    menu_item.each(function(){
    	var _self = $(this)[0];
    	var menu_item_width = _self.style.width;
        $(this).height(menu_item_width);
    });
}
