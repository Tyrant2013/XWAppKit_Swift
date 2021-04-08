//
//  XWAKColor.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2021/4/7.
//  Copyright © 2021 ZhuanagXiaowei. All rights reserved.
//

import Foundation
import UIKit

public class XWAKColor {
    private(set) var hue: CGFloat = 0.0
    private(set) var saturation: CGFloat = 0.0
    private(set) var brightness: CGFloat = 0.0
    private(set) var alpha: CGFloat = 0.0
    private(set) var red: CGFloat = 0.0
    private(set) var green: CGFloat = 0.0
    private(set) var blue: CGFloat = 0.0
    
    private func HSVToRGB(h: CGFloat, s: CGFloat, v: CGFloat, r: inout CGFloat, g: inout CGFloat, b: inout CGFloat) {
        if s == 0.0 {
            (r, g, b) = (v, v, v)
            return
        }
        var (f, p, q, t): (CGFloat, CGFloat, CGFloat, CGFloat) = (0.0, 0.0, 0.0, 0.0)
        var i: Int = 0
        var tmpH = h * 360
        if tmpH == 360.0 {
            tmpH = 0
        }
        tmpH = tmpH / 60
        i = Int(floor(tmpH))
        f = tmpH - CGFloat(i)
        p = v * (1.0 - s)
        q = v * (1.0 - (s * f))
        t = v * (1.0 - (s * (1.0 - f)))
        switch i {
        case 0:
            (r, g, b) = (v, t, p)
        case 1:
            (r, g, b) = (q, v, p)
        case 2:
            (r, g, b) = (p, v, t)
        case 3:
            (r, g, b) = (p, q, v)
        case 4:
            (r, g, b) = (t, p, v)
        case 5:
            (r, g, b) = (v, p, q)
        default:
            fatalError("HSV to RGB failed, i value: \(i)")
        }
    }
    
    private func RGBToHSV(r: CGFloat, g: CGFloat, b: CGFloat, h: inout CGFloat, s: inout CGFloat, v: inout CGFloat) {
        let maxVal = max(r, max(g, b))
        let minVal = min(r, min(g, b))
        let delta = maxVal - minVal
        v = maxVal
        s = maxVal != 0.0 ? (delta / maxVal) : 0.0
        if s == 0.0 {
            h = 0.0
        }
        else {
            if r == maxVal {
                h = (g - b) / delta
            }
            else if (g == maxVal) {
                h = 2.0 + (b - r) / delta
            }
            else if (b == maxVal) {
                h = 4.0 + (r - g) / delta
            }
            h *= 60
            if h < 0.0 {
                h += 360
            }
        }
        h /= 360
    }
    
    init(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        self.hue = hue.clamped(to: 0.0...1.0)
        self.saturation = saturation.clamped(to: 0.0...1.0)
        self.brightness = brightness.clamped(to: 0.0...1.0)
        self.alpha = alpha.clamped(to: 0.0...1.0)
        HSVToRGB(h: hue, s: saturation, v: brightness, r: &red, g: &green, b: &blue)
    }
    
    init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        self.red = red.clamped(to: 0.0...1.0)
        self.green = green.clamped(to: 0.0...1.0)
        self.blue = blue.clamped(to: 0.0...1.0)
        self.alpha = alpha.clamped(to: 0.0...1.0)
        RGBToHSV(r: red, g: green, b: blue, h: &hue, s: &saturation, v: &brightness)
    }
}

