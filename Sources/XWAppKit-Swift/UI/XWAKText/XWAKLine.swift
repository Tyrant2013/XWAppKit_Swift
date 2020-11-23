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
    private(set) var line: CTLine
    private(set) var position: CGPoint
    private(set) var bounds: CGRect
    private(set) var ascent: CGFloat = 0
    private(set) var descent: CGFloat = 0
    private(set) var leading: CGFloat = 0
    private(set) var trailingWidth: Double
    private(set) var lineWidth: Double
    private(set) var extBounds: CGRect
    private(set) var textRange: CFRange
    
    private let _firstGlyphPos: CGFloat
    public var selected: Bool = false
    
    init(line: CTLine, position: CGPoint) {
        self.line = line
        self.position = position
        lineWidth = CTLineGetTypographicBounds(line, &ascent, &descent, &leading)
        trailingWidth = CTLineGetTrailingWhitespaceWidth(line)
        
        if CTLineGetGlyphCount(line) > 0 {
            let runs = CTLineGetGlyphRuns(line) as! [CTRun]
            var pos: CGPoint = .zero
            CTRunGetPositions(runs[0], CFRangeMake(0, 1), &pos)
            _firstGlyphPos = pos.x
        }
        else { _firstGlyphPos = 0 }
        
        bounds = CGRect(x: position.x + _firstGlyphPos,
                        y: position.y - ascent,
                        width: CGFloat(lineWidth),
                        height: ascent + descent)
        bounds.applying(CGAffineTransform(scaleX: 1, y: -1))

        extBounds = CGRect(origin: bounds.origin, size: CGSize(width: 1024, height: bounds.height))
        textRange = CTLineGetStringRange(line)
        super.init()
    }
    
    public func textPosition(for point: CGPoint) -> CGPoint {
        var findPoint = point
        findPoint.x -= position.x
        let index = CTLineGetStringIndexForPosition(line, findPoint)
        let offset = CTLineGetOffsetForStringIndex(line, index, nil)
        return .init(x: offset + position.x - 1.0, y: position.y - ascent)
    }
    
    public func stringIndex(for point: CGPoint) -> CFIndex {
        return CTLineGetStringIndexForPosition(line, point)
    }
}
