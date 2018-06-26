/// <reference path="jquery-1.10.0.js"/*tpa=http://weixin.aduer.com/show/js/jquery-1.10.0.js*/ />
/// <reference path="jquery.mobile-1.3.1.js"/*tpa=http://weixin.aduer.com/show/js/jquery.mobile-1.3.1.js*/ />

//业务逻辑
$(document).bind('pagecreate', function (e) {
    //加载"联系我们"数据
    var url_addresslist = '/article_contact/article_contact_data/';//返回联系我们json数据，这个要更改成发布的实际路径

    var url_baidu_direction = 'http://api.map.baidu.com/direction';
    var url_baidu_marker = 'http://api.map.baidu.com/marker';

    var article_id = $('#article_id').val();

    if (article_id) {
        loadAddress(article_id);
    }


    function loadAddress(article_id) {
        //1.清空banner
        var $banner = $('.banner').html('');
        //2.清空part
        $('.part').remove();
        //3.加载数据
        $.getJSON(url_addresslist, {
            'article_id': article_id
        }, function (data) {
            if (data) {
                //获取主干信息
                if (data['is_image_sic'] == 1) {
                    $banner.append('<div wb_img="' + data['image'] + '"></div>');
                    $banner.wb_banner();
                }

                //clone
                var address_lsit = data['address'];
               
		//临时解决android问题
		var android =  navigator.userAgent.match(/Android/i);
		
                //计算距离
                if (!android && navigator && navigator.geolocation) {
                    var geo = navigator.geolocation;

                    geo.getCurrentPosition(function (pos) {
                        if (pos && pos['coords']) {
                            var coords = pos['coords'], lat1 = coords['latitude'], lng1 = coords['longitude'];
                            $.each(data['address'], function (index, item) {
                                var lat = item['lat'], lng = item['lng'];
                                address_lsit[index]['dis'] = getDistance(lat1, lng1, lat, lng);
                            });
                            address_lsit.sort(function (a, b) {
                                return (a['dis'] - b['dis']);
                            });

                        }
			showAddress();
                    }, function (a, b, c) {
                        showAddress();
                    },{enableHighAccuracy:false,maximumAge:1000,timeout:1500});

                } else {
                    showAddress();
                }

                function showAddress() {
                    //获取地址列表
                    $.each(address_lsit, function (index, item) {
                        var $part = $('<ul data-role="listview" class="part" data-inset="true"></ul>');
                        var toAddress = item['address'],
                        toName = item['name'],
                        toLng = item['lng'],
                        toLat = item['lat'],
                        toAddress = item['address'],
                        dis = item['dis'],
                        url = '';
                        if (item['name']) {
                            $part.append('<li ' + ((index == 0 && dis !== undefined) ? 'style="background:#96FF73"' : '') + ' data-role="list-divider" data-theme="c">' + item['name']+((index == 0 && dis !== undefined) ? '(最近)' : '') + '</li>');
                        }
                        else {
                            toName = toAddress;
                        }

                        url = url_baidu_marker;
                        url += '?location=' + toLat + ',' + toLng;
                        url += '&title=' + toName;
                        url += '&name=' + toName;
                        url += '&content=' + toAddress;
                        url += '&&output=html&src=weiba|weiweb';
                        var $address = $('<li class="address" address="' + item['address'] + '" name="' + (item['name'] ? item['name'] : item['address']) + '" lng="' + item['lng'] + '" lat="' + item['lat'] + '"><a data-ajax="false" href="' + url + '">' + item['address'] + '<span ' + (dis !== undefined ? 'style="display:block;" ' : '') + ' class="ui-li-count">' + (dis !== undefined ? getFriendDistance(dis) : '') + '</span></a></li>'); $part.append($address);
                        $.each(item['tels'], function (index, tel) {
                            $part.append('<li class="tel"><a href="tel:' + getTel(tel) + '">' + tel + '</a></li>');
                        });
                        $part.appendTo($banner.parent());
                        $part.listview();
                    });
                }

            } else {
                //console.log('无法解析地址数据 :-(').show();
            }
        }).fail(function (e) {
            //console.log('获取地址列表失败,请刷新页面重试 :-(').show();
        });
    }

    function getTel(tel) {
        tel += '';
        var numbers = '-0123456789', telNumber = '', spStrings = [' ', ':', '：'];
        spStrings.forEach(function (ele) {
            var spIndex = tel.indexOf(ele);
            if (spIndex > -1) {
                tel = tel.substring(spIndex + 1);
            }
        });

        if (typeof tel === 'string') {
            for (var i = 0, length = tel.length; i < length; i++) {
                var t = tel.charAt(i);
                if (numbers.indexOf(t) > -1) {
                    telNumber += t;
                }
            }
        }
        return telNumber;
    }


    function getFriendDistance(lat1, lng1, lat2, lng2) {
        var dis = 0;
        if (arguments.length == 1) {
            dis = lat1;
        } else {
            dis = getDistance(lat1, lng1, lat2, lng2);
        }
        if (dis < 1000) {
            return (dis >> 0) + 'm';
        } else {
            return ((dis / 1000) >> 0) + 'km';
        }
    }

    function getRad(d) {
        var PI = Math.PI;
        return d * PI / 180.0;
    }
    function getDistance(lat1, lng1, lat2, lng2) {
        var EARTH_RADIUS = 6378137.0;
        lat1 = lat1 * 1;
        lng1 = lng1 * 1;
        lat2 = lat2 * 1;
        lng2 = lng2 * 1;
        var f = getRad((lat1 + lat2) / 2);
        var g = getRad((lat1 - lat2) / 2);
        var l = getRad((lng1 - lng2) / 2);

        var sg = Math.sin(g);
        var sl = Math.sin(l);
        var sf = Math.sin(f);

        var s, c, w, r, d, h1, h2;
        var a = EARTH_RADIUS;
        var fl = 1 / 298.257;

        sg = sg * sg;
        sl = sl * sl;
        sf = sf * sf;

        s = sg * (1 - sl) + (1 - sf) * sl;
        c = (1 - sg) * (1 - sl) + sf * sl;

        w = Math.atan(Math.sqrt(s / c));
        r = Math.sqrt(s * c) / w;
        d = 2 * w * a;
        h1 = (3 * r - 1) / 2 / c;
        h2 = (3 * r + 1) / 2 / s;

        return d * (1 + fl * (h1 * sf * (1 - sg) - h2 * (1 - sf) * sg));
    }
});


//2.wb_banner
(function (window, $, undefined) {

    $.widget('mobile.wb_banner', $.mobile.widget, {
        options: {

        },
        refresh: function () {
            var self = this,
			$el = self.element,
            $parent = $el.parent();
            $box = $('.wb_banner-box', $el);
            list = $box.children('[wb_img]'),
            list_count = list.length;

            list.width($parent.width());
            $box.width($parent.width() * list_count).css('left', -$el.data('__currIndex') * $parent.width());
        },
        _create: function () {
            var self = this,
			$el = self.element,
            list = $el.children('[wb_img]'),
            list_count = list.length,
            $parent = $el.parent();

            $el.addClass('wb_banner');
            var boxWidth = 0, boxHeight = 0;

            var $box = $('<div class="wb_banner-box"></div>').appendTo($el);
            var $toolbar = $('<div class="wb_banner-toolbar"></div>');
            list.each(function () {
                var $this = $(this);
                $this.addClass('wb_banner-item').css({
                    'background-image': 'url(' + this.getAttribute('wb_img') + ')',
                    'width': $parent.width()
                }).html($.trim($this.html()) == '' ? '' : ('<div class="wb_banner-item-title">' + $this.html() + '</div>')).appendTo($box);

                $toolbar.append('<span class="wb_banner-toolitem"></span>');
            });

            var flganimate = false;

            $el.data('__currIndex', 0)

            $box.width($parent.width() * list_count);

            if (list_count > 1) {//超过1个图片
                //添加工具条
                $toolbar.appendTo($el);
                //绑定事件
                $el.on({
                    'swipeleft': function () {
                        if (!flganimate && $el.data('__currIndex') < (list_count - 1)) {
                            $el.data('__currIndex', $el.data('__currIndex') + 1);
                            selectedIndex($el.data('__currIndex'));
                            moveLeft(-$el.data('__currIndex') * $parent.width());
                        }
                    },
                    'swiperight': function () {
                        if (!flganimate && $el.data('__currIndex') > 0) {
                            $el.data('__currIndex', $el.data('__currIndex') - 1);
                            selectedIndex($el.data('__currIndex'));
                            moveLeft(-$el.data('__currIndex') * $parent.width());
                        }
                    }
                })
                //选中第一个
                selectedIndex($el.data('__currIndex'));
            };

            $el.on('tap', '[wb_img]', null, function () {
                var href = this.getAttribute('wb_link');
                if (href) {
                    if ($.mobile.path.isAbsoluteUrl(href)) {
                        window.location.href = href;
                    } else {
                        $.mobile.changePage(href);
                    }
                }
            });

            $(document).bind("orientationchange", function (e) {
                self.refresh();
            });


            function selectedIndex(index) {
                $($toolbar.children().removeClass('selected')[index]).addClass('selected');
            }

            function moveLeft(toLeft) {
                flganimate = true;
                $box.animate({
                    'left': toLeft + 'px'
                }, 220, 'linear', function () {
                    flganimate = false;
                });
            }
        }
    });

    $(document).bind("pagecreate", function (e) {
        return $(':jqmData(role=\'wb_banner\')', e.target).wb_banner();
    });
})(window, jQuery, undefined);

