//
//  XWAKLog.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/8/5.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

enum XWAKLogType {
    case info
    case debug
    case error
}

struct XWAKLog {
    let date: Date
    let type: XWAKLogType
    let msg: String
}
