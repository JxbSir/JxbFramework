require('UIView, UIColor, UIAlertView')

defineClass('ViewController', {
    tapAction: function() {
        UIAlertView.alloc().initWithTitle_message_delegate_cancelButtonTitle_otherButtonTitles("11", "22", null, "33", "44", null).show();
    }
});
