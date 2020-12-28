import Foundation
import CoreImage

public class CIGaussianBlur: ImageFilter {
    public init() {
        super.init(name: "CIGaussianBlur")
    }
    public func inputRadius(_ inputRadius: Double) -> CIGaussianBlur {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIGaussianBlur {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
