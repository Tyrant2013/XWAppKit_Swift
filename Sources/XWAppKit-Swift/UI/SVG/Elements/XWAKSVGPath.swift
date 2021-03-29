//
//  XWAKSVGPath.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2021/3/26.
//  Copyright © 2021 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import CoreGraphics

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
        path.move(to: .zero)
        
        var cpre: CGPoint = .zero
        var qpre: CGPoint = .zero
        
        for (cmd, nums) in cmds {
            switch cmd {
            case "M", "m":
                move(relative: cmd == "m", nums: nums)
            case "L", "l":
                addLine(relative: cmd == "l", nums: nums)
            case "A", "a":
                addEllipticalArc(relative: cmd == "a", nums: nums)
            case "C", "c":
                cpre = addCurve(relative: cmd == "c",
                                nums: nums,
                                preControlPoint: cpre)
            case "Q", "q":
                qpre = addQuadCurve(relative: cmd == "q",
                                    nums: nums,
                                    preControlPoint: qpre)
            case "S", "s":
                addSmoothCurve(relative: cmd == "s", nums: nums, lastControl: cpre)
            case "T", "t":
                qpre = addSmoothQuadCurve(relative: cmd == "t",
                                          nums: nums,
                                          lastControl: qpre)
            case "H", "h":
                addHorizontalLine(relative: cmd == "h", nums: nums)
            case "V", "v":
                addVerticalLine(relative: cmd == "v", nums: nums)
            case "Z", "z":
//                path.close()
                path.closeSubpath()
            default:
                print("未处理的CMD")
            }
        }
    }
    
    private func move(relative: Bool, nums: [Double]) {
        var end = path.currentPoint
        for index in stride(from: 0, to: nums.count, by: 2) {
            var (x, y) = (nums[index], nums[index + 1])
            if relative {
                (x, y) = (Double(end.x) + x, Double(end.y) + y)
            }
            end = .init(x: x, y: y)
            path.move(to: end)
        }
    }
    
    private func addLine(relative: Bool, nums: [Double]) {
        var end = path.currentPoint
        for index in stride(from: 0, to: nums.count, by: 2) {
            var (x, y) = (nums[index], nums[index + 1])
            if relative {
                (x, y) = (Double(end.x) + x, Double(end.y) + y)
            }
            end = .init(x: x, y: y)
            path.addLine(to: end)
        }
    }
    
    private func addHorizontalLine(relative: Bool, nums: [Double]) {
        var end = path.currentPoint
        for index in 0..<nums.count {
            var (x, y) = (nums[index], end.y)
            if relative {
                x = x + Double(end.x)
            }
            end = .init(x: x, y: Double(y))
            path.addLine(to: end)
        }
    }
    
    private func addVerticalLine(relative: Bool, nums: [Double]){
        var end = path.currentPoint
        for index in 0..<nums.count {
            var (x, y) = (end.x, nums[index])
            if relative {
                y = y + Double(end.y)
            }
            end = .init(x: Double(x), y: y)
            path.addLine(to: end)
        }
    }
    
    private func addEllipticalArc(relative: Bool, nums: [Double]){
//  Elliptical Arc，允许不闭合。可以想像成是椭圆的某一段，共七个参数。
//　RX,RY指所在椭圆的半轴大小
//　XROTATION指椭圆的X轴与水平方向顺时针方向夹角，可以想像成一个水平的椭圆绕中心点顺时针旋转XROTATION的角度。
//　FLAG1只有两个值，1表示大角度弧线，0为小角度弧线。
//　FLAG2只有两个值，确定从起点至终点的方向，1为顺时针，0为逆时针
//　X,Y为终点坐标
        var end = path.currentPoint
        let (x1, y1) = (end.x, end.y)
        var (rx, ry) = (CGFloat(nums[0]), CGFloat(nums[1]))
        var phi = CGFloat(nums[2])
        phi *= CGFloat.pi / 180
        phi = fmod(phi, 2 * .pi)
        let largeArcFlag = nums[3] != 0.0
        let sweepFlag = nums[4] != 0.0
        
        var (x2, y2) = (CGFloat(nums[5]), CGFloat(nums[6]))
        if relative {
            (x2, y2) = (x2 + end.x, y2 + end.y)
        }
        
        if rx == 0 || ry == 0 {
            end = .init(x: x2, y: y2)
            path.addLine(to: end)
            return
        }
        
        let (cosPhi, sinPhi) = (cos(phi), sin(phi))
        
        let x1p = cosPhi * (x1 - x2) / 2.0 + sinPhi * (y1 - y2) / 2.0
        let y1p = -sinPhi * (x1 - x2) / 2.0 + cosPhi * (y1 - y2) / 2.0
        
        var lhs: CGFloat = 0
        var (rx_2, ry_2, xp_2, yp_2): (CGFloat, CGFloat, CGFloat, CGFloat) = (rx * rx, ry * ry, x1p * x1p, y1p * y1p)
        let delta: CGFloat = xp_2 / rx_2 + yp_2 / ry_2
        
        if delta > 1.0 {
            rx *= sqrt(delta)
            ry *= sqrt(delta)
            rx_2 = rx * rx
            ry_2 = ry * ry
        }
        let sign = (largeArcFlag == sweepFlag) ? -1 : 1
        var numerator = rx_2 * ry_2 - rx_2 * yp_2 - ry_2 * xp_2
        let denom = rx_2 * yp_2 + ry_2 * xp_2
        numerator = max(0, numerator)
        
        if denom == 0 {
            lhs = 0
        }
        else {
            lhs = CGFloat(sign) * sqrt(numerator / denom)
        }
        
        let cxp = lhs * (rx * y1p) / ry
        let cyp = lhs * (-((ry * x1p) / rx))
        
        let cx = cosPhi * cxp + (-sinPhi * cyp) + (x1 + x2) / 2.0
        let cy = cxp * sinPhi + cyp * cosPhi + (y1 + y2) / 2.0
        
        var tr = CGAffineTransform.identity.scaledBy(x: 1 / rx, y: 1 / ry)
        tr = tr.rotated(by: -phi)
        tr = tr.translatedBy(x: -cx, y: -cy)
        
        let arcPt1 = __CGPointApplyAffineTransform(.init(x: x1, y: y1), tr)
        let arcPt2 = __CGPointApplyAffineTransform(.init(x: x2, y: y2), tr)
        
        let startAngle: CGFloat = atan2(arcPt1.y, arcPt1.x)
        let endAngle: CGFloat = atan2(arcPt2.y, arcPt2.x)
        
        var angleDelta: CGFloat = endAngle - startAngle
        if sweepFlag {
            if angleDelta < 0 {
                angleDelta += 2.0 * .pi
            }
        }
        else {
            if angleDelta > 0 {
                angleDelta = angleDelta - 2 * .pi
            }
        }
        
        var trInv = CGAffineTransform.identity.translatedBy(x: cx, y: cy)
        trInv = trInv.rotated(by: phi)
        trInv = trInv.scaledBy(x: rx, y: ry)
        
        path.addRelativeArc(center: .zero, radius: 1, startAngle: startAngle, delta: angleDelta, transform: trInv)
    }
    
    private func addCurve(relative: Bool, nums: [Double], preControlPoint: CGPoint) -> CGPoint {
        var end = path.currentPoint
        var cpre = preControlPoint
        for index in stride(from: 0, to: nums.count, by: 6) {
            var (cx1, cy1, cx2, cy2, x, y) = (nums[index], nums[index + 1], nums[index + 2], nums[index + 3], nums[index + 4], nums[index + 5])
            if relative {
                (cx1, cy1, cx2, cy2, x, y) = (cx1 + Double(end.x),
                                              cy1 + Double(end.y),
                                              cx2 + Double(end.x),
                                              cy2 + Double(end.y),
                                              x + Double(end.x),
                                              y + Double(end.y))
            }
            end = .init(x: x, y: y)
            cpre = .init(x: cx2, y: cy2)
            path.addCurve(to: end,
                          control1: .init(x: cx1, y: cy1),
                          control2: cpre)
        }
        return cpre
    }
    
    private func addQuadCurve(relative: Bool, nums: [Double], preControlPoint: CGPoint) -> CGPoint {
        var end = path.currentPoint
        var qpre = preControlPoint
        for index in stride(from: 0, to: nums.count, by: 4) {
            var (cx, cy, x, y) = (nums[index], nums[index + 1], nums[index + 2], nums[index + 3])
            if relative {
                (cx, cy, x, y) = (cx + Double(end.x),
                                  cy + Double(end.y),
                                  x + Double(end.x),
                                  y + Double(end.y))
            }
            end = .init(x: x, y: y)
            qpre = .init(x: cx, y: cy)
            path.addQuadCurve(to: end, control: qpre)
        }
        return qpre
    }
    
    private func addSmoothCurve(relative: Bool, nums: [Double], lastControl: CGPoint) {
        var end = path.currentPoint
        let cpre = lastControl
        for index in stride(from: 0, to: nums.count, by: 4) {
            var (cx2, cy2, x, y) = (nums[index], nums[index + 1], nums[index + 2], nums[index + 3])
            if relative {
                (cx2, cy2, x, y) = (cx2 + Double(end.x),
                                    cy2 + Double(end.y),
                                    x + Double(end.x),
                                    y + Double(end.y))
            }
            let c2 = CGPoint(x: cx2, y: cy2)
            var c1: CGPoint
            if cpre == .zero {
                c1 = c2
            }
            else {
                c1 = .init(x: end.x + (end.x - cpre.x),
                           y: end.y + (end.y - cpre.y))
            }
            end = .init(x: x, y: y)
//            path.addCurve(to: end, controlPoint1: c1, controlPoint2: c2)
            path.addCurve(to: end, control1: c1, control2: c2)
        }
    }
    
    private func addSmoothQuadCurve(relative: Bool, nums: [Double], lastControl: CGPoint) -> CGPoint {
        var end = path.currentPoint
        var qpre = lastControl
        for index in stride(from: 0, to: nums.count, by: 2) {
            var (x, y) = (nums[index], nums[index + 1])
            if relative {
                (x, y) = (x + Double(end.x),
                          y + Double(end.y))
            }
            let p = CGPoint(x: x, y: y)
            var c: CGPoint
            if qpre == .zero {
                c = p
            }
            else {
                c = .init(x: end.x + (end.x - qpre.x),
                          y: end.y + (end.y - qpre.y))
            }
            path.addQuadCurve(to: p, control: c)
            end = p
            qpre = c
        }
        return qpre
    }
    
}
