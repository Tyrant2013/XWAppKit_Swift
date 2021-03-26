//
//  XWAKSVGEllipse.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2021/3/26.
//  Copyright © 2021 ZhuanagXiaowei. All rights reserved.
//

import UIKit

class XWAKSVGEllipse: XWAKSVGElement {
    private(set) var cx: Double = 0
    private(set) var cy: Double = 0
    private(set) var rx: Double = 0
    private(set) var ry: Double = 0
    
    required init(dict: [String : String]) {
        guard let cx = dict["cx"], let cy = dict["cy"], let rx = dict["rx"], let ry = dict["ry"] else {
            fatalError("cx, cy, rx, ry missed!")
        }
        self.cx = Double(cx)!
        self.cy = Double(cy)!
        self.rx = Double(rx)!
        self.ry = Double(ry)!
        super.init(dict: dict)
        tagName = "ellipse"
    }
}
