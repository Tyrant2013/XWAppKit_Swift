import Foundation
import CoreImage

public class CIRippleTransition: ImageFilter {
    public init() {
        super.init(name: "CIRippleTransition")
    }
    public func inputWidth(_ inputWidth: Double) -> CIRippleTransition {
        filter.setValue(inputWidth, forKey:"inputWidth")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CIRippleTransition {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    public func inputTime(_ inputTime: Double) -> CIRippleTransition {
        filter.setValue(inputTime, forKey:"inputTime")
        return self
    }
    public func inputShadingImage(_ inputShadingImage: CIImage?) -> CIRippleTransition {
        filter.setValue(inputShadingImage, forKey:"inputShadingImage")
        return self
    }
    public func inputScale(_ inputScale: Double) -> CIRippleTransition {
        filter.setValue(inputScale, forKey:"inputScale")
        return self
    }
    public func inputTargetImage(_ inputTargetImage: CIImage?) -> CIRippleTransition {
        filter.setValue(inputTargetImage, forKey:"inputTargetImage")
        return self
    }
    public func inputExtent(_ inputExtent: CIVector?) -> CIRippleTransition {
        filter.setValue(inputExtent, forKey:"inputExtent")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIRippleTransition {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
