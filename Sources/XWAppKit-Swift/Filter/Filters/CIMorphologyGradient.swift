import Foundation
import CoreImage

public class CIMorphologyGradient: ImageFilter {
    public init() {
        super.init(name: "CIMorphologyGradient")
    }
    public func inputRadius(_ inputRadius: Double) -> CIMorphologyGradient {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIMorphologyGradient {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
