import Foundation
import CoreImage

public class CIFlashTransition: ImageFilter {
    init() {
        super.init(name: "CIFlashTransition")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIFlashTransition {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputStriationContrast(_ inputStriationContrast: Double) -> CIFlashTransition {
        filter.setValue(inputStriationContrast, forKey:"inputStriationContrast")
        return self
    }
    public func inputExtent(_ inputExtent: CIVector?) -> CIFlashTransition {
        filter.setValue(inputExtent, forKey:"inputExtent")
        return self
    }
    public func inputTargetImage(_ inputTargetImage: CIImage?) -> CIFlashTransition {
        filter.setValue(inputTargetImage, forKey:"inputTargetImage")
        return self
    }
    override public func inputColor(_ inputColor: CIColor?) -> CIFlashTransition {
        filter.setValue(inputColor, forKey:"inputColor")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CIFlashTransition {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    public func inputMaxStriationRadius(_ inputMaxStriationRadius: Double) -> CIFlashTransition {
        filter.setValue(inputMaxStriationRadius, forKey:"inputMaxStriationRadius")
        return self
    }
    public func inputTime(_ inputTime: Double) -> CIFlashTransition {
        filter.setValue(inputTime, forKey:"inputTime")
        return self
    }
    public func inputStriationStrength(_ inputStriationStrength: Double) -> CIFlashTransition {
        filter.setValue(inputStriationStrength, forKey:"inputStriationStrength")
        return self
    }
    public func inputFadeThreshold(_ inputFadeThreshold: Double) -> CIFlashTransition {
        filter.setValue(inputFadeThreshold, forKey:"inputFadeThreshold")
        return self
    }
}
