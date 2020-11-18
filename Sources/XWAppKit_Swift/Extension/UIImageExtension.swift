//
//  UIImageExtension.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/9/25.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public extension UIImage {
    static func make(byRoundingCorners corners: UIRectCorner, radius: CGFloat) -> UIImage? {
        let rect = CGRect(origin: .zero, size: CGSize(width: radius * 2 + 1, height: radius * 2 + 1))
        let radii = CGSize(width: radius, height: radius)
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: radii)
        let capInset: CGFloat = radius + 0.1
        let capInsets = UIEdgeInsets(top: capInset, left: capInset, bottom: capInset, right: capInset)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        UIColor.white.setStroke()
        path.fill()
        return UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: capInsets)
    }
    
    static func xwak_frameImage(name: String) -> UIImage? {
        let bundle = Bundle(for: XWAKPhotoKit.self)
        let image = UIImage(named: name)
        if image != nil {
            return image
        }
        return UIImage(named: name, in: bundle, compatibleWith: nil)
    }
}
