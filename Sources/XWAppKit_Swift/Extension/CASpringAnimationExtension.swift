//
//  CASpringAnimationExtension.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/9/25.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import QuartzCore

extension CASpringAnimation {
    convenience init(mass: CGFloat = 1, stiffness: CGFloat = 100, dampingRatio: CGFloat) {
        self.init()
        self.mass = mass
        self.stiffness = stiffness
        self.damping = 2 * dampingRatio * sqrt(mass * stiffness)
    }
}
