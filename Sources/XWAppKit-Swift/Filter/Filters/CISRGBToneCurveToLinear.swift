import Foundation
import CoreImage

public class CISRGBToneCurveToLinear: ImageFilter {
    public init() {
        super.init(name: "CISRGBToneCurveToLinear")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CISRGBToneCurveToLinear {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
