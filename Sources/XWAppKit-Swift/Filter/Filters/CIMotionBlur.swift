import Foundation
import CoreImage

public class CIMotionBlur: ImageFilter {
    init() {
        super.init(name: "CIMotionBlur")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIMotionBlur {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputAngle(_ inputAngle: Double) -> CIMotionBlur {
        filter.setValue(inputAngle, forKey:"inputAngle")
        return self
    }
    public func inputRadius(_ inputRadius: Double) -> CIMotionBlur {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
}
