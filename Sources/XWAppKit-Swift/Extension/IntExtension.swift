//
//  IntExtension.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2021/3/19.
//  Copyright © 2021 ZhuanagXiaowei. All rights reserved.
//

import UIKit

extension Int {
    func toColorComponent() -> CGFloat {
        return CGFloat(self) / 255.0
    }
}
