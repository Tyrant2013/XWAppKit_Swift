//
//  XWAKColorWheelView.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2020/12/10.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

struct RGB {
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var alpha: CGFloat
}

struct HSB {
    var hue: CGFloat
    var saturation: CGFloat
    var brightness: CGFloat
    var alpha: CGFloat
}

class XWAKColorWheelView: UIControl {
    
    public var hue: CGFloat = 0.0 {
        didSet {
            if oldValue != hue {
                updateIndicatorPosition(selectedPoint)
                setNeedsDisplay()
            }
        }
    }
    public var saturation: CGFloat = 0.0 {
        didSet {
            if oldValue != saturation {
                updateIndicatorPosition(selectedPoint)
                setNeedsDisplay()
            }
        }
    }
    public var brightness: CGFloat = 1.0 {
        didSet {
            if oldValue != brightness {
                drawWheelImage()
                updateIndicatorPosition(selectedPoint)
            }
        }
    }
    
    private lazy var indicator: CALayer = {
        let dimension: CGFloat = 33
        let edgeColor = UIColor(white: 0.9, alpha: 0.8)
        
        let layer = CALayer()
        layer.cornerRadius = dimension / 2
        layer.borderColor = edgeColor.cgColor
        layer.borderWidth = 2
        layer.backgroundColor = UIColor.white.cgColor
        layer.bounds = .init(origin: .zero, size: .init(width: dimension, height: dimension))
        layer.position = .init(x: bounds.width / 2, y: bounds.height / 2)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 1
        layer.shadowOpacity = 0.5
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initLayer()
    }
    
    private func initLayer() {
        accessibilityLabel = "Color_Wheel_View"
        layer.delegate = self
        layer.addSublayer(indicator)
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    override func display(_ layer: CALayer) {
        guard layer.contents == nil else { return }
        drawWheelImage()
    }
    
    override func layoutSublayers(of layer: CALayer) {
        if layer == self.layer {
            updateIndicatorPosition(self.selectedPoint)
            self.layer.setNeedsDisplay()
        }
    }
    
    public var selectedPoint: CGPoint {
        let dimension = min(bounds.width, bounds.height)
        let radius = saturation * dimension / 2
        let x = dimension / 2 + radius * CGFloat(cos(Double(hue) * .pi * 2.0))
        let y = dimension / 2 + radius * CGFloat(sin(Double(hue) * .pi * 2.0))
        return .init(x: x, y: y)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let position = touches.first?.location(in: self) {
            touchOn(position)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let position = touches.first?.location(in: self) {
            touchOn(position)
        }
    }
    
    private func touchOn(_ position: CGPoint) {
        let radius = bounds.width / 2
        let mx = Double(radius - position.x)
        let my = Double(radius - position.y)
        let dist = CGFloat(sqrt(mx * mx + my * my))
        
        if dist <= radius {
            var (h, s) = (hue, saturation)
            colorWheelValue(with: position, hue: &h, saturation: &s)
            (hue, saturation) = (h, s)
            updateIndicatorPosition(position)
            sendActions(for: .valueChanged)
        }
    }
    
    private func updateIndicatorPosition(_ position: CGPoint) {
        let selectedColor = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        indicator.position = position
        indicator.backgroundColor = selectedColor.cgColor
        CATransaction.commit()
    }
    
    private func drawWheelImage() {
        let dimension: CGFloat = min(bounds.width, bounds.height)
        guard let bitmapData = CFDataCreateMutable(nil, 0) else { return }
        CFDataSetLength(bitmapData, CFIndex(dimension * dimension * 4))
        colorWheelBitmap(bitmap: CFDataGetMutableBytePtr(bitmapData), with: .init(width: dimension, height: dimension))
        if let image = imageWithRGBAData(data: bitmapData, width: Int(dimension), height: Int(dimension)) {
            layer.contents = image
        }
    }
    
    private func colorWheelBitmap(bitmap: UnsafeMutablePointer<UInt8>, with size: CGSize) {
        if size.width <= 0 || size.height <= 0 { return }
        for y in 0..<Int(size.width) {
            for x in 0..<Int(size.height) {
                var hue: CGFloat = 0, saturation: CGFloat = 0, a: CGFloat = 0.0
                var (h, s) = (hue, saturation)
                colorWheelValue(with: CGPoint(x: x, y: y), hue: &h, saturation: &s)
                (hue, saturation) = (h, s)
                
                var rgb = RGB(red: 1, green: 1, blue: 1, alpha: 1)
                if saturation < 1.0 {
                    if saturation > 0.99 { a = (1.0 - saturation) * 100 }
                    else { a = 1.0 }
                    let hsb = HSB(hue: hue, saturation: saturation, brightness: brightness, alpha: a)
                    rgb = HSBToRGB(hsb: hsb)
                }
                let i = 4 * (x + y * Int(size.width))
                bitmap[i] = UInt8(rgb.red * 0xFF)
                bitmap[i + 1] = UInt8(rgb.green * 0xFF)
                bitmap[i + 2] = UInt8(rgb.blue * 0xFF)
                bitmap[i + 3] = UInt8(rgb.alpha * 0xFF)
            }
            
        }
    }
    
    private func HSBToRGB(hsb: HSB) -> RGB {
//        let color = UIColor(hue: hsb.hue, saturation: hsb.saturation, brightness: hsb.brightness, alpha: hsb.alpha)
//        var (red, green, blue, alpha): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
//        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
//        return RGB(red: min(red, 1.0), green: min(green, 1.0), blue: min(blue, 1.0), alpha: min(alpha, 1.0))
        
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0

        let i: Int = Int(hsb.hue * 6)
        let f = hsb.hue * 6 - CGFloat(i)
        let p = hsb.brightness * (1 - hsb.saturation)
        let q = hsb.brightness * (1 - f * hsb.saturation)
        let t = hsb.brightness * (1 - (1 - f) * hsb.saturation)

        switch i % 6 {
        case 0:
            (r, g, b) = (hsb.brightness, t, p)
        case 1:
            (r, g, b) = (q, hsb.brightness, p)
        case 2:
            (r, g, b) = (p, hsb.brightness, t)
        case 3:
            (r, g, b) = (p, q, hsb.brightness)
        case 4:
            (r, g, b) = (t, p, hsb.brightness)
        case 5:
            (r, g, b) = (hsb.brightness, p, q)
        default:
            break
        }
        return RGB(red: r, green: g, blue: b, alpha: alpha)
    }

    private func colorWheelValue(with position: CGPoint, hue: inout CGFloat, saturation: inout CGFloat) {
        let c = Int(bounds.width / 2)
        let dx = (position.x - CGFloat(c)) / CGFloat(c)
        let dy = (position.y - CGFloat(c)) / CGFloat(c)
        let d = CGFloat(sqrt(Double(dx * dx + dy * dy)))
        
        saturation = d
        
        if d == 0 { hue = 0 }
        else {
            hue = acos(dx / d) / .pi / 2.0
            if dy < 0 { hue = 1.0 - hue }
        }
    }
    
    private func imageWithRGBAData(data: CFData, width: Int, height: Int) -> CGImage? {
        guard let dataProvider = CGDataProvider(data: data) else { return nil }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let imageRef = CGImage(width: width,
                               height: height,
                               bitsPerComponent: 8,
                               bitsPerPixel: 32,
                               bytesPerRow: width * 4,
                               space: colorSpace,
                               bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.last.rawValue),
                               provider: dataProvider,
                               decode: nil,
                               shouldInterpolate: false,
                               intent: CGColorRenderingIntent.defaultIntent)
        return imageRef
    }

}
