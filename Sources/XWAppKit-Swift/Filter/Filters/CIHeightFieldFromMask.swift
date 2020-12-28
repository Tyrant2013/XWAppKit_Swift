import Foundation
import CoreImage

public class CIHeightFieldFromMask: ImageFilter {
    public init() {
        super.init(name: "CIHeightFieldFromMask")
    }
    public func inputRadius(_ inputRadius: Double) -> CIHeightFieldFromMask {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIHeightFieldFromMask {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
