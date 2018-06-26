var playbox = (function(){
	//author:eric_wu
	//http://tool.chinaz.com/js.aspx
	var _playbox = function(){
		var that = this;
		that.box = null;
		that.player = null;
		that.src = null;
		that.on = true;
		//
		that.autoPlayFix = {
			on: true,
			evtName: ("ontouchstart" in window)?"touchend":"click"
		}

	}
	_playbox.prototype = {
		init: function(box_ele){
			
			this.box = "string" === typeof(box_ele)?document.getElementById(box_ele):box_ele;
			this.player = this.box.nextSibling;
			if(this.player.nodeType == 3) this.player = this.player.nextSibling;
			this.src = this.player.src;
			this.init = function(){return this;}
			this.autoPlayEvt(true);
			this.player.play();
			return this;
		},
		play: function(){
			if(this.autoPlayFix.on){
				this.autoPlayFix.on = false;
				this.autoPlayEvt(false);
			}
			this.on = !this.on;
			if(true == this.on){
				this.player.src = this.src;
				this.player.play();
			}else{
				this.player.pause();
				// this.player.src = null;
			}
			if("function" == typeof(this.play_fn)){
				this.play_fn.call(this);
			}
		},
		handleEvent: function(evt){
			if(evt.target == this.box){return;}
			this.play();
		},
		autoPlayEvt: function(important){
			if(important || this.autoPlayFix.on){
				document.body.addEventListener(this.autoPlayFix.evtName, this, false);
			}else{
				document.body.removeEventListener(this.autoPlayFix.evtName, this, false);
			}
		}
	}
	//
	return new _playbox();
})();

playbox.play_fn = function(){
	this.box.className = this.on?"btn_music on":"btn_music";
}