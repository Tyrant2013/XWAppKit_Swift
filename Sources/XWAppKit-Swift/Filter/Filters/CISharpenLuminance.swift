import Foundation
import CoreImage

public class CISharpenLuminance: ImageFilter {
    public init() {
        super.init(name: "CISharpenLuminance")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CISharpenLuminance {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputRadius(_ inputRadius: Double) -> CISharpenLuminance {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
    public func inputSharpness(_ inputSharpness: Double) -> CISharpenLuminance {
        filter.setValue(inputSharpness, forKey:"inputSharpness")
        return self
    }
}
