//
//  XWAKTextView.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/9/18.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import CoreText

extension CGRect: Hashable {
//    public var hashValue: Int {
//        return minX.hashValue
//    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(minX)
        hasher.combine(minY)
        hasher.combine(width)
        hasher.combine(height)
    }
}

public class XWAKTextView: UIScrollView {
    
    private let containerView: XWAKTextContainerView = XWAKTextContainerView()
    
    public var layout: XWAKTextLayout?
    public var attributeString: NSAttributedString? {
        didSet {
            if let attrStr = attributeString {
                layout = XWAKTextLayout(text: attrStr, size: .zero)
            }
            else {
                layout = nil
            }
        }
    }
    public var selectedString: String? {
        get {
            guard let layout = layout, let attrStr = attributeString else { return nil }
            let originStr = attrStr.string
            return layout.lines.filter { $0.selected }.reduce("") { (result, line) -> String in
                let strRange = CTLineGetStringRange(line.line)
                let start = originStr.index(originStr.startIndex, offsetBy: strRange.location)
                let end = originStr.index(originStr.startIndex, offsetBy: strRange.location + strRange.length)
                return result + String(originStr[start..<end])
            }
        }
    }
    
    private var selectionView = XWAKTextSelectionView()
    private var selectionRect = [CGRect: XWAKLine]()
    public var selectable: Bool = false {
        didSet {
            
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.backgroundColor = backgroundColor
        
        if let layout = layout, layout.size == .zero {
            layout.updateSize(bounds.size)
            
            containerView.frame = CGRect(origin: .zero, size: layout.size)
            contentSize = layout.size
            containerView.layout = layout
            selectionView.frame = containerView.frame
        }
        
        
    }
    
    private func setup() {
        addSubview(containerView)
        addSubview(selectionView)
        selectionView.lineBoundsHandler = {[weak self](index) in
            guard let layout = self?.layout else {
                return .zero
            }
            return layout.lines[index].bounds
        }
    }
    
    private enum TouchState {
        case nomarl
        case move(origin: CGPoint)
    }
    private var touchState: TouchState = .nomarl
    private var startState = false

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

extension XWAKTextView {
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let layout = layout else {
            super.touchesBegan(touches, with: event)
            return
        }
        let touch = touches.first!
        let touchPoint = touch.location(in: self)
        touchState = .move(origin: touchPoint)
        
        if selectable {
            for (index, line) in layout.lines.enumerated() {
                if line.extBounds.contains(touchPoint) {
                    let textOffset = line.textPosition(for: touchPoint)
                    let rect = CGRect(origin: textOffset, size: CGSize(width: 0, height: line.bounds.height))
                    let pos = XWAKSelectionPosition(rect: rect, index: index)
                    selectionView.start = pos
                    selectionView.end = .zero
                    break
                }
            }
        }
    }

    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let layout = layout,
              let touch = touches.first else {
            super.touchesMoved(touches, with: event)
            return
        }

        let touchPoint = touch.location(in: self)
        if selectable {
            for (index, line) in layout.lines.enumerated() {
                if line.extBounds.contains(touchPoint) {
                    panGestureRecognizer.isEnabled = false
                    let textOffset = line.textPosition(for: touchPoint)
                    let rect = CGRect(origin: textOffset, size: CGSize(width: 0, height: line.bounds.height))
                    let pos = XWAKSelectionPosition(rect: rect, index: index)
                    selectionView.end = pos
                    break
                }
            }
        }
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        startState = false
        panGestureRecognizer.isEnabled = true
    }
}

extension XWAKTextView {
    private func updateSelections(at point: CGPoint) {
        guard selectable == true, let layout = layout else { return }
        for line in layout.lines {
            if line.bounds.contains(point) {
                let selLine = selectionRect[line.bounds]
                if selLine == nil && startState {
                    selectionRect[line.bounds] = line
                }
                line.selected = startState
                containerView.update()
                if !line.selected {
                    selectionRect[line.bounds] = nil
                }
                break
            }
        }
    }
}

extension UIButton {
    
}
