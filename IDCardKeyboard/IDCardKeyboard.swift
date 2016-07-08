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

enum KeyboardStyle {
    case IDCard
    case Number
}

public class IDCardKeyboard: UIInputView, UITextFieldDelegate, UIInputViewAudioFeedback {
    public static let shareKeyboard: IDCardKeyboard = IDCardKeyboard(frame: CGRect(x:0, y:0, width: SCREEN_WIDTH, height: 224), inputViewStyle: .Keyboard)
    public var enableInputClicksWhenVisible: Bool {
        return true
    }
    var textFields = [UITextField]()
    var superView: UIView! = nil
    var style = KeyboardStyle.IDCard


    override init(frame: CGRect, inputViewStyle: UIInputViewStyle) {
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
        super.init(frame: CGRectMake(0, 0, SCREEN_WIDTH, frameH), inputViewStyle: inputViewStyle)
        self.backgroundColor = .lightGrayColor()
        customSubview()
    }

    public func addKeyboard(view: UIView, field: UITextField?=nil) {
        superView = view
//        KeyboardNotification.shareKeyboardNotification.addKeyboardNotificationForSuperView(superView, margin: 0)

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

    private func customSubview() {
        for idx in 0...13 {
            let button = UIButton()
            button.titleLabel?.font = UIFont.systemFontOfSize(28)
            button.backgroundColor = .whiteColor()
            button.tag = idx
            /// so https://the-nerd.be/2015/08/07/load-assets-from-bundle-resources-in-cocoapods/
            var backSpace: UIImage?
            var dismiss: UIImage?
            let podBundle = NSBundle(forClass: self.classForCoder)
            if let bundleURL = podBundle.URLForResource("IDCardKeyboard", withExtension: "bundle") {
                if let bundle = NSBundle(URL: bundleURL) {
                    backSpace = UIImage(named: "Keyboard_Backspace", inBundle: bundle, compatibleWithTraitCollection: nil)
                    dismiss =  UIImage(named: "Keyboard_DismissKey", inBundle: bundle, compatibleWithTraitCollection: nil)
                } else {
                    backSpace = UIImage(named: "Keyboard_Backspace")
                    dismiss = UIImage(named: "Keyboard_DismissKey")
                }
            } else {
                backSpace = UIImage(named: "Keyboard_Backspace")
                dismiss = UIImage(named: "Keyboard_DismissKey")
            }
            button.setBackgroundImage(UIImage.ic_imageWithColor(.whiteColor()), forState: .Normal)
            button.setBackgroundImage(UIImage.ic_imageWithColor(.lightGrayColor()), forState: .Highlighted)
            button.setTitleColor(.blackColor(), forState: .Normal)
            switch idx {
            case 9:
                button.setTitle(" ", forState: .Normal)
                button.setImage(dismiss, forState: .Normal)
            case 10:
                button.setTitle("0", forState: .Normal)
            case 11:
                switch style {
                case .IDCard:
                    button.setTitle("X", forState: .Normal)
                case .Number:
                    button.setTitle(".", forState: .Normal)
                }
            case 12:
                    button.setTitle("", forState: .Normal)
                    button.setImage(backSpace, forState: .Normal)
            case 13:
                if backSpace != nil {
                    button.titleLabel?.font = UIFont.systemFontOfSize(17)
                    button.setTitle("Done", forState: .Normal)
                    button.backgroundColor = UIColor(red: 28/255, green: 171/255, blue: 235/255, alpha: 1)
                    button.setTitleColor(.whiteColor(), forState: .Normal)
                    button.setBackgroundImage(nil, forState: .Normal)
                    button.setBackgroundImage(nil, forState: .Highlighted)
                }

            default:
                button.setTitle("\(idx+1)", forState: .Normal)
            }
            button.addTarget(self, action: #selector(tap(_:)), forControlEvents: .TouchUpInside)
            addSubview(button)
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
            for view in subviews {
            if view .isKindOfClass(UIButton) {
                let width = frame.width / 4 * 3
                let idx = view.tag
                if idx >= 12 {
                    view.frame = CGRectMake(width + marginvalue, CGFloat((idx-12)%2) * (frame.height/2.0 + marginvalue), frame.width/4, (frame.height - marginvalue)/2.0)
                } else {
                    view.frame = CGRectMake(CGFloat(idx%3) * ((width - 2*marginvalue)/3+marginvalue), CGFloat(idx/3) * (frame.height/4.0 + marginvalue), (width - 2*marginvalue)/3, frame.height/4.0)
                }
            }
        }
    }

    func tap(sender: UIButton) {
        switch sender.tag {
        case 12:
            firstResponder()?.deleteBackward()
        case 13, 9:
            firstResponder()?.resignFirstResponder()
        default:
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
