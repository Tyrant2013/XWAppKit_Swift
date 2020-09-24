//
//  XWAKTextBorder.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/9/24.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public enum XWAKTextBorderStyle {
    case solid
    case dot
    case dash
    case dashdot
    case dashdotdot
    case circledot
}

public struct XWAKTextBorder {
    public var borderStyle: XWAKTextBorderStyle
    public var width: CGFloat
    public var color: UIColor
    
    public init(borderStyle: XWAKTextBorderStyle = .solid, width: CGFloat = 1, color: UIColor = .black) {
        self.borderStyle = borderStyle
        self.width = width
        self.color = color
    }
}
