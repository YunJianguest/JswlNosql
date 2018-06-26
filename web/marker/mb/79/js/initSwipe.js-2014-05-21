// swipe
$(function(){
	var swipeAry = [],
		btnAry = [];

	$('.file_btn').each(function(i){
		btnAry[i] = $(this).parents('li');
	});

	function swipeCallback(obj, index){
		obj.find('.swipe_num span').eq(index).addClass('on').siblings().removeClass('on');
	}

	$('.upload_wrap').each(function(i){
		var _parent = $(this);

		_parent.delegate('.upload_img', 'click', function(e){
			if($(this).find('.file_btn').length) return;
			if(_parent.hasClass('swipe')) return;

			var iIndex = $(this).parent().index();

			if(!swipeAry[i]){
				swipeAry[i] = new Swipe(_parent[0], {
					cur: iIndex,
					dir: 'horizontal',
					getSlides: function(){
						var li = [].slice.apply(this.el.querySelectorAll('li')),
							i = 0;
						for(; i < li.length; i++){
							if(li[i].querySelectorAll('.file_btn').length){
								li.splice(i, 1);
							}
						}

						return li;
					},
					callback: function(index){
						swipeCallback(_parent, index);	
					}
				});
			}else{
				swipeAry[i].cur = iIndex;
				swipeAry[i].init();
			}
			swipeCallback(_parent, iIndex);

			_parent.addClass('swipe');
			$('.fixed').addClass('hide_fixed');
		}).delegate('.del_btn', 'click', function(){
			var _parent = $(this).parents('li'),
				_root = $(this).parents('.swipe'),
				length = _parent.parent().find('li').length,
				index = _parent.index(),
				uploadIndex = $('.file_btn').index(_root.parent().find('.file_btn')), 
				cur = index > $(this).parents('ul').find('li').length - 3 ? 0 : index;

			$.confirm({txt: '你确定要删除该图片吗？', callback: function(){
				// $.get(config.deleteUrl, {imgId: _parent.attr('imgId')}, function(res){
					
				btnAry[i].show();
				_parent.remove();
				_root.find('.swipe_num span').eq(index).remove();

				if(typeof uploadAry !== 'undefined'){
					uploadAry[uploadIndex].fileIndex --;
					uploadAry[uploadIndex].isHideInput();
				}

				//如果只有1张图片删除
				if(length == 2){
					_root.find('.swipe_close').click();
				}else{
					swipeAry[i].stop();
					swipeAry[i].cur = cur;
					swipeAry[i].init();
					swipeCallback(_root, cur);
				}


				// }, 'json');
			}});
		}).delegate('input', 'change', function(){
			var item = $(this).parents('li').clone(),
			file = this.files[0],
				_parent = $(this).parents('.upload_wrap');

			if(file.size / 1024 > 3072){
				$.alert({txt: '所选文件太大，不能超过3M'});
				return;
			}

			_parent.find('.file_btn').css('background-image', 'url('+ webkitURL.createObjectURL(file) +')').removeClass('file_btn');

			_parent.find('.swipe_num').append('<span></span>');

			btnAry[i] = item.appendTo(_parent.find('ul'));

			if(_parent.find('li').length > 5){
				btnAry[i].hide();
			}
		});

		_parent.find('.swipe_close').on('click', function(){
			swipeAry[i].stop();
			_parent.removeClass('swipe');
			$('.fixed').removeClass('hide_fixed');
		});

		//如果不支持预览
		if(!window.URL && !window.webkitURL){
			var _p = _parent.parent();
			_p.prev().remove();
			_p.remove();
		}
	});
});