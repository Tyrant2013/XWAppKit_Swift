//
//  XWAKGeometry.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/9/25.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import Foundation
import CoreGraphics

public func getIntersection(segment1: (CGPoint, CGPoint), segment2: (CGPoint, CGPoint)) -> CGPoint? {
    let p1 = segment1.0
    let p2 = segment1.1
    let p3 = segment2.0
    let p4 = segment2.1
    let d = (p2.x - p1.x) * (p4.y - p3.y) - (p2.y - p1.y) * (p4.x - p3.x)
    if d == 0 {
        return nil // 平行线
    }
    
    let u = ((p3.x - p1.x) * (p4.y - p3.y) - (p3.y - p1.y) * (p4.x - p3.x)) / d
    let v = ((p3.x - p1.x) * (p2.y - p1.y) - (p3.y - p1.y) * (p2.x - p1.x)) / d
    
    if u < 0.0 || u > 1.0 {
        return nil // 相交的点不在 p1 和 p2 之间
    }
    
    if v < 0.0 || v > 1.0 {
        return nil // 相交的点不在 p3 和 p4 之间
    }
    
    return CGPoint(x: p1.x + u * (p2.x - p1.x), y: p1.y + u * (p2.y - p1.y))
}

public func getIntersection(rect: CGRect, segment: (CGPoint, CGPoint)) -> CGPoint? {
    let rMinMin = CGPoint(x: rect.minX, y: rect.minY)
    let rMinMax = CGPoint(x: rect.minX, y: rect.maxY)
    let rMaxMin = CGPoint(x: rect.maxX, y: rect.minY)
    let rMaxMax = CGPoint(x: rect.maxX, y: rect.maxY)
    
    if let point = getIntersection(segment1: (rMinMin, rMinMax), segment2: segment) {
        return point
    }
    if let point = getIntersection(segment1: (rMinMin, rMaxMin), segment2: segment) {
        return point
    }
    if let point = getIntersection(segment1: (rMinMax, rMaxMax), segment2: segment) {
        return point
    }
    if let point = getIntersection(segment1: (rMaxMin, rMaxMax), segment2: segment) {
        return point
    }
    return nil
}
