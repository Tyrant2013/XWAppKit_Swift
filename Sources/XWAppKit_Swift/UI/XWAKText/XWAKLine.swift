//
//  XWAKLine.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/9/22.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import CoreText

public class XWAKLine: NSObject {
    public let line: CTLine
    public let position: CGPoint
    public let bounds: CGRect
    public let ascent: CGFloat
    public let descent: CGFloat
    public let leading: CGFloat
    public let trailingWidth: Double
    public var selected: Bool = false
    init(line: CTLine, position: CGPoint) {
        self.line = line
        self.position = position
        let bounds = CTLineGetBoundsWithOptions(line, CTLineBoundsOptions(rawValue: 0))
        self.bounds = bounds
        var ascent: CGFloat = 0
        var descent: CGFloat = 0
        var leading: CGFloat = 0
        _ = CTLineGetTypographicBounds(line, &ascent, &descent, &leading)
        let trailingWidth = CTLineGetTrailingWhitespaceWidth(line)
        self.ascent = ascent
        self.descent = descent
        self.leading = leading
        self.trailingWidth = trailingWidth
        super.init()
    }
}
