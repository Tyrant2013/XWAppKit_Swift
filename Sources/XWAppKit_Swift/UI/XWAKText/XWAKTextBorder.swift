//
//  XWAKTextBorder.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/9/24.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public enum XWAKTextBorderStyle {
    case line
    case dot
}

public struct XWAKTextBorder {
    public var borderStyle: XWAKTextBorderStyle = .line
    public var width: CGFloat = 1
    public var color: UIColor = .black
    
    public init() {
        
    }
}
