//
//  ImageFilter.swift
//  instaxphoto
//
//  Created by ZHXW on 2020/7/15.
//

import Foundation
import CoreImage
import UIKit

public enum XWAKFilter: String, CaseIterable {
    case AccordionFoldTransition = "CIAccordionFoldTransition"
}

// https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/uid/TP30000136-SW29
public class ImageFilter {
    public var localizedName: String {
        return CIFilter.localizedName(forFilterName: filter.name) ?? filter.name
    }
    internal var filter: CIFilter
    public var outputImage: CIImage? {
        get {
            return filter.outputImage
        }
    }
    
    init(name: String) {
        filter = CIFilter(name: name)!
    }
    
    init(name: XWAKFilter) {
        filter = CIFilter(name: name.rawValue)!
    }
    
    public func inputImage(_ inputImage: CIImage?) -> ImageFilter {
        return self
    }
    
    public func inputColor(_ inputColor: CIColor?) -> ImageFilter {
        return self
    }
}

// Usage:
    
public extension UIImage {
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
