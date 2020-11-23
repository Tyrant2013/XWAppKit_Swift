//
//  XWAKLayout.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/8/17.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public enum XWAKEqualEdge {
    case left
    case right
    case top
    case bottom
    case all
}

public class XWAKLayout: NSObject {
    fileprivate let target: Any
    
    lazy public var left = XWAKLayoutConstrait(edge: .left, upper: self)
    lazy public var right = XWAKLayoutConstrait(edge: .right, upper: self)
    lazy public var top = XWAKLayoutConstrait(edge: .top, upper: self)
    lazy public var bottom = XWAKLayoutConstrait(edge: .bottom, upper: self)
    lazy public var centerX = XWAKLayoutConstrait(edge: .centerX, upper: self)
    lazy public var centerY = XWAKLayoutConstrait(edge: .centerY, upper: self)
    lazy public var width = XWAKLayoutConstrait(edge: .width, upper: self)
    lazy public var height = XWAKLayoutConstrait(edge: .height, upper: self)
    
    init(targetView: Any) {
        self.target = targetView
        super.init()
    }
    
    @discardableResult
    public func left(equalTo edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        return equal(l: left, r: edge, multiplier: multiplier, constatnt: constant)
    }
    @discardableResult
    public func right(equalTo edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        return equal(l: right, r: edge, multiplier: multiplier, constatnt: constant)
    }
    @discardableResult
    public func top(equalTo edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        return equal(l: top, r: edge, multiplier: multiplier, constatnt: constant)
    }
    @discardableResult
    public func bottom(equalTo edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        return equal(l: bottom, r: edge, multiplier: multiplier, constatnt: constant)
    }
    @discardableResult
    public func centerX(equalTo edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        return equal(l: centerX, r: edge, multiplier: multiplier, constatnt: constant)
    }
    @discardableResult
    public func centerY(equalTo edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        return equal(l: centerY, r: edge, multiplier: multiplier, constatnt: constant)
    }
    @discardableResult
    public func width(equalTo edge: XWAKLayoutConstrait? = nil, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        return equal(l: width, r: edge, multiplier: multiplier, constatnt: constant)
    }
    @discardableResult
    public func height(equalTo edge: XWAKLayoutConstrait? = nil, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        return equal(l: height, r: edge, multiplier: multiplier, constatnt: constant)
    }
    
    @discardableResult
    public func edge(equalTo edge: XWAKLayout, multiplier: CGFloat = 1.0, inset: CGFloat = 0.0, edges: [XWAKEqualEdge]) -> XWAKLayout {
        let edgeInset = UIEdgeInsets(top: inset, left: inset, bottom: -inset, right: -inset)
        return self.edge(equalTo: edge, multiplier: multiplier, inset: edgeInset, edges: edges)
    }
    @discardableResult
    public func edge(equalTo edge: XWAKLayout, multiplier: CGFloat = 1.0, inset: UIEdgeInsets = .zero, edges: [XWAKEqualEdge]) -> XWAKLayout {
        if edges.contains(.all) {
            self.left(equalTo: edge.left, multiplier: multiplier, inset.left)
                .right(equalTo: edge.right, multiplier: multiplier, inset.right)
                .top(equalTo: edge.top, multiplier: multiplier, inset.top)
                .bottom(equalTo: edge.bottom, multiplier: multiplier, inset.bottom)
        }
        else {
            if edges.contains(.left) {
                self.left(equalTo: edge.left, multiplier: multiplier, inset.left)
            }
            if edges.contains(.right) {
                self.right(equalTo: edge.right, multiplier: multiplier, inset.right)
            }
            if edges.contains(.top) {
                self.top(equalTo: edge.top, multiplier: multiplier, inset.top)
            }
            if edges.contains(.bottom) {
                self.bottom(equalTo: edge.bottom, multiplier: multiplier, inset.bottom)
            }
        }
        return self
    }
    @discardableResult
    public func center(equalTo center: XWAKLayout, multiplier: CGFloat = 1.0, _ offset: (x: CGFloat, y: CGFloat) = (0, 0)) -> XWAKLayout {
        return self.centerX(equalTo: center.centerX, multiplier: multiplier, offset.x)
            .centerY(equalTo: center.centerY, multiplier: multiplier, offset.y)
    }
    @discardableResult
    public func size(equalTo center: XWAKLayout? = nil, multiplier: CGFloat = 1.0, _ size: (width: CGFloat , height: CGFloat) = (0, 0)) -> XWAKLayout {
        return self.width(equalTo: center?.width, multiplier: multiplier, size.width)
            .height(equalTo: center?.height, multiplier: multiplier, size.height)
    }
    
    private func equal(l: XWAKLayoutConstrait, r: XWAKLayoutConstrait?, multiplier: CGFloat = 0.0, constatnt: CGFloat) -> XWAKLayout {
        let constraint = l.equal(r, multiplier: multiplier, constant: constatnt)
        NSLayoutConstraint.activate([constraint])
        return self
    }
}

enum XWAKLayoutEdge {
    case left
    case right
    case top
    case bottom
    case centerX
    case centerY
    case width
    case height
}

public class XWAKLayoutConstrait: NSObject {
    private let edge: XWAKLayoutEdge
    fileprivate let upper: XWAKLayout
    private var attribute: NSLayoutConstraint.Attribute {
        switch edge {
        case .left:
            return .leading
        case .right:
            return .trailing
        case .top:
            return .top
        case .bottom:
            return .bottom
        case .centerX:
            return .centerX
        case .centerY:
            return .centerY
        case .width:
            return .width
        case .height:
            return .height
        }
    }
    init(edge: XWAKLayoutEdge, upper: XWAKLayout) {
        self.edge = edge
        self.upper = upper
        super.init()
    }
    
    fileprivate func equal(_ to: XWAKLayoutConstrait? = nil, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        if to == nil {
            return NSLayoutConstraint(item: upper.target,
                                      attribute: attribute,
                                      relatedBy: .equal,
                                      toItem: nil,
                                      attribute: .notAnAttribute,
                                      multiplier: multiplier,
                                      constant: constant)
        }
        return NSLayoutConstraint(item: upper.target,
                                  attribute: attribute,
                                  relatedBy: .equal,
                                  toItem: to!.upper.target,
                                  attribute: to!.attribute,
                                  multiplier: multiplier,
                                  constant: constant)
    }
    
    
}

public extension UIView {
    var xwak: XWAKLayout {
        return XWAKLayout(targetView: self)
    }
}

public extension UILayoutGuide {
    var xwak: XWAKLayout {
        return XWAKLayout(targetView: self)
    }
}
