//
//  XWAKSVGPolygon.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2021/3/26.
//  Copyright © 2021 ZhuanagXiaowei. All rights reserved.
//

import UIKit

class XWAKSVGPolygon: XWAKSVGElement {
    private(set) var points: [Double] = []
    
    required init(dict: [String : String]) {
        
        if let values = dict["points"] {
            points = values.split(separator: " ").map({ Double($0)! })
        }
        super.init(dict: dict)
        tagName = "polygon"
    }
    
    override func fillPath() {
        for i in stride(from: 0, to: points.count, by: 2) {
            let x = points[i]
            let y = points[i + 1]
            let point = CGPoint(x: x, y: y)
            if i == 0 {
                path.move(to: point)
            }
            else {
                path.addLine(to: point)
            }
        }
    }
}
