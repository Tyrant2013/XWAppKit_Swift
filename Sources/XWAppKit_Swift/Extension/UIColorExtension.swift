//
//  UIColorExtension.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/7/24.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    class func xwak_color(with hex: Int, alpha: CGFloat) -> UIColor {
        if hex > 0xffffff || hex < 0 || alpha < 0 || alpha > 1 {
            return .clear
        }
        let r = CGFloat(hex & 0xff0000 >> 16) / 255
        let g = CGFloat(hex & 0x00ff00 >> 8) / 255
        let b = CGFloat(hex & 0x0000ff) / 255
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
    class func xwak_color(with hex: String) -> UIColor {
        var hexValue = ""
        if hex.starts(with: "0x") || hex.starts(with: "0X") {
            hexValue = String(hex.dropFirst(2))
        }
        if !(hexValue.count == 8 || hexValue.count == 6) {
            return .clear
        }
        let array = Array(hexValue)
        let numbers = stride(from: 0, to: array.count, by: 2).map {
            strtoul(String(array[$0..<min($0 + 2, array.count)]), nil, 16)
        }
        if numbers.count == 4 {
            let red = CGFloat(numbers[0]) / 255.0
            let green = CGFloat(numbers[1]) / 255.0
            let blue = CGFloat(numbers[2]) / 255.0
            let alpha = CGFloat(numbers[3]) / 255.0
            return .init(red: red, green: green, blue: blue, alpha: alpha)
        }
        return .clear
    }
}
