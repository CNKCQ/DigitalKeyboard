//
//  KeyboardView.swift
//  Swiftk
//
//  Created by KingCQ on 16/5/30.
//  Copyright © 2016年 KingCQ. All rights reserved.
//


import UIKit

let marginvalue = CGFloat(0.5)
let SCREEN_WIDTH = UIScreen.main().bounds.size.width
let CLEAR_NOTIFICTION = "CLEAR_NOTIFICTION"

public class IDCardKeyboard: UIView, UITextFieldDelegate, UIInputViewAudioFeedback {
    public static let shareKeyboard: IDCardKeyboard = IDCardKeyboard()
    public var enableInputClicksWhenVisible: Bool {
        return true
    }
    var textFields = [UITextField]()
    var superView: UIView! = nil

    override init(frame: CGRect) {
        let frameH = CGFloat(224.0)
        let frame: CGRect = CGRect(x:0, y:0, width:SCREEN_WIDTH, height:frameH)
        super.init(frame: frame)
        self.backgroundColor = .lightGray()
        customSubview(frame: frame)

    }

    public func addKeyboard(view: UIView, field: UITextField?=nil) {
        superView = view
        KeyboardNotification.shareKeyboardNotification.addKeyboardNotificationForSuperView(view: superView, margin: 0)

        if field != nil {
            textFields.append(field!)
            field!.inputView = self
            field!.delegate = self
            return
        }
        for view in superView.subviews {
            if view.isKind(of: UITextField.self) {
                let textField = view as! UITextField
                textField.delegate = self
                textFields.append(textField)
                textField.inputView = self
            }
        }
    }

    private func customSubview(frame: CGRect) {
        for idx in 0...11 {
            let button = UIButton()
            button.frame = CGRect(x:CGFloat(idx%3) * (frame.width/3+marginvalue),y: CGFloat(idx/3) * (frame.height/4.0 + marginvalue), width:frame.width/3, height:frame.height/4.0)
            button.backgroundColor = .white()
            button.tag = idx
            button.setTitle("\(idx+1)", for: [])
            if idx == 9 {
                button.setTitle("x", for: [])
            }
            if idx == 10 {
                button.setTitle("0", for: [])
            }
            if idx == 11 {
                /// so https://the-nerd.be/2015/08/07/load-assets-from-bundle-resources-in-cocoapods/
                var image: UIImage?
                let podBundle = Bundle(for: self.classForCoder)
                if let bundleURL = podBundle.urlForResource("IDCardKeyboard", withExtension: "bundle") {
                    if let bundle = Bundle(url: bundleURL) {
                        image = UIImage(named: "Keyboard_Backspace", in: bundle, compatibleWith: nil)
                    } else {
                        image = UIImage(named: "Keyboard_Backspace")
                    }
                } else {
                        image = UIImage(named: "Keyboard_Backspace")
                }
                if image != nil {
                    button.setTitle("", for: [])
                    button.setImage(image, for: [])
                } else {
                    button.setTitle("del", for: [])
                }
            }
            button.setBackgroundImage(UIImage.ic_imageWithColor(color: .white()), for: [])
            button.setBackgroundImage(UIImage.ic_imageWithColor(color: .lightGray()), for: .highlighted)
            button.setTitleColor(.black(), for: [])
            button.addTarget(self, action: #selector(tap), for: .touchUpInside)
            addSubview(button)
        }
    }

    func tap(sender: UIButton) {
        if sender.tag == 11 {
            firstResponder()?.deleteBackward()
        } else {
            firstResponder()?.insertText(sender.currentTitle!)
        }
    }

    func editTextField(text: String) {
        if textFields.count == 0 {
            return
        }
        firstResponder()?.text = text
    }

    func firstResponder() -> UITextField? {
        var firstResponder: UITextField?
        for field in textFields {
            if field.isFirstResponder() {
                firstResponder = field
            }
        }
        return firstResponder
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


/*
 keyboard height
 iphone5 : 224
 iphone6 : 258
 iphone6 plus: 271
 */
