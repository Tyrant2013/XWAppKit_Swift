//
//  XWAKTextView.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/9/18.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import CoreText

public class XWAKTextView: UIScrollView {
    
    private let containerView: XWAKTextContainerView = XWAKTextContainerView()
    
    public var layout: XWAKTextLayout?
    public var attributeString: NSAttributedString? {
        didSet {
            if let attrStr = attributeString {
                layout = XWAKTextLayout(text: attrStr, size: bounds.size)
            }
            else {
                layout = nil
            }
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(containerView)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview(containerView)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        containerView.backgroundColor = backgroundColor
        
        var containerFrame = CGRect(origin: .zero, size: bounds.size)
        if let layout = layout {
            let textSize = layout.text.boundingRect(with: CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
            contentSize = CGSize(width: bounds.width, height: ceil(textSize.height))
            containerFrame.size.height = ceil(textSize.height)
        }
        layout?.size = containerFrame.size
        containerView.frame = containerFrame
        containerView.layout = layout
    }

//    func update() {
//        guard let layout = layout else { return }
//        guard let ctx = UIGraphicsGetCurrentContext() else { return }
//        ctx.textMatrix = .identity
//        ctx.translateBy(x: 0, y: bounds.height)
//        ctx.scaleBy(x: 1, y: -1)
//
//        layout.draw(context: ctx)
//
//    }
    
//    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let layout = layout else { super.touchesBegan(touches, with: event); return }
//        let touch = event?.allTouches?.first
//        if let touchPoint = touch?.location(in: touch?.view),
//           let pointInLayout = _converPointToLayout(touchPoint),
//           let touchImageData = layout.touchImage(in: pointInLayout),
//           let touchBlock = touchImageData.ClickBlock {
//            let frameInView = XWAKTextTools.convertTextLayoutFrame(touchImageData.imageFrame, to: self, layoutSize: layout.size)
//            touchBlock(touchImageData.image, frameInView)
//        }
//    }
//
//    private func _converPointToLayout(_ point: CGPoint) -> CGPoint? {
//        return XWAKTextTools.convertViewPointToTextLayout(layout!.size, frome: bounds, point)
//    }
//
//    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//    }

    private func testUpdate(ctx: CGContext) {
        let path = CGPath(rect: bounds, transform: nil)

        let drawStr = "这是开始，这是中间，这是结束\n这里换行"
        let attrs = [
            NSAttributedString.Key.foregroundColor : UIColor.red,
            NSAttributedString.Key.backgroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)
        ]
        let attr = NSMutableAttributedString(string: drawStr)
        attr.addAttributes(attrs, range: NSRange(location: 0, length: drawStr.count))
        let framesetter = CTFramesetterCreateWithAttributedString(attr)
        let frame = CTFramesetterCreateFrame(framesetter, CFRange(location: 0, length: drawStr.count), path, nil)

        let lines = CTFrameGetLines(frame) as NSArray
        var lineOrigins = [CGPoint](repeating: .zero, count: lines.count)
        CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), &lineOrigins)
        for index in 0..<lines.count {
            let line = lines[index] as! CTLine
            //let line = unsafeBitCast(CFArrayGetValueAtIndex(lines, index), to: CTLine.self)
            let origin = lineOrigins[index]
            ctx.textPosition = origin

            let runs = CTLineGetGlyphRuns(line) as Array

            runs.forEach { run in
                let run = run as! CTRun
                let stringRange = CTRunGetStringRange(run)
                let xOffset = CTLineGetOffsetForStringIndex(line, stringRange.location, nil)
                let attributes = CTRunGetAttributes(run) as NSDictionary
                let glyphCount = CTRunGetGlyphCount(run)
                var runPositions = [CGPoint](repeating: .zero, count: glyphCount)
                CTRunGetPositions(run, CFRangeMake(0, 0), &runPositions)
                print("stringRange: \(stringRange), xOffset: \(xOffset), attrs: \(attributes)")
                for glyphIndex in 0..<glyphCount {
                    print("glyphIndex: \(glyphIndex), position: \(runPositions[glyphIndex])")

                }
                var glyphs = [CGGlyph](repeating: CGGlyph(), count: glyphCount)
                let runFont = attributes[NSAttributedString.Key.font] as! CTFont
                CTRunGetGlyphs(run, CFRangeMake(0, 0), &glyphs)
                if let fillColor = attributes[NSAttributedString.Key.foregroundColor] as? UIColor {
                    ctx.setFillColor(fillColor.cgColor)
                }
                else {
                    ctx.setFillColor(UIColor.black.cgColor)
                }
                ctx.setFont(CTFontCopyGraphicsFont(runFont, nil))
                ctx.setFontSize(CTFontGetSize(runFont))
                ctx.showGlyphs(glyphs, at: runPositions)

                print("")
            }
        }
    }
}
