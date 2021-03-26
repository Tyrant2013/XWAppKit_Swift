//
//  XWAKSVGPath.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2021/3/26.
//  Copyright © 2021 ZhuanagXiaowei. All rights reserved.
//

import UIKit

class XWAKSVGPath: XWAKSVGElement {
    private(set) var cmds: [(cmd: String , points: [Double])] = []
    required init(dict: [String : String]) {
        if let data = dict["d"] {
            let scaner = Scanner(string: data)
            let skippedSet = CharacterSet(charactersIn: " ,\n")
            let commandSet = CharacterSet(charactersIn: "MLACQSTHVZmlacqsthvz")
            scaner.charactersToBeSkipped = skippedSet
            var cmd: NSString?
            while scaner.scanCharacters(from: commandSet, into: &cmd), var cmd = cmd as String? {
                if cmd.count > 1 {
                    cmd = String(cmd.last!)
                }
                var num: Double = 0
                var nums: [Double] = []
                while scaner.scanDouble(&num) {
                    nums.append(num)
                }
                cmds.append((cmd, nums))
            }
        }
        
        super.init(dict: dict)
        tagName = "path"
    }
    
//    override func draw() {
        
//
//    }
    override func fillPath() {
        var lastPoint: CGPoint = .zero
        var cpre: CGPoint = .zero
        var qpre: CGPoint = .zero
        for (cmd, nums) in cmds {
            switch cmd {
            case "M", "m":
                for index in stride(from: 0, to: nums.count, by: 2) {
                    var (x, y) = (nums[index], nums[index + 1])
                    if cmd == "m" {
                        (x, y) = (Double(lastPoint.x) + x, Double(lastPoint.y) + y)
                    }
                    lastPoint = .init(x: x, y: y)
                    path.move(to: lastPoint)
//                    print("\(cmd): move to: (\(x), \(y))")
                }
            case "L", "l":
                for index in stride(from: 0, to: nums.count, by: 2) {
                    var (x, y) = (nums[index], nums[index + 1])
                    if cmd == "l" {
                        (x, y) = (Double(lastPoint.x) + x, Double(lastPoint.y) + y)
                    }
                    lastPoint = .init(x: x, y: y)
                    path.addLine(to: lastPoint)
//                    print("\(cmd): line to (\(x), \(y))")
                }
            case "A", "a":
//  Elliptical Arc，允许不闭合。可以想像成是椭圆的某一段，共七个参数。
//　RX,RY指所在椭圆的半轴大小
//　XROTATION指椭圆的X轴与水平方向顺时针方向夹角，可以想像成一个水平的椭圆绕中心点顺时针旋转XROTATION的角度。
//　FLAG1只有两个值，1表示大角度弧线，0为小角度弧线。
//　FLAG2只有两个值，确定从起点至终点的方向，1为顺时针，0为逆时针
//　X,Y为终点坐标
                for _ in stride(from: 0, to: nums.count, by: 7) {
                    var (rx, ry, xRotation, largeArcFlag, sweep, x, y) = (nums[0], nums[1], nums[2], nums[3], nums[4], nums[5], nums[6])
                    if cmd == "a" {
                        (x, y) = (x + Double(lastPoint.x), y + Double(lastPoint.y))
                    }
                    let clockwise = sweep == 1.0
                    let startAngle = sin(xRotation * .pi / 180.0)
                    let endAngle = cos(xRotation * .pi / 180.0)
                    let center = CGPoint(x: x - rx, y: y - ry)
//                    path.addArc(withCenter: center, radius: CGFloat(rx), startAngle: 0, endAngle: CGFloat(endAngle), clockwise: clockwise)
//                    lastPoint = .init(x: x, y: y)
                }
            case "C", "c":
                for index in stride(from: 0, to: nums.count, by: 6) {
                    var (cx1, cy1, cx2, cy2, x, y) = (nums[index], nums[index + 1], nums[index + 2], nums[index + 3], nums[index + 4], nums[index + 5])
                    if cmd == "c" {
                        (cx1, cy1, cx2, cy2, x, y) = (cx1 + Double(lastPoint.x),
                                                      cy1 + Double(lastPoint.y),
                                                      cx2 + Double(lastPoint.x),
                                                      cy2 + Double(lastPoint.y),
                                                      x + Double(lastPoint.x),
                                                      y + Double(lastPoint.y))
                    }
                    lastPoint = .init(x: x, y: y)
                    cpre = .init(x: cx2, y: cy2)
                    path.addCurve(to: lastPoint,
                                  controlPoint1: .init(x: cx1, y: cy1),
                                  controlPoint2: cpre)
//                    print("\(cmd): add curve to (\(x), \(y)), c1: (\(cx1), \(cy1)), c2: (\(cx2), \(cy2))")
                }
            case "Q", "q":
                for index in stride(from: 0, to: nums.count, by: 4) {
                    var (cx, cy, x, y) = (nums[index], nums[index + 1], nums[index + 2], nums[index + 3])
                    if cmd == "q" {
                        (cx, cy, x, y) = (cx + Double(lastPoint.x),
                                          cy + Double(lastPoint.y),
                                          x + Double(lastPoint.x),
                                          y + Double(lastPoint.y))
                    }
                    lastPoint = .init(x: x, y: y)
                    qpre = .init(x: cx, y: cy)
                    path.addQuadCurve(to: lastPoint, controlPoint: qpre)
//                    print("\(cmd): add QuadCurve to (\(x), \(y)), c: (\(cx), \(cy))")
                }
            case "S", "s":
                for index in stride(from: 0, to: nums.count, by: 4) {
                    var (cx2, cy2, x, y) = (nums[index], nums[index + 1], nums[index + 2], nums[index + 3])
                    if cmd == "s" {
                        (cx2, cy2, x, y) = (cx2 + Double(lastPoint.x),
                                            cy2 + Double(lastPoint.y),
                                            x + Double(lastPoint.x),
                                            y + Double(lastPoint.y))
                    }
                    let c2 = CGPoint(x: cx2, y: cy2)
                    var c1: CGPoint
                    if cpre == .zero {
                        c1 = c2
                    }
                    else {
                        c1 = .init(x: lastPoint.x + (lastPoint.x - cpre.x),
                                   y: lastPoint.y + (lastPoint.y - cpre.y))
                    }
                    lastPoint = .init(x: x, y: y)
                    path.addCurve(to: lastPoint, controlPoint1: c1, controlPoint2: c2)
//                    print("\(cmd): add curve to (\(x), \(y)), c1: (\(c1.x), \(c1.y)), c2: (\(cx2), \(cy2))")
                }
            case "T", "t":
                for index in stride(from: 0, to: nums.count, by: 2) {
                    var (x, y) = (nums[index], nums[index + 1])
                    if cmd == "t" {
                        (x, y) = (x + Double(lastPoint.x),
                                  y + Double(lastPoint.y))
                    }
                    let p = CGPoint(x: x, y: y)
                    var c: CGPoint
                    if qpre == .zero {
                        c = p
                    }
                    else {
                        c = .init(x: lastPoint.x + (lastPoint.x - qpre.x),
                                  y: lastPoint.y + (lastPoint.y - qpre.y))
                    }
                    path.addQuadCurve(to: p, controlPoint: c)
                    lastPoint = p
                    qpre = c
//                    print("\(cmd): add QuadCurve to (\(x), \(y)), c: (\(c.x), \(c.y))")
                }
                
            case "H", "h":
                for index in 0..<nums.count {
                    var (x, y) = (nums[index], lastPoint.y)
                    if cmd == "h" {
                        x = x + Double(lastPoint.x)
                    }
                    lastPoint = .init(x: x, y: Double(y))
                    path.addLine(to: lastPoint)
//                    print("\(cmd): line to (\(x), \(y))")
                }
            case "V", "v":
                for index in 0..<nums.count {
                    var (x, y) = (lastPoint.x, nums[index])
                    if cmd == "v" {
                        y = y + Double(lastPoint.y)
                    }
                    lastPoint = .init(x: Double(x), y: y)
                    path.addLine(to: lastPoint)
//                    print("\(cmd): line to (\(x), \(y))")
                }
            case "Z", "z":
//                print("close")
                path.close()
            default:
                print("未处理的CMD")
            }
        }
    }
}
