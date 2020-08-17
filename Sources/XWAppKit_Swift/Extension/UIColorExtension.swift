//
//  UIColorExtension.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/7/24.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class func xwak_color(with hex: Int, alpha: CGFloat) -> UIColor {
        if hex > 0xffffff || hex < 0 || alpha < 0 || alpha > 1 {
            return .clear
        }
        let r = CGFloat(hex & 0xff0000 >> 16) / 255
        let g = CGFloat(hex & 0x00ff00 >> 8) / 255
        let b = CGFloat(hex & 0x0000ff) / 255
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
}
