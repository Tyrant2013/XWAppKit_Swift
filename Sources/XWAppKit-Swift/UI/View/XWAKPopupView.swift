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
    private lazy var borderLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        self.layer.addSublayer(layer)
        return layer
    }()
    public override init(frame: CGRect) {
        var solidFrame = frame
        solidFrame.size = CGSize(width: 22, height: 14)
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
        borderLayer.fillColor = UIColor.red.cgColor
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
            triangle.fillColor = fillColor
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
        self.layer.insertSublayer(layer, at: 0)
        return layer
    }()
    
//    private func drawTopTriangle() -> CGPath {
//        let path = UIBezierPath()
//
//        // 左上角
//        path.move(to: .init(x: 0, y: radius + triangleHeight))
//        path.addArc(withCenter: .init(x: radius, y: triangleHeight + radius),
//                    radius: radius,
//                    startAngle: .pi,
//                    endAngle: -.pi/2,
//                    clockwise: true)
//        path.addLine(to: .init(x: triangleTopPoint.x - triangeWidth / 2, y: triangleHeight))
//        // 三角
////        path.addLine(to: triangleTopPoint)
////        path.addLine(to: .init(x: triangleTopPoint.x + triangeWidth / 2, y: triangleHeight))
//
//        var bp1 = triangleTopPoint.x - triangeWidth / 2
//        var cp1 = bp1 + 5 // bp1 * 0.1
//        var bp2 = triangleTopPoint.x
//        var cp2 = bp2 - 5 //bp2 * 0.1
//        path.addCurve(to: triangleTopPoint,
//                      controlPoint1: .init(x: cp1, y: triangleHeight),
//                      controlPoint2: .init(x: cp2, y: 0))
//
//        bp1 = triangleTopPoint.x
//        cp1 = bp1 + 5 //bp1 * 0.1
//        bp2 = triangleTopPoint.x + triangeWidth / 2
//        cp2 = bp2 - 5 //bp2 * 0.0
//        path.addCurve(to: .init(x: triangleTopPoint.x + triangeWidth / 2, y: triangleHeight),
//                      controlPoint1: .init(x: cp1, y: 0),
//                      controlPoint2: .init(x: cp2, y: triangleHeight))
//
//        path.addLine(to: .init(x: bounds.width - radius, y: triangleHeight))
//        // 右上角
//        path.addArc(withCenter: .init(x: bounds.width - radius, y: triangleHeight + radius),
//                    radius: radius,
//                    startAngle: -.pi/2,
//                    endAngle: 0,
//                    clockwise: true)
//        path.addLine(to: .init(x: bounds.width, y: bounds.height - 10))
//        // 右下角
//        path.addArc(withCenter: .init(x: bounds.width - radius, y: bounds.height - radius),
//                    radius: radius,
//                    startAngle: 0,
//                    endAngle: .pi/2,
//                    clockwise: true)
//        path.addLine(to: .init(x: radius, y: bounds.height))
//        // 左下角
//        path.addArc(withCenter: .init(x: radius, y: bounds.height - radius),
//                    radius: radius,
//                    startAngle: .pi/2,
//                    endAngle: .pi,
//                    clockwise: true)
//        path.addLine(to: .init(x: 0, y: radius + triangleHeight))
//        return path.cgPath
//    }
    private lazy var tw: CGFloat = 20
    private lazy var th: CGFloat = 10
    private lazy var triangle: XWAKPopupTriangleView = {
        let origin = CGPoint(x: 0, y: 0)
        let size = CGSize(width: tw, height: th)
        let view = XWAKPopupTriangleView(frame: .init(origin: origin, size: size))
        addSubview(view)
        return view
    }()
    
//    private lazy var midHLine: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(view)
//        view.xwak.edge(equalTo: xwak, inset: 0, edges: [.left, .right])
//            .centerY(equalTo: xwak.centerY)
//            .height(1)
//        view.backgroundColor = .black
//        return view
//    }()
//    private lazy var midVLine: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(view)
//        view.xwak.edge(equalTo: xwak, inset: 0, edges: [.top, .bottom])
//            .centerX(equalTo: xwak.centerX)
//            .width(1)
//        view.backgroundColor = .black
//        return view
//    }()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
//        midHLine.backgroundColor = .black
//        midVLine.backgroundColor = .black

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
            triFrame.origin.x = 0
        case .top:
            trans = ids
            (x, y, w, h) = (0, th, bounds.width, bounds.height - th)
            // 最左边
//            triFrame.origin.x = radius
            // 中间
            triFrame.origin.x = (bounds.width - tw) / 2
            triFrame.origin.y = 0
        case .right:
            trans = ids.rotated(by: .pi / 2).translatedBy(x: 0, y: (tw-th)/2)
            (x, y, w, h) = (0, 0, bounds.width - th, bounds.height)
            triFrame.origin.x = bounds.width - th
            triFrame.origin.y = radius
        case .bottom:
            trans = ids.rotated(by: .pi)
            (x, y, w, h) = (0, 0, bounds.width, bounds.height - th)
            triFrame.origin.y = bounds.height - th
            triFrame.origin.x = radius
        }
        triangle.frame = triFrame
        triangle.transform = trans
        let path = UIBezierPath(roundedRect: .init(x: x, y: y, width: w, height: h), cornerRadius: radius)
        borderLayer.path = path.cgPath
        borderLayer.fillColor = fillColor.cgColor
        triangle.fillColor = fillColor
    }

}
