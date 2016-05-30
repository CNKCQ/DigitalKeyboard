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

