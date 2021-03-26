//
//  XWAKSVGRect.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2021/3/26.
//  Copyright © 2021 ZhuanagXiaowei. All rights reserved.
//

import UIKit

class XWAKSVGRect: XWAKSVGElement {
    private(set) var x: Double = 0
    private(set) var y: Double = 0
    private(set) var w: Double = 0
    private(set) var h: Double = 0
    
    
    required init(dict: [String : String]) {
        
        guard let x = dict["x"], let y = dict["y"], let width = dict["width"] , let height = dict["height"] else {
            fatalError("x, y, width, height missed!")
        }
        self.x = Double(x)!
        self.y = Double(y)!
        self.w = Double(width)!
        self.h = Double(height)!
        super.init(dict: dict)
        tagName = "rect"
    }
    
    override func fillPath() {
        path = UIBezierPath(rect: .init(x: x, y: y, width: w, height: h))
    }
}
