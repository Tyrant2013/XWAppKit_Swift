import Foundation
import CoreImage

public class CIBicubicScaleTransform: ImageFilter {
    init() {
        super.init(name: "CIBicubicScaleTransform")
    }
    public func inputC(_ inputC: Double) -> CIBicubicScaleTransform {
        filter.setValue(inputC, forKey:"inputC")
        return self
    }
    public func inputAspectRatio(_ inputAspectRatio: Double) -> CIBicubicScaleTransform {
        filter.setValue(inputAspectRatio, forKey:"inputAspectRatio")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIBicubicScaleTransform {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputB(_ inputB: Double) -> CIBicubicScaleTransform {
        filter.setValue(inputB, forKey:"inputB")
        return self
    }
    public func inputScale(_ inputScale: Double) -> CIBicubicScaleTransform {
        filter.setValue(inputScale, forKey:"inputScale")
        return self
    }
}
