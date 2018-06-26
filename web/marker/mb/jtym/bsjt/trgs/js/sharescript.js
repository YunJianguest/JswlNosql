document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
    window.shareData = {
        "ShareImg": ShareImg,
        "ShareUrl": ShareUrl,
        "ShareTitle": ShareTitle,
        "ShareContent": ShareContent,
        "ShareType": ShareType,
        "ShareID": ShareID,
        "ShareSiteID": ShareSiteID,
        "ShareOpenID": ShareOpenID,
        "SharePostPath": '/ajax/Shard.ashx?retype=' + ShareType + '&siteid=' + ShareSiteID + '&openid=' + ShareOpenID + '&id=' + ShareID + '&url=' + escape(ShareUrl) + '&key=' + ShareTitle + '&img=' + ShareImg
    };

    // 发送给好友
    WeixinJSBridge.on('menu:share:appmessage', function (argv) {
        WeixinJSBridge.invoke('sendAppMessage', {
            "img_url": window.shareData.ShareImg,
            "img_width": "640",
            "img_height": "640",
            "link": window.shareData.ShareUrl,
            "desc": window.shareData.ShareContent,
            "title": window.shareData.ShareTitle
        }, function (res) {
            $.post(window.shareData.SharePostPath + '&to=appmessage');
        })
    });

    // 分享到朋友圈
    WeixinJSBridge.on('menu:share:timeline', function (argv) {
        WeixinJSBridge.invoke('shareTimeline', {
            "img_url": window.shareData.ShareImg,
            "img_width": "640",
            "img_height": "640",
            "link": window.shareData.ShareUrl,
            "desc": window.shareData.ShareContent,
            "title": window.shareData.ShareTitle
        }, function (res) {
            $.post(window.shareData.SharePostPath + '&to=timeline');
        });
    });

    // 分享到微博
    WeixinJSBridge.on('menu:share:weibo', function (argv) {
        WeixinJSBridge.invoke('shareWeibo', {
            "content": window.shareData.ShareContent,
            "url": window.shareData.ShareUrl,
            "img_url": window.shareData.ShareImg,
            "title": window.shareData.ShareTitle
        }, function (res) {
            $.post(window.shareData.SharePostPath + '&to=weibo');
        });
    });
}, false)
