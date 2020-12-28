import Foundation
import CoreImage

public class CIUnsharpMask: ImageFilter {
    public init() {
        super.init(name: "CIUnsharpMask")
    }
    public func inputIntensity(_ inputIntensity: Double) -> CIUnsharpMask {
        filter.setValue(inputIntensity, forKey:"inputIntensity")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIUnsharpMask {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputRadius(_ inputRadius: Double) -> CIUnsharpMask {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
}
