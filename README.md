
# DigitalKeyboard
[![CI Status](https://img.shields.io/travis/CNKCQ/IDCardKeyboard.svg?style=flat)](https://travis-ci.org/CNKCQ/DigitalKeyboard)
[![Version](https://img.shields.io/cocoapods/v/IDCardKeyboard.svg?style=flat)](http://cocoadocs.org/docsets/IDCardKeyboard)
[![Platform](https://img.shields.io/cocoapods/p/IDCardKeyboard.svg?style=flat)](http://cocoadocs.org/docsets/IDCardKeyboard)
![](https://camo.githubusercontent.com/7d97f558ccb8751e27fa65eeee94047955eba100/68747470733a2f2f63646e2d696d616765732d312e6d656469756d2e636f6d2f6d61782f313630302f312a7861666332716159644d375a4f68655957614d6d51412e706e67)
# DigitalKeyboard
A custom digital keyboard for idcard
##### :eyes: See also:
![dititalkeyboard_display](https://cloud.githubusercontent.com/assets/8440220/18740685/8f6b6824-80dd-11e6-99a7-6a8a76152bab.gif)
![](http://7xslr9.com1.z0.glb.clouddn.com/IDKeyboard_id.gif)
### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 0.39.0+ is required to build IDCardKeyboard 3.0.0+.

To integrate IDCardKeyboard into your Xcode project using CocoaPods, specify it in your `Podfile`:

Swift 2.2：
```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'IDCardKeyboard', '~> 1.0.8'
end
```
Swift 2.3:
```ruby
    pod 'IDCardKeyboard', :git => 'https://github.com/CNKCQ/DigitalKeyboard.git', :branch => 'Swift2.3'
```
Swift 3.0：
```ruby
    pod 'DigitalKeyboard'
```


Then, run the following command:

```bash
$ pod install
```
### Carthage
```bash
    github "CNKCQ/DigitalKeyboard"   
```


## :book: Usage
  ``` bash
import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.orange
        let textField = UITextField(frame: CGRect(x: 100, y: 120, width: 200, height: 35))
        textField.borderStyle = .roundedRect
        view.addSubview(textField)
        let keyboard = DigitalKeyboard(view: view)
        keyboard.style = .Number
        keyboard.customDoneButton(title: "hello", titleColor: UIColor.blue, theme: UIColor.green)
        textField.inputView = keyboard
        textField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

  ```
   :key: Basics  Swift 2.2、Swift 3.0
