//
//  ViewController.swift
//  IDCardKeyboard
//
//  Created by KingCQ on 16/5/30.
//  Copyright © 2016年 KingCQ. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    let textField: UITextField = UITextField()
    let fieldNext: UITextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .blueColor()
        textField.frame = CGRectMake(80, 400, 160, 30)
        textField.borderStyle = .RoundedRect
        textField.clearButtonMode = .WhileEditing
        textField.delegate = self
        textField.becomeFirstResponder()
        view.addSubview(textField)
        
        fieldNext.frame = CGRectMake(80, 500, 160, 30)
        fieldNext.borderStyle = .RoundedRect
        fieldNext.placeholder = "nextField"
        fieldNext.delegate = self
        view .addSubview(fieldNext)
        
        KeyboardView.shareKeyboard.addKeyboard(view)//一句代码搞定数字键盘

        
    }
    
  
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            UIApplication.sharedApplication().keyWindow?.endEditing(true)
    }
    
}

