(function($) {
     var defaults = {
        text:"提示",
        color:"black",
        time:"2000", 
    };
    var methods = {
        init: function(options) {
            // this
        },
        show: function(options) {
            // is   
            if(typeof(options.text)!="undefined"){
                defaults.text=options.text; 
            }
            if(typeof(options.color)!="undefined"){
                defaults.color=options.color; 
            }
            if(typeof(options.time)!="undefined"){
                defaults.time=options.time; 
            }
            var  html='<div class="position-f width-10" style="bottom:100px;left:0px;" id="tx">'
                     +'<div class="zi-bai txt-c line-height25">'
                     +'<i class="bg-hei-5 div-group-10 border-radius5 line-height25">'+options.text+'</i>'
                     +'</div></div>';  
                   $(this).append(html); 
                   setTimeout(function(){ 
                    $('#tx').remove(); 
                   },defaults.time); 

        },
        hide: function() {
            // good
        },
        update: function(content) {
            // !!!
        }
    };
    $.fn.showTxt= function(method) {
        // 方法调用
        if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        } else {
            $.error('Method' + method + 'does not exist on jQuery.tooltip');
        }
    };
})(jQuery); 