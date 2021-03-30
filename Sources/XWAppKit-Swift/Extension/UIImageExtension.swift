//
//  UIImageExtension.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/9/25.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public extension UIImage {
    static func make(byRoundingCorners corners: UIRectCorner, radius: CGFloat) -> UIImage? {
        let rect = CGRect(origin: .zero, size: CGSize(width: radius * 2 + 1, height: radius * 2 + 1))
        let radii = CGSize(width: radius, height: radius)
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: radii)
        let capInset: CGFloat = radius + 0.1
        let capInsets = UIEdgeInsets(top: capInset, left: capInset, bottom: capInset, right: capInset)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        UIColor.white.setStroke()
        path.fill()
        return UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: capInsets)
    }
    
    static func xwak_frameImage(name: String) -> UIImage? {
        let bundle = Bundle(for: XWAKPhotoKit.self)
        let image = UIImage(named: name)
        if image != nil {
            return image
        }
        return UIImage(named: name, in: bundle, compatibleWith: nil)
    }
    
    func color(from pos: CGPoint) -> UIColor {
        let (pointX, pointY) = (trunc(pos.x), trunc(pos.y))
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        var pixelData: [UInt8] = [0, 0, 0, 0]
        pixelData.withUnsafeMutableBytes { pointer in
            if let context = CGContext(data: pointer.baseAddress,
                                       width: 1,
                                       height: 1,
                                       bitsPerComponent: 8,
                                       bytesPerRow: 4,
                                       space: colorSpace,
                                       bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue),
               let cgImage = cgImage {
                context.setBlendMode(.copy)
                context.translateBy(x: -pointX, y: pointY - size.height)
                context.draw(cgImage, in: .init(origin: .zero, size: size))
            }
        }

        let red = CGFloat(pixelData[0]) / 255.0
        let green = CGFloat(pixelData[1]) / 255.0
        let blue = CGFloat(pixelData[2]) / 255.0
        let alpha = CGFloat(pixelData[3]) / 255.0
        
        return UIColor(displayP3Red: red, green: green, blue: blue, alpha: alpha)
    }
    
    subscript(x: Int, y: Int) -> UIColor? {
        guard x < 0 || x > Int(size.width) || y < 0 || y > Int(size.height) else { return nil }
        let provider = cgImage!.dataProvider
        let providerData = provider!.data
        let data = CFDataGetBytePtr(providerData!)
        let numberOfComponents = 4
        let pixelData = ((Int(size.width) * y) + x) * numberOfComponents
        let r = CGFloat(data![pixelData]) / 255.0
        let g = CGFloat(data![pixelData + 1]) / 255.0
        let b = CGFloat(data![pixelData] + 2) / 255.0
        let a = CGFloat(data![pixelData] + 3) / 255.0
        
        return UIColor(displayP3Red: r, green: g, blue: b, alpha: a)
    }
    
    subscript(x: CGFloat, y: CGFloat) -> UIColor? {
        guard x < 0 || x > size.width || y < 0 || y > size.height else { return nil }
        let x = Int(x)
        let y = Int(y)
        return self[x, y]
    }
}
