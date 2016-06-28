
# IDCardKeyboard
[![CI Status](http://img.shields.io/travis/kishikawakatsumi/IDCardKeyboard.svg?style=flat)](https://travis-ci.org/kishikawakatsumi/IDCardKeyboard)
[![Version](https://img.shields.io/cocoapods/v/IDCardKeyboard.svg?style=flat)](http://cocoadocs.org/docsets/IDCardKeyboard)
[![Platform](https://img.shields.io/cocoapods/p/IDCardKeyboard.svg?style=flat)](http://cocoadocs.org/docsets/IDCardKeyboard)
![](https://camo.githubusercontent.com/7d97f558ccb8751e27fa65eeee94047955eba100/68747470733a2f2f63646e2d696d616765732d312e6d656469756d2e636f6d2f6d61782f313630302f312a7861666332716159644d375a4f68655957614d6d51412e706e67)
# IDCardKeyboard
A custom digital keyboard for idcard
##### :eyes: See also:
![](http://7xslr9.com1.z0.glb.clouddn.com/IDCardKeyboard.gif) 
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
    pod 'IDCardKeyboard', '~> 1.0.8'
end
```

Then, run the following command:

```bash
$ pod install
```

## :book: Usage
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
        
        textField.idcardKeyboard(view)//一句代码搞定数字键盘

        
    }
    
  
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            UIApplication.sharedApplication().keyWindow?.endEditing(true)
    }
    
}

  ```
  :key: Basics  Swift 3.0, Swift2.2
