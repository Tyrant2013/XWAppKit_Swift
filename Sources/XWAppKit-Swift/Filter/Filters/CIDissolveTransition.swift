import Foundation
import CoreImage

public class CIDissolveTransition: ImageFilter {
    public init() {
        super.init(name: "CIDissolveTransition")
    }
    public func inputTime(_ inputTime: Double) -> CIDissolveTransition {
        filter.setValue(inputTime, forKey:"inputTime")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIDissolveTransition {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputTargetImage(_ inputTargetImage: CIImage?) -> CIDissolveTransition {
        filter.setValue(inputTargetImage, forKey:"inputTargetImage")
        return self
    }
}
