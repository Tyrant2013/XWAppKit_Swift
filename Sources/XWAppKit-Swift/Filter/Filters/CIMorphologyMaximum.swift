import Foundation
import CoreImage

public class CIMorphologyMaximum: ImageFilter {
    init() {
        super.init(name: "CIMorphologyMaximum")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIMorphologyMaximum {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputRadius(_ inputRadius: Double) -> CIMorphologyMaximum {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
}
