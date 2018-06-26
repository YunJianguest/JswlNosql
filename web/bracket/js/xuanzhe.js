jQuery(document).ready(function(){

    "use strict";

    // Tags Input
    jQuery('#tags').tagsInput({width:'auto'});

    // Select2
    jQuery(".select2").select2({
    width: '100%'
    });

    // Textarea Autogrow
    jQuery('#autoResizeTA').autogrow();

    // Color Picker
    if(jQuery('#colorpicker').length > 0) {
    jQuery('#colorSelector').ColorPicker({
    onShow: function (colpkr) {
    jQuery(colpkr).fadeIn(500);
    return false;
    },
    onHide: function (colpkr) {
    jQuery(colpkr).fadeOut(500);
    return false;
    },
    onChange: function (hsb, hex, rgb) {
    jQuery('#colorSelector span').css('backgroundColor', '#' + hex);
    jQuery('#colorpicker').val('#'+hex);
    }
    });
    }

    // Color Picker Flat Mode
    jQuery('#colorpickerholder').ColorPicker({
    flat: true,
    onChange: function (hsb, hex, rgb) {
    jQuery('#colorpicker3').val('#'+hex);
    }
    });

    // Date Picker
    jQuery('#datepicker').datepicker();

    jQuery('#datepicker-inline').datepicker();

    jQuery('#datepicker-multiple').datepicker({
    numberOfMonths: 3,
    showButtonPanel: true
    });

    // Spinner
    var spinner = jQuery('#spinner').spinner();
    spinner.spinner('value', 0);

    // Input Masks
    jQuery("#date").mask("99/99/9999");
    jQuery("#phone").mask("(999) 999-9999");
    jQuery("#ssn").mask("999-99-9999");

    // Time Picker
    jQuery('#timepicker').timepicker({defaultTIme: false});
    jQuery('#timepicker2').timepicker({showMeridian: false});
    jQuery('#timepicker3').timepicker({minuteStep: 15});


    });
