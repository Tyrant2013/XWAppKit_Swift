//
//  UIImageViewExtension.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/10/13.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public extension UIImageView {
    func frameFixTo(_ bounds: CGRect) {
        if let image = image {
            frame = image.size.fixFrameTo(bounds)
        }
        else {
            frame = .zero
        }
    }
}
