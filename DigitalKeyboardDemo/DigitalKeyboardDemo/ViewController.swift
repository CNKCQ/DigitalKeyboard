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
        view.backgroundColor = UIColor.orange
        let textField = UITextField(frame: CGRect(x: 100, y: 120, width: 200, height: 35))
        textField.borderStyle = .roundedRect
        view.addSubview(textField)
        let keyboard = DigitalKeyboard(view: view)
        keyboard.style = .Number
        keyboard.customDoneButton(title: "hello", titleColor: UIColor.blue, theme: UIColor.green, target: self, callback: #selector(test))
        keyboard.isSafety = false
        textField.inputView = keyboard
        textField.becomeFirstResponder()
    }
    
    func test() {
        print("hello ok")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

