jQuery(document).ready(function(){

    "use strict";

    // Basic Wizard
    jQuery('#basicWizard').bootstrapWizard();

    // Progress Wizard
    $('#progressWizard').bootstrapWizard({
    'nextSelector': '.next',
    'previousSelector': '.previous',
    onNext: function(tab, navigation, index) {
    var $total = navigation.find('li').length;
    var $current = index+1;
    var $percent = ($current/$total) * 100;
    jQuery('#progressWizard').find('.progress-bar').css('width', $percent+'%');
    },
    onPrevious: function(tab, navigation, index) {
    var $total = navigation.find('li').length;
    var $current = index+1;
    var $percent = ($current/$total) * 100;
    jQuery('#progressWizard').find('.progress-bar').css('width', $percent+'%');
    },
    onTabShow: function(tab, navigation, index) {
    var $total = navigation.find('li').length;
    var $current = index+1;
    var $percent = ($current/$total) * 100;
    jQuery('#progressWizard').find('.progress-bar').css('width', $percent+'%');
    }
    });

    // Disabled Tab Click Wizard
    jQuery('#disabledTabWizard').bootstrapWizard({
    tabClass: 'nav nav-pills nav-justified nav-disabled-click',
    onTabClick: function(tab, navigation, index) {
    return false;
    }
    });

    // With Form Validation Wizard
    var $validator = jQuery("#firstForm").validate({
    highlight: function(element) {
    jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
    },
    success: function(element) {
    jQuery(element).closest('.form-group').removeClass('has-error');
    }
    });

    jQuery('#validationWizard').bootstrapWizard({
    tabClass: 'nav nav-pills nav-justified nav-disabled-click',
    onTabClick: function(tab, navigation, index) {
    return false;
    },
    onNext: function(tab, navigation, index) {
    var $valid = jQuery('#firstForm').valid();
    if(!$valid) {

    $validator.focusInvalid();
    return false;
    }
    }
    });

    jQuery(".select2").select2({
    width: '100%',
    minimumResultsForSearch: -1
    });


    });