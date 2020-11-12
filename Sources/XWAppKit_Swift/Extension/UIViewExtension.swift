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
        clipsToBounds = false
        layer.shadowOpacity = opacity
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOffset = offset
    }
    
    func addCorner(radius: CGFloat = 10) {
        layer.cornerRadius = radius
    }
    
    func addBorder(width: CGFloat = 1, color: UIColor = .lightGray) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
}

public extension UIView {
    func scaleAnimation() {
        transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.15) {
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } completion: { (finished) in
            UIView.animate(withDuration: 0.1) {
                self.transform = .identity
            }
        }
    }
}
