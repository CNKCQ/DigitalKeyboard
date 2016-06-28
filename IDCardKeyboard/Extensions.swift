//
//  Copyright © 2016年 KingCQ. All rights reserved.
//

import UIKit


extension UIImage {
    /** 生成纯色图片, 默认大小1x1, 在UITableViewCell默认左侧图标使用时需要手动设定大小占位 */
    public class func ic_imageWithColor(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        UIGraphicsBeginImageContext(size)
        color.set()
        UIRectFill(CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

public extension UITextField {
    public func idcardKeyboard(view: UIView) {
        IDCardKeyboard.shareKeyboard.addKeyboard(view, field: self)
    }
}
