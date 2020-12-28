import Foundation
import CoreImage

public class CIAreaMaximumAlpha: ImageFilter {
    init() {
        super.init(name: "CIAreaMaximumAlpha")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIAreaMaximumAlpha {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputExtent(_ inputExtent: CIVector?) -> CIAreaMaximumAlpha {
        filter.setValue(inputExtent, forKey:"inputExtent")
        return self
    }
}
