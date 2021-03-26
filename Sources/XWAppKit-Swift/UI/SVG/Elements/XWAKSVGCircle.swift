//
//  XWAKSVGCircle.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2021/3/26.
//  Copyright © 2021 ZhuanagXiaowei. All rights reserved.
//

import UIKit

class XWAKSVGCircle: XWAKSVGElement {
    private(set) var cx: Double = 0
    private(set) var cy: Double = 0
    private(set) var r: Double = 0
    
    required init(dict: [String : String]) {
        
        guard let cx = dict["cx"], let cy = dict["cy"], let r = dict["r"] else { fatalError("cx, cy, r missed!")}
        self.cx = Double(cx)!
        self.cy = Double(cy)!
        self.r = Double(r)!
        super.init(dict: dict)
        tagName = "circle"
    }
    
}
