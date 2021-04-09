//
//  XWAKColorIndicator.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2021/4/9.
//  Copyright © 2021 ZhuanagXiaowei. All rights reserved.
//

import UIKit

class XWAKColorIndicator: UIView {

    public var alphaMode = false;
    public var color: XWAKColor? {
        didSet {
            setNeedsDisplay()
        }
    }
    public var sharpCenter: CGPoint = .zero {
        didSet {
            var frame = self.frame
            frame.origin = (sharpCenter - .init(x: frame.width / 2, y: frame.height / 2)).roundPoint()
            center = .init(x: frame.midX, y: frame.midY)
        }
    }
    
    class func indicator() -> XWAKColorIndicator {
        let ins = XWAKColorIndicator(frame: .init(x: 0, y: 0, width: 24, height: 24))
        return ins
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        let overlay = UIView(frame: bounds)
        addSubview(overlay)
        
        overlay.layer.borderColor = UIColor.white.cgColor
        overlay.layer.borderWidth = 3
        overlay.layer.cornerRadius = bounds.width / 2
        
        overlay.layer.shadowOpacity = 0.5
        overlay.layer.shadowRadius = 1
        overlay.layer.shadowOffset = .zero
    }
    
    override func draw(_ rect: CGRect) {
        guard let color = self.color else { return }
        if let ctx = UIGraphicsGetCurrentContext() {
            let bounds = self.bounds.insetBy(dx: 2, dy: 2)
            if alphaMode {
                ctx.saveGState()
                
                ctx.addEllipse(in: bounds)
                ctx.clip()
                
                ctx.saveGState()
                UIColor.white.set()
                ctx.fill(bounds)
                
                UIColor.black.set()
                ctx.addPath(UIBezierPath(rect: bounds).cgPath)
                ctx.fillPath()
                ctx.restoreGState()
                
                ctx.restoreGState()
            }
            else {
                color.opaqueColor.set()
            }
            ctx.fill(bounds)
        }
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return false
    }

}
