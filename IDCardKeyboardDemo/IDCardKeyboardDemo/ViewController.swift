//
//  ViewController.swift
//  IDCardKeyboard
//
//  Created by KingCQ on 16/5/30.
//  Copyright © 2016年 KingCQ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let textField: UITextField = UITextField()
    let fieldNext: UITextField = UITextField()
    var fields: [UITextField] = []


    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .orangeColor()
        textField.frame = CGRect(x: 80, y: 400, width: 200, height: 30)
        textField.borderStyle = .RoundedRect
        textField.clearButtonMode = .WhileEditing
        textField.becomeFirstResponder()
        view.addSubview(textField)
        fieldNext.frame = CGRect(x: 80, y: 500, width: 200, height: 30)
        fieldNext.borderStyle = .RoundedRect
        fieldNext.placeholder = "nextField"
        view.addSubview(fieldNext)
        textField.becomeFirstResponder()
        let keyboard = IDCardKeyboard(frame: CGRect.zero, inputViewStyle: .Keyboard)
        keyboard.style = .Number
        keyboard.addKeyboard(view)
        textField.inputView = keyboard//一句代码搞定数字键盘
        fieldNext.idcardKeyboard(view)

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }


    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            UIApplication.sharedApplication().keyWindow?.endEditing(true)
    }


}
