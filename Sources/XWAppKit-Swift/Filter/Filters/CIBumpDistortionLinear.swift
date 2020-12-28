import Foundation
import CoreImage

public class CIBumpDistortionLinear: ImageFilter {
    init() {
        super.init(name: "CIBumpDistortionLinear")
    }
    public func inputAngle(_ inputAngle: Double) -> CIBumpDistortionLinear {
        filter.setValue(inputAngle, forKey:"inputAngle")
        return self
    }
    public func inputRadius(_ inputRadius: Double) -> CIBumpDistortionLinear {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
    public func inputScale(_ inputScale: Double) -> CIBumpDistortionLinear {
        filter.setValue(inputScale, forKey:"inputScale")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIBumpDistortionLinear {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CIBumpDistortionLinear {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
}
