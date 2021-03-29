//
//  XWAKSVGElement.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2021/3/25.
//  Copyright © 2021 ZhuanagXiaowei. All rights reserved.
//

import UIKit

class XWAKSVGElement {
    var parent: XWAKSVGElement?
    var children = [XWAKSVGElement]()
    
    var tagName: String = ""
    var title: String?
    var id: String?
    var className: String?
    var transform: String?
    var group: String?
    var path: CGMutablePath = CGMutablePath()
    var strokeColor: UIColor = .black
    var fillColor: UIColor = .black
    var strokeWidth: Float = 1.0
    var style: String?
    var elements: [XWAKSVGElement] = []
    var scale: Float = 1.0
    
    var transform_origin: CGPoint = .zero
    var opacity: Float = 1.0
    
    required init(dict: [String: String]) {
        title = dict["title"]
        id = dict["id"]
        className = dict["class"]
        transform = dict["transform"]
        group = ""
        style = dict["style"]
        
        fillPath()
        
        if let style = style {
            let scan = Scanner(string: style)
            let skippedSet = CharacterSet(charactersIn: " :;,\n()")
            scan.charactersToBeSkipped = skippedSet
            var name: NSString?
            if scan.scanString("opacity", into: &name) && name != nil {
                var num: Float = 0
                if scan.scanFloat(&num) {
                    opacity = num
                }
            }
            if scan.scanString("stroke-width", into: &name) && name != nil {
                var num: Float = 0
                if scan.scanFloat(&num) {
                    strokeWidth = num
                }
            }
            if scan.scanString("fill", into: &name) && name != nil {
                var num: Double = 0
                var nums: [Double] = []
                var value: NSString?
                if scan.scanString("rgb", into: &value) {
                    while scan.scanDouble(&num) {
                        nums.append(num)
                    }
                    if nums.count == 3 {
                        fillColor = UIColor(displayP3Red: CGFloat(nums[0] / 255),
                                            green: CGFloat(nums[1] / 255),
                                            blue: CGFloat(nums[2] / 255),
                                            alpha: 1.0)
                    }
                }
                else if scan.scanString("#", into: &name) {
                    var hex: UInt64 = 0
                    scan.scanHexInt64(&hex)
                    fillColor = UIColor(displayP3Red: CGFloat(hex >> 16 & 0xFF) / 255,
                                        green: CGFloat(hex >> 8 & 0xFF) / 255,
                                        blue: CGFloat(hex & 0xFF) / 255,
                                        alpha: 1.0)
                }
                
            }
            if scan.scanString("transform-origin", into: &name) && name != nil {
                var (x, y): (Double, Double) = (0, 0)
                var px: NSString?
                scan.scanDouble(&x)
                scan.scanString("px", into: &px)
                scan.scanDouble(&y)
                transform_origin = .init(x: x, y: y)
            }
            
        }
    }
    
    public func fillPath() {
        
    }
}

struct Stack<T> {
    var items = [T]()
    mutating func pop() -> T {
        return items.removeLast()
    }
    
    mutating func push(_ item: T) {
        items.append(item)
    }
    
    func top() -> T? {
        return items.last
    }
}
