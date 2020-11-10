//
//  XWAKTextSelectionView.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/11/9.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

struct XWAKSelectionPosition {
    var rect: CGRect
    var index: Int
    
    var minX: CGFloat { return rect.minX }
    var minY: CGFloat { return rect.minY }
    var maxX: CGFloat { return rect.maxX }
    var maxY: CGFloat { return rect.maxY }
    var width: CGFloat { return rect.width }
    var height: CGFloat { return rect.height }
}

extension XWAKSelectionPosition: Equatable {
    static let zero = XWAKSelectionPosition(rect: .zero, index: 0)
    
    static func ==(lhs: XWAKSelectionPosition, rhs: XWAKSelectionPosition) -> Bool {
        return lhs.rect == rhs.rect && lhs.index == lhs.index
    }
}

class XWAKTextSelectionView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        inits()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        inits()
    }
    private func inits() {
//        layer.addSublayer(selectionLayer)
//        selectionLayer.fillColor = UIColor.systemYellow.withAlphaComponent(0.5).cgColor
        
        layer.addSublayer(startCursor)
        startCursor.fillColor = UIColor.systemYellow.cgColor
    }
    public var lineBoundsHandler: ((_ index: Int) -> CGRect)!
    var layers = [CAShapeLayer]()
    var rects = [CGRect]()
    var start: XWAKSelectionPosition = .zero {
        didSet {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: start.minX - 10, y: start.minY - 10))
            path.addLine(to: CGPoint(x: start.maxX + 10, y: start.maxY - 10))
            path.addLine(to: CGPoint(x: start.minX, y: start.minY))
            path.addLine(to: CGPoint(x: start.minX - 10, y: start.minY - 10))
            startCursor.path = path.cgPath
            startCursor.frame = CGRect(x: start.minX - 10, y: start.minY - 10, width: 20, height: 20)
            startCursor.backgroundColor = UIColor.clear.cgColor
            update()
        }
    }
    var end: XWAKSelectionPosition = .zero {
        didSet {
            rects.removeAll()
            calculateRects()
            update()
                
        }
    }
    let startCursor = CAShapeLayer()
    let endCursor = CAShapeLayer()
    private var selectionLayer = CAShapeLayer()
    
    private func calculateRects() {
        guard end.rect != .zero else { return }
        if end.index == start.index { // 同一行
            if end.rect.minX > start.rect.minX { /// 由左往右选择
                rects.append(CGRect(x: start.minX, y: end.minY, width: end.maxX - start.minX, height: start.height))
            }
            else { /// 右往左， 需要换一下两个点的顺序
                rects.append(CGRect(x: end.minX, y: start.minY, width: start.maxX - end.minX, height: start.height))
            }
        }
        else {
            var (startR, endR) = (start, end)
            
            if end.minY < start.minY {
                (startR, endR) = (end, start)
            }
            let startRect = lineBoundsHandler(startR.index)
            rects.append(CGRect(x: startR.minX, y: startR.minY, width: startRect.width - startR.minX, height: startR.height))
            for index in (startR.index + 1)..<endR.index {
                let rect = lineBoundsHandler(index)
                if rect != .zero { rects.append(rect) }
            }
            rects.append(CGRect(x: 0, y: endR.minY, width: endR.maxX, height: endR.height))
        }
    }
    private func update() {
        layers.forEach { $0.removeFromSuperlayer() }
        
        for selectedRect in rects {
            let converLayer = CAShapeLayer()
            converLayer.frame = selectedRect
            converLayer.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.4).cgColor
            layers.append(converLayer)
            layer.addSublayer(converLayer)
        }
    }

}
