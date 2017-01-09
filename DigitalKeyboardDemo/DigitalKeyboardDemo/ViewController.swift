//
//  ViewController.swift
//  DigitalKeyboardDemo
//
//  Created by Jack on 16/9/15.
//  Copyright © 2016年 Jack. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .orange
        let textField = UITextField(frame: CGRect(x: 100, y: 120, width: 200, height: 35))
        textField.borderStyle = .roundedRect
        view.addSubview(textField)
        DigitalKeyboard.default.addKeyboard(view, field: textField)
        textField.becomeFirstResponder()
//        let keyboard = DigitalKeyboard(view: view)
//        keyboard.style = .number
//        keyboard.customDoneButton(title: "hello", titleColor: .blue, theme: .green, target: self, callback: #selector(test))
//        keyboard.isSafety = true
//        textField.inputView = keyboard
//        textField.becomeFirstResponder()
    }
    
    func test() {
        print("hello ok")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

