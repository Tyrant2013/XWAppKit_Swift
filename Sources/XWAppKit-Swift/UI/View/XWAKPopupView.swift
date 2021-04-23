//
//  XWAKPopupView.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2020/12/31.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public enum XWAKPopupViewPosition {
    case left
    case bottom
    case right
    case top
}

public class XWAKPopupTriangleView: UIView {
    public var fillColor: UIColor = .red {
        didSet {
            borderLayer.fillColor = fillColor.cgColor
        }
    }
    public var borderColor:  UIColor = .black {
        didSet {
            borderLayer.strokeColor = borderColor.cgColor
            borderLayer.lineWidth = 1
        }
    }
    private lazy var borderLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        self.layer.addSublayer(layer)
        return layer
    }()
    public override init(frame: CGRect) {
        var solidFrame = frame
        solidFrame.size = CGSize(width: 20, height: 10)
        super.init(frame: solidFrame)
        setup()
    }
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        setupLayer()
    }
    
    func setupLayer() {
        let path = UIBezierPath()
        path.move(to: .init(x: 0, y: bounds.height))
//        path.addCurve(to: .init(x: bounds.width / 2, y: 0),
//                      controlPoint1: .init(x: 6.5, y: 12.5),
//                      controlPoint2: .init(x: 6.5, y: 0.5))
//        path.addCurve(to: .init(x: bounds.width, y: bounds.height),
//                      controlPoint1: .init(x: 15.5, y: 0.5),
//                      controlPoint2: .init(x: 15.5, y: 12.5))
        
        path.addCurve(to: .init(x: bounds.width / 2, y: 0),
                      controlPoint1: .init(x: 3.5, y: 9.5),
                      controlPoint2: .init(x: 5.5, y: 0.5))
        path.addCurve(to: .init(x: bounds.width, y: bounds.height),
                      controlPoint1: .init(x: 14.5, y: 0.5),
                      controlPoint2: .init(x: 16.5, y: 9.5))
        
        borderLayer.path = path.cgPath
        borderLayer.fillColor = fillColor.cgColor
        borderLayer.lineWidth = 1
        borderLayer.strokeColor = borderColor.cgColor
    }
}

public class XWAKPopupView: UIView {
    public var arrowPosition: XWAKPopupViewPosition = .top
    public var radius: CGFloat = 10
    public var triangleTopPoint: CGPoint = .init(x: 50, y: 0) {
        didSet {
            setNeedsLayout()
        }
    }
    
//    public var triangleHeight: CGFloat = 14
    public var fillColor: UIColor = UIColor.xwak_color(with: 0xF5F5F5, alpha: 0.9) {
        didSet {
            borderLayer.fillColor = fillColor.cgColor
            coverView.backgroundColor = fillColor
            triangle.fillColor = fillColor
        }
    }
    public var borderColor: UIColor = .black {
        didSet {
            borderLayer.strokeColor = borderColor.cgColor
            triangle.borderColor = borderColor
        }
    }
    
    /*                ___
            /\
           /  \       triangleHeight
          /____\      ___
          |     |
        triangleWidth
     */
//    public var triangeWidth: CGFloat = 22
    
    private lazy var borderLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 1
        self.layer.insertSublayer(layer, at: 0)
        return layer
    }()
    
    private lazy var tw: CGFloat = 20
    private lazy var th: CGFloat = 10
    private lazy var triangle: XWAKPopupTriangleView = {
        let origin = CGPoint(x: 0, y: 0)
        let size = CGSize(width: tw, height: th)
        let view = XWAKPopupTriangleView(frame: .init(origin: origin, size: size))
        addSubview(view)
        return view
    }()
    private lazy var coverView: UIView = {
        let layer = UIView()
        return layer
    }()
    
    /// 三角指向的View
    public var targetView: UIView?
    /// 添加到View
    public var sourceView: UIView?
    
    public override func layoutSubviews() {
        super.layoutSubviews()

        insertSubview(coverView, aboveSubview: triangle)
        
        update()
    }
    
    func update() {
        let ids = CGAffineTransform.identity
        let trans: CGAffineTransform
        let (x, y, w, h): (CGFloat, CGFloat, CGFloat, CGFloat)
        var triFrame = triangle.frame
        
        switch arrowPosition {
        case .left:
            trans = ids.rotated(by: -.pi / 2).translatedBy(x: 0, y: -(tw-th)/2)
            (x, y, w, h) = (th, 0, bounds.width - th, bounds.height)
            // 最上面
//            triFrame.origin.y = 10
            // 中间
            triFrame.origin.y = (bounds.height - tw) / 2
            if let t = targetView, let s = sourceView {
                let tFrame = t.superview!.convert(t.frame, to: s)
                var sFrame = CGRect(x: tFrame.maxX + 5,
                                    y: tFrame.minY - (self.frame.height - tFrame.height) / 2,
                                    width: self.frame.width,
                                    height: self.frame.height)
                var delta: CGFloat = 0
                if sFrame.maxY > s.frame.height {
                    delta = sFrame.maxY - s.frame.height + 10
                }
                sFrame.origin.y -= delta
                self.frame = sFrame
                if delta != 0 {
                    triFrame.origin.y += delta
                    if triFrame.minY < radius {
                        triFrame.origin.y = radius
                    }
                    else if triFrame.maxY > bounds.height - tw {
                        triFrame.origin.y = bounds.height - tw
                    }
                }
            }
            
            triFrame.origin.x = 0
            coverView.frame = CGRect(x: th, y: triFrame.minY, width: 1, height: tw)
        case .top:
            trans = ids
            (x, y, w, h) = (0, th, bounds.width, bounds.height - th)
            // 最左边
//            triFrame.origin.x = radius
            // 中间
            triFrame.origin.x = (bounds.width - tw) / 2
            triFrame.origin.y = 0
            if let t = targetView, let s = sourceView {
                let tFrame = t.superview!.convert(t.frame, to: s)
                var sFrame = CGRect(x: tFrame.minX - (self.frame.width - tFrame.width) / 2,
                                    y: tFrame.maxY + 5,
                                    width: self.frame.width,
                                    height: self.frame.height)
                var delta: CGFloat = 0
                if sFrame.maxX > s.frame.width {
                    delta = sFrame.maxX - s.frame.width + 10
                }
                sFrame.origin.x -= delta
                self.frame = sFrame
                if delta != 0 {
                    triFrame.origin.x += delta
                    if triFrame.minX < radius {
                        triFrame.origin.x = radius
                    }
                    else if triFrame.maxX > bounds.width - tw {
                        triFrame.origin.x = bounds.width - tw
                    }
                }
            }
            coverView.frame = CGRect(x: triFrame.minX, y: triFrame.maxY, width: triFrame.width, height: 1)
        case .right:
            trans = ids.rotated(by: .pi / 2).translatedBy(x: 0, y: (tw-th)/2)
            (x, y, w, h) = (0, 0, bounds.width - th, bounds.height)
            triFrame.origin.x = bounds.width - th
//            triFrame.origin.y = radius
            triFrame.origin.y = (bounds.height - tw) / 2
            if let t = targetView, let s = sourceView {
                let tFrame = t.superview!.convert(t.frame, to: s)
                var sFrame = CGRect(x: tFrame.minX - 5 - self.frame.width,
                                    y: tFrame.minY - (self.frame.height - tFrame.height) / 2,
                                    width: self.frame.width,
                                    height: self.frame.height)
                var delta: CGFloat = 0
                if sFrame.maxY > s.frame.height {
                    delta = sFrame.maxY - s.frame.height + 10
                }
                sFrame.origin.y -= delta
                self.frame = sFrame
                if delta != 0 {
                    triFrame.origin.y += delta
                    if triFrame.minY < radius {
                        triFrame.origin.y = radius
                    }
                    else if triFrame.maxY > bounds.height - tw {
                        triFrame.origin.y = bounds.height - tw
                    }
                }
            }
            coverView.frame = CGRect(x: w - 1, y: triFrame.minY, width: 1, height: tw)
        case .bottom:
            trans = ids.rotated(by: .pi)
            (x, y, w, h) = (0, 0, bounds.width, bounds.height - th)
            triFrame.origin.y = bounds.height - th
//            triFrame.origin.x = radius
            triFrame.origin.x = (bounds.width - tw) / 2
            if let t = targetView, let s = sourceView {
                let tFrame = t.superview!.convert(t.frame, to: s)
                var sFrame = CGRect(x: tFrame.minX - (self.frame.width - tFrame.width) / 2,
                                    y: tFrame.minY - bounds.height - 5,
                                    width: self.frame.width,
                                    height: self.frame.height)
                var delta: CGFloat = 0
                if sFrame.maxX > s.frame.width {
                    delta = sFrame.maxX - s.frame.width + 10
                }
                sFrame.origin.x -= delta
                self.frame = sFrame
                if delta != 0 {
                    triFrame.origin.x += delta
                    if triFrame.minX < radius {
                        triFrame.origin.x = radius
                    }
                    else if triFrame.maxX > bounds.width - tw {
                        triFrame.origin.x = bounds.width - tw
                    }
                }
            }
            coverView.frame = CGRect(x: triFrame.minX, y: triFrame.minY - 1, width: triFrame.width, height: 1)
        }
        triangle.frame = triFrame
        triangle.transform = trans
        let path = UIBezierPath(roundedRect: .init(x: x, y: y, width: w, height: h), cornerRadius: radius)
        borderLayer.path = path.cgPath
        borderLayer.fillColor = fillColor.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        
        coverView.backgroundColor = fillColor
        
        triangle.fillColor = fillColor
        triangle.borderColor = borderColor
    }

}
