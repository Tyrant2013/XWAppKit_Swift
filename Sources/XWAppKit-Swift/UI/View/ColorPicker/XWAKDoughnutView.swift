//
//  XWAKDoughnutView.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2021/4/7.
//  Copyright © 2021 ZhuanagXiaowei. All rights reserved.
//

import UIKit

class XWAKDoughnutView: UIControl {
    public var color: XWAKColor = XWAKColor(red: 0, green: 0, blue: 0, alpha: 1.0)
    private(set) var radius: CGFloat = 1.0
    public var hue: CGFloat = 0
    
    private let _wheelWidth: CGFloat = 35.0
    private var _value: CGPoint = .zero
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let bounds = self.bounds.insetBy(dx: 1, dy: 1)
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.saveGState()
        ctx?.addEllipse(in: bounds)
        ctx?.addEllipse(in: bounds.insetBy(dx: _wheelWidth, dy: _wheelWidth))
        ctx?.clip()
        if let cgimage = UIImage(named: "color_wheel")?.cgImage {
            ctx?.draw(cgimage, in: self.bounds)
        }
        ctx?.setShadow(offset: .init(width: 0, height: 4), blur: 8)
        ctx?.addRect(bounds.insetBy(dx: -20, dy: -20))
        ctx?.addEllipse(in: bounds.insetBy(dx: -1, dy: -1))
        ctx?.addEllipse(in: bounds.insetBy(dx: _wheelWidth + 1, dy: _wheelWidth + 1))
        ctx?.fillPath()
        
        ctx?.restoreGState()
        
        UIColor.white.set()
        ctx?.setLineWidth(1.5)
        ctx?.strokeEllipse(in: bounds)
        ctx?.strokeEllipse(in: bounds.insetBy(dx: _wheelWidth, dy: _wheelWidth))
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let pt = touch.location(in: self)
        let center = CGPoint(x: bounds.minX, y: bounds.minY)
        let delta = pt - center
        let dis = delta.distance(to: center) / radius
        
        if dis >= 1.0 {
            return false
        }
        _value = hueConstrainPoint(pt)
        
        return super.continueTracking(touch, with: event)
    }
    
    private func normalizePoint(_ vector: CGPoint) -> CGPoint {
        let dis = distance(a: .zero, b: vector)
        if dis == 0.0 {
            return vector
        }
        return multiplyPointScalar(p: vector, s: 1.0 / dis)
    }
    private func distance(a: CGPoint, b: CGPoint) -> CGFloat {
        let xd = a.x - b.x
        let yd = a.y - b.y
        return sqrt(xd * xd + yd * yd)
    }
    private func multiplyPointScalar(p: CGPoint, s: CGFloat) -> CGPoint {
        return .init(x: p.x * s, y: p.y * s)
    }
    private func hueConstrainPoint(_ pt: CGPoint) -> CGPoint {
        let center = CGPoint(x: bounds.minX, y: bounds.minY)
        var delta = CGPoint(x: pt.x - center.x, y: pt.y - center.y)
        
        delta = normalizePoint(delta)
        
        delta = multiplyPointScalar(p: delta, s: radius - (_wheelWidth / 2.0 + 1))
        return center + delta
    }
}
