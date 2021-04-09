//
//  XWAKDoughnutView.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2021/4/7.
//  Copyright © 2021 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public class XWAKDoughnutView: UIControl {
    private var _color: XWAKColor = .white
    public var color: XWAKColor {
        get {
            return XWAKColor(hue: hue, saturation: _color.saturation, brightness: _color.brightness, alpha: 1.0)
        }
        set {
            let center = CGPoint(x: bounds.midX, y: bounds.midY)
            var hue = self.hue
            hue *= -(2 * .pi)
            _color = newValue
            _value.x = cos(hue) * radius
            _value.y = sin(hue) * radius
            _value = center + _value
            _indicator.sharpCenter = hueConstrainPoint(_value)
        }
    }
    private(set) var radius: CGFloat = 1.0
    public var hue: CGFloat {
        get {
            let center = CGPoint(x: bounds.midX, y: bounds.midY)
            let delta = _value - center
            var angle = -atan2(delta.y, delta.x)
            if angle < 0.0 {
                angle += 2 * .pi
            }
            angle *= (180.0 / .pi)
            angle = fmod(angle, 360.0)
            return angle / 360.0
        }
    }
    
    private let _wheelWidth: CGFloat = 35.0
    private var _value: CGPoint = .zero
    private let _indicator: XWAKColorIndicator = XWAKColorIndicator.indicator()
    
    public override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        let (width, height) = (frame.width, frame.height)
        let diameter = min(width, height)
        radius = floor(diameter / 2.0)
        
        _indicator.sharpCenter = hueConstrainPoint(.init(x: 0, y: 1))
        _indicator.isOpaque = false
        _indicator.color = nil
        addSubview(_indicator)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func draw(_ rect: CGRect) {
        // Drawing code
        let bounds = self.bounds.insetBy(dx: 1, dy: 1)
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.saveGState()
        ctx?.addEllipse(in: bounds)
        ctx?.addEllipse(in: bounds.insetBy(dx: _wheelWidth, dy: _wheelWidth))
        ctx?.clip(using: .evenOdd)
        
        if let cgimage = UIImage.xwak_frameImage(name: "color_wheel")?.cgImage {
            ctx?.draw(cgimage, in: self.bounds)
        }
        ctx?.setShadow(offset: .init(width: 0, height: 4), blur: 8)
        ctx?.addRect(bounds.insetBy(dx: -20, dy: -20))
        ctx?.addEllipse(in: bounds.insetBy(dx: -1, dy: -1))
        ctx?.addEllipse(in: bounds.insetBy(dx: _wheelWidth + 1, dy: _wheelWidth + 1))
        ctx?.fillPath(using: .evenOdd)
        
        ctx?.restoreGState()
        
        UIColor.white.set()
        ctx?.setLineWidth(1.5)
        ctx?.strokeEllipse(in: bounds)
        ctx?.strokeEllipse(in: bounds.insetBy(dx: _wheelWidth, dy: _wheelWidth))
    }
    
    public override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let pt = touch.location(in: self)
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let delta = pt - center
        let dis = delta.distance(to: .zero) / radius
        
        if dis >= 1.0 {
            return false
        }
        _value = hueConstrainPoint(pt)
        _indicator.sharpCenter = _value
        
        return true
    }
    
    public override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        _value = hueConstrainPoint(touch.location(in: self))
        _indicator.sharpCenter = _value
        return super .continueTracking(touch, with: event)
    }
    
    private func normalizePoint(_ vector: CGPoint) -> CGPoint {
        let dis = CGPoint.zero.distance(to: vector)
        if dis == 0.0 {
            return vector
        }
        return vector / dis
    }
    
    private func hueConstrainPoint(_ pt: CGPoint) -> CGPoint {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        var delta = pt - center
        
        delta = normalizePoint(delta)
        
        delta = delta * (radius - (_wheelWidth / 2.0 + 1))
        return center + delta
    }
}
