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
    private lazy var borderLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        self.layer.addSublayer(layer)
        return layer
    }()
    public override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath()
        path.move(to: .init(x: 0, y: bounds.height))
        path.addCurve(to: .init(x: bounds.width / 2, y: 0),
                      controlPoint1: .init(x: 20, y: 57),
                      controlPoint2: .init(x: 18, y: 3))
//        bounds.width / 2 - 10
//        bounds.height - 3
//        bounds.width / 2 - 12
//        3
        path.addCurve(to: .init(x: bounds.width, y: bounds.height),
                      controlPoint1: .init(x: bounds.width / 2 + 14, y: 3),
                      controlPoint2: .init(x: bounds.width / 2 + 11.5, y: bounds.height - 10))
        borderLayer.path = path.cgPath
        borderLayer.fillColor = UIColor.white.cgColor
        borderLayer.strokeColor = UIColor.black.cgColor
        borderLayer.lineWidth = 2
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
    
    public var triangleHeight: CGFloat = 14
    public var fillColor: UIColor = UIColor.xwak_color(with: 0xF5F5F5, alpha: 0.9)
    /*                ___
            /\
           /  \       triangleHeight
          /____\      ___
          |     |
        triangleWidth
     */
    public var triangeWidth: CGFloat = 22
    
    private lazy var borderLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        self.layer.insertSublayer(layer, at: 0)
        return layer
    }()
    
    private func drawTopTriangle() -> CGPath {
        let path = UIBezierPath()

        // 左上角
        path.move(to: .init(x: 0, y: radius + triangleHeight))
        path.addArc(withCenter: .init(x: radius, y: triangleHeight + radius),
                    radius: radius,
                    startAngle: .pi,
                    endAngle: -.pi/2,
                    clockwise: true)
        path.addLine(to: .init(x: triangleTopPoint.x - triangeWidth / 2, y: triangleHeight))
        // 三角
//        path.addLine(to: triangleTopPoint)
//        path.addLine(to: .init(x: triangleTopPoint.x + triangeWidth / 2, y: triangleHeight))
        
        var bp1 = triangleTopPoint.x - triangeWidth / 2
        var cp1 = bp1 + 5 // bp1 * 0.1
        var bp2 = triangleTopPoint.x
        var cp2 = bp2 - 5 //bp2 * 0.1
        path.addCurve(to: triangleTopPoint,
                      controlPoint1: .init(x: cp1, y: triangleHeight),
                      controlPoint2: .init(x: cp2, y: 0))
        
        bp1 = triangleTopPoint.x
        cp1 = bp1 + 5 //bp1 * 0.1
        bp2 = triangleTopPoint.x + triangeWidth / 2
        cp2 = bp2 - 5 //bp2 * 0.0
        path.addCurve(to: .init(x: triangleTopPoint.x + triangeWidth / 2, y: triangleHeight),
                      controlPoint1: .init(x: cp1, y: 0),
                      controlPoint2: .init(x: cp2, y: triangleHeight))
        
        path.addLine(to: .init(x: bounds.width - radius, y: triangleHeight))
        // 右上角
        path.addArc(withCenter: .init(x: bounds.width - radius, y: triangleHeight + radius),
                    radius: radius,
                    startAngle: -.pi/2,
                    endAngle: 0,
                    clockwise: true)
        path.addLine(to: .init(x: bounds.width, y: bounds.height - 10))
        // 右下角
        path.addArc(withCenter: .init(x: bounds.width - radius, y: bounds.height - radius),
                    radius: radius,
                    startAngle: 0,
                    endAngle: .pi/2,
                    clockwise: true)
        path.addLine(to: .init(x: radius, y: bounds.height))
        // 左下角
        path.addArc(withCenter: .init(x: radius, y: bounds.height - radius),
                    radius: radius,
                    startAngle: .pi/2,
                    endAngle: .pi,
                    clockwise: true)
        path.addLine(to: .init(x: 0, y: radius + triangleHeight))
        return path.cgPath
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()

        if arrowPosition == .top {
            borderLayer.path = drawTopTriangle()
        }
        switch arrowPosition {
        case .left:
            print("实现中")
        case .top:
            borderLayer.path = drawTopTriangle()
        case .right:
            print("实现中")
        case .bottom:
            print("实现中")
        }
        borderLayer.fillColor = fillColor.cgColor
    }

}
