//
//  XWAKTimingParameters.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/9/25.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import Foundation
import CoreGraphics

public protocol XWAKTimingParameters {
    var duration: TimeInterval { get }
    func value(at time: TimeInterval) -> CGPoint
}
