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
        return equal(l: left, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    public func left(greaterThan edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        return greater(l: left, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    public func left(lessThan edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        return less(l: left, r: edge, multiplier: multiplier, constant: constant)
    }
    
    @discardableResult
    public func right(equalTo edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        return equal(l: right, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    public func right(greaterThan edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        return greater(l: right, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    public func right(lessThan edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        return less(l: right, r: edge, multiplier: multiplier, constant: constant)
    }
    
    @discardableResult
    public func top(equalTo edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        return equal(l: top, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    public func top(greaterThan edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        return greater(l: top, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    public func top(lessThan edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        return less(l: top, r: edge, multiplier: multiplier, constant: constant)
    }
    
    @discardableResult
    public func bottom(equalTo edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        return equal(l: bottom, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    public func bottom(greaterThan edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        return greater(l: bottom, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    public func bottom(lessThan edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        return less(l: bottom, r: edge, multiplier: multiplier, constant: constant)
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
    public func centerX(equalTo edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        return equal(l: centerX, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    public func centerX(greaterThan edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        return greater(l: centerX, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    public func centerX(lessThan edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        return less(l: centerX, r: edge, multiplier: multiplier, constant: constant)
    }
    
    @discardableResult
    public func centerY(equalTo edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        return equal(l: centerY, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    public func centerY(greaterThan edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        return greater(l: centerY, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    public func centerY(lessThan edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        return less(l: centerY, r: edge, multiplier: multiplier, constant: constant)
    }
    
    @discardableResult
    public func center(equalTo center: XWAKLayout, multiplier: CGFloat = 1.0, _ offset: (x: CGFloat, y: CGFloat) = (0, 0)) -> XWAKLayout {
        return self.centerX(equalTo: center.centerX, multiplier: multiplier, offset.x)
            .centerY(equalTo: center.centerY, multiplier: multiplier, offset.y)
    }
//    @discardableResult
//    public func center(greaterThan center: XWAKLayout, multiplier: CGFloat = 1.0, _ offset: (x: CGFloat, y: CGFloat) = (0, 0)) -> XWAKLayout {
//        return self.centerX(greaterThan: center.centerX, multiplier: multiplier, offset.x)
//            .centerY(greaterThan: center.centerY, multiplier: multiplier, offset.y)
//    }
//    @discardableResult
//    public func center(lessThan center: XWAKLayout, multiplier: CGFloat = 1.0, _ offset: (x: CGFloat, y: CGFloat) = (0, 0)) -> XWAKLayout {
//        return self.centerX(lessThan: center.centerX, multiplier: multiplier, offset.x)
//            .centerY(lessThan: center.centerY, multiplier: multiplier, offset.y)
//    }
    
    @discardableResult
    public func width(equalTo edge: XWAKLayoutConstrait? = nil, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        return equal(l: width, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    public func width(greaterThan edge: XWAKLayoutConstrait?, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        return greater(l: width, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    public func width(lessThan edge: XWAKLayoutConstrait?, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        return less(l: width, r: edge, multiplier: multiplier, constant: constant)
    }
    
    @discardableResult
    public func height(equalTo edge: XWAKLayoutConstrait? = nil, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        return equal(l: height, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    public func height(greaterThan edge: XWAKLayoutConstrait?, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        return greater(l: height, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    public func height(lessThan edge: XWAKLayoutConstrait?, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        return less(l: height, r: edge, multiplier: multiplier, constant: constant)
    }
    
    @discardableResult
    public func size(equalTo center: XWAKLayout? = nil, multiplier: CGFloat = 1.0, _ size: (width: CGFloat , height: CGFloat) = (0, 0)) -> XWAKLayout {
        return self.width(equalTo: center?.width, multiplier: multiplier, size.width)
            .height(equalTo: center?.height, multiplier: multiplier, size.height)
    }
    @discardableResult
    public func size(greaterThan center: XWAKLayout?, multiplier: CGFloat = 1.0, _ size: (width: CGFloat , height: CGFloat) = (0, 0)) -> XWAKLayout {
        return self.width(greaterThan: center?.width, multiplier: multiplier, size.width)
            .height(greaterThan: center?.height, multiplier: multiplier, size.height)
    }
    @discardableResult
    public func size(lessThan center: XWAKLayout?, multiplier: CGFloat = 1.0, _ size: (width: CGFloat , height: CGFloat) = (0, 0)) -> XWAKLayout {
        return self.width(lessThan: center?.width, multiplier: multiplier, size.width)
            .height(lessThan: center?.height, multiplier: multiplier, size.height)
    }
    
    private func equal(l: XWAKLayoutConstrait, r: XWAKLayoutConstrait?, multiplier: CGFloat = 1.0, constant: CGFloat) -> XWAKLayout {
        let constraint = l.equal(r, multiplier: multiplier, constant: constant)
        NSLayoutConstraint.activate([constraint])
        return self
    }
    
    private func greater(l: XWAKLayoutConstrait, r: XWAKLayoutConstrait?, multiplier: CGFloat = 1.0, constant: CGFloat) -> XWAKLayout {
        l.greater(r, multiplier: multiplier, constant: constant).isActive = true
        return self
    }
    
    private func less(l: XWAKLayoutConstrait, r: XWAKLayoutConstrait?, multiplier: CGFloat = 1.0, constant: CGFloat) -> XWAKLayout {
        l.less(r, multiplier: multiplier, constant: constant).isActive = true
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
    
    fileprivate func less(_ to: XWAKLayoutConstrait? = nil, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        if to == nil {
            return NSLayoutConstraint(item: upper.target,
                                      attribute: attribute,
                                      relatedBy: .lessThanOrEqual,
                                      toItem: nil,
                                      attribute: .notAnAttribute,
                                      multiplier: multiplier,
                                      constant: constant)
        }
        return NSLayoutConstraint(item: upper.target,
                                  attribute: attribute,
                                  relatedBy: .lessThanOrEqual,
                                  toItem: to!.upper.target,
                                  attribute: to!.attribute,
                                  multiplier: multiplier,
                                  constant: constant)
    }
    
    fileprivate func greater(_ to: XWAKLayoutConstrait? = nil, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        if to == nil {
            return NSLayoutConstraint(item: upper.target,
                                      attribute: attribute,
                                      relatedBy: .greaterThanOrEqual,
                                      toItem: nil,
                                      attribute: .notAnAttribute,
                                      multiplier: multiplier,
                                      constant: constant)
        }
        return NSLayoutConstraint(item: upper.target,
                                  attribute: attribute,
                                  relatedBy: .greaterThanOrEqual,
                                  toItem: to!.upper.target,
                                  attribute: to!.attribute,
                                  multiplier: multiplier,
                                  constant: constant)
    }
    
}

public extension UIView {
    var xwak: XWAKLayout {
//        assert(translatesAutoresizingMaskIntoConstraints == false, "translatesAutoresizingMaskIntoConstraints is not set to false")
        return XWAKLayout(targetView: self)
    }
}

public extension UILayoutGuide {
    var xwak: XWAKLayout {
        return XWAKLayout(targetView: self)
    }
}
