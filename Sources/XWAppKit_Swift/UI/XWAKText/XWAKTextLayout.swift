//
//  XWAKLayout.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/9/21.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public class XWAKTextLayout: NSObject {
    public let text: String
    public let size: CGSize
    
    init(text: String, images: [UIImage]? = nil, attrs: Dictionary<NSAttributedString.Key, Any>, size: CGSize) {
        self.text = text
        self.size = size
        super.init()
    }
    
    func calculate() {
        let attrStr = NSMutableAttributedString(string: text, attributes: nil)
        let framesetter = CTFramesetterCreateWithAttributedString(attrStr)
        let path = CGPath(rect: CGRect(origin: .zero, size: size), transform: nil)
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attrStr.length), path, nil)
        let lines = CTFrameGetLines(frame) as! [CTLine]
        var lineOrigins = [CGPoint](repeating: .zero, count: lines.count)
        CTFrameGetLineOrigins(frame, CFRange(location: 0, length: attrStr.length), &lineOrigins)
        for lineIndex in 0..<lines.count {
            let line = lines[lineIndex]
            let runs = CTLineGetGlyphRuns(line) as! [CTRun]
            for runIndex in 0..<runs.count {
//                let run = runs[runIndex]
//                let runAttrs = CTRunGetAttributes(run) as! Dictionary<NSAttributedString.Key, Any>
//                if let runDelegate = runAttrs[(kCTRunDelegateAttributeName) as NSAttributedString.Key] {
//                    attrStr.append(NSAttributedString(string: " ", attributes: runDelegate))
//                }
            }
        }
    }
}
