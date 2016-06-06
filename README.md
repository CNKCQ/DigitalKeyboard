# IDCardKeyboard
手动实现简单的生份证数字键盘
# 效果图展示
![](http://7xslr9.com1.z0.glb.clouddn.com/2016-5-30-IDCardKeyboard.gif) ![](http://7xslr9.com1.z0.glb.clouddn.com/2016-5-30-IDCardKeyboard2.gif)
# Usage
  ``` bash
  class ViewController: UIViewController,UITextFieldDelegate {
    let textField: UITextField = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blueColor()
        textField.frame = CGRectMake(80, 100, 160, 30)
        textField.borderStyle = .RoundedRect
        textField.clearButtonMode = .WhileEditing
        textField.delegate = self
        let keyboardView: KeyboardView = KeyboardView()
        keyboardView.inputTextClosure = { text in
            self.textField.text = text
        }
        textField.resignFirstResponder()
        textField.inputView = keyboardView
        textField.becomeFirstResponder()
        view.addSubview(textField)
        
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
    NSNotificationCenter.defaultCenter().postNotificationName(CLEAR_NOTIFICTION, object: nil, userInfo: nil)
        return true
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        textField.resignFirstResponder()
    }
    
}

  ```
# Keywork: Swift 2.2
