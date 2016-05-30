//
//  KeyboardView.swift
//  Swiftk
//
//  Created by KingCQ on 16/5/30.
//  Copyright © 2016年 Jack. All rights reserved.
//

import UIKit
let marginvalue = CGFloat(0.5)

typealias InputTextClosure = (String)->()

class KeyboardView: UIView {
    var inputTextClosure: InputTextClosure?
    var text = ""
    
    override init(frame: CGRect) {
        let frame: CGRect = CGRectMake(0,0,WIDTH,224.0)
        super.init(frame: frame)
        self.backgroundColor = .blackColor()
        customSubview(frame)
        
    }
    
    func customSubview(frame: CGRect){
        for idx in 0...11 {
            let button: UIButton = UIButton()
            button.frame = CGRectMake(CGFloat(idx%3) * (frame.width/3+marginvalue), CGFloat(idx/3) * (frame.height/4.0 + marginvalue), frame.width/3, frame.height/4.0)
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
                button.setTitle("回退", forState: .Normal)
            }
            button.setBackgroundImage(UIImage.imageWithColor(.whiteColor()), forState: .Normal)
            button.setBackgroundImage(UIImage.imageWithColor(.lightGrayColor()), forState: .Highlighted)
            button.setTitleColor(.blackColor(), forState: .Normal)
            button.addTarget(self, action: #selector(tap(_:)), forControlEvents: .TouchUpInside)
            addSubview(button)
        }
    }
    
    func tap(sender:UIButton) {
        if sender.currentTitle! == "回退" {
            if text.characters.count > 0 {
                text = text.removeLastCharacter()
                if inputTextClosure != nil {
                    inputTextClosure!(text)
                }
            }
            return
        }
        text += sender.currentTitle!
        if inputTextClosure != nil {
            inputTextClosure!(text)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension String {
    mutating func removeLastCharacter() -> String {
        self.removeAtIndex(self.endIndex.predecessor())
        return self
    }
}

extension UIImage {
    /** 生成纯色图片, 默认大小1x1, 在UITableViewCell默认左侧图标使用时需要手动设定大小占位 */
    public class func imageWithColor(color: UIColor, size: CGSize = CGSizeMake(1, 1)) -> UIImage {
        UIGraphicsBeginImageContext(size)
        color.set()
        UIRectFill(CGRect(origin: CGPointZero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

/*
 keyboard height
 iphone5 : 224
 iphone6 : 258
 iphone6 plus: 271
 */

