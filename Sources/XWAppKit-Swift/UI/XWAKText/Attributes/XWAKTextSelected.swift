//
//  XWAKTextSelected.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/9/29.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public struct XWAKTextSelected {
    public var backgroundColor: UIColor?
    public var foregroundColor: UIColor?
    public var font: UIFont?
    
    public init(backgroundColor: UIColor? = nil, foregroundColor: UIColor? = nil, font: UIFont? = nil) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.font = font
    }
}
