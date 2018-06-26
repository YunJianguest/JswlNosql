$(function(){
	var d = new Date(),
		dateOpt = {
			lang: 'zh',
            display: 'bottom',
            startYear: d.getFullYear(),
            endYear: d.getFullYear() + 1,
            dateFormat: 'yy-mm-dd'
		};

	// $('[data-role="date"]').mobiscroll().date(dateOpt);
	$('[data-role="date"]').each(function(){
		$(this).val($.mobiscroll.datetime.formatDate('yy-mm-dd', new Date()))
			.mobiscroll().date(dateOpt);
	});

	var request = {
				size: 0,
				loadSize: 0
			};


	$('#subBtn').on('click', function(){
		request.errorStr = '';

		var _tel = $('[data-role="tel"]');

		$('.required').each(function(){
			var parent, parent1;

			if(this.tagName == 'UL'){
				parent = $(this).parents('dd').prev();
				if($('li', this).length == 1){
					// errorStr += $(this).attr('placeholder') + '</br>';
					parent.addClass('error');
				}else{
					parent.removeClass('error');
				}
			}else{
				parent1 = $(this).parent().prev();
				if(this.value == ''){
					// errorStr += this.placeholder + '</br>';
					$(this).addClass('error');
					parent1.addClass('error');
				}else{
					$(this).removeClass('error');
					parent1.removeClass('error');
				}
			}
		});

		// if(_tel.hasClass('required')){
		// 	if(_tel.val()){
		// 		if(!/1\d{10}/.test(_tel.val())){
		// 			errorStr += '手机号码格式不正确';
		// 		}
		// 	}
		// }else{
		// 	if(!/1\d{10}/.test(_tel.val())){
		// 		errorStr += '手机号码格式不正确';
		// 	}
		// }

		if($('.error').length){
			$.alert({txt: '请完善资料再提交'});
			return false;
		}

		//图片上传
		if(!request.loader){
			request.loader = new Loading();
		}else{
			request.loader.init();
		}

		var uploadCallback = function(e){
				var res = JSON.parse(e.target.responseText);

				request.loadSize ++;

                if(res.errno == 1){
                    request.errorStr += res.msg + '<br>';
                }else{
                	$(this).addClass('uploaded').data('url', res.url);
                }

                if(request.loadSize == request.size){
                	if(request.errorStr){
                		request.loader.close();
                		$.alert({txt: request.errorStr});
                	}else{
                        config.subFn(request.loader,request.size);
                    }

                }

			},
			imgUpload = function(name, file){
				var xhr = new XMLHttpRequest(),
					fd = new FormData(),
					_this = this;

				fd.append(name, file);
				xhr.open("post", config.uploadUrl, true);
				xhr.addEventListener("load", function(e){
					uploadCallback.call(_this, e);
	            }, false);

	            xhr.send(fd);
			},
			hasUpload = false;

		$('[type="file"]').each(function(){
			if(this.className == 'uploaded') return;

			if(this.files.length){
				hasUpload = true;
				request.size ++;
	            imgUpload.call(this, this.name, this.files[0]);
			}
		});
		if(!hasUpload) config.subFn(request.loader, request.size);
		return false;
	});
	
	$('#addressBox li').on('click', function(e){
		if(e.target.tagName !== 'A'){
			$(this).find('a').click();
		}
	});
	
	// 获取验证码
	(function(){
		var timeFlag;
		
		$('body').delegate('.btn1', 'click', function(){
			if(timeFlag) timeFlag = null;
			if($(this).hasClass('disabled')) return;

			var telInput = $(this).parents('ul').find('.tel'),
				_this = $(this),
				tel = telInput.val();
			var aid = $("#aid").val();
			if(/1\d{10}/.test(tel)){
				// 发送验证码...
				$.post(config.sendCodeUrl, {tel: tel,aid:aid}, function(res){
					if(res.status == 0){
						setTimer(telInput, _this);
					}else{
						alert({txt:res.data});
					}					
				}, 'json');
			}else{
				$.alert({txt: '请输入正确的手机号码'});
			}
		});

		function setTimer(telInput, button){
			var _this = this;

			var overplus = 60;

			function setTxt(time){
				button.text(time + '秒后可重新获取').addClass('disabled');
				telInput.attr('disabled', true);
			}
			function update(){
				setTxt(overplus);
				timeFlag = setTimeout(function(){
					if(overplus > 1){
						overplus --;
						setTxt(overplus);
						update();
					}else{
						button.text('获取验证码').removeClass('disabled');
						telInput.removeAttr('disabled');
					}
				}, 1000);
			}
			update();
		}

		// submit
		var htmls = '<ul class="vali_tel">'+
			'<li><input type="tel" class="txt tel" placeholder="手机" maxlength="11"></li>'+
			'<li>'+
				'<span><input class="txt code" placeholder="验证码"></span>'+
				'<span><a href="javascript:void(0);" class="btn1">获取验证码</a></span>'+
			'</li>'+
			'<li>需验证手机号码后才能查看您的历史订单</li>'+
		'</ul>';

		$('#myBtn').on('click', function(){
			var rid = $("#rid").val();
			var aid = $("#aid").val();
			if(!config.isValiTel){
				var url = this.href;

				$.confirm({txt: htmls, callback: function(){
					var el = $(this.el),
						tel = el.find('.tel').val(),
						code = el.find('.code').val();

					if(!tel){
						$.alert({txt: '手机号码不能为空'});
						return false;
					}else{
						if(!/1\d{10}/.test(tel)){
							$.alert({txt: '手机号码格式不正确'});
							return false;
						}
					}

					if(!code){
						$.alert({txt: '验证码不能为空'});
						return false;
					}

					$.post(config.subUrl, {tel: tel, code: code}, function(res){
						if(res.errno == 0){
							localStorage['tel'] = tel;
							location.href = "http://stc.weimob.com/webreserve/ReserveMyBook/aid/"+aid+"/tel/"+tel+"/rid/"+rid;
						}else{
							$.alert({txt: res.msg});
						}
					}, 'json');
					return false;
				}});

				return false;
			}else{
				var wechatid = "";
                var tel = "";
                if(localStorage['wechatid']){
                     wechatid = localStorage['wechatid'];
                }
                if(localStorage['tel']){
                     tel = localStorage['tel'];
                }
                if(wechatid=="" && tel ==""){
                     wechatid = $("#uid").val();
                     tel = $("#tel").val();
                }
                if(tel=="" && (wechatid =="" || wechatid ==0)){
                	$.alert('非法连接!');
                	return false;
                }else{
                	var url = "/webreserve/ReserveMyBook/rid/"+rid+"/aid/"+aid;
	                if(tel != ""){
	                        url += "/tel/"+tel;
	                }
	                if(wechatid != "" && wechatid!=0){
	                        url += "/wechatid/"+wechatid;
	                }
                	location.href = url;
            	}
			}
		});
	})();
});