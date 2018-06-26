(function(){
	function Message(type){
		this.type = type || 'alert';
	}
	Message.prototype = {
		init: function(opts){
			var _this = this,
				callback = opts.callback || function(){};

			this.mask = typeof opts.mask === 'undefined' ? true : opts.mask;
			this.txt = opts.txt;
			this.okTxt = opts.okTxt || '确定';

			this.el = $(this.tpl()).appendTo('body');

			// 修复iPhone4 ios7.0.4下，input和textarea穿透问题
			$('body').on('click.disabled', function(e){
				//判断点击区域是否在dialog内
				if(!$(e.target).parents('.message_box').length){
					return false;
				}
			});

			this.el.find('.cancle').click(function(){
				_this.close.call(_this);
			});			

			this.el.find('.ok').click(function(){
				var c = callback.call(_this);
				
				if(c === false) return;
				_this.close.call(_this);
			});
		},
		tpl: function(){
			var cancleStr = this.type == 'confirm' ? '<a href="javascript:void(0);" class="cancle border_dark b_right">取消</a>' : '',
				htmls = '<div class="message_box'+ (this.mask ? ' mask' : '') +'">'+
					'<div>'+
						'<div class="text">'+ this.txt +'</div>'+
						'<div class="btns border_dark b_top">'+
							cancleStr +
							'<a href="javascript:void(0);" class="ok">'+ this.okTxt +'</a>'+
						'</div>'+
					'</div>'+
				'</div>';
			return htmls;
		},
		close: function(obj){
			$('body').off('.disabled');
			this.el.remove();
		}
	}

	$.alert = function(opts){
		new Message('alert').init(opts);
	}
	$.confirm = function(opts){
		new Message('confirm').init(opts);
	}

	function Loading(){
		this.init();
	}
	Loading.prototype = {
		init: function(){
			this.el = $('<div class="loading"><span></span></div>').appendTo($('body'));
		},
		close: function(){
			this.el.remove();
		}
	}

	window.Loading = Loading;
})();