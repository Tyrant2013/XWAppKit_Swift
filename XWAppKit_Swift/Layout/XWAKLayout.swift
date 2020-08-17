//
//  XWAKLayout.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/8/17.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public class XWAKLayout: NSObject {
    fileprivate let target: UIView
    
    lazy public var left = XWAKLayoutConstrait(edge: .left, upper: self)
    lazy public var right = XWAKLayoutConstrait(edge: .right, upper: self)
    lazy public var top = XWAKLayoutConstrait(edge: .top, upper: self)
    lazy public var bottom = XWAKLayoutConstrait(edge: .bottom, upper: self)
    lazy public var centerX = XWAKLayoutConstrait(edge: .centerX, upper: self)
    lazy public var centerY = XWAKLayoutConstrait(edge: .centerY, upper: self)
    lazy public var width = XWAKLayoutConstrait(edge: .width, upper: self)
    lazy public var height = XWAKLayoutConstrait(edge: .height, upper: self)
    
    init(targetView: UIView) {
        self.target = targetView
        super.init()
    }
    
    public func left(equalTo edge: XWAKLayoutConstrait) -> XWAKLayout {
        let constraint = self.left.equal(edge)
        edge.upper.target.addConstraint(constraint)
        return self
    }
    public func right(equalTo edge: XWAKLayoutConstrait) -> XWAKLayout {
        let constraint = self.right.equal(edge)
        edge.upper.target.addConstraint(constraint)
        return self
    }
    public func centerX(equalTo edge: XWAKLayoutConstrait) -> XWAKLayout {
        let constraint = self.centerX.equal(edge)
        edge.upper.target.addConstraint(constraint)
        return self
    }
    public func centerY(equalTo edge: XWAKLayoutConstrait) -> XWAKLayout {
        let constraint = self.centerY.equal(edge)
        edge.upper.target.addConstraint(constraint)
        return self
    }
    public func width(equalTo edge: XWAKLayoutConstrait? = nil, _ constant: CGFloat = 0.0) -> XWAKLayout {
        let constraint = self.width.equal(edge, constant: constant)
        if edge == nil {
            target.addConstraint(constraint)
        }
        else {
            edge!.upper.target.addConstraint(constraint)
        }
        return self
    }
    public func height(equalTo edge: XWAKLayoutConstrait? = nil, _ constant: CGFloat = 0.0) -> XWAKLayout {
        let constraint = self.height.equal(edge, constant: constant)
        if edge == nil {
            target.addConstraint(constraint)
        }
        else {
            edge!.upper.target.addConstraint(constraint)
        }
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
    
    public func equal(_ to: XWAKLayoutConstrait? = nil, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) -> NSLayoutConstraint {
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
