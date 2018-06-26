/*
 * Translated default messages for the jQuery validation plugin.
 * Language: CN
 * Author: gaojt by 2010-07-11
 */
jQuery.extend(jQuery.validator.messages, {
        required: "必输项",
		remote: "输入信息已存在",
		email: "请输入正确格式的电子邮件",
		url: "请输入合法的日期",
		date: "请输入合法的日期",
		dateISO: "(请输入合法的日期 (ISO)",
		number: "请输入合法的数字",
		digits: "只能输入整数",
		creditcard: "请输入合法的信用卡号",
		equalTo: "请再次输入相同的值",
		ignoreCaseEqualTo: "忽略大小写请再次输入相同的值",
		accept: "请输入拥有合法后缀名的字符串",
		maxlength: jQuery.format("请输入一个长度最多是 {0} 的字符串"),
		minlength: jQuery.format("请输入一个长度最少是 {0} 的字符串"),
		rangelength: jQuery.format("长度介于 {0} 和 {1} 之间"),
		range: jQuery.format("请输入一个介于 {0} 和 {1} 之间的值"),
		max: jQuery.format("请输入一个最大为 {0} 的值"),
		min: jQuery.format("请输入一个最小为 {0} 的值"),
		alpha: jQuery.format("请输入字母"),
		alphanum: jQuery.format("请输入字母或数字"),
		isFloat: jQuery.format("请输入浮点数"),
		isIdCardNo:jQuery.format("请正确输入您的身份证号码"),
		isTel:jQuery.format("请正确输入您的电话号码 (029-12345678 或 029-12345678-1234)"),
		isMobile:jQuery.format("请正确输入您的手机号码"),
		isPhone:jQuery.format("请正确输入您的手机或座机号码"),
		isZipCode:jQuery.format("请正确输入您的邮政编码"),
		dateAndTime:jQuery.format("格式为yyyy-MM-dd HH:mm:ss"),
		stringMinLength:"长度不能小于{0}字节",
		stringMaxLength:"长度不能大于{0}字节",
		stringCheck:"只能包括中文字、英文字母、数字和下划线",
		begin:"必须以 {0} 开头",
		notEqualTo:"两次输入不能相同",
		notEqual:"输入值不允许为{0}",
		gt:"输入值必须大于{0}",
		selectNone:"请选择一项",
		isnumberPlate:jQuery.format("请输入合法的车牌号"),
		isLessThanCurrentDate:jQuery.format("请输入早于当前日期的日期")
});