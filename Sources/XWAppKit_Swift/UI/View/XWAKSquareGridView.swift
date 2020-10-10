//
//  XWAKSquareGridView.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/10/10.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public protocol XWAKSquareGridViewDelegate {
    func squareGridView(_ gridView: XWAKSquareGridView, did finishedCliped: CGRect)
}

public class XWAKSquareGridView: UIView {
    private(set) var col: Int = 3
    private(set) var row: Int = 3
    public var lineColor: UIColor = .white
    public var delegate: XWAKSquareGridViewDelegate?
    private var lineLayer = CAShapeLayer()
    private var cornerLayer = CAShapeLayer()
    private var pathBound: CGRect = .zero
    private let innerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
//    private let outerInset = UIEdgeInsets(top: -5, left: -5, bottom: -5, right: -5)
    public convenience init(col: Int, row: Int) {
        self.init()
        self.col = col
        self.row = row
        backgroundColor = .red
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panHandler(_:)))
        addGestureRecognizer(panGesture)
        
        lineLayer.addSublayer(cornerLayer)
        layer.addSublayer(lineLayer)
        
        cornerLayer.lineWidth = 4
        cornerLayer.strokeColor = UIColor.white.cgColor
        cornerLayer.fillColor = UIColor.clear.cgColor
        
        lineLayer.lineWidth = 2
        lineLayer.strokeColor = lineColor.cgColor
        lineLayer.fillColor = UIColor.clear.cgColor
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if pathBound == .zero {
            pathBound = bounds.inset(by: innerInset)
        }
        setup()
    }
    
    private func setup() {
        let outerPathBound = pathBound.inset(by: UIEdgeInsets(top: -3, left: -3, bottom: -3, right: -3))
        let cornerLength: CGFloat = 15
        
        let cornerPath = UIBezierPath()
        cornerPath.move(to: CGPoint(x: outerPathBound.minX, y: cornerLength + outerPathBound.minY))
        cornerPath.addLine(to: outerPathBound.origin)
        cornerPath.addLine(to: CGPoint(x: cornerLength + outerPathBound.minX, y: outerPathBound.minY))
        
        cornerPath.move(to: CGPoint(x: outerPathBound.maxX - cornerLength, y: outerPathBound.minY))
        cornerPath.addLine(to: CGPoint(x: outerPathBound.maxX, y: outerPathBound.minY))
        cornerPath.addLine(to: CGPoint(x: outerPathBound.maxX, y: cornerLength + outerPathBound.minY))
        
        cornerPath.move(to: CGPoint(x: outerPathBound.minX, y: outerPathBound.maxY - cornerLength))
        cornerPath.addLine(to: CGPoint(x: outerPathBound.minX, y: outerPathBound.maxY))
        cornerPath.addLine(to: CGPoint(x: cornerLength + outerPathBound.minX, y: outerPathBound.maxY))
        
        cornerPath.move(to: CGPoint(x: outerPathBound.maxX - cornerLength, y: outerPathBound.maxY))
        cornerPath.addLine(to: CGPoint(x: outerPathBound.maxX, y: outerPathBound.maxY))
        cornerPath.addLine(to: CGPoint(x: outerPathBound.maxX, y: outerPathBound.maxY - cornerLength))
        
        cornerLayer.path = cornerPath.cgPath
        
        let path = UIBezierPath(rect: pathBound)
        let rowStart = pathBound.height / CGFloat(row)
        let colStart = pathBound.width / CGFloat(col)
        path.move(to: CGPoint(x: pathBound.minX, y: rowStart + pathBound.minY))
        path.addLine(to: CGPoint(x: pathBound.maxX, y: rowStart + pathBound.minY))
        path.move(to: CGPoint(x: pathBound.maxX, y: rowStart * 2 + pathBound.minY))
        path.addLine(to: CGPoint(x: pathBound.minX, y: rowStart * 2 + pathBound.minY))
        
        path.move(to: CGPoint(x: colStart + pathBound.minX, y: pathBound.minY))
        path.addLine(to: CGPoint(x: colStart + pathBound.minX, y: pathBound.maxY))
        path.move(to: CGPoint(x: colStart * 2 + pathBound.minX, y: pathBound.maxY))
        path.addLine(to: CGPoint(x: colStart * 2 + pathBound.minX, y: pathBound.minY))
        
        lineLayer.path = path.cgPath
    }
    
    private enum State {
        case `default`
        case move(_ startPoint: CGPoint = .zero, _ startSize: CGSize, _ direct: Director)
        
        enum Director {
            case none
            case topLeft
            case topRight
            case bottomLeft
            case bottomRight
        }
    }
    
    private var state: State = .default
    @objc
    func panHandler(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            let touchPoint = sender.location(in: self)
            let direct = pointInCorner(touchPoint)
            state = .move(pathBound.origin, pathBound.size, direct)
        case .changed:
            if case .move(let startPoint, let startSize, let direct) = state {
                let translation = sender.translation(in: self)
                
                switch direct {
                case .topLeft:
                    pathBound.origin.x = startPoint.x + translation.x
                    pathBound.origin.y = startPoint.y + translation.y
                    pathBound.size.width = startSize.width - translation.x
                    pathBound.size.height = startSize.height - translation.y
                    break
                case .topRight:
                    pathBound.size.width = startSize.width + translation.x
                    pathBound.size.height = startSize.height - translation.y
                    pathBound.origin.y = startPoint.y + translation.y
                    break
                case .bottomLeft:
                    pathBound.origin.x = startPoint.x + translation.x
                    pathBound.size.width = startSize.width - translation.x
                    pathBound.size.height = startSize.height + translation.y
                    break
                case .bottomRight:
                    pathBound.size.width = startSize.width + translation.x
                    pathBound.size.height = startSize.height + translation.y
                    break
                case .none:
                    print("none")
                    break
                }
            }
        case .ended:
//            let time = Timer(timeInterval: 0.5, repeats: false) { (timer) in
//                timer.invalidate()
//                self.pathBound.origin.x = (self.bounds.width - self.pathBound.width) / 2
//                self.pathBound.origin.y = (self.bounds.height - self.pathBound.height) / 2
//                UIView.animate(withDuration: 0.25) {
//                    self.lineLayer.frame = self.pathBound
//                    self.setup()
//                }
//            }
//            RunLoop.main.add(time, forMode: .common)
            break
        default:
            state = .default
            break
        }
        setup()
    }

    private func pointInCorner(_ point: CGPoint) -> State.Director {
        let cornerLength: CGFloat = 25
        let inset = UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)
        let size = CGSize(width: cornerLength, height: cornerLength)
        let topLeftRect = CGRect(origin: pathBound.origin, size: size).inset(by: inset)
        let topRightRect = CGRect(origin: CGPoint(x: pathBound.maxX - cornerLength, y: pathBound.minY), size: size).inset(by: inset)
        let bottomLeftRect = CGRect(origin: CGPoint(x: pathBound.minX, y: pathBound.maxY - cornerLength), size: size).inset(by: inset)
        let bottomRightRect = CGRect(origin: CGPoint(x: pathBound.maxX - cornerLength, y: pathBound.maxY - cornerLength), size: size).inset(by: inset)
        
        if topLeftRect.contains(point) {
            return .topLeft
        }
        if topRightRect.contains(point) {
            return .topRight
        }
        if bottomLeftRect.contains(point) {
            return .bottomLeft
        }
        if bottomRightRect.contains(point) {
            return .bottomRight
        }
        return .none
    }
}
