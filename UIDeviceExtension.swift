//
//  UIDeviceExtension.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2021/1/8.
//  Copyright © 2021 ZhuanagXiaowei. All rights reserved.
//

import Foundation
import UIKit

public extension UIDevice {
    class var hasBang: Bool {
        if #available(iOS 13.0, *) {
            guard let optionalWin = UIApplication.shared.delegate?.window,
                  let window = optionalWin else {
                return false
            }
            return window.safeAreaInsets.bottom > 0
        }
        else {
            return false
        }
    }
}
