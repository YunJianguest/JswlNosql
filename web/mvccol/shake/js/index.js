document.body.addEventListener("touchstart",function(e){
	e.preventDefault();
	e.target.click();
}, false);
function ShakeHandler(callback,threshold){
	callback._threshold = threshold || 800;
	if(ShakeHandler._inited){
		callbacks.push(callback);
		return;
	}
	if (!window.DeviceMotionEvent) {
		alert('本设备不支持 devicemotion 事件');
		return;
	}
	ShakeHandler._inited = true;
	var callbacks = [];

	var last_update = 0;
	var x = y = z = last_x = last_y = last_z = 0;
	window.addEventListener('devicemotion',function(eventData) {
		var acceleration = eventData.accelerationIncludingGravity;
		var curTime = new Date().getTime();

		if ((curTime - last_update) > 100) {
			var diffTime = curTime - last_update;
			last_update = curTime;
			x = acceleration.x;
			y = acceleration.y;
			z = acceleration.z;
			var speed = Math.abs(x + y + z - last_x - last_y - last_z) / diffTime * 10000;
			for(var n in callbacks){
				if (speed > callbacks[n]._threshold) {
					callbacks[n]();
				}
			}
			last_x = x;
			last_y = y;
			last_z = z;
		}
	});
	callbacks.push(callback);
}