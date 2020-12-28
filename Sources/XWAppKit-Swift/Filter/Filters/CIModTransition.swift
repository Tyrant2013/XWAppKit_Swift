import Foundation
import CoreImage

public class CIModTransition: ImageFilter {
    init() {
        super.init(name: "CIModTransition")
    }
    public func inputTargetImage(_ inputTargetImage: CIImage?) -> CIModTransition {
        filter.setValue(inputTargetImage, forKey:"inputTargetImage")
        return self
    }
    public func inputTime(_ inputTime: Double) -> CIModTransition {
        filter.setValue(inputTime, forKey:"inputTime")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CIModTransition {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIModTransition {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputCompression(_ inputCompression: Double) -> CIModTransition {
        filter.setValue(inputCompression, forKey:"inputCompression")
        return self
    }
    public func inputAngle(_ inputAngle: Double) -> CIModTransition {
        filter.setValue(inputAngle, forKey:"inputAngle")
        return self
    }
    public func inputRadius(_ inputRadius: Double) -> CIModTransition {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
}
