# IDCardKeyboard
手动实现简单的生份证数字键盘
# 效果图展示
![](http://7xslr9.com1.z0.glb.clouddn.com/2016-5-30-IDCardKeyboard.gif) ![](http://7xslr9.com1.z0.glb.clouddn.com/2016-5-30-IDCardKeyboard2.gif)
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
