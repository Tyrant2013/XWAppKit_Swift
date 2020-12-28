import Foundation
import CoreImage

public class CIDepthOfField: ImageFilter {
    public init() {
        super.init(name: "CIDepthOfField")
    }
    public func inputPoint1(_ inputPoint1: CIVector?) -> CIDepthOfField {
        filter.setValue(inputPoint1, forKey:"inputPoint1")
        return self
    }
    public func inputRadius(_ inputRadius: Double) -> CIDepthOfField {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
    public func inputUnsharpMaskRadius(_ inputUnsharpMaskRadius: Double) -> CIDepthOfField {
        filter.setValue(inputUnsharpMaskRadius, forKey:"inputUnsharpMaskRadius")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIDepthOfField {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputPoint0(_ inputPoint0: CIVector?) -> CIDepthOfField {
        filter.setValue(inputPoint0, forKey:"inputPoint0")
        return self
    }
    public func inputUnsharpMaskIntensity(_ inputUnsharpMaskIntensity: Double) -> CIDepthOfField {
        filter.setValue(inputUnsharpMaskIntensity, forKey:"inputUnsharpMaskIntensity")
        return self
    }
    public func inputSaturation(_ inputSaturation: Double) -> CIDepthOfField {
        filter.setValue(inputSaturation, forKey:"inputSaturation")
        return self
    }
}
