//
//  XWAKProfileItem.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/8/3.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public typealias XWAKProfileAction = () -> Void
public struct XWAKProfileItem {
    let name: String
    let targetVC: UIViewController?
    let action: XWAKProfileAction?
}
