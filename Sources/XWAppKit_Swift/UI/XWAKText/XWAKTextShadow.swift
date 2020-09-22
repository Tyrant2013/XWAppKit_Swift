//
//  XWAKTextShadow.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/9/22.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public class XWAKTextShadow: NSObject {
    let offset: CGSize
    let color: UIColor
    let blur: CGFloat
    
    public init(offset: CGSize, color: UIColor, blur: CGFloat) {
        self.offset = offset
        self.color = color
        self.blur = blur
        super.init()
    }
}
