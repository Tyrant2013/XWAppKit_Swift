import Foundation
import CoreImage

public class CIMorphologyMinimum: ImageFilter {
    public init() {
        super.init(name: "CIMorphologyMinimum")
    }
    public func inputRadius(_ inputRadius: Double) -> CIMorphologyMinimum {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIMorphologyMinimum {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
