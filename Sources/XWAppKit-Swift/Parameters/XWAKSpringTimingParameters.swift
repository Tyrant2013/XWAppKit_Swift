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

public extension XWAKSpring {
    var damping: CGFloat {
        return 2 * dampingRatio * sqrt(mass * stiffness)
    }
    
    var beta: CGFloat {
        return damping / (2 * mass)
    }
    
    var dampedNaturalFrequency: CGFloat {
        return sqrt(stiffness / mass) * sqrt(1 - dampingRatio * dampingRatio)
    }
}

public struct XWAKSpringTimingParameters {
    public let spring: XWAKSpring
    public let displacement: CGPoint
    public let initialVelocity: CGPoint
    public let threshold: CGFloat
    private let impl: XWAKTimingParameters
    
    public init(spring: XWAKSpring, displacement: CGPoint, initialVelocity: CGPoint, threshold: CGFloat) {
        self.spring = spring
        self.displacement = displacement
        self.initialVelocity = initialVelocity
        self.threshold = threshold
        
        if spring.dampingRatio == 1 {
            impl = CriticallyDampedSpringTimingParameters(spring: spring, displacement: displacement, initialVelocity: initialVelocity, threshold: threshold)
        }
        else if spring.dampingRatio > 0 && spring.dampingRatio < 1 {
            impl = UnderdampedSpringTimingParameters(spring: spring, displacement: displacement, initialVelocity: initialVelocity, threshold: threshold)
        }
        else {
            fatalError("dampingRatio should be greater than 0 and less than or equal to 1")
        }
    }
}

extension XWAKSpringTimingParameters: XWAKTimingParameters {
    public var duration: TimeInterval {
        return impl.duration
    }
    
    public func value(at time: TimeInterval) -> CGPoint {
        return impl.value(at: time)
    }
}

private struct UnderdampedSpringTimingParameters {
    let spring: XWAKSpring
    let displacement: CGPoint
    let initialVelocity: CGPoint
    let threshold: CGFloat
}

extension UnderdampedSpringTimingParameters: XWAKTimingParameters {
    var duration: TimeInterval {
        if displacement.length == 0 && initialVelocity.length == 0 {
            return 0
        }
        return TimeInterval(log((c1.length + c2.length) / threshold) / spring.beta)
    }
    
    func value(at time: TimeInterval) -> CGPoint {
        let t = CGFloat(time)
        let wd = spring.dampedNaturalFrequency
        return exp(-spring.beta * t) * (c1 * cos(wd * t) + c2 * sin(wd * t))
    }
    
    private var c1: CGPoint {
        return displacement
    }
    
    private var c2: CGPoint {
        return (initialVelocity + spring.beta * displacement) / spring.dampedNaturalFrequency
    }
}

private struct CriticallyDampedSpringTimingParameters {
    let spring: XWAKSpring
    let displacement: CGPoint
    let initialVelocity: CGPoint
    let threshold: CGFloat
}

extension CriticallyDampedSpringTimingParameters: XWAKTimingParameters {
    var duration: TimeInterval {
        if displacement.length == 0 && initialVelocity.length == 0 {
            return 0
        }
        
        let b = spring.beta
        let e = CGFloat(M_E)
        
        let t1 = 1 / b * log(2 * c1.length / threshold)
        let t2 = 2 / b * log(4 * c2.length / (e * b * threshold))
        
        return TimeInterval(max(t1, t2))
    }
    
    func value(at time: TimeInterval) -> CGPoint {
        let t = CGFloat(time)
        return exp(-spring.beta * t) * (c1 + c2 * t)
    }
    
    private var c1: CGPoint {
        return displacement
    }
    
    private var c2: CGPoint {
        return initialVelocity + spring.beta * displacement
    }
    
}
