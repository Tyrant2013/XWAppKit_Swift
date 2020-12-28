import Foundation
import CoreImage

public class CIDiscBlur: ImageFilter {
    public init() {
        super.init(name: "CIDiscBlur")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIDiscBlur {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputRadius(_ inputRadius: Double) -> CIDiscBlur {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
}
