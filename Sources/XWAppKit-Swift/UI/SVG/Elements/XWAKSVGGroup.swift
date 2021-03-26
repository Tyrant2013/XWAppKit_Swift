//
//  XWAKSVGGroup.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2021/3/26.
//  Copyright © 2021 ZhuanagXiaowei. All rights reserved.
//

import UIKit

class XWAKSVGGroup: XWAKSVGElement {
    required init(dict: [String : String]) {
        super.init(dict: dict)
        tagName = "g"
    }
}
