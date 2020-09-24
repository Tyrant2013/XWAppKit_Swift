//
//  XWAKTextContainerView.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/9/24.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

class XWAKTextContainerView: UIView {

    var layout: XWAKTextLayout? {
        didSet {
            setNeedsLayout()
        }
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        print("container height: \(bounds)")
        guard let layout = layout else { return }
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        ctx.textMatrix = .identity
        ctx.translateBy(x: 0, y: bounds.height)
        ctx.scaleBy(x: 1, y: -1)
        
        layout.draw(context: ctx)
    }
}
