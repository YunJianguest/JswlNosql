/**
 * Created by Administrator on 13-11-12.
 */
var form_validator = function(form_id){
    this.form_id = form_id;
    this.msg = '';

}
form_validator.prototype.validator = function(){
    var flag = 0;
    var that = this;
    $('#' + this.form_id).find('input').each(function(){
        var type = $(this).attr('data-pattern');
        if(type && type != undefined){
            var result = that.input_validator($(this), type);
            if(!result){
                flag = 1;
                return false;
            }
        }
    });
    $('#' + this.form_id).find('textarea').each(function(){
        var type = $(this).attr('data-pattern');
        if(type && type != undefined){
            var result = that.input_validator($(this), type);
            if(!result){
                flag = 1;
                return false;
            }
        }
    });
    if(flag === 1){
        return false;
    }else{
        return true;
    }
}
form_validator.prototype.input_validator = function(obj, type){
    var reg_exc = '';
    switch(type){
        case 'require':
            reg_exc = 'require';
            break;
        case 'num':
            reg_exc = /^([+-]?)\d*\.?\d+$/;
            break;
        case 'tel':
            reg_exc = /(^[0-9]{3,4}\-[0-9]{7,8}$)|(^[0-9]{7,8}$)|(^\([0-9]{3,4}\)[0-9]{3,8}$)|(^0{0,1}13|15|18[0-9]{9}$)/;
            break;
        case 'mobile':
            reg_exc = /^(13|15|18)[0-9]{9}$/;
            break;
        case 'uname':
            reg_exc = /^[\w]{4,16}$/;
            break;
        case 'pwd':
            reg_exc = /^[\w]{6,20}$/;
            break;
        case 'email':
            reg_exc = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
            break;
        default:
            reg_exc = 'require';
            break;
    }
    var input_val = $(obj).val();

    if(reg_exc === 'require'){
        if (input_val !== '') {
            return true;
        } else {
            this.msg = $(obj).attr('placeholder') + ',不能为空';
            return false;
        }
    }else{
        if(reg_exc.test(input_val)){
            return true;
        }else{
            this.msg = $(obj).attr('placeholder') + ',格式不正确';
            return false;
        }
    }
}