//
//  XWAKLine.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/9/22.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public class XWAKLine: NSObject {
    public let line: CTLine
    public let position: CGPoint
    init(line: CTLine, position: CGPoint) {
        self.line = line
        self.position = position
        super.init()
    }
}
