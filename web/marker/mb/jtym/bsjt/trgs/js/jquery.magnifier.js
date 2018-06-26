//图文内容放大的通用方法,调用的时候传入需要放大区域的元素绑定.img_magnifier()方法即可;
//为了使界面对用户友好,需要用一个div把body内的所有内容包括进去,这个div使用jquery生成;
//demo  $(".content").img_magnifier();
(function (factory) {
    if (typeof define === "function" && define.amd) {
        // AMD模式
        define(["jquery"], factory);
    } else {
        // 全局模式
        factory(jQuery);
    }
} (function ($) {
    $.fn.img_magnifier = function () {
        var img = this.find("img");
        var cre = function () {
            $("body").children().wrapAll("<div id=\"_mask\"></div>")
            $("body").append("<div class=\"magnfier_container\"><\/div>");
            $(".magnfier_container").css({
                "position": "absolute",
                "width": "100%",
                "height": "100%",
                "top": "0px",
                "left": "0px",
                "opacity": "0",
                "display": "none",
                "background-color": "#000",
                "background-repeat": "no-repeat",
                "background-position": "center",
                "background-size": "contain",
                "z-index": "2147483584"
            });
        };
        cre();
        var imgset = function () {
            $(".magnfier_container").bind("click", function () {
                $(".magnfier_container").animate({
                    "opacity": 0
                }, 300, function () {
                    $(".magnfier_container").css({
                        "display": "none"
                    });
                });
                $("#_mask").css({
                    "display": "block"
                });
                $("body").off("click", ".magnfier_container");
            });
        };
        var magnifier = function (src) {
            $(".magnfier_container").css({
                "display": "block",
                "background-image": "url(" + src + ")"
            }).animate({
                "opacity": "1"
            }, 500, function () {
                $("#_mask").css({
                    "display": "none"
                });
            });

        };
        img.click(function () {
            var src = this.src;
            magnifier(src);
            imgset();
        });
    };
}));