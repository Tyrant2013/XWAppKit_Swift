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
            var start = selectionView.start
            var end = selectionView.end
            if start == end { return "" }
            if start.index > end.index { (start, end) = (end, start) }
            
            var result = ""
            if start.index != end.index {
                var line = layout.lines[start.index]
                var startIndex = line.stringIndex(for: start.rect.origin)
                var endIndex = line.textRange.location + line.textRange.length
                result += originStr[startIndex..<endIndex]
                
                for index in (start.index + 1)..<end.index {
                    let line = layout.lines[index]
                    let strRange = CTLineGetStringRange(line.line)
                    result += originStr[strRange.location..<(strRange.location + strRange.length)]
                }
                
                line = layout.lines[end.index]
                startIndex = line.textRange.location
                endIndex = line.stringIndex(for: end.rect.origin)
                result += originStr[startIndex..<endIndex]
            }
            else {
                let startIndex = CTLineGetStringIndexForPosition(layout.lines[start.index].line, start.rect.origin)
                let endIndex = CTLineGetStringIndexForPosition(layout.lines[end.index].line, end.rect.origin)
                result += originStr[startIndex..<endIndex]
            }
            return result
        }
    }
    
    private var selectionView = XWAKTextSelectionView()
    private var selectionRect = [CGRect: XWAKLine]()
    private var hadAlreadyLine: XWAKLine?
    public var selectable: Bool = false {
        didSet {
            
        }
    }
    private var longPressTimer: Timer?
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
    
    public override var canBecomeFirstResponder: Bool {
        return true
    }
    
    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(selectAll(_:)) {
            return true
        }
        if action == #selector(select(_:)) {
            return true
        }
        return false
    }
    
    public override func copy(_ sender: Any?) {
        
    }
    
    public override func select(_ sender: Any?) {
        
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
        case normal
        case move(origin: CGPoint)
        case willShowMenu
        case selection
    }
    private var touchState: TouchState = .normal
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
        
        if case .normal = touchState {
            selectionView.start = .zero
            selectionView.end = .zero
        }
        
        if selectable , case .normal = touchState {
            longPressTimer = Timer(timeInterval: 0.5, repeats: false, block: { [weak self](timer) in
                print("invoke long press")
                timer.invalidate()
                self?.longPressTimer = nil
                self?.touchState = .selection
                self?.panGestureRecognizer.isEnabled = false
                
                for (index, line) in layout.lines.enumerated() {
                    if line.extBounds.contains(touchPoint) {
                        let textOffset = line.textPosition(for: touchPoint)
                        let rect = CGRect(origin: textOffset, size: CGSize(width: 0, height: line.bounds.height))
                        let pos = XWAKSelectionPosition(rect: rect, index: index)
                        self?.selectionView.start = pos
                        self?.selectionView.end = pos
                        break
                    }
                }
            })
            RunLoop.main.add(longPressTimer!, forMode: .common)
        }
    }

    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        longPressTimer?.invalidate()
        longPressTimer = nil
        guard let layout = layout,
              let touch = touches.first else {
            super.touchesMoved(touches, with: event)
            return
        }

        let touchPoint = touch.location(in: self)
        if selectable, case .selection = touchState {
            select(at: touchPoint, from: layout)
        }
    }
    
    private func select(at point: CGPoint, from layout: XWAKTextLayout) {
        panGestureRecognizer.isEnabled = false
        let touchPosition: (_ line: XWAKLine, _ index: Int) -> XWAKSelectionPosition = {
            let textOffset = $0.textPosition(for: point)
            let rect = CGRect(origin: textOffset, size: CGSize(width: 0, height: $0.bounds.height))
            return XWAKSelectionPosition(rect: rect, index: $1)
        }
        if !(hadAlreadyLine?.extBounds.contains(point) ?? false) {
            for (index, line) in layout.lines.enumerated() {
                if line.extBounds.contains(point) {
                    hadAlreadyLine = line
                    let pos = touchPosition(line, index)
                    selectionView.end = pos
                    break
                }
            }
        }
        else {
            let pos = touchPosition(hadAlreadyLine!, selectionView.end.index)
            if selectionView.end != pos {
                selectionView.end = pos
            }
        }
    }
    @objc
    func startSelection() {
        
    }
    @objc
    func selectionAll() {
        
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        longPressTimer?.invalidate()
        longPressTimer = nil
        panGestureRecognizer.isEnabled = true
        self.becomeFirstResponder()
        UIMenuController.shared.setMenuVisible(true, animated: true)
//        if case .willShowMenu = touchState {
//            let touch = touches.first!
//            let touchPoint = touch.location(in: self)
//            if let _ = layout!.lines.first(where: { $0.extBounds.contains(touchPoint) }) {
//                if let window = UIApplication.shared.delegate?.window {
//                    print(window?.isKeyWindow)
//                }
//
//                let selectItem = UIMenuItem(title: "Select", action: #selector(startSelection))
//                let selectAllItem = UIMenuItem(title: "SelectAll", action: #selector(selectionAll))
//                UIMenuController.shared.menuItems = [selectItem, selectAllItem]
//                UIMenuController.shared.setMenuVisible(true, animated: true)
//            }
//        }
        if case .selection = touchState {
            print("selected string: ", selectedString as Any)
        }
    }
}
