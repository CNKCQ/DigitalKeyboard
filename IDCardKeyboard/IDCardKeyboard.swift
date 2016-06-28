//
//  KeyboardView.swift
//  Swiftk
//
//  Created by KingCQ on 16/5/30.
//  Copyright © 2016年 KingCQ. All rights reserved.
//

import DeviceKit
import UIKit

let marginvalue = CGFloat(0.5)
let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
let CLEAR_NOTIFICTION = "CLEAR_NOTIFICTION"

public class IDCardKeyboard: UIView, UITextFieldDelegate, UIInputViewAudioFeedback {
    public static let shareKeyboard: IDCardKeyboard = IDCardKeyboard()
    public var enableInputClicksWhenVisible: Bool {
        return true
    }
    var textFields = [UITextField]()
    var superView: UIView! = nil

    override init(frame: CGRect) {
        var frameH = CGFloat(224.0)
        switch Device() {
        case .iPhone4, .iPhone4s:
            frameH = CGFloat(209.0)
        case .iPhone5, .iPhone5s, .iPhone5c:
            frameH = CGFloat(224.0)
        case .iPhone6, .iPhone6s:
            frameH = CGFloat(258.0)
        case .iPhone6Plus, .iPhone6sPlus:
            frameH = CGFloat(271.0)
        default:
            break
        }

        let frame: CGRect = CGRectMake(0, 0, SCREEN_WIDTH, frameH)
        super.init(frame: frame)
        self.backgroundColor = .lightGrayColor()
        customSubview(frame)

    }

    public func addKeyboard(view: UIView, field: UITextField?=nil) {
        superView = view
        KeyboardNotification.shareKeyboardNotification.addKeyboardNotificationForSuperView(superView, margin: 0)

        if field != nil {
            textFields.append(field!)
            field!.inputView = self
            field!.delegate = self
            return
        }
        for view in superView.subviews {
            if view.isKindOfClass(UITextField) {
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
            button.frame = CGRectMake(CGFloat(idx%3) * (frame.width/3+marginvalue), CGFloat(idx/3) * (frame.height/4.0 + marginvalue), frame.width/3, frame.height/4.0)
            button.titleLabel?.font = UIFont.systemFontOfSize(28)
            button.backgroundColor = .whiteColor()
            button.tag = idx
            button.setTitle("\(idx+1)", forState: .Normal)
            if idx == 9 {
                button.setTitle("x", forState: .Normal)
            }
            if idx == 10 {
                button.setTitle("0", forState: .Normal)
            }
            if idx == 11 {
                /// so https://the-nerd.be/2015/08/07/load-assets-from-bundle-resources-in-cocoapods/
                var image: UIImage?
                let podBundle = NSBundle(forClass: self.classForCoder)
                if let bundleURL = podBundle.URLForResource("IDCardKeyboard", withExtension: "bundle") {
                    if let bundle = NSBundle(URL: bundleURL) {
                        image = UIImage(named: "Keyboard_Backspace", inBundle: bundle, compatibleWithTraitCollection: nil)
                    } else {
                        image = UIImage(named: "Keyboard_Backspace")
                    }
                } else {
                        image = UIImage(named: "Keyboard_Backspace")
                }
                if image != nil {
                    button.setTitle("", forState: .Normal)
                    button.setImage(image, forState: .Normal)
                } else {
                    button.setTitle("del", forState: .Normal)
                }
            }
            button.setBackgroundImage(UIImage.ic_imageWithColor(.whiteColor()), forState: .Normal)
            button.setBackgroundImage(UIImage.ic_imageWithColor(.lightGrayColor()), forState: .Highlighted)
            button.setTitleColor(.blackColor(), forState: .Normal)
            button.addTarget(self, action: #selector(tap(_:)), forControlEvents: .TouchUpInside)
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
