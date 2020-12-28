import Foundation
import CoreImage

public class CIAreaMinimumAlpha: ImageFilter {
    public init() {
        super.init(name: "CIAreaMinimumAlpha")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIAreaMinimumAlpha {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputExtent(_ inputExtent: CIVector?) -> CIAreaMinimumAlpha {
        filter.setValue(inputExtent, forKey:"inputExtent")
        return self
    }
}
