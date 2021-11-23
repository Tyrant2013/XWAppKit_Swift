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

public extension XWAKLayout {
    
}

public class XWAKLayout: NSObject {
    fileprivate weak var target: AnyObject?
    
    lazy public var left = XWAKLayoutConstrait(edge: .left, upper: self)
    lazy public var leading = XWAKLayoutConstrait(edge: .leading, upper: self)
    lazy public var trailing = XWAKLayoutConstrait(edge: .trailing, upper: self)
    lazy public var right = XWAKLayoutConstrait(edge: .right, upper: self)
    lazy public var top = XWAKLayoutConstrait(edge: .top, upper: self)
    lazy public var bottom = XWAKLayoutConstrait(edge: .bottom, upper: self)
    lazy public var centerX = XWAKLayoutConstrait(edge: .centerX, upper: self)
    lazy public var centerY = XWAKLayoutConstrait(edge: .centerY, upper: self)
    lazy public var width = XWAKLayoutConstrait(edge: .width, upper: self)
    lazy public var height = XWAKLayoutConstrait(edge: .height, upper: self)
    
    /// 竖屏起效的约束, 添加到这里面的约束会自动设置为false, 需要调用activeVerticals方法才能生效
    public var verticalLayouts: [XWAKLayoutConstrait] = [] {
        didSet {
            disableAll()
        }
    }
    /// 横屏起效的约束, 添加到这里面的约束会自动设置为false, 需要调用activeHorizontals方法才能生效
    public var horizontalLayouts: [XWAKLayoutConstrait] = [] {
        didSet {
            disableAll()
        }
    }
    /// 添加完约束后自动生效, 默认值为 true, 必须优先于约束设置才能生效，否则只会影响设置后的约束设置
    public var autoActive: Bool = true
    /// 使添加到 verticalLayouts 和 horizontalLayouts 里的约束失效
    public func disableAll() {
        verticalLayouts.forEach { $0.isActive = false }
        horizontalLayouts.forEach { $0.isActive = false }
    }
    /// 使添加到 verticalLayouts 里的约束生效
    public func activeVerticals() {
        verticalLayouts.forEach { $0.isActive = true }
    }
    /// 使添加到 verticalLayouts 里的约束生效
    public func activeHorizontals() {
        horizontalLayouts.forEach { $0.isActive = true }
    }
    
    init(targetView: AnyObject) {
        self.target = targetView
        super.init()
        
        NotificationCenter.default.addObserver(forName: UIApplication.didChangeStatusBarFrameNotification, object: nil, queue: OperationQueue.main) { [self] _ in
            let orientation = UIApplication.shared.statusBarOrientation
            self.disableAll()
            orientation.isPortrait ? self.activeVerticals() : self.activeHorizontals()
        }
    }
    
    private func equal(l: XWAKLayoutConstrait, r: XWAKLayoutConstrait?, multiplier: CGFloat = 1.0, constant: CGFloat) -> XWAKLayout {
        l.equal(r, multiplier: multiplier, constant: constant).isActive = autoActive
        return self
    }
    
    private func greater(l: XWAKLayoutConstrait, r: XWAKLayoutConstrait?, multiplier: CGFloat = 1.0, constant: CGFloat) -> XWAKLayout {
        l.greater(r, multiplier: multiplier, constant: constant).isActive = autoActive
        return self
    }
    
    private func less(l: XWAKLayoutConstrait, r: XWAKLayoutConstrait?, multiplier: CGFloat = 1.0, constant: CGFloat) -> XWAKLayout {
        l.less(r, multiplier: multiplier, constant: constant).isActive = autoActive
        return self
    }
}

public extension XWAKLayout {
    @discardableResult
    func left(equalTo edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        equal(l: left, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    func left(greaterThan edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        greater(l: left, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    func left(lessThan edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        less(l: left, r: edge, multiplier: multiplier, constant: constant)
    }
    
    @discardableResult
    func right(equalTo edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        equal(l: right, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    func right(greaterThan edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        greater(l: right, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    func right(lessThan edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        less(l: right, r: edge, multiplier: multiplier, constant: constant)
    }
    
    @discardableResult
    func top(equalTo edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        equal(l: top, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    func top(greaterThan edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        greater(l: top, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    func top(lessThan edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        less(l: top, r: edge, multiplier: multiplier, constant: constant)
    }
    
    @discardableResult
    func bottom(equalTo edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        equal(l: bottom, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    func bottom(greaterThan edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        greater(l: bottom, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    func bottom(lessThan edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        less(l: bottom, r: edge, multiplier: multiplier, constant: constant)
    }
    
    @discardableResult
    func edge(equalTo edge: XWAKLayout, multiplier: CGFloat = 1.0, inset: CGFloat, edges: [XWAKEqualEdge]) -> XWAKLayout {
        let edgeInset = UIEdgeInsets(top: inset, left: inset, bottom: -inset, right: -inset)
        return self.edge(equalTo: edge, multiplier: multiplier, inset: edgeInset, edges: edges)
    }
    @discardableResult
    func edge(equalTo edge: XWAKLayout, multiplier: CGFloat = 1.0, inset: UIEdgeInsets, edges: [XWAKEqualEdge]) -> XWAKLayout {
        if edges.contains(.all) {
            left(equalTo: edge.left, multiplier: multiplier, inset.left)
                .right(equalTo: edge.right, multiplier: multiplier, inset.right)
                .top(equalTo: edge.top, multiplier: multiplier, inset.top)
                .bottom(equalTo: edge.bottom, multiplier: multiplier, inset.bottom)
        }
        else {
            if edges.contains(.left) {
                left(equalTo: edge.left, multiplier: multiplier, inset.left)
            }
            if edges.contains(.right) {
                right(equalTo: edge.right, multiplier: multiplier, inset.right)
            }
            if edges.contains(.top) {
                top(equalTo: edge.top, multiplier: multiplier, inset.top)
            }
            if edges.contains(.bottom) {
                bottom(equalTo: edge.bottom, multiplier: multiplier, inset.bottom)
            }
        }
        return self
    }
    
    @discardableResult
    func centerX(equalTo edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        equal(l: centerX, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    func centerX(greaterThan edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        greater(l: centerX, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    func centerX(lessThan edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        less(l: centerX, r: edge, multiplier: multiplier, constant: constant)
    }
    
    @discardableResult
    func centerY(equalTo edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        equal(l: centerY, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    func centerY(greaterThan edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        greater(l: centerY, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    func centerY(lessThan edge: XWAKLayoutConstrait, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        less(l: centerY, r: edge, multiplier: multiplier, constant: constant)
    }
    
    @discardableResult
    func center(equalTo center: XWAKLayout, multiplier: CGFloat = 1.0, _ offset: (x: CGFloat, y: CGFloat) = (0, 0)) -> XWAKLayout {
        centerX(equalTo: center.centerX, multiplier: multiplier, offset.x)
            .centerY(equalTo: center.centerY, multiplier: multiplier, offset.y)
    }
    @discardableResult
    func center(greaterThan center: XWAKLayout, multiplier: CGFloat = 1.0, _ offset: (x: CGFloat, y: CGFloat) = (0, 0)) -> XWAKLayout {
        centerX(greaterThan: center.centerX, multiplier: multiplier, offset.x)
            .centerY(greaterThan: center.centerY, multiplier: multiplier, offset.y)
    }
    @discardableResult
    func center(lessThan center: XWAKLayout, multiplier: CGFloat = 1.0, _ offset: (x: CGFloat, y: CGFloat) = (0, 0)) -> XWAKLayout {
        centerX(lessThan: center.centerX, multiplier: multiplier, offset.x)
            .centerY(lessThan: center.centerY, multiplier: multiplier, offset.y)
    }
    
    @discardableResult
    func width(equalTo edge: XWAKLayoutConstrait? = nil, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        equal(l: width, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    func width(greaterThan edge: XWAKLayoutConstrait?, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        greater(l: width, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    func width(lessThan edge: XWAKLayoutConstrait?, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        less(l: width, r: edge, multiplier: multiplier, constant: constant)
    }
    
    @discardableResult
    func height(equalTo edge: XWAKLayoutConstrait? = nil, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        equal(l: height, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    func height(greaterThan edge: XWAKLayoutConstrait?, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        greater(l: height, r: edge, multiplier: multiplier, constant: constant)
    }
    @discardableResult
    func height(lessThan edge: XWAKLayoutConstrait?, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0.0) -> XWAKLayout {
        less(l: height, r: edge, multiplier: multiplier, constant: constant)
    }
    
    @discardableResult
    func size(equalTo center: XWAKLayout? = nil, multiplier: CGFloat = 1.0, _ size: (width: CGFloat , height: CGFloat) = (0, 0)) -> XWAKLayout {
        width(equalTo: center?.width, multiplier: multiplier, size.width)
            .height(equalTo: center?.height, multiplier: multiplier, size.height)
    }
    @discardableResult
    func size(greaterThan center: XWAKLayout?, multiplier: CGFloat = 1.0, _ size: (width: CGFloat , height: CGFloat) = (0, 0)) -> XWAKLayout {
        width(greaterThan: center?.width, multiplier: multiplier, size.width)
            .height(greaterThan: center?.height, multiplier: multiplier, size.height)
    }
    @discardableResult
    func size(lessThan center: XWAKLayout?, multiplier: CGFloat = 1.0, _ size: (width: CGFloat , height: CGFloat) = (0, 0)) -> XWAKLayout {
        width(lessThan: center?.width, multiplier: multiplier, size.width)
            .height(lessThan: center?.height, multiplier: multiplier, size.height)
    }
}

enum XWAKLayoutEdge {
    case left, right, leading, trailing, top, bottom, centerX, centerY, width, height
}

public class XWAKLayoutConstrait: NSObject {
    private let edge: XWAKLayoutEdge
    fileprivate let upper: XWAKLayout
    private var constraint: NSLayoutConstraint?
    public var constant: CGFloat {
        get { return constraint?.constant ?? 0 }
        set { constraint?.constant = newValue }
    }
    public var multiplier: CGFloat {
        get { return constraint?.multiplier ?? 0 }
        set {
            guard let cs = constraint else { return }
            constraint = NSLayoutConstraint(item: cs.firstItem!,
                                            attribute: cs.firstAttribute,
                                            relatedBy: cs.relation,
                                            toItem: cs.secondItem,
                                            attribute: cs.secondAttribute,
                                            multiplier: newValue,
                                            constant: cs.constant)
            cs.isActive = false
            constraint?.isActive = true
        }
    }
    public var isActive: Bool {
        get { constraint?.isActive ?? false }
        set { constraint?.isActive = newValue }
    }
    
    private var attribute: NSLayoutConstraint.Attribute {
        switch edge {
        case .left:     return .left
        case .right:    return .right
        case .leading:  return .leading
        case .trailing: return .trailing
        case .top:      return .top
        case .bottom:   return .bottom
        case .centerX:  return .centerX
        case .centerY:  return .centerY
        case .width:    return .width
        case .height:   return .height
        }
    }
    init(edge: XWAKLayoutEdge, upper: XWAKLayout) {
        self.edge = edge
        self.upper = upper
        super.init()
    }
    
    fileprivate func equal(_ to: XWAKLayoutConstrait? = nil, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        makeConstraint(to, multiplier: multiplier, constant: constant, relatedBy: .equal)
    }
    
    fileprivate func less(_ to: XWAKLayoutConstrait? = nil, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        makeConstraint(to, multiplier: multiplier, constant: constant, relatedBy: .lessThanOrEqual)
    }
    
    fileprivate func greater(_ to: XWAKLayoutConstrait? = nil, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        makeConstraint(to, multiplier: multiplier, constant: constant, relatedBy: .greaterThanOrEqual)
    }
    
    fileprivate func makeConstraint(_ to: XWAKLayoutConstrait? = nil,
                                    multiplier: CGFloat,
                                    constant: CGFloat,
                                    relatedBy: NSLayoutConstraint.Relation) -> NSLayoutConstraint {
        guard constraint == nil else { return constraint! }
        let noTo = to == nil
        let toItem = noTo ? nil : to!.upper.target
        let toAttribute: NSLayoutConstraint.Attribute = noTo ? .notAnAttribute : to!.attribute
        constraint = NSLayoutConstraint(item: upper.target as Any,
                                        attribute: attribute,
                                        relatedBy: relatedBy,
                                        toItem: toItem,
                                        attribute: toAttribute,
                                        multiplier: multiplier,
                                        constant: constant)
        return constraint!
    }
    
}

fileprivate var XWAKKey = "XWAKKey"

public extension UIView {
    var xwak: XWAKLayout {
        get {
            var obj = objc_getAssociatedObject(self, &XWAKKey) as? XWAKLayout
            if obj == nil {
                
                obj = XWAKLayout(targetView: self)
                objc_setAssociatedObject(self, &XWAKKey, obj, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
            return obj!
        }
    }
}

public extension UILayoutGuide {
    var xwak: XWAKLayout {
        get {
            var obj = objc_getAssociatedObject(self, &XWAKKey) as? XWAKLayout
            if obj == nil {
                obj = XWAKLayout(targetView: self)
                objc_setAssociatedObject(self, &XWAKKey, obj, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
            return obj!
        }
    }
}
