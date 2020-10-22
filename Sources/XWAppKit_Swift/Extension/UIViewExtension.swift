//
//  UIViewExtension.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/10/22.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public extension UIView {
    func addShadow(opacity: Float = 0.8,
                   color: UIColor = .lightGray,
                   radius: CGFloat = 5,
                   offset: CGSize = .init(width: 0, height: 3)) {
        layer.shadowOpacity = opacity
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOffset = offset
    }
    
    func addCorner(radius: CGFloat = 10) {
        layer.cornerRadius = radius
    }
    
    func addBorder(width: CGFloat = 1, color: UIColor = .lightGray) {
        layer.borderWidth = 1
        layer.borderColor = color.cgColor
    }
}
