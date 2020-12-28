//
//  ImageFilter.swift
//  instaxphoto
//
//  Created by ZHXW on 2020/7/15.
//

import Foundation
import CoreImage
import UIKit

// https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/uid/TP30000136-SW29
public class ImageFilter {
    internal var filter: CIFilter
    public var outputImage: CIImage? {
        get {
            return filter.outputImage
        }
    }
    
    init(name: String) {
        filter = CIFilter(name: name)!
    }
    
    public func inputImage(_ inputImage: CIImage?) -> ImageFilter {
        return self
    }
    
    public func inputColor(_ inputColor: CIColor?) -> ImageFilter {
        return self
    }
}

// Usage:
    
extension UIImage {
    func applyingFilter(_ filter: ImageFilter) -> UIImage {
        let ciImage = self.ciImage != nil ? self.ciImage : CIImage(image: self)
        if let filteredImage = filter.inputImage(ciImage).outputImage {
            return UIImage(ciImage: filteredImage)
        }
        return self
    }
}
//let image = UIImage(named: "abc")!
//            .applyingFilter(CISepiaTone()
//                            .inputIntensity(NSNumber(floatLiteral: 10))))
//let iv = UIImageView(image: image)
