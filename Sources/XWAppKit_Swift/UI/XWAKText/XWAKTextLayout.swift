//
//  XWAKLayout.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/9/21.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public struct XWAKImageMetaData {
    public let ascent: CGFloat
    public let descent: CGFloat
    public let width: CGFloat
    public let image: UIImage
    public var imageFrame: CGRect = .zero
    public let ClickBlock: ((_ image: UIImage, _ frame: CGRect) -> Void)?
    
    public static func makeImageAttributeString(image: UIImage, size: CGSize? = nil, tapHandler: @escaping (_ image: UIImage, _ frame: CGRect) -> Void) -> NSAttributedString {
        let imageSize = size ?? image.size
        let extentBuffer = UnsafeMutablePointer<XWAKImageMetaData>.allocate(capacity: 1)
        extentBuffer.initialize(to: XWAKImageMetaData(ascent: imageSize.height, descent: 0, width: imageSize.width, image: image, ClickBlock: tapHandler))
        var callbacks = CTRunDelegateCallbacks(version: kCTRunDelegateVersion1) { (pointer) in
        } getAscent: { (pointer) -> CGFloat in
            let d = pointer.assumingMemoryBound(to: XWAKImageMetaData.self)
            return d.pointee.ascent
        } getDescent: { (pointer) -> CGFloat in
            let d = pointer.assumingMemoryBound(to: XWAKImageMetaData.self)
            return d.pointee.descent
        } getWidth: { (pointer) -> CGFloat in
            let d = pointer.assumingMemoryBound(to: XWAKImageMetaData.self)
            return d.pointee.width
        }
        let delegate = CTRunDelegateCreate(&callbacks, extentBuffer)
        let attrDictionaryDelegate = [(kCTRunDelegateAttributeName as NSAttributedString.Key) : delegate as Any]
        return NSAttributedString(string: " ", attributes: attrDictionaryDelegate)
    }
}

public class XWAKTextLayout: NSObject {
    public let text: NSAttributedString
    public var size: CGSize
    public var inset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    public var lines: [XWAKLine] {
        get {
            return _innerLines
        }
    }
    
    private var _innerLines = [XWAKLine]()
    private var _innerImages = [XWAKImageMetaData]()
    
    private override init() {
        self.text = NSAttributedString()
        self.size = .zero
        super.init()
    }
    
    init(text: NSAttributedString, size: CGSize) {
        self.text = text
        self.size = size
        super.init()
    }
    
    public func updateSize(_ size: CGSize) {
        self.size = size
        parseText()
    }
    
    private func parseText() {
        _innerLines.removeAll()
        
        let attrStr = text
        let pathRect = CGRect(origin: .zero, size: CGSize(width: size.width, height: 10000))
        let drawBoxRect = pathRect.inset(by: inset)
        let path = CGPath(rect: drawBoxRect, transform: nil)
        
        let framesetter = CTFramesetterCreateWithAttributedString(attrStr)
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attrStr.length), path, nil)
        let lines = CTFrameGetLines(frame) as! [CTLine]
        var lineOrigins = [CGPoint](repeating: .zero, count: lines.count)
        CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), &lineOrigins)
        var _lastRect: CGRect = .zero
        
        for lineIndex in 0..<lines.count {
            let ctline = lines[lineIndex]
            var position = lineOrigins[lineIndex]
            position.x = drawBoxRect.minX + lineOrigins[lineIndex].x
            position.y = drawBoxRect.height + drawBoxRect.minY - position.y
            
            let line = XWAKLine(line: ctline, position: position)
            _innerLines.append(line)
            _lastRect = _lastRect.union(line.bounds)
            
            let runs = CTLineGetGlyphRuns(ctline) as! [CTRun]

            for run in runs {
                if let runAttrs = CTRunGetAttributes(run) as? Dictionary<NSAttributedString.Key, Any> {
                    if let imageDelegate = runAttrs[(kCTRunDelegateAttributeName as NSAttributedString.Key)] {
                        parseImages(line: line, run: run, imageDelegate: imageDelegate as! CTRunDelegate)
                    }
                }
            }
        }
        size = _lastRect.size
        size.height += inset.top + inset.bottom
    }
    
    private func parseImages(line: XWAKLine, run: CTRun, imageDelegate: CTRunDelegate) {
        let keyValue = CTRunDelegateGetRefCon(imageDelegate)
        var metaData = keyValue.assumingMemoryBound(to: XWAKImageMetaData.self).pointee
        let imageHeight = metaData.ascent + metaData.descent
        let imageWidth = metaData.width
        let x = CTLineGetOffsetForStringIndex(line.line, CTRunGetStringRange(run).location, nil) + line.position.x
        let y = line.position.y
        metaData.imageFrame = CGRect(x: x, y: y, width: imageWidth, height: imageHeight)
        _innerImages.append(metaData)
    }
    
    public func draw(context: CGContext) {
        
        for line in _innerLines {
            drawLine(line, context: context)
        }
        
        for imageData in _innerImages {
            var imageFrame = imageData.imageFrame
            imageFrame.origin.y = size.height - imageFrame.minY
            context.draw(imageData.image.cgImage!, in: imageFrame)
        }
        
    }
    
    public func touchImage(in point: CGPoint) -> XWAKImageMetaData? {
        for imageData in _innerImages {
            if imageData.imageFrame.contains(point) {
                return imageData
            }
        }
        return nil
    }
    
    private func drawLine(_ line: XWAKLine, context: CGContext) {
        let ctline = line.line
        var lineOrigin = line.position
        lineOrigin.y = size.height - lineOrigin.y
        
        context.textPosition = lineOrigin
        
        let runs = CTLineGetGlyphRuns(ctline) as Array
        for run in runs {
            let run = run as! CTRun
            let attributes = CTRunGetAttributes(run) as! Dictionary<NSAttributedString.Key, Any>
            ContextStateStore(context) {
                var runAscent: CGFloat = 0
                var runDescent: CGFloat = 0
                let runWidth = CGFloat(CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &runAscent, &runDescent, nil))
                let runHeight = runAscent + runDescent
                let stringRange = CTRunGetStringRange(run)
                let runXOffset = CTLineGetOffsetForStringIndex(line.line, stringRange.location, nil) + line.position.x
                let runYOffset = size.height - line.position.y - runDescent
                let runFrame = CGRect(x: runXOffset, y: runYOffset, width: runWidth, height: runHeight)
                
                
                drawBackground(line: line, run: run, runFrame: runFrame, context: context)
                
                if let shadowAttr = attributes[NSAttributedString.Key.xwak_shadow] as? XWAKTextShadow {
                    context.setShadow(offset: shadowAttr.offset, blur: shadowAttr.blur, color: shadowAttr.color.cgColor)
                }
                
                if let border = attributes[NSAttributedString.Key.xwak_border] as? XWAKTextBorder {
                    drawBorder(border, line: line, run: run, runFrame: runFrame, context: context)
                }
                
                drawRun(run, line: line, attributes: attributes, context: context)
            }
        }
    }
    
    private func drawBackground(line: XWAKLine, run: CTRun, runFrame: CGRect, context: CGContext) {
        let runAttributes = CTRunGetAttributes(run) as! Dictionary<NSAttributedString.Key, Any>
        let stringRange = CTRunGetStringRange(run)
        /// 消除换行符导致的背景色高出一截(大概)
        if !(stringRange.location > 0 && stringRange.length == 1 && line.trailingWidth == Double(runFrame.width)) {
            let background = runAttributes[NSAttributedString.Key.xwak_background] as? XWAKTextBackground
            let backgroundColor = background?.color ?? .clear
            /// 检查是否设置了选中时的背景色
            let selectedAttrs = runAttributes[NSAttributedString.Key.xwak_selected] as? XWAKTextSelected
            let selectedBackgroundColor = selectedAttrs?.backgroundColor ?? UIColor.systemYellow
            
            let path = UIBezierPath(roundedRect: runFrame.inset(by: background?.inset ?? .zero),
                                    cornerRadius: background?.corner ?? 0)
            context.addPath(path.cgPath)
            context.setFillColor(line.selected ? selectedBackgroundColor.cgColor : backgroundColor.cgColor)
            context.fillPath()
        }
    }
    
    private func drawBorder(_ border: XWAKTextBorder, line: XWAKLine, run: CTRun, runFrame: CGRect, context: CGContext) {

        context.setStrokeColor(border.color.cgColor)
        context.setLineWidth(border.width)
        context.setLineCap(.butt)
        context.setLineJoin(.miter)
        
        let (dash, dot, space): (CGFloat, CGFloat, CGFloat) = (12, 5, 3)
        let dashLengths = [border.width * dash, border.width * space]
        let dotLengths = [border.width * dot, border.width * space]
        switch border.borderStyle {
        case .solid:
            context.setLineDash(phase: 0, lengths: [])
        case .dot:
            context.setLineDash(phase: 0, lengths: dotLengths)
        case .dash:
            context.setLineDash(phase: 0, lengths: dashLengths)
        case .dashdot:
            context.setLineDash(phase: 0, lengths: dashLengths + dotLengths)
        case .dashdotdot:
            context.setLineDash(phase: 0, lengths: dashLengths + dotLengths + dotLengths)
        case .circledot:
            context.setLineDash(phase: 0, lengths: [0, border.width * 3])
            context.setLineCap(.round)
            context.setLineJoin(.round)
        }
        
        context.stroke(runFrame)
    }
    
    private func drawRun(_ run: CTRun, line: XWAKLine, attributes: Dictionary<NSAttributedString.Key, Any>, context: CGContext) {
        let glyphCount = CTRunGetGlyphCount(run)
        var runPositions = [CGPoint](repeating: .zero, count: glyphCount)
        CTRunGetPositions(run, CFRangeMake(0, 0), &runPositions)
        var glyphs = [CGGlyph](repeating: CGGlyph(), count: glyphCount)
        CTRunGetGlyphs(run, CFRangeMake(0, 0), &glyphs)
        let runFont = attributes[NSAttributedString.Key.font] as! CTFont
        let fillColor = attributes[NSAttributedString.Key.foregroundColor] as? UIColor ?? UIColor.black
        
        let selectedAttribute = attributes[NSAttributedString.Key.xwak_selected] as? XWAKTextSelected
        let selectedFont = selectedAttribute?.font as CTFont? ?? runFont
        let selectedForeground = selectedAttribute?.foregroundColor ?? fillColor
        
        context.setFillColor(line.selected ? selectedForeground.cgColor : fillColor.cgColor)
        let setFont = line.selected ? selectedFont : runFont
        context.setFont(CTFontCopyGraphicsFont(setFont, nil))
        context.setFontSize(CTFontGetSize(setFont))
        context.showGlyphs(glyphs, at: runPositions)
    }
    
    private func ContextStateStore(_ context: CGContext, _ block: () -> Void) {
        context.saveGState()
        block()
        context.restoreGState()
    }
}
