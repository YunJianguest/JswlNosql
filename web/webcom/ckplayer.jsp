<%@ page contentType="text/html;charset=UTF-8"%>
<div id="a1"></div>
<script type="text/javascript" src="${ctx }/ckplayer/ckplayer/ckplayer.js" charset="utf-8"></script>
<script type="text/javascript"> 
	var flashvars={ 
    c:0,
    p:1, 
		};
	var video=['${ctx }/video/video.mp4'];
	var support=['all'];
	CKobject.embedHTML5('a1','${ctx }/ckplayer/ckplayer_a1',315,200,video,flashvars,support);
</script>
 