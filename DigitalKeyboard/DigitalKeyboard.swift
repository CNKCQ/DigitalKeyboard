//
//  DigitalKeyboard.swift
//  KeyBoard forKey
//
//  Created by Jack on 16/9/15.
//  Copyright © 2016年 Jack. All rights reserved.
//

import UIKit
private let marginvalue = CGFloat(0.5)
private let screenWith = UIScreen.main.bounds.size.width

public enum Style {
    case idcard
    case number
}

public class DigitalKeyboard: UIInputView, UITextFieldDelegate {
    public static let `default` = DigitalKeyboard(frame: CGRect(x: 0, y: 0, width: screenWith, height: 224), inputViewStyle: .keyboard)
    
    public static let defaultDoneColor = UIColor(red: 28 / 255, green: 171 / 255, blue: 235 / 255, alpha: 1)
    
    public var accessoryView: UIView?

    public var style = Style.idcard {
        didSet {
            setDigitButton(style: style)
        }
    }

    public var isSafety: Bool = false {
        didSet {
            if isSafety {
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotify(notifiction:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            }
        }
    }

    public var shouldHighlight = true {
        didSet {
            highlight(heghlight: shouldHighlight)
        }
    }

    public func customDoneButton(title: String, titleColor: UIColor = UIColor.white, theme: UIColor = DigitalKeyboard.defaultDoneColor, target: UIViewController? = nil, callback: Selector? = nil) {
        
        setDoneButton(title: title, titleColor: titleColor, theme: theme, target: target, callback: callback)
    }

    private var textFields = [UITextField]()
    private var superView: UIView?
    private var buttions: [UIButton] = []

    public convenience init(_ view: UIView, accessoryView: UIView? = nil, field: UITextField? = nil) {
        self.init(frame: CGRect.zero, inputViewStyle: .keyboard)
        self.accessoryView = accessoryView
        addKeyboard(view, field: field)
    }

    private override init(frame _: CGRect, inputViewStyle: UIInputViewStyle) {
        let frameH = CGFloat(224)
        super.init(frame: CGRect(x: 0, y: 0, width: screenWith, height: frameH), inputViewStyle: inputViewStyle)
        backgroundColor = .lightGray
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func addKeyboard(_ view: UIView, field: UITextField? = nil) {
        superView = view
        customSubview()
        if let textField = field {
            textFields.append(textField)
            textField.inputView = self
            textField.delegate = self
            textField.inputAccessoryView =  accessoryView
        } else {
            for view in (superView?.subviews)! {
                if view.isKind(of: UITextField.self) {
                    let textField = view as! UITextField
                    textField.delegate = self
                    textField.inputView = self
                    textField.inputAccessoryView = accessoryView
                    textFields.append(textField)
                }
            }
        }
    }

    private func customSubview() {
        var backSpace: UIImage?
        var dismiss: UIImage?
        let podBundle = Bundle(for: classForCoder)
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
        for idx in 0 ... 13 {
            let button = UIButton()
            button.titleLabel?.font = UIFont.systemFont(ofSize: 28)
            button.backgroundColor = UIColor.white
            button.tag = idx
            highlight(heghlight: shouldHighlight)
            addSubview(button)
            button.setTitleColor(UIColor.black, for: .normal)
            switch idx {
            case 9:
                button.setTitle("", for: .normal)
                button.setImage(dismiss, for: .normal)
            case 10:
                button.setTitle("0", for: .normal)
                buttions.append(button)
            case 11:
                button.setTitle("X", for: .normal)
            case 12:
                button.setTitle("", for: .normal)
                button.setImage(backSpace, for: .normal)
            case 13:
                button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
                button.backgroundColor = DigitalKeyboard.defaultDoneColor
                button.setTitleColor(UIColor.white, for: .normal)
                button.setBackgroundImage(nil, for: .normal)
                button.setBackgroundImage(nil, for: .highlighted)
                button.setTitle(LocalizedString(key: "Done"), for: .normal)
            default:
                button.setTitle("\(idx + 1)", for: .normal)
                buttions.append(button)
            }
            button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        }
    }

    @objc func tap(sender: UIButton) {
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
            if view.isKind(of: UIButton.self) {
                let width = frame.width / 4 * 3
                let idx = view.tag
                if idx >= 12 {
                    view.frame = CGRect(x: width + marginvalue, y: CGFloat((idx - 12) % 2) * (frame.height / 2.0 + marginvalue), width: frame.width / 4, height: (frame.height - marginvalue) / 2.0)
                } else {
                    view.frame = CGRect(x: CGFloat(idx % 3) * ((width - 2 * marginvalue) / 3 + marginvalue), y: CGFloat(idx / 3) * (frame.height / 4.0 + marginvalue), width: (width - 2 * marginvalue) / 3, height: frame.height / 4.0)
                }
            }
        }
    }

    func highlight(heghlight: Bool) {
        for view in subviews {
            if let button = view as? UIButton {
                if button.tag == 13 { return }
                if heghlight {
                    button.setBackgroundImage(UIImage.dk_image(with: .white), for: .normal)
                    button.setBackgroundImage(UIImage.dk_image(with: .lightGray), for: .highlighted)
                } else {
                    button.setBackgroundImage(UIImage.dk_image(with: .white), for: .normal)
                    button.setBackgroundImage(UIImage.dk_image(with: .white), for: .highlighted)
                }
            }
        }
    }

    func setDigitButton(style: Style) {
        guard let button = findButton(by: 11) else {
            fatalError("not found the button with the tag")
        }
        switch style {
        case .idcard:
            button.setTitle("X", for: .normal)
        case .number:
            let locale = Locale.current
            let decimalSeparator = locale.decimalSeparator! as String
            button.setTitle(decimalSeparator, for: .normal)
        }
    }

    func findButton(by tag: Int) -> UIButton? {
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

    func setDoneButton(title: String, titleColor: UIColor, theme: UIColor, target: UIViewController?, callback: Selector?) {
        guard let itemButton = findButton(by: 13) else {
            fatalError("not found the button with the tag")
        }
        if let selector = callback, let target = target {
            itemButton.addTarget(target, action: selector, for: .touchUpInside)
        }
        itemButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        itemButton.setTitle(title, for: .normal)
        itemButton.backgroundColor = theme
        itemButton.setTitleColor(titleColor, for: .normal)
    }

    @objc func keyboardWillShowNotify(notifiction _: NSNotification) {
        titles = titles.sorted { _, _ in
            arc4random() < arc4random()
        }
        if !buttions.isEmpty {
            for (idx, item) in buttions.enumerated() {
                item.setTitle(titles[idx], for: .normal)
            }
        }
    }

    private lazy var titles = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
}

extension UIImage {
    public class func dk_image(with color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        UIGraphicsBeginImageContext(size)
        color.set()
        UIRectFill(CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

// MARK: UIInputViewAudioFeedback
extension DigitalKeyboard: UIInputViewAudioFeedback {
    open var enableInputClicksWhenVisible: Bool {
        return true
    }
}
