//
//  KeyboardNotication.swift
//  IDCardKeyboardDemo
//
//  Created by KingCQ on 16/5/31.
//  Copyright © 2016年 KingCQ. All rights reserved.
//

import UIKit

class KeyboardNotification: AnyObject {
    static let shareKeyboardNotification: KeyboardNotification = KeyboardNotification()
    var superView: UIView?
    var superOriginFrame: CGRect = CGRect.zero
    var superViewTopMargin: CGFloat?
    var keyboardShown: Bool = false

    init() {
        NotificationCenter.default().addObserver(self, selector: #selector(keyboardWillShowNotify), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default().addObserver(self, selector: #selector(keyboardWillHidderNotify), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    func addKeyboardNotificationForSuperView(view: UIView, margin: CGFloat) {
        superView = view
        superViewTopMargin = margin
    }

    @objc func keyboardWillShowNotify(notifiction: NSNotification) {
        let info: NSDictionary = notifiction.userInfo!
        let value: NSValue = info.object(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let duration: Double = (info.object(forKey: UIKeyboardAnimationDurationUserInfoKey)?.doubleValue)!
        let keyboardSize = value.cgRectValue().size
        let firstResponderView = UIView.getFirstResponderAtView(view: superView!)
        if firstResponderView != nil {
            let bottomY = caculateAbsoluteBottomY(view: firstResponderView!) + 20
            if bottomY + keyboardSize.height > UIScreen.main().bounds.size.height {
                let length = bottomY + keyboardSize.height - UIScreen.main().bounds.size.height
                // 记录下移动前的初始位置，方便后面还原
                if keyboardShown == false {
                    keyboardShown = true
                    superOriginFrame = superView!.frame
                }
                UIView.animate(withDuration: duration, animations: {
                    var frame = (self.superView?.frame)!
                    frame.origin.y = (self.superOriginFrame.origin.y) - length
                    self.superView?.frame = frame
                })
            }


        }
    }

    @objc func keyboardWillHidderNotify(notifiction: NSNotification) {
        // 键盘没有遮挡输入框
        if superOriginFrame.equalTo(CGRect.zero) {
            return
        }
        let info: NSDictionary = notifiction.userInfo!
        let duration = (info.object(forKey: UIKeyboardAnimationDurationUserInfoKey)?.doubleValue)!
        UIView.animate(withDuration: duration, animations: {
            self.superView?.frame = self.superOriginFrame
            }) { (finished) in
                self.keyboardShown = false
                self.superOriginFrame = CGRect.zero
        }
    }

    func caculateAbsoluteBottomY(view: UIView) -> CGFloat {

        var bottomY = view.frame.maxY
        var subView = view
        while subView.superview != superView {
            subView = subView.superview!
            // 如果是滚动视图，应该计算偏移量
            
            if subView.isKind(of: UIScrollView.self) {
                let subView = subView as! UIScrollView
                bottomY -= subView.contentOffset.y
            }
            bottomY += subView.frame.origin.y
        }
        bottomY += superViewTopMargin!
        
        if subView.isKind(of: UIScrollView.self) {
            let supV = superView as! UIScrollView
            bottomY -= supV.contentOffset.y
        }
        return bottomY
    }

    deinit {
        NotificationCenter.default().removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default().removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }

}

extension UIView {

    class func getFirstResponderAtView(view: UIView) -> UIView? {
        for subView in view.subviews {
            if subView.isFirstResponder() == true {
                return subView
            }
        }
        // 没有找到，继续子view寻找
        for subView in view.subviews {
            let firstResponderView = getFirstResponderAtView(view: subView)
            if firstResponderView != nil && firstResponderView!.isFirstResponder() == true {
                return firstResponderView!
            }

        }
        return nil
    }
}
