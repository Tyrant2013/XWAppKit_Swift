import Foundation
import CoreImage

public class CIDisintegrateWithMaskTransition: ImageFilter {
    init() {
        super.init(name: "CIDisintegrateWithMaskTransition")
    }
    public func inputMaskImage(_ inputMaskImage: CIImage?) -> CIDisintegrateWithMaskTransition {
        filter.setValue(inputMaskImage, forKey:"inputMaskImage")
        return self
    }
    public func inputShadowRadius(_ inputShadowRadius: Double) -> CIDisintegrateWithMaskTransition {
        filter.setValue(inputShadowRadius, forKey:"inputShadowRadius")
        return self
    }
    public func inputTime(_ inputTime: Double) -> CIDisintegrateWithMaskTransition {
        filter.setValue(inputTime, forKey:"inputTime")
        return self
    }
    public func inputShadowDensity(_ inputShadowDensity: Double) -> CIDisintegrateWithMaskTransition {
        filter.setValue(inputShadowDensity, forKey:"inputShadowDensity")
        return self
    }
    public func inputShadowOffset(_ inputShadowOffset: CIVector?) -> CIDisintegrateWithMaskTransition {
        filter.setValue(inputShadowOffset, forKey:"inputShadowOffset")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIDisintegrateWithMaskTransition {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputTargetImage(_ inputTargetImage: CIImage?) -> CIDisintegrateWithMaskTransition {
        filter.setValue(inputTargetImage, forKey:"inputTargetImage")
        return self
    }
}
