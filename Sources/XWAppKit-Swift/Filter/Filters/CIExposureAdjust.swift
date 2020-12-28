import Foundation
import CoreImage

public class CIExposureAdjust: ImageFilter {
    init() {
        super.init(name: "CIExposureAdjust")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIExposureAdjust {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputEV(_ inputEV: Double) -> CIExposureAdjust {
        filter.setValue(inputEV, forKey:"inputEV")
        return self
    }
}
