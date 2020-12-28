import Foundation
import CoreImage

public class CIPageCurlTransition: ImageFilter {
    init() {
        super.init(name: "CIPageCurlTransition")
    }
    public func inputExtent(_ inputExtent: CIVector?) -> CIPageCurlTransition {
        filter.setValue(inputExtent, forKey:"inputExtent")
        return self
    }
    public func inputTargetImage(_ inputTargetImage: CIImage?) -> CIPageCurlTransition {
        filter.setValue(inputTargetImage, forKey:"inputTargetImage")
        return self
    }
    public func inputTime(_ inputTime: Double) -> CIPageCurlTransition {
        filter.setValue(inputTime, forKey:"inputTime")
        return self
    }
    public func inputShadingImage(_ inputShadingImage: CIImage?) -> CIPageCurlTransition {
        filter.setValue(inputShadingImage, forKey:"inputShadingImage")
        return self
    }
    public func inputBacksideImage(_ inputBacksideImage: CIImage?) -> CIPageCurlTransition {
        filter.setValue(inputBacksideImage, forKey:"inputBacksideImage")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIPageCurlTransition {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputAngle(_ inputAngle: Double) -> CIPageCurlTransition {
        filter.setValue(inputAngle, forKey:"inputAngle")
        return self
    }
    public func inputRadius(_ inputRadius: Double) -> CIPageCurlTransition {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
}
