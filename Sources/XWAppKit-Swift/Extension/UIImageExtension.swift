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
//        let (pointX, pointY) = (trunc(pos.x), trunc(pos.y))
//
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        var pixelData: [UInt8] = [0, 0, 0, 0]
//        pixelData.withUnsafeMutableBytes { pointer in
//            if let context = CGContext(data: pointer.baseAddress,
//                                       width: 1,
//                                       height: 1,
//                                       bitsPerComponent: 8,
//                                       bytesPerRow: 4,
//                                       space: colorSpace,
//                                       bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue),
//               let cgImage = cgImage {
//                context.setBlendMode(.copy)
//                context.translateBy(x: -pointX, y: pointY - size.height)
//                context.draw(cgImage, in: .init(origin: .zero, size: size))
//            }
//        }
//
//        let red = CGFloat(pixelData[0]) / 255.0
//        let green = CGFloat(pixelData[1]) / 255.0
//        let blue = CGFloat(pixelData[2]) / 255.0
//        let alpha = CGFloat(pixelData[3]) / 255.0
//
//        return UIColor(displayP3Red: red, green: green, blue: blue, alpha: alpha)
        return self[pos.x, pos.y] ?? .clear
    }
    
    func colors(around point: CGPoint, radius: Int, dis: Int) -> [UIColor] {
        var colors = [UIColor]()
        guard let imageData = cgImage?.dataProvider?.data,
              let imagePtr = CFDataGetBytePtr(imageData) else { return colors }
        let width = Int(size.width)
        let height = Int(size.height)
        let alphaInfo = cgImage!.alphaInfo
        
        let (lx, ly) = (Int(trunc(point.x)), Int(trunc(point.y)))
        for yIndex in -radius...radius {
            for xIndex in -radius...radius {
                let x = lx + xIndex * dis
                let y = ly + yIndex * dis
                if x < 0 || y < 0 || x > width || y > height {
                    colors.append(.black)
                    continue
                }
                let index = (y * width + x) * 4
                let rgba = imagePtr.advanced(by: index)
                
                var (red, green, blue, alpha): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 1.0)
                switch alphaInfo {
                case .none:
                    red = CGFloat(rgba.pointee) / 255.0
                    green = CGFloat(rgba.advanced(by: 1).pointee) / 255.0
                    blue = CGFloat(rgba.advanced(by: 2).pointee) / 255.0
                case .first, .noneSkipFirst, .premultipliedFirst:
                    alpha = alphaInfo == .noneSkipFirst ? 1.0 : CGFloat(rgba.pointee) / 255.0
                    blue = CGFloat(rgba.pointee) / 255.0
                    green = CGFloat(rgba.advanced(by: 1).pointee) / 255.0
                    red = CGFloat(rgba.advanced(by: 2).pointee) / 255.0
                case .last, .noneSkipLast, .premultipliedLast:
                    red = CGFloat(rgba.pointee) / 255.0
                    green = CGFloat(rgba.advanced(by: 1).pointee) / 255.0
                    blue = CGFloat(rgba.advanced(by: 2).pointee) / 255.0
                    alpha = alphaInfo == .noneSkipLast ? 1.0 : CGFloat(rgba.advanced(by: 3).pointee) / 255.0
                case .alphaOnly:
                    alpha = 1.0
                @unknown default:
                    print("error alpha info")
                }
                let color = UIColor(displayP3Red: red, green: green, blue: blue, alpha: alpha)
                colors.append(color)
            }
        }
        return colors
    }
    
    subscript(x: Int, y: Int) -> UIColor? {
        let (width, height) = (Int(size.width), Int(size.height))
        guard !(x < 0 || x > width || y < 0 || y > height) else { return nil }
        guard let provider = cgImage?.dataProvider,
              let imageData = provider.data,
              let imagePtr = CFDataGetBytePtr(imageData) else { return nil }
        let alphaInfo = cgImage!.alphaInfo
        let numberOfComponents = 4
        let index = (y * width + x) * numberOfComponents
        let rgba = imagePtr.advanced(by: index)
        
        var (r, g, b, a): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 1.0)
        switch alphaInfo {
        case .none:
            r = CGFloat(rgba.pointee) / 255.0
            g = CGFloat(rgba.advanced(by: 1).pointee) / 255.0
            b = CGFloat(rgba.advanced(by: 2).pointee) / 255.0
        case .first, .noneSkipFirst, .premultipliedFirst:
            a = alphaInfo == .noneSkipFirst ? 1.0 : CGFloat(rgba.pointee) / 255.0
            b = CGFloat(rgba.pointee) / 255.0
            g = CGFloat(rgba.advanced(by: 1).pointee) / 255.0
            r = CGFloat(rgba.advanced(by: 2).pointee) / 255.0
        case .last, .noneSkipLast, .premultipliedLast:
            r = CGFloat(rgba.pointee) / 255.0
            g = CGFloat(rgba.advanced(by: 1).pointee) / 255.0
            b = CGFloat(rgba.advanced(by: 2).pointee) / 255.0
            a = alphaInfo == .noneSkipLast ? 1.0 : CGFloat(rgba.advanced(by: 3).pointee) / 255.0
        case .alphaOnly:
            a = 1.0
        @unknown default:
            print("error alpha info")
        }
        
        return UIColor(displayP3Red: r, green: g, blue: b, alpha: a)
    }
    
    subscript(x: CGFloat, y: CGFloat) -> UIColor? {
        guard !(x < 0 || x > size.width || y < 0 || y > size.height) else { return nil }
        let (x, y) = (Int(trunc(x)), Int(trunc(y)))
        return self[x, y]
    }
}
