# IDCardKeyboard
手动实现简单的生份证数字键盘
# 效果图展示
![](http://7xslr9.com1.z0.glb.clouddn.com/2016-5-30-IDCardKeyboard.gif) ![](http://7xslr9.com1.z0.glb.clouddn.com/2016-5-30-IDCardKeyboard2.gif)
### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 0.39.0+ is required to build IDCardKeyboard 3.0.0+.

To integrate IDCardKeyboard into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'IDCardKeyboard', '~> 1.0.2'
end
```

Then, run the following command:

```bash
$ pod install
```

# Usage
  ``` bash
  class ViewController: UIViewController {
    let textField: UITextField = UITextField()
    let fieldNext: UITextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .blueColor()
        textField.frame = CGRectMake(80, 400, 160, 30)
        textField.borderStyle = .RoundedRect
        textField.clearButtonMode = .WhileEditing
        textField.becomeFirstResponder()
        view.addSubview(textField)
        
        fieldNext.frame = CGRectMake(80, 500, 160, 30)
        fieldNext.borderStyle = .RoundedRect
        fieldNext.placeholder = "nextField"
        view .addSubview(fieldNext)
        
        KeyboardView.shareKeyboard.addKeyboard(view)//一句代码搞定数字键盘

        
    }
    
  
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            UIApplication.sharedApplication().keyWindow?.endEditing(true)
    }
    
}

  ```
# Keywork: Swift 2.2
