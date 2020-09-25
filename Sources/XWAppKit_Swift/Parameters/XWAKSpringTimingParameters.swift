//
//  XWAKSpringTimingParameters.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/9/25.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import Foundation
import CoreGraphics

/// https://en.wikipedia.org/wiki/Harmonic_oscillator
///
/// System's equation of motion:
///
/// 0 < dampingRatio < 1:
/// x(t) = exp(-beta * t) * (c1 * sin(w' * t) + c2 * cos(w' * t))
/// c1 = x0
/// c2 = (v0 + beta * x0) / w'
///
/// dampingRatio == 1:
/// x(t) = exp(-beta * t) * (c1 + c2 * t)
/// c1 = x0
/// c2 = (v0 + beta * x0)
///
/// x0 - initial displacement
/// v0 - initial velocity
/// beta = damping / (2 * mass)
/// w0 = sqrt(stiffness / mass) - natural frequency
/// w' = sqrt(w0 * w0 - beta * beta) - damped natural frequency

public struct XWAKSpring {
    public var mass: CGFloat
    public var stiffness: CGFloat
    public var dampingRatio: CGFloat
    
    public init(mass: CGFloat, stiffness: CGFloat, dampingRatio: CGFloat) {
        self.mass = mass
        self.stiffness = stiffness
        self.dampingRatio = dampingRatio
    }
}

public extension XWAKSpring {
    static var `default`: XWAKSpring {
        return XWAKSpring(mass: 1, stiffness: 200, dampingRatio: 1)
    }
}
