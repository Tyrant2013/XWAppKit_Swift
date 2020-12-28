import Foundation
import CoreImage

public class CIBlendWithRedMask: ImageFilter {
    public init() {
        super.init(name: "CIBlendWithRedMask")
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CIBlendWithRedMask {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIBlendWithRedMask {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputMaskImage(_ inputMaskImage: CIImage?) -> CIBlendWithRedMask {
        filter.setValue(inputMaskImage, forKey:"inputMaskImage")
        return self
    }
}
