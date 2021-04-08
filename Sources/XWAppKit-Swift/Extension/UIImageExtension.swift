//
//  UIImageExtension.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/9/25.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import Foundation

private class BundleFinder {}

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
        
        if let bundle = bundleFromModule() {
            return UIImage(named: name, in: bundle, compatibleWith: nil)
        }
        else {
            let bundle = Bundle(for: XWAKPhotoKit.self)
            let image = UIImage(named: name)
            if image != nil {
                return image
            }
            return UIImage(named: name, in: bundle, compatibleWith: nil)
        }
    }
    
    fileprivate static func bundleFromModule() -> Bundle? {
        let bundleName = "XWAppKit-Swift_XWAppKit-Swift"

        let candidates = [
            // Bundle should be present here when the package is linked into an App.
            Bundle.main.resourceURL,

            // Bundle should be present here when the package is linked into a framework.
            Bundle(for: BundleFinder.self).resourceURL,

            // For command-line tools.
            Bundle.main.bundleURL,
        ]

        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        return nil
    }
    
    func fixOrientation() -> UIImage {
        guard imageOrientation != .up else {
            return self
        }
        var tt = CGAffineTransform.identity
        let realSize = imageOrientationUpSize()
        switch imageOrientation {
        case .left, .leftMirrored:
            tt = tt.translatedBy(x: realSize.width, y: 0).rotated(by: .pi / 2)
        case .right, .rightMirrored:
            tt = tt.translatedBy(x: 0, y: realSize.height).rotated(by: -.pi / 2)
        case .down, .downMirrored:
            tt = tt.translatedBy(x: realSize.width, y: realSize.height).rotated(by: .pi)
        default:
            tt = .identity
        }
        
        if let ctx = CGContext(data: nil,
                               width: Int(realSize.width),
                               height: Int(realSize.height),
                               bitsPerComponent: cgImage!.bitsPerComponent,
                               bytesPerRow: Int(realSize.width) * 8,
                               space: cgImage!.colorSpace!,
                               bitmapInfo: cgImage!.bitmapInfo.rawValue) {
            ctx.concatenate(tt)
            if let ii = ctx.makeImage() {
                return UIImage(cgImage: ii)
            }
        }
//        defer {
//            UIGraphicsEndImageContext()
//        }
//        UIGraphicsBeginImageContext(realSize)
//        if let ctx = UIGraphicsGetCurrentContext() {
//            ctx.concatenate(tt)
//            ctx.draw(cgImage!, in: .init(origin: .zero, size: realSize))
//            return UIGraphicsGetImageFromCurrentImageContext() ?? self
//        }
        return self
    }
    
    func loadPixels() -> [UInt8] {
        let orientation = imageOrientation
        var tt = CGAffineTransform.identity
        let realSize = imageOrientationUpSize()
        let (width, height) = (Int(realSize.width), Int(realSize.height))
        switch orientation {
        case .up:
            print("正的， 不用改")
        case .left, .leftMirrored:
            tt = tt.translatedBy(x: realSize.width, y: 0).rotated(by: .pi / 2)
            print("向左旋转90度")
        case .right, .rightMirrored:
            tt = tt.translatedBy(x: 0, y: realSize.height).rotated(by: -.pi / 2)
            print("向右旋转90度")
        case .down, .downMirrored:
            tt = tt.translatedBy(x: size.width, y: size.height).rotated(by: .pi)
            print("上下颠倒")
        default:
            print("不用修改")
        }
        
        var pixelData: [UInt8] = [UInt8](repeating: 0, count: width * height * 4)
        let bitmapInfo = CGBitmapInfo.byteOrder32Big.rawValue | CGImageAlphaInfo.premultipliedLast.rawValue
        pixelData.withUnsafeMutableBytes { pointer in
            if let ctx = CGContext(data: pointer.baseAddress,
                                width: width,
                                height: height,
                                bitsPerComponent: 8,
                                bytesPerRow: width * 4,
                                space: CGColorSpaceCreateDeviceRGB(),
                                bitmapInfo: bitmapInfo),
               let cgImage = cgImage {
                ctx.concatenate(tt)
                ctx.draw(cgImage, in: .init(origin: .zero, size: size))
            }
        }
        return pixelData
    }
    
    func imageOrientationUpSize() -> CGSize {
        let orientation = imageOrientation
        let (width, height): (CGFloat, CGFloat)
        switch orientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            (width, height) = (size.height, size.width)
        default:
            (width, height) = (size.width, size.height)
        }
        return .init(width: width, height: height)
    }
    
    func color(from pos: CGPoint) -> UIColor {
        return self[pos.x, pos.y] ?? .clear
    }
    
    func colors(around point: CGPoint, radius: Int, disScale: Int) -> [UIColor] {
        var colors = [UIColor]()
        guard let imageData = cgImage?.dataProvider?.data,
              let imagePtr = CFDataGetBytePtr(imageData) else { return colors }
        let width = Int(size.width)
        let height = Int(size.height)
        let alphaInfo = cgImage!.alphaInfo
        
        let (lx, ly) = (Int(trunc(point.x)), Int(trunc(point.y)))
        for yIndex in -radius...radius {
            for xIndex in -radius...radius {
                let x = lx + xIndex * disScale
                let y = ly + yIndex * disScale
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
