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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blueColor()
        textField.frame = CGRect(x: 80, y: 400, width: 160, height: 30)
        textField.borderStyle = .RoundedRect
        textField.clearButtonMode = .WhileEditing
        textField.becomeFirstResponder()
        view.addSubview(textField)
        textField.keyboardType = .DecimalPad
        fieldNext.frame = CGRect(x: 80, y: 500, width: 160, height: 30)
        fieldNext.borderStyle = .RoundedRect
        fieldNext.placeholder = "nextField"

        view .addSubview(fieldNext)
        textField.becomeFirstResponder()
        textField.idcardKeyboard(view)//一句代码搞定数字键盘
        fieldNext.idcardKeyboard(view)

    }


    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            UIApplication.sharedApplication().keyWindow?.endEditing(true)
    }

}
