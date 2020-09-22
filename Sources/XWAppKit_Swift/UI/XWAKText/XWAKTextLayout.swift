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
    
//    init(ascent: CGFloat, descent: CGFloat, width: CGFloat, image: UIImage, ClickBlock: @escaping (_ image: UIImage) -> Void) {
//        self.ascent = ascent
//        self.descent = descent
//        self.width = width
//        self.image = image
//        self.ClickBlock = ClickBlock
//    }
    
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
    public let size: CGSize
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
        parseText()
    }
    
    private func parseText() {
        let attrStr = text
        let path = CGPath(rect: CGRect(origin: .zero, size: size), transform: nil)
        
        let framesetter = CTFramesetterCreateWithAttributedString(attrStr)
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attrStr.length), path, nil)
        let lines = CTFrameGetLines(frame) as! [CTLine]
        var lineOrigins = [CGPoint](repeating: .zero, count: lines.count)
        CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), &lineOrigins)
        for lineIndex in 0..<lines.count {
            let ctline = lines[lineIndex]
            let line = XWAKLine(line: ctline, position: lineOrigins[lineIndex])
            _innerLines.append(line)
            
            let runs = CTLineGetGlyphRuns(ctline) as! [CTRun]
            
            for run in runs {
                if let runAttrs = CTRunGetAttributes(run) as? Dictionary<NSAttributedString.Key, Any> {
                    if let imageDelegate = runAttrs[(kCTRunDelegateAttributeName as NSAttributedString.Key)] {
                        parseImages(line: line, run: run, imageDelegate: imageDelegate as! CTRunDelegate)
                    }
                }
            }
        }
    }
    
    private func parseImages(line: XWAKLine, run: CTRun, imageDelegate: CTRunDelegate) {
        let keyValue = CTRunDelegateGetRefCon(imageDelegate)
        var metaData = keyValue.assumingMemoryBound(to: XWAKImageMetaData.self).pointee
        let imageHeight = metaData.ascent + metaData.descent
        let imageWidth = metaData.width
        let x = CTLineGetOffsetForStringIndex(line.line, CTRunGetStringRange(run).location, nil)
        let y = line.position.y
        metaData.imageFrame = CGRect(x: x, y: y, width: imageWidth, height: imageHeight)
        _innerImages.append(metaData)
    }
    
    public func draw(context: CGContext) {
        for line in _innerLines {
            drawLine(line, context: context)
        }
        for imageData in _innerImages {
            context.draw(imageData.image.cgImage!, in: imageData.imageFrame)
        }
    }
    
    public func touchImage(in point: CGPoint) -> XWAKImageMetaData? {
        for imageData in _innerImages {
            print("image frame: \(imageData.imageFrame), touch point: \(point)")
            if imageData.imageFrame.contains(point) {
                return imageData
            }
        }
        return nil
    }
    
    private func drawLine(_ line: XWAKLine, context: CGContext) {
        let ctline = line.line
        let lineOrigin = line.position
        
        context.textPosition = lineOrigin
        
        let runs = CTLineGetGlyphRuns(ctline) as Array
        for run in runs {
            let run = run as! CTRun
            
            let attributes = CTRunGetAttributes(run) as NSDictionary
            let glyphCount = CTRunGetGlyphCount(run)
            var runPositions = [CGPoint](repeating: .zero, count: glyphCount)
            CTRunGetPositions(run, CFRangeMake(0, 0), &runPositions)
            
//            let stringRange = CTRunGetStringRange(run)
//            let xOffset = CTLineGetOffsetForStringIndex(ctline, stringRange.location, nil)
//            print("stringRange: \(stringRange), xOffset: \(xOffset), attrs: \(attributes)")
//            for glyphIndex in 0..<glyphCount {
//                print("glyphIndex: \(glyphIndex), position: \(runPositions[glyphIndex])")
//            }
            
            var glyphs = [CGGlyph](repeating: CGGlyph(), count: glyphCount)
            let runFont = attributes[NSAttributedString.Key.font] as! CTFont
            CTRunGetGlyphs(run, CFRangeMake(0, 0), &glyphs)
            if let fillColor = attributes[NSAttributedString.Key.foregroundColor] as? UIColor {
                context.setFillColor(fillColor.cgColor)
            }
            else {
                context.setFillColor(UIColor.black.cgColor)
            }
            context.setFont(CTFontCopyGraphicsFont(runFont, nil))
            context.setFontSize(CTFontGetSize(runFont))
            context.showGlyphs(glyphs, at: runPositions)
        }
    }
}
