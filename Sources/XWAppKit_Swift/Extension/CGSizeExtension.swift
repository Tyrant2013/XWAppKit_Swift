//
//  CGSizeExtension.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/10/13.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public extension CGSize {
    func fixFrameTo(_ bounds: CGRect) -> CGRect {
        var oriX: CGFloat = 0
        var oriY: CGFloat = 0
        let imageSize = self
        var width = imageSize.width
        var height = imageSize.height
        let radio = imageSize.height / imageSize.width
        
        if width > bounds.width || height > bounds.height {
            if width > bounds.width && height < bounds.height {
                width = bounds.width
                height = width * radio
                oriY = (bounds.height - height) / 2 + bounds.minY
            }
            else if width < bounds.width && height > bounds.height {
                height = bounds.height
                width = height / radio
                oriX = (bounds.width - width) / 2 + bounds.minX
            }
            else {
                width = bounds.width
                height = width * radio
                if height > bounds.height {
                    height = bounds.height
                    width = height / radio
                }
                oriX = (bounds.width - width) / 2 + bounds.minX
                oriY = (bounds.height - height) / 2 + bounds.minY
            }
        }
        else {
            oriX = (bounds.width - width) / 2 + bounds.minX
            oriY = (bounds.height - height) / 2 + bounds.minY
        }
        return CGRect(x: oriX, y: oriY, width: width, height: height)
    }
}
