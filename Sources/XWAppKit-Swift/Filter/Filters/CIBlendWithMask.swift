import Foundation
import CoreImage

public class CIBlendWithMask: ImageFilter {
    public init() {
        super.init(name: "CIBlendWithMask")
    }
    public func inputMaskImage(_ inputMaskImage: CIImage?) -> CIBlendWithMask {
        filter.setValue(inputMaskImage, forKey:"inputMaskImage")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIBlendWithMask {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CIBlendWithMask {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
}
