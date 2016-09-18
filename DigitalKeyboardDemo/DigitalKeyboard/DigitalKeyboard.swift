//
//  DigitalKeyboard.swift
//  KeyBoard
//
//  Created by Jack on 16/9/15.
//  Copyright © 2016年 Jack. All rights reserved.
//

import UIKit
private let marginvalue = CGFloat(0.5)
private let screenWith = UIScreen.main.bounds.size.width
private let defaultDoneColor = UIColor(red: 28/255, green: 171/255, blue: 235/255, alpha: 1)

public enum KeyboardStyle {
    case IDCard
    case Number
}

public class  DigitalKeyboard: UIInputView, UITextFieldDelegate {
    
    public var style = KeyboardStyle.IDCard {
        didSet {
            setDigitButton(style: style)
        }
    }
    
    public var shouldHighlight = true {
        didSet {
            highlight(heghlight: shouldHighlight)
        }
    }
    
    public func customDoneButton(title: String, titleColor: UIColor = UIColor.white, theme: UIColor = defaultDoneColor) {
        setDoneButton(title: title, titleColor: titleColor, theme: theme)
    }

    
    private var textFields = [UITextField]()
    private var superView: UIView? = nil
    
    public convenience init(view: UIView, field: UITextField?=nil) {
        self.init(frame: CGRect.zero, inputViewStyle: .keyboard)
        addKeyboard(view: view, field: field)
    }
    
    private override init(frame: CGRect, inputViewStyle: UIInputViewStyle) {
        let frameH = CGFloat(224)
        super.init(frame: CGRect(x: 0, y: 0, width: screenWith, height: frameH), inputViewStyle: inputViewStyle)
        backgroundColor = UIColor.lightGray
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addKeyboard(view: UIView, field: UITextField?=nil) {
        superView = view
        customSubview()
        if let textField = field {
            textFields.append(textField)
            textField.inputView = self
            textField.delegate = self
        } else {
            for view in (superView?.subviews)! {
                if view .isKind(of: UITextField.self) {
                    let textField = view as! UITextField
                    textField.delegate = self
                    textField.inputView = self
                    textFields.append(textField)
                }
            }
        }
    }
    
    private func customSubview() {
        for idx in 0...13 {
            let button = UIButton()
            button.titleLabel?.font = UIFont.systemFont(ofSize: 28)
            button.backgroundColor = UIColor.white
            button.tag = idx
            highlight(heghlight: shouldHighlight)
            addSubview(button)
            var backSpace: UIImage?
            var dismiss: UIImage?
            let podBundle = Bundle(for: self.classForCoder)
            if let bundleURL = podBundle.url(forResource: "DigitalKeyboard", withExtension: "bundle") {
                if let bundle = Bundle(url: bundleURL) {
                    backSpace = UIImage(named: "Keyboard_Backspace", in: bundle, compatibleWith: nil)
                    dismiss = UIImage(named: "Keyboard_DismissKey", in: bundle, compatibleWith: nil)
                } else {
                    backSpace = UIImage(named: "Keyboard_Backspace")
                    dismiss = UIImage(named: "Keyboard_DismissKey")
                }
            } else {
                backSpace = UIImage(named: "Keyboard_Backspace")
                dismiss = UIImage(named: "Keyboard_DismissKey")
            }
            button.setTitleColor(UIColor.black, for: .normal)
            switch idx {
            case 9:
                button.setTitle("", for: .normal)
                button.setImage(dismiss, for: .normal)
            case 10:
                button.setTitle("0", for: .normal)
            case 11:
                button.setTitle("X", for: .normal)
            case 12:
                button.setTitle("", for: .normal)
                button.setImage(backSpace, for: .normal)
            case 13:
                button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
                button.backgroundColor = defaultDoneColor
                button.setTitleColor(UIColor.white, for: .normal)
                button.setBackgroundImage(nil, for: .normal)
                button.setBackgroundImage(nil, for: .highlighted)
                button.setTitle(LocalizedString(key: "Done"), for: .normal)
            default:
                button.setTitle("\(idx + 1)", for: .normal)
            }
            button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        }
    }
    
    func tap(sender: UIButton) {
        guard let text = sender.currentTitle else {
            fatalError("not found the sender's currentTitle")
        }
        switch sender.tag {
        case 12:
            firstResponder()?.deleteBackward()
        case 13, 9:
            firstResponder()?.resignFirstResponder()
        default:
            firstResponder()?.insertText(text)
        }
    }
    
    func firstResponder() -> UITextField? {
        var firstResponder: UITextField?
        for field in textFields {
            if field.isFirstResponder {
                firstResponder = field
            }
        }
        return firstResponder
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        for view in subviews {
            if view .isKind(of: UIButton.self) {
                let width = frame.width / 4 * 3
                let idx = view.tag
                if idx >= 12 {
                    
                    view.frame = CGRect(x: width + marginvalue, y: CGFloat((idx-12)%2) * (frame.height/2.0 + marginvalue), width: frame.width/4, height: (frame.height - marginvalue)/2.0)
                } else {
                    view.frame = CGRect(x: CGFloat(idx%3) * ((width - 2*marginvalue)/3+marginvalue), y: CGFloat(idx/3) * (frame.height/4.0 + marginvalue), width: (width - 2*marginvalue)/3, height: frame.height/4.0)
                }
            }
        }
    }
    
    func highlight(heghlight: Bool) {
        for view in subviews {
            if let button = view as? UIButton {
                if button.tag == 13 {return}
                if heghlight {
                    button.setBackgroundImage(UIImage.dk_imageWithColor(color: UIColor.white), for: .normal)
                    button.setBackgroundImage(UIImage.dk_imageWithColor(color: UIColor.lightGray), for: .highlighted)
                } else {
                    button.setBackgroundImage(UIImage.dk_imageWithColor(color: UIColor.white), for: .normal)
                    button.setBackgroundImage(UIImage.dk_imageWithColor(color: UIColor.white), for: .highlighted)
                }
            }
        }

    }
    
    func setDigitButton(style: KeyboardStyle) {
        guard let button = findButtonByTag(tag: 11) else {
            fatalError("not found the button with the tag")
        }
        switch style {
        case .IDCard:
            button.setTitle("X", for: .normal)
        case .Number:
            let locale = Locale.current
            let decimalSeparator = locale.decimalSeparator! as String 
            button.setTitle(decimalSeparator, for: .normal)
        }
    }
    
    func findButtonByTag(tag: Int) -> UIButton? {
        for button in subviews {
            if button.tag == tag {
                return button as? UIButton
            }
        }
        return nil
    }
    
    func LocalizedString(key: String) -> String {
        return (Bundle(identifier: "com.apple.UIKit")?.localizedString(forKey: key, value: nil, table: nil))!
    }
    
    func setDoneButton(title: String, titleColor: UIColor, theme: UIColor) {
        guard let itemButton = findButtonByTag(tag: 13) else {
            fatalError("not found the button with the tag")
        }
        itemButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        itemButton.setTitle(title, for: .normal)
        itemButton.backgroundColor = theme
        itemButton.setTitleColor(titleColor, for: .normal)
    }
}

extension UIImage {
    public class func dk_imageWithColor(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        UIGraphicsBeginImageContext(size)
        color.set()
        UIRectFill(CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

// MARK: UIInputViewAudioFeedback
extension DigitalKeyboard: UIInputViewAudioFeedback {
    public var enableInputClicksWhenVisible: Bool {
        return true
    }
}
