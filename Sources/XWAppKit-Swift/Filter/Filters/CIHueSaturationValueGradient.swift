import Foundation
import CoreImage

public class CIHueSaturationValueGradient: ImageFilter {
    public init() {
        super.init(name: "CIHueSaturationValueGradient")
    }
    public func inputColorSpace(_ inputColorSpace: NSObject?) -> CIHueSaturationValueGradient {
        filter.setValue(inputColorSpace, forKey:"inputColorSpace")
        return self
    }
    public func inputDither(_ inputDither: Double) -> CIHueSaturationValueGradient {
        filter.setValue(inputDither, forKey:"inputDither")
        return self
    }
    public func inputValue(_ inputValue: Double) -> CIHueSaturationValueGradient {
        filter.setValue(inputValue, forKey:"inputValue")
        return self
    }
    public func inputSoftness(_ inputSoftness: Double) -> CIHueSaturationValueGradient {
        filter.setValue(inputSoftness, forKey:"inputSoftness")
        return self
    }
    public func inputRadius(_ inputRadius: Double) -> CIHueSaturationValueGradient {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
}
