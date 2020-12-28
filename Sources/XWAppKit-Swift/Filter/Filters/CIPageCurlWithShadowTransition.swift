import Foundation
import CoreImage

public class CIPageCurlWithShadowTransition: ImageFilter {
    public init() {
        super.init(name: "CIPageCurlWithShadowTransition")
    }
    public func inputRadius(_ inputRadius: Double) -> CIPageCurlWithShadowTransition {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIPageCurlWithShadowTransition {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputShadowExtent(_ inputShadowExtent: CIVector?) -> CIPageCurlWithShadowTransition {
        filter.setValue(inputShadowExtent, forKey:"inputShadowExtent")
        return self
    }
    public func inputBacksideImage(_ inputBacksideImage: CIImage?) -> CIPageCurlWithShadowTransition {
        filter.setValue(inputBacksideImage, forKey:"inputBacksideImage")
        return self
    }
    public func inputShadowAmount(_ inputShadowAmount: Double) -> CIPageCurlWithShadowTransition {
        filter.setValue(inputShadowAmount, forKey:"inputShadowAmount")
        return self
    }
    public func inputShadowSize(_ inputShadowSize: Double) -> CIPageCurlWithShadowTransition {
        filter.setValue(inputShadowSize, forKey:"inputShadowSize")
        return self
    }
    public func inputAngle(_ inputAngle: Double) -> CIPageCurlWithShadowTransition {
        filter.setValue(inputAngle, forKey:"inputAngle")
        return self
    }
    public func inputExtent(_ inputExtent: CIVector?) -> CIPageCurlWithShadowTransition {
        filter.setValue(inputExtent, forKey:"inputExtent")
        return self
    }
    public func inputTime(_ inputTime: Double) -> CIPageCurlWithShadowTransition {
        filter.setValue(inputTime, forKey:"inputTime")
        return self
    }
    public func inputTargetImage(_ inputTargetImage: CIImage?) -> CIPageCurlWithShadowTransition {
        filter.setValue(inputTargetImage, forKey:"inputTargetImage")
        return self
    }
}
