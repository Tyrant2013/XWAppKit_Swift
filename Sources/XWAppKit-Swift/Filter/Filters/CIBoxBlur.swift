import Foundation
import CoreImage

public class CIBoxBlur: ImageFilter {
    public init() {
        super.init(name: "CIBoxBlur")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIBoxBlur {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputRadius(_ inputRadius: Double) -> CIBoxBlur {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
}
