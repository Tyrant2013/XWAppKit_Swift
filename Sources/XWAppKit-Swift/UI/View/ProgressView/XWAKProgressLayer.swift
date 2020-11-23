//
//  XWAKProgressLayer.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/11/13.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

class XWAKProgressLayer: CALayer {
    @NSManaged var progress: CGFloat
    let start: CGFloat = -.pi / 2
    let end: CGFloat = -.pi / 2 + (.pi * 2)
    let lineWidth: CGFloat = 5
    
    private var radius: CGFloat {
        get {
            return bounds.width / 2 - lineWidth
        }
    }
    private var arcCenter: CGPoint {
        get {
            return .init(x: bounds.midX, y: bounds.midY)
        }
    }
    
    override class func needsDisplay(forKey key: String) -> Bool {
        if key == #keyPath(progress) {
            return true
        }
        return super.needsDisplay(forKey: key)
    }
    
    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        
        UIGraphicsPushContext(ctx)
        UIColor.lightGray.setStroke()
        
        let path = UIBezierPath(arcCenter: arcCenter,
                                radius: radius,
                                startAngle: start,
                                endAngle: end,
                                clockwise: true)
        path.lineWidth = lineWidth
        path.stroke()
        
        UIColor.systemOrange.setStroke()
        let endAngle: CGFloat = (-.pi / 2) + (.pi * 2) * progress
        let progressPath = UIBezierPath(arcCenter: arcCenter,
                                        radius: radius,
                                        startAngle: start,
                                        endAngle: endAngle,
                                        clockwise: true)
        progressPath.lineWidth = lineWidth
        progressPath.stroke()
        
        UIGraphicsPopContext()
    }
}
