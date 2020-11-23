//
//  UISpringTimingParameters.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/9/25.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

extension UISpringTimingParameters {
    convenience init(mass: CGFloat, stiffness: CGFloat, dampingRatio: CGFloat, initialVelocity velocity: CGVector) {
        let damping = 2 * dampingRatio * sqrt(mass * stiffness)
        self.init(mass: mass, stiffness: stiffness, damping: damping, initialVelocity: velocity)
    }
}
