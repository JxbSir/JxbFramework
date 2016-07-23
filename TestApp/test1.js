require('UIView, UIColor, UILabel')

defineClass('ViewController', {
    viewDidLoad: function() {
        self.ORIGviewDidLoad();
        self.view().setBackgroundColor(UIColor.greenColor());
    }
});